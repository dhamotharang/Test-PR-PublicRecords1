
import mi8;
import crim_cp_ln;

////////check to see is state cd, county cd and distrct id all null, if all null then amrk error 'State, County and District UID'								
									
mi8.Layout_LN_Cross_Prom_Sources tr_check_prom_source_state_county_and_dist_uid(mi8.File_LN_Cross_prom_sources L) := TRANSFORM
SELF.Remarks := Map(L.STAT_STATE_CD +L.CNTY_COUNTY_CD + L.DINA_DINA_ID = '' => ' State, County and District UID, ',l.Remarks);
SELF := L;
END;


ds_check_prom_source_state_county_and_dist_uid := PROJECT(mi8.File_LN_Cross_prom_sources,tr_check_prom_source_state_county_and_dist_uid(LEFT));

//output(ds_check_prom_source_state_county_and_dist_uid);

//////////////// Get found and not found couny desc 

Join_prom_sources_and_counties := join(ds_check_prom_source_state_county_and_dist_uid, mi8.File_LN_Cross_Counties,
                                                                  left.CNTY_COUNTY_CD = right.COUNTY_CD ,LEFT OUTER);
																																	
//output(Join_prom_sources_and_counties);			


////////////////// If couny desc is null then mark error 'County Name' and assign null dina id = 638


Layout_check_prom_source_county_name
  :=
	record
 mi8.Layout_LN_Cross_Prom_Sources;
 mi8.Layout_LN_Cross_Counties
end;


Layout_check_prom_source_county_name tr_check_prom_source_county_name(Join_prom_sources_and_counties L) := TRANSFORM
SELF.Remarks := Map(l.COUNTY_NAME = '' => trim(l.Remarks) + ' County Name, ',l.Remarks);
SELF.dina_dina_id := Map(l.dina_dina_id = '' => '638',l.dina_dina_id);
SELF := L;
END;


ds_prom_source_county_name := PROJECT(Join_prom_sources_and_counties,tr_check_prom_source_county_name(LEFT));

//output(ds_prom_source_county_name(source_uid = '340393'));
																														



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
																																	
//output(Join_source_cross_ref_and_ds_prom_source_county_name);	


export File_references_tables := Join_source_cross_ref_and_ds_prom_source_county_name
                                                    : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::File_references_tables');									 
																										