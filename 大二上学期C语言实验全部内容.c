///*11月23日作业
// * 程序编写 陈宇翔
// * 程序目的 从键盘输入英语句子（可能包含大小写字母，数字，其它符号等），统计单词的个数
// */
//#include <stdio.h>
//int find_word(char *a);
//int main(void){
//    char sen[100];
//    printf("请输入对应的英文句子\n");
//    gets(sen);
//    int number;
//    number=find_word(sen);
//    printf("单词数量为%d",number);
//    return 0;
//}
//
//int find_word(char *a){
//    /*
//     * 函数接口：
//     * 输入：字符数组
//     * 输出：单词个数
//     * 设计思路：构建钥匙变量 key
//     * 对字符串逐行检索，当检索到字母的时候，key会处于开启状态，当检测到非字母字符时，key将处于关闭状态
//     * 也就是说，每当key由关闭变为开启，意味着检索到一个单词
//     * 故统计单词的个数可以转化为统计key由0变为1的次数
//     */
//    int number=0;
//    int key=0; //初始化key变量
//    for (int i = 0; i < 100;) {
//        while (key==1){
//            if(((char)a[i]<'A')||((char)a[i]>'Z'&&(char)a[i]<'a')||((char)a[i]>'z')){ //key关闭的条件：检测到非字母字符
//                key=0; //关闭key
//            }
//            i++;
//            if((i>100)||(char)a[i]=='\0'){
//                goto FLAG;; //跳出循环
//            }}
//        while (key==0){
//            if((((char)a[0]<='z')&&((char)a[i]>='a'))||((((char)a[0]<='Z')&&((char)a[i]>='A')))){ //key开启的条件：检测到字母字符
//                key=1; //开启key
//                number++; //统计开启次数
//            }
//            i++;
//            if((i>100)||(char)a[i]=='\0'){
//                goto FLAG; //跳出循环
//            }
//        }
//    }
//    FLAG:
//    return number;
//}




///*11月30日实验报告一
// * 程序编写 陈宇翔
// * 程序目的 计算二次方程的根
// */
//#include <stdio.h>
//#include <math.h>
//int main(void){
//    printf("请输入对应二次方程的三个系数(用逗号隔开)");
//    float a,b,c,x1,x2;
//    scanf("%f,%f,%f",&a,&b,&c);
//    float delat;
//    delat=b*b-4*a*c; //计算判别式，并着手判断
//    if(delat<0){
//        printf("方程没有实根");
//    } else{
//        if(delat==0){
//            x1=-b/2*a;
//            printf("方程的两个根均为%f",x1);
//        } else{
//            x1=((-b)+ sqrt(delat))/2*a;
//            x2=((-b)- sqrt(delat))/2*a;
//            printf("方程的一个根为%f,另一个为%f",x1,x2);
//        }
//    }
//    return 0;
//}




///*实验报告二
// * 程序目的 判断三角形的类型
// * 程序作者 陈宇翔
// */
//#include <stdio.h>
//int main(void){
//    printf("请输入三角形对应三边长度（逗号隔开）\n");
//    float a,b,c,max,min,mid;
//    scanf("%f,%f,%f",&a,&b,&c);
//    max=(a>b?(a>c?a:c):(b>c?b:c));
//    min=(a<b?(a<c?a:c):(b<c?b:c));
//    mid=(a>b?(a>c?(b>c?b:c):a):(a>c?a:(b>c?c:b)));
//    if((min+mid)<=max){
//        printf("不能构成三角形");
//    }
//    else if((min*min+mid*mid)==max*max){
//        if(min==mid){
//            printf("等腰直角三角形");
//        } else{
//            printf("一般直角三角形");
//        }
//    }
//    else if((mid==min)||(mid==max)){
//        if((mid==min)&&(max==mid)){
//            printf("等边三角形");
//        } else{
//            printf("等腰三角形，不等边");
//        }
//    }
//    else{
//        printf("一般三角形");
//    }
//    return 0;
//};




///*11月2日 实验报告三
// * 程序目的 求解百钱百鸡问题
// * “百钱百鸡”问题，公鸡5元1只，母鸡3元1只，小鸡1元3只，100元钱买100只鸡，公鸡，母鸡，小鸡各多少只？
// * 程序作者 陈宇翔
// */
//#include <stdio.h>
//int main(void){
//    for (int i = 0; i < 20; ++i) {
//        for (int j = 0; j < 33; ++j) {
//            int k=100-i-j;
//            if((k%3==0)&&((5*i+3*j+k/3)==100)){
//                printf("公鸡%d只，母鸡%d只，小鸡%d只\n",i,j,k);
//            }
//        }
//    }
//    return 0;
//}




