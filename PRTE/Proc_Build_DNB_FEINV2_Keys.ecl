 import	_control;
 
EXPORT Proc_Build_DNB_FEINV2_Keys (string pIndexVersion) := function


	addr := 
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

	export rkey__dnb__feinv2__autokey__addressb2	:=
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

	export rkey__dnb__feinv2__autokey__citystnameb2	:=
	record
		unsigned4 city_code;
		string2 st;
		string40 cname_indic;
		string40 cname_sec;
		unsigned6 bdid;
		unsigned4 lookups;
	end;

  export rkey__dnb__feinv2__autokey__fein2	:=
	record
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
	end;

	export rkey__dnb__feinv2__autokey__nameb2	:=
	record
		string40 cname_indic;
		string40 cname_sec;
		unsigned6 bdid;
		unsigned4 lookups;
	end;

	export rkey__dnb__feinv2__autokey__namewords2	:=
	record
		string40 word;
		string2 state;
		unsigned1 seq;
		unsigned6 bdid;
		unsigned4 lookups;
	end;
	
	export rkey__dnb__feinv2__autokey__payload	:=
	record
	  unsigned6 fakeid;
		string50 clean_cname;
		string50 tmsid;
		string9 fein;
		unsigned6 intbdid;
		addr company_addr;
		unsigned1 zero;
		string1 blank;
		unsigned8 __internal_fpos__;
	end;

	export rkey__dnb__feinv2__autokey__phoneb2	:=
	record
		string7 p7;
		string3 p3;
		string40 cname_indic;
		string40 cname_sec;
		string2 st;
		unsigned6 bdid;
		unsigned4 lookups;
	end;
	
	export rkey__dnb__feinv2__autokey__stnameb2	:=
	record
		string2 st;
		string40 cname_indic;
		string40 cname_sec;
		unsigned6 bdid;
		unsigned4 lookups;
	end;

	export rkey__dnb__feinv2__autokey__zipb2	:=
	record
	  integer4 zip;
		string40 cname_indic;
		string40 cname_sec;
		unsigned6 bdid;
		unsigned4 lookups;
	end;

	export rkey__dnb__feinv2__bdid := { unsigned6 p_bdid, string50 tmsid, unsigned8 __internal_fpos__ };

	export rkey__dnb__feinv2__LinkIDs	:=
	record
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
		string12 bdid;
		string8 date_first_seen;
		string8 date_last_seen;
		string8 date_vendor_first_reported;
		string8 date_vendor_last_reported;
		string50 orig_company_name;
		string50 clean_cname;
		string30 orig_address1;
		string30 orig_address2;
		string20 orig_city;
		string2 orig_state;
		string5 orig_zip5;
		string4 orig_zip4;
		string20 orig_county;
		string9 fein;
		string9 source_duns_number;
		string9 case_duns_number;
		string50 duns_orig_source;
		string2 confidence_code;
		string1 indirect_direct_source_ind;
		string1 best_fein_indicator;
		string120 company_name;
		string120 trade_style;
		string8 sic_code;
		string16 telephone_number;
		string60 top_contact_name;
		string60 top_contact_title;
		string9 hdqtr_parent_duns_number;
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
		unsigned8 raw_aid;
		unsigned8 ace_aid;
		string100 prep_addr_line1;
		string50 prep_addr_line_last;
		unsigned8 source_rec_id;
		integer1 fp;
	end;
	 
	export rkey__dnb__feinv2__tmsid	:=
	record
		string50 tmsid;
		string12 bdid;
		string8 date_first_seen;
		string8 date_last_seen;
		string8 date_vendor_first_reported;
		string8 date_vendor_last_reported;
		string50 orig_company_name;
		string50 clean_cname;
		string30 orig_address1;
		string30 orig_address2;
		string20 orig_city;
		string2 orig_state;
		string5 orig_zip5;
		string4 orig_zip4;
		string20 orig_county;
		string9 fein;
		string9 source_duns_number;
		string50 duns_orig_source;
		string2 confidence_code;
		string1 indirect_direct_source_ind;
		string1 best_fein_indicator;
		string120 company_name;
		string120 trade_style;
		string8 sic_code;
		string16 telephone_number;
		string60 top_contact_name;
		string60 top_contact_title;
		string9 hdqtr_parent_duns_number;
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
		unsigned8 __internal_fpos__;
	end;



