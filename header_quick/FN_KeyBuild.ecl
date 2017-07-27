import ut, header, doxie, autokey, autokeyb, RoxieKeyBuild, header_services, risk_indicators, mdr;

export FN_KeyBuild(dataset(header.Layout_Header) header_in0, string filedate) := 
FUNCTION

//***//***//***//*** SUPPRESSION CODE - CNG 20070417 - W20070417-161923 & W20070417-164348 ***//***//***//***//

recordof(header_in0) t_set_src(recordof(header_in0) le) := transform
 self.src := if(le.src='WH','WH', if(le.src= 'EQ', 'QH', le.src));
 self     := le;
end;

header_in := project(header_in0,t_set_src(left));

Suppression_Layout := header_services.Supplemental_Data.layout_in;

header_services.Supplemental_Data.mac_verify('didaddress_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashDIDAddress := header_services.Supplemental_Data.layout_out;

rFullOut_HashDIDAddress := record
 header.Layout_Header;
 rHashDIDAddress;
end;

//***//***// TEST CODE FOR SUPPRESSION - 20070605

rFullOut_HashDIDAddress tHashDIDAddress(header_in l) := transform                            
 self.hval :=  hashmd5(intformat(l.did,12,1),(string)l.st,(string)l.zip,(string)l.city_name,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.suffix,(string)l.postdir,(string)l.sec_range);
 self := l;
end;

dHeader_withMD5 := project(header_in, tHashDIDAddress(left));

header.Layout_Header tSuppress(dHeader_withMD5 l, dSuppressedIn r) := transform
 self := l;
end;

full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
                          left.hval=right.hval,
						  tSuppress(left,right),
						  left only,lookup); // : persist('~thor_data400::persist::Test_FN_KEYBUILD_Step_1');

///%%%
header_services.Supplemental_Data.mac_verify('driverslicense_sup.txt',Suppression_Layout, dl_supp_ds_func);
DL_Suppression_In 	:= dl_supp_ds_func();
DLSuppressedIn 			:= PROJECT(	DL_Suppression_In,header_services.Supplemental_Data.in_to_out(left));

HashDLShort := header_services.Supplemental_Data.layout_out;

shortHashrec := record
 header.layout_header;
 HashDLShort;
end;

shortHashrec HashDID_DLnumber(header.Layout_Header l) := transform                            
	self.hval := hashmd5(	intformat((unsigned6)l.did,12,1),TRIM((string14)l.vendor_id, left, right));
	self := l;
end;

hdr_withMD5 := project(full_out_suppress, HashDID_DLnumber(left));

header.layout_header shortSuppress(hdr_withMD5 l, DLSuppressedIn r) := transform
self := l;
end;

full_ShortSuppress := join(hdr_withMD5,DLSuppressedIn,left.hval=right.hval,shortSuppress(left,right),left only,lookup);
													 // : persist('~thor_data400::persist::Test_FN_KEYBUILD_Step_2');

header_services.Supplemental_Data.mac_verify('driverslicenseall_sup.txt',Suppression_Layout,dl_supp_ALL_ds_func);																					
 
DL_Supp_All_In := dl_supp_ALL_ds_func();
DLSuppressAllIn := PROJECT(	DL_Supp_All_In, header_services.Supplemental_Data.in_to_out(left));

HashDLLong := header_services.Supplemental_Data.layout_out;

longHashrec := record
 header.layout_header;
 HashDLLong;
end;

longHashrec HashALL(header.Layout_Header l) := transform                            
 self.hval := HASHMD5(	intformat((unsigned6)l.did,12,1),TRIM((string14)l.vendor_id, left, right),intformat((unsigned4)l.dob,8,1),Trim((string9)l.ssn));
 self := l;
end;

hdrFull_withMD5 := project(full_ShortSuppress, HashALL(left));

header.layout_header longSuppress(hdrFull_withMD5 l, DLSuppressAllIn r) := transform
 self := l;
end;

j1 := join(	hdrFull_withMD5,DLSuppressAllIn,left.hval=right.hval,longSuppress(left,right),left only,lookup);
					//	: persist('~thor_data400::persist::Test_FN_KEYBUILD_Step_3');

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
full_LongSuppress := j1 + dsModified;

//append gender

ut.Mac_Apply_Title(full_LongSuppress,title, fname, mname, apply_title_)

//Supress Fname = 'BIRTHDATE' Bug 79470
apply_title := apply_title_(header.Blocked_data_new());


ut.mac_sf_buildprocess(apply_title,'~thor_data400::base::quick_header',build_qh_base,2);

//just keys
autoKeys := header_quick.FN_AutokeyBuild(header_quick.file_header_quick, filedate); //  : persist('~thor_data400::persist::Test_FN_KEYBUILD_Step_4');

     didkey := header_quick.FN_key_DID(file_header_quick,                                          '~thor_data400::key::HeaderQuick::'      +filedate+'::DID') ;
fcra_didkey := header_quick.FN_key_DID(file_header_quick(src in mdr.sourceTools.set_scoring_FCRA), '~thor_data400::key::HeaderQuick::fcra::'+filedate+'::DID') ;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(     didkey,           '',                                            '~thor_data400::key::HeaderQuick::'      +filedate+'::DID',         B1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra_didkey,           '',                                            '~thor_data400::key::HeaderQuick::fcra::'+filedate+'::DID',         B2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_ssn_validity,      '~thor_data400::key::HeaderQuick_SSN_validity','~thor_data400::key::HeaderQuick::'      +filedate+'::SSN_validity',B3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(header.key_nlr_payload,'~thor_data400::key::header_nlr::did.rid',     '~thor_data400::key::header_nlr::'       +filedate+'::did.rid',     B4);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::HeaderQuickDID',           '~thor_data400::key::HeaderQuick::'      +filedate+'::DID',          M1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::HeaderQuick::fcra::DID',   '~thor_data400::key::HeaderQuick::fcra::'+filedate+'::DID',          M2);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::HeaderQuick_SSN_validity', '~thor_data400::key::HeaderQuick::'      +filedate+'::SSN_validity', M3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header_nlr::did.rid',      '~thor_data400::key::header_nlr::'       +filedate+'::did.rid',      M4);

ut.MAC_SK_Move_v2('~thor_data400::key::HeaderQuickDID',          'Q',MQ1);
ut.MAC_SK_Move_v2('~thor_data400::key::HeaderQuick::fcra::DID',  'Q',MQ2);
ut.MAC_SK_Move_v2('~thor_data400::key::HeaderQuick_SSN_validity','Q',MQ3);
ut.MAC_SK_Move_v2('~thor_data400::key::header_nlr::did.rid',     'Q',MQ4);

return sequential(
									build_qh_base
									,notify('QuickHeader BaseFile Complete','*')
									,doxie.proc_header_keys(filedate,true)
									,parallel(
														autoKeys
														,sequential(B1,M1,MQ1)
														,sequential(B2,M2,MQ2)
														,sequential(B3,M3,MQ3)
														,sequential(B4,M4,MQ4)
														)
								);

END;
