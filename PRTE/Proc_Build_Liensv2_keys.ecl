import liensv2, PRTE_CSV, _control, BIPV2; 
 export	Proc_Build_Liensv2_Keys(string pIndexVersion)	:=
function
 rkey__liensv2__autokey__address	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_address;
	end;
	
	dkey__liensv2__autokey__address			            := 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_address, rkey__liensv2__autokey__address);
	kkey__liensv2__autokey__address			            :=	index(dkey__liensv2__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dkey__liensv2__autokey__address}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_address');

rKeyliensv2__autokey__addressb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_addressb2;
	end;
	
	dKeyliensv2__autokey__addressb2		:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_addressb2 , rKeyliensv2__autokey__addressb2);
    kKeyliensv2__autokey__addressb2		:=	index(dKeyliensv2__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__addressb2}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_addressb2');

rKeyliensv2__autokey__citystname	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_citystname;
	end;
	dKeyliensv2__autokey__citystname		:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_citystname, rKeyliensv2__autokey__citystname);
	kKeyliensv2__autokey__citystname		:=	index(dKeyliensv2__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__citystname}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_citystname');

 rKeyliensv2__autokey__citystnameb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_citystnameb2;
	end;
	
	dKeyliensv2__autokey__citystnameb2	:= 	project(PRTE_CSV.liensv2. dthor_data400__key__liensv2__autokey_citystnameb2, rKeyliensv2__autokey__citystnameb2);
	kKeyliensv2__autokey__citystnameb2	:=	index(dKeyliensv2__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__citystnameb2}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_citystnameb2');

rKeyliensv2__autokey__fein2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_fein2;
	end;
	dKeyliensv2__autokey__fein2				:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_fein2, rKeyliensv2__autokey__fein2);
	kKeyliensv2__autokey__fein2				:=	index(dKeyliensv2__autokey__fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__fein2}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_fein2');

rKeyliensv2__autokey__name	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_name;
	end;
	dKeyliensv2__autokey__name					:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_name, rKeyliensv2__autokey__name);
	kKeyliensv2__autokey__name					:=	index(dKeyliensv2__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__name}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_name');
 
 rKeyliensv2__autokey__nameb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_nameb2;
	end;
	dKeyliensv2__autokey__nameb2				:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_nameb2, rKeyliensv2__autokey__nameb2);
	kKeyliensv2__autokey__nameb2				:=	index(dKeyliensv2__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__nameb2}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_nameb2');

rKeyliensv2__autokey__namewords2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_namewords2;
	end;

	dKeyliensv2__autokey__namewords2		:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_namewords2, rKeyliensv2__autokey__namewords2);
    kKeyliensv2__autokey__namewords2		:=	index(dKeyliensv2__autokey__namewords2, {word,state,seq,bdid}, {dKeyliensv2__autokey__namewords2}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_namewords2');

rKeyliensv2__autokey__payload	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_payload;
	end;
	dKeyliensv2__autokey__payload			:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_payload , rKeyliensv2__autokey__payload);
	kKeyliensv2__autokey__payload			:=	index(dKeyliensv2__autokey__payload, {fakeid}, {dKeyliensv2__autokey__payload}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_payload');

rKeyliensv2__autokey__phone2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_phone2;
	end;

	rKeyliensv2__autokey__phoneb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_phoneb2;
	end;
	
	dKeyliensv2__autokey__phone2				:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_phone2, rKeyliensv2__autokey__phone2);
	dKeyliensv2__autokey__phoneb2			:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_phoneb2, rKeyliensv2__autokey__phoneb2);
    kKeyliensv2__autokey__phone2				:=	index(dKeyliensv2__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyliensv2__autokey__phone2}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_phone2');
	kKeyliensv2__autokey__phoneb2			:=	index(dKeyliensv2__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyliensv2__autokey__phoneb2}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_phoneb2');
	
	rKeyliensv2__autokey__ssn2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_ssn2;
	end;
	dKeyliensv2__autokey__ssn2					:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_ssn2, rKeyliensv2__autokey__ssn2);
	kKeyliensv2__autokey__ssn2					:=	index(dKeyliensv2__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyliensv2__autokey__ssn2}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_ssn2');

rKeyliensv2__autokey__stname	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_stname;
	end;
	dKeyliensv2__autokey__stname				:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_stname  , rKeyliensv2__autokey__stname);
	kKeyliensv2__autokey__stname				:=	index(dKeyliensv2__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__stname}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_stname');

rKeyliensv2__autokey__stnameb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_stnameb2;
	end;
	dKeyliensv2__autokey__stnameb2			:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_stnameb2, rKeyliensv2__autokey__stnameb2);
	kKeyliensv2__autokey__stnameb2			:=	index(dKeyliensv2__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__stnameb2}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_stnameb2');

