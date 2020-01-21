﻿IMPORT STD, _Control, Prof_License_Mari, SANCTN;
EXPORT ExternalBuildSample := MODULE


EXPORT garnishmentsDsBipExternalBuild(string prefix) := FUNCTION

sprayed := RECORD
   string1 deleteflag;
   string2 entitytype;
   string1 assoccode;
   string7 courtid;
   string2 filetypeid;
   string17 casenumber;
   string6 book;
   string6 page;
   string8 filingdate;
   string8 releasedate;
   string9 amount;
   string9 assets;
   string32 plaintiff;
   string25 attorneyname;
   string10 attorneyphone;
   string8 s341date;
   string3 judgeinit;
   string13 alternatecase;
   string9 ssn;
   string32 defendantname;
   string1 defendantsuffix;
   string32 defendantaddress;
   string24 defendantcity;
   string2 defendantstate;
   string5 defendantzip;
   string8 loaddate;
   string1 detainerflag;
   string17 origcase;
   string6 origbook;
   string6 origpage;
   string32 attorneyaddress;
   string24 attorneycity;
   string2 attorneystate;
   string5 attorneyzip;
   string1 assetsavailable;
   string2 actiontype;
   string4 _341time;
   string5 countyofres;
   string2 origdept;
   string1 dismissalflag;
   string10 rmsid;
   string __filename{maxlength(500)};
  END;

layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

layout_clean182_fips := RECORD
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
  END;

cleaned_dates := RECORD
   unsigned4 filingdate;
   unsigned4 releasedate;
   unsigned4 s341date;
   unsigned4 loaddate;
  END;

cleaned_phones := RECORD
   unsigned5 attorneyphone;
  END;

layout_garnishments := RECORD
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
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 defendant_raw_aid;
  unsigned8 defendant_ace_aid;
  unsigned8 attorney_raw_aid;
  unsigned8 attorney_ace_aid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  sprayed rawfields;
  layout_clean_name clean_defendant_name;
  layout_clean182_fips clean_defendant_address;
  layout_clean182_fips clean_attorney_address;
  cleaned_dates clean_dates;
  cleaned_phones clean_phones;
 END;


ds_garnishments := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::garnishments::data','~thor_data400::base::garnishments::qa::data'), layout_garnishments, thor);

pj_garnishments := project(ds_garnishments, transform(modLayouts.lSrcLayout,
 		SELF.proxid :=left.proxid;
		SELF.seleid :=left.seleid;
		SELF.company_name := std.str.ToUpperCase(left.rawfields.attorneyname);
		SELF.contact_fname := left.clean_defendant_name.fname	;
		SELF.contact_mname := left.clean_defendant_name.mname	;
		SELF.contact_lname := left.clean_defendant_name.lname	;
		SELF.prim_range := left.Clean_attorney_address.prim_range;
		SELF.prim_name := left.Clean_attorney_address.prim_name;
		SELF.sec_range := left.Clean_attorney_address.sec_range;
		SELF.city := left.Clean_attorney_address.p_city_name;
		SELF.state := left.Clean_attorney_address.st;
		SELF.zip5 := left.Clean_attorney_address.zip;
		SELF.src_category := 'GR';
		SELF.dt_last_seen := left.dt_last_seen;
		SELF.phone10 := (string)left.clean_phones.AttorneyPhone;
		SELF := [];));
	
	RETURN	pj_garnishments;
	END;


EXPORT spokeDsBipExternalBuild(string prefix) := FUNCTION

sprayed := RECORD,maxlength(8192)
   string first_name;
   string last_name;
   string job_title;
   string company_name;
   string validation_date;
   string company_street_address;
   string company_city;
   string company_state;
   string company_postal_code;
   string company_phone_number;
   string company_annual_revenue;
   string company_business_description;
   string lf;
  END;

layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

layout_clean182_fips := RECORD
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
  END;

cleaned_dates := RECORD
   unsigned4 validation_date;
  END;

cleaned_phones := RECORD
   string10 company_phone_number;
  END;

