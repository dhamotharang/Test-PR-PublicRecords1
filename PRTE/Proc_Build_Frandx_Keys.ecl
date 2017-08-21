import	_control;

export Proc_Build_Frandx_Keys(string pIndexVersion) := function

	rKeyFrandx__bdid	:= RECORD
		unsigned6 bdid;
		unsigned6 dotid;
		unsigned2 dotscore;
		unsigned2 dotweight;
		unsigned6 empid;
		unsigned2 empscore;
		unsigned2 empweight;
		unsigned6 powid;
		unsigned2 powscore;
		unsigned2 powweight;
		unsigned6 proxid;
		unsigned2 proxscore;
		unsigned2 proxweight;
		unsigned6 seleid;
		unsigned2 selescore;
		unsigned2 seleweight;
		unsigned6 orgid;
		unsigned2 orgscore;
		unsigned2 orgweight;
		unsigned6 ultid;
		unsigned2 ultscore;
		unsigned2 ultweight;
		unsigned1 bdid_score;
		unsigned6 did;
		unsigned1 did_score;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		string1 record_type;
		string6 franchisee_id;
		string60 brand_name;
		string6 fruns;
		string60 company_name;
		string56 exec_full_name;
		string50 address1;
		string50 address2;
		string25 city;
		string2 state;
		string5 zip_code;
		string4 zip_code4;
		string10 phone;
		string4 phone_extension;
		string10 secondary_phone;
		string1 unit_flag;
		string2 relationship_code;
		string4 f_units;
		string43 website_url;
		string45 email;
		string30 industry;
		string33 sector;
		string8 industry_type;
		string4 sic_code;
		string8 frn_start_date;
		string6 record_id;
		string20 unit_flag_exp;
		string20 relationship_code_exp;
		string10 clean_phone;
		string10 clean_secondary_phone;
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
		string2 fips_state;
		string3 fips_county;
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
	end; 

	rKeyFrandx__linkid	:= RECORD
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
		unsigned1 bdid_score;
		unsigned6 did;
		unsigned1 did_score;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		string1 record_type;
		string6 franchisee_id;
		string60 brand_name;
		string6 fruns;
		string60 company_name;
		string56 exec_full_name;
		string50 address1;
		string50 address2;
		string25 city;
		string2 state;
		string5 zip_code;
		string4 zip_code4;
		string10 phone;
		string4 phone_extension;
		string10 secondary_phone;
		string1 unit_flag;
		string2 relationship_code;
		string4 f_units;
		string43 website_url;
		string45 email;
		string30 industry;
		string33 sector;
		string8 industry_type;
		string4 sic_code;
		string8 frn_start_date;
		string6 record_id;
		string20 unit_flag_exp;
		string20 relationship_code_exp;
		string10 clean_phone;
		string10 clean_secondary_phone;
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
		string2 fips_state;
		string3 fips_county;
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

	rKeyFrandx__source_rec_id	:= RECORD
		unsigned8 source_rec_id;
		string franchisee_id;
		string fruns;
		unsigned8 __internal_fpos__;
	end;

	ds_bdid							:= dataset([],rKeyFrandx__bdid);	
	ds_linkid						:= dataset([],rKeyFrandx__linkid);
	ds_source_rec_id		:= dataset([],rKeyFrandx__source_rec_id);
	
	bdid_IN				  		:= index(ds_bdid, 				 {bdid},
													 {ds_bdid}, 			 '~prte::key::Frandx::'+pIndexVersion+'::bdid');	
	linkid_IN			  		:= index(ds_linkid, 			 {ultid,orgid,seleid,proxid,powid,empid,dotid},
													 {ds_linkid}, 		 '~prte::key::Frandx::'+pIndexVersion+'::linkids');
	source_rec_id_IN		:= index(ds_source_rec_id,{source_rec_id},
													 {ds_source_rec_id},'~prte::key::Frandx::'+pIndexVersion+'::source_rec_id');
	return	sequential(
										parallel(	build(bdid_IN, update),
															build(linkid_IN, update),
															build(source_rec_id_IN, update)																															
														),
								
								PRTE.UpdateVersion('FrandxKeys',				   					//	Package name
																pIndexVersion,											//	Package version
																_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																 'B',																//	B = Boca, A = Alpharetta
																 'N',																//	N = Non-FCRA, F = FCRA
																 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																	)
										 );

end;