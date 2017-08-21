import	_control;

export Proc_Build_DEADCO_Keys(string pIndexVersion) := function

arecord1:= RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned integer4 city_code;
  string5 zip;
  string8 sec_range;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  unsigned integer8 states;
  unsigned integer4 lname1;
  unsigned integer4 lname2;
  unsigned integer4 lname3;
  unsigned integer4 lookups;
  unsigned integer6 did;
 END;

arecord2:= RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned integer4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned integer6 bdid;
  unsigned integer4 lookups;
 END;

arecord3:= RECORD
  unsigned integer4 city_code;
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  integer4 dob;
  unsigned integer8 states;
  unsigned integer4 lname1;
  unsigned integer4 lname2;
  unsigned integer4 lname3;
  unsigned integer4 city1;
  unsigned integer4 city2;
  unsigned integer4 city3;
  unsigned integer4 rel_fname1;
  unsigned integer4 rel_fname2;
  unsigned integer4 rel_fname3;
  unsigned integer4 lookups;
  unsigned integer6 did;
 END;

arecord4:= RECORD
  unsigned integer4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned integer6 bdid;
  unsigned integer4 lookups;
 END;

arecord5:= RECORD
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned integer2 yob;
  unsigned integer2 s4;
  integer4 dob;
  unsigned integer8 states;
  unsigned integer4 lname1;
  unsigned integer4 lname2;
  unsigned integer4 lname3;
  unsigned integer4 city1;
  unsigned integer4 city2;
  unsigned integer4 city3;
  unsigned integer4 rel_fname1;
  unsigned integer4 rel_fname2;
  unsigned integer4 rel_fname3;
  unsigned integer4 lookups;
  unsigned integer6 did;
 END;

arecord6:= RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned integer6 bdid;
  unsigned integer4 lookups;
 END;

arecord7:= RECORD
  string40 word;
  string2 state;
  unsigned integer1 seq;
  unsigned integer6 bdid;
  unsigned integer4 lookups;
 END;

EXPORT standard__name :=RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

EXPORT standard__base :=RECORD
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

arecord8:= RECORD
  unsigned integer6 fakeid;
  string9 abi_number;
  string10 phone;
  string30 company_name;
  unsigned integer6 bdid;
  standard__name name;
  standard__base addr;
  unsigned integer1 zero;
  unsigned integer6 fdid;
 END;

arecord9:= RECORD
  string7 p7;
  string3 p3;
  string6 dph_lname;
  string20 pfname;
  string2 st;
  unsigned integer6 did;
  unsigned integer4 lookups;
 END;

arecord10:= RECORD
  string7 p7;
  string3 p3;
  string40 cname_indic;
  string40 cname_sec;
  string2 st;
  unsigned integer6 bdid;
  unsigned integer4 lookups;
 END;

arecord11:= RECORD
  string2 st;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned integer2 yob;
  unsigned integer2 s4;
  integer4 zip;
  integer4 dob;
  unsigned integer8 states;
  unsigned integer4 lname1;
  unsigned integer4 lname2;
  unsigned integer4 lname3;
  unsigned integer4 city1;
  unsigned integer4 city2;
  unsigned integer4 city3;
  unsigned integer4 rel_fname1;
  unsigned integer4 rel_fname2;
  unsigned integer4 rel_fname3;
  unsigned integer4 lookups;
  unsigned integer6 did;
 END;

arecord12:= RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned integer6 bdid;
  unsigned integer4 lookups;
 END;

arecord13:= RECORD
  integer4 zip;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  string1 minit;
  unsigned integer2 yob;
  unsigned integer2 s4;
  integer4 dob;
  unsigned integer8 states;
  unsigned integer4 lname1;
  unsigned integer4 lname2;
  unsigned integer4 lname3;
  unsigned integer4 city1;
  unsigned integer4 city2;
  unsigned integer4 city3;
  unsigned integer4 rel_fname1;
  unsigned integer4 rel_fname2;
  unsigned integer4 rel_fname3;
  unsigned integer4 lookups;
  unsigned integer6 did;
 END;

