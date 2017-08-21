IMPORT _Control;

EXPORT Proc_Build_Zoom_Keys(STRING pIndexVersion) := FUNCTION

	keybuild := RECORD
		STRING14  zoomid;
		STRING50  name_last;
		STRING50  name_first;
		STRING50  name_middle;
		STRING200 name_prefix;
		STRING255 name_suffix;
		STRING255 job_title;
		STRING4   job_title_hierarchy_level;
		STRING255 company_division_name;
		STRING108 phone;
		STRING117 email_address;
		STRING5   source_count;
		STRING10  last_updated_date;
		STRING9   zoom_company_id;
		STRING9   acquiring_company_id;
		STRING9   parent_company_id;
		STRING255 company_name;
		STRING255 company_domain_name;
		STRING30  company_phone;
		STRING255 company_address_street;
		STRING73  company_address_city;
		STRING61  company_address_state;
		STRING27  company_address_postal;
		STRING43  company_address_country;
		STRING73  industry_label;
		STRING34  industry_hierarchical_category;
		STRING71  secondary_industry_label;
		STRING34  secondary_industry_hierarchical_category;
	END;

	xml_keybuild := RECORD
    STRING15  zoomid;
    STRING22  diversity;
    STRING1   education;
    STRING255 education_concentration;
    STRING255 education_degree;
    STRING255 education_institution;
    STRING111 email;
    STRING1   name;
    STRING50  name_first;
    STRING50  name_last;
    STRING50  name_middle;
    STRING205 name_prefix;
    STRING278 name_suffix;
    STRING896 picture;
    STRING1   reference;
    STRING255 reference_url;
    STRING11  reference_pageid;
    STRING10  reference_personid;
    STRING1   reference_sequence;
    STRING255 reference_title;
    STRING1   resume;
    STRING1   resume_address;
    STRING1   resume_affiliation;
    STRING1   resume_company;
    STRING255 resume_company_division;
    STRING15  resume_company_id;
    STRING302 resume_company_value;
    STRING1   resume_past;
    STRING1   resume_primary;
    STRING1   resume_sequence;
    STRING1   resume_title;
    STRING4   resume_title_hierarchy;
    STRING255 resume_title_value;
    STRING5   sourcecount;
  END;

	layout_clean_name := RECORD
		STRING5  title;
		STRING20 fname;
		STRING20 mname;
		STRING20 lname;
		STRING5  name_suffix;
		STRING3  name_score;
	END;

  layout_clean182_fips := RECORD
		STRING10 prim_range;
		STRING2  predir;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  postdir;
		STRING10 unit_desig;
		STRING8  sec_range;
		STRING25 p_city_name;
		STRING25 v_city_name;
		STRING2  st;
		STRING5  zip;
		STRING4  zip4;
		STRING4  cart;
		STRING1  cr_sort_sz;
		STRING4  lot;
		STRING1  lot_order;
		STRING2  dbpc;
		STRING1  chk_digit;
		STRING2  rec_type;
		STRING2  fips_state;
		STRING3  fips_county;
		STRING10 geo_lat;
		STRING11 geo_long;
		STRING4  msa;
		STRING7  geo_blk;
		STRING1  geo_match;
		STRING4  err_stat;
  END;
	
	cleaned_dates := RECORD
		UNSIGNED4 last_updated_date;
	END;

	cleaned_phones := RECORD
		STRING10 phone;
		STRING10 company_phone;
	END;

	rKeyZoom__bdid := RECORD
		UNSIGNED6 bdid;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED1 bdid_score;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		keybuild             rawfields;
		layout_clean_name    clean_contact_name;
		layout_clean182_fips clean_company_address;
		cleaned_dates        clean_dates;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyZoom__did := RECORD
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		keybuild             rawfields;
		layout_clean_name    clean_contact_name;
		layout_clean182_fips clean_company_address;
		cleaned_dates        clean_dates;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyZoom__linkids := RECORD
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
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		keybuild             rawfields;
		layout_clean_name    clean_contact_name;
		layout_clean182_fips clean_company_address;
		cleaned_dates        clean_dates;
		cleaned_phones       clean_phones;
		UNSIGNED8 source_rec_id;
		INTEGER1  fp;
	END;

	rKeyZoom__xmlzoomid := RECORD, MAXLENGTH(20000)
		STRING15  zoomid;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		xml_keybuild      rawfields;
		layout_clean_name clean_contact_name;
		STRING8   clean_ref_last_date;
		STRING8   clean_ref_valid_date;
		STRING8   clean_valid_date;
		STRING10  cleaned_phone;
		UNSIGNED8 __internal_fpos__;
	END;

	rKeyZoom__zoomid := RECORD
	  STRING15  zoomid;
		UNSIGNED6 did;
		UNSIGNED1 did_score;
		UNSIGNED6 bdid;
		UNSIGNED1 bdid_score;
		UNSIGNED8 raw_aid;
		UNSIGNED8 ace_aid;
		UNSIGNED4 dt_first_seen;
		UNSIGNED4 dt_last_seen;
		UNSIGNED4 dt_vendor_first_reported;
		UNSIGNED4 dt_vendor_last_reported;
		STRING1   record_type;
		keybuild             rawfields;
		layout_clean_name    clean_contact_name;
		layout_clean182_fips clean_company_address;
		cleaned_dates        clean_dates;
		cleaned_phones       clean_phones;
		UNSIGNED8 __internal_fpos__;
	END;

  ds_bdid      	:= DATASET([], rKeyZoom__bdid);
  ds_did       	:= DATASET([], rKeyZoom__did);
  ds_linkids   	:= DATASET([], rKeyZoom__linkids);
  ds_xmlzoomid	:= DATASET([], rKeyZoom__xmlzoomid);
  ds_zoomid    	:= DATASET([], rKeyZoom__zoomid);

  bdid_IN				:= INDEX(ds_bdid, {bdid}, {ds_bdid}, '~prte::key::zoom::' + pIndexVersion + '::bdid');	
  did_IN				:= INDEX(ds_did, {did}, {ds_did}, '~prte::key::zoom::' + pIndexVersion + '::did');	
  linkids_IN		:= INDEX(ds_linkids, {ultid, orgid, seleid, proxid, powid, empid, dotid}, {ds_linkids}, '~prte::key::zoom::' + pIndexVersion + '::linkids');	
  xmlzoomid_IN	:= INDEX(ds_xmlzoomid, {zoomid}, {ds_xmlzoomid}, '~prte::key::zoom::' + pIndexVersion + '::xmlzoomid');	
  zoomid_IN			:= INDEX(ds_zoomid, {zoomid}, {ds_zoomid}, '~prte::key::zoom::' + pIndexVersion + '::zoomid');	

	RETURN SEQUENTIAL(PARALLEL(BUILD(bdid_IN, update),
														 BUILD(did_IN, update),
														 BUILD(linkids_IN, update),
														 BUILD(xmlzoomid_IN, update),
														 BUILD(zoomid_IN, update)),
									  PRTE.UpdateVersion('ZoomKeys',										 		 //	Package name
																	     pIndexVersion,											 //	Package version
																	     _control.MyInfo.EmailAddressNormal, //	Who to email with specifics
																	     'B',																 //	B = Boca, A = Alpharetta
																	     'N',																 //	N = Non-FCRA, F = FCRA
																	     'N'																 //	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );
END;