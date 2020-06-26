import QtQuick 2.0

Rectangle{
    //头像

    property alias searchimage: touxiang.source

    Image {
        id: touxiang
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 32
        height: 32
        source: "../../assets/touxiang.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                stackView.push(personalpage)
            }
        }
    }
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
                stackView.pop()
            }
        }
    }
}