arecord14:= RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned integer6 bdid;
  unsigned integer4 lookups;
 END;

arecord15:= RECORD
  integer1 f;
  unsigned integer8 maxdocfreq;
  unsigned integer8 maxfreq;
  integer8 meandocsize;
  integer8 uniquenominals;
  integer8 doccount;
  unsigned integer8 fpos;
 END;


arecord16:= RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  string9 abi_number;
  unsigned integer8 __filepos;
 END;


arecord17:= RECORD
  integer1 f;
  string segname{maxLength(128)};
  unsigned integer1 segtype;
  set of unsigned integer2 seglist{maxCount(64)};
  unsigned integer8 fpos;
 END;

arecord18:= RECORD
  unsigned integer1 typ;
  unsigned integer4 nominal;
  unsigned integer2 lseg;
  unsigned integer2 part;
  unsigned integer2 src;
  unsigned integer6 doc;
  unsigned integer2 seg;
  unsigned integer4 kwp;
  unsigned integer2 wip;
  unsigned integer4 suffix;
  unsigned integer2 sect;
  unsigned integer8 fpos;
 END;

EXPORT string text_search__externalkey := string{maxLength(255)};

arecord19:= RECORD
  unsigned integer8 hashkey;
  unsigned integer2 part;
  unsigned integer2 src;
  unsigned integer6 doc;
  text_search__externalkey externalkey;
  unsigned integer8 __internal_fpos__;
 END;

arecord20:= RECORD
  unsigned integer2 src;
  unsigned integer6 doc;
  text_search__externalkey externalkey;
  unsigned integer8 __internal_fpos__;
 END;

arecord21:= RECORD
  string20 word;
  unsigned integer4 nominal;
  unsigned integer4 suffix;
  unsigned integer8 freq;
  unsigned integer8 docfreq;
  unsigned integer1 typ;
  string128 fullword;
  unsigned integer8 fpos;
 END;

arecord22:= RECORD
  string20 word;
  unsigned integer4 nominal;
  unsigned integer4 suffix;
  unsigned integer8 freq;
  unsigned integer8 docfreq;
  unsigned integer1 typ;
  string128 fullword;
  unsigned integer8 fpos;
 END;

arecord23:= RECORD
  string9 abi_number;
  unsigned integer6 bdid;
  string30 contact_name;
  string30 company_name;
  string30 street1;
  string16 city1;
  string2 state1;
  string5 zip1_5;
  string4 zip1_4;
  string4 carrier_cd;
  string2 state_cd;
  string3 county_cd;
  string10 phone;
  string2 filler1;
  string6 sic_cd;
  string6 franchise_cd;
  string1 ad_size_cd;
  string1 filler2;
  string1 population_cd;
  string1 individual_firm_cd;
  string4 year_started;
  string6 date_added;
  string14 contact_lname;
  string11 contact_fname;
  string3 contact_prof_title;
  string1 contact_title;
  string1 gender_cd;
  string1 employee_size_cd;
  string1 sales_volume_cd;
  string1 industry_specific_cd;
  string1 business_status_cd;
  string6 trad_date;
  string4 key_cd;
  string10 fax;
  string1 office_size_cd;
  string8 production_date;
  string9 subsidiary_parent_num;
  string9 ultimate_parent_num;
  string6 primary_sic;
  string6 secondary_sic_1;
  string6 secondary_sic_2;
  string6 secondary_sic_3;
  string6 secondary_sic_4;
  string1 total_employee_size_cd;
  string1 total_output_sales_cd;
  string1 public_co_indicator;
  string1 stock_exchange_cd;
  string6 stock_ticker_symbol;
  string6 num_employees_actual;
  string6 total_employees_actual;
  string30 secondary_address;
  string16 secondary_city;
  string2 secondary_state;
  string5 secondary_zip_code;
  string1 credit_code;
  string24 filler3;
  string8 process_date;
  string2 crlf;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string8 dt_vendor_first_reported;
  string8 dt_vendor_last_reported;
  standard__name name;
  standard__base addr;
  string17 ad_size;
  string20 population;
  string20 employee_size;
  string30 sales_volume;
  string40 industry_desc;
  string25 business_status;
  string20 office_size;
  string13 total_employee_size;
  string30 total_output_sales;
  string6 stock_exchange;
  string27 credit_desc;
  string10 individual_firm;
  string50 sic_desc;
  string50 secondary_sic_desc1;
  string50 secondary_sic_desc2;
  string50 secondary_sic_desc3;
  string50 secondary_sic_desc4;
  unsigned integer8 __internal_fpos__;
 END;

