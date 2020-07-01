import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle{
    id : textItem
    height: 30
//    visible: false
    property real endx: 1500
    property alias textstr: roottext.text
//    property alias textVisible: roottext.visible

    Text {
        id : roottext
        color: Qt.rgba(Math.random()+0.1,Math.random()+0.05,Math.random(),1)
        font.pointSize: 20
    }
    NumberAnimation on  x{
        from : endx
        to : Math.random()*20
        duration: 10000
        //这个信号在动画结束时发出。
        //动画可能已经手动停止，也可能已经运行到完成。
        //它只在顶级独立动画中触发。对于行为或转换中的动画，或者属于动画组的动画，它不会被触发。
        onStopped: textItem.destroy(1)
        //loops此属性保存动画应该播放的次数。
        //默认情况下，循环为1:动画将播放一次，然后停止。
        //如果设置为动画。无限，动画将不断重复，直到显式地停止——通过将running属性设置为false，或者调用stop()方法
//        loops: Animation.Infinite
    }

}
