﻿import	_control;

export Proc_Build_Equifax_Business_Data_Keys(string pIndexVersion) := function

rKeyEquifax_Business_Data__linkid	:= RECORD
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
  string6 source;
  unsigned6 rcid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned4 dt_effective_first;
  unsigned4 dt_effective_last;
  unsigned4 process_date;
  string1 record_type;
  string10 efx_id;
  string75 efx_name;
  string75 efx_legal_name;
  string75 efx_address;
  string75 efx_city;
  string2 efx_state;
  string2 efx_statec;
  string15 efx_zipcode;
  string4 efx_zip4;
  string15 efx_lat;
  string15 efx_lon;
  string3 efx_geoprec;
  string50 efx_region;
  string3 efx_ctryisocd;
  string10 efx_ctrynum;
  string100 efx_ctryname;
  string100 efx_countynm;
  string3 efx_county;
  string4 efx_cmsa;
  string100 efx_cmsadesc;
  string1 efx_soho;
  string1 efx_biz;
  string1 efx_res;
  string1 efx_cmra;
  string2 efx_congress;
  string75 efx_secadr;
  string75 efx_seccty;
  string2 efx_secstat;
  string2 efx_statec2;
  string15 efx_seczip;
  string4 efx_seczip4;
  string15 efx_seclat;
  string15 efx_seclon;
  string3 efx_secgeoprec;
  string50 efx_secregion;
  string3 efx_secctryisocd;
  string10 efx_secctrynum;
  string100 efx_secctryname;
  string10 efx_ctrytelcd;
  string18 efx_phone;
  string18 efx_faxphone;
  string50 efx_busstat;
  string10 efx_busstatcd;
  string100 efx_web;
  string10 efx_yrest;
  string10 efx_corpempcnt;
  string10 efx_locempcnt;
  string1 efx_corpempcd;
  string1 efx_locempcd;
  string10 efx_corpamount;
  string1 efx_corpamountcd;
  string50 efx_corpamounttp;
  string50 efx_corpamountprec;
  string10 efx_locamount;
  string1 efx_locamountcd;
  string50 efx_locamounttp;
  string50 efx_locamountprec;
  string1 efx_public;
  string1 efx_stkexc;
  string10 efx_tcksym;
  string4 efx_primsic;
  string4 efx_secsic1;
  string4 efx_secsic2;
  string4 efx_secsic3;
  string4 efx_secsic4;
  string250 efx_primsicdesc;
  string250 efx_secsicdesc1;
  string250 efx_secsicdesc2;
  string250 efx_secsicdesc3;
  string250 efx_secsicdesc4;
  string6 efx_primnaicscode;
  string6 efx_secnaics1;
  string6 efx_secnaics2;
  string6 efx_secnaics3;
  string6 efx_secnaics4;
  string250 efx_primnaicsdesc;
  string250 efx_secnaicsdesc1;
  string250 efx_secnaicsdesc2;
  string250 efx_secnaicsdesc3;
  string250 efx_secnaicsdesc4;
  string1 efx_dead;
  string10 efx_deaddt;
  string1 efx_mrkt_telever;
  string10 efx_mrkt_telescore;
  string10 efx_mrkt_totalscore;
  string2 efx_mrkt_totalind;
  string1 efx_mrkt_vacant;
  string1 efx_mrkt_seasonal;
  string1 efx_mbe;
  string1 efx_wbe;
  string1 efx_mwbe;
  string1 efx_sdb;
  string1 efx_hubzone;
  string1 efx_dbe;
  string1 efx_vet;
  string1 efx_dvet;
  string1 efx_8a;
  string10 efx_8aexpdt;
  string1 efx_dis;
  string1 efx_sbe;
  string1 efx_bussize;
  string1 efx_lbe;
  string1 efx_gov;
  string1 efx_fgov;
  string10 efx_gov1057;
  string1 efx_nonprofit;
  string1 efx_merctype;
  string1 efx_hbcu;
  string1 efx_gaylesbian;
  string1 efx_wsbe;
  string1 efx_vsbe;
  string1 efx_dvsbe;
  string30 efx_mwbestatus;
  string1 efx_nmsdc;
  string1 efx_wbenc;
  string1 efx_ca_puc;
  string1 efx_tx_hub;
  string13 efx_tx_hubcertnum;
  string1 efx_gsax;
  string1 efx_caltrans;
  string1 efx_edu;
  string1 efx_mi;
  string1 efx_anc;
  string10 at_cert1;
  string10 at_cert2;
  string10 at_cert3;
  string10 at_cert4;
  string10 at_cert5;
  string10 at_cert6;
  string10 at_cert7;
  string10 at_cert8;
  string10 at_cert9;
  string10 at_cert10;
  string100 at_certdesc1;
  string100 at_certdesc2;
  string100 at_certdesc3;
  string100 at_certdesc4;
  string100 at_certdesc5;
  string100 at_certdesc6;
  string100 at_certdesc7;
  string100 at_certdesc8;
  string100 at_certdesc9;
  string100 at_certdesc10;
  string255 at_certsrc1;
  string255 at_certsrc2;
  string255 at_certsrc3;
  string255 at_certsrc4;
  string255 at_certsrc5;
  string255 at_certsrc6;
  string255 at_certsrc7;
  string255 at_certsrc8;
  string255 at_certsrc9;
  string255 at_certsrc10;
  string50 at_certlev1;
  string50 at_certlev2;
  string50 at_certlev3;
  string50 at_certlev4;
  string50 at_certlev5;
  string50 at_certlev6;
  string50 at_certlev7;
  string50 at_certlev8;
  string50 at_certlev9;
  string50 at_certlev10;
  string30 at_certnum1;
  string30 at_certnum2;
  string30 at_certnum3;
  string30 at_certnum4;
  string30 at_certnum5;
  string30 at_certnum6;
  string30 at_certnum7;
  string30 at_certnum8;
  string30 at_certnum9;
  string30 at_certnum10;
  string19 at_certexp1;
  string19 at_certexp2;
  string19 at_certexp3;
  string19 at_certexp4;
  string19 at_certexp5;
  string19 at_certexp6;
  string19 at_certexp7;
  string19 at_certexp8;
  string19 at_certexp9;
  string19 at_certexp10;
  string19 efx_extract_date;
  string20 efx_merchant_id;
  string10 efx_project_id;
  string1 efx_foreign;
  string19 record_update_refresh_date;
	string10 efx_date_created;
  string100 normcompany_name;
	string1 normcompany_type;
  string1 normaddress_type;
  string75 norm_address;
  string75 norm_city;
  string2 norm_state;
  string2 norm_statec2;
  string15 norm_zip;
  string4 norm_zip4;
  string15 norm_lat;
  string15 norm_lon;
  string3 norm_geoprec;
  string50 norm_region;
  string3 norm_ctryisocd;
  string10 norm_ctrynum;
  string100 norm_ctryname;




  string10 norm_Geo_Precision;
	string9 exploded_desc_Corporate_Amount_Precision;
	string9 exploded_desc_Location_Amount_Precision;
	string8 exploded_desc_Public_Co_Indicator;
	string48 exploded_desc_Stock_Exchange;
	string18 exploded_desc_Telemarketablity_Score;
	string25 exploded_desc_Telemarketablity_Total_Indicator;
	string18 exploded_desc_Telemarketablity_Total_Score;
	string21 exploded_desc_Government1057_Entity;
	string22 exploded_desc_Merchant_Type;	
  string50 exploded_desc_Busstatcd;
	string100 exploded_desc_CMSA;
	string13 exploded_desc_Corpamountcd;
	string50 exploded_desc_Corpamountprec;
	string50 exploded_desc_Corpamounttp;
	string9 exploded_desc_Corpempcd;
	string100 exploded_desc_Ctrytelcd;
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


  string100 clean_company_name;
  string10 clean_phone;
  string10 clean_secondary_phone;

  unsigned8 raw_aid;
  unsigned8 ace_aid;
  string100 prep_addr_line1;
  string50 prep_addr_line_last;
		UNSIGNED4                     clean_date_created                := 0;
		UNSIGNED4                     clean_extract_date                := 0;
		UNSIGNED4                     clean_record_update_refresh_date  := 0;		
		UNSIGNED4 										clean_dead_date                   := 0;
		UNSIGNED4                     clean_expiration_date             := 0;
		UNSIGNED4                     clean_certexp1_date               := 0;
		UNSIGNED4                     clean_certexp2_date               := 0;
		UNSIGNED4                     clean_certexp3_date               := 0;
		UNSIGNED4                     clean_certexp4_date               := 0;
		UNSIGNED4                     clean_certexp5_date               := 0;
		UNSIGNED4                     clean_certexp6_date               := 0;
		UNSIGNED4                     clean_certexp7_date               := 0;
		UNSIGNED4                     clean_certexp8_date               := 0;
		UNSIGNED4                     clean_certexp9_date               := 0;
		UNSIGNED4                     clean_certexp10_date              := 0;
		unsigned4 global_sid := 0;   //this is a unique source ID that will be coming from Orbit.  
																 // The Orbit infrastructure is not available yet.  
																 // In the meantime, when adding the field leave it unpopulated.  
																 // More information will come as the Orbit change moves along.
    unsigned8 record_sid := 0; //this is a source specific unique and persistent record id.  
															 // Same as the persistent record id we have in some datasets.  
															 // In new development using the ingest process, it will be the record id from SALT.  
															 // For CCPA, this field is not required to be populated.  


  integer1 fp;
end;

	ds_linkid						:= dataset([],rKeyEquifax_Business_Data__linkid);
		
	linkid_IN			  		:= index(ds_linkid, 			 {ultid,orgid,seleid,proxid,powid,empid,dotid},
													 {ds_linkid}, 		 '~prct::key::Equifax_Business_Data::'+pIndexVersion+'::linkids');
	
	return	sequential(	
								build(linkid_IN, update),
								
								PRTE.UpdateVersion('EquifaxBusinessDataKeys',				   			//	Package name
																pIndexVersion,											//	Package version
																_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																 'B',																//	B = Boca, A = Alpharetta
																 'N',																//	N = Non-FCRA, F = FCRA
																 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																	)
										 );

end;