﻿IMPORT $, doxie, data_services;

// ---------------------------------------------------------------
// For delta rollup logic use: $.Key_Delta_Rid_Attributes
// ---------------------------------------------------------------

inFile := $.Layouts.Layout_Attributes_Out;

EXPORT Key_Attributes_Link_Id := INDEX ({inFile.ULTIMATE_LINKID}, {inFile}, $.Keynames().Attr_Link_Id.QA);