layout_spoke := RECORD,maxlength(8192)
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
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  sprayed rawfields;
  layout_clean_name clean_contact_name;
  layout_clean182_fips clean_company_address;
  cleaned_dates clean_dates;
  cleaned_phones clean_phones;
  unsigned4 global_sid;
  unsigned8 record_sid;
 END;

ds_spoke := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::spoke::data','~thor_data400::base::spoke::qa::data'), layout_spoke, thor);

pj_spoke := project(ds_spoke, transform(modLayouts.lSrcLayout,
 		SELF.proxid :=left.proxid;
		SELF.seleid :=left.seleid;
		SELF.company_name := std.str.ToUpperCase(left.rawfields.company_name);
		SELF.contact_fname := left.clean_contact_name.fname;
		SELF.contact_mname := left.clean_contact_name.mname;
		SELF.contact_lname := left.clean_contact_name.lname;
		SELF.prim_range := left.clean_company_address.prim_range;
		SELF.prim_name := left.clean_company_address.prim_name;
		SELF.sec_range := left.clean_company_address.sec_range;
		SELF.city := left.clean_company_address.p_city_name;
		SELF.state := left.clean_company_address.st;
		SELF.zip5 := left.clean_company_address.zip;
		SELF.src_category :='SP';
		SELF.dt_last_seen := left.dt_last_seen;
		SELF.phone10 := left.clean_phones.company_phone_number;
		SELF.contact_did := left.did;
		SELF := [];));	
	
	RETURN pj_spoke;
	END;
	
	EXPORT taxproDsBipExternalBuild(string prefix) := FUNCTION

name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

detailed := RECORD
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
   string10 geo_lat;
   string11 geo_long;
   string4 cbsa;
   string7 geo_blk;
   string1 geo_match;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dpbc;
   string1 chk_digit;
   string4 err_stat;
  END;

layout_taxpro := RECORD
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string10 tmsid;
  string14 source;
  string30 firstnm;
  string15 midinit;
  string30 lastnm;
  string48 company;
  string16 occupation;
  string4 enroll_year;
  string35 addr1;
  string35 addr2;
  string35 addr3;
  string35 city;
  string20 state;
  string20 zip;
  string35 country;
  name name;
  detailed addr;
  string9 ssn;
  unsigned6 did;
  unsigned6 did_score;
  unsigned6 bdid;
  unsigned6 bdid_score;
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
 END;
 
ds_taxpro := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::persist::base::taxpro::copyfrom92','~thor_data400::persist::base::taxpro::copyfrom92'), layout_taxpro, thor);

 pj_taxpro := project(ds_taxpro, transform(modLayouts.lSrcLayout,
 		SELF.proxid :=left.proxid;
		SELF.seleid :=left.seleid;
		SELF.company_name := std.str.ToUpperCase(left.company);
		SELF.contact_fname := left.name.fname;
		SELF.contact_mname := left.name.mname;
		SELF.contact_lname := left.name.lname;
		SELF.contact_ssn := left.ssn;
		SELF.prim_range := left.addr.prim_range;
		SELF.prim_name := left.addr.prim_name;
		SELF.sec_range := left.addr.sec_range;
		SELF.city := left.addr.p_city_name;
		SELF.state:= left.addr.st;
		SELF.zip5 := left.addr.zip5;
		SELF.src_category := '@@';
		SELF.dt_last_seen := left.dt_last_seen;
		SELF.contact_did := left.did;
		SELF := [];));
	
	RETURN	pj_taxpro;
	
	END;

EXPORT thriveDsBipExternalBuild(string prefix) := FUNCTION

