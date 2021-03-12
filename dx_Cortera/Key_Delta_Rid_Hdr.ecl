import $, doxie, data_services;

inFile := $.Layouts.Layout_Delta_Rid;

EXPORT Key_Delta_Rid_Hdr := INDEX({inFile.record_sid}, {inFile}, $.Keynames().Hdr_Delta_Rid.QA);