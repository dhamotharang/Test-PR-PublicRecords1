import BIPV2, DCAV2, DNB_DMI, Frandx, bipv2_hrchy, tools, Data_Services;


EXPORT files_HRCHY := module

	// import bipv2_hrchy_dev;  	shared ref := bipv2_hrchy_dev;
														shared ref := bipv2_hrchy;


	/*----------------- Other Inputs to Hrchy Build ------------------------------------------ */
	export lnca := DCAV2.Files().base.companies.qa;
	export duns := DNB_DMI.Files().base.companies.qa;
	export fran := Frandx.files().base.qa;//** NEED TO INCORPORATE THIS FILE TOO

  // export location := Data_Services.Data_Location.Prefix('BIPv2_HRCHY');
  // export location := '~';

	shared filePrefix := '~thor_data400::bipv2_HRCHY::';

	/*----------------- for now, keep the full file separate from micro below ------------------------------------------ */

shared headrec2 := RECORD
  unsigned6 rcid;
  unsigned6 dotid;
  unsigned6 empid;
  unsigned6 powid;
  unsigned6 proxid;
  unsigned6 seleid;
  unsigned6 orgid;
  unsigned6 ultid;
  boolean has_lgid;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  unsigned2 levels_from_top;
  unsigned3 nodes_below;
  unsigned3 nodes_total;
  string1 iscontact;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string1 iscorp;
  string120 company_name;
  string50 company_name_type_raw;
  string50 company_name_type_derived;
  string1 cnp_hasnumber;
  string250 cnp_name;
  string10 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
  unsigned8 company_rawaid;
  unsigned8 company_aceaid;
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
  string250 corp_legal_name;
  string250 dba_name;
  string9 active_duns_number;
  string9 hist_duns_number;
  string9 active_enterprise_number;
  string9 hist_enterprise_number;
  string9 ebr_file_number;
  string30 active_domestic_corp_key;
  string30 hist_domestic_corp_key;
  string30 foreign_corp_key;
  string30 unk_corp_key;
  string2 source;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned6 company_bdid;
  string50 company_address_type_raw;
  string9 company_fein;
  string1 best_fein_indicator;
  string10 company_phone;
  string1 phone_type;
  string60 company_org_structure_raw;
  unsigned4 company_incorporation_date;
  string8 company_sic_code1;
  string8 company_sic_code2;
  string8 company_sic_code3;
  string8 company_sic_code4;
  string8 company_sic_code5;
  string6 company_naics_code1;
  string6 company_naics_code2;
  string6 company_naics_code3;
  string6 company_naics_code4;
  string6 company_naics_code5;
  string6 company_ticker;
  string6 company_ticker_exchange;
  string1 company_foreign_domestic;
  string80 company_url;
  string2 company_inc_state;
  string32 company_charter_number;
  unsigned4 company_filing_date;
  unsigned4 company_status_date;
  unsigned4 company_foreign_date;
  unsigned4 event_filing_date;
  string50 company_name_status_raw;
  string50 company_status_raw;
  unsigned4 dt_first_seen_company_name;
  unsigned4 dt_last_seen_company_name;
  unsigned4 dt_first_seen_company_address;
  unsigned4 dt_last_seen_company_address;
  string34 vl_id;
  boolean current;
  unsigned8 source_record_id;
  unsigned2 phone_score;
  unsigned4 dt_first_seen_contact;
  unsigned4 dt_last_seen_contact;
  unsigned6 contact_did;
  string50 contact_type_raw;
  string50 contact_job_title_raw;
  string9 contact_ssn;
  unsigned4 contact_dob;
  string30 contact_status_raw;
  string60 contact_email;
  string30 contact_email_username;
  string30 contact_email_domain;
  string10 contact_phone;
  string1 from_hdr;
  string35 company_department;
  string50 company_address_type_derived;
  string60 company_org_structure_derived;
  string50 company_name_status_derived;
  string50 company_status_derived;
  string50 contact_type_derived;
  string50 contact_job_title_derived;
  string30 contact_status_derived;
 END;


