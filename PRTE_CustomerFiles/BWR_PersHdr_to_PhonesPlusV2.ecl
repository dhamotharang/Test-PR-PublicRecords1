#workunit('name', 'PRCT-Append Header Recs To PhonesPlus CSV');
Import PRTE_CustomerFiles, PRTE_CSV, data_services, ut;

/* Run this code after the Header Build completes to find customer records in Header and map to PhonesPlus CSV file format
   Despray final CSV file and update PRCT PhonesPlus CSV file as necessary  */

//modify fields below
customer 		:= 'synchrony';
filedate 		:= '20160718';
bugnum	 		:= '17141';
hdrfiledate	:= '20160721'; //latest prct header build date

cust_layout := record
		string first_name;
		string last_name;
		string middle_name;
		string suffix_name;
		string addr;
		string filler1; //date_first_seen YYYYMMDD
		string filler2; //date_last_seen YYYYMMDD
		string city;
		string2 state;
		string5 zip5;
		string10 phone;
		string8 dob;
		string9 ssn;
 end;


//sprayed customer input file ***modify the seperator is not comma; tab: ['\t']  pipe delimitted: ['\|']  ***
cust_file := dataset(data_services.foreign_prod+'prte::in::'+customer+'_'+filedate+'_'+bugnum+'.txt', cust_layout, CSV(heading(1),separator(['\t']),terminator(['\r\n']),MAXLENGTH(10000)));
output(count(cust_file), named('CustomerFileCount'));

//check for and remove duplicate records from customer file
ddp_cust_file := dedup(sort(cust_file, record, skew(1.0), local), record, all, local);
output(count(ddp_cust_file), named('DedupedCustFileCount'));

//sort deduped customer file for join to Person Header
srt_cust_file := sort(distribute(ddp_cust_file, hash(ssn)), ssn, last_name, first_name, middle_name, dob, zip5, phone, skew(1.0), local);

//Sort Person Header Data Key for join to Deduped Customer File
Layout_hdr_data_key := RECORD
//  unsigned6 s_did;
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

prct_data_key := INDEX({unsigned6 s_did}, Layout_hdr_data_key, data_services.foreign_prod+'prte::key::header::'+hdrfiledate+'::data');
prct_hdr_key  := PROJECT(prct_data_key, Layout_hdr_data_key);
srt_hdr_recs	:= sort(distribute(prct_hdr_key, hash(ssn)), ssn, lname, fname, mname, dob, zip, phone, skew(1.0), local);

cust_hdr_layout := record 
 cust_layout;
 unsigned6 did;
 string2 src;
 unsigned3 dt_first_seen;
 unsigned3 dt_last_seen;
 unsigned3 dt_vendor_last_reported;
 unsigned3 dt_vendor_first_reported;
 unsigned3 dt_nonglb_last_seen;
 string1 rec_type;
 qstring9 hdr_ssn;
 integer4 hdr_dob;
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
 unsigned6 hhid;
 end;

//join Customer File to Person Header File
cust_hdr_layout xformClnRecs(srt_cust_file le, srt_hdr_recs ri) := transform
	self.hdr_ssn := ri.ssn;
	self.hdr_dob := ri.dob;
	self := le;
	self := ri;
 end;	

cust_hdr_recs	:= join(srt_cust_file, srt_hdr_recs, 
											(qstring9) left.ssn = right.ssn AND 
																 left.last_name = right.lname AND
																 left.first_name = right.fname AND
															   left.middle_name = right.mname AND
											(integer4) left.dob = right.dob AND
											(qstring5) left.zip5 = right.zip,
											xformClnRecs(left, right), left outer, local, skew(1.0)); 
											
output(count(cust_hdr_recs), named('CustomerHeaderRecsCount'));
output(cust_hdr_recs(did=0), all, named('CustomerHeaderRecsNoLexid'));

ddp_cust_hdr_recs := dedup(sort(distribute(cust_hdr_recs, hash(did)), 
															did, ssn, lname, fname, mname, dob, prim_range, prim_name, zip, phone, skew(1.0), local),
																did, ssn, lname, fname, mname, dob, prim_range, prim_name, zip, phone, all, local);

