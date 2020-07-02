import QtQuick 2.0
import QtQuick.Controls 2.5
import Felgo 3.0

Rectangle{
    id:titlebar
    width: parent.width
    height: 70
    color: "whitesmoke"
    Rectangle {
        id: searchBkgnd;

        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter: parent.verticalCenter
        width: 300
        height: parent.height-20
        radius: 14;
        //        color: Qt.rgba(213/255, 217/255, 227/255, 1.0);
        color: "white"
        border.color: "green"
        Rectangle{
            id:searchInput
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width/4*3
            height: parent.height-2
            TextField{
                id:searchlater
                clip: true
                width: parent.width
                height: parent.height+2
                background: transparent
                autoScroll:true
                color: "gray"
                anchors.verticalCenter: parent.verticalCenter
                renderType: TextInput.NativeRendering; font.hintingPreference: Font.PreferVerticalHinting
                onAccepted: {
                    searchInputText.text=searchInputText.text
                }
            }
        }
        Rectangle{
            anchors.right: parent.right
            width: parent.width/4
            height: parent.height
            color: "green"
            radius:14;
            MouseArea{
                id:sea
                anchors.fill: parent
                onClicked: {

                    //输入关键字为空的情况
                    if(searchlater.text==""){

                        searchhomepage.searchDialog.searchDiaolognull.open()
                    }else if(dataManage.setKey(searchlater.text)==0){//不为空，搜索匹配

                        //在这个页面一开始就把之前搜索的清空
                        var count=searchhomepage.listmodes.count
                        for(var i=count-1; i>=0;i--){
                            searchhomepage.listmodes.remove(i)
                        }
                        //追加
                        for(var i=0; i<dataManage.getName().length;i++){
                            searchhomepage.listmodes.append({"title":dataManage.getName()[i],"director":dataManage.getDirector()[i],"introduce": dataManage.getIntroduce()[i],"role":dataManage.getRole()[i],"episodes":dataManage.getEpisodes()[i],"portrait":dataManage.getmoveImage()[i],"time":dataManage.getTime()[i],"source":dataManage.getSource()[i]})

                        }
                        //清空已有的listElement里面的东西
                        //                        searchhomepage.listmodes.remove(0)
                        searchlater.text=""
                        dataManage.clearVector()
                    }else if(dataManage.setKey(searchlater.text)==-1){//不为空但是输入的关键字不匹配的情况
                        searchhomepage.searchDialog.searchDiaologno.open()
                    }


                }

            }
            Image {
                id: searchImg
                source: "../../assets/search.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left;
                width: 25;
                height: 25;
            }
            Text {
                id: searchtext
                anchors.left: searchImg.right
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("搜索")
                font.pointSize: 15;
            }
        }
    }

}