rKeyliensv2__autokey__zip	:=
	record
		PRTE_CSV.liensv2. rthor_data400__key__liensv2__autokey_zip;
	end;
	dKeyliensv2__autokey__zip					:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_zip, rKeyliensv2__autokey__zip);
	kKeyliensv2__autokey__zip					:=	index(dKeyliensv2__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__zip}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_zip');

rKeyliensv2__autokey__zipb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_zipb2;
	end;
	
	dKeyliensv2__autokey__zipb2				:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_zipb2, rKeyliensv2__autokey__zipb2);
	kKeyliensv2__autokey__zipb2				:=	index(dKeyliensv2__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__zipb2}, '~prte::key::liensv2::' + pIndexVersion + '::autokey_zipb2');

rKeyliensv2__bdid	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__bdid;
	end;
	dKeyliensv2__bdid									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__bdid, rKeyliensv2__bdid);
	kKeyliensv2__bdid									:=	index(dKeyliensv2__bdid, {p_bdid}, {TMSID,RMSID}, '~prte::key::liensv2::' + pIndexVersion + '::bdid');

rKeyliensv2__case_number	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__case_number;
	end;
	dKeyliensv2__case_number									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__case_number, rKeyliensv2__case_number);
	kKeyliensv2__case_number									:=	index(dKeyliensv2__case_number, {case_number, filing_state}, {TMSID,RMSID}, '~prte::key::liensv2::' + pIndexVersion + '::case_number');

rKeyliensv2__did	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__did;
	end;
	dKeyliensv2__did									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__did ,rKeyliensv2__did);
	kKeyliensv2__did									:=	index(dKeyliensv2__did, {did}, {TMSID,RMSID}, '~prte::key::liensv2::' + pIndexVersion + '::did');

rKeyliensv2__filing_number	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__filing_number;
	end;
	dKeyliensv2__filing_number									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__filing_number, rKeyliensv2__filing_number);
	kKeyliensv2__filing_number									:=	index(dKeyliensv2__filing_number, {filing_number, filing_state}, {TMSID,RMSID}, '~prte::key::liensv2::' + pIndexVersion + '::filing_number');

rKeyliensv2__certificate_number	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__main__certificate_number;
	end;
	dKeyliensv2__certificate_number									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__main__certificate_number, rKeyliensv2__certificate_number);
	kKeyliensv2__certificate_number									:=	index(dKeyliensv2__certificate_number, {certificate_number}, {TMSID,RMSID}, '~prte::key::liensv2::' + pIndexVersion + '::main::certificate_number');


rKeyliensv2__irs_serial_number	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__main__irs_serial_number;
	end;
	dKeyliensv2__irs_serial_number									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__main__irs_serial_number, rKeyliensv2__irs_serial_number);
	kKeyliensv2__irs_serial_number									:=	index(dKeyliensv2__irs_serial_number, {irs_serial_number,agency_state}, {TMSID,RMSID}, '~prte::key::liensv2::' + pIndexVersion + '::main::irs_serial_number');

rKeyliensv2__main__rmsid	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__main__rmsid;
	end;
	dKeyliensv2__main__rmsid									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__main__rmsid, rKeyliensv2__main__rmsid);
	kKeyliensv2__main__rmsid									:=	index(dKeyliensv2__main__rmsid, {RMSID},{TMSID}, '~prte::key::liensv2::' + pIndexVersion + '::main::rmsid');

rKeyliensv2__party__tmsid_rmsid	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__party__tmsid_rmsid and not __internal_fpos__;
		  unsigned8 persistent_record_id:= 0;
			BIPV2.IDlayouts.l_xlink_ids;

	end;
	dKeyliensv2__party__tmsid_rmsid									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2___party__tmsid_rmsid, rKeyliensv2__party__tmsid_rmsid);
	kKeyliensv2__party__tmsid_rmsid									:=	index(dKeyliensv2__party__tmsid_rmsid	, {tmsid,RMSID},{dKeyliensv2__party__tmsid_rmsid}, '~prte::key::liensv2::' + pIndexVersion + '::party::tmsid.rmsid');

rKeyliensv2__main__tmsid_rmsid	:=  module

	export liensv2__layout_filing_status :=
record,maxLength(10000)
	string filing_status;
	string filing_status_desc;
