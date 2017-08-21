 import	_control;

export Proc_Build_OIG_Keys(string pIndexVersion) := function

rKeyOIG__autokey__address := RECORD
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

 
 
rKeyOIG__autokey__addressb2 := RECORD
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

rKeyOIG__autokey__citystname := RECORD
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

rKeyOIG__autokey__citystnameb2 := RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;



rKeyOIG__autokey__name:= RECORD
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


rKeyOIG__autokey__nameb2 := RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;



rKeyOIG__autokey__ssn2 := RECORD
  string1 s1;
  string1 s2;
  string1 s3;
  string1 s4;
  string1 s5;
  string1 s6;
  string1 s7;
  string1 s8;
  string1 s9;
  string6 dph_lname;
  string20 pfname;
  unsigned6 did;
  unsigned4 lookups;
 END;

 

rKeyOIG__autokey__stname := RECORD
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

 

rKeyOIG__autokey__stnameb2:= RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;


rKeyOIG__autokey__zip := RECORD
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
 
rKeyOIG__autokey__zipb2 := RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyOIG__autokey__payload := RECORD
  unsigned6 fakeid;
  string20 lastname;
  string15 firstname;
  string15 midname;
  string30 busname;
  string20 general;
  string20 specialty;
  string6 upin1;
  string8 dob;
  string30 address1;
  string20 city;
  string2 state;
  string5 zip5;
  string9 sanctype;
  string8 sancdate;
  string8 reindate;
  string100 append_prep_address1;
  string50 append_prep_addresslast;
  unsigned8 append_rawaid;
  unsigned8 ace_aid;
  string2 addr_type;
  string8 dt_vendor_first_reported;
  string8 dt_vendor_last_reported;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string250 sancdesc;
  unsigned6 did;
  unsigned6 bdid;
  string9 ssn;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string2 ace_fips_st;
  string3 fips_county;
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
  string2 dpbc;
  string1 chk_digit;
  string2 addr_rec_type;
  string2 fips_state;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 cbsa;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 __internal_fpos__;
 END;


rKeyOIG__autokey__namewords2 := RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
rKeyOIG__LinkIDs := RECORD
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
  string20 lastname;
  string15 firstname;
  string15 midname;
  string30 busname;
  string20 general;
  string20 specialty;
  string6 upin1;
  string8 dob;
  string30 address1;
  string20 city;
  string2 state;
  string5 zip5;
  string9 sanctype;
  string8 sancdate;
  string8 reindate;
  string100 append_prep_address1;
  string50 append_prep_addresslast;
  unsigned8 append_rawaid;
  unsigned8 ace_aid;
  string2 addr_type;
  string8 dt_vendor_first_reported;
  string8 dt_vendor_last_reported;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string250 sancdesc;
  unsigned6 did;
  unsigned6 bdid;
  string9 ssn;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string2 ace_fips_st;
  string3 fips_county;
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
  string2 dpbc;
  string1 chk_digit;
  string2 addr_rec_type;
  string2 fips_state;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 cbsa;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  integer1 fp;
 END;

				ds_address 				:= dataset([],rKeyOIG__autokey__address);
				ds_addressb2			:=dataset([],rKeyOIG__autokey__addressb2);
				ds_citystname			:=dataset([],rKeyOIG__autokey__citystname);
				ds_citystnameb2		:=dataset([],rKeyOIG__autokey__citystnameb2);
				ds_name					  :=dataset([],rKeyOIG__autokey__name);
				ds_nameb2					:=dataset([],rKeyOIG__autokey__nameb2); 
				ds_ssn2					  :=dataset([],rKeyOIG__autokey__ssn2); 
				ds_stname				  :=dataset([],rKeyOIG__autokey__stname); 
				ds_stnameb2				:=dataset([],rKeyOIG__autokey__stnameb2);
				ds_zip1						:=dataset([],rKeyOIG__autokey__zip); 
				ds_zipb2					:=dataset([],rKeyOIG__autokey__zipb2);
				ds_payload				:=dataset([],rKeyOIG__autokey__payload);
				ds_namewords2			:=dataset([],rKeyOIG__autokey__namewords2);	
				ds_LinkIDs			  :=dataset([],rKeyOIG__LinkIDs);	
								
				address_IN				:=index(ds_address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {ds_address}, '~prte::key::oig::'+pIndexVersion+'::autokey::address');
				addressb2_IN			:=index(ds_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {ds_addressb2}, '~prte::key::oig::'+pIndexVersion+'::autokey::addressb2');
				citystname_IN			:=index(ds_citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {ds_citystname}, '~prte::key::oig::'+pIndexVersion+'::autokey::citystname');
				citystnameb2_IN		:=index(ds_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {ds_citystnameb2}, '~prte::key::oig::'+pIndexVersion+'::autokey::citystnameb2');
				name_IN						:=index(ds_name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {ds_name}, '~prte::key::oig::'+pIndexVersion+'::autokey::name');
				nameb2_IN					:=index(ds_nameb2, {cname_indic,cname_sec,bdid}, {ds_nameb2}, '~prte::key::oig::'+pIndexVersion+'::autokey::nameb2');
				namewords2_IN			:=index(ds_namewords2, {word,state,seq,bdid}, {ds_namewords2}, '~prte::key::oig::'+pIndexVersion+'::autokey::namewords2');
				payload_IN				:=index(ds_payload, {fakeid}, {ds_payload}, '~prte::key::oig::'+pIndexVersion+'::autokey::payload');
				ssn2_IN						:=index(ds_ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {ds_ssn2}, '~prte::key::oig::'+pIndexVersion+'::autokey::ssn2');
				stname_IN					:=index(ds_stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {ds_stname}, '~prte::key::oig::'+pIndexVersion+'::autokey::stname');
				stnameb2_IN				:=index(ds_stnameb2, {st,cname_indic,cname_sec,bdid}, {ds_stnameb2}, '~prte::key::oig::'+pIndexVersion+'::autokey::stnameb2');
				zip_IN						:=index(ds_zip1, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {ds_zip1}, '~prte::key::oig::'+pIndexVersion+'::autokey::zip');
				zipb2_IN					:=index(ds_zipb2, {zip,cname_indic,cname_sec,bdid}, {ds_zipb2}, '~prte::key::oig::'+pIndexVersion+'::autokey::zipb2');
				LinkIDs_IN				:=index(ds_LinkIDs, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_LinkIDs}, '~prte::key::oig::'+pIndexVersion+'::linkids');
				
								
			
															 
return	sequential(
													parallel(		
																build(address_IN			, update),																
																build(addressb2_IN		, update),																
																build(citystname_IN		, update),																
																build(citystnameb2_IN	, update),	
																build(name_IN				  , update),																
																build(nameb2_IN				, update),																
																build(ssn2_IN					, update),																
																build(stname_IN				, update),	
																build(stnameb2_IN			, update),																
																build(zip_IN					, update),																
																build(zipb2_IN				, update),																
																build(payload_IN			, update),
																build(namewords2_IN		, update),
																build(LinkIDs_IN			, update)
															 ),
								
								PRTE.UpdateVersion('OIGKeys',										//	Package name
																pIndexVersion,						//	Package version
																_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																 'B',								//	B = Boca, A = Alpharetta
																 'N',								//	N = Non-FCRA, F = FCRA
																 'N'								//	N = Do not also include boolean, Y = Include boolean, too
																	)
										 );

end;
