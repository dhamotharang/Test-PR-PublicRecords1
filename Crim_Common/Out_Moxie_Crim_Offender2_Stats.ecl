dMoxieFile := Crim_Common.File_Moxie_Crim_Offender2_Dev;

rstatRecord
 :=
  record
	dMoxieFile.Vendor;
	dMoxieFile.Source_File;
	Total 		:= count(group);
	Has_DID 	:= AVE(group,IF(dMoxieFile.did<>'',100,0));
	Has_PGID 	:= AVE(group,IF(dMoxieFile.pgid<>'',100,0));
	Has_orig_SSN:= AVE(group,IF(dMoxieFile.orig_ssn<>'',100,0));
	Has_SSN 	:= AVE(group,IF(dMoxieFile.ssn<>'',100,0));
	Has_DOB 	:= AVE(group,IF(dMoxieFile.dob<>'',100,0));
	Has_Street 	:= AVE(group,IF(dMoxieFile.prim_name<>'',100,0));
	Has_Zip5 	:= AVE(group,IF(dMoxieFile.zip5<>'',100,0));
	Has_Nitro 	:= AVE(group,IF(dMoxieFile.nitro_flag<>'',100,0));
	Has_DLE_Num := AVE(group,IF(dMoxieFile.dle_num<>'',100,0));
	Has_FBI_Num := AVE(group,IF(dMoxieFile.fbi_num<>'',100,0));
	Has_DOC_Num := AVE(group,IF(dMoxieFile.doc_num<>'',100,0));
	Has_ID_Num  := AVE(group,IF(dMoxieFile.id_num<>'',100,0));
	Has_INS_Num := AVE(group,IF(dMoxieFile.ins_num<>'',100,0));
  end
 ;

dStatsTable 	:= table(dMoxieFile,rStatRecord,Vendor,Source_File,few);
dStatsSorted	:= sort(dStatsTable,Vendor);

export Out_Moxie_Crim_Offender2_Stats := output(dStatsSorted,all,named('Statistics'));