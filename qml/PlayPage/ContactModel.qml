import QtQuick 2.0

ListModel {


    //    ListElement {
    //        portrait: "../../assets/playInterface/avatar.jpg"
    //        name: "lalala"
    //        commenttext: "如果可能，在单词边界处进行换行;否则，它将出现在该行上的适当位置，甚至在单词的中间。"
    //      }
    property real firstValue: 2

    // 1. Initialize the list model:
    property bool completed: false
    Component.onCompleted: {
        var a = danMuSql.getCommentsCount();
        console.log("aaaaaaa:  "+a);
        var i = 0;
        while(i < a){
            //评论内容初始化
            append({"portrait": danMuSql.getAvatar(),"name": danMuSql.getName(),"commenttext": danMuSql.getComments()});
            i++;
        }
        completed = true;
    }


    // 2. Update the list model:
    onFirstValueChanged: {
        if(completed) setProperty(0);

    }
}
