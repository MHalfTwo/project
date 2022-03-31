#include <stdio.h>
#include "time.h"
#include "stdlib.h"


/*
 * 试编写一程序给小朋友做测试。要求：依次出10道题，每次随机产生2个10以内的整数，随机选择+、-、×三种运算，
 * 在屏幕上显示算式“*+*=”（*为刚才随机产生的加数，+为运算），如果是减法运算，要求大数在前，小数在后，即大数-小数。
 * 在算式后面小朋友从键盘输入答案。程序对小朋友输入的答案做判断，如果正确加10分，
 * 如果错误，提示错误并再显示刚才的题目重新做答，
 * 每道题最多有3次机会，第二次答对得5分，第三次答对得2分，三次没有答对不得分，进入下一题。
 * 十题全部完成后显示总得分。综合运用循环、选择（if\switch)结构解决问题！
 */

struct problem{
    int x;
    int y;
    int z;
    int ans;
    char cal;
};

void calculate(struct problem *x){
    switch (x->z) {
        case 0: x->cal='+';
        x->ans=x->x+x->y;
        break;
        case 1:x->cal='-';
        int p;
        x->x>x->y ? :(p=x->x,x->x=x->y,x->y=p);
        x->ans=x->x-x->y;
        break;
        case 2:x->cal='*';
        x->ans=x->x*x->y;
        break;
    }
}

int main(void ){
    srand(time(NULL));
    int score=0;
    struct problem problems[10];
    for (int i = 0; i < 10; ++i) {
        problems[i].x=rand()%11;
        problems[i].y=rand()%11;
        problems[i].z=rand()%3;
        calculate(&problems[i]);
    }
    for (int i = 0; i < 10; ++i) {
        printf("%d %c %d = ?\n",problems[i].x,problems[i].cal,problems[i].y);
        int p=1;int num=0;
        while (p){
            int solve;
            if (num<3){
                scanf("%d",&solve);
                if (solve==problems[i].ans){
                    p=0;
                }
                if ((solve!=problems[i].ans) && (num==2)){
                    num=4;
                    goto FLAG;
                }
                num++;
                if (num>3){
                    goto FLAG;
                }}
        }
        FLAG:
            switch (num) {
                case 1:score+=10;break;
                case 2:score+=5;break;
                case 3:score+=2;break;
                case 4:
                    printf("你这题做错了！！！You are wrong!!!\n");
            }

    }
    printf("您的分数为%d",score);
    return 0;
}