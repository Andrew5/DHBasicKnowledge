//
//  Learn0518Node.c
//  DHBasicKnowledge
//
//  Created by jabraknight on 2022/5/18.
//

#include "Learn0518Node.h"
#include <stdio.h>
#include <stdlib.h>

//打印节点
void printList(struct Node* headNode) {
    struct Node* pMove = headNode->next;
    while (pMove) {
        printf("%d",pMove->data);
        pMove = pMove->next;
    }
    printf("\n节点打印完成");
}

//插入节点 参数： 插入哪一个链表 插入节点的数据是多少
void insertNodeByHead(struct Node * headNode, int data){
    //创建插入的节点
    struct Node* newNode = createNode(data);
    newNode->next = headNode->next;//新的节点指向原来表头的下一个
    headNode->next = newNode;//原来表头的下一个指向新的节点
}

//链表删除
void deleteNodeByAppoin(struct Node* headNode,int data){
    struct Node* posNode = headNode->next;//当前删除的节点=表头的下一个
    struct Node* posNodeFront = headNode;//指定位置的前面那个节点
    if (posNode == NULL) {
        printf("无法删除链表为空");
    }else{
        while (posNode -> data != data) {//当指定位置节点 不等于指定的数据 往下走
            posNodeFront = posNode;//前面的节点到达了后面的节点的位置
            posNode = posNodeFront->next;//后面节点位置到达了原来位置的下一个
            if (posNode == NULL) {
                printf("到达了表尾，未找到指定位置");
                break;
            }
        }
        //前面节点指向后面节点的next值
        posNodeFront->next=posNode->next;
        free(posNode);
    }
}
//指定位置删除

//表头法插入
//二叉树
int height(struct BinaryTreeNode* pRoot){
    if (pRoot == NULL) {
        return 0;
    }
    int leftHeight = 0;
    int rightHeight = 0;
    if (pRoot != NULL) {
        leftHeight = height(pRoot->m_pLeft);
        rightHeight = height(pRoot->m_pRight);
    }
    //取两深度的较大值
    return leftHeight>rightHeight?leftHeight:rightHeight;
//    return (leftHeight>right) ? (left+1) : (right+1);

}

