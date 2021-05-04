IMPORT _Control, PRTE2_Common, Census_Data, PromoteSupers, std, tools, ut, RoxieKeyBuild;

fileVersion := (string)std.date.CurrentDate()+'';

// Layout definitions
Layout_Base := RECORD
    UNSIGNED6   LexId;
    STRING2     ADDR_IND;
    STRING2		phone_ind;
    STRING2		email_ind;
    UNSIGNED6   UniqueRID;
    STRING      bug_num;  			// New column  ( Bug number would be the Jira Ticket to be added new test cases )
    STRING      xVendorCode;   		// New column  ( This would be Experian / Equifax / TransUnion )
    STRING      xSponsorCode;		// Modifying the sponsor code length to string 
    STRING6     xAmbestNumber;
    STRING20    FIRST_NAME;
    STRING20    MIDDLE_NAME;
    STRING28    LAST_NAME;
    STRING5     NAME_SUFFIX;
    STRING8     DOB;
    STRING9     SSN;
    STRING1     GENDER;
    STRING100   STREET_ADDRESS;
    STRING25    CITY;
    STRING2     STATE;
    STRING5     ZIP5;
    STRING4     xZip4;
    STRING2     DL_STATE;
    STRING25    DL_NUMBER;
    STRING8     DOD;
    STRING8     DATE_FIRST_SEEN;
    STRING8     DATE_LAST_SEEN;
    STRING10    PHONE;
    STRING1     PHONE_TYPE;
    STRING      EMAIL;
    STRING1     EMAIL_TYPE;
    QSTRING50   LICENSE_CLASS;
    QSTRING50   LICENSE_TYPE;
    QSTRING50   STATUS;
    STRING8     LICENSE_ISSUE_DATE;
    STRING8     LICENSE_EXPIRATION_DATE;
    STRING50    RESTRICTIONS;
    QSTRING50   LIC_ENDORSEMENT := '';
    STRING8     ORIG_ISSUE_DATE := '';
    STRING3     CDL_STATUS;
    QSTRING3    HEIGHT;
    QSTRING3    HAIR_COLOR;
    QSTRING3    EYE_COLOR;
    QSTRING3    WEIGHT;
    STRING8     ORIG_ORIGCDLDATE := '';
    STRING15    ORIG_COUNTY := '';
    STRING1     ORIG_HABITUALOFFENDER := '';
    STRING1     SCHOOL_BUS_PHYSICAL_TYPE;
    UNSIGNED4   SCHOOL_BUS_PHYSICAL_EXPDATE;
    STRING10    CUST_TEST_DATA_TYPE;
    STRING1     AGE_DATA_FLAG;
    STRING1     HAS_SECURITY_FREEZE;
    STRING10    CONSUMER_NUMBER;
    STRING2     INSURANCE_TYPE:='PA';
    STRING      LN_PRODUCT_TIE := '';
    STRING      LN_PRODUCT_NOTES := '';
    STRING      cust_name;   // New Column  ( This would be IN_PR for those records to be added in Boca Header )
    STRING      Boca_Clash;
END;

Layout_InsHead := RECORD
    INTEGER			id;
    UNSIGNED6		RID;
    STRING2 		ADDR_IND;
    STRING2 		phone_ind;
    STRING2			email_ind;
    STRING9			fb_ssn;
    STRING30		fb_first_name;
    STRING20		fb_mid_name;
    STRING30		fb_last_name;
    STRING30		fb_2lst_name; 
    STRING20		fb_sfx_name;
    STRING20		fb_house_num;
    STRING2     	fb_predir;	// Added in Aug 2015
    STRING30		fb_street;
    STRING20		fb_stsfx;
    STRING2    	 	fb_postdir; // Added in Aug 2015
    STRING20		fb_unit_name;
    STRING20		fb_unit_no;
    STRING30		fb_city;
    STRING5			fb_state;
    STRING5			fb_zip;
    STRING4			fb_zip4;
    STRING4 		fb_err_stat;  // Added in Aug 2015
    STRING3			fb_gender;
    STRING8			fb_dob;
    STRING30		fb_dln;
    STRING2			fb_dlstate;
    STRING20		fb_dln_type;										
    STRING1628 		fb_other;
    STRING8   		fb_loaddt;
    STRING4   		fb_score;
    UNSIGNED6 		fb_seq;
    STRING1   		fb_rest;
    STRING8 		fb_first_dt;
    STRING8			fb_last_dt;
    STRING10    	PHONE;
    STRING1      	PHONE_TYPE;
    STRING      	EMAIL;
    STRING1      	EMAIL_TYPE;
    STRING9			fb_src := '';
    STRING2			INSURANCE_TYPE:='PA';
