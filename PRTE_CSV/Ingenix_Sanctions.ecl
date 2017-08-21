export Ingenix_Sanctions := 

module

	shared	lSubDirName					:=	'';
	shared	lCSVVersion					:=	'20091215';
	shared	lCSVFileNamePrefix	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;
	
	shared	lSubDirName1					:=	'';
	shared	lCSVVersion1					:=	'20100713a';
	shared	lCSVFileNamePrefix1	:=	PRTE_CSV.Constants.CSVFilesBaseName + lSubDirName;

export rthor_data400__key__ingenix_sanctions__address__auto	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	string8 sec_range;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export name := 
record
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
end;


export addr :=
record
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 addr_rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 cbsa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
end;

export rthor_data400__key__ingenix_sanctions__autokey__address	:=
record
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	string8 sec_range;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__ingenix_sanctions__autokey__addressb2	:=
record
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
end;

export rthor_data400__key__ingenix_sanctions__autokey__citystname	:=
record
	unsigned4 city_code;
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__ingenix_sanctions__autokey__citystnameb2	:=
record
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
end;

export rthor_data400__key__ingenix_sanctions__autokey__name	:=
record
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__ingenix_sanctions__autokey__nameb2	:=
record
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
end;

export rthor_data400__key__ingenix_sanctions__autokey__namewords2	:=
record
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
end;

export rthor_data400__key__ingenix_sanctions__autokey__payload	:=
record
  unsigned6 fakeid;
  string sanc_id;
  string filetyp;
  string sanc_tin;
  string sanc_dob;
  addr addr;
  name name;
  unsigned6 did;
  string sanc_busnme;
  unsigned6 zero;
  string1 blank;
  unsigned6 lookups;
 END;

export rthor_data400__key__ingenix_sanctions__autokey__stname	:=
record
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 zip;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__ingenix_sanctions__autokey__stnameb2	:=
record
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
end;

export rthor_data400__key__ingenix_sanctions__autokey__zip	:=
record
	integer4 zip;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;


export rthor_data400__key__ingenix_sanctions__autokey__zipb2	:=
record
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
end;

export rthor_data400__key__ingenix_sanctions__bdid := { unsigned6 bdid, string sanc_id, unsigned8 __internal_fpos__ };

export rthor_data400__key__ingenix_sanctions__citystname__auto	:=
record
	unsigned4 city_code;
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__ingenix_sanctions__did := { unsigned6 l_did, string sanc_id, unsigned8 __internal_fpos__ };

export rthor_data400__key__ingenix_sanctions__fdids	:=
record
	unsigned6 fdid;
	string sanc_id;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_sanctions__license	:=
record
	string2 sanc_sancst;
	string12 sanc_licnbr;
	string6 sanc_id;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_sanctions__name__auto	:=
record
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__ingenix_sanctions__sancid	:=
record
  unsigned6 l_sancid;
  string12 bdid;
  unsigned6 bdid_score;
  string8 process_date;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_first_reported;
  string8 date_last_reported;
  string12 did;
  string filetyp;
  string sanc_id;
  string sanc_lnme;
  string sanc_fnme;
  string sanc_mid_i_nm;
  string sanc_busnme;
  string sanc_dob;
  string sanc_street;
  string sanc_city;
  string sanc_zip;
  string sanc_state;
  string sanc_cntry;
  string sanc_tin;
  string sanc_upin;
  string sanc_provtype;
  string8 sanc_sancdte_form;
  string sanc_sancdte;
  string sanc_sancst;
  string sanc_licnbr;
  string sanc_brdtype;
  string sanc_src_desc;
  string sanc_type;
  string sanc_reas;
  string sanc_terms;
  string sanc_cond;
  string sanc_fines;
  string sanc_fab;
  string8 sanc_updte_form;
  string sanc_updte;
  string8 sanc_reindte_form;
  string sanc_reindte;
  string sanc_unamb_ind;
  string5 prov_clean_title;
  string20 prov_clean_fname;
  string20 prov_clean_mname;
  string20 prov_clean_lname;
  string5 prov_clean_name_suffix;
  string3 prov_clean_cleaning_score;
  string10 provco_address_clean_prim_range;
  string2 provco_address_clean_predir;
  string28 provco_address_clean_prim_name;
  string4 provco_address_clean_addr_suffix;
  string2 provco_address_clean_postdir;
  string10 provco_address_clean_unit_desig;
  string8 provco_address_clean_sec_range;
  string25 provco_address_clean_p_city_name;
  string25 provco_address_clean_v_city_name;
  string2 provco_address_clean_st;
  string5 provco_address_clean_zip;
  string4 provco_address_clean_zip4;
  string4 provco_address_clean_cart;
  string1 provco_address_clean_cr_sort_sz;
  string4 provco_address_clean_lot;
  string1 provco_address_clean_lot_order;
  string2 provco_address_clean_dpbc;
  string1 provco_address_clean_chk_digit;
  string2 provco_address_clean_record_type;
  string2 provco_address_clean_ace_fips_st;
  string3 provco_address_clean_fipscounty;
  string10 provco_address_clean_geo_lat;
  string11 provco_address_clean_geo_long;
  string4 provco_address_clean_msa;
  string7 provco_address_clean_geo_match;
  string4 provco_address_clean_err_stat;
  unsigned8 __internal_fpos__;
 END;