arecord24:= RECORD
 unsigned integer6 bdid;
 string9 abi_number;
 unsigned integer8 __internal_fpos__ ;
END;

arecord25:= RECORD
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
  qstring34 vendor_id;
  unsigned8 source_rec_id;
  string30 contact_name;
  string30 company_name;
  string30 street1;
  string16 city1;
  string2 state1;
  string5 zip1_5;
  string4 zip1_4;
  string4 carrier_cd;
  string2 state_cd;
  string3 county_cd;
  string10 phone;
  string2 filler1;
  string6 sic_cd;
  string6 franchise_cd;
  string1 ad_size_cd;
  string1 filler2;
  string1 population_cd;
  string1 individual_firm_cd;
  string4 year_started;
  string6 date_added;
  string14 contact_lname;
  string11 contact_fname;
  string3 contact_prof_title;
  string1 contact_title;
  string1 gender_cd;
  string1 employee_size_cd;
  string1 sales_volume_cd;
  string1 industry_specific_cd;
  string1 business_status_cd;
  string6 trad_date;
  string4 key_cd;
  string10 fax;
  string1 office_size_cd;
  string8 production_date;
  string9 abi_number;
  string9 subsidiary_parent_num;
  string9 ultimate_parent_num;
  string6 primary_sic;
  string6 secondary_sic_1;
  string6 secondary_sic_2;
  string6 secondary_sic_3;
  string6 secondary_sic_4;
  string1 total_employee_size_cd;
  string1 total_output_sales_cd;
  string1 public_co_indicator;
  string1 stock_exchange_cd;
  string6 stock_ticker_symbol;
  string6 num_employees_actual;
  string6 total_employees_actual;
  string30 secondary_address;
  string16 secondary_city;
  string2 secondary_state;
  string5 secondary_zip_code;
  string1 credit_code;
  string24 filler3;
  string8 process_date;
  string2 crlf;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string8 dt_vendor_first_reported;
  string8 dt_vendor_last_reported;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_cleaning_score;
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
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 ace_fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string17 ad_size;
  string20 population;
  string20 employee_size;
  string30 sales_volume;
  string40 industry_desc;
  string25 business_status;
  string20 office_size;
  string13 total_employee_size;
  string30 total_output_sales;
  string6 stock_exchange;
  string27 credit_desc;
  string10 individual_firm;
  string50 sic_desc;
  string50 secondary_sic_desc1;
  string50 secondary_sic_desc2;
  string50 secondary_sic_desc3;
  string50 secondary_sic_desc4;
  unsigned8 append_rawaid;
  unsigned8 append_aceaid;
  string100 prep_addr_line1;
  string50 prep_addr_last_line;
  integer1 fp;
END;

