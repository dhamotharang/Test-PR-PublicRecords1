import mdr, ut, header_slimsort, did_add, didville, _control, address,idl_header,PromoteSupers;

//contains all LT and TU records from the 20070724 header
boolean is_hdrbuild := true;
trans_recs0 := dataset('~thor_data400::base::header_transunion',Header.layout_header,flat);
header.Mac_File_headers(trans_recs0,is_hdrbuild,trans_recs);

r1 := record
 integer dob2;
 unsigned1 did_score := 0;
 trans_recs;
end;

r1 t_re_did_prep(trans_recs le) := transform

 string8 v_dob0     := (string)le.dob;
 //apparently a default date
 string8 v_dob      := if(v_dob0 in ['18990000','18990100'],'',v_dob0);
		
 string4 v_dob_yyyy := v_dob[1..4];
 string2 v_dob_mm   := if(v_dob[5..6]='00','',v_dob[5..6]);
 string2 v_dob_dd   := if(v_dob[7..8]='00','',v_dob[7..8]);
 
 string8 v_dob2     := if(le.dob<>0,v_dob_yyyy+v_dob_mm+v_dob_dd,'');
 
 self.did                      := 0;
 self.ssn                      := if(le.pflag3 in ['U','X'],'',if(le.ssn in ut.set_badssn,'',le.ssn));
 self.phone                    := if(le.pflag3 in ['W','X'],'',header.fn_blank_bogus_phones(le.phone));
 self.pflag3                   := if(le.pflag3 in ['U','X','W'],'',le.pflag3);
 self.dob                      := if(le.dob in [18990000,18990100],0,le.dob);
 self.dob2                     := (integer)v_dob2;
 self.dt_first_seen            := if(le.src='TU',0,le.dt_first_seen);
 self.dt_last_seen             := if(le.src='TU',0,le.dt_last_seen);
 self.dt_vendor_first_reported := if(le.src='TU',0,le.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := if(le.src='TU',0,le.dt_vendor_last_reported);
 self.rec_type                 := '';
 self.valid_ssn                := '';
 self.prim_name  := if(le.prim_name in Header.set_derogatory_address
												or header.bogusstreets(le.prim_name)
												or regexfind('^error | error | error$',trim(le.prim_name),nocase)
											,'',le.prim_name);
 self.city_name  := if(le.city_name in Header.set_derogatory_address,'',le.city_name);
	self.pflag1 := '';
	self.jflag2 := '';
	self.jflag3 := '';
 self                          := le;
end;

p_re_did_prep0 := project(trans_recs,t_re_did_prep(left));

Header.mac_Fix_Suffix(p_re_did_prep0,p_re_did_prep1);
ut.mac_flipnames(p_re_did_prep1,fname,mname,lname,p_re_did_prep2);
//this filter is applied because of mac_flipnames rule 2; this can result in records with no last_name W20100505-090313
p_re_did_prep   := p_re_did_prep2(fname<>'' and lname<>'');

//Patch to filter bad names
check_for_junk := header.BogusNames(p_re_did_prep.fname,p_re_did_prep.mname,p_re_did_prep.lname) or header.boguscities(p_re_did_prep.city_name, p_re_did_prep.st);

good_names := p_re_did_prep(not check_for_junk);
junk_names := p_re_did_prep(    check_for_junk);

//Clean phone
header.MAC_555_phones(good_names, phone, good_names_ph);

good_names_has_SSN := good_names_ph(ssn <> '');
good_names_no_SSN := good_names_ph(ssn = '');

//passing the records with SSN to name + SSN matching 
matchset := ['S'];

//switching to sensitive... i think transunion data had suspicious DOB's to begin with
//DID with dob2 but drop it later
did_add.MAC_Match_Flex
	(good_names_has_SSN, matchset,					
	 ssn, foo, fname, mname, lname, name_suffix, 
	 foo, foo, foo, foo, foo, foo, 
	 DID, r1, true, DID_Score,
	75, re_did1)

//passing the records without SSN + the records without name SSN matching (DID_score = 0) to 
//other matchings. 
second_call := re_did1(did_score = 0) + good_names_no_SSN;

matchset1 := ['A','Z','D','P'];

did_add.MAC_Match_Flex
	(second_call, matchset1,					
	 ssn, dob2, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 DID, r1, true, DID_Score,
	 75, re_did2)

//combine the records from two matchflex

re_did := re_did1(did_score <> 0) + re_did2;

drop_dob2 := project(re_did,header.layout_header);

got_a_did0 := drop_dob2(did>0);

//these 2 searches return roughly 60k each with the same DID
got_a_did1 := got_a_did0(~(trim(fname)='ANGEL'   and trim(lname)='CAMILO' and trim(prim_range)='8750' and trim(prim_name)='36TH'       and zip='33178'));
got_a_did  := got_a_did1(~(trim(fname)='BARBARA' and trim(lname)='JONES'  and trim(prim_range)=''     and trim(prim_name)='PO BOX 357' and zip='33004'));

ut.mac_suppress_by_phonetype(got_a_did,phone,st,phone_suppression,true,did);
set_titles := header.fn_get_title_from_header(phone_suppression);
SSN_DOB_suppression := fn_TULT_SSN_DOB_suppression(set_titles);

header.Mac_clean_trustee_name(SSN_DOB_suppression,NoTtee);

hdr_val_ssn := dedup(sort(distribute(header.file_headers(ssn<>'' and valid_ssn<>''),hash(did)),did,ssn,local),did,ssn,local);

header.layout_header x1(NoTtee le, hdr_val_ssn ri) := transform
 self.valid_ssn := if(le.did=ri.did and le.ssn=ri.ssn,ri.valid_ssn,le.valid_ssn);
 self.prim_name  := if(le.prim_name in Header.set_derogatory_address
												or header.bogusstreets(le.prim_name)
												or regexfind('^error | error | error$',trim(le.prim_name),nocase)
											,'',le.prim_name);
 self           := le;
end;

j1 := join(distribute(NoTtee,hash(did)),hdr_val_ssn,left.did=right.did and left.ssn=right.ssn,x1(left,right),left outer,local);

DoBuild:= distribute(j1,hash(did));

pre1 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::transunion_did_BUILDING')>0,
    output('Nothing added to Base::transunion_did_BUILDING'),
    fileservices.addsuperfile('~thor_data400::Base::transunion_did_BUILDING','~thor_data400::base::header',,true));

PromoteSupers.MAC_SF_BuildProcess(DoBuild,'~thor_data400::BASE::transunion_did',bld,2,,true,pVersion:=Header.version_build)

post1 := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::transunion_did_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::transunion_did_BUILT','~thor_Data400::base::transunion_did_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::transunion_did_BUILDING'));

full1 := if (fileservices.getsuperfilesubname('~thor_Data400::base::transunion_did_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::header',1),
		output('Header Base = BUILT. Nothing Done.'),
		sequential(pre1, bld ,post1));

export transunion_did := full1;