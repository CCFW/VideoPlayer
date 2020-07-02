import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle{
    Button {
        id: fileButton
        onClicked: menu.open()
        opacity: 0

        function chooseTime(min,max){
            var countnum=searchhomepage.listmodes.count
            for(var i=countnum-1; i>=0;i--){
                searchhomepage.listmodes.remove(i)
            }
            dataManage.queryInfo()
            console.log(searchhomepage.listmodes.count)
            for(var i=0; i<dataManage.getName().length;i++){
                searchhomepage.listmodes.append({"title":dataManage.getName()[i],"director":dataManage.getDirector()[i],"introduce": dataManage.getIntroduce()[i],"role":dataManage.getRole()[i],"episodes":dataManage.getEpisodes()[i],"portrait":dataManage.getmoveImage()[i],"time":dataManage.getTime()[i],"source":dataManage.getSource()[i]})
            }

            for(var i=searchhomepage.listmodes.count-1; i>=0;i--){
                if(min>searchhomepage.listmodes.get(i).time||searchhomepage.listmodes.get(i).time>max){
                    searchhomepage.listmodes.remove(i)
                }
            }
            dataManage.clearVector()

        }

        Menu {
            id: menu
            y: fileButton.height
            Action {
                text: "全部"
                onTriggered: {
                    var countnum=searchhomepage.listmodes.count
                    for(var i=countnum-1; i>=0;i--){
                        searchhomepage.listmodes.remove(i)
                    }

                    dataManage.queryInfo()

                    console.log(searchhomepage.listmodes.count)
                    for(var i=0; i<dataManage.getName().length;i++){
                        searchhomepage.listmodes.append({"title":dataManage.getName()[i],"director":dataManage.getDirector()[i],"introduce": dataManage.getIntroduce()[i],"role":dataManage.getRole()[i],"episodes":dataManage.getEpisodes()[i],"portrait":dataManage.getmoveImage()[i],"time":dataManage.getTime()[i],"source":dataManage.getSource()[i]})
                    }
                    dataManage.clearVector()
                }
            }
            Action {
                text: "0-10分钟"
                onTriggered: {
                    fileButton.chooseTime(0,10)
                }
            }
            Action {
                text: "11-30分钟"
                onTriggered: {
                    fileButton.chooseTime(11,30)
                }
            }
            Action {
                text: "31-60分钟"
                onTriggered: {
                    fileButton.chooseTime(31,60)
                }
            }
            Action {
                text: "61分钟以上"
                onTriggered: {
                    var countnum=searchhomepage.listmodes.count
                    for(var i=countnum-1; i>=0;i--){
                        searchhomepage.listmodes.remove(i)
                    }
                    dataManage.queryInfo()
                    for(var i=0; i<dataManage.getName().length;i++){
                        searchhomepage.listmodes.append({"title":dataManage.getName()[i],"director":dataManage.getDirector()[i],"introduce": dataManage.getIntroduce()[i],"role":dataManage.getRole()[i],"episodes":dataManage.getEpisodes()[i],"portrait":dataManage.getmoveImage()[i],"time":dataManage.getTime()[i],"source":dataManage.getSource()[i]})

                    }
                    for(var j=searchhomepage.listmodes.count-1; j>=0;j--){
                        if(searchhomepage.listmodes.get(j).time<61){
                            searchhomepage.listmodes.remove(j)
                        }
                    }

                    dataManage.clearVector()

                }
            }
        }
    }
}
