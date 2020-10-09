IMPORT Business_Header, ut, header_services, Suppress;

export Emp_out(

	 dataset(Layout_Business_Contact_Plus		)	pBc_plus		= Files().Base.Business_Contacts_Plus.keybuild
	,dataset(Layout_Business_Contacts_Stats	)	pPaw_Stats	= Files().Base.PeopleAtWorkStats.built

) := 
function


//use file without appended data
Employees := pBc_plus;
//Employees := File_Business_Contacts_Plus;

business_header.Layout_Business_Contact_Plus fixempdates(Employees L) := transform
  self.dt_first_seen := map(validatedate((string8)L.dt_first_seen) = '' => 0, 
							L.dt_first_seen);
  self.dt_last_seen :=  map(validatedate((string8)L.dt_last_seen) = ''  => self.dt_first_seen, 
							L.dt_last_seen < self.dt_first_seen => self.dt_first_seen,
							L.dt_last_seen);
  self := L;
end;

Employees_Filtered := filters.outs.PeopleAtWork(Employees);

emp_date_fix := project(if(Flags.Out.ShouldFilter, Employees_Filtered, Employees), fixempdates(left));


//Rollup Employees from Business Reocrds by BDID, Company across sources
//This code moved from BC_Init to preserve contacts by source code in base
Business_Contacts_Dist := DISTRIBUTE(emp_date_fix(from_hdr = 'N'), HASH(bdid, TRIM(ut.CleanCompany(company_name)), TRIM(lname), zip));
Business_Contacts_Sort := SORT(Business_Contacts_Dist, bdid, ut.CleanCompany(company_name), company_title,
    lname, Datalib.PreferredFirst(fname), mname, name_suffix, zip, prim_name, prim_range, company_zip, company_prim_name, company_prim_range, IF(phone<>0,0,1), Business_Header.Map_Source_Hierarchy(source), if(vendor_id <> '', 0, 1), LOCAL);
Business_Contacts_Grpd := GROUP(Business_Contacts_Sort, bdid, ut.CleanCompany(company_name), company_title,
    lname, Datalib.PreferredFirst(fname), mname, name_suffix, zip, prim_name, prim_range, company_zip, company_prim_name, company_prim_range, LOCAL);

Business_Header.Layout_Business_Contact_Plus RollupContacts(Business_Header.Layout_Business_Contact_Plus L, Business_Header.Layout_Business_Contact_Plus R) := TRANSFORM
SELF.dt_first_seen := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen);
SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen, R.dt_last_seen);
SELF.company_phone := IF(L.company_phone = 0, R.company_phone, L.company_phone);
SELF.company_fein := IF(L.company_fein = 0, R.company_fein, L.company_fein);
SELF.record_type := IF(R.record_type = 'C', R.record_type, L.record_type);
SELF := L;
END;

Business_Contacts_Rollup := GROUP(ROLLUP(Business_Contacts_Grpd, TRUE, RollupContacts(LEFT,RIGHT)));


//Join "people at work" with the stats to generate the total score.
//Note that the stats file currently includes the full contact so we
//could have just used that directly.
Employees_Business := Business_Contacts_Rollup(NOT Business_Header.CheckUCC(source, company_name, fname, mname, lname, name_suffix));
Employees_Other := if(Flags.Out.ShouldFilter, Employees_Filtered(from_hdr <> 'N'), Employees(from_hdr <> 'N'));

// Rollup Employees from Business to discard blank company addresses if contact and current clean name name, source, vendor_id exists with an address
Employees_Business_Dist := distribute(Employees_Business, hash(source, trim(vendor_id), trim(ut.CleanCompany(company_name))));

Employees_Business_Sort := sort(Employees_Business_Dist, source, vendor_id, ut.CleanCompany(company_name),
                     datalib.PreferredFirst(fname), mname, lname, name_suffix, company_title, zip, prim_name, prim_range,
					 if(record_type = 'C', 0, 1), if(company_zip <> 0, 0, 1), local);

