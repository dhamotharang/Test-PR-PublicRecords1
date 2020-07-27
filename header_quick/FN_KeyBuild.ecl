IMPORT header, doxie, autokey, autokeyb, RoxieKeyBuild, header_services, risk_indicators, mdr,aid,PromoteSupers, DriversV2, suppress;

EXPORT FN_KeyBuild(
	DATASET(header.Layout_Header) header_in0, 
	STRING filedate
) := FUNCTION

	//***//***//***//*** SUPPRESSION CODE - CNG 20070417 - W20070417-161923 & W20070417-164348 ***//***//***//***//

	RECORDOF(header_in0) t_set_src(recordof(header_in0) le) := TRANSFORM
 		self.src := if(le.src='WH','WH', if(le.src= 'EQ', 'QH', le.src));
 		self     := le;
	END;

	header_in := PROJECT(header_in0,t_set_src(left));

	full_out_suppress :=  Header.Prep_Build.applyDidAddressSup(header_in);						  	

full_ShortSuppress := DriversV2.Regulatory.applyDriversLicenseSup_DIDVend(full_out_suppress);

j1 := DriversV2.Regulatory.applyDriversLicenseAllSup_DIDVendDOBSSN(full_ShortSuppress);

string_header_layout := {
			string15  did;
			string15  rid;
			string1   pflag1;
			string1   pflag2;
			string1   pflag3;
			string2   src;
			string8   dt_first_seen;
			string8   dt_last_seen;
			string8   dt_vendor_last_reported;
			string8   dt_vendor_first_reported;
			string8   dt_nonglb_last_seen;
			string1   rec_type;
			string18  vendor_id;
			string10  phone;
			string9   ssn;
			string10  dob;
			string5   title;
			string20  fname;
			string20  mname;
			string20  lname;
			string5   name_suffix;
			string10  prim_range;
			string2   predir;
			string28  prim_name;
			string4   suffix;
			string2   postdir;
			string10  unit_desig;
			string8   sec_range;
			string25  city_name;
			string2   st;
			string5   zip;
			string4   zip4;
			string3   county;
			string7   geo_blk;
			string5   cbsa;
			string1   tnt;
			string1   valid_SSN;
			string1   jflag1;
			string1   jflag2;
			string1   jflag3;	
			string2   eor;
	};
	
header_services.Supplemental_Data.mac_verify('file_qh_inj.txt',string_header_layout,supplementalData);

header.layout_header  ReformatInput(string_header_layout l) := TRANSFORM
	SELF.did := (unsigned6) l.did;
	SELF.rid := (unsigned6) l.rid;
	SELF.dt_first_seen := (unsigned3) l.dt_first_seen;
	SELF.dt_last_seen := (unsigned3) l.dt_last_seen;
	SELF.dt_vendor_last_reported := (unsigned3) l.dt_vendor_last_reported;
	SELF.dt_vendor_first_reported := (unsigned3) l.dt_vendor_first_reported;
	SELF.dt_nonglb_last_seen := (unsigned3) l.dt_nonglb_last_seen;
	SELF.dob := (integer4) l.dob;
	SELF := l;
END;

dsModified := PROJECT(supplementalData(), ReformatInput(LEFT));

//// this is full dataset as of full_LongSuppress := j1 + dsModified;
full_LongSuppress_pre := j1 + dsModified;
/////////////////////////////////////////////////////////

rid_base :=  Header.Prep_Build.applyRidRecSup(full_LongSuppress_pre);						  	
						 
						  
full_LongSuppress := 	rid_base ;						

///////////////////////////////////////////////////////
//append gender
header.Mac_Apply_Title(full_LongSuppress,title, fname, mname, apply_title_)

//Supress Fname = 'BIRTHDATE' Bug 79470
apply_title0 := apply_title_(header.Blocked_data_new());
apply_title := dedup(distribute(Header.fn_blank_phone(apply_title0,true),hash(did)),all,local);
apply_PID  := header.fn_persistent_record_ID(apply_title, true);
fix_dates := header.fn_fix_dates(apply_PID,true,header.Sourcedata_month.v_version);
header.macGetCleanAddr(fix_dates, RawAID, true, cln_addr);
header.Mac_dedup_header(cln_addr,head_out,'QH'); 
PromoteSupers.mac_sf_buildprocess(head_out,'~thor_data400::base::quick_header',build_qh_base,3,,true);

//just keys
autoKeys := header_quick.FN_AutokeyBuild(file_header_quick_skip_PID, filedate);

     didkey := header_quick.FN_key_DID(file_header_quick_skip_PID,                                 '~thor_data400::key::HeaderQuick::'      +filedate+'::DID') ;
fcra_didkey := header_quick.FN_key_DID(file_header_quick(src in mdr.sourceTools.set_scoring_FCRA,src not in mdr.sourceTools.set_scoring_FCRA_retro_test),
																																											'~thor_data400::key::HeaderQuick::fcra::'+filedate+'::DID') ;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(     didkey,           '',                                            '~thor_data400::key::HeaderQuick::'            +filedate+'::DID',         B1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra_didkey,           '',                                            '~thor_data400::key::HeaderQuick::fcra::'      +filedate+'::DID',         B2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_ssn_validity,      '~thor_data400::key::HeaderQuick_SSN_validity','~thor_data400::key::HeaderQuick::'            +filedate+'::SSN_validity',B3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(header.key_nlr_payload,'~thor_data400::key::header_nlr::did.rid',     '~thor_data400::key::header_nlr::'             +filedate+'::did.rid',     B4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(header_quick.key_fraud_flag_eq_pre,'',                                '~thor_data400::key::HeaderQuick::fraud_flag::'+filedate+'::eq'          ,B5);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::HeaderQuickDID',                '~thor_data400::key::HeaderQuick::'              +filedate+'::DID',          M1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::HeaderQuick::fcra::DID',        '~thor_data400::key::HeaderQuick::fcra::'        +filedate+'::DID',          M2);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::HeaderQuick_SSN_validity',      '~thor_data400::key::HeaderQuick::'              +filedate+'::SSN_validity', M3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header_nlr::did.rid',           '~thor_data400::key::header_nlr::'               +filedate+'::did.rid',      M4);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::headerquick::fraud_flag::@version@::eq','~ thor_data400::key::headerquick::fraud_flag::'+filedate+'::eq',    M5);

PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::HeaderQuickDID',                 'Q',MQ1);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::HeaderQuick::fcra::DID',         'Q',MQ2);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::HeaderQuick_SSN_validity',       'Q',MQ3);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::header_nlr::did.rid',            'Q',MQ4);
Roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::headerquick::fraud_flag::@version@::eq','Q',MQ5,filedate);

RETURN SEQUENTIAL(
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, header_quick.build_source_key(filedate),611),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, build_qh_base, 612),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, header_quick.proc_build_fraud_flag_eq(filedate), 613),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, build_rid_srid_keys(filedate), 614),
		Header.mac_runIfNotCompleted ('QuickHeader',filedate, PARALLEL(
			autoKeys,
			SEQUENTIAL(B1,M1,MQ1),
			SEQUENTIAL(B2,M2,MQ2),
			SEQUENTIAL(B3,M3,MQ3),
			SEQUENTIAL(B4,M4,MQ4),
			SEQUENTIAL(B5,M5,MQ5)
			), 615),
		build_source_key_prep(filedate)
	);

END;
