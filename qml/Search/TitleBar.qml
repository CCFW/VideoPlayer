import QtQuick 2.0
import QtQuick.Controls 2.5

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
            TextInput{
                clip: true
                width: parent.width
                autoScroll:true
                color: "gray"
                anchors.verticalCenter: parent.verticalCenter
                text: "传闻中的陈千千"; renderType: TextInput.NativeRendering; font.hintingPreference: Font.PreferVerticalHinting
            }
        }
        Rectangle{
            anchors.right: parent.right
            width: parent.width/4
            height: parent.height
            color: "green"
            radius:14;
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
