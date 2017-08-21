import	_control, PRTE_CSV;

export	Proc_Build_FBNv2_Keys(string pIndexVersion)	:=
function

	rKeyFBNv2__did	:=
	RECORD
  unsigned6 did;
  string38 tmsid;
  string35 rmsid;
  unsigned8 __internal_fpos__;
 END;


	rKeyFBNv2__rmsid__business	:=
RECORD
  string38 tmsid;
  string35 rmsid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string3 filing_jurisdiction;
  string35 filing_number;
  unsigned4 filing_date;
  string filing_type;
  unsigned4 expiration_date;
  unsigned4 cancellation_date;
  string12 orig_filing_number;
  unsigned4 orig_filing_date;
  string192 bus_name;
  string long_bus_name;
  unsigned4 bus_comm_date;
  string10 bus_status;
  unsigned4 orig_fein;
  string10 bus_phone_num;
  string9 sic_code;
  string100 bus_type_desc;
  string40 bus_address1;
  string40 bus_address2;
  string28 bus_city;
  string12 bus_county;
  string2 bus_state;
  unsigned3 bus_zip;
  unsigned2 bus_zip4;
  string12 bus_country;
  string80 mail_street;
  string28 mail_city;
  string2 mail_state;
  string10 mail_zip;
  unsigned3 seq_no;
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
  string10 mail_prim_range;
  string2 mail_predir;
  string28 mail_prim_name;
  string4 mail_addr_suffix;
  string2 mail_postdir;
  string10 mail_unit_desig;
  string8 mail_sec_range;
  string25 mail_v_city_name;
  string2 mail_st;
  string5 mail_zip5;
  string4 mail_zip4;
  string2 mail_addr_rec_type;
  string2 mail_fips_state;
  string3 mail_fips_county;
  string10 mail_geo_lat;
  string11 mail_geo_long;
  string4 mail_cbsa;
  string7 mail_geo_blk;
  string1 mail_geo_match;
  string4 mail_err_stat;
  unsigned6 bdid;
  unsigned6 bdid_score;
 END;


	rKeyFBNv2__rmsid__contact	:=
RECORD
  string38 tmsid;
  string35 rmsid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 contact_type;
  string55 contact_name;
  string10 contact_status;
  string10 contact_phone;
  string10 contact_name_format;
  string40 contact_addr;
  string28 contact_city;
  string2 contact_state;
  unsigned6 contact_zip;
  string12 contact_country;
  unsigned4 contact_fei_num;
  string12 contact_charter_num;
  string9 ssn;
  unsigned3 seq_no;
  unsigned4 withdrawal_date;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
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
  unsigned6 did;
  unsigned6 did_score;
  unsigned6 bdid;
  unsigned6 bdid_score;
 END;

	
	rKeyFBNv2__address	:=
RECORD
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

	
	rKeyFBNv2__addressb2	:=
RECORD
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

	
	rKeyFBNv2__citystname	:=
RECORD
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

	
	rKeyFBNv2__citystnameb2	:=
RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

	
	rKeyFBNv2__fein2	:=
RECORD
  string1 f1;
  string1 f2;
  string1 f3;
  string1 f4;
  string1 f5;
  string1 f6;
  string1 f7;
  string1 f8;
  string1 f9;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

	
	rKeyFBNv2__name	:=
RECORD
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

	
  rKeyFBNv2__nameb2	:=
RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

	
	rKeyFBNv2__namewords2	:=
RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

	addr := RECORD
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
  END;

layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;
	
	rKeyFBNv2__payload 	:=
	RECORD
  unsigned6 fakeid;
  string192 bus_name;
  string38 tmsid;
  string35 rmsid;
  string9 ssn;
  unsigned4 orig_fein;
  string10 bus_phone_num;
  unsigned6 did;
  string10 contact_phone;
  unsigned6 bdid;
  addr bus_addr;
  addr person_addr;
  layout_clean_name person_name;
  unsigned1 zero;
 END;
	
	rKeyFBNv2__phone2 	:=
RECORD
  string7 p7;
  string3 p3;
  string6 dph_lname;
  string20 pfname;
  string2 st;
  unsigned6 did;
  unsigned4 lookups;
 END;

	
	rKeyFBNv2__phoneb2 	:=
RECORD
  string7 p7;
  string3 p3;
  string40 cname_indic;
  string40 cname_sec;
  string2 st;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

	
	rKeyFBNv2__stname 	:=
RECORD
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

	rKeyFBNv2__stnameb2 	:=
RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

	
	rKeyFBNv2__zip 	:=
RECORD
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

	
	rKeyFBNv2__zipb2 	:=
RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

	
	rKeyFBNv2__bdid 	:=
RECORD
  unsigned6 bdid;
  string38 tmsid;
  string35 rmsid;
  unsigned8 __internal_fpos__;
 END;

	
	rKeyFBNv2__filing_number 	:=
RECORD
  string35 filing_number;
  string38 tmsid;
  string35 rmsid;
  unsigned8 __internal_fpos__;
 END;

	
	rKeyFBNv2__rmsid 	:={ string38 tmsid, string35 rmsid, unsigned8 __internal_fpos__ };

