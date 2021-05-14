IMPORT  doxie;

EXPORT keys := MODULE

EXPORT key_linkids := INDEX(files.ds_linkid(bus_q.cname !=''), {ultid,orgid,seleid,proxid,powid,empid,dotid}, 
	 {files.ds_linkid}, 
	'~prte::key::inquiry_table::linkids_' + doxie.Version_SuperKey);
	
EXPORT key_fein := INDEX(files.ds_fein, {appended_ein}, 
	 {files.ds_fein}, 
	'~prte::key::inquiry_table::fein_' + doxie.Version_SuperKey);

EXPORT key_did := INDEX(files.ds_did, {s_did}, 
	 {files.ds_did}, 
	'~prte::key::inquiry_table::did_' + doxie.Version_SuperKey);	
	
EXPORT key_address := INDEX(files.ds_address, {zip,prim_name,prim_range,sec_range}, 
	 {files.ds_address}, 
	'~prte::key::inquiry_table::address_' + doxie.Version_SuperKey);	

EXPORT key_phone := INDEX(files.ds_phone, {phone10}, 
	 {files.ds_phone}, 
	'~prte::key::inquiry_table::phone_' + doxie.Version_SuperKey);	

EXPORT key_email := INDEX(files.ds_email, {email_address}, 
	 {files.ds_email}, 
	'~prte::key::inquiry_table::email_' + doxie.Version_SuperKey);	

EXPORT key_ssn := INDEX(files.ds_ssn, {ssn}, 
	 {files.ds_ssn}, 
	'~prte::key::inquiry_table::ssn_' + doxie.Version_SuperKey);
	
	EXPORT key_transaction_id := INDEX(files.ds_transaction_id, {transaction_id}, 
	 {files.ds_transaction_id}, 
	'~prte::key::inquiry_table::transaction_id_' + doxie.Version_SuperKey);	
	
	EXPORT key_ipaddr := INDEX(files.ds_ipaddr, {ipaddr}, 
	 {files.ds_ipaddr}, 
	'~prte::key::inquiry_table::ipaddr_' + doxie.Version_SuperKey);	
	
	EXPORT key_name := INDEX(files.ds_name, {fname, mname, lname}, 
	 {files.ds_name}, 
	'~prte::key::inquiry_table::name_' + doxie.Version_SuperKey);	

EXPORT key_bill := INDEX(files.ds_bill, {did}, 
	 {files.ds_bill}, 
	'~prte::key::inquiry_table::billgroups_did_' + doxie.Version_SuperKey);	
	
EXPORT key_fcra_address := INDEX(files.ds_fcra_address, {zip, prim_name, prim_range, sec_range}, 
	 {files.ds_fcra_address}, 
	'~prte::key::inquiry_table::fcra::address_' + doxie.Version_SuperKey);	

EXPORT key_fcra_did := INDEX(files.ds_fcra_did, {appended_adl}, 
	 {files.ds_fcra_did}, 
	'~prte::key::inquiry_table::fcra::did_' + doxie.Version_SuperKey);	

EXPORT key_fcra_ssn := INDEX(files.ds_fcra_ssn, {ssn}, 
	 {files.ds_fcra_ssn}, 
	'~prte::key::inquiry_table::fcra::ssn_' + doxie.Version_SuperKey);	

EXPORT key_fcra_phone := INDEX(files.ds_fcra_phone, {phone10}, 
	 {files.ds_fcra_phone}, 
	'~prte::key::inquiry_table::fcra::phone_' + doxie.Version_SuperKey);	
	
	EXPORT key_fcra_login := INDEX(files.ds_fcra_login, { s_company_id, s_product_id, s_gc_id}, 
	 {files.ds_fcra_login}, 
	'~prte::key::inquiry_table::fcra::industry_use_vertical_login_' + doxie.Version_SuperKey);	
	
	EXPORT key_fcra_bill := INDEX(files.ds_bill, {did}, 
	 {files.ds_bill}, 
	'~prte::key::inquiry_table::fcra_billgroups_did_' + doxie.Version_SuperKey);	
	
	EXPORT key_fcra_vertical := INDEX(files.ds_vertical, {s_company_id, s_product_id, s_gc_id}, 
	 {files.ds_vertical}, 
	'~prte::key::inquiry_table::fcra::industry_use_vertical_' + doxie.Version_SuperKey);	
	
	


END;
