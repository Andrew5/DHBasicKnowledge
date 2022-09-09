//
//  listmerge.h
//  DHBasicKnowledge
//
//  Created by jabraknight on 2022/5/17.
//

#ifndef listmerge_h
#define listmerge_h

#include <stdio.h>
#include <stdlib.h>

typedef struct ListNode{

    struct ListNode *next;
    int data;
}ListNode;

//初始化
void Init(ListNode *pp)
{
    pp= NULL;
    //memset(pp, 0, sizeof(pp));
}
//将两个有序链表合并为一个有序链表。
ListNode*Merge(ListNode*list1, ListNode*list2)////合并两个有序链表成一个有序链表
{
    ListNode*p1 = list1;
    ListNode*p2 = list2;
    ListNode*pp = list1;
    if (p1->data < p2->data)////确定好合并后的头结点
    {
        pp = p1; p1 = p1->next;
    }
    else
    {
        pp = p2; p2 = p2->next;
    }
    ListNode*result = pp;////定义一个移动指针,将两个链表连接在一起
    while (p1 != NULL && p2 != NULL)
    {
        if (p1->data < p2->data)
        {
            pp->next = p1; p1 = p1->next; pp = pp->next;
        }
        else
        {
            pp->next = p2; p2 = p2->next; pp = pp->next;
        }
    }
    while (p1 != NULL)//// 补齐p1剩余未比较的节点
    {
        pp->next = p1; p1 = p1->next; pp = pp->next;
    }
    while (p2 != NULL)//// 补齐p2剩余未比较的节点
    {
        pp->next = p2; p2 = p2->next; pp = pp->next;
    }
    return result;
}

//申请新空间
ListNode* Creat(int data)
{
    ListNode*pnew = (ListNode*)malloc(sizeof(ListNode));
    pnew->data = data;
    pnew->next = NULL;
    printf("链表建立成功！\n");
    return pnew;
    
}

//手动创建链表
void lianbiao(ListNode**n11,ListNode**m11)
{
    *n11 = Creat(1);
    ListNode*n12= Creat(4);
    ListNode*n13= Creat(6);
    ListNode*n14 = Creat(7);
    ListNode*n15= Creat(8);
    (*n11)->next = n12;
    n12->next = n13; n13->next = n14; n14->next = n15;

    *m11 = Creat(0);
    ListNode*m12 = Creat(1);
    ListNode*m13 = Creat(3);
    ListNode*m14 = Creat(4);
    ListNode*m15 = Creat(7);
    ListNode*m16 = Creat(9);
    ListNode*m17 = Creat(11);
    (*m11)->next = m12; m12->next = m13; m13->next = m14;
    m14->next = m15; m15->next = m16; m16->next = m17;

}

#endif /* listmerge_h */
