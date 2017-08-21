import doxie;
deaths := pull(Doxie.key_death_masterV2_DID);

x:= sort(misc._pl_derogatories_details2(has_death or has_crim or has_sor),did,source_st,license_number,date_first_seen,local);

x_active:= x(
(expiration_date='' or (expiration_date<>'' and expiration_date>='20091030')) and
trim(status)  in [
'ACTIVE',                                 
'ACTIVE (EMERITUS)',                            
'ACTIVE - RESTRICTED',                          
'ACTIVE - WITH CONDITIONS',                     
'ACTIVE IN RENEWAL',                   
'ACTIVE LICENSE',                           
'ACTIVE NOT EXPIRED',                           
'ACTIVE PHYSICIAN',                             
'ACTIVE TO INACTIVE',                           
'ACTIVE WITH RESTRICTIONS',                     
'ACTIVE-NON RENEWABLE',                         
'CLEAR ACTIVE',                                 
'CURRENT',                                      
'CURRENT - UNRESTRICTED',                       
'CURRENT ACTIVE',                               
'CURRENT LICENSE',                              
'CURRENT LICENSE - ON PROBATION DUE TO DISCIPL',
'CURRENT LICENSE - STATEMENT OF CHARGES ISSUED',
'CURRENT LICENSE; STATEMENT OF CHARGES ISSUED', 
'CURRENT, UNRESTRICTED LICENSE',                
'VALID UNTIL 01/31/2010',                       
'VALID UNTIL 01/31/2011',                                             
'VALID UNTIL 03/28/2010',                         
'VALID UNTIL 03/31/2010',                       
'VALID UNTIL 04/30/2010',                       
'VALID UNTIL 04/30/2011',                       
'VALID UNTIL 05/31/2010',                                          
'VALID UNTIL 07/31/2010',                                          
'VALID UNTIL 08/31/2010',                       
'VALID UNTIL 10/31/2010',                       
'VALID UNTIL 12/31/2010'		
]);

layout_pretty := record
	string12	did;
 	string9		best_ssn;
	string    name;
	string8   dob;
	string100	company_name;
	string 		address;
	string 		city_st_zip;
//
	string8		date_first_seen;
	string8   date_last_seen;
//
	string2   source_st;
	string60  profession_or_board;
	string60  license_type;
	// string50	category1;
	// string50	category2;
	string20  license_number;
	//
  string45  status;
	string10 	status_status_cds;
  string8 	status_effective_dt;
  string8 	status_renewal_desc;
  string20 	status_other_agency;
	string8   issue_date;
	string8   expiration_date;
	string8   last_renewal_date;
//
  string1 	dead;
	string8   dod8:='';
	string1 	crim;
	string1 	sor;
//
	string		offender_keys;
  string 		seisint_primary_keys;
	string 		offenses;
end;
layout_pretty to_pretty(x l,deaths r) := transform
self.Crim := if(l.has_crim,'Y','');
self.SOR 	:= if(l.has_sor,'Y','');
self.dead := if(l.has_death,'Y','');
self.Name :=  	
				trim(l.fname)+' '+ 
				trim(l.mname)+' '+
				trim(l.lname)+' '+
				trim(l.name_suffix);
self.Address := 
				trim(l.prim_range)+' '+
				trim(l.predir)+' '+
				trim(l.prim_name)+' '+
				trim(l.suffix)+' '+
				trim(l.postdir)+' '+
				trim(l.unit_desig)+' '+
				trim(l.sec_range);

self.City_ST_Zip := 
				trim(l.p_city_name)+' '+
				trim(l.st)+' '+
				trim(l.zip);
self.dod8 := r.dod8;
self := l;
end;
x_pretty := join(distribute(x,hash(did)),distribute(deaths,hash(did)),left.did=right.did, to_pretty(left,right),local);

x_last_license := dedup(sort(x,did,source_st,license_number,date_first_seen,local),did,source_st,license_number,local);
x_active_last_license := x_last_license(
	(expiration_date='' or (expiration_date<>'' and expiration_date>='20091030')) and
	trim(status)  in [
	'ACTIVE',                                 
	'ACTIVE (EMERITUS)',                            
	'ACTIVE - RESTRICTED',                          
	'ACTIVE - WITH CONDITIONS',                     
	'ACTIVE IN RENEWAL',                   
	'ACTIVE LICENSE',                           
	'ACTIVE NOT EXPIRED',                           
	'ACTIVE PHYSICIAN',                             
	'ACTIVE TO INACTIVE',                           
	'ACTIVE WITH RESTRICTIONS',                     
	'ACTIVE-NON RENEWABLE',                         
	'CLEAR ACTIVE',                                 
	'CURRENT',                                      
	'CURRENT - UNRESTRICTED',                       
	'CURRENT ACTIVE',                               
	'CURRENT LICENSE',                              
	'CURRENT LICENSE - ON PROBATION DUE TO DISCIPL',
	'CURRENT LICENSE - STATEMENT OF CHARGES ISSUED',
	'CURRENT LICENSE; STATEMENT OF CHARGES ISSUED', 
	'CURRENT, UNRESTRICTED LICENSE',                
	'VALID UNTIL 01/31/2010',                       
	'VALID UNTIL 01/31/2011',                                             
	'VALID UNTIL 03/28/2010',                         
	'VALID UNTIL 03/31/2010',                       
	'VALID UNTIL 04/30/2010',                       
	'VALID UNTIL 04/30/2011',                       
	'VALID UNTIL 05/31/2010',                                          
	'VALID UNTIL 07/31/2010',                                          
	'VALID UNTIL 08/31/2010',                       
	'VALID UNTIL 10/31/2010',                       
	'VALID UNTIL 12/31/2010'		
	]);
x_active_dids := dedup(sort(x_active_last_license,did,local),did,local);
layout_pretty to_keep_active(x_pretty l, x_active_dids r) := transform
	self := l;
	end;
x_pretty_active := join(x_pretty, x_active_dids, left.did=right.did, to_keep_active(left,right),local);

export _pl_derogatories_final := x_pretty_active;
