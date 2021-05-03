import $, doxie, data_services;

inFile := $.Layouts.Layout_Delta_Rid;

EXPORT Key_Delta_Rid := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Delta_Rid.QA);