end;
export rthor_data400__key__liensv2__main__tmsid_rmsid :=
record,maxLength(32766)
	string50 tmsid;
	string50 rmsid;
	string process_date;
	string record_code;
	string date_vendor_removed;
	string filing_jurisdiction;
	string filing_state;
	string20 orig_filing_number;
	string orig_filing_type;
	string orig_filing_date;
	string orig_filing_time;
	string case_number;
	string20 filing_number;
	string filing_type_desc;
	string filing_date;
	string filing_time;
	string vendor_entry_date;
	string judge;
	string case_title;
	string filing_book;
	string filing_page;
	string release_date;
	string amount;
	string eviction;
	string satisifaction_type;
	string judg_satisfied_date;
	string judg_vacated_date;
	string tax_code;
	string irs_serial_number;
	string effective_date;
	string lapse_date;
	string accident_date;
	string sherrif_indc;
	string expiration_date;
	string agency;
	string agency_city;
	string agency_state;
	string agency_county;
	string legal_lot;
	string legal_block;
	string legal_borough;
	string certificate_number;
	unsigned8 persistent_record_id := 0 ; 
	DATASET(liensv2__layout_filing_status) filing_status;
	unsigned8 __internal_fpos__;
end;
		//PRTE_CSV.XML_Liensv2.rthor_data400__key__liensv2__main__tmsid_rmsid;
	end;
	dKeyliensv2__main__tmsid_rmsid								:= 	project(PRTE_CSV.XML_Liensv2.dthor_data400__key__liensv2__main__tmsid_rmsid, rKeyliensv2__main__tmsid_rmsid.rthor_data400__key__liensv2__main__tmsid_rmsid);
	kKeyliensv2__main__tmsid_rmsid									:=	index(dKeyliensv2__main__tmsid_rmsid	, {tmsid,RMSID},{dKeyliensv2__main__tmsid_rmsid}, '~prte::key::liensv2::' + pIndexVersion + '::main::tmsid.rmsid');


arecord28:= 
RECORD
  unsigned6 did;
  unsigned1 liens_recent_unreleased_count;
  unsigned1 liens_historical_unreleased_count;
  unsigned1 liens_recent_released_count;
  unsigned1 liens_historical_released_count;
  string8 last_liens_unreleased_date;
  unsigned8 __internal_fpos__;
 END;

layout_liens_info := RECORD
   unsigned1 count;
   unsigned4 earliest_filing_date;
   unsigned4 most_recent_filing_date;
   unsigned8 total_amount;
  END;

arecord29:= RECORD
  unsigned6 did;
  unsigned1 liens_recent_unreleased_count;
  unsigned1 liens_historical_unreleased_count;
  unsigned1 liens_unreleased_count30;
  unsigned1 liens_unreleased_count90;
  unsigned1 liens_unreleased_count180;
  unsigned1 liens_unreleased_count12;
  unsigned1 liens_unreleased_count24;
  unsigned1 liens_unreleased_count36;
  unsigned1 liens_unreleased_count60;
  string8 last_liens_unreleased_date;
  unsigned1 liens_recent_released_count;
  unsigned1 liens_historical_released_count;
  unsigned1 liens_released_count30;
  unsigned1 liens_released_count90;
  unsigned1 liens_released_count180;
  unsigned1 liens_released_count12;
  unsigned1 liens_released_count24;
  unsigned1 liens_released_count36;
  unsigned1 liens_released_count60;
  unsigned4 last_liens_released_date;
  unsigned1 eviction_recent_unreleased_count;
  unsigned1 eviction_historical_unreleased_count;
  unsigned1 eviction_recent_released_count;
  unsigned1 eviction_historical_released_count;
  unsigned1 eviction_count;
  unsigned1 eviction_count30;
  unsigned1 eviction_count90;
  unsigned1 eviction_count180;
  unsigned1 eviction_count12;
  unsigned1 eviction_count24;
  unsigned1 eviction_count36;
  unsigned1 eviction_count60;
  unsigned4 last_eviction_date;
  Layout_Liens_Info liens_unreleased_civil_judgment;
  Layout_Liens_Info liens_released_civil_judgment;
  Layout_Liens_Info liens_unreleased_federal_tax;
  Layout_Liens_Info liens_released_federal_tax;
  Layout_Liens_Info liens_unreleased_foreclosure;
  Layout_Liens_Info liens_released_foreclosure;
  Layout_Liens_Info liens_unreleased_landlord_tenant;
  Layout_Liens_Info liens_released_landlord_tenant;
  Layout_Liens_Info liens_unreleased_lispendens;
  Layout_Liens_Info liens_released_lispendens;
  Layout_Liens_Info liens_unreleased_other_lj;
  Layout_Liens_Info liens_released_other_lj;
  Layout_Liens_Info liens_unreleased_other_tax;
  Layout_Liens_Info liens_released_other_tax;
  Layout_Liens_Info liens_unreleased_small_claims;
  Layout_Liens_Info liens_released_small_claims;
  unsigned8 __internal_fpos__;
 END;

