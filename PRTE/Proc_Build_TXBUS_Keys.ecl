import	_control;

export Proc_Build_TXBUS_Keys(string pIndexVersion) := function

Txbus_taxpayer_nbr_record:= RECORD
  string11 taxpayer_number;
  unsigned6 did;
  unsigned1 did_score;
  string9 ssn;
  unsigned6 bdid;
  string8 process_date;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string5 outlet_number;
  string50 taxpayer_name;
  string40 taxpayer_address;
  string20 taxpayer_city;
  string2 taxpayer_state;
  string5 taxpayer_zipcode;
  string3 taxpayer_county_code;
  string10 taxpayer_phone;
  string2 taxpayer_org_type;
  string50 outlet_name;
  string40 outlet_address;
  string20 outlet_city;
  string2 outlet_state;
  string5 outlet_zipcode;
  string3 outlet_county_code;
  string10 outlet_phone;
  string6 outlet_naics_code;
  string1 outlet_city_limits_indicator;
  string8 outlet_permit_issue_date;
  string8 outlet_first_sales_date;
  string75 taxpayer_org_type_desc;
  string5 taxpayer_title;
  string20 taxpayer_fname;
  string20 taxpayer_mname;
  string20 taxpayer_lname;
  string5 taxpayer_name_suffix;
  string3 taxpayer_name_score;
  string10 taxpayer_prim_range;
  string2 taxpayer_predir;
  string28 taxpayer_prim_name;
  string4 taxpayer_addr_suffix;
  string2 taxpayer_postdir;
  string10 taxpayer_unit_desig;
  string8 taxpayer_sec_range;
  string25 taxpayer_p_city_name;
  string25 taxpayer_v_city_name;
  string2 taxpayer_st;
  string5 taxpayer_zip5;
  string4 taxpayer_zip4;
  string4 taxpayer_cart;
  string1 taxpayer_cr_sort_sz;
  string4 taxpayer_lot;
  string1 taxpayer_lot_order;
  string2 taxpayer_dpbc;
  string1 taxpayer_chk_digit;
  string2 taxpayer_addr_rec_type;
  string2 taxpayer_fips_state;
  string3 taxpayer_fips_county;
  string10 taxpayer_geo_lat;
  string11 taxpayer_geo_long;
  string4 taxpayer_cbsa;
  string7 taxpayer_geo_blk;
  string1 taxpayer_geo_match;
  string4 taxpayer_err_stat;
  string10 outlet_prim_range;
  string2 outlet_predir;
  string28 outlet_prim_name;
  string4 outlet_addr_suffix;
  string2 outlet_postdir;
  string10 outlet_unit_desig;
  string8 outlet_sec_range;
  string25 outlet_p_city_name;
  string25 outlet_v_city_name;
  string2 outlet_st;
  string5 outlet_zip5;
  string4 outlet_zip4;
  string4 outlet_cart;
  string1 outlet_cr_sort_sz;
  string4 outlet_lot;
  string1 outlet_lot_order;
  string2 outlet_dpbc;
  string1 outlet_chk_digit;
  string2 outlet_addr_rec_type;
  string2 outlet_fips_state;
  string3 outlet_fips_county;
  string10 outlet_geo_lat;
  string11 outlet_geo_long;
  string4 outlet_cbsa;
  string7 outlet_geo_blk;
  string1 outlet_geo_match;
  string4 outlet_err_stat;
  unsigned8 __internal_fpos__;
 END;

Txbus_bdid_record:=RECORD  
	unsigned6 bdid; 
	string11 taxpayer_number;
	unsigned8 __internal_fpos__ ; 
END;

Txbus_did_record:= RECORD 
 unsigned6 did; 
 string11 taxpayer_number; 
 unsigned8 __internal_fpos__ ;
END;

Txbus_addressb2_record:= RECORD
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
 END;

Txbus_citystnameb2_record:= RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
Txbus_nameb2_record:= RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
base :=RECORD
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
   string5 zip5;
   string4 zip4;
   string2 fips_state;
   string3 fips_county;
   string2 addr_rec_type;
  END;

name :=RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

Txbus_payload_record:= RECORD
  unsigned6 fakeid;
  unsigned6 bdid;
  unsigned6 did;
  string11 taxpayer_number;
  string5 outlet_number;
  string50 name;
  Base addr;
  name taxpayercleanname;
  string10 phone;
  unsigned6 zero;
  string1 blank;
  unsigned8 __internal_fpos__;
 END;

Txbus_zipb2_record:= RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
Txbus_stnameb2_record:= RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
Txbus_namewords2_record:= RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
  
Txbus_phoneb2_record:= RECORD
  string7 p7;
  string3 p3;
  string40 cname_indic;
  string40 cname_sec;
  string2 st;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
Txbus_name_record:= RECORD
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
 END;
 
Txbus_address_record:= RECORD
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
 END;
 
Txbus_stname_record:= RECORD
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
 END;
 
Txbus_citystname_record:= RECORD
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
 END;
 
Txbus_zip_record:= RECORD
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
 END;
 
