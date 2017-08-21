/*2010-12-08T21:23:21Z (skasavajjala_prod)
C:\Documents and Settings\skasavajjala\Application Data\LexisNexis\querybuilder\skasavajjala_prod\BocaProd\FLAccidents\strata_NtlCrash\2010-12-08T21_23_21Z.ecl
*/
import strata, ut;

export strata_NtlCrash(string filedate) := function

d :=FLAccidents.BaseFile_NtlAccidents_Alpharetta(st <> '');
rPopulationStats_File_NationalCrash
 :=
  record
 CountGroup									 := count(group);

 d.st;   
dt_first_seen_CountNonBlank                             := sum(group,if( d.dt_first_seen <>'',1,0));
dt_last_seen_CountNonBlank                              := sum(group,if(d.dt_last_seen <>'',1,0));
report_code_CountNonBlank                               := sum(group,if(d.report_code <>'',1,0));
report_category_CountNonBlank                           := sum(group,if( d.report_category <>'',1,0));
report_code_desc_CountNonBlank                          := sum(group,if(d.report_code_desc <>'',1,0));
vehicle_incident_id_CountNonBlank                       := sum(group,if( d.vehicle_incident_id <>'',1,0));
vehicle_status_CountNonBlank                            := sum(group,if( d.vehicle_status <>'',1,0));
did_CountNonBlank                                       := sum(group,if(d.did <> 0,1 ,0 ));
title_CountNonBlank                                     := sum(group,if( d.title <>'',1,0));
fname_CountNonBlank                                     := sum(group,if( d.fname <>'',1,0));
mname_CountNonBlank                                     := sum(group,if( d.mname <>'',1,0));
lname_CountNonBlank                                     := sum(group,if( d.lname <>'',1,0));
name_suffix_CountNonBlank                               := sum(group,if( d.name_suffix <>'',1,0));
prim_range_CountNonBlank                                := sum(group,if( d.prim_range <>'',1,0));
predir_CountNonBlank                                    := sum(group,if(d.predir <>'',1,0));
prim_name_CountNonBlank                                 := sum(group,if(d.prim_name <>'',1,0));
postdir_CountNonBlank                                   := sum(group,if( d.postdir <>'',1,0));
unit_desig_CountNonBlank                                := sum(group,if( d.unit_desig <>'',1,0));
sec_range_CountNonBlank                                 := sum(group,if( d.sec_range  <>'',1,0));
v_city_name_CountNonBlank                               := sum(group,if( d.v_city_name <>'',1,0));
st_CountNonBlank                                        := sum(group,if( d.st <>'',1,0));
zip4_CountNonBlank                                      := sum(group,if( d.zip4 <>'',1,0));
vin_CountNonBlank                                       := sum(group,if( d.vin <>'',1,0));
    
end;

tStats := table(d,rPopulationStats_File_NationalCrash,st,few);
strata.createXMLStats(tStats,'AccidentReports-NationalCrash','data',filedate,'sudhir.kasavajjala@lexisnexisrisk.com',resultsOut);

rPopulationStats_File_NationalCrash_V2
 :=
  record
 CountGroup									 := count(group);

 d.st;   
dt_first_seen_CountNonBlank                             := sum(group,if( d.dt_first_seen <>'',1,0));
dt_last_seen_CountNonBlank                              := sum(group,if(d.dt_last_seen <>'',1,0));
report_code_CountNonBlank                               := sum(group,if(d.report_code <>'',1,0));
report_category_CountNonBlank                           := sum(group,if( d.report_category <>'',1,0));
report_code_desc_CountNonBlank                          := sum(group,if(d.report_code_desc <>'',1,0));
vehicle_incident_id_CountNonBlank                       := sum(group,if( d.vehicle_incident_id <>'',1,0));
vehicle_status_CountNonBlank                            := sum(group,if( d.vehicle_status <>'',1,0));
did_CountNonBlank                                       := sum(group,if(d.did <> 0,1 ,0 ));
title_CountNonBlank                                     := sum(group,if( d.title <>'',1,0));
fname_CountNonBlank                                     := sum(group,if( d.fname <>'',1,0));
mname_CountNonBlank                                     := sum(group,if( d.mname <>'',1,0));
lname_CountNonBlank                                     := sum(group,if( d.lname <>'',1,0));
name_suffix_CountNonBlank                               := sum(group,if( d.name_suffix <>'',1,0));
prim_range_CountNonBlank                                := sum(group,if( d.prim_range <>'',1,0));
predir_CountNonBlank                                    := sum(group,if(d.predir <>'',1,0));
prim_name_CountNonBlank                                 := sum(group,if(d.prim_name <>'',1,0));
postdir_CountNonBlank                                   := sum(group,if( d.postdir <>'',1,0));
unit_desig_CountNonBlank                                := sum(group,if( d.unit_desig <>'',1,0));
sec_range_CountNonBlank                                 := sum(group,if( d.sec_range  <>'',1,0));
v_city_name_CountNonBlank                               := sum(group,if( d.v_city_name <>'',1,0));
st_CountNonBlank                                        := sum(group,if( d.st <>'',1,0));
zip4_CountNonBlank                                      := sum(group,if( d.zip4 <>'',1,0));
vin_CountNonBlank                                       := sum(group,if( d.vin <>'',1,0));
inquiry_ssn_CountNonBlank                               := sum(group,if( d.inquiry_ssn <>'',1,0));
inquiry_dob_CountNonBlank                               := sum(group,if( d.inquiry_mname <>'',1,0));
inquiry_mname_CountNonBlank                             := sum(group,if( d.inquiry_mname <>'',1,0));
inquiry_zip5_CountNonBlank                              := sum(group,if( d.inquiry_zip5 <>'',1,0));
inquiry_zip4_CountNonBlank                              := sum(group,if( d.inquiry_zip4 <>'',1,0));    
end;

tStatsV2 := table(d,rPopulationStats_File_NationalCrash_V2,st,few);
strata.createXMLStats(tStatsV2,'AccidentReports-NationalCrash-V2','data',filedate,'sudhir.kasavajjala@lexisnexisrisk.com',resultsOutnew);
return sequential(resultsOut,resultsOutnew);
end;