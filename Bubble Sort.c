#include "stdio.h"

int main(){
    /*冒泡排序：已知数组Target，利用冒泡排序算法输出排序后的数组
     *
     *
     */
    int Target[10]={10,9,8,7,6,5,4,3,2,1};
    for (int j = 0; j < 10; ++j) {
        for (int i = 0; i < 9-j; ++i) {
            int m;
            Target[i] <=Target[i+1] ? : (m=Target[i+1],Target[i+1]=Target[i],Target[i]=m);
        }
    }
    for (int i = 0; i < 10; ++i) {
        printf("%d\t",Target[i]);
    }
    return 0;
}