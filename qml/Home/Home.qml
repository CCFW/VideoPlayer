import "../Search"
import QtQuick 2.0
import QtQuick.Controls 2.5
import Felgo 3.0

Rectangle {
    id:coverflow
    //    color:"black"
    property alias homepageimage: touxiang.source
    property alias searchInputText: searchInputText.text
    //    property alias searchModel: searchModel


    property ListModel model
    property int itemCount: 5

    PathView{
        id:pathView
        anchors.top: parent.top
        //        anchors.topMargin: -50
        model:ContactModel2{}
        delegate: Item {
            id:delegateItem
            width: 1000
            height: 300
            z:PathView.iconZ
            scale:PathView.iconScale

            Image{
                id:image
                source: portrait
                width: delegateItem.width
                height: delegateItem.height
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        stackView.push(playInterface);
                    }
                }
            }
            ShaderEffect {
                anchors.top: image.bottom
                width: image.width
                height: image.height/5
                anchors.left: image.left
                property variant source: image;
                property size sourceSize: Qt.size(0.5 / image.width, 0.5 / image.height);
                fragmentShader:
                    "varying highp vec2 qt_TexCoord0;
                        uniform lowp sampler2D source;
                        uniform lowp vec2 sourceSize;
                        uniform lowp float qt_Opacity;
                        void main() {

                            lowp vec2 tc = qt_TexCoord0 * vec2(1, -1) + vec2(0, 1);
                            lowp vec4 col = 0.25 * (texture2D(source, tc + sourceSize) + texture2D(source, tc- sourceSize)
                            + texture2D(source, tc + sourceSize * vec2(1, -1))
                            + texture2D(source, tc + sourceSize * vec2(-1, 1)));
                            gl_FragColor = col * qt_Opacity * (1.0 - qt_TexCoord0.y) * 0.2;
                        }"
            }



            transform: Rotation{
                origin.x:image.width/2.0
                origin.y:image.height/2.0
                axis{x:0;y:1;z:0}
                angle: delegateItem.PathView.iconAngle
            }
        }
        path:coverFlowPath
        pathItemCount: coverflow.itemCount
        anchors.fill: parent

        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5

    }

    Path{
        id:coverFlowPath
        startX: 0
        startY: coverflow.height/3

        PathAttribute{name:"iconZ";value: 0}
        PathAttribute{name:"iconAngle";value: 70}
        PathAttribute{name:"iconScale";value: 0.6}
        PathLine{x:coverflow.width/2;y:coverflow.height/3}

        PathAttribute{name:"iconZ";value: 100}
        PathAttribute{name:"iconAngle";value: 0}
        PathAttribute{name:"iconScale";value: 1.0}

        PathLine{x:coverflow.width;y:coverflow.height/3}
        PathAttribute{name:"iconZ";value: 0}
        PathAttribute{name:"iconAngle";value: -70}
        PathAttribute{name:"iconScale";value: 0.6}
        PathPercent{value:1.0}

    }

    Rectangle{
        id:titlebar
        width: parent.width
        height: 50
        //        anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin: 50
        color: "whitesmoke"
        ToolBar{
            id:toolbar
            width: parent.width
            ToolButton{
                id:button1
                text: qsTr("首页")

            }
            ToolButton{
                id:button2
                anchors.left: button1.left
                anchors.leftMargin: button1.width
                text: qsTr("电视剧")
                onClicked:stackView.push(playInterface)

                //                //                        onClicked: stack.push(tv)

            }
            ToolButton{
                id:button3
                anchors.left: button2.left
                anchors.leftMargin: button2.width
                text: qsTr("电影")
            }
            ToolButton{
                id:button4
                anchors.left: parent.left
                anchors.leftMargin: parent.width-touxiang.width
                Image {
                    id: touxiang
                    width: 40
                    height: 40
                    source: "../../assets/touxiang.png"
                }
                onClicked:{
                    var id = sql.getid()
                    if(id == 0){
                        personalpage.personalpageview = false
                    }
                    stackView.push(personalpage)
                }
            }
        }

        //        Rectangle{
        //            Image {
        //                width: 40
        //                height: 40
        //                id:touxiang
        //                source: "../../assets/touxiang.png"
        //            }
        //            MouseArea{
        //                anchors.fill: parent
        //                onClicked:{
        //                    var id = sql.getid()
        //                    if(id == 0){
        //                        personalpage.personalpageview = false
        //                    }
        //                    stackView.push(personalpage)
        //                }

        //            }

        //            anchors.left: parent.left
        //            anchors.leftMargin: parent.width-touxiang.width
        //        }
    }
    Rectangle {
        id: searchBkgnd;
        anchors.left: parent.left
        anchors.leftMargin: parent.width/2-300
        //                anchors.horizontalCenter: parent.horizontalCenter;
        //                anchors.verticalCenter: parent.verticalCenter
        width: 300
        height: 50
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
            //            TextInput{
            //                clip: true
            //                width: parent.width
            //                autoScroll:true
            //                color: "gray"
            //                anchors.verticalCenter: parent.verticalCenter
            //                text: "传闻中的陈千千"; renderType: TextInput.NativeRendering; font.hintingPreference: Font.PreferVerticalHinting
            //            }
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
                property bool editing: false
                                onTextEdited: editing=true;
                                onEditingFinished: editing=false;
                                onTextChanged: {
                                    myModel.sortByKey(searchInputText.text)
                                }
                            }
                        }
                        Rectangle{
                            id:historyList
                            radius: 4
                            width: 300
                            height: 300
                            visible: searchInputText.editing||searchInputText.activeFocus
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: searchInput.bottom
                            anchors.topMargin: 2
                            color: "white"

                            ListView{
                                id:listviewHistory
                                anchors.fill: parent
                                anchors.margins: 5
                                clip: true
                                spacing: 5
                                delegate: Component{
                                    Rectangle{
                                        radius: 4
                                        width: listviewHistory.width-20
                                        height: 40
                                        color: hovered?"#f4f4f4":"white"

                                        property bool hovered: false
                                        Text {
                                            id: displayText
                                            text: display
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left
                                            anchors.leftMargin: 20
                                            font.pixelSize: 12
                                            font.wordSpacing: 3
                                        }
                                        MouseArea{
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            onEntered: parent.hovered=true;
                                            onExited: parent.hovered=false;
                                            onClicked: {
                                                if(dataManage.setKey(display)==0){//不为空，搜索匹配
                                                    for(var i=0; i<dataManage.getName().length;i++){
                                                        searchhomepage.listmodes.append({"title":dataManage.getName()[i],"director":dataManage.getDirector()[i],"introduce": dataManage.getIntroduce()[i],"role":dataManage.getRole()[i],"episodes":dataManage.getEpisodes()[i],"portrait":dataManage.getmoveImage()[i],"time":dataManage.getTime()[i]})
                                                    }
                                                    if(searchhomepage.listmodes.get(0).title==""){
                                                        searchhomepage.listmodes.remove(0)
                                                    }

                                                    stackView.push(searchhomepage)
                                                    dataManage.clearVector()
                                                    searchInputText.text=""
                                                }
                                            }
                                        }
                                    }
                                }
                                model:myModel
                                ScrollBar.vertical: ScrollBar{
                                    width: 12
                                    policy: ScrollBar.AlwaysOn
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
            Image {
                id: searchImg
                source: "../../assets/search.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left;
                width: 25;
                height: 25;
            }
            MouseArea{
                id:sea
                anchors.fill: parent
                onClicked: {

                    //输入关键字为空的情况
                    if(searchInputText.text==""){
                        searchDialog.searchDiaolognull.open()
                    }else if(dataManage.setKey(searchInputText.text)==0){//不为空，搜索匹配
                        for(var i=0; i<dataManage.getName().length;i++){
                            //searchhomepage.listmodes.append({"title":dataManage.getName()[i],"director":dataManage.getDirector()[i],"introduce": dataManage.getIntroduce()[i],"role":dataManage.getRole()[i],"episodes":dataManage.getEpisodes()[i],"portrait":dataManage.getmoveImage()[i],"time":dataManage.getTime()[i],"source":dataManage.getSource()[i]})
                            //console.log(typeof(dataManage.getSource()[i]))
                            searchhomepage.listmodes.append({"title":dataManage.getName()[i],"director":dataManage.getDirector()[i],"introduce": dataManage.getIntroduce()[i],"role":dataManage.getRole()[i],"episodes":dataManage.getEpisodes()[i],"portrait":dataManage.getmoveImage()[i],"time":dataManage.getTime()[i]})

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

            Text {
                id: searchtext
                anchors.left: searchImg.right
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("搜索")
                font.pointSize: 15;
            }
        }
    }

    Rectangle{
        id:moive
        anchors.top: parent.top
        anchors.topMargin: 500
        width: parent.width
        visible: true
        //            Text {
        //                id: name
        //                text: qsTr("11111111")
        //            }
        ListModel{
            id: phoneModel1
        }
        ListModel{
            id: phoneModel
        }
        ListModel{
            id: phoneModel2
        }
        Component{
            id: sectionHeader1

            Rectangle{
                width: parent.width
                height: 66
                color: "transparent"
                Rectangle{height:27;width:4;color: "#3cecc8"}
                Text{
                    anchors.left:parent.left
                    anchors.leftMargin: 19
                    anchors.top:parent.top
                    text: section
                    font.pixelSize: 26
                    color: "black"
                    font.family: "FZLTHJW--GB1-0"   //字体
                    opacity: 0.9
                }
            }
        }
        Component{
            id:lisview_gridview1
            Rectangle{

                width: ListView.view.width
                //            height: calculate_height(fenlei_texts[index%6].length)
                height: 700
                color: "transparent"
                border.color: Qt.lighter(color, 1.1)
                GridView{
                    id:grid_view1
                    property int spacing: 40
                    //                                    model:fenlei_texts[index%6]
                    model: ContactModel1{}
                    height:parent.height
                    //                    width:1280
                    width: 2000
                    cellWidth: 300
                    cellHeight: 340
                    contentWidth: 0
                    contentHeight:0
                    interactive:false
                    delegate: Component{
                        Rectangle{
                            id:back
                            //                            color: "blue"
                            Image {
                                id: img1
                                width: parent.width
                                height: parent.height
                                source: portrait
                            }
                            width: {grid_view1.cellWidth - grid_view1.spacing}
                            height: {grid_view1.cellHeight - grid_view1.spacing}
                            Text{
                                //                                anchors.centerIn: parent
                                anchors.top: parent.bottom
                                text:name
                                font.pixelSize: 26
                                //                                color: "#ffffff"
                                color: "black"
                                font.family: "FZLTHJW--GB1-0"   //字体
                                opacity: 0.9
                            }
                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.AllButtons
                                onClicked:{
                                    grid_view1.currentIndex = index  //实现item切换
                                    console.log("*******grid_currentIndex**********"+index)
                                }
                                onPressed: {back.opacity = 0.3}
                                onReleased: {back.opacity = 1}
                            }

                        }
                    }
                    Component.onCompleted: {
                        grid_view1.currentIndex = -1;
                    }

                }
                MouseArea {
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onPressed:{
                        listview.currentIndex = index  //实现item切换
                        grid_view.currentIndex = -1
                        mouse.accepted = false
                        console.log("*******List_currentIndex**********"+index)
                    }
                }
            }

        }

        Component{
            id:lisview_gridview
            Rectangle{

                width: ListView.view.width
                //            height: calculate_height(fenlei_texts[index%6].length)
                height: 700
                color: "transparent"
                border.color: Qt.lighter(color, 1.1)
                GridView{
                    id:grid_view
                    property int spacing: 40
                    //                                    model:fenlei_texts[index%6]
                    model: ContactModel1{}
                    height:parent.height
                    //                    width:1280
                    width: 2000
                    cellWidth: 300
                    cellHeight: 340
                    contentWidth: 0
                    contentHeight:0
                    interactive:false
                    delegate: Component{
                        Rectangle{
                            id:back
                            //                            color: "blue"
                            Image {
                                id: img1
                                width: parent.width
                                height: parent.height
                                source: portrait
                            }
                            width: {grid_view.cellWidth - grid_view.spacing}
                            height: {grid_view.cellHeight - grid_view.spacing}
                            Text{
                                //                                anchors.centerIn: parent
                                anchors.top: parent.bottom
                                text:name
                                font.pixelSize: 26
                                //                                color: "#ffffff"
                                color: "black"
                                font.family: "FZLTHJW--GB1-0"   //字体
                                opacity: 0.9
                            }
                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.AllButtons
                                onClicked:{
                                    grid_view.currentIndex = index  //实现item切换
                                    console.log("*******grid_currentIndex**********"+index)
                                }
                                onPressed: {back.opacity = 0.3}
                                onReleased: {back.opacity = 1}
                            }

                        }
                    }
                    Component.onCompleted: {
                        grid_view.currentIndex = -1;
                    }

                }
                MouseArea {
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onPressed:{
                        listview1.currentIndex = index  //实现item切换
                        grid_view1.currentIndex = -1
                        mouse.accepted = false
                        console.log("*******List_currentIndex**********"+index)
                    }
                }
            }
        }

        Component{
            id:lisview_gridview2
            Rectangle{

                width: ListView.view.width
                //            height: calculate_height(fenlei_texts[index%6].length)
                height: 1200
                color: "transparent"
                border.color: Qt.lighter(color, 1.1)
                GridView{
                    id:grid_view2
                    property int spacing: 40
                    //                                    model:fenlei_texts[index%6]
                    model: ContactModel{}
                    height:parent.height
                    //                    width:1280
                    width: 2000
                    cellWidth: 300
                    cellHeight: 340
                    contentWidth: 0
                    contentHeight:0
                    interactive:false
                    delegate: Component{
                        Rectangle{
                            id:back
                            //                            color: "blue"
                            Image {
                                id: img1
                                width: parent.width
                                height: parent.height
                                source: portrait 
                            }
                            width: {grid_view2.cellWidth - grid_view2.spacing}
                            height: {grid_view2.cellHeight - grid_view2.spacing}
                            Text{
                                //                                anchors.centerIn: parent
                                anchors.top: parent.bottom
                                text:name
                                font.pixelSize: 26
                                //                                color: "#ffffff"
                                color: "black"
                                font.family: "FZLTHJW--GB1-0"   //字体
                                opacity: 0.9
                            }
                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.AllButtons
                                onClicked:{
                                    grid_view.currentIndex = index  //实现item切换
                                    console.log("*******grid_currentIndex**********"+index)
                                }
                                onPressed: {back.opacity = 0.3}
                                onReleased: {back.opacity = 1}
                            }

                        }
                    }
                    Component.onCompleted: {
                        grid_view2.currentIndex = -1;
                    }

                }
                MouseArea {
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onPressed:{
                        listview2.currentIndex = index  //实现item切换
                        grid_view2.currentIndex = -1
                        mouse.accepted = false
                        console.log("*******List_currentIndex**********"+index)
                    }
                }
            }
        }

        ScrollView{
            anchors.left: parent.left
            anchors.leftMargin: 100
            //            anchors.right: parent.right
            //            anchors.rightMargin:
            width: 1800
            height: 400
            //        }

            ListView {
                id:listview2
                //                x:60
                y:52

                width: parent.width
                //                height: 466
                height: 400
                model:phoneModel2
                delegate:lisview_gridview2
                section.property: "manufacture"
                section.criteria: ViewSection.FullString
                section.delegate: sectionHeader1
                clip: true
            }

            ListView {
                id:listview1
                //                x:60
                y:420
                width: parent.width
                //                height: 466
                height: 400
                model:phoneModel1
                delegate:lisview_gridview1
                section.property: "manufacture"
                section.criteria: ViewSection.FullString
                section.delegate: sectionHeader1
                clip: true
            }
            ListView {
                id:listview
                //                x:60
                y:850
                width: parent.width
                //                height: 466
                height: 400
                model:phoneModel
                delegate:lisview_gridview
                section.property: "manufacture"
                section.criteria: ViewSection.FullString
                section.delegate: sectionHeader1
                clip: true
            }



        }

        Component.onCompleted: {
            phoneModel.append({"manufacture":"其他"})
            phoneModel1.append({"manufacture":"电影"})
            phoneModel2.append({"manufacture":"电视剧"})
            //                    phoneModel1.append({"manufacture":"年代"})
            //                    phoneModel1.append({"manufacture":"流派"})
            //                    phoneModel1.append({"manufacture":"语种"})

        }
    }

    SearchDialog{
        id:searchDialog
    }
}






