#workunit('name','Header_sources');
import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP;

import header,doxie, header_quick;
lay := RECORD
  unsigned6 s_did;
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  unsigned8 persistent_record_id;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
 END;

cert_QH_key_DID := header_quick.FN_key_DID(dataset([], header.Layout_Header), 
									// '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::headerquick::fcra::20171126::did');		//run on dataland, need forigen call
									'~foreign::' + '10.173.44.105' + '::'+'thor_data400::key::headerquick::20180318::did');		//run on dataland, need forigen call
Prod_QH_key_DID := header_quick.FN_key_DID(dataset([], header.Layout_Header), 
									// '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::headerquick::fcra::20171119::did');		//run on dataland, need forigen call
									'~foreign::' + '10.173.44.105' + '::'+'thor_data400::key::headerquick::20180311::did');		//run on dataland, need forigen call
										
// cert_header := (dataset([], lay),	'~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::header::20171025::data');	
// Prod_header := (dataset([], lay),	'~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::header::20170925a::data');	
in_header := dataset([], lay);
	// logfile := '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::fcra::header::20171025::data';
	logfile := '~foreign::' + '10.173.44.105' + '::'+'thor_data400::key::header::20180221::data';
	cert_header := index(in_header, {s_did}, lay - s_did, logfile);	

// cert_header := pull(cert_header_FCRA(src='EQ' and dt_last_seen = 201710));
	
		// logfile2 := '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::fcra::header::20170925a::data';
		logfile2 := '~foreign::' + '10.173.44.105' + '::'+'thor_data400::key::header::20180130::data';
	Prod_header := index(in_header, {s_did}, lay - s_did, logfile2);

// Prod_header := pull(Prod_header2(src='EQ' and dt_last_seen = 201710));


// output(choosen(cert_QH_key_DID, 25));
// output(choosen(cert_header, 25));

// results_cert_header_FCRA := cert_header_FCRA( src = 'EQ' and dt_last_seen = 201710);

// Output(choosen(cert_header, 25));
// output(count(cert_header));

// results_Prod_header := Prod_header( src = 'EQ' and dt_last_seen = 201709);
// Output(choosen(Prod_header, 25));
// output(count(Prod_header));

ds_cert_QH_key_DID := cert_QH_key_DID  ;
ds_cert_header := cert_header  ;
ds2_Prod_QH_key_DID :=  Prod_QH_key_DID ;
ds2_Prod_header :=  Prod_header ;

dis_cert_QH := distribute(cert_QH_key_DID, did);
dis_cert_header:= distribute(ds_cert_header, did);
dis2_prod_QH := distribute(Prod_QH_key_DID, did);
dis2_Prod_header := distribute(ds2_Prod_header, did);

tbl_src_cert_QH := table(dis_cert_QH, {mysrc	 := 	src	; _count := count(group)}, src, local);
src_table_cert_QH 	:= table(tbl_src_cert_QH, {mysrc; rec_count := sum(group, _count)}, mysrc); 

output(src_table_cert_QH , named('cert_QH'));

tbl_src_prod2_QH  := table(dis2_prod_QH, {mysrc2	 := 	src	; _count2 := count(group)}, src, local);
src_table_prod2_QH 	:= table(tbl_src_prod2_QH, {mysrc2; rec_count2 := sum(group, _count2)}, mysrc2); 

output(src_table_prod2_QH, named('Prod_QH'));

//////////////////////////////////////////////////
tbl_src_cert_header := table(dis_cert_header, {mysrc	 := 	src	; _count := count(group)}, src, local);
src_table_cert_header  	:= table(tbl_src_cert_header, {mysrc; rec_count := sum(group, _count)}, mysrc); 

output(choosen(src_table_cert_header, all),named('Cert_Header'));

// tbl_src_prod2_header  := table(dis2_Prod_header, {mysrc2	 := 	src	; _count2 := count(group)}, src, local);
// src_table_prod2_header 	:= table(tbl_src_prod2_header, {mysrc2; rec_count2 := sum(group, _count2)}, mysrc2); 

// output(src_table_prod2_header, named('Prod_Header'));