export rthor_data400__key__ingenix_sanctions__stname__auto	:=
record
	string2 st;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 zip;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;


export rthor_data400__key__ingenix_sanctions__taxid	:=
record
  string10 l_taxid;
	unsigned6 fdid;
end;

export rthor_data400__key__ingenix_sanctions__taxid__name	:=
record
  string10 l_taxid;
  string20 l_fname;
  string sanc_id;
  unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_sanctions__upin := { string6 l_upin, string6 sanc_id, unsigned8 __internal_fpos__ };

export rthor_data400__key__ingenix_sanctions__zip__auto	:=
record
	integer4 zip;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	string1 minit;
	unsigned2 yob;
	unsigned2 s4;
	integer4 dob;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 city1;
	unsigned4 city2;
	unsigned4 city3;
	unsigned4 rel_fname1;
	unsigned4 rel_fname2;
	unsigned4 rel_fname3;
	unsigned4 lookups;
	unsigned6 did;
end;

export rthor_data400__key__ingenix_speciality__providerid	:=
record
	unsigned6 l_providerid;
	string filetyp;
	string processdate;
	string providerid;
	string specialityid;
	string specialtycompanycount;
	string specialtytiertypeid;
	string specialityname;
	string specialitygroupid;
	string specialitygroupname;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string8 dt_vendor_first_reported;
	string8 dt_vendor_last_reported;
	unsigned8 __internal_fpos__;
end;

export rthor_data400__key__ingenix_sanctions__LinkIDs	:=
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
  unsigned6 bdid;
  unsigned6 bdid_score;
  string8 process_date;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_first_reported;
  string8 date_last_reported;
  string12 did;
  string filetyp;
  string sanc_id;
  string sanc_lnme;
  string sanc_fnme;
  string sanc_mid_i_nm;
  string sanc_busnme;
  string sanc_dob;
  string sanc_street;
  string sanc_city;
  string sanc_zip;
  string sanc_state;
  string sanc_cntry;
  string sanc_tin;
  string sanc_upin;
  string sanc_provtype;
  string8 sanc_sancdte_form;
  string sanc_sancdte;
  string sanc_sancst;
  string sanc_licnbr;
  string sanc_brdtype;
  string sanc_src_desc;
  string sanc_type;
  string sanc_reas;
  string sanc_terms;
  string sanc_cond;
  string sanc_fines;
  string sanc_fab;
  string8 sanc_updte_form;
  string sanc_updte;
  string8 sanc_reindte_form;
  string sanc_reindte;
  string sanc_unamb_ind;
  string5 prov_clean_title;
  string20 prov_clean_fname;
  string20 prov_clean_mname;
  string20 prov_clean_lname;
  string5 prov_clean_name_suffix;
  string3 prov_clean_cleaning_score;
  string10 provco_address_clean_prim_range;
  string2 provco_address_clean_predir;
  string28 provco_address_clean_prim_name;
  string4 provco_address_clean_addr_suffix;
  string2 provco_address_clean_postdir;
  string10 provco_address_clean_unit_desig;
  string8 provco_address_clean_sec_range;
  string25 provco_address_clean_p_city_name;
  string25 provco_address_clean_v_city_name;
  string2 provco_address_clean_st;
  string5 provco_address_clean_zip;
  string4 provco_address_clean_zip4;
  string4 provco_address_clean_cart;
  string1 provco_address_clean_cr_sort_sz;
  string4 provco_address_clean_lot;
  string1 provco_address_clean_lot_order;
  string2 provco_address_clean_dpbc;
  string1 provco_address_clean_chk_digit;
  string2 provco_address_clean_record_type;
  string2 provco_address_clean_ace_fips_st;
  string3 provco_address_clean_fipscounty;
  string10 provco_address_clean_geo_lat;
  string11 provco_address_clean_geo_long;
  string4 provco_address_clean_msa;
  string7 provco_address_clean_geo_match;
  string4 provco_address_clean_err_stat;
  unsigned8 source_rec_id;
  integer1 fp;
 END;

