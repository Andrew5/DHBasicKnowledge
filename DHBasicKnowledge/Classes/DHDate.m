//
//  DHDate.m
//  DHBasicKnowledge_Example
//
//  Created by jabraknight on 2021/8/16.
//  Copyright © 2021 localhost3585@gmail.com. All rights reserved.
//

#import "DHDate.h"
//做App避免不了要和时间打交道，关于时间的处理，里面有不少门道，远不是一行API调用，获取当前系统时间这么简单。我们需要了解与时间相关的各种API之间的差别，再因场景而异去设计相应的机制。
//
//时间的形式
//
//在开始深入讨论之前，我们需要确信一个前提：时间是线性的。即任意一个时刻，这个地球上只有一个绝对时间值存在，只不过因为时区或者文化的差异，处于同一时空的我们对同一时间的表述或者理解不同。这个看似简单明了的道理，是我们理解各种与时间相关的复杂概念的基石。就像UTF-8和UTF-16其实都是Unicode一样，北京的20：00和东京的21：00其实是同一个绝对的时间值。
//
//GMT
//
//人类对于时间的理解还很有限，但我们至少能确定一点：时间的变化是匀速的。时间前进的速度是均匀的，不会忽快忽慢，所以为了描述时间，我们也需要找到一个值，它的变化也是以均匀的速度向前变化的。
//
//说出来你可能不信，我们人类为了寻找这个参考值，来精确描述当前的时间值，都经历了漫长岁月的探索。你可以尝试思考下，生活中有什么事物是随着时间均匀变化的，它具备的数值属性，会随着时间处于绝对的匀速变化状态。
//
//前人发现抬头看太阳是个好办法，太阳总是按规律的“早起晚落”，而且“亘古不变”，可以用太阳在一天当中所处的位置来描述当前的时间。后来不同地区的文化需要交流，你这里太阳正高空照，我这可能已经下山了，所以需要有一个公共的大家都认可的地方，以这个地方太阳的位置来做参考着，沟通起来就会方便很多。最后选择的是英国伦敦的格林尼治天文台所在地，以格林尼治的时间作为公共时间，也就是我们所说的GMT时间（Greenwich Mean Time）。
//
//UTC
//
//太阳所处的位置变化跟地球的自转相关，过去人们认为地球自转的速率是恒定的，但在1960年这一认知被推翻了，人们发现地球自转的速率正变得越来越慢，而时间前进的速率还是恒定的，所以GMT不再被认为可以用来精准的描述时间了。
//
//我们需要继续寻找一个匀速前进的值。抬头看天是我们从宏观方向去寻找答案，科技的发展让我们在微观方面取得了更深的认识，于是有聪明人根据微观粒子原子的物理属性，建立了原子钟，以这种原子钟来衡量时间的变化，原子钟50亿年才会误差1秒，这种精读已经远胜于GMT了。这个原子钟所反映的时间，也就是我们现在所使用的UTC（Coordinated Universal Time ）标准时间。
//
//接下来我们看下iOS里，五花八门的记录时间的方式。
//
//NSDate
//
//NSDate是我们平时使用较多的一个类，先看下它的定义：
//
//NSDate objects encapsulate a single point in time, independent of any particular calendrical system or time zone. Date objects are immutable, representing an invariant time interval relative to an absolute reference date (00:00:00 UTC on 1 January 2001).
//
//NSDate对象描述的是时间线上的一个绝对的值，和时区和文化无关，它参考的值是：以UTC为标准的，2001年一月一日00：00：00这一刻的时间绝对值。
//
//这里有个概念很重要，我们用编程语言描述时间的时候，都是以一个时间线上的绝对值为参考点，参考点再加上偏移量（以秒或者毫秒，微秒，纳秒为单位）来描述另外的时间点。
//
//理解了这一点，再看NSDate的一些API调用就非常清楚了，比如：
//
//大家在使用NSDate时有时候会发现时间有时多8小时,有时少8小时,现在对遇到的这些问题做一些剖析和记录.
//
//基础知识普及
//
//1、什么是UTC？
//UTC是世界标准时间，不属于任何时区。
//2、 什么是时间戳？
//是以 1970年1月1日 00：00：00 为参考标准，某个时间(必须是UTC时间即0时区时间)和它的差转换成秒，就是时间戳。
//3、时间戳应该是10整数，如果遇见了13位的时间戳，直接去掉前3位（因为这可能是精确到了毫秒的时间）
//获取当前的时间
//
//方式一、直接使用NSDate获取并打印
////方式一
//NSDate *date = [NSDate date];
//NSLog(@"方式一：%@",date);
//方式二、使用NSDate获取后再转换成NSString,打印NSString
////方式二
//NSDateFormatter *dateFmt = [[NSDateFormatter alloc]init];
//dateFmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//NSString *dateStr1 = [dateFmt stringFromDate:date];
//NSLog(@"方式二: %@",dateStr1);
//
//方式三、使用NSDate获取后再转换成NSString,打印NSString
////方式三
//NSDateFormatter *dateFmt2 = [[NSDateFormatter alloc]init];
//dateFmt2.dateFormat = @"yyyy年MM年dd日 HH时mm分ss秒 aa";
//NSString *dateStr2 = [dateFmt2 stringFromDate:date];
//NSLog(@"方式三: %@",dateStr2);
//打印结果：
//
//方式一：2018-04-24 05:09:19 +0000
//方式二: 2018-04-24 13:09:19
//方式三: 2018年04年24日 13时09分19秒 下午
//从上面的打印结果来看，方式一 少了8小时，为什么会这样呢？
//解释如下：
//
//1、为什么[NSDate date] 获取的时间会少8小时呢？
//因为[NSDate date] 获取到的是UTC时间，和时区无关，显示的是GMT时间 年-月-日 时：分：秒 + 时区，我们在东8区，所以会少8小时，系统是没问题的。
//2、 为什么方式二、方式三 显示没有问题。
//因为系统默认认为[NSDate date]是0时区的时间，转换成字符串应该是当前时区的，所以显示的是当前北京时间，没问题。(其实在转换格式时系统默认给我们设置了当前设备的时区(东8区)因此少的8小时又回来了)
//验证1
//
// NSDate *date = [NSDate date];
// NSLog(@"UTC date = %@", date);
//
// // 其实时间格式时,系统默认了当前设备时区
// NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
// [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
// NSString *dateStr = [formatter stringFromDate:date];
// NSLog(@"字符串时间 = %@", dateStr);
// //打印结果: 2018-07-17 11:36:55 +0800
//验证2
//
//NSDate *date = [NSDate date];
//NSLog(@"UTC date = %@", date);
//
//NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
////手动设置 打印时区  东九区时间
//formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Tokyo"];
//[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
//NSString *dateStr = [formatter stringFromDate:date];
//NSLog(@"字符串时间 = %@", dateStr);
// //打印结果: 2018-07-17 12:39:11 +0900
//结论：
//
//1、通过NSDate 类获取到的时间是 UTC格式，和时区无关，UTC 格式的时间通过NSDateFormatter转换成 GMT格式的时间字符串时，系统会自动调整，增加或减少时区差(其实就是采用当前设备默认的时区)
//// 凡是 UTC 格式时间转换成GMT时间字符串 系统会自动调整到系统对应的时区自
// NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:(8*60*60)];
//NSDateFormatter *dateFmt3 = [[NSDateFormatter alloc]init];
//dateFmt3.dateFormat = @"yyyy年MM年dd日 HH时mm分ss秒 aa";
//NSString *dateStr3 = [dateFmt3 stringFromDate:date2];
//NSLog(@"方式三:UTC: %@-- GMT: %@",date2,dateStr3);
//打印如下：
//
//方式三:UTC: 2018-04-24 14:02:07 +0000-- GMT: 2018年04年24日 22时02分07秒 下午
//可见，系统自动调整了时区
//正确的获取字符串时间的步骤
//
//1、获取零时区的时间
//2、通过给dateFormat设置任意字符串转化
//3、就可以自动变成正确的北京时间字符串！
//4、原因，系统认为NSDate是0时区的，NSString是东八区的
//
// G:     公元时代，例如AD公元
// yy:    年的后2位
// yyyy:  完整年
// MM:    月，显示为1-12
// MMM:   月，显示为英文月份简写,如 Jan
// MMMM:  月，显示为英文月份全称，如 Janualy
// dd:    日，2位数表示，如02
// d:     日，1-2位显示，如 2
// EEE:   简写星期几，如Sun
// EEEE:  全写星期几，如Sunday
// aa:    上下午，AM/PM
// H:     时，24小时制，0-23
// K：    时，12小时制，0-11
// m:     分，1-2位
// mm:    分，2位
// s:     秒，1-2位
// ss:    秒，2位
// S：    毫秒
//

@implementation DHDate

@end
