import	_control;

export Proc_Build_WorkersCompensation_Keys(string pIndexVersion) := function

rKeyWorkersCompensation__autokey__addressb2 := RECORD
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

rKeyWorkersCompensation__autokey__citystnameb2 := RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyWorkersCompensation__autokey__fein2 := RECORD
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
 
rKeyWorkersCompensation__autokey__nameb2 := RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyWorkersCompensation__autokey__namewords2 := RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyWorkersCompensation__autokey__payload := RECORD
  unsigned6 fakeid;
  unsigned8 date_firstseen;
  unsigned8 date_lastseen;
  unsigned6 bdid;
  string15 master_uid;
  string15 unique_id;
  string15 rmid;
  string100 description;
  string100 address;
  string50 city;
  string2 state;
  string5 zip;
  string4 zipplus4;
  string15 classcode;
  string5 effective_month_day;
  string2 effectivemonth;
  string8 effective_date;
  string100 naiccarriername;
  string15 naiccarriernumber;
  string100 naicgroupname;
  string15 naicgroupnumber;
  string30 fein;
  string30 policyself;
  string5 record_type;
  string2 insured_status;
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

rKeyWorkersCompensation__autokey__stnameb2:= RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyWorkersCompensation__autokey__zipb2 := RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyWorkersCompensation__bdid	:= RECORD
  unsigned6 bdid;
  unsigned8 date_firstseen;
  unsigned8 date_lastseen;
  string15 master_uid;
  string15 unique_id;
  string15 rmid;
  string100 description;
  string100 address;
  string50 city;
  string2 state;
  string5 zip;
  string4 zipplus4;
  string15 classcode;
  string5 effective_month_day;
  string2 effectivemonth;
  string8 effective_date;
  string100 naiccarriername;
  string15 naiccarriernumber;
  string100 naicgroupname;
  string15 naicgroupnumber;
  string30 fein;
  string30 policyself;
  string5 record_type;
	string2 insured_status;
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

rKeyWorkersCompensation__linkids	:= RECORD
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
  unsigned8 date_firstseen;
  unsigned8 date_lastseen;
  unsigned6 bdid;
  string15 master_uid;
  string15 unique_id;
  string15 rmid;
  string100 description;
  string100 address;
  string50 city;
  string2 state;
  string5 zip;
  string4 zipplus4;
  string15 classcode;
  string5 effective_month_day;
  string2 effectivemonth;
  string8 effective_date;
  string100 naiccarriername;
  string15 naiccarriernumber;
  string100 naicgroupname;
  string15 naicgroupnumber;
  string30 fein;
  string30 policyself;
  string5 record_type;
  string2 insured_status;
  string100 append_mailaddress1;
  string50 append_mailaddresslast;
  unsigned8 append_mailrawaid;
  unsigned8 append_mailaceaid;
  integer1 fp;
end; 

ds_addressb2		:=dataset([],rKeyWorkersCompensation__autokey__addressb2);
ds_citystnameb2	:=dataset([],rKeyWorkersCompensation__autokey__citystnameb2);
ds_fein2  			:=dataset([],rKeyWorkersCompensation__autokey__fein2);
ds_nameb2				:=dataset([],rKeyWorkersCompensation__autokey__nameb2);
ds_namewords2		:=dataset([],rKeyWorkersCompensation__autokey__namewords2);
ds_payload			:=dataset([],rKeyWorkersCompensation__autokey__payload);
ds_stnameb2			:=dataset([],rKeyWorkersCompensation__autokey__stnameb2);
ds_zipb2				:=dataset([],rKeyWorkersCompensation__autokey__zipb2);
ds_bdid					:=dataset([],rKeyWorkersCompensation__bdid);
ds_linkids			:=dataset([],rKeyWorkersCompensation__linkids);	
								
addressb2_IN		:=index(ds_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {ds_addressb2}, '~prte::key::Workers_Compensation::'+pIndexVersion+'::autokey::addressb2');
citystnameb2_IN	:=index(ds_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {ds_citystnameb2}, '~prte::key::Workers_Compensation::'+pIndexVersion+'::autokey::citystnameb2');
fein2_IN        :=index(ds_fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {ds_fein2}, '~prte::key::Workers_Compensation::'+pIndexVersion+'::autokey::fein2');
nameb2_IN				:=index(ds_nameb2, {cname_indic,cname_sec,bdid}, {ds_nameb2}, '~prte::key::Workers_Compensation::'+pIndexVersion+'::autokey::nameb2');
namewords2_IN		:=index(ds_namewords2, {word,state,seq,bdid}, {ds_namewords2}, '~prte::key::Workers_Compensation::'+pIndexVersion+'::autokey::namewords2');
payload_IN			:=index(ds_payload, {fakeid}, {ds_payload}, '~prte::key::Workers_Compensation::'+pIndexVersion+'::autokey::payload');
stnameb2_IN			:=index(ds_stnameb2, {st,cname_indic,cname_sec,bdid}, {ds_stnameb2}, '~prte::key::Workers_Compensation::'+pIndexVersion+'::autokey::stnameb2');
zipb2_IN				:=index(ds_zipb2, {zip,cname_indic,cname_sec,bdid}, {ds_zipb2}, '~prte::key::Workers_Compensation::'+pIndexVersion+'::autokey::zipb2');
bdid_IN				  :=index(ds_bdid, {bdid}, {ds_bdid}, '~prte::key::Workers_Compensation::' + pIndexVersion + '::bdid');	
linkids_IN			:=index(ds_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {ds_linkids}, '~prte::key::Workers_Compensation::' + pIndexVersion + '::linkids');	
															 
return	sequential(
										parallel(												
																build(addressb2_IN, update),																															
																build(citystnameb2_IN, update),
																build(fein2_IN, update),
																build(nameb2_IN	, update),															
																build(stnameb2_IN, update),																											
																build(zipb2_IN, update),																
																build(payload_IN, update),
																build(namewords2_IN, update),
																build(bdid_IN, update),
																build(linkids_IN, update)
															 ),
								
								PRTE.UpdateVersion('WorkersCompensationKeys',				//	Package name
																pIndexVersion,											//	Package version
																_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																 'B',																//	B = Boca, A = Alpharetta
																 'N',																//	N = Non-FCRA, F = FCRA
																 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																	)
										 );
end;