arecord30:= 
RECORD
  unsigned6 did;
  unsigned1 liens_recent_unreleased_count;
  unsigned1 liens_historical_unreleased_count;
  unsigned1 liens_unreleased_count30;
  unsigned1 liens_unreleased_count90;
  unsigned1 liens_unreleased_count180;
  unsigned1 liens_unreleased_count12;
  unsigned1 liens_unreleased_count24;
  unsigned1 liens_unreleased_count36;
  unsigned1 liens_unreleased_count60;
  string8 last_liens_unreleased_date;
  unsigned1 liens_recent_released_count;
  unsigned1 liens_historical_released_count;
  unsigned1 liens_released_count30;
  unsigned1 liens_released_count90;
  unsigned1 liens_released_count180;
  unsigned1 liens_released_count12;
  unsigned1 liens_released_count24;
  unsigned1 liens_released_count36;
  unsigned1 liens_released_count60;
  unsigned4 last_liens_released_date;
  unsigned1 eviction_recent_unreleased_count;
  unsigned1 eviction_historical_unreleased_count;
  unsigned1 eviction_recent_released_count;
  unsigned1 eviction_historical_released_count;
  unsigned1 eviction_count30;
  unsigned1 eviction_count90;
  unsigned1 eviction_count180;
  unsigned1 eviction_count12;
  unsigned1 eviction_count24;
  unsigned1 eviction_count36;
  unsigned1 eviction_count60;
  unsigned4 last_eviction_date;
 END;
 
arecord31:= 
RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  string50 tmsid;
  string50 rmsid;
  string orig_full_debtorname;
  string orig_name;
  string orig_lname;
  string orig_fname;
  string orig_mname;
  string orig_suffix;
  string9 tax_id;
  string9 ssn;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string cname;
  string orig_address1;
  string orig_address2;
  string orig_city;
  string orig_state;
  string orig_zip5;
  string orig_zip4;
  string orig_county;
  string orig_country;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string phone;
  string name_type;
  string12 did;
  string12 bdid;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  unsigned8 persistent_record_id;
  string9 app_ssn;
  string9 app_tax_id;
  integer1 fp;
 END;



