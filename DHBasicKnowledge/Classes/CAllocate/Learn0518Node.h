//
//  Learn0518Node.h
//  DHBasicKnowledge
//
//  Created by jabraknight on 2022/5/18.
//

#ifndef Learn0518Node_h
#define Learn0518Node_h

#include <stdio.h>
//声明节点 供外部调用

struct BinaryTreeNode
{
    int m_nValue;
    struct BinaryTreeNode* m_pLeft;
    struct BinaryTreeNode* m_pRight;
};
struct Node{
    int data;
    struct Node* next;
};
struct Node* createList()
{
    struct Node* headNode = (struct Node*)malloc(sizeof(struct Node));
    //headNode 成为了结构体变量
    //变量使用前必须初始化
    //headNode -> data = 1;
    headNode->next = NULL;
    return headNode;
}
//创建节点
struct Node* createNode(int data) {
    struct Node *newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->data = data;
    newNode->next = NULL;
    return newNode;
}

//打印节点
void printList(struct Node* headNode) ;
//插入节点
void insertNodeByHead(struct Node * headNode, int data);
//删除指定位置节点
void deleteNodeByAppoin(struct Node* headNode,int data);
//
int height(struct BinaryTreeNode* pRoot);
#endif /* Learn0518Node_h */