return	sequential(
					parallel(		
						buildindex(index(dataset([],arecord1),{prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups},{dataset([],arecord1)},'keyname')
							,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::address',update) 
						,buildindex(index(dataset([],arecord2),{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},{dataset([],arecord2)},'keyname')
							,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::addressb2',update) 
						,buildindex(index(dataset([],arecord3),{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord3)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::citystname',update) 
						,buildindex(index(dataset([],arecord4),{city_code,st,cname_indic,cname_sec,bdid},{dataset([],arecord4)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::citystnameb2',update) 
						,buildindex(index(dataset([],arecord5),{dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord5)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::name',update) 
						,buildindex(index(dataset([],arecord6),{cname_indic,cname_sec,bdid},{dataset([],arecord6)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::nameb2',update) 
						,buildindex(index(dataset([],arecord7),{word,state,seq,bdid},{dataset([],arecord7)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::namewords2',update) 
						,buildindex(index(dataset([],arecord8),{fakeid},{dataset([],arecord8)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::payload',update) 
						,buildindex(index(dataset([],arecord9),{p7,p3,dph_lname,pfname,st,did},{dataset([],arecord9)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::phone2',update) 
						,buildindex(index(dataset([],arecord10),{p7,p3,cname_indic,cname_sec,st,bdid},{dataset([],arecord10)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::phoneb2',update) 
						,buildindex(index(dataset([],arecord11),{st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord11)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::stname',update)
						,buildindex(index(dataset([],arecord12),{st,cname_indic,cname_sec,bdid},{dataset([],arecord12)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::stnameb2',update) 
						,buildindex(index(dataset([],arecord13),{zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups},{dataset([],arecord13)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::zip',update) 
						,buildindex(index(dataset([],arecord14),{zip,cname_indic,cname_sec,bdid},{dataset([],arecord14)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::autokey::zipb2',update) 
						,buildindex(index(dataset([],arecord15),{f},{dataset([],arecord15)},'keyname')
						 ,'~prte::key::deadco::' + pIndexVersion + '::xdstat2',update) 
						,buildindex(index(dataset([],arecord16),{src,doc,abi_number},{dataset([],arecord16)},'keyname')
						 ,'~prte::key::deadco::' + pIndexVersion + '::doc.abinumber',update) 
						,buildindex(index(dataset([],arecord17),{f},{dataset([],arecord17)},'keyname')
						 ,'~prte::key::deadco::' + pIndexVersion + '::xseglist',update) 
						,buildindex(index(dataset([],arecord18),{typ,nominal,lseg,part,src,doc,seg,kwp,wip,suffix},{dataset([],arecord18)},'keyname')
						 ,'~prte::key::deadco::' + pIndexVersion + '::nidx3',update) 
						,buildindex(index(dataset([],arecord19),{hashkey,part,src,doc},{dataset([],arecord19)},'keyname')
						 ,'~prte::key::deadco::' + pIndexVersion + '::exkeyi',update) 
						,buildindex(index(dataset([],arecord20),{src,doc},{dataset([],arecord20)},'keyname')
						 ,'~prte::key::deadco::' + pIndexVersion + '::exkeyo',update) 
						,buildindex(index(dataset([],arecord21),{word,nominal,suffix,freq,docfreq},{dataset([],arecord21)},'keyname')
						 ,'~prte::key::deadco::' + pIndexVersion + '::dictindx3',update) 
						,buildindex(index(dataset([],arecord22),{word,nominal,suffix,freq,docfreq},{dataset([],arecord22)},'keyname')
						 ,'~prte::key::deadco::' + pIndexVersion + '::dtldictx',update) 
						,buildindex(index(dataset([],arecord23),{abi_number},{dataset([],arecord23)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::abi_number',update) 
						,buildindex(index(dataset([],arecord24),{bdid},{dataset([],arecord24)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::bdid',update) 
						,buildindex(index(dataset([],arecord25),{ultid,orgid,seleid,proxid,powid,empid,dotid},{dataset([],arecord25)},'keyname')
						 ,'~prte::key::infousa::deadco::' + pIndexVersion + '::linkids',update) 
 																	 ),
						PRTE.UpdateVersion('DEADCOKeys',			            	//	Package name
						  							pIndexVersion,											//	Package version
							  						_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
														 'B',																//	B = Boca, A = Alpharetta
														 'N',																//	N = Non-FCRA, F = FCRA
														 'N'));															//	N = Do not also include boolean, Y = Include boolean, too
end;
 