END;

// Remote read Alpha IHDR
IHDR_InsHead := DATASET('~foreign::' + _Control.IPAddress.aprod_thor_dali + '::'+'thor::base::ct::InsHeadDLDeath::qa::InsHead', Layout_InsHead, THOR);
IHDR_Main := DATASET('~foreign::' + _Control.IPAddress.aprod_thor_dali + '::'+'thor::base::ct::InsHeadDLDeath::qa::alldata', Layout_Base, THOR);
IHDR_Ins_Filtered := IHDR_InsHead(ADDR_IND='1' AND fb_src<>'ICA');

// Remove Boca clashing SSNs
IHDR_Ins_Filtered_No_Clash := JOIN(IHDR_Ins_Filtered,IHDR_Main(Boca_Clash='SSN'),
											LEFT.id = RIGHT.lexid,
											TRANSFORM({RECORDOF(IHDR_Ins_Filtered)},
											SELF := LEFT), LEFT ONLY
											);

// Transform data to prct::base::ct::alpharetta::qa::peopleheader_base layout
IHDR_SSN_No_Clash_Transformed := PROJECT(IHDR_Ins_Filtered_No_Clash,TRANSFORM({Layouts.Base_Layout},
    Street_Address := TRIM(TRIM(LEFT.fb_house_num)+' '+TRIM(LEFT.fb_predir)+' '+TRIM(LEFT.fb_street)+' '+TRIM(LEFT.fb_stsfx)+' '+TRIM(LEFT.fb_postdir)+' '+TRIM(LEFT.fb_unit_name)+' '+TRIM(LEFT.fb_unit_no));
    cleanAddress := PRTE2_Common.Clean_Address.FromLine(Street_Address, LEFT.fb_city, LEFT.fb_state, LEFT.fb_zip, LEFT.fb_zip4);
    SELF.s_did := LEFT.id;
	SELF.did := LEFT.id;
	SELF.rid := LEFT.RID;
	SELF.pflag1 := '';
	SELF.pflag2 := '';
	SELF.pflag3 := '';
	SELF.src := LEFT.fb_src;
    timestamp := PRTE2_Common.Constants.TodayString;
	SELF.dt_first_seen := (unsigned3)LEFT.fb_first_dt[1..6];
	SELF.dt_last_seen := (unsigned3)(timestamp[1..6]);
	SELF.dt_vendor_last_reported := 0;
	SELF.dt_vendor_first_reported := 0;
	SELF.dt_nonglb_last_seen := 0;
	SELF.rec_type := cleanAddress.rec_type;
	SELF.vendor_id := 'IN_PR';
	SELF.phone := LEFT.phone;
	SELF.ssn := LEFT.fb_ssn;
	SELF.dob := (INTEGER)LEFT.fb_dob;
	SELF.title := '';
	SELF.fname := LEFT.fb_first_name;
	SELF.mname := LEFT.fb_mid_name;
	SELF.lname := LEFT.fb_last_name;
	SELF.name_suffix := LEFT.fb_sfx_name;
	SELF.prim_range := LEFT.fb_house_num;
	SELF.predir := LEFT.fb_predir;
	SELF.prim_name := LEFT.fb_street;
	SELF.suffix := LEFT.fb_stsfx;
	SELF.postdir := LEFT.fb_postdir;
	SELF.unit_desig := LEFT.fb_unit_name;
	SELF.sec_range := LEFT.fb_unit_no;
	SELF.city_name := LEFT.fb_city;
	SELF.st := LEFT.fb_state;
	SELF.zip := LEFT.fb_zip;
	SELF.zip4 := LEFT.fb_zip4;
	SELF.county := cleanAddress.fips_county;
	SELF.geo_blk := cleanAddress.geo_blk;
	SELF.cbsa := IF(cleanAddress.msa!='',cleanAddress.msa + '0','');
	SELF.tnt := '';
	SELF.valid_ssn := '';
	SELF.jflag1 := '';
	SELF.jflag2 := '';
	SELF.jflag3 := '';
    SELF.rawaid := 0;
	SELF.valid_dob := '';
	SELF.hhid := LEFT.id;
    county_lookup := Census_Data.Key_Fips2County(state_code=LEFT.fb_state,county_fips=cleanAddress.fips_county);
	SELF.county_name := IF(EXISTS(county_lookup),county_lookup[1].county_name,'');
	SELF.listed_name := '';
	SELF.listed_phone := LEFT.phone;
	SELF.dod := 0;
	SELF.death_code := '';
	SELF.lookup_did := 0;
    SELF.addr_suffix := LEFT.fb_stsfx;
    SELF.p_city_name := cleanAddress.p_city_name;
    SELF.v_city_name := cleanAddress.v_city_name;
    SELF.cart := cleanAddress.cart;
    SELF.cr_sort_sz := cleanAddress.cr_sort_sz;
    SELF.lot := cleanAddress.lot;
    SELF.lot_order := cleanAddress.lot_order;
    SELF.dbpc := cleanAddress.dbpc;
    SELF.chk_digit := cleanAddress.chk_digit;
    SELF.geo_lat := cleanAddress.geo_lat;
    SELF.geo_long := cleanAddress.geo_long;
    SELF.msa := cleanAddress.msa;
    SELF.geo_match := cleanAddress.geo_match;
    SELF.err_stat := cleanAddress.err_stat;
    SELF.uid := LEFT.id;
    SELF.dph_lname := metaphonelib.DMetaPhone1(LEFT.fb_last_name);
    SELF.l4 := LEFT.fb_last_name[1..4];
    SELF.f3 := LEFT.fb_first_name[1..3];
    SELF.s1 := LEFT.fb_ssn[1];
    SELF.s2 := LEFT.fb_ssn[2];
    SELF.s3 := LEFT.fb_ssn[3];
    SELF.s4 := LEFT.fb_ssn[4];
    SELF.s5 := LEFT.fb_ssn[5];
    SELF.s6 := LEFT.fb_ssn[6];
    SELF.s7 := LEFT.fb_ssn[7];
    SELF.s8 := LEFT.fb_ssn[8];
    SELF.s9 := LEFT.fb_ssn[9];
    SELF.ssn4 := LEFT.fb_ssn[6..9];
    SELF.ssn5 := LEFT.fb_ssn[1..5];
    SELF.city_code := HASH64((qstring25)LEFT.fb_city);
    SELF.pfname := LEFT.fb_first_name[1];
    SELF.minit := LEFT.fb_mid_name[1];
    SELF.yob := (INTEGER)LEFT.fb_dob[1..4];
    SELF.states := 0;
    SELF.lname1 := 0;
    SELF.lname2 := 0;
    SELF.lname3 := 0;
    SELF.city1 := 0;
    SELF.city2 := 0;
    SELF.city3 := 0;
    SELF.rel_fname1 := 0;
    SELF.rel_fname2 := 0;
    SELF.rel_fname3 := 0;
    SELF.fname_count := 0;
    SELF.p7 := '';
    SELF.p3 := '';
    SELF.person1 := 0;
    SELF.same_lname := true;
    SELF.number_cohabits := 0;
    SELF.recent_cohabit := 0;
    SELF.person2 := 0;
    SELF.zero := 0;
    SELF.lookups := 0;
    SELF.addr_dt_last_seen := 0;
    SELF.prpty_deed_id := '';
    SELF.vehicle_vehnum := '';
    SELF.bkrupt_crtcode_caseno := '';
    SELF.main_count := 0;
    SELF.search_count := 0;
    SELF.dl_number := LEFT.fb_dln;
    SELF.bdid := '';
    SELF.run_date := 0;
    SELF.total_records := 0;
    SELF.addr_dt_first_seen := 0;
    SELF.adl_ind := '';
    SELF.s_ssn := (STRING)LEFT.fb_ssn;
    SELF.cnt := 0;
    SELF.cellphone := FALSE;
    SELF.persistent_record_ID:=0;
    SELF.rtitle := 0;
    SELF := LEFT;
    SELF := [];
    ));

RoxieKeyBuild.Mac_SF_BuildProcess_V2(IHDR_SSN_No_Clash_Transformed,
    Files.Base_Prefix, 
    Files.Base_Name,
    fileVersion, buildHDRBase, 3,
    false,true
);

SEQUENTIAL(buildHDRBase);
//TODO: automate for monday nights
//TODO: Add phone/email in future project