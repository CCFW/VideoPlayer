import QtQuick 2.0

Rectangle{
    //头像
//    Image {
//        id: touxiang
//        anchors.right: parent.right
//        anchors.rightMargin: 20
//        anchors.top: parent.top
//        anchors.topMargin: 10
//        width: 32
//        height: 32
//        source: "../../assets/touxiang.png"
//        MouseArea{
//            anchors.fill: parent
//            onClicked: {
//                var id = sql.getid()
//                if(id == 0){
//                    personalpage.personalpageview = false
//                }
//                stackView.push(personalpage)
//            }
//        }
//    }
    //返回按钮
    Image{
        id:backbutton
        width: 30
        height: 30
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        source: "../../assets/back.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
//                dataManage.clearVector()
                stackView.pop()
                console.log(dataManage.getName().length)
                searchhomepage.listmodes.clear()
//                for(var i=0; i<dataManage.getName().length;i++){
//                    console.log(dataManage.getName().length)
//                searchhomepage.listmodes.remove(i)
//                }
            }
        }
    }
}