layout_thrive := RECORD,maxlength(40000)
  string20 persistent_record_id;
  string2 src;
  unsigned6 dt_first_seen;
  unsigned6 dt_last_seen;
  unsigned6 dt_vendor_first_reported;
  unsigned6 dt_vendor_last_reported;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned6 did;
  unsigned1 did_score;
  string40 orig_fname;
  string40 orig_mname;
  string60 orig_lname;
  string75 orig_addr;
  string40 orig_city;
  string2 orig_state;
  string5 orig_zip5;
  string4 orig_zip4;
  string90 email;
  string50 employer;
  string10 income;
  string20 pay_frequency;
  string20 phone_work;
  string20 phone_home;
  string20 phone_cell;
  string8 dob;
  string4 monthsemployed;
  string1 own_home;
  string1 is_military;
  string2 drvlic_state;
  string4 monthsatbank;
  string25 ip;
  string25 yrsthere;
  string20 besttime;
  string20 credit;
  string15 loanamt;
  string25 loantype;
  string15 ratetype;
  string15 mortrate;
  string10 ltv;
  string25 propertytype;
  string20 datecollected;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  unsigned8 nid;
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
  string2 fips_st;
  string3 fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 rawaid;
  unsigned8 aceaid;
  string10 clean_phone_work;
  string10 clean_phone_home;
  string10 clean_phone_cell;
  string8 clean_dob;
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
 END;

ds_thrive := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::thrive::data','~thor_data400::base::thrive::qa'), layout_thrive, thor);

 pj_thrive := project(ds_thrive, transform(modLayouts.lSrcLayout,
 		SELF.proxid :=left.proxid;
		SELF.seleid :=left.seleid;
		SELF.company_name := std.str.ToUpperCase(left.employer);
		SELF.contact_fname := left.fname;
		SELF.contact_mname := left.mname;
		SELF.contact_lname := left.lname;
		SELF.email := left.email;
		SELF.prim_range := left.prim_range;
		SELF.prim_name := left.prim_name;
		SELF.sec_range := left.sec_range;
		SELF.city := left.p_city_name;
		SELF.state:= left.st;
		SELF.zip5 := left.zip;
		SELF.src_category := '!!';
		SELF.dt_last_seen := left.dt_last_seen;
		SELF.phone10 := left.clean_phone_work;
		SELF.contact_did := left.did;
		SELF := [];));
	
	RETURN	pj_thrive;
  END;
	
	EXPORT vickers13d13gDsBipExternalBuild(string prefix) := FUNCTION

layout_vickers := RECORD
  unsigned6 bdid;
  string20 form_id;
  string15 cusip;
  string5 amend_nbr;
  string5 form_type;
  string80 form_type_desc;
  string30 form_type_alpha;
  string50 form_type_desc2;
  string50 signer_title;
  string70 signer_name;
  string70 contact_name;
  string70 contact_title;
  string70 contact_street;
  string50 contact_street2;
  string50 contact_city;
  string2 contact_state;
  string15 contact_zip;
  string4 contact_zip4;
  string30 contact_phone;
  string2 contact_province;
  string150 contact_province_desc;
  string5 contact_country;
  string80 contact_country_desc;
  string15 filer_id;
  string70 filer_name;
  string8 trans_date_from;
  string8 trans_date_to;
  string15 trans_amount;
  string5 trans_type;
  string80 trans_type_desc;
  string20 trans_type_alpha;
  string50 trans_type_desc2;
  string15 amount_owned;
  string15 sole_vote;
  string15 sole_disp;
  string15 shared_vote;
  string15 shared_disp;
  string10 percent_share_out;
  string50 reporter_type;
  string80 reporter_type_desc;
  string350 comment;
  string3000 summary_text;
  string25 filing_date;
  string8 entered_date;
  string8 upd_date;
  string5 signer_name_prefix;
  string20 signer_name_first;
  string20 signer_name_middle;
  string20 signer_name_last;
  string5 signer_name_suffix;
  string3 signer_name_score;
  string5 contact_name_prefix;
  string20 contact_name_first;
  string20 contact_name_middle;
  string20 contact_name_last;
  string5 contact_name_suffix;
  string3 contact_name_score;
  string5 filer_name_prefix;
  string20 filer_name_first;
  string20 filer_name_middle;
  string20 filer_name_last;
  string5 filer_name_suffix;
  string3 filer_name_score;
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
  string2 record_type;
  string2 ace_fips_st;
  string3 fipscounty;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string1 lf;
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
 END;

