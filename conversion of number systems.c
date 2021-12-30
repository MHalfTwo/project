/*
 * 输入一个十进制数N，将它转换成R进制数输出。
 * 输入
 * 输入数据包含多个测试实例，每个测试实例包含两个整数N(32位整数)和R（2<=R<=16, R<>10）。
 * 输出
 * 为每个测试实例输出转换后的数，每个输出占一行。如果R大于10，则对应的数字规则参考16进制（比如，10用A表示，等等）。
 */
#include <stdio.h>
struct NR{
    int N;
    int R;
    char NR[100];
};
void input(struct NR NRS[]);
void output(struct NR NRS[]);
void tran(struct NR *NR0);
void output_NRS(char NRS[]);
int main(void){
    struct NR NRS[100];
    input(NRS);
    int i=0;
    for (; i < 100; ++i) {
        if(NRS[i].N==0){
            break;
        }
    }
    for (int j=0; j < i; ++j) {
        tran(&NRS[j]);
    }
    output(NRS);
    return 0;
}
void input(struct NR NRS[]){
    int j=0;
    while (1){
        printf("请输入第%d个要转化的数(输入0结束输入)",j+1);
        scanf("%d",&(NRS[j].N));
        if(NRS[j].N==0){
            break;
        }
        printf("请输入第%d个要转化的数要转化的目标进制",j+1);
        scanf("%d",&(NRS[j].R));
        j++;
    }
    printf("\n");
}
void output(struct NR NRS[]){
    int i=0;
    while (NRS[i].N!=0){
        printf("第%d个数\t%d对应的%d进制为\t",i+1,NRS[i].N,NRS[i].R);
        output_NRS(NRS[i].NR);
        i++;
    }
}
void tran(struct NR *NR0){
    int x=NR0->N;
    int y=NR0->R;
    for (int i = 0; i < 100; ++i) {
        NR0->NR[i]='g';
    }
    int i=0;
    while ((x!=1)&&(x!=0)){
        NR0->NR[i]=x%y;
        x=x/y;
        i++;
    }
    NR0->NR[i]=x;
}
void output_NRS(char NRS[]){
    int i=0;
    while (NRS[i]!='g'){
        i++;
    }
    if((int)NRS[i-1]!=0){
        printf("%d",NRS[i-1]);
    }
        for (int j = 2; j <= i; ++j) {
            switch (NRS[i-j]) {
                case 10:printf("A");break;
                case 11:
                    printf("B");break;
                case 12:
                    printf("C");break;
                case 13:
                    printf("D");break;
                case 14:
                    printf("E");break;
                case 15:
                    printf("F");break;
                default:printf("%d",NRS[i-j]);
            }
        }
    printf("\n");
}
