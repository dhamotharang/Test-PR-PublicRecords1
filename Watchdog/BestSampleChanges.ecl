import Data_Services;
cur_best := watchdog.File_Best;
prev_best := dataset(Data_Services.Data_location.prefix('Watchdog_Best')+'thor_data400::base::watchdog_best_father', recordof(cur_best), thor);

new_recs := join(distribute(cur_best, hash(did)),
								 distribute(prev_best, hash(did)),
								 left.did = right.did,
								 left only,
								 local);

sample_new := choosen(ENTH(distribute(new_recs, random()),1, 1000,1), 2000); 
change_ly := record
recordof(cur_best) cur_watchdog;
recordof(prev_best) prev_watchdog;
end;

changed_recs := join(distribute(cur_best, hash(did)),
								 distribute(prev_best, hash(did)),
								 left.did = right.did and
								 left.phone + ' ' +  
								 left.ssn  + ' ' +  
								 left.dob  + ' ' +  
								 left.title  + ' ' +  
								 left.fname  + ' ' +  
								 left.mname  + ' ' +  
								 left.lname + ' ' +  
								 left.name_suffix  + ' ' +  
								 left.prim_range  + ' ' +  
								 left.predir + ' ' +  
								 left.prim_name  + ' ' +  
								 left.suffix  + ' ' +  
								 left.postdir  + ' ' +  
								 left.unit_desig  + ' ' +  
								 left.sec_range  + ' ' +  
								 left.city_name  + ' ' +  
								 left.st   + ' ' +  
								 left.zip  + ' ' +  
								 left.zip4  + ' ' +  
								 left.DOD  + ' ' +  
								 left.Prpty_deed_id  + ' ' +  
								 left.Vehicle_vehnum  + ' ' +  
								 left.Bkrupt_CrtCode_CaseNo  + ' ' +  
								 left.DL_number 
								 <>
								 right.phone + ' ' +  
								 right.ssn  + ' ' +  
								 right.dob  + ' ' +  
								 right.title  + ' ' +  
								 right.fname  + ' ' +  
								 right.mname  + ' ' +  
								 right.lname + ' ' +  
								 right.name_suffix  + ' ' +  
								 right.prim_range  + ' ' +  
								 right.predir + ' ' +  
								 right.prim_name  + ' ' +  
								 right.suffix  + ' ' +  
								 right.postdir + ' ' +  
								 right.unit_desig   + ' ' +  
								 right.sec_range  + ' ' +  
								 right.city_name  + ' ' +  
								 right.st + ' ' +  
								 right.zip  + ' ' +  
								 right.zip4  + ' ' +  
								 right.DOD  + ' ' +  
								 right.Prpty_deed_id  + ' ' +  
								 right.Vehicle_vehnum  + ' ' +  
								 right.Bkrupt_CrtCode_CaseNo  + ' ' +  
								 right.DL_number,
								 transform(change_ly, self.cur_watchdog := left, self.prev_watchdog := right),
								 local);
								 
sample_changes :=  choosen(ENTH(distribute(changed_recs, random()),1, 1000,1), 2000); 

export BestSampleChanges := sequential(output(sample_new, named('NewRecordsSample'),all),
																				 output(sample_changes, named('ChangedRecordsSample'), all)) ;
