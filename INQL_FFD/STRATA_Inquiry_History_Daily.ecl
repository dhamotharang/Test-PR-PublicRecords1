import strata;

export STRATA_Inquiry_History_Daily(string pfiledate, boolean omit_output_to_screen = true) := function 

ds :=  INQL_FFD.Files().Base.built;

rSTRATA_Inquiry_History_Daily := record	 
    CountGroup        := count(group);
    ds.function_name;
    ds.transaction_type;
		lex_id 						:= sum(group,if(ds.lex_id <>'',1,0));
		product_id 				:= sum(group,if(ds.product_id <>'',1,0));
		inquiry_date 			:= sum(group,if(ds.inquiry_date <>'',1,0));
		transaction_id 		:= sum(group,if(ds.transaction_id <>'',1,0));
		date_added 				:= sum(group,if(ds.date_added <>'',1,0));
		customer_number 	:= sum(group,if(ds.customer_number <>'',1,0));
		customer_account 	:= sum(group,if(ds.customer_account <>'',1,0));
		ssn 							:= sum(group,if(ds.ssn <>'',1,0));
		drivers_license_number := sum(group,if(ds.drivers_license_number <>'',1,0));
		drivers_license_state 	:= sum(group,if(ds.drivers_license_state <>'',1,0));
		name_first 				:= sum(group,if(ds.name_first <>'',1,0));
		name_last 				:= sum(group,if(ds.name_last <>'',1,0));
		name_middle 			:= sum(group,if(ds.name_middle <>'',1,0));
		name_suffix 			:= sum(group,if(ds.name_suffix <>'',1,0));
		addr_street 			:= sum(group,if(ds.addr_street <>'',1,0));
		addr_city 				:= sum(group,if(ds.addr_city <>'',1,0));
		addr_state 				:= sum(group,if(ds.addr_state <>'',1,0));
		addr_zip5 				:= sum(group,if(ds.addr_zip5 <>'',1,0));
		addr_zip4 				:= sum(group,if(ds.addr_zip4 <>'',1,0));
		dob 							:= sum(group,if(ds.dob <>'',1,0));
		transaction_location 	:= sum(group,if(ds.transaction_location <>'',1,0));
		ppc 									:= sum(group,if(ds.ppc <>'',1,0));
		internal_identifier 	:= sum(group,if(ds.internal_identifier <>'',1,0));
		eu1_customer_number 	:= sum(group,if(ds.eu1_customer_number <>'',1,0));
		eu1_customer_account 	:= sum(group,if(ds.eu1_customer_account <>'',1,0));
		eu2_customer_number 	:= sum(group,if(ds.eu2_customer_number <>'',1,0));
		eu2_customer_account 	:= sum(group,if(ds.eu2_customer_account <>'',1,0));
		state_id_number 			:= sum(group,if(ds.state_id_number <>'',1,0));
		state_id_state 				:= sum(group,if(ds.state_id_state <>'',1,0));
		phone_nbr 						:= sum(group,if(ds.phone_nbr <>'',1,0));
		email_addr 						:= sum(group,if(ds.email_addr <>'',1,0));
		ip_address 						:= sum(group,if(ds.ip_address <>'',1,0));
		perm_purp_inq_type 		:= sum(group,if(ds.perm_purp_inq_type <>'',1,0));
		eu_company_name 			:= sum(group,if(ds.eu_company_name <>'',1,0));
		eu_addr_street 				:= sum(group,if(ds.eu_addr_street <>'',1,0));
		eu_addr_city 					:= sum(group,if(ds.eu_addr_city <>'',1,0));
		eu_addr_state 				:= sum(group,if(ds.eu_addr_state <>'',1,0));
		eu_addr_zip5 					:= sum(group,if(ds.eu_addr_zip5 <>'',1,0));
		eu_phone_nbr 					:= sum(group,if(ds.eu_phone_nbr <>'',1,0));
		product_code 					:= sum(group,if(ds.product_code <>'',1,0));
		// transaction_type 			:= sum(group,if(ds.transaction_type <>'',1,0));
		// function_name 				:= sum(group,if(ds.function_name <>'',1,0));
		customer_id 					:= sum(group,if(ds.customer_id <>'',1,0));
		company_id 						:= sum(group,if(ds.company_id <>'',1,0));
		global_company_id 		:= sum(group,if(ds.global_company_id <>'',1,0));
		title 								:= sum(group,if(ds.title <>'',1,0));
		fname 								:= sum(group,if(ds.fname <>'',1,0));
		mname 								:= sum(group,if(ds.mname <>'',1,0));
		lname 								:= sum(group,if(ds.lname <>'',1,0));
		name_score 						:= sum(group,if(ds.name_score <>'',1,0));
		prim_range 						:= sum(group,if(ds.prim_range <>'',1,0));
		predir 								:= sum(group,if(ds.predir <>'',1,0));
		prim_name 						:= sum(group,if(ds.prim_name <>'',1,0));
		addr_suffix 					:= sum(group,if(ds.addr_suffix <>'',1,0));
		postdir 							:= sum(group,if(ds.postdir <>'',1,0));
		unit_desig 						:= sum(group,if(ds.unit_desig <>'',1,0));
		sec_range 						:= sum(group,if(ds.sec_range <>'',1,0));
		v_city_name 					:= sum(group,if(ds.v_city_name <>'',1,0));
		st 										:= sum(group,if(ds.st <>'',1,0));
		zip5 									:= sum(group,if(ds.zip5 <>'',1,0));
		zip4 									:= sum(group,if(ds.zip4 <>'',1,0));
		addr_rec_type 				:= sum(group,if(ds.addr_rec_type <>'',1,0));
		fips_state 						:= sum(group,if(ds.fips_state <>'',1,0));
		fips_county 					:= sum(group,if(ds.fips_county <>'',1,0));
		geo_lat 							:= sum(group,if(ds.geo_lat <>'',1,0));
		geo_long 							:= sum(group,if(ds.geo_long <>'',1,0));
		cbsa 									:= sum(group,if(ds.cbsa <>'',1,0));
		geo_blk								:= sum(group,if(ds.geo_blk <>'',1,0));
		geo_match 						:= sum(group,if(ds.geo_match <>'',1,0));
		err_stat 							:= sum(group,if(ds.err_stat <>'',1,0));
		datetime 							:= sum(group,if(ds.datetime <>'',1,0));
		appended_did 					:= sum(group,if(ds.appended_did <>0,1,0));
		appended_ssn 					:= sum(group,if(ds.appended_ssn <>'',1,0));
		version 							:= sum(group,if(ds.version <>'',1,0));
		filedate 							:= sum(group,if(ds.filedate <> 0,1,0));
		
END;
 
 
tStats := table(ds,rSTRATA_Inquiry_History_Daily,function_name,transaction_type, few);

strata.createXMLStats(tStats,'Inquiry_History_Update','data',pfiledate,'',resultsOut,,,,,omit_output_to_screen);
return resultsOut;
end;






