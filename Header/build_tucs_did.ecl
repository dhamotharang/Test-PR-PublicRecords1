import mdr, ut, header_slimsort, did_add, didville, _control, Transunion_PTrak, TransunionCred, address,idl_header,header,Data_Services,PromoteSupers;
import NID as nNID;

EXPORT build_tucs_did(string filedate) := FUNCTION

trans_recs := dataset(Data_Services.Data_location.Prefix('person_header')
											+'thor_data400::base::tucsheader_building',Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut,flat);

bad_dates := [200011,200107,200402,200510];

Header.Layout_New_Records Translate_tucs_to_Header(trans_recs l) := transform
	unsigned3 v_dt := IF(l.FileType = 'F', (integer)l.UPDATEDATE_unformatted[1..6] ,(integer)l.COMPILATIONDATE_unformatted[1..6]);
	unsigned3 v_r_dt := IF(l.FileType = 'F', (integer)l.TRANSFERDATE_Unformatted[1..6] ,(integer)l.FileDate[1..6]);

	self.did := 0;
	self.rid := 0;
	self.src := 'TS';
	self.pflag1 := '';
	self.pflag2 := '';
	self.pflag3 := '';  
	self.dt_first_seen            := if(v_dt in bad_dates,0,v_dt);
	self.dt_last_seen             := if(v_dt in bad_dates,0,v_dt);
	self.dt_vendor_first_reported := v_r_dt;
	self.dt_vendor_last_reported :=  v_r_dt;
	self.dt_nonglb_last_seen :=  self.dt_last_seen;
	self.rec_type := if(l.AddressSeq =1, '1','2'); 
	self.vendor_id := 'TS'+l.VendorDocumentIdentifier+((string)(hash(l.fname,l.lname,l.prim_name)))[1..4];
	self.phone := l.TELEPHONE_unformatted;
	self.ssn := l.SSN_unformatted;
	self.dob := if((integer)l.BIRTHDATE_unformatted[1..4] < 1800 ,0  // 36 records with invalid year as of 2009/01
		 , if(l.BIRTHDATEIND = 'N' or (l.BIRTHDATEIND = '' AND l.BIRTHDATE_unformatted [7..] NOT IN ['01','15']),( integer)l.BIRTHDATE_unformatted,0));
/*Y = Birth date calculated from social security number
N = Exact date of birth
E =  Calculated from individuals age
Blank = Unknown*/
	self.title := l.title;
	self.fname := l.fname;
	self.lname := l.lname;
	self.mname := l.mname;
	self.name_suffix := l.name_suffix;
	self.prim_range := l.prim_range;
	self.predir := l.predir;
	self.prim_name := l.prim_name;
	self.suffix := l.addr_suffix;
	self.postdir := l.postdir;
	self.unit_desig := l.unit_desig;
	self.sec_range := l.sec_range;
	self.city_name := l.v_city_name;
	self.st := l.st;
	self.zip := l.zip;
	self.zip4 := l.zip4;
	self.county := l.county[3..5];
	string3 msa_temp := l.msa;
	self.cbsa := if(msa_temp!='',msa_temp + '0','');
	self.geo_blk := l.geo_blk;
	self.tnt := '';
	self.valid_ssn := '';
	self.jflag1 := '';
	self.jflag2 := '';
	self.jflag3 := '';
  self := l;
end;
//project to canonic form, distribute, sort, and roll
dtucsasSource := project(trans_recs,Translate_tucs_to_Header(left));

dtucsasSource_dist := distribute(dtucsasSource,hash(fname,lname,name_suffix,
                prim_range,predir, prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county
							  ));

dtucsasSource_sort := sort(dtucsasSource_dist,fname,lname,name_suffix,
                prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county,phone,rec_type,local);

