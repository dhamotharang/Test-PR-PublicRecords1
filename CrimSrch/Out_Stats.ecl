dOffender_Distributed := File_Moxie_Offender_Dev;

rOffenderStatRecord
 :=
  record
	dOffender_Distributed.Vendor;
	dOffender_Distributed.Source_File;
	Total 			:= count(group);
	Has_DID 		:= AVE(group,IF(dOffender_Distributed.did<>'',100,0));
	Has_SSN 		:= AVE(group,IF(dOffender_Distributed.ssn<>'',100,0));
	Has_DOB 		:= AVE(group,IF(dOffender_Distributed.dob<>'',100,0));
	Has_Street 		:= AVE(group,IF(dOffender_Distributed.prim_name<>'',100,0));
	Has_Zip5 		:= AVE(group,IF(dOffender_Distributed.zip5<>'',100,0));
	Has_Convicted_Y	:= AVE(group,IF(dOffender_Distributed.fcra_conviction_flag='Y',100,0));
	Has_Convicted_N	:= AVE(group,IF(dOffender_Distributed.fcra_conviction_flag='N',100,0));
	Has_Convicted_U	:= AVE(group,IF(dOffender_Distributed.fcra_conviction_flag='U',100,0));
	Has_Traffic_Y 	:= AVE(group,IF(dOffender_Distributed.fcra_traffic_flag='Y',100,0));
	Has_Traffic_N 	:= AVE(group,IF(dOffender_Distributed.fcra_traffic_flag='N',100,0));
	Has_Traffic_M 	:= AVE(group,IF(dOffender_Distributed.fcra_traffic_flag='M',100,0));
	Has_Traffic_U 	:= AVE(group,IF(dOffender_Distributed.fcra_traffic_flag='U',100,0));
	Has_ConvOverDt	:= AVE(group,IF(dOffender_Distributed.conviction_override_date<>'',100,0));
	Has_ConvOverDtGd:= AVE(group,IF((integer4)dOffender_Distributed.conviction_override_date + 70000 >= (integer4)Version.Development,100,0));
  end
 ;

tOffenderStatsTable	:= table(dOffender_Distributed,rOffenderStatRecord,Vendor,Source_File,few);
tOffenderStatsSorted:= sort(tOffenderStatsTable,vendor);

A01 := output(tOffenderStatsSorted,all,named('Offender_Statistics'));

dOffenses_Distributed := File_Moxie_Offenses_Dev;

rOffensesStatRecord
 :=
  record
	dOffenses_Distributed.Vendor;
	dOffenses_Distributed.Source_File;
	Total 			:= count(group);
	Has_Convicted_Y	:= AVE(group,IF(dOffenses_Distributed.fcra_conviction_flag='Y',100,0));
	Has_Convicted_N	:= AVE(group,IF(dOffenses_Distributed.fcra_conviction_flag='N',100,0));
	Has_Convicted_U	:= AVE(group,IF(dOffenses_Distributed.fcra_conviction_flag='U',100,0));
	Has_Traffic_Y 	:= AVE(group,IF(dOffenses_Distributed.fcra_traffic_flag='Y',100,0));
	Has_Traffic_N 	:= AVE(group,IF(dOffenses_Distributed.fcra_traffic_flag='N',100,0));
	Has_Traffic_M 	:= AVE(group,IF(dOffenses_Distributed.fcra_traffic_flag='M',100,0));
	Has_Traffic_U 	:= AVE(group,IF(dOffenses_Distributed.fcra_traffic_flag='U',100,0));
	Has_ConvOverDt	:= AVE(group,IF(dOffenses_Distributed.conviction_override_date<>'',100,0));
	Has_ConvOverDtGd:= AVE(group,IF((integer4)dOffenses_Distributed.conviction_override_date + 70000 >= (integer4)Version.Development,100,0));
  end
 ;

tOffensesStatsTable := table(dOffenses_Distributed,rOffensesStatRecord,Vendor,Source_File,few);
tOffensesStatsSorted:= sort(tOffensesStatsTable,vendor);

A02 := output(tOffensesStatsSorted,all,named('Offenses_Statistics'));

dPunishment_Distributed := File_Moxie_Punishment_Dev;

rPunishmentStatRecord
 :=
  record
	dPunishment_Distributed.Vendor;
	dPunishment_Distributed.Source_File;
	Total 			:= count(group);
	Has_ConvOverDt	:= AVE(group,IF(dPunishment_Distributed.conviction_override_date<>'',100,0));
	Has_ConvOverDtGd:= AVE(group,IF((integer4)dPunishment_Distributed.conviction_override_date + 70000 >= (integer4)Version.Development,100,0));
  end
 ;

tPunishmentStatsTable := table(dPunishment_Distributed,rPunishmentStatRecord,Vendor,Source_File,few);
tPunishmentStatsSorted:= sort(tPunishmentStatsTable,vendor);

A03 := output(tPunishmentStatsSorted,all,named('Punishment_Statistics'));

export Out_Stats := parallel(A01,A02,A03);