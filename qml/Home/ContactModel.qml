

import QtQuick 2.0

ListModel {

    property real firstValue: 2
    id: leftGrid

    // 1. Initialize the list model:
    property bool completed: false
    Component.onCompleted: {
        append({"portrait":"../../assets/d1.jpg","number": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/d2.jpg","number": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/d3.jpg","number": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/d4.jpg","number": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/d5.jpg","number": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        append({"portrait":"../../assets/d6.jpg","number": introduceSql.getIntroduce(),value:leftGrid.firstValue});
        completed = true;
    }

    // 2. Update the list model:
    onFirstValueChanged: {
        if(completed) setProperty(0, "value", leftGrid.firstValue);
    }

}