ds_vickers_13d13g := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::vickers_13d13g_base::data','~thor_data400::base::vickers_13d13g_base'), layout_vickers, thor);

 pj_vickers_13d13g := project(ds_vickers_13d13g, transform(modLayouts.lSrcLayout,
 		SELF.proxid :=left.proxid;
		SELF.seleid :=left.seleid;
		SELF.company_name := std.str.ToUpperCase(left.filer_name);
		SELF.contact_fname := left.contact_name_first;
		SELF.contact_mname := left.contact_name_middle;
		SELF.contact_lname := left.contact_name_last;
		SELF.prim_range := left.prim_range;
		SELF.prim_name := left.prim_name;
		SELF.sec_range := left.sec_range;
		SELF.city := left.p_city_name;
		SELF.state:= left.st;
		SELF.zip5 := left.zip;
		SELF.src_category := 'V@';
		SELF := [];));
	
  RETURN pj_vickers_13d13g;

  END;


EXPORT vickersDsBipExternalBuild(string prefix) := FUNCTION

layout_vickers := RECORD
  unsigned6 bdid;
  string20 form_id;
  string3 row_nbr;
  string15 cusip;
  string15 filer_id;
  string70 filer_name;
  string70 street;
  string50 street2;
  string50 city;
  string2 state;
  string2 province;
  string5 country;
  string80 country_desc;
  string15 zip_code;
  string4 zip_code4;
  string5 relationship_code;
  string80 relationship_desc;
  string20 relationship_alpha;
  string8 trans_date_from;
  string8 trans_date_to;
  string15 trans_amt;
  string15 market_value;
  string5 trans_amt_type;
  string5 dollar_type;
  string80 dollar_type_desc;
  string20 dollar_type_alpha;
  string5 trans_type;
  string80 trans_type_desc;
  string20 trans_type_alpha;
  string50 trans_type_desc2;
  string15 trans_price_from;
  string15 trans_price_to;
  string15 amt_owned;
  string5 owned_type;
  string5 form_type;
  string80 form_type_desc;
  string20 form_type_alpha;
  string50 form_type_desc2;
  string5 broker_code;
  string8 date_entered;
  string8 upd_date;
  string5 name_prefix;
  string20 name_first;
  string20 name_middle;
  string20 name_last;
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
  string2 dpbc;
  string1 chk_digit;
  string2 record_type;
  string2 ace_fips_st;
  string3 fipscounty;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string2 crlf;
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
 END;

ds_vickers := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::vickers_insider_filing_base::data','~thor_data400::base::vickers_insider_filing_base'), layout_vickers, thor);

 pj_vickers := project(ds_vickers, transform(modLayouts.lSrcLayout,
 		SELF.proxid :=left.proxid;
		SELF.seleid :=left.seleid;
        SELF.company_name := std.str.ToUpperCase(left.filer_name);
		SELF.contact_fname := left.name_first;
		SELF.contact_mname := left.name_middle;
		SELF.contact_lname := left.name_last;
		SELF.prim_range := left.prim_range;
		SELF.prim_name := left.prim_name;
		SELF.sec_range := left.sec_range;
		SELF.city := left.p_city_name;
		SELF.state:= left.st;
		SELF.zip5 := left.zip;
		SELF.src_category := 'V#';
		SELF := [];));
	
		RETURN pj_vickers;
		END;

EXPORT zoomDsBipExternalBuild(string prefix) := FUNCTION

sprayed2 := RECORD,maxlength(4096)
   string zoomid;
   string name_last;
   string name_first;
   string name_middle;
   string name_prefix;
   string name_suffix;
   string job_title;
   string job_title_hierarchy_level;
   string job_function;
   string management_level;
   string company_division_name;
   string phone;
   string email_address;
   string person_street;
   string person_city;
   string person_state;
   string person_zip;
   string person_country;
   string source_count;
   string last_updated_date;
   string zoom_company_id;
   string acquiring_company_id;
   string parent_company_id;
   string company_name;
   string company_domain_name;
   string company_phone;
   string company_address_street;
   string company_address_city;
   string company_address_state;
   string company_address_postal;
   string company_address_country;
   string industry_label;
   string industry_hierarchical_category;
   string secondary_industry_label;
   string secondary_industry_hierarchical_category;
   string revenue;
   string revenue_range;
   string employees;
   string employees_range;
   string sic1;
   string sic2;
   string naics1;
   string naics2;
   string titlecode;
   string highest_level_job_fuction;
   string person_pro_url;
   string encrypted_email_address;
   string email_domain;
   string query_name;
  END;

