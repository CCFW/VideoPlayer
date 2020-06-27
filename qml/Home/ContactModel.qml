import QtQuick 2.0

ListModel {

    property real firstValue: 2
    id: leftGrid

    // 1. Initialize the list model:
    property bool completed: false
    Component.onCompleted: {
        append({"number": introduceSql.getIntroduce(), value: leftGrid.firstValue});
        completed = true;
    }

    // 2. Update the list model:
    onFirstValueChanged: {
        if(completed) setProperty(0, "value", leftGrid.firstValue);
    }
}
