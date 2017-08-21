import ut, Std;

EXPORT files := module

EXPORT CCW_hunting_fishing_IN := DATASET(constants.In_Hunters, Layouts.Hunters_Base_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT CCW_Hunting_fishing_Base := DATASET(constants.Base_Hunters, Layouts.Hunters_Base_Layout, FLAT );

EXPORT CCW_IN := DATASET(constants.In_CCW, Layouts.CCW_Base_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
EXPORT CCW_Base := DATASET(constants.Base_CCW, Layouts.CCW_Base_Layout, FLAT );

Export DS_CCW_Out:=project(CCW_Base,
Transform(Layouts.layout_ccw_out,
self.dob:=(string8)left.dob;
self.did_out:=(string12)left.did;
Self:=Left;
self := []; 
));

ut.MAC_Sequence_Records_NewRec(DS_CCW_Out,Layouts.Layout_Searchfile,rid,outCCW);
export CCW_SearchFile := outCCW; 

Export DS_Hunters_Out:=project(CCW_Hunting_fishing_Base,
Transform(Layouts.layout_hunters_out,
self.dob:=(string8)left.dob;
self.did_out:=(string12)left.did;
self.antelope := IF(STD.Str.ToUpperCase(Left.preytype)='ANTELOPE','Y','');
self.bear := IF(STD.Str.ToUpperCase(Left.preytype)='BEAR','Y','');
self.cougar := IF(STD.Str.ToUpperCase(Left.preytype)='COUGAR','Y','');
self.deer := IF(STD.Str.ToUpperCase(Left.preytype)='DEER','Y','');
self.shellfishlobster := IF(STD.Str.ToUpperCase(Left.preytype)='LOBSTER','Y','');
self.shellfishcrab := IF(STD.Str.ToUpperCase(Left.preytype)='SHELLFISHCRAB','Y','');
self.sikeBull := IF(STD.Str.ToUpperCase(Left.preytype)='SIKEBULL','Y','');
self.trout := IF(STD.Str.ToUpperCase(Left.preytype)='TROUT','Y','');
self.whitejubherring := IF(STD.Str.ToUpperCase(Left.preytype)='WHITEJUB','Y','');
Self:=Left;
self := []; 
));

ut.MAC_Sequence_Records_NewRec(DS_Hunters_Out,Layouts.Layout_Hunters_Searchfile,rid,outHunters);
export Hunters_SearchFile := outHunters; 

Export DS_CCW_did:=project(CCW_SearchFile,
Transform(Layouts.Layout_CCW_did,
self.did_out6:= (unsigned6)left.did_out;
Self:=Left;
));

Export DS_Hunters_did:=project(Hunters_SearchFile,
Transform(Layouts.Layout_Hunters_did,
self.did:= (unsigned6)left.did_out;
Self:=Left;
));

Export DS_CCW_Header:=project(CCW_SearchFile,
Transform(layouts.rHuntCCWCleanAddr_layout,
self.dob_str:=left.dob;
self.dob_str_in:=left.dob;
Self:=Left;
self := []; 
));

Export DS_Hunters_Header:=project(Hunters_SearchFile,
Transform(layouts.rHuntCCWCleanAddr_layout,
self.dob_str:=left.dob;
self.dob_str_in:=left.dob;
Self:=Left;
self := []; 
));

Export DS_header:=Project(DS_CCW_header + DS_Hunters_header,
Transform(layouts.rHuntCCWCleanAddr_layout,
self.AID_ResClean_prim_name:=left.prim_name;
self.AID_ResClean_zip4:=left.zip4;
self.AID_ResClean_predir:=left.prim_range;
Self.AID_resClean_addr_suffix:=left.suffix;
Self.AID_resClean_postdir:=left.postdir;
self.AID_resClean_unit_desig:=left.Unit_desig;
Self.AID_ResClean_sec_range:=left.sec_range;
self.AID_ResClean_v_city_name:=left.city_name;
self.AID_ResClean_st:=left.st;
Self.AID_ResClean_zip:=left.zip;
Self.AID_resClean_fipscounty:=left.county;
self.AID_resClean_geo_blk:=left.geo_blk;
self.AID_ResClean_prim_range := left.prim_range;
Self:=Left;
self := []; 
));
END;