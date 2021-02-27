import $, doxie, data_services;

inFile := $.Layouts.Layout_Delta_Rid;

EXPORT Key_Delta_Rid_Executive := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Executive_Delta_Rid.QA);