///*实验报告四
// * 程序目的：求解点到直线的距离
// *程序作者：陈宇翔
// */
//#include <stdio.h>
//#include <math.h>
//float Distance(int x1,int y1,int x2,int y2,int x,int y);
//int main(void){
//    int x1,x2,y1,y2;
//    int x,y;
//    printf("请输入A点的坐标\n");
//    scanf("%d,%d",&x1,&y1);
//    printf("请输入B点的坐标\n");
//    scanf("%d,%d",&x2,&y2);
//    printf("请输入C点的坐标\n");
//    scanf("%d,%d",&x,&y);
//    float DIS;
//    DIS=Distance(x1,y1,x2,y2,x,y);
//    if(DIS==0){
//        printf("点在直线上");
//    }
//    else{
//        printf("点到直线的距离为%f\n", DIS);
//    }
//    return 0;
//}
//float Distance(int x1,int y1,int x2,int y2,int x,int y){
//    float Dis;
//    float k,c;
//    if(x1==x2){
//        Dis= fabs(x-x1);
//    } else{
//        k=(y1-y2)/(x1-x2);
//        c=y1-k*x1;
//        Dis=fabs(k*x-y+c)/(sqrt((k*k)+1));
//    }
//    return Dis;
//}




///*实验报告五
// * 程序目的 实现冒泡排序并输出原数组最大值的下标
// *程序作者 陈宇翔
// */
//#include <stdio.h>
//void input(int *a);
//void find_max(int *a);
//void sort(int *a);
//void output(int *a);
//int main(){
//    int Target[10];
//    input(Target);
//    find_max(Target);
//    sort(Target);
//    output(Target);
//    return 0;
//}
//
//void input(int *a){
//    printf("请输入十个数的数组\n");
//    for (int i = 0; i < 10; ++i) {
//        scanf("%d",&a[i]);
//    }
//}
//void find_max(int *a){
//
//    int max=a[0];int index=0;
//    for (int i = 1; i < 10; ++i) {
//        if(max<a[i]){
//            max=a[i];
//            index=i;
//        }
//    }
//    printf("该数组最大值为%d，其对应下标为%d\n",max,index);
//}
//void sort(int *a){
//    for(int i=0;i<10;++i){
//        for (int j = 0; j < 9-i; ++j) {
//            if(a[j]>a[j+1]){
//                int k=a[j];
//                a[j]=a[j+1];
//                a[j+1]=k;
//            }
//        }
//    }
//}
//void output(int *a){
//    for (int i = 0; i < 10; ++i) {
//        printf("%d\t",a[i]);
//    }
//    printf("\n");
//}




///*实验报告六
// * 程序目的 从键盘输入4个字符串，将这4个字符串拼接成1个字符串，并输出。
// *程序作者 陈宇翔
// */
//#include <stdio.h>
//void input(char word[]);
//void output(char word[]);
//void ADD(char word1[],char word2[],char word3[],char word4[],char word[]);
//int main(void){
//    char Word_1[100],Word_2[100],Word_3[100],Word_4[100];
//    char WORD[400];
//    printf("请输入四个字符串，每个字符串间用回车分开\n");
//    input(Word_1);input(Word_2);input(Word_3);input(Word_4);
////    output(Word_1);output(Word_2);output(Word_3);output(Word_4);
//    ADD(Word_1,Word_2,Word_3,Word_4,WORD);
//    output(WORD);
//    return 0;
//}
//void input(char word[]){
//    for (int i = 0; i < 100; ++i) {
//        scanf("%c", &word[i]);
//        if(word[i]=='\n'){
//            word[i+1]='\0';
//            goto FLAG1;
//        }
//    }
//    FLAG1:;
//}
//void output(char word[]){
//    for (int i = 0; i < 100; ++i) {
//        printf("%c",word[i]);
//        if(word[i+1]=='\0'){
//            goto FLAG2;
//        }
//    }
//    FLAG2:;
//}
//void ADD(char word1[],char word2[],char word3[],char word4[],char word[]) {
//    int Key = 0;
//    int Case = 1;
//    for (int i = 0; i < 400;) {
//        FLAG:
//        switch (Case) {
//            case 1: {
//                word[i] = word1[Key];
//                Key++;
//                i++;
//                if (word1[Key] == '\n') {
//                    Key = 0;
//                    Case = 2;
//                    goto FLAG;
//                }
//                goto FLAG;
//            };
//            case 2: {
//                word[i] = word2[Key];
//                Key++;
//                i++;
//                if (word2[Key] == '\n') {
//                    Key = 0;
//                    Case = 3;
//                    goto FLAG;
//                }
//                goto FLAG;
//            };
//            case 3: {
//                word[i] = word3[Key];
//                Key++;
//                i++;
//                if (word3[Key] == '\n') {
//                    Key = 0;
//                    Case = 4;
//                    goto FLAG;
//                }
//                goto FLAG;
//            };
//            case 4: {
//                word[i] = word4[Key];
//                Key++;
//                i++;
//                if ((word4[Key] == '\0')||(word4[Key] == '\n')) {
//                    Key = 0;
//                    Case = 5;
//                    goto FLAG;
//                }
//                goto FLAG;
//            };
//            case 5: {
//                word[i] = '\0';
//                goto END;
//            }
//        }
//    }
//    END:;
//}