export dkey__dnb__feinv2__autokey__addressb2 		:= dataset( [], rkey__dnb__feinv2__autokey__addressb2);
export dkey__dnb__feinv2__autokey__citystnameb2 := dataset( [], rkey__dnb__feinv2__autokey__citystnameb2);
export dkey__dnb__feinv2__autokey__nameb2 			:= dataset( [], rkey__dnb__feinv2__autokey__nameb2);
export dkey__dnb__feinv2__autokey__namewords2 	:= dataset( [], rkey__dnb__feinv2__autokey__namewords2);
export dkey__dnb__feinv2__autokey__payload 			:= dataset( [], rkey__dnb__feinv2__autokey__payload);
export dkey__dnb__feinv2__autokey__phoneb2 			:= dataset( [], rkey__dnb__feinv2__autokey__phoneb2);
export dkey__dnb__feinv2__autokey__fein2 			  := dataset( [], rkey__dnb__feinv2__autokey__fein2);
export dkey__dnb__feinv2__autokey__stnameb2 		:= dataset( [], rkey__dnb__feinv2__autokey__stnameb2);
export dkey__dnb__feinv2__autokey__zipb2 				:= dataset( [], rkey__dnb__feinv2__autokey__zipb2);
export dkey__dnb__feinv2__bdid 									:= dataset( [], rkey__dnb__feinv2__bdid);
export dkey__dnb__feinv2__LinkIDs 							:= dataset( [], rkey__dnb__feinv2__linkIDs);
export dkey__dnb__feinv2__tmsid 							  := dataset( [], rkey__dnb__feinv2__tmsid);

	kKeyDNB__FEINV2__autokey__addressb2					:=	index(dkey__dnb__feinv2__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dkey__dnb__feinv2__autokey__addressb2}, '~prte::key::dnbfein::' + pIndexVersion + '::autokey::addressb2');
	kKeyDNB__FEINV2__autokey__citystnameb2			:=	index(dkey__dnb__feinv2__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dkey__dnb__feinv2__autokey__citystnameb2}, '~prte::key::dnbfein::' + pIndexVersion + '::autokey::citystnameb2');	
	kKeyDNB__FEINV2__autokey__nameb2						:=	index(dkey__dnb__feinv2__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dkey__dnb__feinv2__autokey__nameb2}, '~prte::key::dnbfein::' + pIndexVersion + '::autokey::nameb2');
	kKeyDNB__FEINV2__autokey__namewords2				:=	index(dkey__dnb__feinv2__autokey__namewords2, {word,state,seq,bdid}, {dkey__dnb__feinv2__autokey__namewords2}, '~prte::key::dnbfein::' + pIndexVersion + '::autokey::namewords2');
	kKeyDNB__FEINV2__autokey__payload						:=	index(dkey__dnb__feinv2__autokey__payload, {fakeid}, {dkey__dnb__feinv2__autokey__payload}, '~prte::key::dnbfein::' + pIndexVersion + '::autokey::payload');
	kKeyDNB__FEINV2__autokey__phoneb2						:=	index(dkey__dnb__feinv2__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dkey__dnb__feinv2__autokey__phoneb2}, '~prte::key::dnbfein::' + pIndexVersion + '::autokey::phoneb2');
	kKeyDNB__FEINV2__autokey__fein2             :=  index(dkey__dnb__feinv2__autokey__fein2,{f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dkey__dnb__feinv2__autokey__fein2}, '~prte::key::dnbfein::' + pIndexVersion + '::autokey::fein2');
	kKeyDNB__FEINV2__autokey__stnameb2					:=	index(dkey__dnb__feinv2__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dkey__dnb__feinv2__autokey__stnameb2}, '~prte::key::dnbfein::' + pIndexVersion + '::autokey::stnameb2');
	kKeyDNB__FEINV2__autokey__zipb2							:=	index(dkey__dnb__feinv2__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dkey__dnb__feinv2__autokey__zipb2}, '~prte::key::dnbfein::' + pIndexVersion + '::autokey::zipb2');
	kKeyDNB__FEINV2__bdid												:=	index(dkey__dnb__feinv2__bdid, {p_bdid},{dkey__dnb__feinv2__bdid} ,'~prte::key::dnbfein::' + pIndexVersion + '::bdid' );
  kKeyDNB__FEINV2__LinkIDs										:=	index(dkey__dnb__feinv2__linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkey__dnb__feinv2__linkids}, '~prte::key::dnbfein::' + pIndexVersion + '::linkids');																 
	kKeyDNB__FEINV2__tmsid											:=	index(dkey__dnb__feinv2__tmsid, {TMSID},{dkey__dnb__feinv2__tmsid}, '~prte::key::dnbfein::' + pIndexVersion + '::tmsid' );

	return	sequential(
											parallel(													
																build(kKeyDNB__FEINV2__autokey__addressb2		, update),														
																build(kKeyDNB__FEINV2__autokey__citystnameb2, update),																							
																build(kKeyDNB__FEINV2__autokey__nameb2			, update),
																build(kKeyDNB__FEINV2__autokey__namewords2	, update),
																build(kKeyDNB__FEINV2__autokey__payload			, update),																
																build(kKeyDNB__FEINV2__autokey__phoneb2			, update),
																build(kKeyDNB__FEINV2__autokey__fein2			  , update),
																build(kKeyDNB__FEINV2__autokey__stnameb2		, update),																
																build(kKeyDNB__FEINV2__autokey__zipb2				, update),
																build(kKeyDNB__FEINV2__bdid					    		, update),																																
															  build(kKeyDNB__FEINV2__linkIDs				   		, update),
															  build(kKeyDNB__FEINV2__tmsid				   		  , update)
															 ),
										PRTE.UpdateVersion('DNBFEINV2Keys',										    //Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
											);

end;