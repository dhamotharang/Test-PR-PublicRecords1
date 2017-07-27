Import Data_Services, doxie;


export key_mar_div_did(boolean IsFCRA = false) := function

KeyName 		 := 'thor_data400::key::mar_div::';
KeyName_fcra := 'thor_data400::key::mar_div::fcra::';

mar_div_did := marriage_divorce_v2.file_mar_div_search(did>0);

r1 := record
 mar_div_did.did;
 mar_div_did.record_id;
end;

t1 := table(mar_div_did,r1);
t1_dist := distribute(t1,hash(did,record_id));
t1_sort := sort      (t1_dist,did,record_id,local);
t1_dupd := dedup     (t1_sort,did,record_id,local);

key_name := Data_services.Data_location.Prefix('marriage') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::did';
										
return_file		:= INDEX(t1_dupd,{did},{record_id},key_name);
														
return(return_file); 

end;				   