output(sort(ddp_cust_hdr_recs, ssn, last_name, first_name, middle_name, dob, phone),all, named('CusomerHeaderRecs'));


//Convert Customer+Header File to PRCT PhonesPlus CSV layout
PP_CSV_Layout := record
	PRTE_CSV.PhonesPlus.rthor_data400__key__phonesplus__did; 
	string cust_name;
	string bug_num;
	end;

PP_CSV_Layout makePPcsv(ddp_cust_hdr_recs le) := transform
	self.l_did := (unsigned integer6) le.did;
	self.datevendorlastreported := le.dt_vendor_last_reported;
	self.datevendorfirstreported := le.dt_vendor_first_reported;
	self.datefirstseen := IF(le.filler1='', le.dt_first_seen, (unsigned3)le.filler1[1..6]);
	self.datelastseen  := IF(le.filler2='', le.dt_last_seen, (unsigned3)le.filler2[1..6]);
	self.dt_nonglb_last_seen := 0;
	self.glb_dppa_flag := 'G';
	self.activeflag := '';
	self.cellphoneidkey := '';
	self.confidencescore := 11;
	self.recordkey := '';
	self.vendor := 'HD';
	self.stateorigin := '';
	self.sourcefile := 'Headers';
	self.src := le.src;
	self.origname := 'orig_not scrambled';
	self.nameformat := '';
	self.address1 := 'orig_not scrambled';
	self.address2 := '';
	self.address3 := '';
	self.origcity := '';
	self.origstate := '';
	self.origzip := '';
	self.country := '';
	self.dob := le.dob;
	self.agegroup := '';
	self.gender := '';
	self.email := '';
	self.homephone := le.phone;
	self.cellphone := le.phone;
	self.listingtype := '';
	self.publishcode := '';
	self.company := '';
	self.origtitle := '';
	self.registrationdate := 0;
	self.phonemodel := '';
	self.ipaddress := '';
	self.carriercode := '';
	self.countrycode := '';
	self.keycode := '';
	self.globalkeycode := '';
  self.prim_range := le.prim_range;
	self.predir := le.predir;
	self.prim_name := le.prim_name;
	self.addr_suffix := le.suffix;
	self.postdir := le.postdir;
	self.unit_desig := le.unit_desig;
	self.sec_range := le.sec_range;
	self.p_city_name := le.city_name;
	self.v_city_name := le.city_name;
	self.state := le.st;
	self.zip5 := le.zip;
	self.zip4 := '';
	self.cart := '';
	self.cr_sort_sz := '';
	self.lot := '';
	self.lot_order := '';
	self.dpbc := '';
	self.chk_digit := '';
	self.rec_type := '';
	self.ace_fips_st := '';
	self.ace_fips_county := '';
	self.geo_lat := '';
	self.geo_long := '';
	self.msa := '';
	self.geo_blk := '';
	self.geo_match := '';
	self.err_stat := '';
	self.title := le.title;
	self.fname :=	le.first_name;
	self.lname := le.last_name;
	self.mname := le.middle_name;
	self.name_suffix := le.suffix_name;
  self.name_score := '';
	self.did := le.did;
	self.did_score := '';
	self.__internal_fpos__ := 0;
	self.cust_name := customer;
	self.bug_num := bugnum;
	self := le;
 end;

append_csv_file := project(ddp_cust_hdr_recs, makePPcsv(left));

output(append_csv_file, named('AppendPhonesPlusSampleRecs'));
output(append_csv_file,, '~prte::out::'+customer+'_'+filedate+'_'+bugnum+'_phonesplus_append.csv', CSV(HEADING(SINGLE), SEPARATOR('\t'), TERMINATOR('\r\n')),overwrite);
output(append_csv_file,, '~prte::out::'+customer+'_'+filedate+'_'+bugnum+'::phonesplus_append', overwrite);