Header.Layout_New_Records t_rollup(dtucsasSource_sort le, dtucsasSource_sort ri) := transform
 self.dt_first_seen            := if(le.dt_first_seen>0 and ri.dt_first_seen>0
                                     ,ut.Min2(le.dt_first_seen,ri.dt_first_seen)
                                     ,Max(le.dt_first_seen,ri.dt_first_seen));
 self.dt_last_seen             := Max(le.dt_last_seen,ri.dt_last_seen);
 self.dt_vendor_first_reported := if(le.dt_vendor_first_reported>0 and ri.dt_vendor_first_reported>0
                                     ,ut.Min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported)
                                     ,Max(le.dt_vendor_first_reported,ri.dt_vendor_first_reported));
 self.dt_vendor_last_reported  := Max(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
 self.dt_nonglb_last_seen      := self.dt_last_seen;
 
 self.mname    := if(length(trim(le.mname))>length(trim(ri.mname)),le.mname,ri.mname);
 self.ssn      := if(le.ssn <> '' ,le.ssn,ri.ssn); 
 self.dob      := if(le.dob <>0 ,le.dob, ri.dob); 
 self.phone    := if(le.phone <>'' ,le.phone ,ri.phone); 
 self.rec_type := if(le.rec_type = '1', le.rec_type , ri.rec_type); 
 self          := le;
end;

Tucs_prep0 := rollup(dtucsasSource_sort,
                           left.fname       = right.fname       and  
						   left.lname       = right.lname       and 
						   left.name_suffix = right.name_suffix and
						   left.prim_range  = right.prim_range  and 
						   left.predir      = right.predir      and
						   left.prim_name   = right.prim_name   and
						   left.suffix      = right.suffix      and
						   left.postdir     = right.postdir     and
						   left.unit_desig  = right.unit_desig  and
						   left.sec_range   = right.sec_range   and 
						   left.city_name   = right.city_name   and
						   left.st          = right.st          and
						   left.zip         = right.zip         and
						   left.zip4        = right.zip4        and
						   left.county      = right.county      and
						   nNID.firstname_match(left.mname,right.mname)>0 and
						   ut.NNEQ_SSN(left.ssn, right.ssn)     and
						   ut.NNEQ_Date(left.dob, right.dob)    , 
				   t_rollup(left,right),
				   local
				  );

tucs_tucp_combined:= Tucs_prep0 + TransunionCred.as_header(,true);

ut.mac_flipnames(tucs_tucp_combined,fname,mname,lname,names_fixed);

char_swaped   := header.fn_character_swapping(names_fixed);

Header.mac_Fix_Suffix(char_swaped,Tucs_prep1);

//this filter is applied because of mac_flipnames rule 2; this can result in records with no last_name W20100505-090313
Tucs_prep2   := Tucs_prep1(fname<>'' and lname<>'');

//Patch to filter bad names
check_for_junk := header.BogusNames(Tucs_prep2.fname,Tucs_prep2.mname,Tucs_prep2.lname) or header.boguscities(Tucs_prep2.city_name, Tucs_prep2.st);

Tucs_prep4 := Tucs_prep2(not check_for_junk);

//Clean phone
header.MAC_555_phones(Tucs_prep4, phone, Tucs_prep5);

//prepare to did twice
r1 := record
 dob2:=0;
 unsigned1 did_score := 0;
 header.layout_header;
end;

Tucs_prep6 := project(Tucs_prep5,transform({r1},self.dob2:=left.dob,self:=left));

Tucs_prep6_has_SSN := Tucs_prep6(ssn <> '');
Tucs_prep6_no_SSN := Tucs_prep6(ssn = '');

//passing the records with SSN to name + SSN matching
matchset := ['S'];

//switching to sensitive... i think transunion data had suspicious DOB's to begin with
//DID with dob2 but drop it later
did_add.MAC_Match_Flex
	(Tucs_prep6_has_SSN, matchset,					
	 ssn, foo, fname, mname, lname, name_suffix, 
	 foo, foo, foo, foo, foo, foo, 
	 DID, r1, true, DID_Score,
	75, re_did1)

//passing the records without SSN + the records without name SSN matching (DID_score = 0) to 
//other matchings. 
second_call := re_did1(did_score = 0) + Tucs_prep6_no_SSN;

matchset1 := ['A','Z','D','P'];

did_add.MAC_Match_Flex
	(second_call, matchset1,					
	 ssn, dob2, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 DID, r1, true, DID_Score,
	 75, re_did2)

//combine the records from two matchflex
re_did := re_did1(did_score <> 0) + re_did2;

drop_dob2 := project(re_did(did>0),Header.Layout_New_Records);

//assign a sequence to uid - fn_tucs_exclussions needs it
ut.MAC_Sequence_Records(drop_dob2,uid,got_a_did0)
// source filter src not in ['TS','TN'] is not really needed because the sources are external, but, just in case latter we deside to make them internal
got_a_did1 := Header.fn_TUCS_exclusuins(got_a_did0(src<>'TN'),header.File_Headers(src not in ['TS','TN']))(fname <> '' and lname <>'')+got_a_did0(src='TN');
//get a new min rid
start_rid:= 799999999999 - max(got_a_did1,uid);  //  TULT rids start at 800000000000.  TS rids will start and end just before.
//assign a new rid using the new max rid and sequensed uid
Header.Layout_header to_form2(got_a_did1 l) := transform
  self.rid := start_rid + l.uid;
  self := l;
  end;
got_a_did := project(got_a_did1,to_form2(left));

ut.mac_suppress_by_phonetype(got_a_did,phone,st,phone_suppression,true,did);
set_titles := header.fn_get_title_from_header(phone_suppression):persist('~thor_data400::persist::TSTN_set_titles_');
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

j1 := join(distribute(NoTtee,hash(did)),hdr_val_ssn
             ,   left.did=right.did
						 and left.ssn=right.ssn
						 ,x1(left,right)
						 ,left outer
						 ,local)(fname <> '' and lname <>'');

fixed_dates := header.fn_fix_dates(j1,,filedate);

DoBuild := distribute(fixed_dates,hash(did));

pre1 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::tucs_did_BUILDING')>0,
    output('Nothing added to Base::tucs_did_BUILDING'),
    fileservices.addsuperfile('~thor_data400::Base::tucs_did_BUILDING','~thor_data400::Base::tucsHeader_Building',,true));
pre2 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::TransunionCred_did_BUILDING')>0,
    output('Nothing added to Base::TransunionCred_did_BUILDING'),
		fileservices.addsuperfile('~thor_data400::Base::TransunionCred_did_BUILDING','~thor_data400::base::transunioncredheader_building',,true));

PromoteSupers.MAC_SF_BuildProcess(DoBuild(src='TS' and ( ~((did=118120464 and fname='STEPHEN' and lname='KLINE') or (did=1067439253 and fname='STEPHEN' and lname in ['KLINE','BAKER'])))),'~thor_data400::BASE::tucs_did',bld_TS,2,,true,pVersion:=filedate);
PromoteSupers.MAC_SF_BuildProcess(transunionCred.fn_dedup(DoBuild(src='TN')),'~thor_data400::BASE::TransunionCred_did',bld_TN,2,,true,pVersion:=filedate);

post1 := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::tucs_did_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::tucs_did_BUILT','~thor_Data400::base::tucs_did_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::tucs_did_BUILDING'));
post2 := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::TransunionCred_did_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::TransunionCred_did_BUILT','~thor_Data400::base::TransunionCred_did_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::TransunionCred_did_BUILDING'));

full1 := sequential(pre1, pre2, bld_TS, bld_TN, post1, post2);

RETURN full1;
END;