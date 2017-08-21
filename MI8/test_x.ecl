export test := 'todo';






//output(mi8.File_LN_Cross_Source_Cross_References);
output(choosen(mi8.File_LN_Cross_prom_sources,5000));

//output(choosen(mi8.File_LN_Cross_District_Names,5000));
//output(choosen(mi8.File_LN_Cross_Counties,5000));


//output(MI8.File_LN_Cross_Extract_Driver);


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


////////check to see is state cd, county cd and distrct id all null, if all null then amrk error 'State, County and District UID'								
									
mi8.Layout_LN_Cross_Prom_Sources tr_check_prom_source_state_county_and_dist_uid(mi8.File_LN_Cross_prom_sources L) := TRANSFORM
SELF.Remarks := Map(L.STAT_STATE_CD +L.CNTY_COUNTY_CD + L.DINA_DINA_ID = '' => ' State, County and District UID, ',l.Remarks);
SELF := L;
END;


ds_check_prom_source_state_county_and_dist_uid := PROJECT(mi8.File_LN_Cross_prom_sources,tr_check_prom_source_state_county_and_dist_uid(LEFT));

output(ds_check_prom_source_state_county_and_dist_uid);

//////////////// Get found and not found couny desc 

Join_prom_sources_and_counties := join(ds_check_prom_source_state_county_and_dist_uid, mi8.File_LN_Cross_Counties,
                                                                  left.CNTY_COUNTY_CD = right.COUNTY_CD ,LEFT OUTER);
																																	
output(Join_prom_sources_and_counties);			


////////////////// If couny desc is null then mark error 'County Name' and assign null dina id = 638


Layout_check_prom_source_county_name
  :=
	record
 mi8.Layout_LN_Cross_Prom_Sources;
 mi8.Layout_LN_Cross_Counties
end;


Layout_check_prom_source_county_name tr_check_prom_source_county_name(Join_prom_sources_and_counties L) := TRANSFORM
SELF.Remarks := Map(l.COUNTY_NAME = '' => l.Remarks + ' County Name, ',l.Remarks);
SELF.dina_dina_id := Map(l.dina_dina_id = '' => '638',l.dina_dina_id);
SELF := L;
END;


ds_prom_source_county_name := PROJECT(Join_prom_sources_and_counties,tr_check_prom_source_county_name(LEFT));

output(ds_prom_source_county_name);
																														



/////////////////////// Join scr to prom sources.

Layout_source_cross_ref_and_ds_prom_source_county_name 
  :=
	record
 mi8.Layout_LN_Cross_Source_Cross_References;
 Layout_check_prom_source_county_name
end;
																							
Join_source_cross_ref_and_ds_prom_source_county_name 
                                   := join(mi8.File_LN_Cross_Source_Cross_References, ds_prom_source_county_name,
                                                                  left.PRSO_SOURCE_UID = right.SOURCE_UID);  ///// this should be equa join
																																	
output(Join_source_cross_ref_and_ds_prom_source_county_name);		


////////////////////////////////  Join MapCreateMasterKeys with Join_source_cross_ref_and_ds_prom_source_county_name

S :=  Join master key (SOURCE_UID_C = court_id 
                                 and  OLD_RECORD_SUPPLIER_CD_C = RECORD_SUPPLIER_CD) ,LEFT OUTER);
											


///Send S to transform

///process remarks above ****** remember ******

Tranform: SELF.Remarks := Map(scre_id = '' => l.Remarks + ' Source UID; ',l.Remarks);
                Self.SOURCE_UID_C = Map(scre_id <> '' and remarks = '' ,scre_id,SOURCE_UID_C);
								SELF.SOURCE_STATE_CD_C := Map(scre_id <> '' and remarks = '',stat-state_cd,SOURCE_STATE_CD_C);
                SELF.SOURCE_COUNTY_CD_C := Map(scre_id <> '' and remarks = '',county_cd,SOURCE_COUNTY_CD_C);
                SELF.SOURCE_COUNTY_NAME_C := Map(scre_id <> '' and remarks = '',county_name,SOURCE_COUNTY_NAME_C);
                SELF.DISTRICT_NAME_UID := Map(scre_id <> '' and remarks = '',dina_dina_id,DISTRICT_NAME_UID);
		
get new S		
		
	
from Builder window runable:

Process new S master where remarks is null.

Get distinct cade id from master where remarks is null.
Process case details, crim supp, where get distinct cade id.


for charges map....get source uid simmilar to masterkey map.

then Get distinct charge id from criminal charges where remarks is null.
Process criminal sentences, where get distinct charge id.

	

                     



