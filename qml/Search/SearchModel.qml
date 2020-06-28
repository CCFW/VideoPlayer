import QtQuick 2.0
ListModel{
    //    property var titleValue: dataManage.getName()
    //    property var directorValue: dataManage.getDirector()
    //    property var introduceValue: dataManage.getIntroduce()
    //    property var roleValue: dataManage.getRole()
    //    property var episodesValue: dataManage.getEpisodes()

    //    property int titleCount:3
    //    property int num0: 0
    //    property int num1: 0
    //    property int num2: 0
    //    property int num3: 0
    //    property int num4: 0
    //    property int num5:0

    //    id: leftGrid

    //    property bool completed: false
    //    Component.onCompleted: {
    //        while(num0<titleCount){
    //            append({"title":dataManage.getName()[num0++],"director":  dataManage.getDirector()[num1++],"introduce":leftGrid.introduceValue[num2++],"role":leftGrid.roleValue[num3++],"episodes":leftGrid.episodesValue[num4++]});
    //            console.log("cbhsdxjz")
    //            console.log("Model中leftGrid.titleValue[0]为"+dataManage.getName()[num5++] )
    ////            console
    //        }
    //        num5=0
    //        console.log("Model中leftGrid.titleValue[1]为"+leftGrid.titleValue[1] )
    //        console.log("Model中searchhomepage.flag为"+searchhomepage.flag )
    //        completed = true;
    //        num0=0
    //        num1=0
    //        num2=0
    //        num3=0
    //        num4=0
    //    }

    ListElement{title:"";director:"";introduce:"";role:"";episodes:0;portrait:""}

}

//    Component.onCompleted: {
//        console.log(searchhomepage.flag + "   hucdimqavvd")
//        if(searchhomepage.flag == 1){
//            while(num0<titleCount){
//                append({title: leftGrid.titleValue[num0++],director: leftGrid.directorValue[num1++],introduce:leftGrid.introduceValue[num2++],role:leftGrid.roleValue[num3++],episodes:leftGrid.episodesValue[num4++]});
//            }

//            console.log(dataManage.getName()[0]+"listMOdel")
//        }

//    }
//    Component.onCompleted: {
//        console.log(searchhomepage.flag + "   aaaaaaaa")
//        while(num0<titleCount){
//            append({title: leftGrid.titleValue[num0++],director: leftGrid.directorValue[num1++],introduce:leftGrid.introduceValue[num2++],role:leftGrid.roleValue[num3++],episodes:leftGrid.episodesValue[num4++]});
//        }

//        console.log(dataManage.getName()[0]+"listMOdel")

//    }
//    Rectangle{
//        Component.onCompleted: {
//            console.log("fsaaa")
//        }
//    }



//    Rectangle{
//        Component.onCompleted: {
//            console.log("bbbbb")
//        }
//    }



//    onFlagaChanged: {
//        setProperty(0,"title",leftGrid.titleValue[0])
//    }