export dthor_data400__key__ingenix_sanctions__address__auto		 				:= dataset([], rthor_data400__key__ingenix_sanctions__address__auto);
export dthor_data400__key__ingenix_sanctions__autokey__address 				:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__ingenix_sanctions__' + lCSVVersion1 + '__autokey__address.csv', rthor_data400__key__ingenix_sanctions__autokey__address, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_sanctions__autokey__addressb2 			:= dataset([], rthor_data400__key__ingenix_sanctions__autokey__addressb2);
export dthor_data400__key__ingenix_sanctions__autokey__citystname 		:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__ingenix_sanctions__' + lCSVVersion1 + '__autokey__citystname.csv', rthor_data400__key__ingenix_sanctions__autokey__citystname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_sanctions__autokey__citystnameb2 	:= dataset([], rthor_data400__key__ingenix_sanctions__autokey__citystnameb2);
export dthor_data400__key__ingenix_sanctions__autokey__name 					:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__ingenix_sanctions__' + lCSVVersion1 + '__autokey__name.csv', rthor_data400__key__ingenix_sanctions__autokey__name, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_sanctions__autokey__nameb2					:= dataset([], rthor_data400__key__ingenix_sanctions__autokey__nameb2);
export dthor_data400__key__ingenix_sanctions__autokey__namewords2 		:= dataset([], rthor_data400__key__ingenix_sanctions__autokey__namewords2);
export dthor_data400__key__ingenix_sanctions__autokey__payload 				:= dataset([], rthor_data400__key__ingenix_sanctions__autokey__payload);
export dthor_data400__key__ingenix_sanctions__autokey__stname 				:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__ingenix_sanctions__' + lCSVVersion1 + '__autokey__stname.csv', rthor_data400__key__ingenix_sanctions__autokey__stname, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_sanctions__autokey__stnameb2 			:= dataset([],rthor_data400__key__ingenix_sanctions__autokey__stnameb2);
export dthor_data400__key__ingenix_sanctions__autokey__zip 						:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__ingenix_sanctions__' + lCSVVersion1 + '__autokey__zip.csv', rthor_data400__key__ingenix_sanctions__autokey__zip, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_sanctions__autokey__zipb2 					:= dataset([], rthor_data400__key__ingenix_sanctions__autokey__zipb2);
export dthor_data400__key__ingenix_sanctions__bdid 										:= dataset(lCSVFileNamePrefix  + 'thor_data400__key__ingenix_sanctions__' + lCSVVersion + '__bdid.csv', rthor_data400__key__ingenix_sanctions__bdid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_sanctions__citystname__auto		 		:= dataset([], rthor_data400__key__ingenix_sanctions__citystname__auto);
export dthor_data400__key__ingenix_sanctions__did 										:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__ingenix_sanctions__' + lCSVVersion1 + '__did.csv', rthor_data400__key__ingenix_sanctions__did, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_sanctions__fdids										:= dataset([], rthor_data400__key__ingenix_sanctions__fdids);
export dthor_data400__key__ingenix_sanctions__license 								:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__ingenix_sanctions__' + lCSVVersion1 + '__license.csv', rthor_data400__key__ingenix_sanctions__license, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_sanctions__name__auto		 					:= dataset([], rthor_data400__key__ingenix_sanctions__name__auto);
export dthor_data400__key__ingenix_sanctions__sancid 									:= dataset([], rthor_data400__key__ingenix_sanctions__sancid);
export dthor_data400__key__ingenix_sanctions__stname__auto		 				:= dataset([], rthor_data400__key__ingenix_sanctions__stname__auto);
export dthor_data400__key__ingenix_sanctions__taxid										:= dataset([], rthor_data400__key__ingenix_sanctions__taxid);
export dthor_data400__key__ingenix_sanctions__taxid__name							:= dataset([], rthor_data400__key__ingenix_sanctions__taxid__name);
export dthor_data400__key__ingenix_sanctions__upin 										:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__ingenix_sanctions__' + lCSVVersion1 + '__upin.csv', rthor_data400__key__ingenix_sanctions__upin, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_sanctions__zip__auto		 						:= dataset([], rthor_data400__key__ingenix_sanctions__zip__auto);
export dthor_data400__key__ingenix_speciality__providerid 						:= dataset(lCSVFileNamePrefix1 + 'thor_data400__key__ingenix_speciality__' + lCSVVersion1 + '__providerid.csv', rthor_data400__key__ingenix_speciality__providerid, csv(separator('\t'), terminator('\r\n'), quote(''), heading(single)));
export dthor_data400__key__ingenix_sanctions__LinkIDs 								:= dataset([],rthor_data400__key__ingenix_sanctions__LinkIDs);
end;