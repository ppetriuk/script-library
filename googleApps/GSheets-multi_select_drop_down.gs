function onEdit(e) {
var oldValue;
var newValue;
var ss=SpreadsheetApp.getActiveSpreadsheet();
var activeCell = ss.getActiveCell();
if((activeCell.getColumn() == 2 && (ss.getActiveSheet().getName()=="FY22" || ss.getActiveSheet().getName()=="FY22 Q1 Data"|| ss.getActiveSheet().getName()=="FY22 Q2 Data")) || (activeCell.getColumn() == 5 && ss.getActiveSheet().getName()=="FY22 Q3 Data")) {
newValue=e.value;
oldValue=e.oldValue;
if(!e.value) {
activeCell.setValue("");
}
else {
if (!e.oldValue) {
activeCell.setValue(newValue);
}
else {
if(oldValue.indexOf(newValue) <0) {
activeCell.setValue(oldValue+',\n'+newValue);
}
else {
activeCell.setValue(oldValue);
}
}
}
}
}