rKeyFBNv2__LinkIDs 	:=
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
  string38 tmsid;
  string35 rmsid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string3 filing_jurisdiction;
  string35 filing_number;
  unsigned4 filing_date;
  string filing_type;
  unsigned4 expiration_date;
  unsigned4 cancellation_date;
  string12 orig_filing_number;
  unsigned4 orig_filing_date;
  string192 bus_name;
  string long_bus_name;
  unsigned4 bus_comm_date;
  string10 bus_status;
  unsigned4 orig_fein;
  string10 bus_phone_num;
  string9 sic_code;
  string100 bus_type_desc;
  string40 bus_address1;
  string40 bus_address2;
  string28 bus_city;
  string12 bus_county;
  string2 bus_state;
  unsigned3 bus_zip;
  unsigned2 bus_zip4;
  string12 bus_country;
  string80 mail_street;
  string28 mail_city;
  string2 mail_state;
  string10 mail_zip;
  unsigned3 seq_no;
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
  string10 mail_prim_range;
  string2 mail_predir;
  string28 mail_prim_name;
  string4 mail_addr_suffix;
  string2 mail_postdir;
  string10 mail_unit_desig;
  string8 mail_sec_range;
  string25 mail_v_city_name;
  string2 mail_st;
  string5 mail_zip5;
  string4 mail_zip4;
  string2 mail_addr_rec_type;
  string2 mail_fips_state;
  string3 mail_fips_county;
  string10 mail_geo_lat;
  string11 mail_geo_long;
  string4 mail_cbsa;
  string7 mail_geo_blk;
  string1 mail_geo_match;
  string4 mail_err_stat;
  unsigned6 bdid;
  unsigned6 bdid_score;
  unsigned8 rawaid;
  unsigned8 aceaid;
  unsigned8 mail_rawaid;
  unsigned8 mail_aceaid;
  string100 prep_addr_line1;
  string50 prep_addr_line_last;
  string100 prep_mail_addr_line1;
  string50 prep_mail_addr_line_last;
  unsigned8 source_rec_id;
  integer1 fp;
 END;

	dKeyFBNv2__did					    := 	dataset([], rKeyFBNv2__did);
	dKeyFBNv2__rmsid_business		:= 	dataset([], rKeyFBNv2__rmsid__business);
	dKeyFBNv2__rmsid_contact		:= 	dataset([], rKeyFBNv2__rmsid__contact);
	dKeyFBNv2__address          := 	dataset([], rKeyFBNv2__address);
	dKeyFBNv2__addressb2        := 	dataset([], rKeyFBNv2__addressb2);
	dKeyFBNv2__citystname       := 	dataset([], rKeyFBNv2__citystname);
	dKeyFBNv2__citystnameb2     := 	dataset([], rKeyFBNv2__citystnameb2);
	dKeyFBNv2__fein2            := 	dataset([], rKeyFBNv2__fein2);
	dKeyFBNv2__name             := 	dataset([], rKeyFBNv2__name );
	dKeyFBNv2__nameb2           := 	dataset([], rKeyFBNv2__nameb2);
	dKeyFBNv2__namewords2       := 	dataset([], rKeyFBNv2__namewords2);
	dKeyFBNv2__payload          := 	dataset([], rKeyFBNv2__payload);
	dKeyFBNv2__phone2           := 	dataset([], rKeyFBNv2__phone2);
	dKeyFBNv2__phoneb2          := 	dataset([], rKeyFBNv2__phoneb2);
	dKeyFBNv2__stname           := 	dataset([], rKeyFBNv2__stname);
	dKeyFBNv2__stnameb2         := 	dataset([], rKeyFBNv2__stnameb2);
	dKeyFBNv2__zip             	:= 	dataset([], rKeyFBNv2__zip);
	dKeyFBNv2__zipb2            := 	dataset([], rKeyFBNv2__zipb2);
	dKeyFBNv2__bdid             := 	dataset([], rKeyFBNv2__bdid);
	dKeyFBNv2__filing_number    := 	dataset([], rKeyFBNv2__filing_number);
	dKeyFBNv2__rmsid						:= 	dataset([], rKeyFBNv2__rmsid);
	dKeyFBNv2__LinkIDs					:= 	dataset([], rKeyFBNv2__LinkIDs);
	
	kKeyFBNv2__did					   	 	:=	index(dKeyFBNv2__did,{did},{dKeyFBNv2__did}, '~prte::key::FBNv2::' + pIndexVersion + '::did');
	kKeyFBNv2__rmsid_business			:=	index(dKeyFBNv2__rmsid_business,{tmsid,rmsid},{dKeyFBNv2__rmsid_business}, '~prte::key::FBNv2::' + pIndexVersion + '::rmsid_business');
	kKeyFBNv2__rmsid_contact			:=	index(dKeyFBNv2__rmsid_contact,{tmsid,rmsid},{dKeyFBNv2__rmsid_contact}, '~prte::key::FBNv2::' + pIndexVersion + '::rmsid_contact');
	kKeyFBNv2__address          	:=	index(dKeyFBNv2__address , {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeyFBNv2__address}, '~prte::key::fbnv2::' + pIndexVersion + '::autokey::address');
	kKeyFBNv2__addressb2        	:=	index(dKeyFBNv2__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeyFBNv2__addressb2},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::addressb2');  
	kKeyFBNv2__citystname       	:=	index(dKeyFBNv2__citystname,{city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyFBNv2__citystname},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::citystname'); 
	kKeyFBNv2__citystnameb2     	:=	index(dKeyFBNv2__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeyFBNv2__citystnameb2},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::citystnameb2');
	kKeyFBNv2__fein2           		:=	index(dKeyFBNv2__fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dKeyFBNv2__fein2},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::fein2');
	kKeyFBNv2__name            		:=	index(dKeyFBNv2__name , {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyFBNv2__name} ,'~prte::key::fbnv2::' + pIndexVersion + '::autokey::name');
	kKeyFBNv2__nameb2          		:=	index(dKeyFBNv2__nameb2, {cname_indic,cname_sec,bdid}, {dKeyFBNv2__nameb2},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::nameb2'); 
	kKeyFBNv2__namewords2       	:=	index(dKeyFBNv2__namewords2, {word,state,seq,bdid}, {dKeyFBNv2__namewords2},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::namewords2'); 
	kKeyFBNv2__payload          	:=	index(dKeyFBNv2__payload, {fakeid}, {dKeyFBNv2__payload},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::payload'); 
	kKeyFBNv2__phone2           	:=	index(dKeyFBNv2__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeyFBNv2__phone2},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::phone2');
	kKeyFBNv2__phoneb2          	:=	index(dKeyFBNv2__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeyFBNv2__phoneb2}, '~prte::key::fbnv2::' + pIndexVersion + '::autokey::phoneb2');
	kKeyFBNv2__stname           	:=	index(dKeyFBNv2__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyFBNv2__stname},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::stname'); 
	kKeyFBNv2__stnameb2        		:=	index(dKeyFBNv2__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeyFBNv2__stnameb2},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::stnameb2');
	kKeyFBNv2__zip             		:=	index(dKeyFBNv2__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeyFBNv2__zip} ,'~prte::key::fbnv2::' + pIndexVersion + '::autokey::zip');  
	kKeyFBNv2__zipb2          		:=	index(dKeyFBNv2__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeyFBNv2__zipb2},'~prte::key::fbnv2::' + pIndexVersion + '::autokey::zipb2');
	kKeyFBNv2__bdid             	:=	index(dKeyFBNv2__bdid ,{Bdid},{dKeyFBNv2__bdid},'~prte::key::fbnv2::' + pIndexVersion + '::bdid');
	kKeyFBNv2__filing_number    	:=	index(dKeyFBNv2__filing_number,{filing_number},{dKeyFBNv2__filing_number},'~prte::key::fbnv2::' + pIndexVersion + '::filing_number'); 
	kKeyFBNv2__rmsid							:=	index(dKeyFBNv2__rmsid,{TMSID},{dKeyFBNv2__rmsid},'~prte::key::fbnv2::' + pIndexVersion + '::rmsid');
  kKeyFBNv2__LinkIDs						:=	index(dKeyFBNv2__LinkIDs, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight},{dKeyFBNv2__LinkIDs},'~prte::key::fbnv2::' + pIndexVersion + '::linkids');


	return	sequential(
														parallel(
																build(kKeyFBNv2__did						  , update),
																build(kKeyFBNv2__rmsid_business		, update),
																build(kKeyFBNv2__rmsid_contact	  , update)),
																build(kKeyFBNv2__address			   	, update),          
																build(kKeyFBNv2__address			   	, update),          
																build(kKeyFBNv2__addressb2			  , update),        
																build(kKeyFBNv2__citystname 			, update),      
																build(kKeyFBNv2__citystnameb2 		, update),    
																build(kKeyFBNv2__fein2			   		, update),           
																build(kKeyFBNv2__name 			   		, update),           
																build(kKeyFBNv2__nameb2			   		, update),          
																build(kKeyFBNv2__namewords2			  , update),       
																build(kKeyFBNv2__payload			   	, update),          
																build(kKeyFBNv2__phone2 			   	, update),          
																build(kKeyFBNv2__phoneb2			   	, update),          
																build(kKeyFBNv2__stname 			   	, update),          
																build(kKeyFBNv2__stnameb2			    , update),       
																build(kKeyFBNv2__zip			   		  , update),             
																build(kKeyFBNv2__zipb2			   		, update),          
																build(kKeyFBNv2__bdid			   		  , update),             
																build(kKeyFBNv2__filing_number		, update),    
																build(kKeyFBNv2__rmsid			   		, update),	
																build(kKeyFBNv2__LinkIDs		   		, update),					
   											PRTE.UpdateVersion('FBN2Keys',										//	Package name
   																				 pIndexVersion,												//	Package version
   																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 'B',																	//	B = Boca, A = Alpharetta
   																				 'N',																	//	N = Non-FCRA, F = FCRA
   																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																				));
								 

end;