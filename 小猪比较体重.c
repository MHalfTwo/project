#include <stdio.h>

int main(void){
    printf("请输入小猪的重量");
    int a,b,c;
    scanf("%d %d %d",&a,&b,&c);
    a>=b? c>=a? printf("C最大,A最小\n"): b>=c? printf("A最大，C最小\n"): printf("A最大，B最小\n") : c>=b? printf("C最大,A最小\n"): a>=c? printf("B最大，C最小\n"): printf("B最大，A最小\n");
    return 0;
}