Txbus_docref_taxpayernumber_record:= RECORD
  unsigned2 src;
  unsigned6 doc;
  string11 taxpayer_number;
  unsigned8 __internal_fpos__;
 END;

Txbus_xdstat2_record:= RECORD
  integer1 f;
  unsigned8 maxdocfreq;
  unsigned8 maxfreq;
  integer8 meandocsize;
  integer8 uniquenominals;
  integer8 doccount;
  unsigned8 fpos;
 END;
 
Txbus_xseglist_record:= RECORD
  integer1 f;
  string segname{maxLength(128)};
  unsigned1 segtype;
  set of unsigned2 seglist{maxCount(64)};
  unsigned8 fpos;
 END;
 

Txbus_nidx3_record:= RECORD
  unsigned1 typ;
  unsigned4 nominal;
  unsigned2 lseg;
  unsigned2 part;
  unsigned2 src;
  unsigned6 doc;
  unsigned2 seg;
  unsigned4 kwp;
  unsigned2 wip;
  unsigned4 suffix;
  unsigned2 sect;
  unsigned8 fpos;
 END;

Txbus_dictindx3_record:= RECORD
  string20 word;
  unsigned4 nominal;
  unsigned4 suffix;
  unsigned8 freq;
  unsigned8 docfreq;
  unsigned1 typ;
  string128 fullword;
  unsigned8 fpos;
 END;

Txbus_dtldictx_record:= RECORD
  string20 word;
  unsigned4 nominal;
  unsigned4 suffix;
  unsigned8 freq;
  unsigned8 docfreq;
  unsigned1 typ;
  string128 fullword;
  unsigned8 fpos;
 END;

EXPORT string text_search__externalkey := string{maxLength(255)};

Txbus_exkeyi_record:= RECORD
  unsigned8 hashkey;
  unsigned2 part;
  unsigned2 src;
  unsigned6 doc;
  text_search__externalkey externalkey;
  unsigned8 __internal_fpos__;
 END;

Txbus_exkeyo_record:= RECORD
  unsigned2 src;
  unsigned6 doc;
  text_search__externalkey externalkey;
  unsigned8 __internal_fpos__;
 END;
 
 Txbus_linkids_record:=RECORD
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
  unsigned6 did;
  unsigned1 did_score;
  string9 ssn;
  unsigned6 bdid;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned8 mail_raw_aid;
  unsigned8 mail_ace_aid;
  string100 prep_addr_line1;
  string50 prep_addr_line_last;
  string100 prep_mail_addr_line1;
  string50 prep_mail_addr_line_last;
  string8 process_date;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string11 taxpayer_number;
  string5 outlet_number;
  string50 taxpayer_name;
  string40 taxpayer_address;
  string20 taxpayer_city;
  string2 taxpayer_state;
  string5 taxpayer_zipcode;
  string3 taxpayer_county_code;
  string10 taxpayer_phone;
  string2 taxpayer_org_type;
  string50 outlet_name;
  string40 outlet_address;
  string20 outlet_city;
  string2 outlet_state;
  string5 outlet_zipcode;
  string3 outlet_county_code;
  string10 outlet_phone;
  string6 outlet_naics_code;
  string1 outlet_city_limits_indicator;
  string8 outlet_permit_issue_date;
  string8 outlet_first_sales_date;
  string75 taxpayer_org_type_desc;
  string5 taxpayer_title;
  string20 taxpayer_fname;
  string20 taxpayer_mname;
  string20 taxpayer_lname;
  string5 taxpayer_name_suffix;
  string3 taxpayer_name_score;
  string10 taxpayer_prim_range;
  string2 taxpayer_predir;
  string28 taxpayer_prim_name;
  string4 taxpayer_addr_suffix;
  string2 taxpayer_postdir;
  string10 taxpayer_unit_desig;
  string8 taxpayer_sec_range;
  string25 taxpayer_p_city_name;
  string25 taxpayer_v_city_name;
  string2 taxpayer_st;
  string5 taxpayer_zip5;
  string4 taxpayer_zip4;
  string4 taxpayer_cart;
  string1 taxpayer_cr_sort_sz;
  string4 taxpayer_lot;
  string1 taxpayer_lot_order;
  string2 taxpayer_dpbc;
  string1 taxpayer_chk_digit;
  string2 taxpayer_addr_rec_type;
  string2 taxpayer_fips_state;
  string3 taxpayer_fips_county;
  string10 taxpayer_geo_lat;
  string11 taxpayer_geo_long;
  string4 taxpayer_cbsa;
  string7 taxpayer_geo_blk;
  string1 taxpayer_geo_match;
  string4 taxpayer_err_stat;
  string10 outlet_prim_range;
  string2 outlet_predir;
  string28 outlet_prim_name;
  string4 outlet_addr_suffix;
  string2 outlet_postdir;
  string10 outlet_unit_desig;
  string8 outlet_sec_range;
  string25 outlet_p_city_name;
  string25 outlet_v_city_name;
  string2 outlet_st;
  string5 outlet_zip5;
  string4 outlet_zip4;
  string4 outlet_cart;
  string1 outlet_cr_sort_sz;
  string4 outlet_lot;
  string1 outlet_lot_order;
  string2 outlet_dpbc;
  string1 outlet_chk_digit;
  string2 outlet_addr_rec_type;
  string2 outlet_fips_state;
  string3 outlet_fips_county;
  string10 outlet_geo_lat;
  string11 outlet_geo_long;
  string4 outlet_cbsa;
  string7 outlet_geo_blk;
  string1 outlet_geo_match;
  string4 outlet_err_stat;
  unsigned8 source_rec_id;
  integer1 fp;
 END;

  
