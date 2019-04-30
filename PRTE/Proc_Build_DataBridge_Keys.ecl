import	_control;

export Proc_Build_DataBridge_Keys(STRING pIndexVersion) := function

	rKeyDataBridge__linkid	:= RECORD
		UNSIGNED6 ultid;
		UNSIGNED6 orgid;
		UNSIGNED6 seleid;
		UNSIGNED6 proxid;
		UNSIGNED6 powid;
		UNSIGNED6 empid;
		UNSIGNED6 dotid;
		UNSIGNED2 ultscore;
		UNSIGNED2 orgscore;
		UNSIGNED2 selescore;
		UNSIGNED2 proxscore;
		UNSIGNED2 powscore;
		UNSIGNED2 empscore;
		UNSIGNED2 dotscore;
		UNSIGNED2 ultweight;
		UNSIGNED2 orgweight;
		UNSIGNED2 seleweight;
		UNSIGNED2 proxweight;
		UNSIGNED2 powweight;
		UNSIGNED2 empweight;
		UNSIGNED2 dotweight;
		STRING6   source;
		UNSIGNED4 global_sid;
		UNSIGNED8 record_sid;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		UNSIGNED4 process_date;
		STRING1   record_type;
		STRING100 clean_company_name;
		STRING3   clean_area_code;
		string10  clean_telephone_num;
		STRING13  mail_score_desc;
		STRING9   name_gender_desc;
		STRING40  title_desc_1;
		STRING40  title_desc_2;
		STRING40  title_desc_3;
		STRING40  title_desc_4;
		STRING50  web_address1;
		STRING50  web_address2;
		STRING50  web_address3;
		STRING75  sic8_desc_1;
		STRING75  sic8_desc_2;
		STRING75  sic8_desc_3;
		STRING75  sic8_desc_4;
		STRING75  sic6_desc_1;
		STRING75  sic6_desc_2;
		STRING75  sic6_desc_3;
		STRING75  sic6_desc_4;
		STRING75  sic6_desc_5;
		STRING50  email1;
		STRING50  email2;
		STRING50  email3;
		STRING30  name;
		STRING50  company;
		STRING30  address;
		STRING30  address2;
		STRING20  city;
		STRING2   state;
		STRING3   scf;
		STRING5   zip;
		STRING4   zip4;
		STRING1   mail_score;
		STRING3   area_code;
		STRING10  telephone_number;
		STRING1   name_gender;
		STRING10  name_prefix;
		STRING20  name_first;
		STRING1   name_middle_initial;
		STRING20  name_last;
		STRING10  suffix;
		STRING4   title_code_1;
		STRING4   title_code_2;
		STRING4   title_code_3;
		STRING4   title_code_4;
		STRING8   sic8_1;
		STRING8   sic8_2;
		STRING8   sic8_3;
		STRING8   sic8_4;
		STRING6   sic6_1;
		STRING6   sic6_2;
		STRING6   sic6_3;
		STRING6   sic6_4;
		STRING6   sic6_5;
		STRING6   transaction_date;
		STRING10  database_site_id;
		STRING10  database_individual_id;
		STRING1   email_present_flag;
		STRING1   site_source1;
		STRING1   site_source2;
		STRING1   site_source3;
		STRING1   site_source4;
		STRING1   site_source5;
		STRING1   site_source6;
		STRING1   site_source7;
		STRING1   site_source8;
		STRING1   site_source9;
		STRING1   site_source10;
		STRING1   individual_source1;
		STRING1   individual_source2;
		STRING1   individual_source3;
		STRING1   individual_source4;
		STRING1   individual_source5;
		STRING1   individual_source6;
		STRING1   individual_source7;
		STRING1   individual_source8;
		STRING1   individual_source9;
		STRING1   individual_source10;
		STRING7   email_status;
		STRING5   title;
		STRING20  fname;
		STRING20  mname;
		STRING20  lname;
		STRING5   name_suffix;
		STRING3   name_score;
		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   addr_suffix;
		STRING2   postdir;
		STRING10  unit_desig;
		STRING8   sec_range;
		STRING25  p_city_name;
		STRING25  v_city_name;
		STRING2   st;
		STRING4   cart;
		STRING1   cr_sort_sz;
		STRING4   lot;
		STRING1   lot_order;
		STRING2   dbpc;
		STRING1   chk_digit;
		STRING2   rec_type;
		STRING2   fips_state;
		STRING3   fips_county;
		STRING10  geo_lat;
		STRING11  geo_long;
		STRING4   msa;
		STRING7   geo_blk;
		STRING1   geo_match;
		STRING4   err_stat;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		STRING100 prep_address_line1;
		STRING50  prep_address_line_last;
		INTEGER1  fp;
	end;

	ds_linkid						:= dataset([],rKeyDataBridge__linkid);
		
	linkid_IN			  		:= index(ds_linkid, 			 {ultid,orgid,seleid,proxid,powid,empid,dotid},
													 {ds_linkid}, 		 '~prte::key::DataBridge::'+pIndexVersion+'::linkids');
	
	return	sequential(	
								build(linkid_IN, update),
								
								PRTE.UpdateVersion('DataBridgeKeys',				   		//	Package name
																pIndexVersion,											//	Package version
																_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																 'B',																//	B = Boca, A = Alpharetta
																 'N',																//	N = Non-FCRA, F = FCRA
																 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																	)
										 );

end;