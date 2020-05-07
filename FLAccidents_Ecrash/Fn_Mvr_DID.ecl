import VehicleV2; 

export Fn_Mvr_DID(dataset(recordof(Layout_eCrash.Consolidation_AgencyOri)) infile) := function

// get only valid vins

main := distribute(VehicleV2.file_VehicleV2_Main(length(trim(vina_vin,left,right)) = 17 ), hash(vehicle_key)); 

// get only owner/registrants

party := distribute(VehicleV2.Files.Base.Party(orig_name_type in ['1', '4'] and fname <> '' and lname <>'' and (unsigned) append_did <>0 ), hash(vehicle_key)); 

t := {party , string25 orig_vin, string17 vina_vin , string flag := ''} ; 

//join main and party file 
j := join(party, main , left.vehicle_key = right.vehicle_key and 
                        left.iteration_key = right.iteration_key , 
												transform(t, 
												self := left, 
												self.orig_vin := right.orig_vin , 
												self.vina_vin := right.vina_vin), local); 
												
// keep latest name by date 
j_sort:= sort(distribute(j, hash(fname,lname,vina_vin)),fname,lname,vina_vin,Append_DID,-Registration_Expiration_Date,-Registration_Effective_Date,-Title_Issue_Date,local); 


// Ignore records which has same name,  vin but diff did

t t_roll(j_sort l , j_sort r) := transform 

self.flag := if(l.Append_DID <> r.Append_DID , 'F', 'T'); 

self := l ; 

end; 

roll_ := rollup(j_sort, left.fname = right.fname and 
                         left.lname = right.lname and 
												 left.vina_vin = right.vina_vin, t_roll(left,right), local):persist('~thor_data400::persist::vehicle_rollup'); 

// allow only owners and drivers. 

accidentKeybuild := distribute(infile(trim(record_type,left,right) in ['OWNER', 'DRIVER', 'PROPERTY OWNER', 'VEHICLE DRIVER' , 'VEHICLE OWNER' , 
'VEHICLE OWNER-OTHER'] ),hash(fname,lname,vin)); 


accidentNoOwners := distribute(infile(trim(record_type,left,right) not in ['OWNER', 'DRIVER', 'PROPERTY OWNER', 'VEHICLE DRIVER' , 'VEHICLE OWNER' , 
'VEHICLE OWNER-OTHER'] ),hash(fname,lname,vin)); 

//get did 

jdid:= join(roll_(flag <>'F') , accidentKeybuild, trim(left.lname,left,right) = trim(right.lname,left,right) and 
                              trim(left.fname,left,right) = trim(right.fname,left,right) and 
															trim(left.vina_vin,left,right) = trim(right.vin,left,right), 
												      transform({infile},self.did := intformat(left.append_did ,12,1), self := right), right outer, local); 

result := accidentNoOwners + jdid ; 

return result; 
end;