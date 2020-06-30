#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <mysql/mysql.h>

#define BUF_SIZE 1024
void error_handling(char *message);
int connectSql(char *message);
void saveMessage(char *message);


int main(int argc,char *argv[]){
    int serv_sock;
    int clnt_sock;
    int str_len,i;
    char message[BUF_SIZE];
    //char *ip = "127.168.43.104";

    struct sockaddr_in serv_adr;
    struct sockaddr_in clnt_adr;
    socklen_t clnt_adr_sz;

//    int c = connectSql();
////    printf("%s\n");
//    printf("%d\n",c);

    if(argc != 2 ){
        printf("Usage :%s <port>\n",argv[0]);
        exit(1);
    }

    serv_sock=socket(PF_INET,SOCK_STREAM,0);
    if(serv_sock==-1)
        error_handling("socket() error");

    memset(&serv_adr,0,sizeof(serv_adr));
    serv_adr.sin_family=AF_INET;
    //serv_adr.sin_addr.s_addr=inet_addr(ip);
    serv_adr.sin_addr.s_addr=htonl(INADDR_ANY);
    serv_adr.sin_port=htons(atoi(argv[1]));
    printf("--------------\n");

    if(bind(serv_sock,(struct sockaddr*)&serv_adr,sizeof(serv_adr))==-1)
        error_handling("bind() error");

    if(listen(serv_sock,5)==-1)
        error_handling("listen() error");

    clnt_adr_sz=sizeof (clnt_adr);
    for(i=0;i<5;i++){
        clnt_sock = accept(serv_sock,(struct sockaddr*)&clnt_adr,&clnt_adr_sz);
        if(clnt_sock==-1)
            error_handling("accept() error");
        else
            printf("Connected client %d\n",i+1);

        while((str_len=read(clnt_sock,message,BUF_SIZE))!=0){
            write(clnt_sock,message,str_len);
            printf("Message from client:%s",message);
            int c = connectSql(message);
        //    printf("%s\n");
//            printf("%d\n",c);

        }



        close(clnt_sock);
    }
    close(serv_sock);
    return 0;
}

void error_handling(char *message){
    fputs(message,stderr);
//    fputc('\n',stderr);
    exit(1);
}

//int connectSql(char *message){
//    MYSQL *conn_prt;
//    int res;
//    conn_prt = mysql_init(NULL);
//    if(!conn_prt){
//        printf("failed\n");
//        return -1;
//    }
//    if(!mysql_real_connect(conn_prt,"localhost","root","root","test",0,NULL,0)){
//        printf("failed to connect mysql:%s\n",mysql_error(conn_prt));
//    }
//    else {
//        printf("success\n");
//    }
//    mysql_close(conn_prt);
//    return 0;
//}

int connectSql(char *message){
    MYSQL my_connection;

    int res;
    static int i = 2;

    mysql_init(&my_connection);

      /*mysql_real_connect(&mysql,主机名,用户名,密码,数据库名,0,NULL,0) == NULL)*/
      /*mysql_real_connect(&mysql,host,user,passwd,dbname,0,NULL,0) == NULL)*/

    if (mysql_real_connect(&my_connection, "localhost", "root", "root","test",0,NULL,CLIENT_FOUND_ROWS))
    {
//        printf("Connection success\n");
        char sql_insert[200];
        sprintf(sql_insert,"insert into ts(ve_id,ve_title) values('%d','%s');",i,message);
        res = mysql_query(&my_connection,sql_insert);
//        res = mysql_query(&my_connection, "insert into ts(ve_id,ve_title) values('3','888888')");

//        if (!res)
//        {
//            printf("Inserted %lu rows\n",(unsigned long)mysql_affected_rows(&my_connection));
//        /*里头的函数返回受表中影响的行数*/
//        }
//        else
//        {
//        //分别打印出错误代码及详细信息
//            fprintf(stderr, "Insert error %d: %s\n",mysql_errno(&my_connection),mysql_error(&my_connection));
//         }
          mysql_close(&my_connection);
     }

      else
      {
          fprintf(stderr, "Connection failed\n");

          if (mysql_errno(&my_connection))
          {
            fprintf(stderr, "Connection error %d: %s\n",mysql_errno(&my_connection),mysql_error(&my_connection));
          }
      }
   return 1;// "EXIT_SUCCES";
}