layout_clean_name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

layout_clean182_fips := RECORD
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
  END;

cleaned_dates := RECORD
   unsigned4 last_updated_date;
  END;

cleaned_phones := RECORD
   string10 phone;
   string10 company_phone;
  END;

layout_zoom := RECORD
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
  unsigned8 person_raw_aid;
  unsigned8 person_ace_aid;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  string1 record_type;
  sprayed2 rawfields;
  layout_clean_name clean_contact_name;
  layout_clean182_fips clean_company_address;
  layout_clean182_fips clean_person_address;
  cleaned_dates clean_dates;
  cleaned_phones clean_phones;
  unsigned8 source_rec_id;
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
  unsigned4 global_sid;
  unsigned8 record_sid;
 END;

ds_zoom := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::zoom::data','~thor_data400::base::zoom::qa::data'), layout_zoom, thor);

pj_zoom := project(ds_zoom, transform(modLayouts.lSrcLayout,
 		SELF.proxid :=left.proxid;
		SELF.seleid :=left.seleid;
		SELF.company_name := std.str.ToUpperCase(left.rawfields.company_name);
		SELF.contact_fname := left.clean_contact_name.fname;
		SELF.contact_mname := left.clean_contact_name.mname;
		SELF.contact_lname := left.clean_contact_name.lname;
		SELF.prim_range := left.clean_company_address.prim_range;
		SELF.prim_name := left.clean_company_address.prim_name;
		SELF.sec_range := left.clean_company_address.sec_range;
		SELF.city := left.clean_company_address.p_city_name;
		SELF.state := left.clean_company_address.st;
		SELF.zip5 := left.clean_company_address.zip;
		SELF.src_category :='ZM';
		SELF.dt_last_seen := left.dt_last_seen;
		SELF.phone10 := left.clean_phones.company_phone;
		SELF.sic_code := left.rawfields.sic1;
		SELF.contact_did := left.did;
		SELF := [];));
	
	RETURN pj_zoom;	
	END;

EXPORT bankruptcyAttorneysDsBipExternalBuild(string prefix) := FUNCTION

layout_bankruptcy := RECORD
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
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  string fullname;
  string firm;
  string email;
  string address;
  string country;
  string city;
  string state;
  string zipcode;
  string phone;
  string fax;
  string lastupdated;
  string10 clean_phone;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string120 company_name;
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
  string2 fips_county;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string1 active_flag;
 END;

ds_bankruptcy := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::bat_attorneys::data','~thor_data400::base::bat::attorneys'), layout_bankruptcy, thor);


