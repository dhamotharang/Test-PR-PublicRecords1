import Lib_StringLib;

export string fConstruct_Watercraft_Key(string pGroupKeyIn, string pHullIDIn)
 := lib_stringlib.stringlib.stringfindreplace(trim(trim(Lib_StringLib.StringLib.StringFilter(pGroupKeyIn[1..22],'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ')) + pHullIDIn),' ','_')
 ;
