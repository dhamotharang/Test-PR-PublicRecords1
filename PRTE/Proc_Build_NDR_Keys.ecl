import	_control;

export Proc_Build_NDR_Keys(string pIndexVersion) := function

rKeyNDR__autokey__addressb2 := RECORD
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

rKeyNDR__autokey__citystnameb2 := RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyNDR__autokey__nameb2 := RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyNDR__autokey__namewords2 := RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyNDR__autokey__payload := RECORD
  unsigned6 fakeid;
  unsigned6 bdid;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string8 date_added;
  string8 date_updated;
  string20 website;
  string4 state;
  string200 business_name;
  string65 business_acronym;
  string250 business_address1;
  string100 business_address2;
  string100 clean_business_address2;
  string100 business_city;
  string100 clean_business_city;
  string2 business_state;
  string5 business_zip_code;
  string4 business_zip_code4;
  string20 business_country;
  string55 business_phone_no;
  string55 business_clean_phone_no;
  string40 business_fax_no;
  string40 business_clean_fax_no;
  string25 business_telex_no;
  string50 business_email_id;
  string90 business_website;
  string3 total_no_liaisons;
  string3 total_no_liaisons_a;
  string3 total_no_liaisons_b;
  string1 total_no_liaisons_c;
  string1700 iso_committee_reference;
  string6500 iso_committee_title;
  string330 iso_committee_type;
  string100 append_mailaddress1;
  string50 append_mailaddresslast;
  unsigned8 append_mailrawaid;
  unsigned8 append_mailaceaid;
  string10 m_prim_range;
  string2 m_predir;
  string28 m_prim_name;
  string4 m_addr_suffix;
  string2 m_postdir;
  string10 m_unit_desig;
  string8 m_sec_range;
  string25 m_p_city_name;
  string25 m_v_city_name;
  string2 m_st;
  string5 m_zip;
  string4 m_zip4;
  string4 m_cart;
  string1 m_cr_sort_sz;
  string4 m_lot;
  string1 m_lot_order;
  string2 m_dbpc;
  string1 m_chk_digit;
  string2 m_rec_type;
  string2 m_fips_state;
  string3 m_fips_county;
  string10 m_geo_lat;
  string11 m_geo_long;
  string4 m_msa;
  string7 m_geo_blk;
  string1 m_geo_match;
  string4 m_err_stat;
  unsigned6 did;
  unsigned6 zero;
 END;

rKeyNDR__autokey__phoneb2 := RECORD
  string7 p7;
  string3 p3;
  string40 cname_indic;
  string40 cname_sec;
  string2 st;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyNDR__autokey__stnameb2:= RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyNDR__autokey__zipb2 := RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyNDR__bdid	:= RECORD
  unsigned6 bdid;
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string8 date_added;
  string8 date_updated;
  string20 website;
  string4 state;
  string200 business_name;
  string65 business_acronym;
  string250 business_address1;
  string100 business_address2;
  string100 clean_business_address2;
  string100 business_city;
  string100 clean_business_city;
  string2 business_state;
  string5 business_zip_code;
  string4 business_zip_code4;
  string20 business_country;
  string55 business_phone_no;
  string55 business_clean_phone_no;
  string40 business_fax_no;
  string40 business_clean_fax_no;
  string25 business_telex_no;
  string50 business_email_id;
  string90 business_website;
  string3 total_no_liaisons;
  string3 total_no_liaisons_a;
  string3 total_no_liaisons_b;
  string1 total_no_liaisons_c;
  string1700 iso_committee_reference;
  string6500 iso_committee_title;
  string330 iso_committee_type;
  string100 append_mailaddress1;
  string50 append_mailaddresslast;
  unsigned8 append_mailrawaid;
  unsigned8 append_mailaceaid;
  string10 m_prim_range;
  string2 m_predir;
  string28 m_prim_name;
  string4 m_addr_suffix;
  string2 m_postdir;
  string10 m_unit_desig;
  string8 m_sec_range;
  string25 m_p_city_name;
  string25 m_v_city_name;
  string2 m_st;
  string5 m_zip;
  string4 m_zip4;
  string4 m_cart;
  string1 m_cr_sort_sz;
  string4 m_lot;
  string1 m_lot_order;
  string2 m_dbpc;
  string1 m_chk_digit;
  string2 m_rec_type;
  string2 m_fips_state;
  string3 m_fips_county;
  string10 m_geo_lat;
  string11 m_geo_long;
  string4 m_msa;
  string7 m_geo_blk;
  string1 m_geo_match;
  string4 m_err_stat;
  unsigned8 __internal_fpos__;
end; 