pj_bankruptcy := project(ds_bankruptcy, transform(modLayouts.lSrcLayout,
 		SELF.proxid :=left.proxid;
		SELF.seleid :=left.seleid;
		SELF.company_name := std.str.ToUpperCase(left.company_name);
		SELF.contact_fname := left.fname;
		SELF.contact_mname := left.mname;
		SELF.contact_lname := left.lname;
		SELF.email := left.email;
		SELF.prim_range := left.prim_range;
		SELF.prim_name := left.prim_name;
		SELF.sec_range := left.sec_range;
		SELF.city := left.p_city_name;
		SELF.state := left.st;
		SELF.zip5 := left.zip;
		SELF.src_category := 'BY';
		SELF.phone10 := left.clean_phone;
		SELF.contact_did := left.did;
		SELF := [];));
	
	RETURN pj_bankruptcy;
	
	END;

	EXPORT profLicMari(string prefix) := FUNCTION

	dsMari := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::mari_prof_license::data','~thor_data400::base::proflic_mari::search'), Prof_License_Mari.layouts.final, thor);

	modLayouts.lSrcLayout into_temp(dsMari L, INTEGER cnt) := TRANSFORM
 		SELF.proxid := L.proxid;
		SELF.seleid := L.seleid;
		SELF.contact_fname := L.fname	;
		SELF.contact_mname := L.mname	;
		SELF.contact_lname := L.lname	;
		SELF.company_name		:= 	CHOOSE(cnt 	
																				,L.name_company
																				,L.name_company
																				,L.name_company_dba
																				,L.name_company_dba
																				);
																				
		SELF.phone10 					:= 	CHOOSE(cnt
																				,L.phn_mari_1
																				,L.phn_mari_2
																				,L.phn_mari_1
																				,L.phn_mari_2
																					);
				
		SELF.prim_range 		:= 	CHOOSE(cnt 	
																				,l.Bus_prim_range
																				,l.Mail_prim_range
																				,l.Bus_prim_range
																				,l.Mail_prim_range																						
																			   );

		SELF.prim_name 			:= 	CHOOSE(cnt 	
																				,l.Bus_prim_name
																				,l.Mail_prim_name
																				,l.Bus_prim_name
																				,l.Mail_prim_name																						
																			   );

		SELF.sec_range 			:= 	CHOOSE(cnt 	
																				,l.Bus_sec_range
																				,l.Mail_sec_range
																				,l.Bus_sec_range
																				,l.Mail_sec_range																						
																			   );
				
		SELF.city		:=  CHOOSE(cnt 	
																				,l.Bus_p_city_name
																				,l.Mail_p_city_name
																				,l.Bus_p_city_name
																				,l.Mail_p_city_name
																			   );																												 

		SELF.zip5						:= 	CHOOSE(cnt 	
																				,l.Bus_zip5
																				,l.Mail_zip5
																				,l.Bus_zip5
																				,l.Mail_zip5																				
																			   );
																				 
		SELF.state 						:= 	CHOOSE(cnt 	
																				,l.Bus_state
																				,l.Mail_state
																				,l.Bus_state
																				,l.Mail_state																				
																			   );
																				 
		SELF.fein 					:= 	CHOOSE(cnt 	
																				,IF(l.TAX_TYPE_1 = 'E', l.SSN_TAXID_1,'')
																				,IF(l.TAX_TYPE_2 = 'E', l.SSN_TAXID_2,'')
																				,IF(l.TAX_TYPE_1 = 'E', l.SSN_TAXID_1,'')
																				,IF(l.TAX_TYPE_2 = 'E', l.SSN_TAXID_2,'')
																			   );																																	

		SELF.src_category 	:= 'MP';
		SELF.dt_last_seen 	:= (integer)L.date_last_seen;
		SELF.email 					:= L.email;
		SELF.url 						:= L.url;
		SELF								:= [];
		END;

	NormBusNameAddr := NORMALIZE(dsMari,4,into_temp(LEFT,COUNTER));

	fNormBusNameAddr := NormBusNameAddr(company_name != '' or contact_ssn != '' or prim_name != '' or phone10 != '' or city != '' or fein != '');//filter out ones with only contact_name

	dNormBusNameAddr := DEDUP(SORT(fNormBusNameAddr,	company_name,	prim_name,	city,	phone10,	fein,	contact_fname,	contact_mname,	contact_lname,	skew(1)),
																			company_name,	prim_name,	city,	phone10,	fein,	contact_fname,	contact_mname,	contact_lname);

	RETURN dNormBusNameAddr;
