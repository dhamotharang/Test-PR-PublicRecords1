IMPORT doxie, data_services;

inFile := Layouts.Layout_BDID;

EXPORT Key_BDID := INDEX({inFile.bdid}, {inFile.Activity_Number}, names().bdid);