///*实验报告七
// * 程序目的：判断一个AT指令的含义·
// * 定义2个函数，分别实现  提取输入AT指令的命令、节点地址、节点数据  和  字符串的比对  ，函数的形式参数为指向字符的指针。
// * Example:AT+OPEN=12345678,01\r\n
// * 程序作者：陈宇翔
// */
//#include <stdio.h>
//void input(char x[]);void output(char x[]);
//void analyse(char x[]);
//int lenn(char x[]);
//int really(char a[],char b[]);
//int main(){
//    char AT[30];
//    printf("请输入AT指令\n");
//    input(AT);
////    output(AT);
//    analyse(AT);
//    return 0;
//}
//int lenn(char x[]){
//    /*函数目的：用于求对应字符串的长度
//     * 输入：字符数组指针
//     * 返回值：字符串长度
//     */
//    int len=0;
//    for (int i = 0; i < 30; ++i) {
//        if(x[i]!='\0'){
//            len++;
//        } else break;
//    }
////    len=(len-1)/2;
//    return len;
//}
//void input(char x[]){
//    for (int i = 0; i < 30; ++i) {
//        scanf("%c",&x[i]);
//        if(x[i]=='\n'){
//            x[i+1]='\0';
//            break;
//        }
//    }
//}
//void output(char x[]){
//    for (int i = 0; i < 30; ++i) {
//        printf("%c",x[i]);
//        if(x[i+1]=='\0'){
//            break;
//        }
//    }
//    printf("\n");
//}
//int really(char a[],char b[]){
//    int x=1;
//    for (int i = 0; i < 40; ++i) {
//        if ((a[i]!='\n')&&b[i]!='\n'){
//            if(a[i]!=b[i]){
//                x=0;
//            }
//            else goto FLAG;
//        } else{
//            break;
//        }
//        FLAG:;
//    }
//    return x;
//}
//void analyse(char x[]){
//    int len,len1,len2;
//    len= lenn(x);
//    char Command[15],Target[9],result[3];
//    for (int i = 0; i < 30; ++i) {
//        if(x[i]!='='){
//            Command[i]=x[i];
//        } else{
//            Command[i]='\0';
//            break;
//        }
//    }
//    len1= lenn(Command);
//    int j=0;
//    for (int i = len1+1; i <30; ++i) {
//        if(x[i]!=','){
//            Target[j]=x[i];
//            j++;
//        } else{
//            Target[j]='\0';
//            break;
//        }
//    }
//    j=0;
//    len2= lenn(Target);
//    result[0]=x[len1+len2+2];result[1]=x[len1+len2+3];result[2]='\0';
//    if(
//            (really(Command,"AT+OPEN\n")||really(Command,"AT+LOCK\n")||really(Command,"AT+INQUIRE\n"))
//                    )
//    {
//        if(really(Target,"12345678\n")){
//            if((
//                    (result[0]=='1')&&((result[1]=='0')||(result[1]=='1')||(result[1]=='2'))||(
//                            (result[0]=='0')
//                    )
//            )){
//                printf("OK!!!");
//            } else printf("NODE DATA ERROR\n");
//        } else printf("NODE ADDRESS ERROR\n");
//
//    } else printf("COMMAND ERROR\n");
//}




