//
//  TopKaAgorithm.c
//  testSingature
//
//  Created by jabraknight on 2021/11/22.
//  Copyright © 2021 Jabraknight. All rights reserved.
//

#include "TopKaAgorithm.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
/*
 将这一亿个数据，按从小到大进行排序，然后取前10个。这样的话，即使使用时间复杂度为nlogn的快排或堆排，由于元素会频繁的移动，效率也不会是最高的。

 实际上我们可以维护一个大小为10的大顶堆，开始可以就将数列中的前10个数用来建堆，根元素最大。之后遍历剩余的数，分别将其与根元素进行比较，只要小于根元素，就将该数替代原来的根元素，成为新的根元素，之后adjustdown该堆，则该堆的根元素又是堆中最大的数据了。
 */
void showResult(int *arr, int len)
{
    int index;
    for(index = 0; index < len; index++)
    {
        printf("%d ",arr[index]);
    }
    printf("\n");
}

static void swap(int *left, int *right)
{
    int tmp = *left;
    *left = *right;
    *right = tmp;
}

void adjustdown(int *arr, int i, int end)
{
    int key = arr[i];
    int p = i;
    int left = 2 * p + 1;
    /* 越界就是没孩子 */    /* 只要能进循环，一定有左孩子 */
    while( left <= end )
    {
        /* 有右孩子的情况下，大于等于左右孩子不用换 */
        if( (key >= arr[left]) && (left+1 <= end && key >= arr[left+1]))
        {
            break;
        }else if( key >= arr[left] && left + 1 > end) /* 没有右孩子，只有左孩子，且大于等于左孩子不用换*/
        {
            break;
        }else if(left + 1 <= end && arr[left+1] >= arr[left] && key < arr[left+1]) /* 与右孩子换。要保证有右孩子，且右孩子大于等于左孩子，父亲小于右孩子 */
        {
            swap(arr+p, arr+left+1);
            p = left + 1;    //父亲与谁换，就到谁的位置了
            left = 2 * p + 1;//父亲新的左孩子的位置
        }else if(left + 1 <= end && arr[left] > arr[left + 1] && key < arr[left])/* 与左孩子换。有右孩子的情况下，右孩子小于左孩子，父亲小于左孩子 */
        {
            swap(arr + p, arr + left);
            p = left;
            left = 2 * p + 1;
        }else if(left + 1 > end && arr[left] > key) /* 与左孩子换。没右孩子的情况下，只需父亲小于左孩子 */
        {
            swap(arr + p, arr + left);
            p = left;
            left = 2 * p + 1;
        }
    }
}


void heap_sort(int *arr, int len)
{
    int p;   // 最后一个父亲
    int end; // 最后一个有效下标
    /* 建一个大顶堆，从最后一个父亲开始调 */
    for(p = (len -1 -1) /2 ; p >= 0; p--)
    {
        adjustdown(arr, p ,len - 1);
    }
    /* 根结点的值最大，与末尾交换，并继续建立堆结构，再交换... */
    for(end = len - 1; end >= 1; end--)
    {
        swap(arr, arr + end );   // end已经是最大值
        adjustdown(arr,0,end-1); // 从arr+1 到 end-1位置都是满足堆结构的
    }
}

void my_top(int *arr, int len, int top, int *arr_top, int top_len) //此处选最小的top个数，维护大堆。如果是最大top个数，就维护小堆。
{
    /* 开始用插入排序 */ /* 不用插入排序，对arr_top直接建堆也是可以的 */
    int index;
    int pos;
    for(index = 0; index < len; index ++)
    {
        if(index < top)
        {
            if(index == 0)
            {
                arr_top[index] = arr[index];
            }else
            {
                /* 插入排序 */
                //int pos; 从大到小
                for(pos = index - 1; pos >= 0; pos--)
                {
                    if(arr[index] >= arr_top[pos])
                    {
                        arr_top[pos + 1] = arr_top[pos];
                    }else
                    {
                        break;
                    }
                }
                arr_top[pos+1] = arr[index];
            }
        }else
        {
            if(arr[index] >= arr_top[0]) //比最大值还大，说明不是最小的10个数
            {
                continue;
            }else
            {
                arr_top[0] = arr[index];       //淘汰掉原来最大的
                adjustdown(arr_top,0,top_len-1); //重新选最大值  复杂度nlogn 但是这10个数并不是有序的
            }
        }
    }
}