//on dataland, default is to pull from prod, on prod, pull from prod
	export FILE_HRCY_BASE_LF_FULL_nopersist						:= BIPv2_HRCHY.Files(,tools._constants.isdataland).base.qa    ;
	export FILE_HRCY_BASE_LF_FULL_BUILDING_nopersist	:= BIPv2_HRCHY.Files(,tools._constants.isdataland).base.built ;

	export FILE_HRCY_BASE_LF_FULL_persist						  := FILE_HRCY_BASE_LF_FULL_nopersist					 : persist('thor::persist::BIPV2_Files::files_hrchy.FILE_HRCY_BASE_LF_FULL');
	export FILE_HRCY_BASE_LF_FULL_BUILDING_persist	  := FILE_HRCY_BASE_LF_FULL_BUILDING_nopersist : persist('thor::persist::BIPV2_Files::files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING');

	export FILE_HRCY_BASE_LF_FULL						:= if(tools._constants.isdataland ,FILE_HRCY_BASE_LF_FULL_persist           ,FILE_HRCY_BASE_LF_FULL_nopersist         );
	export FILE_HRCY_BASE_LF_FULL_BUILDING	:= if(tools._constants.isdataland ,FILE_HRCY_BASE_LF_FULL_BUILDING_persist  ,FILE_HRCY_BASE_LF_FULL_BUILDING_nopersist);

	EXPORT KEY_HRCY_PROXID_FULL(dataset(ref.Layouts.lgidr) lt = dataset([], ref.Layouts.lgidr)) :=
	INDEX(
		dedup(lt(lgid > 0, proxid > 0), proxid, lgid, lgid_level, proxid_level_within_lgid, src, all),
		{proxid},
		{lgid, lgid_level, proxid_level_within_lgid, src, biz_type},		//src not here yet, and pretty sure the full build still uses the code below to build the index.  this is just for reading it.
		BIPv2_HRCHY.keynames(pUseOtherEnvironment := tools._Constants.IsDataland).HrchyProxid.qa
	);


	EXPORT KEY_HRCY_LGID_FULL(dataset(ref.Layouts.lgidr) lt = dataset([], ref.Layouts.lgidr)) :=
	INDEX(
		lt(lgid > 0),
		{lgid},
		{lt},
		BIPv2_HRCHY.keynames(pUseOtherEnvironment := tools._Constants.IsDataland).HrchyLgid.qa
	);
	/*----------------- BIPv2 HRCHY - BASE HEADER FILE------------------------------------------ */
	// Logical Filenames
	EXPORT FILE_HRCY_BASE_LF			:= filePrefix + 'base::' + BIPV2.KeySuffix + '::data';

	// BaseFile
	EXPORT FILE_HRCHY_BASE				:= filePrefix + 'base';
	EXPORT DS_HRCHY_BASE   				:= BIPv2_HRCHY.Files().base.qa;

	// Father
	EXPORT FILE_HRCHY_FATHER			:= filePrefix + 'father';
	EXPORT DS_HRCHY_FATHER   			:= BIPv2_HRCHY.Files().base.father;

	// GrandFather
	EXPORT FILE_HRCHY_GRANDFATHER := filePrefix + 'grandfather';
	EXPORT DS_HRCHY_GRANDFATHER		:= BIPv2_HRCHY.Files().base.grandfather;

	/*----------------- BIPv2 HRCHY - INDEXES ------------------------------------------ */
	// Logical Filenames
	EXPORT KEYNAME_HRCY_PROXID_LF			:= filePrefix + 'key::' + BIPV2.KeySuffix + '::proxid';

	// QA
	EXPORT KEYNAME_HRCY_PROXID_QA								:= filePrefix + 'key::proxid_qa';

	// Father
	EXPORT KEYNAME_HRCY_PROXID_Father						:= filePrefix + 'key::proxid_Father';

	// GrandFather
	EXPORT KEYNAME_HRCY_PROXID_GrandFather			:= filePrefix + 'key::proxid_GrandFather';

	EXPORT KEY_HRCY_PROXID_QA(dataset(ref.Layouts.lgidr) lt = dataset([], ref.Layouts.lgidr)) :=
	INDEX(
		dedup(lt(lgid > 0, proxid > 0), proxid, lgid, lgid_level, proxid_level_within_lgid, src, all),
		{proxid},
		{lgid, lgid_level, proxid_level_within_lgid, src, biz_type},
		KEYNAME_HRCY_PROXID_QA//build to lf and read from sf
	);



	// index (perhaps temporary) for proxids that need hrchy patching between data builds
	new := dataset( Data_Services.foreign_prod+'thor_data400::bipv2_hrchy::base::20130330::data',headrec2, thor);
	old := dataset( Data_Services.foreign_prod+'thor_data400::bipv2_hrchy::base::20130212::datab',headrec2, thor);

	newd := dedup(new, proxid, all);
	oldd := dedup(old, proxid, all);

	j :=
	join(
		newd,
		oldd,
		left.proxid = right.proxid and
		(
			left.seleid > right.seleid or
			left.orgid > right.orgid or
			left.ultid > right.ultid
		),
		transform(
			{unsigned6 proxid, unsigned6 old_seleid, unsigned6 new_seleid, unsigned6 old_orgid, unsigned6 new_orgid, unsigned6 old_ultid, unsigned6 new_ultid},
			self.proxid := left.proxid,
			self.new_seleid := left.seleid,
			self.new_orgid := left.orgid,
			self.new_ultid := left.ultid,
			self.old_seleid := right.seleid,
			self.old_orgid := right.orgid,
			self.old_ultid := right.ultid
		)
	);

	j_ddp := dedup(j, proxid, all) : persist('~cemtemp::j_ddp');

	// output(count(j), named('cnt_j'));
	// output(count(j_ddp), named('cnt_j_ddp'));
	// output(enth(j_ddp, 1000), all, named('enth_j_ddp'));

	export key_proxids_needing_update := index(j_ddp, {proxid},{old_seleid,old_orgid,old_ultid},'~thor_data400::key::bizlinkfull::20130330::proxids.needingHrchyUpdate');


	// Logical Filenames
	EXPORT KEYNAME_HRCY_LGID_LF			:= filePrefix + 'key::' + BIPV2.KeySuffix + '::LGID';

	// QA
	EXPORT KEYNAME_HRCY_LGID_QA								:= filePrefix + 'key::LGID_qa';

	// Father
	EXPORT KEYNAME_HRCY_LGID_Father						:= filePrefix + 'key::LGID_Father';

	// GrandFather
	EXPORT KEYNAME_HRCY_LGID_GrandFather			:= filePrefix + 'key::LGID_GrandFather';

	EXPORT KEY_HRCY_LGID_QA(dataset(ref.Layouts.lgidr) lt = dataset([], ref.Layouts.lgidr)) :=
	INDEX(
		lt(lgid > 0),
		{lgid},
		{lt},
		KEYNAME_HRCY_LGID_QA//build to lf and read from sf
	);


	/*-------------------- updateHRCHYSuperFiles ----------------------------------------------------*/
	EXPORT updateHRCHYSuperFiles(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_HRCHY_BASE,
																									 FILE_HRCHY_FATHER,
																									 FILE_HRCHY_GRANDFATHER], inFile, true)
							);
		return action;
	END;
	/*-------------------- updateHRCHYSuperKeys ----------------------------------------------------*/
	EXPORT updateHRCHYSuperKeyProxid(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([KEYNAME_HRCY_PROXID_QA,
																									 KEYNAME_HRCY_PROXID_Father,
																									 KEYNAME_HRCY_PROXID_GrandFather], inFile, true)
							);
		return action;
	END;
	EXPORT updateHRCHYSuperKeyLGID(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([KEYNAME_HRCY_LGID_QA,
																									 KEYNAME_HRCY_LGID_Father,
																									 KEYNAME_HRCY_LGID_GrandFather], inFile, true)
							);
		return action;
	END;

	/*-------------------- updateHRCHYLinkHist ----------------------------------------------------*/
	// NONE

	/*-------------------- updateHRCHYDeleteHist ----------------------------------------------------*/
	// NONE

end;