Employees_Business_Rollup := rollup(Employees_Business_Sort,
               left.source = right.source and
               left.vendor_id = right.vendor_id and
							 ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name) and
							 datalib.PreferredFirst(left.fname) = datalib.PreferredFirst(right.fname) and
							 ut.NNEQ(left.mname, right.mname) and
							 left.lname = right.lname and
							 ut.NNEQ(left.name_suffix, right.name_suffix) and
							 left.company_title = right.company_title and
							 left.zip = right.zip and
							 left.prim_name = right.prim_name and
							 left.prim_range = right.prim_range and
                             right.company_zip = 0,
							 Business_Header.TRA_Merge_Employees_Business(left, right),
							 local);
							 
Employees_Combined := Employees_Other + Employees_Business_Rollup;


// Employee_Stats := Business_Header.File_Business_Contacts_Stats; //pPaw_Stats;
Employee_Stats := pPaw_Stats;

layout_contact_full_with_stat := RECORD
	Business_Header.Layout_Business_Contact_Full;
	STRING1 active_phone_flag;
END;

layout_contact_full_with_stat AddScore(Employees l, Employee_Stats r) := TRANSFORM
	SELF.contact_score := r.combined_score;
	SELF.company_phone := IF(0 != r.best_phone, r.best_phone, l.company_phone);
	SELF.active_phone_flag := IF(r.has_gong_yp, 'Y', 'N');
	SELF := l;
END;

Employees_Join := JOIN(
	DISTRIBUTE(Employees_Combined, HASH(__filepos)),
	DISTRIBUTE(Employee_Stats, HASH(__filepos)),
	LEFT.__filepos = RIGHT.__filepos,
	AddScore(LEFT, RIGHT), LOCAL);


Business_Header.Layout_Employment_Out ToOut(Employees_Join L) := TRANSFORM
	SELF.bdid 					:= IF(L.bdid <> 0, (STRING15)INTFORMAT(L.bdid, 15, 1), '');
	SELF.did 						:= IF(L.did <> 0, (STRING15)INTFORMAT(L.did, 15, 1), '');
	SELF.ssn 						:= IF(L.ssn <> 0, (STRING9)INTFORMAT(L.ssn, 9, 1), '');
	SELF.dt_first_seen 	:= IF(L.dt_first_seen <> 0, (STRING8)L.dt_first_seen, '');
	SELF.dt_last_seen 	:= IF(L.dt_last_seen <> 0, (STRING8)L.dt_last_seen, '');
	SELF.company_zip 		:= IF(L.company_zip <> 0, (STRING5)INTFORMAT(L.company_zip, 5, 1), '');
	SELF.company_zip4 	:= IF(L.company_zip4 <> 0, (STRING4)INTFORMAT(L.company_zip4, 4, 1), '');
	SELF.zip 						:= IF(L.zip <> 0, (STRING5)INTFORMAT(L.zip, 5, 1), '');
	SELF.zip4 					:= IF(L.zip4 <> 0, (STRING4)INTFORMAT(L.zip4, 4, 1), '');
	SELF.phone 					:= IF(L.phone <> 0, (STRING10)INTFORMAT(L.phone, 10, 1), '');
	SELF.company_phone 	:= IF(L.company_phone <> 0, (STRING10)INTFORMAT(L.company_phone, 10, 1), '');
	SELF.company_fein 	:= IF(L.company_fein <> 0, (STRING9)INTFORMAT(L.company_fein, 9, 1), '');
	SELF.score 					:= IF(L.contact_score = 0, '', INTFORMAT(L.contact_score, 3, 1));
	SELF.GLB 						:= IF(L.glb, 'Y', 'N');
	self.DPPA_State 		:= IF(L.dppa, L.vendor_id[1..2], '');
	self.name_suffix 		:= IF ( ut.is_unk(l.name_suffix),'',l.name_suffix);
	SELF := L;
END;


