import STRATA;

export out_strata_population(string filedate) := function

rPopulationStats_CompID
 :=
record
compID.file_compid_best.st;
CountGroup                                       := count(group); 
did_CountNonZero                       :=    sum(group,if(compID.file_compid_best.did       <> 0,1,0));            
phone_CountNonBlank                    :=    sum(group,if(compID.file_compid_best.phone     <>'',1,0));            
ssn_CountNonBlank                      :=    sum(group,if(compID.file_compid_best.ssn        <>'',1,0));           
dob_CountNonZero                       :=    sum(group,if(compID.file_compid_best.dob        <> 0,1,0));           
title_CountNonBlank                    :=    sum(group,if(compID.file_compid_best.title      <>'',1,0));           
fname_CountNonBlank                    :=    sum(group,if(compID.file_compid_best.fname     <>'',1,0));            
mname_CountNonBlank                    :=    sum(group,if(compID.file_compid_best.mname     <>'',1,0));            
lname_CountNonBlank                    :=    sum(group,if(compID.file_compid_best.lname     <>'',1,0));            
name_suffix_CountNonBlank              :=    sum(group,if(compID.file_compid_best.name_suffix<>'',1,0));           
prim_range_CountNonBlank               :=    sum(group,if(compID.file_compid_best.prim_range<>'',1,0));            
predir_CountNonBlank                   :=    sum(group,if(compID.file_compid_best.predir      <>'',1,0));          
prim_name_CountNonBlank                :=    sum(group,if(compID.file_compid_best.prim_name <>'',1,0));            
suffix_CountNonBlank                   :=    sum(group,if(compID.file_compid_best.suffix     <>'',1,0));           
postdir_CountNonBlank                  :=    sum(group,if(compID.file_compid_best.postdir    <>'',1,0));           
unit_desig_CountNonBlank               :=    sum(group,if(compID.file_compid_best.unit_desig<>'',1,0));            
sec_range_CountNonBlank                :=    sum(group,if(compID.file_compid_best.sec_range  <>'',1,0));           
city_name_CountNonBlank                :=    sum(group,if(compID.file_compid_best.city_name <>'',1,0));            
zip_CountNonBlank                     :=    sum(group,if(compID.file_compid_best.zip        <>'',1,0));           
zip4_CountNonBlank                     :=    sum(group,if(compID.file_compid_best.zip4       <>'',1,0));           
addr_dt_last_seen_CountNonZero         :=    sum(group,if(compID.file_compid_best.addr_dt_last_seen<> 0,1,0));     
dod_CountNonBlank                      :=    sum(group,if(compID.file_compid_best.dod        <>'',1,0));           
prpty_deed_id_CountNonBlank            :=    sum(group,if(compID.file_compid_best.prpty_deed_id <>'',1,0));        
vehicle_veh_num_CountNonBlank          :=    sum(group,if(compID.file_compid_best.vehicle_vehnum<>'',1,0));        
bkrupt_crtcode_caseno_CountNonBlank    :=    sum(group,if(compID.file_compid_best.bkrupt_crtcode_caseno<>'',1,0)); 
main_count_CountNonZero                :=    sum(group,if(compID.file_compid_best.main_count <> 0,1,0));           
search_count_CountNonZero              :=    sum(group,if(compID.file_compid_best.search_count<> 0,1,0));          
dl_number_CountNonBlank                :=    sum(group,if(compID.file_compid_best.dl_number <>'',1,0));            
bdid_CountNonBlank                     :=    sum(group,if(compID.file_compid_best.bdid      <>'',1,0));            
run_date_CountNonZero                  :=    sum(group,if(compID.file_compid_best.run_date   <> 0,1,0));           
total_records_CountNonZero             :=    sum(group,if(compID.file_compid_best.total_records<> 0,1,0));         
rawaid_CountNonZero                    :=    sum(group,if(compID.file_compid_best.rawaid    <> 0,1,0));            
addr_dt_first_seen_CountNonZero        :=    sum(group,if(compID.file_compid_best.addr_dt_first_seen<> 0,1,0));    
adl_ind_CountNonBlank                  :=    sum(group,if(compID.file_compid_best.adl_ind    <>'',1,0));           
valid_ssn_CountNonBlank                :=    sum(group,if(compID.file_compid_best.valid_ssn  <>'',1,0));           

end;

  
dPopulationStats_CompID := sort(table(compID.file_compid_best,rPopulationStats_CompID,st,few),st);

STRATA.createXMLStats(dPopulationStats_CompID,
                      'CompID',
					            'base',
					            filedate,
					            'skasavajjala@seisint.com',
					            compidresults
					           );
return compidresults;
end;