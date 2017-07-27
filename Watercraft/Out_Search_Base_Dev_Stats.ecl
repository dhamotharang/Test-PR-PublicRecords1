dMoxieFile := Watercraft.File_Base_Search_Dev;

rPersonStatRecord
 :=
  record
	dMoxieFile.source_code;
	dMoxieFile.state_origin;
	Total 		:= count(group);
	Has_DID 	:= AVE(group,IF((unsigned8)dMoxieFile.did<>0,100,0));
	Has_orig_SSN:= AVE(group,IF((unsigned8)dMoxieFile.orig_ssn<>0,100,0));
	Has_SSN 	:= AVE(group,IF((unsigned8)dMoxieFile.ssn<>0,100,0));
	Has_DOB 	:= AVE(group,IF(dMoxieFile.dob<>'',100,0));
	Has_Street 	:= AVE(group,IF(dMoxieFile.prim_name<>'',100,0));
	Has_Zip5 	:= AVE(group,IF(dMoxieFile.zip5<>'',100,0));
  end
 ;

dPersonStatsTable 	:= table(dMoxieFile(Company_Name=''),rPersonStatRecord,Source_Code,State_Origin,few);
dPersonStatsSorted	:= sort(dPersonStatsTable,Source_Code,State_Origin);

oPersonStats		:= output(dPersonStatsSorted,all,named('Person_Statistics'));

rCompanyStatRecord
 :=
  record
	dMoxieFile.source_code;
	dMoxieFile.state_origin;
	Total 			:= count(group);
	Has_BDID 		:= AVE(group,IF((unsigned8)dMoxieFile.bdid<>0,100,0));
	Has_orig_FEIN	:= AVE(group,IF((unsigned8)dMoxieFile.orig_fein<>0,100,0));
	Has_FEIN 		:= AVE(group,IF((unsigned8)dMoxieFile.FEIN<>0,100,0));
	Has_Street 		:= AVE(group,IF(dMoxieFile.prim_name<>'',100,0));
	Has_Zip5 		:= AVE(group,IF(dMoxieFile.zip5<>'',100,0));
  end
 ;

dCompanyStatsTable 	:= table(dMoxieFile(Company_Name<>''),rCompanyStatRecord,Source_Code,State_Origin,few);
dCompanyStatsSorted	:= sort(dCompanyStatsTable,Source_Code,State_Origin);

oCompanyStats		:= output(dCompanyStatsSorted,all,named('Company_Statistics'));

export Out_Search_Base_Dev_Stats
 :=
  parallel
	(
		oPersonStats,
		oCompanyStats
	)
 ;