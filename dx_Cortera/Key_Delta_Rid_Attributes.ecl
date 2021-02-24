import $, doxie, data_services;

inFile := $.Layouts.Layout_Delta_Rid;

EXPORT Key_Delta_Rid_Attributes := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Attr_Delta_Rid.QA);