/*实验报告八
 *程序目的：从键盘输入三角形的6个顶点坐标，实现三角形周长和面积的计算。
 *程序作者：陈宇翔
 */
#include <stdio.h>
#include <math.h>
struct point{
    int x;
    int y;
};
struct triangle{
    struct point O,P,Q;
    float C,S;
};
void input(struct triangle* x);
float distance(struct point a,struct point b);
void Calculate(struct triangle *x);
void find_max(struct triangle* x1,struct triangle* x2,struct triangle* x3);
int main(){
    struct triangle triangle1,triangle2,triangle3;
    printf("请输入第一个三角形的信息\n");
    input(&triangle1);
    printf("请输入第二个三角形的信息\n");
    input(&triangle2);
    printf("请输入第三个三角形的信息\n");
    input(&triangle3);
    Calculate(&triangle1);Calculate(&triangle2);Calculate(&triangle3);
    find_max(&triangle1,&triangle2,&triangle3);
    return 0;
}
void input(struct triangle* x){
    /** 重点注意！！！结构体输入的这个地方一定要记住 是传入 结构体指针！！！！！
     *
     */
    int a,b;
    printf("请输入三角形的第一个点\n");
    scanf("%d,%d",&a,&b);
    x->O.x=a;x->O.y=b;a=0,b=0;
//    x.O.x=a;x.O.y=b;a=0;b=0; //错误示范
    printf("请输入三角形的第二个点\n");
    scanf("%d,%d",&a,&b);
    x->P.x=a;x->P.y=b;a=0,b=0;
    printf("请输入三角形的第三个点\n");
    scanf("%d,%d",&a,&b);
    x->Q.x=a;x->Q.y=b;a=0,b=0;
}

float distance(struct point a,struct point b){
    /**函数输入：已知的两个点
     * 返回值：两点距离
     */
    float DIS;
    DIS=sqrt(((a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y)));
    return DIS;
}
void Calculate(struct triangle *x){
    /**函数输入 一个已知的三角形（已知三个顶点）
     *  无返回值
     *  计算三角形的面积和周长
     *  周长计算直接求出三边再求和即可
     *  面积计算此处采用 S=1/2*a*b*sinC
     *  正弦值可通过余弦定理求解余弦值后得到
     */
    float C,S;
    float l1,l2,l3;
    float cos3,sin3;
    l1= distance(x->O,x->P);
    l2= distance(x->P,x->Q);
    l3= distance(x->Q,x->O);
    C=l1+l2+l3;
    x->C=C;
    cos3=(l1*l1+l2*l2-l3*l3)/(2*l1*l2);
    sin3= sqrt(1-(cos3*cos3));
    S=0.5*l1*l2*sin3;
    x->S=S;
    printf("三角形的周长为%f\n",x->C);
    printf("三角形的面积为%f\n\n",x->S);
}
void find_max(struct triangle* x1,struct triangle* x2,struct triangle* x3){
    if(x1->S>x2->S){
        if(x1->S>x3->S){
            printf("面积最大的三角形为第一个三角形,\n其面积为%f,\n对应的三点坐标为\n(%d,%d),(%d,%d),(%d,%d)",x1->S,x1->O.x,x1->O.y,x1->P.x,x1->P.y,x1->Q.x,x1->Q.y);
        }
        else{
            printf("面积最大的三角形为第三个三角形,\n其面积为%f,\n对应的三点坐标为\n(%d,%d),(%d,%d),(%d,%d)",x3->S,x3->O.x,x3->O.y,x3->P.x,x3->P.y,x3->Q.x,x3->Q.y);
        }
    } else{
        if(x2->S>x3->S){
            printf("面积最大的三角形为第二个三角形,\n其面积为%f,\n对应的三点坐标为\n(%d,%d),(%d,%d),(%d,%d)",x2->S,x2->O.x,x2->O.y,x2->P.x,x2->P.y,x2->Q.x,x2->Q.y);
        }
        else{
            printf("面积最大的三角形为第三个三角形,\n其面积为%f,\n对应的三点坐标为\n(%d,%d),(%d,%d),(%d,%d)",x3->S,x3->O.x,x3->O.y,x3->P.x,x3->P.y,x3->Q.x,x3->Q.y);
        }
    }
}