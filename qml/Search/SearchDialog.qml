import QtQuick 2.0
import Felgo 3.0

Item {
    property alias searchDiaolognull: searchDiaolognull
    property alias searchDiaologno: searchDiaologno
    Dialog{
        id: searchDiaolognull
        title: "搜索框不能为空，请重新输入"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        onCanceled:{
            searchDiaolognull.close()
        }
        onAccepted: {
            searchDiaolognull.close()
        }
    }
    Dialog{
        id: searchDiaologno
        title: "没有搜索到您输入的视频相关信息，请重新输入"
        positiveActionLabel: "确定"
        negativeActionLabel: "取消"
        onCanceled:{
            searchDiaologno.close()
        }
        onAccepted: {
            searchDiaologno.close()
        }
    }
}
