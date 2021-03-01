IMPORT $, doxie, data_services;

// ---------------------------------------------------------------
// For delta rollup logic use: $.Key_Delta_Rid_Hdr
// ---------------------------------------------------------------

inFile := $.Layouts.Layout_Header_Out; 

EXPORT Key_Header_Link_Id := INDEX ({inFile.link_id}, {inFile}, $.Keynames().Hdr_Link_Id.QA);