rKeyNDR__linkids	:= RECORD
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
  unsigned6 date_firstseen;
  unsigned6 date_lastseen;
  string5 dart_id;
  string8 date_added;
  string8 date_updated;
  string20 website;
  string4 state;
  string200 business_name;
  string65 business_acronym;
  string250 business_address1;
  string100 business_address2;
  string100 clean_business_address2;
  string100 business_city;
  string100 clean_business_city;
  string2 business_state;
  string5 business_zip_code;
  string4 business_zip_code4;
  string20 business_country;
  string55 business_phone_no;
  string55 business_clean_phone_no;
  string40 business_fax_no;
  string40 business_clean_fax_no;
  string25 business_telex_no;
  string50 business_email_id;
  string90 business_website;
  string3 total_no_liaisons;
  string3 total_no_liaisons_a;
  string3 total_no_liaisons_b;
  string1 total_no_liaisons_c;
  string1700 iso_committee_reference;
  string6500 iso_committee_title;
  string330 iso_committee_type;
  string100 append_mailaddress1;
  string50 append_mailaddresslast;
  unsigned8 append_mailrawaid;
  unsigned8 append_mailaceaid;
  string10 m_prim_range;
  string2 m_predir;
  string28 m_prim_name;
  string4 m_addr_suffix;
  string2 m_postdir;
  string10 m_unit_desig;
  string8 m_sec_range;
  string25 m_p_city_name;
  string25 m_v_city_name;
  string2 m_st;
  string5 m_zip;
  string4 m_zip4;
  string4 m_cart;
  string1 m_cr_sort_sz;
  string4 m_lot;
  string1 m_lot_order;
  string2 m_dbpc;
  string1 m_chk_digit;
  string2 m_rec_type;
  string2 m_fips_state;
  string3 m_fips_county;
  string10 m_geo_lat;
  string11 m_geo_long;
  string4 m_msa;
  string7 m_geo_blk;
  string1 m_geo_match;
  string4 m_err_stat;
  integer1 fp;
 END;


ds_addressb2		:=dataset([],rKeyNDR__autokey__addressb2);
ds_citystnameb2	:=dataset([],rKeyNDR__autokey__citystnameb2);
ds_nameb2				:=dataset([],rKeyNDR__autokey__nameb2);
ds_namewords2		:=dataset([],rKeyNDR__autokey__namewords2);
ds_payload			:=dataset([],rKeyNDR__autokey__payload);
ds_phoneb2			:=dataset([],rKeyNDR__autokey__phoneb2);
ds_stnameb2			:=dataset([],rKeyNDR__autokey__stnameb2);
ds_zipb2				:=dataset([],rKeyNDR__autokey__zipb2);
ds_bdid					:=dataset([],rKeyNDR__bdid);	
ds_linkids			:=dataset([],rKeyNDR__linkids);									
								
addressb2_IN		:=index(ds_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {ds_addressb2}, '~prte::key::NaturalDisaster_Readiness::'+pIndexVersion+'::autokey::addressb2');
citystnameb2_IN	:=index(ds_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {ds_citystnameb2}, '~prte::key::NaturalDisaster_Readiness::'+pIndexVersion+'::autokey::citystnameb2');
nameb2_IN				:=index(ds_nameb2, {cname_indic,cname_sec,bdid}, {ds_nameb2}, '~prte::key::NaturalDisaster_Readiness::'+pIndexVersion+'::autokey::nameb2');
namewords2_IN		:=index(ds_namewords2, {word,state,seq,bdid}, {ds_namewords2}, '~prte::key::NaturalDisaster_Readiness::'+pIndexVersion+'::autokey::namewords2');
payload_IN			:=index(ds_payload, {fakeid}, {ds_payload}, '~prte::key::NaturalDisaster_Readiness::'+pIndexVersion+'::autokey::payload');
phoneb2_IN			:=index(ds_phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {ds_phoneb2}, '~prte::key::NaturalDisaster_Readiness::' + pIndexVersion + '::autokey::phoneb2');
stnameb2_IN			:=index(ds_stnameb2, {st,cname_indic,cname_sec,bdid}, {ds_stnameb2}, '~prte::key::NaturalDisaster_Readiness::'+pIndexVersion+'::autokey::stnameb2');
zipb2_IN				:=index(ds_zipb2, {zip,cname_indic,cname_sec,bdid}, {ds_zipb2}, '~prte::key::NaturalDisaster_Readiness::'+pIndexVersion+'::autokey::zipb2');
bdid_IN				  :=index(ds_bdid, {bdid}, {ds_bdid}, '~prte::key::NaturalDisaster_Readiness::' + pIndexVersion + '::bdid');	
linkids_IN		  :=index(ds_linkids,{ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_linkids}, '~prte::key::NaturalDisaster_Readiness::' + pIndexVersion + '::linkids');																 
															 
return	sequential(  parallel(  build(addressb2_IN, update),																															
																build(citystnameb2_IN, update),														
																build(nameb2_IN	, update),															
																build(stnameb2_IN, update),																											
																build(zipb2_IN, update),																
																build(payload_IN, update),
																build(namewords2_IN, update),
																build(phoneb2_IN, update),
																build(bdid_IN, update),
																build(linkids_IN, update)
														 ),								
											PRTE.UpdateVersion('NDRKeys',												//	Package name
																				 pIndexVersion,											//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																//	B = Boca, A = Alpharetta
																				 'N',																//	N = Non-FCRA, F = FCRA
																				 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );
end;
