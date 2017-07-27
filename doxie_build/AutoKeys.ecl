export AutoKeys (proj, infiletype, ssn_key, phone_key, addr_key, stfl_key, city_key) :=

MACRO

ssn_key := INDEX(DEDUP(proj(ssn != ''),ssn,id,all),{ssn},{id},'~thor_data400::key::auto'+infiletype+'_ssn_QA');

phone_key := INDEX(DEDUP(proj(phone10 != '' OR id=''),phone10,id,all),{string7 p7 := phone10[4..10],
								string3 p3 := phone10[1..3]},{id},'~thor_data400::key::auto'+infiletype+'_phone_QA');

addr_key := INDEX(dedup(proj(prim_name != ''),prim_name,prim_range,state,city_code,zip,sec_range,lname,fname,all),
							  {prim_name,
							   prim_range,
							   state,
							   city_code,
							   zip, 
							   sec_range,
							   dph_lname,
							   lname,
							   pfname,
							   fname},{id}, '~thor_data400::key::auto'+infiletype+'_addr_QA');

stfl_key := INDEX(DEDUP(proj(dph_lname != ''),dph_lname,lname,pfname,fname,minit,s4,zip,dob,all),
								{state,
								 dph_lname,
								 lname,
								 pfname,
								 fname,
								 minit
								 ,yob
								 ,s4
								 ,zip,
								 dob
								 },{id},'~thor_data400::key::auto'+infiletype+'_stfl_QA');
  
city_key := INDEX(DEDUP(proj(city_code <> 0),city_code,state,lname,fname,yob,all),
							  {city_code,
								state,
								dph_lname,
								lname,
								pfname,
								fname
								,yob
								},{id},'~thor_data400::key::auto'+infiletype+'_city_QA');
								
ENDMACRO;