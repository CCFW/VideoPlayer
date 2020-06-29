import QtQuick 2.0
import QtQuick.Controls 2.5
import "../Search"
import Felgo 3.0


Rectangle {
    id:main
    visible: true
    width: 1080
    height: 960
    property alias searchInputText: searchInputText.text


    SwipeView{
        id:swipeView
        anchors.fill: parent
        currentIndex: indicator.currentIndex
        width: 1000
        height: 300

        Item{
            Image {
                id:img1
                width: parent.width
                height: 300
                source: "../../assets/5.jpg"
                anchors.fill: img1
            }
        }
        Item{
            Image {
                id:img2
                width: parent.width
                height: 300
                source: "../../assets/5.jpg"
                anchors.fill: img2
            }
        }
        Item{
            Image {
                id:img3
                width: parent.width
                height: 300
                source: "../../assets/5.jpg"
                anchors.fill: img3
            }
        }
        Item{
            Image {
                id:img4
                width: parent.width
                height: 300
                source: "../../assets/5.jpg"
                anchors.fill: img4
            }
        }
    }

    //tubiao
    PageIndicator{
        id:indicator
        count:swipeView.count
        currentIndex: swipeView.currentIndex
        interactive: true
        anchors.top: swipeView.top
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Rectangle{
        id:titlebar
        width: parent.width
        height: 60
        color: "whitesmoke"
        ToolBar{
            id:toolbar
            width: parent.width
            //                anchors.bottom: main.Center
            //            anchors.bottomMargin: 10
            ToolButton{
                id:button1
                text: qsTr("shouye")
                //                onClicked:

            }
            ToolButton{
                id:button2
                anchors.left: button1.left
                anchors.leftMargin: button1.width
                text: qsTr("dianshiju")
                //                        onClicked: stack.push(tv)

            }
        }

        Rectangle{

            Image {
                id:touxiang
                source: "../../assets/touxiang.png"

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stackView.push(personalpage)
                    }
                }
            }
            anchors.fill: parent
            anchors.left: parent.left
            anchors.leftMargin: parent.width-touxiang.width
        }

        Rectangle {
            id: searchBkgnd;
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2-300
            //                anchors.horizontalCenter: parent.horizontalCenter;
            //                anchors.verticalCenter: parent.verticalCenter
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
                    id:searchInputText
                    clip: true
                    width: parent.width
                    height: parent.height+2
                    background: transparent
                    autoScroll:true
                    color: "gray"
                    anchors.verticalCenter: parent.verticalCenter
                    placeholderText: "传闻中的陈千千";
                    renderType: TextInput.NativeRendering; font.hintingPreference: Font.PreferVerticalHinting

                    onAccepted: {
                        if(searchInputText.text==""){
                            searchInputText.text=searchInputText.placeholderText
                        }else{
                            searchInputText.text=searchInputText.text
                        }
                    }
                }
            }
            Rectangle{
                id:a
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
                        if(searchInputText.text==""){
                            searchDialog.searchDiaolognull.open()
                        }else if(dataManage.setKey(searchInputText.text)==0){//不为空，搜索匹配
                            for(var i=0; i<dataManage.getName().length;i++){
                                console.log(dataManage.getName().length)
                                searchhomepage.listmodes.append({"title":dataManage.getName()[i],"director":dataManage.getDirector()[i],"introduce": dataManage.getIntroduce()[i],"role":dataManage.getRole()[i],"episodes":dataManage.getEpisodes()[i],"portrait":dataManage.getmoveImage()[i]})
                            }
                            if(searchhomepage.listmodes.get(0).title==""){
                                searchhomepage.listmodes.remove(0)
                            }

                            stackView.push(searchhomepage)
                            dataManage.clearVector()
                            searchInputText.text=""
                        }else if(dataManage.setKey(searchInputText.text)==-1){//不为空但是输入的关键字不匹配的情况
                            searchDialog.searchDiaologno.open()
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
    Text {
        id: dianshiju
        text: qsTr("dianshiju")
        anchors.top: titlebar.top
        anchors.topMargin: titlebar.height+250
    }

    Rectangle{
        id:i1
        width: 180; height: 200
        anchors.top: parent.top
        anchors.topMargin: parent.height/3+20
        ListView {
            anchors.fill: parent
            flickableDirection: Flickable.AutoFlickDirection
            model: ContactModel {}
            delegate: Column {
                Rectangle {
                    Image {
                        id: name
                        source: "../../assets/4.jpg"
                    }
                }
            }
        }
    }
    Text {
        text: qsTr("111111111111")
        anchors.left: i1.left
        anchors.top: i1.top
        anchors.topMargin: i1.height
    }

    Rectangle{
        id:i2
        width: 180; height: 200
        anchors.top: parent.top
        anchors.topMargin: parent.height/3+20
        anchors.left: parent.left
        anchors.leftMargin:parent.width-parent.width/4*3
        ListView {
            anchors.fill: parent
            flickableDirection: Flickable.AutoFlickDirection
            model: ContactModel {}
            delegate: Column {
                Rectangle {
                    Image {
                        id: name1
                        source: "../../assets/4.jpg"
                    }
                }
            }
        }
    }
    Text {
        text: qsTr("111111111111")
        anchors.top: i2.top
        anchors.left: i2.left
        anchors.topMargin: i2.height
    }

    Text {
        id: dianying
        text: qsTr("dianying")
        anchors.top: titlebar.top
        anchors.topMargin: titlebar.height+490
    }

    Rectangle{
        id:i11
        width: 180; height: 200
        anchors.top: parent.top
        anchors.topMargin: parent.height/3+260
        ListView {
            anchors.fill: parent
            flickableDirection: Flickable.AutoFlickDirection
            model: ContactModel {}
            delegate: Column {
                Rectangle {
                    Image {
                        id: name11
                        source: "../../assets/4.jpg"
                    }
                }
            }
        }
    }
    Text {
        text: qsTr("111111111111")
        anchors.left: i11.left
        anchors.top: i11.top
        anchors.topMargin: i11.height
    }

    Rectangle{
        id:i21
        width: 180; height: 200
        anchors.top: parent.top
        anchors.topMargin: parent.height/3+260
        anchors.left: parent.left
        anchors.leftMargin:parent.width-parent.width/4*3
        ListView {
            anchors.fill: parent
            flickableDirection: Flickable.AutoFlickDirection
            model: ContactModel {}
            delegate: Column {
                Rectangle {
                    Image {
                        id: name21
                        source: "../../assets/4.jpg"
                    }
                }
            }
        }
    }
    Text {
        text: qsTr("111111111111")
        anchors.top: i21.top
        anchors.left: i21.left
        anchors.topMargin: i21.height
    }
SearchDialog{
    id:searchDialog
}
}

