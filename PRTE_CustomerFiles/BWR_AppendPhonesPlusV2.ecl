#workunit('name', 'PRCT-Append Recs to PhonesPlus CSV');
Import PRTE_CustomerFiles, PRTE_CSV, ut;

/* Spray customer tab delimitted file to thor and using Naming Convention: 'prte::in::customer_filedate_bugnum.txt'
   This program maps customer supplied PhonesPlus records (with a LexID) to PhonesPlus CSV file format
   Despray final CSV file and update PRCT PhonesPlus file  */

//modify fields below
customer 		:= 'citi';
filedate 		:= '20150217';
bugnum	 		:= '173672';

cust_layout := record,MAXLENGTH(10000)
		string	did;
		string  title;
		string  fname;
		string  lname;
		string  mname;
		string  suffix;
		string  datefirstseen;
		string  datelastseen;
		string  dob;
		string  home_phone;
		string  cell_phone;
		string  prim_range;
		string  predir;
		string  prim_name;
		string  addr_suffix;
		string  postdir;
		string  unit_desig;
		string  sec_range;
		string  city;
		string  st;
		string  zip5;
		string  zip4;
	end;

//sprayed customer tab-delimited input file 
cust_file := dataset('~prte::in::'+customer+'_'+filedate+'_'+bugnum+'.txt', cust_layout, CSV(heading(1),separator(['\t']),terminator(['\r\n']),MAXLENGTH(10000)));
output(count(cust_file), named('CustFileCount'));
ddp_cust_file := dedup(sort(distribute(cust_file, hash(did)), did, lname, fname, mname, dob, home_phone, cell_phone, skew(1.0), local), record, local);
output(count(ddp_cust_file), named('CustFileDedupCount'));

/* PhonesPlus CSV File (for reference): PhonesPlusCSV := PRTE_CSV.PhonesPlus.dthor_data400__key__phonesplus__did_ge;*/

//Map Customer File to PRCT PhonesPlus CSV layout
PP_CSV_Layout := record
	PRTE_CSV.PhonesPlus.rthor_data400__key__phonesplus__did; 
	string cust_name;
	string bug_num;
	end;

PP_CSV_Layout makePPcsv(ddp_cust_file le) := transform
	self.l_did := (unsigned integer6) le.did;
	self.datevendorlastreported := 0;
	self.datevendorfirstreported := 0;
	self.datefirstseen := (integer3) le.datefirstseen;
	self.datelastseen := (integer3) le.datelastseen;
	self.dt_nonglb_last_seen := 0;
	self.glb_dppa_flag := 'G';
	self.activeflag := '';
	self.cellphoneidkey := '';
	self.confidencescore := 11;
	self.recordkey := '';
	self.vendor := 'HD';
	self.stateorigin := '';
	self.sourcefile := 'Headers';
	self.src := 'EQ';
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
	self.homephone := le.home_phone;
	self.cellphone := le.cell_phone;
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
	self.p_city_name := le.city;
	self.v_city_name := le.city;
	self.state := le.st;
	self.zip5 := le.zip5;
	self.zip4 := le.zip4;
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
	self.fname :=	le.fname;
	self.lname := le.lname;
	self.mname := le.mname;
	self.name_suffix := le.suffix;
  self.name_score := ''; 
	self.did := (unsigned integer6) le.did;
	self.did_score := '';
	self.__internal_fpos__ := 0;
	self.cust_name := customer;
	self.bug_num := bugnum;
	self := le;
 end;

//join(cln_cust_recs, srt_hdr_recs, left.ssn = right.ssn, makePPcsv(left, right), left outer, skew(1.0));
append_csv_file := project(ddp_cust_file, makePPcsv(left));

output(append_csv_file, named('AppendPhonesPlusSampleRecs'));
output(append_csv_file,, '~prte::out::'+customer+'_'+filedate+'_'+bugnum+'_phonesplus_append.txt', CSV(HEADING(SINGLE), SEPARATOR('\t'), TERMINATOR('\r\n')),overwrite);
output(append_csv_file,, '~prte::out::'+customer+'_'+filedate+'_'+bugnum+'::phonesplus_append', overwrite);