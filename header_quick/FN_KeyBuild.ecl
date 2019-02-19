import header, doxie, autokey, autokeyb, RoxieKeyBuild, header_services, risk_indicators, mdr,aid,PromoteSupers;

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
 self.hval :=  hashmd5(intformat(l.did,15,1),(string)l.st,(string)l.zip,(string)l.city_name,
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
						  left only,lookup);

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
	self.hval := hashmd5(	intformat((unsigned6)l.did,15,1),TRIM((string14)l.vendor_id, left, right));
	self := l;
end;

hdr_withMD5 := project(full_out_suppress, HashDID_DLnumber(left));

header.layout_header shortSuppress(hdr_withMD5 l, DLSuppressedIn r) := transform
self := l;
end;

full_ShortSuppress := join(hdr_withMD5,DLSuppressedIn,left.hval=right.hval,shortSuppress(left,right),left only,lookup);

header_services.Supplemental_Data.mac_verify('driverslicenseall_sup.txt',Suppression_Layout,dl_supp_ALL_ds_func);																					
 
DL_Supp_All_In := dl_supp_ALL_ds_func();
DLSuppressAllIn := PROJECT(	DL_Supp_All_In, header_services.Supplemental_Data.in_to_out(left));

HashDLLong := header_services.Supplemental_Data.layout_out;

longHashrec := record
 header.layout_header;
 HashDLLong;
end;

longHashrec HashALL(header.Layout_Header l) := transform                            
 self.hval := HASHMD5(	intformat((unsigned6)l.did,15,1),TRIM((string14)l.vendor_id, left, right),intformat((unsigned4)l.dob,8,1),Trim((string9)l.ssn));
 self := l;
end;

hdrFull_withMD5 := project(full_ShortSuppress, HashALL(left));

header.layout_header longSuppress(hdrFull_withMD5 l, DLSuppressAllIn r) := transform
 self := l;
end;

j1 := join(	hdrFull_withMD5,DLSuppressAllIn,left.hval=right.hval,longSuppress(left,right),left only,lookup);

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

layout_ff := Record
     data16 hval_did ;
     data16 hval_ssn ;
		 string1 nl := '\n' ;
END ;

header_services.Supplemental_Data.mac_verify('ff_sup.txt',layout_ff, ff_sup_attr); // 
 
Base_ff_sup := ff_sup_attr();


full_LongSuppress_1 := JOIN(full_LongSuppress_pre, Base_ff_sup,
                    hashmd5((string9)left.ssn) = right.hval_ssn 
                    AND
						  hashmd5(intformat(left.did,15,1)) != right.hval_did, 
						TRANSFORM(LEFT),
						LEFT ONLY, ALL) ;
						
header_services.Supplemental_Data.mac_verify('ridrec_sup.txt',Suppression_Layout, base_sup_attr); // 
 
Base_rid_sup_in := base_sup_attr() ;

base_rid_sup := PROJECT(Base_rid_sup_in ,header_services.Supplemental_Data.in_to_out(left));

rid_base := JOIN(full_LongSuppress_1, base_rid_sup,
                 hashmd5(intformat((unsigned6)left.rid,15,1)) = right.hval,                    
						     TRANSFORM(LEFT),
						    LEFT ONLY, ALL) ;
						 
						  
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

     didkey := FN_key_DID(file_header_quick_skip_PID,                                 '~thor_data400::key::HeaderQuick::'      +filedate+'::DID') ;
fcra_didkey := FN_key_DID(file_header_quick(src in mdr.sourceTools.set_scoring_FCRA,src not in mdr.sourceTools.set_scoring_FCRA_retro_test),
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

return sequential(
									build_source_key(filedate)
									,build_qh_base
									,header_quick.proc_build_fraud_flag_eq(filedate)
									,notify('QuickHeader BaseFile Complete','*')
									,build_rid_srid_keys(filedate)
									,parallel(
														autoKeys
														,sequential(B1,M1,MQ1)
														,sequential(B2,M2,MQ2)
														,sequential(B3,M3,MQ3)
														,sequential(B4,M4,MQ4)
														,sequential(B5,M5,MQ5)
														)
									//,build_source_key_prep(filedate)
								);

END;