// FcRA 

  kkey__liensv2__autokey__address_fcra	           :=	index(dkey__liensv2__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dkey__liensv2__autokey__address}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_address');
  kKeyliensv2__autokey__addressb2_fcra		   :=	index(dKeyliensv2__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__addressb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_addressb2');
	kKeyliensv2__autokey__citystname_fcra	   :=	index(dKeyliensv2__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__citystname}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_citystname');
	kKeyliensv2__autokey__citystnameb2_fcra	   :=	index(dKeyliensv2__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__citystnameb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_citystnameb2');
	kKeyliensv2__autokey__fein2_fcra		   :=	index(dKeyliensv2__autokey__fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__fein2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_fein2');
	kKeyliensv2__autokey__name_fcra		   :=	index(dKeyliensv2__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__name}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_name');
	kKeyliensv2__autokey__nameb2_fcra		   :=	index(dKeyliensv2__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__nameb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_nameb2');
  kKeyliensv2__autokey__namewords2_fcra	   :=	index(dKeyliensv2__autokey__namewords2, {word,state,seq,bdid}, {dKeyliensv2__autokey__namewords2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_namewords2');
	kKeyliensv2__autokey__payload_fcra		   :=	index(dKeyliensv2__autokey__payload, {fakeid}, {dKeyliensv2__autokey__payload}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_payload');
  kKeyliensv2__autokey__phone2_fcra		   :=	index(dKeyliensv2__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyliensv2__autokey__phone2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_phone2');
	kKeyliensv2__autokey__phoneb2_fcra		   :=	index(dKeyliensv2__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyliensv2__autokey__phoneb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_phoneb2');
  kKeyliensv2__autokey__ssn2_fcra		   :=	index(dKeyliensv2__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyliensv2__autokey__ssn2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_ssn2');
	kKeyliensv2__autokey__stname_fcra		   :=	index(dKeyliensv2__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__stname}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_stname');
	kKeyliensv2__autokey__stnameb2_fcra		   :=	index(dKeyliensv2__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__stnameb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_stnameb2');
	kKeyliensv2__autokey__zip_fcra		   :=	index(dKeyliensv2__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__zip}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_zip');
	kKeyliensv2__autokey__zipb2_fcra		   :=	index(dKeyliensv2__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__zipb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_zipb2');
	kKeyliensv2__bdid_fcra			   :=	index(dKeyliensv2__bdid, {p_bdid}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::bdid');
	kKeyliensv2__case_number_fcra		   :=	index(dKeyliensv2__case_number, {case_number, filing_state}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::case_number');
	kKeyliensv2__did_fcra			   :=	index(dKeyliensv2__did, {did}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::did');
	kKeyliensv2__filing_number_fcra		   :=	index(dKeyliensv2__filing_number, {filing_number, filing_state}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::filing_number');
	kKeyliensv2__certificate_number_fcra		   :=	index(dKeyliensv2__certificate_number, {certificate_number}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::main::certificate_number');
	kKeyliensv2__irs_serial_number_fcra		   :=	index(dKeyliensv2__irs_serial_number, {irs_serial_number,agency_state}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::main::irs_serial_number');
	kKeyliensv2__main__rmsid_fcra		   :=	index(dKeyliensv2__main__rmsid, {RMSID},{TMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::main::rmsid');
	kKeyliensv2__party__tmsid_rmsid_fcra		   :=	index(dKeyliensv2__party__tmsid_rmsid	, {tmsid,RMSID},{dKeyliensv2__party__tmsid_rmsid}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::party::tmsid.rmsid');
	kKeyliensv2__main__tmsid_rmsid_fcra		   :=	index(dKeyliensv2__main__tmsid_rmsid	, {tmsid,RMSID},{dKeyliensv2__main__tmsid_rmsid}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::main::tmsid.rmsid');


export layout_date :=RECORD
   unsigned4 date;
   string50 tmsid;
   string50 rmsid;
   boolean eviction;
   unsigned8 amount;
   string1 filing_type;
  END;

arecord4:= 
RECORD
  unsigned6 did;
  DATASET(layout_date) liens_recent_unreleased_count{maxcount(25)};
  DATASET(layout_date) liens_historical_unreleased_count{maxcount(25)};
  DATASET(layout_date) liens_recent_released_count{maxcount(25)};
  DATASET(layout_date) liens_historical_released_count{maxcount(25)};
  unsigned8 __internal_fpos__;
 END;
		return 					sequential(parallel(
																build(kkey__liensv2__autokey__address			, update),
	                              build(kKeyliensv2__autokey__addressb2			, update), 
																 build(kKeyliensv2__autokey__citystname, update), 
																build(kKeyliensv2__autokey__citystnameb2			, update),
																build(kKeyliensv2__autokey__fein2			, update),
																build(kKeyliensv2__autokey__name			, update),
																build(kKeyliensv2__autokey__nameb2			, update),
																build(kKeyliensv2__autokey__namewords2			, update),
																build(kKeyliensv2__autokey__payload			, update),
																build(kKeyliensv2__autokey__phone2			, update),
																build(kKeyliensv2__autokey__phoneb2			, update),
																build(kKeyliensv2__autokey__ssn2			, update),
																build(kKeyliensv2__autokey__stname			, update),
																build(kKeyliensv2__autokey__stnameb2			, update),
																build(kKeyliensv2__autokey__zip			, update),
																build(kKeyliensv2__autokey__zipb2			, update),
																build(kKeyliensv2__bdid			, update),
																build(kKeyliensv2__case_number			, update),
																build(kKeyliensv2__did			, update),
																build(kKeyliensv2__filing_number			, update),
																build(kKeyliensv2__certificate_number			, update),
																build(kKeyliensv2__irs_serial_number			, update),
																build(kKeyliensv2__main__rmsid			, update),
																build(kKeyliensv2__party__tmsid_rmsid			, update),
																build(kKeyliensv2__main__tmsid_rmsid			, update),
																buildindex(index(dataset([],arecord28),{did},{dataset([],arecord28)},'keyname'),'~prte::key::liensv2::' + pIndexVersion + '::bocashell_did_v2',update),
                                buildindex(index(dataset([],arecord29),{did},{dataset([],arecord29)},'keyname'),'~prte::key::liensv2::' + pIndexVersion + '::bocashell_liens_and_evictions_did_v2',update),
                                buildindex(index(dataset([],arecord30),{did},{dataset([],arecord30)},'keyname'),'~prte::key::liensv2::' + pIndexVersion + '::bocashell_liens_and_evictions_did',update);
																buildindex(index(dataset([],arecord31),{ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight},{dataset([],arecord31)},'keyname'),'~prte::key::liensv2::' + pIndexVersion + '::party::linkids',update);
											// FCRA keys 
	build(kkey__liensv2__autokey__address_fcra, update),	          
  build(kKeyliensv2__autokey__addressb2_fcra, update),		   
	build(kKeyliensv2__autokey__citystname_fcra, update),	   
	build(kKeyliensv2__autokey__citystnameb2_fcra, update),	   
	build(kKeyliensv2__autokey__fein2_fcra	, update),	   
	build(kKeyliensv2__autokey__name_fcra, update),		   
	build(kKeyliensv2__autokey__nameb2_fcra	, update),	   
  build(kKeyliensv2__autokey__namewords2_fcra, update),	   
	build(kKeyliensv2__autokey__payload_fcra, update),		   
  build(kKeyliensv2__autokey__phone2_fcra	, update),	   
	build(kKeyliensv2__autokey__phoneb2_fcra, update),		  
  build(kKeyliensv2__autokey__ssn2_fcra, update),		   
	build(kKeyliensv2__autokey__stname_fcra	, update),	   
	build(kKeyliensv2__autokey__stnameb2_fcra, update),		   
	build(kKeyliensv2__autokey__zip_fcra	, update),	  
	build(kKeyliensv2__bdid_fcra	, update),		   
	build(kKeyliensv2__case_number_fcra, update),		   
	build(kKeyliensv2__did_fcra	, update),		   
	build(kKeyliensv2__filing_number_fcra	, update),	   
	build(kKeyliensv2__certificate_number_fcra	, update),	   
	build(kKeyliensv2__irs_serial_number_fcra, update),		   
	build(kKeyliensv2__main__rmsid_fcra	, update),	   
	build(kKeyliensv2__party__tmsid_rmsid_fcra, update),		   
	build(kKeyliensv2__main__tmsid_rmsid_fcra, update),		   

  buildindex(index(dataset([],arecord4),{did},{dataset([],arecord4)},'keyname'),'~prte::key::liensv2::fcra::' + pIndexVersion + '::bocashell_did_v2',update);

											
														
																											  ),
													  
											PRTE.UpdateVersion('Liensv2Keys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				), 
											PRTE.UpdateVersion('FCRA_Liensv2Keys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
														

//FCRA keys 
/*import liensv2, PRTE_CSV; 
 pIndexVersion := '' + pIndexVersion + '';
 rkey__liensv2__autokey__address	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_address;
	end;
	
	dkey__liensv2__autokey__address			            := 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_address, rkey__liensv2__autokey__address);
	kkey__liensv2__autokey__address			            :=	index(dkey__liensv2__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dkey__liensv2__autokey__address}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_address');

rKeyliensv2__autokey__addressb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_addressb2;
	end;
	
	dKeyliensv2__autokey__addressb2		:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_addressb2 , rKeyliensv2__autokey__addressb2);
    kKeyliensv2__autokey__addressb2		:=	index(dKeyliensv2__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__addressb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_addressb2');

rKeyliensv2__autokey__citystname	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_citystname;
	end;
	dKeyliensv2__autokey__citystname		:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_citystname, rKeyliensv2__autokey__citystname);
	kKeyliensv2__autokey__citystname		:=	index(dKeyliensv2__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__citystname}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_citystname');

 rKeyliensv2__autokey__citystnameb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_citystnameb2;
	end;
	
	dKeyliensv2__autokey__citystnameb2	:= 	project(PRTE_CSV.liensv2. dthor_data400__key__liensv2__autokey_citystnameb2, rKeyliensv2__autokey__citystnameb2);
	kKeyliensv2__autokey__citystnameb2	:=	index(dKeyliensv2__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__citystnameb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_citystnameb2');

rKeyliensv2__autokey__fein2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_fein2;
	end;
	dKeyliensv2__autokey__fein2				:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_fein2, rKeyliensv2__autokey__fein2);
	kKeyliensv2__autokey__fein2				:=	index(dKeyliensv2__autokey__fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__fein2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_fein2');

rKeyliensv2__autokey__name	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_name;
	end;
	dKeyliensv2__autokey__name					:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_name, rKeyliensv2__autokey__name);
	kKeyliensv2__autokey__name					:=	index(dKeyliensv2__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__name}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_name');
 
 rKeyliensv2__autokey__nameb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_nameb2;
	end;
	dKeyliensv2__autokey__nameb2				:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_nameb2, rKeyliensv2__autokey__nameb2);
	kKeyliensv2__autokey__nameb2				:=	index(dKeyliensv2__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__nameb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_nameb2');

rKeyliensv2__autokey__namewords2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_namewords2;
	end;

	dKeyliensv2__autokey__namewords2		:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_namewords2, rKeyliensv2__autokey__namewords2);
    kKeyliensv2__autokey__namewords2		:=	index(dKeyliensv2__autokey__namewords2, {word,state,seq,bdid}, {dKeyliensv2__autokey__namewords2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_namewords2');

rKeyliensv2__autokey__payload	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_payload;
	end;
	dKeyliensv2__autokey__payload			:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_payload , rKeyliensv2__autokey__payload);
	kKeyliensv2__autokey__payload			:=	index(dKeyliensv2__autokey__payload, {fakeid}, {dKeyliensv2__autokey__payload}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_payload');

rKeyliensv2__autokey__phone2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_phone2;
	end;

	rKeyliensv2__autokey__phoneb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_phoneb2;
	end;
	
	dKeyliensv2__autokey__phone2				:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_phone2, rKeyliensv2__autokey__phone2);
	dKeyliensv2__autokey__phoneb2			:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_phoneb2, rKeyliensv2__autokey__phoneb2);
    kKeyliensv2__autokey__phone2				:=	index(dKeyliensv2__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyliensv2__autokey__phone2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_phone2');
	kKeyliensv2__autokey__phoneb2			:=	index(dKeyliensv2__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyliensv2__autokey__phoneb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_phoneb2');
	
	rKeyliensv2__autokey__ssn2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_ssn2;
	end;
	dKeyliensv2__autokey__ssn2					:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_ssn2, rKeyliensv2__autokey__ssn2);
	kKeyliensv2__autokey__ssn2					:=	index(dKeyliensv2__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeyliensv2__autokey__ssn2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_ssn2');

rKeyliensv2__autokey__stname	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_stname;
	end;
	dKeyliensv2__autokey__stname				:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_stname  , rKeyliensv2__autokey__stname);
	kKeyliensv2__autokey__stname				:=	index(dKeyliensv2__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__stname}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_stname');

rKeyliensv2__autokey__stnameb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_stnameb2;
	end;
	dKeyliensv2__autokey__stnameb2			:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_stnameb2, rKeyliensv2__autokey__stnameb2);
	kKeyliensv2__autokey__stnameb2			:=	index(dKeyliensv2__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__stnameb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_stnameb2');

rKeyliensv2__autokey__zip	:=
	record
		PRTE_CSV.liensv2. rthor_data400__key__liensv2__autokey_zip;
	end;
	dKeyliensv2__autokey__zip					:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_zip, rKeyliensv2__autokey__zip);
	kKeyliensv2__autokey__zip					:=	index(dKeyliensv2__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyliensv2__autokey__zip}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_zip');

rKeyliensv2__autokey__zipb2	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__autokey_zipb2;
	end;
	
	dKeyliensv2__autokey__zipb2				:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__autokey_zipb2, rKeyliensv2__autokey__zipb2);
	kKeyliensv2__autokey__zipb2				:=	index(dKeyliensv2__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyliensv2__autokey__zipb2}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::autokey_zipb2');

rKeyliensv2__bdid	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__bdid;
	end;
	dKeyliensv2__bdid									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__bdid, rKeyliensv2__bdid);
	kKeyliensv2__bdid									:=	index(dKeyliensv2__bdid, {p_bdid}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::bdid');

rKeyliensv2__case_number	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__case_number;
	end;
	dKeyliensv2__case_number									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__case_number, rKeyliensv2__case_number);
	kKeyliensv2__case_number									:=	index(dKeyliensv2__case_number, {case_number, filing_state}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::case_number');

rKeyliensv2__did	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__did;
	end;
	dKeyliensv2__did									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__did ,rKeyliensv2__did);
	kKeyliensv2__did									:=	index(dKeyliensv2__did, {did}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::did');

rKeyliensv2__filing_number	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__filing_number;
	end;
	dKeyliensv2__filing_number									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__filing_number, rKeyliensv2__filing_number);
	kKeyliensv2__filing_number									:=	index(dKeyliensv2__filing_number, {filing_number, filing_state}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::filing_number');

rKeyliensv2__certificate_number	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__main__certificate_number;
	end;
	dKeyliensv2__certificate_number									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__main__certificate_number, rKeyliensv2__certificate_number);
	kKeyliensv2__certificate_number									:=	index(dKeyliensv2__certificate_number, {certificate_number}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::main::certificate_number');


rKeyliensv2__irs_serial_number	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__main__irs_serial_number;
	end;
	dKeyliensv2__irs_serial_number									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__main__irs_serial_number, rKeyliensv2__irs_serial_number);
	kKeyliensv2__irs_serial_number									:=	index(dKeyliensv2__irs_serial_number, {irs_serial_number,agency_state}, {TMSID,RMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::main::irs_serial_number');

rKeyliensv2__main__rmsid	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__main__rmsid;
	end;
	dKeyliensv2__main__rmsid									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2__main__rmsid, rKeyliensv2__main__rmsid);
	kKeyliensv2__main__rmsid									:=	index(dKeyliensv2__main__rmsid, {RMSID},{TMSID}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::main::rmsid');

rKeyliensv2__party__tmsid_rmsid	:=
	record
		PRTE_CSV.liensv2.rthor_data400__key__liensv2__party__tmsid_rmsid;
		  unsigned8 persistent_record_id:= 0;

	end;
	dKeyliensv2__party__tmsid_rmsid									:= 	project(PRTE_CSV.liensv2.dthor_data400__key__liensv2___party__tmsid_rmsid, rKeyliensv2__party__tmsid_rmsid);
	kKeyliensv2__party__tmsid_rmsid									:=	index(dKeyliensv2__party__tmsid_rmsid	, {tmsid,RMSID},{dKeyliensv2__party__tmsid_rmsid}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::party::tmsid.rmsid');

rKeyliensv2__main__tmsid_rmsid	:=  module

	export liensv2__layout_filing_status :=
record,maxLength(10000)
	string filing_status;
	string filing_status_desc;
end;
export rthor_data400__key__liensv2__main__tmsid_rmsid :=
record,maxLength(32766)
	string50 tmsid;
	string50 rmsid;
	string process_date;
	string record_code;
	string date_vendor_removed;
	string filing_jurisdiction;
	string filing_state;
	string20 orig_filing_number;
	string orig_filing_type;
	string orig_filing_date;
	string orig_filing_time;
	string case_number;
	string20 filing_number;
	string filing_type_desc;
	string filing_date;
	string filing_time;
	string vendor_entry_date;
	string judge;
	string case_title;
	string filing_book;
	string filing_page;
	string release_date;
	string amount;
	string eviction;
	string satisifaction_type;
	string judg_satisfied_date;
	string judg_vacated_date;
	string tax_code;
	string irs_serial_number;
	string effective_date;
	string lapse_date;
	string accident_date;
	string sherrif_indc;
	string expiration_date;
	string agency;
	string agency_city;
	string agency_state;
	string agency_county;
	string legal_lot;
	string legal_block;
	string legal_borough;
	string certificate_number;
	unsigned8 persistent_record_id := 0 ; 
	DATASET(liensv2__layout_filing_status) filing_status;
	unsigned8 __internal_fpos__;
end;
		//PRTE_CSV.XML_Liensv2.rthor_data400__key__liensv2__main__tmsid_rmsid;
	end;
	dKeyliensv2__main__tmsid_rmsid								:= 	project(PRTE_CSV.XML_Liensv2.dthor_data400__key__liensv2__main__tmsid_rmsid, rKeyliensv2__main__tmsid_rmsid.rthor_data400__key__liensv2__main__tmsid_rmsid);
	kKeyliensv2__main__tmsid_rmsid									:=	index(dKeyliensv2__main__tmsid_rmsid	, {tmsid,RMSID},{dKeyliensv2__main__tmsid_rmsid}, '~prte::key::liensv2::fcra::' + pIndexVersion + '::main::tmsid.rmsid');


										parallel(
																build(kkey__liensv2__autokey__address			, update),
	                              build(kKeyliensv2__autokey__addressb2			, update), 
																 build(kKeyliensv2__autokey__citystname, update), 
																build(kKeyliensv2__autokey__citystnameb2			, update),
																build(kKeyliensv2__autokey__fein2			, update),
																build(kKeyliensv2__autokey__name			, update),
																build(kKeyliensv2__autokey__nameb2			, update),
																build(kKeyliensv2__autokey__namewords2			, update),
																build(kKeyliensv2__autokey__payload			, update),
																build(kKeyliensv2__autokey__phone2			, update),
																build(kKeyliensv2__autokey__phoneb2			, update),
																build(kKeyliensv2__autokey__ssn2			, update),
																build(kKeyliensv2__autokey__stname			, update),
																build(kKeyliensv2__autokey__stnameb2			, update),
																build(kKeyliensv2__autokey__zip			, update),
																build(kKeyliensv2__autokey__zipb2			, update),
																build(kKeyliensv2__bdid			, update),
																build(kKeyliensv2__case_number			, update),
																build(kKeyliensv2__did			, update),
																build(kKeyliensv2__filing_number			, update),
																build(kKeyliensv2__certificate_number			, update),
																build(kKeyliensv2__irs_serial_number			, update),
																build(kKeyliensv2__main__rmsid			, update),
																build(kKeyliensv2__party__tmsid_rmsid			, update),
																build(kKeyliensv2__main__tmsid_rmsid			, update)
													  );
														
export layout_date :=RECORD
   unsigned4 date;
   string50 tmsid;
   string50 rmsid;
   boolean eviction;
   unsigned8 amount;
   string1 filing_type;
  END;

arecord4:= 
RECORD
  unsigned6 did;
  DATASET(layout_date) liens_recent_unreleased_count{maxcount(25)};
  DATASET(layout_date) liens_historical_unreleased_count{maxcount(25)};
  DATASET(layout_date) liens_recent_released_count{maxcount(25)};
  DATASET(layout_date) liens_historical_released_count{maxcount(25)};
  unsigned8 __internal_fpos__;
 END;
buildindex(index(dataset([],arecord4),{did},{dataset([],arecord4)},'keyname'),'~prte::key::liensv2::fcra::' + pIndexVersion + '::bocashell_did_v2',update);
*/ 												