END;

	EXPORT SANCTN(string prefix) := FUNCTION

	dsSanctn := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::sanctn::data','~thor_data400::persist::sanctn::party_did_new2'), SANCTN.layout_SANCTN_did, thor);

	pj_Sanctn := project(dsSanctn, transform(modLayouts.lSrcLayout,
										SELF.proxid :=left.proxid;
										SELF.seleid :=left.seleid;
										SELF.company_name := std.str.ToUpperCase(left.cname);
										SELF.contact_fname := left.fname	;
										SELF.contact_mname := left.mname	;
										SELF.contact_lname := left.lname	;
										SELF.prim_range := left.prim_range;
										SELF.prim_name := left.prim_name;
										SELF.sec_range := left.sec_range;
										SELF.city := left.p_city_name;
										SELF.state := left.st;
										SELF.zip5 := left.zip5;
										SELF.src_category := 'S@';
										SELF.contact_ssn := left.ssn_appended;
										SELF.contact_did := left.did;
										SELF.source_record_id := left.source_rec_id;
										SELF := [];
										));
	
		RETURN	pj_Sanctn;
	END;

	EXPORT SANCTN_Mari(string prefix) := FUNCTION
	
	layout_sanctnMari := RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid
  =>
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
  unsigned8 source_rec_id;
  string8 batch;
  string1 dbcode;
  string8 incident_num;
  string7 party_num;
  string sanctions;
  string additional_info;
  string150 party_firm;
  string10 tin;
  string50 name_first;
  string50 name_last;
  string50 name_middle;
  string10 suffix;
  string20 nickname;
  string45 party_position;
  string150 party_employer;
  string9 ssn;
  string8 dob;
  string45 address;
  string45 city;
  string2 state;
  string9 zip;
  string1 party_type;
  integer8 party_key;
  integer8 int_key;
  string20 phone;
  string500 akaname;
  string500 dbaname;
  unsigned8 aid;
  unsigned6 did;
  unsigned6 did_score;
  unsigned6 bdid;
  unsigned6 bdid_score;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  unsigned4 global_sid;
  unsigned8 record_sid;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string150 ename;
  string150 cname;
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
  string10 geo_lat;
  string11 geo_long;
  string4 cbsa;
  string7 geo_blk;
  string1 geo_match;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string4 err_stat;
  integer1 fp;
 END;

	dsSanctn_mari00 := dataset(if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::sanctn_np::data','~thor_data400::key::sanctn::np::qa::party_linkids'), layout_sanctnMari, thor);
	dsSanctn_mari := pull(index(dsSanctn_mari00,{ultid,orgid,seleid,proxid,powid,empid,dotid},{dsSanctn_mari00},if(_Control.ThisEnvironment.Name='Dataland','~thor_data400::base::elert::sanctn_np::data','~thor_data400::key::sanctn::np::qa::party_linkids'))); 

	pj_SanctnMari := project(dsSanctn_mari, transform(bizlinkfull_elert.modLayouts.lSrcLayout,
										SELF.proxid :=left.proxid;
										SELF.seleid :=left.seleid;
										SELF.company_name := std.str.ToUpperCase(left.cname);
										SELF.contact_fname := left.fname	;
										SELF.contact_mname := left.mname	;
										SELF.contact_lname := left.lname	;
										SELF.prim_range := left.prim_range;
										SELF.prim_name := left.prim_name;
										SELF.sec_range := left.sec_range;
										SELF.city := left.p_city_name;
										SELF.state := left.st;
										SELF.zip5 := left.zip5;
										SELF.src_category := 'M@';
										SELF.fein := left.tin;
										SELF.phone10 := left.phone;
										SELF.contact_ssn := left.ssn;
										SELF.contact_did := left.did;
										SELF.source_record_id := left.source_rec_id;
										SELF := [];
										));
	
		RETURN	pj_SanctnMari;
	END;

	EXPORT captureData(unsigned iCountRecs2Pull = 50000, boolean bUseForeign = false) := function
        prefix := if(bUseForeign, '~foreign::'+_Control.IPAddress.prod_thor_dali+'::', '~');

        return garnishmentsDsBipExternalBuild(prefix)[1..iCountRecs2Pull]
             + spokeDsBipExternalBuild(prefix)[1..iCountRecs2Pull]
             + taxproDsBipExternalBuild(prefix)[1..iCountRecs2Pull]
             + thriveDsBipExternalBuild(prefix)[1..iCountRecs2Pull]
             + vickers13d13gDsBipExternalBuild(prefix)[1..iCountRecs2Pull]
             + vickersDsBipExternalBuild(prefix)[1..iCountRecs2Pull]
             + zoomDsBipExternalBuild(prefix)[1..iCountRecs2Pull]
             + bankruptcyAttorneysDsBipExternalBuild(prefix)[1..iCountRecs2Pull]
						 + profLicMari(prefix)[1..iCountRecs2Pull]
             + SANCTN(prefix)[1..iCountRecs2Pull]
						 + SANCTN_Mari(prefix)[1..iCountRecs2Pull];
	END;
END;