in_hdr := PROJECT(Employees_Join, ToOut(LEFT));
Suppression_Layout := Suppress.applyRegulatory.layout_in;


	full_out_suppress := Business_Header.Prep_Build.applyDidAddressBusiness_sup(in_hdr);


header_services.Supplemental_Data.mac_verify(	'employment_sup.txt',
																							Suppression_Layout, 
																							emp_ONLY_supp_ds_func	);
 
Emp_ONLY_Suppression_In := emp_ONLY_supp_ds_func();

dEmpONLYSuppressedIn := PROJECT(	Emp_ONLY_Suppression_In, 
																Suppress.applyRegulatory.in_to_out(left));

EmpHashBDIDFormat := Suppress.applyRegulatory.layout_out;

EmpFullOut_HashBDID := RECORD
	Business_Header.Layout_Employment_Out;
	EmpHashBDIDFormat;
end;

EmpFullOut_HashBDID EmpHashBDID(Business_Header.Layout_Employment_Out l) := transform                            
 self.hval := hashmd5(l.bdid, l.did);
 self := l;
end;

EmpONLYHeader_withMD5 := project(full_out_suppress, EmpHashBDID(left));

Business_Header.Layout_Employment_Out EmpONLYSuppress(EmpONLYHeader_withMD5 l) := transform
 self := l;
end;

emp_ONLY_full_out_suppress := JOIN(	EmpONLYHeader_withMD5,
																		dEmpONLYSuppressedIn,
																		left.hval = right.hval,
																		EmpONLYSuppress(left),
																		left only,
																		lookup);

			
	header_services.Supplemental_Data.mac_verify(	'businesscontactsbytitle_sup.txt',
																									Suppression_Layout, 
																								BCbytitle_ds_func	);
	 
	BCbytitle_Suppression_In := BCbytitle_ds_func();

	dBCbytitle_SuppressedIn := PROJECT(	BCbytitle_Suppression_In, 
																	Suppress.applyRegulatory.in_to_out(left));

	rHashVal := Suppress.applyRegulatory.layout_out;
	
	rEmp_withHash := RECORD
		Business_Header.Layout_Employment_Out;
		rHashVal;
	end;

	rEmp_withHash addHash(Business_Header.Layout_Employment_Out l) := transform                            
	 self.hval := hashmd5(intformat((unsigned6)l.bdid,15,1), l.company_title, l.lname, l.fname);
	 self := l;
	end;

	ds_withHash := project(emp_ONLY_full_out_suppress, addHash(left));

	Business_Header.Layout_Employment_Out removeHash(ds_withHash l) := transform
	 self := l;
	end;
	
	emp_by_title_suppress := JOIN(ds_withHash,
																dBCbytitle_SuppressedIn,
																left.hval = right.hval,
																removeHash(left),
																left only,
																lookup);
																			
header_services.Supplemental_Data.mac_verify(	'employmentall_sup.txt',
																							Suppression_Layout, 
																							emp_all_supp_ds_func	);
 
Emp_All_Suppression_In := emp_all_supp_ds_func();

dEmpAllSuppressedIn := PROJECT(	Emp_All_Suppression_In, 
																Suppress.applyRegulatory.in_to_out(left));

rHashBDID := Suppress.applyRegulatory.layout_out;

rFullOut_HashBDID := RECORD
	Business_Header.Layout_Employment_Out;
	rHashBDID;
end;

rFullOut_HashBDID tHashBDID(Business_Header.Layout_Employment_Out l) := transform                            
 self.hval := hashmd5(l.bdid);
 self := l;
end;

dEmpAllHeader_withMD5 := project(emp_by_title_suppress, tHashBDID(left));

Business_Header.Layout_Employment_Out tEmpAllSuppress(dEmpAllHeader_withMD5 l) := transform
 self := l;
end;


emp_all_full_out_suppress := JOIN(	dEmpAllHeader_withMD5,
																		dEmpAllSuppressedIn,
																		left.hval = right.hval,
																		tEmpAllSuppress(left),
																		left only,
																		lookup);

//Output all "people at work" records
return emp_all_full_out_suppress;


end;