return sequential(
							 parallel(																									
												buildindex(index(dataset([],Txbus_taxpayer_nbr_record),{taxpayer_number},{dataset([],Txbus_taxpayer_nbr_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::taxpayer_nbr',update);
												buildindex(index(dataset([],Txbus_bdid_record),{bdid},{dataset([],Txbus_bdid_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::bdid',update);
												buildindex(index(dataset([],Txbus_did_record),{did},{dataset([],Txbus_did_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::did',update);
												buildindex(index(dataset([],Txbus_addressb2_record),{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},{dataset([],Txbus_addressb2_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::addressb2',update);
												buildindex(index(dataset([],Txbus_citystnameb2_record),{city_code,st,cname_indic,cname_sec,bdid},{dataset([],Txbus_citystnameb2_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::citystnameb2',update);
												buildindex(index(dataset([],Txbus_nameb2_record),{cname_indic,cname_sec,bdid},{dataset([],Txbus_nameb2_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::nameb2',update);
												buildindex(index(dataset([],Txbus_payload_record),{fakeid},{dataset([],Txbus_payload_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::payload',update);
												buildindex(index(dataset([],Txbus_zipb2_record),{zip,cname_indic,cname_sec,bdid},{dataset([],Txbus_zipb2_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::zipb2',update);
												buildindex(index(dataset([],Txbus_stnameb2_record),{st,cname_indic,cname_sec,bdid},{dataset([],Txbus_stnameb2_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::stnameb2',update);
												buildindex(index(dataset([],Txbus_namewords2_record),{word,state,seq,bdid},{dataset([],Txbus_namewords2_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::namewords2',update);
												buildindex(index(dataset([],Txbus_phoneb2_record),{p7,p3,cname_indic,cname_sec,st,bdid},{dataset([],Txbus_phoneb2_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::phoneb2',update);
												buildindex(index(dataset([],Txbus_name_record),{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],Txbus_name_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::name',update);
												buildindex(index(dataset([],Txbus_address_record),{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{dataset([],Txbus_address_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::address',update);
												buildindex(index(dataset([],Txbus_stname_record),{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],Txbus_stname_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::stname',update);
												buildindex(index(dataset([],Txbus_citystname_record),{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],Txbus_citystname_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::citystname',update);
												buildindex(index(dataset([],Txbus_zip_record),{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],Txbus_zip_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::autokey::zip',update);
												buildindex(index(dataset([],Txbus_docref_taxpayernumber_record),{src,doc},{dataset([],Txbus_docref_taxpayernumber_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::docref.taxpayernumber',update);
												buildindex(index(dataset([],Txbus_xdstat2_record),{f},{dataset([],Txbus_xdstat2_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::xdstat2',update);
												buildindex(index(dataset([],Txbus_xseglist_record),{f},{dataset([],Txbus_xseglist_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::xseglist',update);
												buildindex(index(dataset([],Txbus_nidx3_record),{typ,nominal,lseg,part,src,doc,seg,kwp,wip,suffix},{dataset([],Txbus_nidx3_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::nidx3',update);
												buildindex(index(dataset([],Txbus_dictindx3_record),{word,nominal,suffix,freq,docfreq},{dataset([],Txbus_dictindx3_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::dictindx3',update);
												buildindex(index(dataset([],Txbus_dtldictx_record),{word,nominal,suffix,freq,docfreq},{dataset([],Txbus_dtldictx_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::dtldictx',update);
												buildindex(index(dataset([],Txbus_exkeyi_record),{hashkey,part,src,doc},{dataset([],Txbus_exkeyi_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::exkeyi',update);
												buildindex(index(dataset([],Txbus_exkeyo_record),{src,doc},{dataset([],Txbus_exkeyo_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::exkeyo',update);
												buildindex(index(dataset([],Txbus_LinkIDs_record),{ultid,orgid,proxid,powid,empid,dotid,ultscore,orgscore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,proxweight,powweight,empweight,dotweight},{dataset([],Txbus_LinkIDs_record)},'keyname'),'~prte::key::txbus::' + pIndexVersion + '::linkids',update);
																																																																																	
											 ),
							PRTE.UpdateVersion('TxbusKeys',													     //	Package name
																					pIndexVersion,												  //	Package version
																					_control.MyInfo.EmailAddressNormal,	   // 	Who to email with specifics
																					'B',																	//	  B = Boca, A = Alpharetta
																					'N',																 //	    N = Non-FCRA, F = FCRA
																					'N'																	//	    N = Do not also include boolean, Y = Include boolean, too
																)
				);
end;