import strata, ut;

export strata(string filedate) := function

d :=FLAccidents_Ecrash.BaseFile;
rPopulationStats_File_ECrash
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

tStats := table(d,rPopulationStats_File_ECrash,st,few);
strata.createXMLStats(tStats,'AccidentReports-ECrash','data',filedate,'skasavajjala@seisint.com',resultsOut);


return resultsOut;
end;