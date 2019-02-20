// This code is left as it is, since it is used by ContactCard service. For future development use PersonReports.Person_records
// Attribute Information: Fetches Imposters, AKAs, and Subject_Information for ContactCard ReportService.

import ut, doxie, suppress, codes, driversv2_services, watchdog, risk_indicators, DeathV2_Services,
       header, PersonReports, AutoStandardI, MDR;

t_yesNo	:= PersonReports.layouts.t_yesNo; // string3
yesNo		:= PersonReports.layouts.yesNo;

mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ());

export Addrs_imposters_rels_assocs(dataset(doxie.layout_references) dids, boolean checkrna = header.constants.checkRNA) := MODULE

shared layout_comp_names_w_title := record
	PersonReports.layouts.comp_names;
	Watchdog.Layout_Best.title;
end;

// Best records for subject_information, AKAs, Imposters -checkRNA = false for subject_info,AKA and TRUE for imposters
shared bestrecs := doxie.best_records(dids, false, , , true, checkrna, modAccess := mod_access);
// Fetch records using SSN
shared sslr := doxie.SSN_Lookups;

ssn_per := dedup(sort(doxie.ssn_persons(),record,except dt_first_seen,dt_last_seen),record,except dt_first_seen,dt_last_seen);
proj_ssn_per := project(ssn_per,transform(layout_comp_names_w_title,
																					self.dob := left.date_ob,
																					self.age := if(left.date_ob<>0,ut.Age(left.date_ob),0),
																					self.address_seq_no := 0;
																					self := left));
// Used by Imposters and AKAs section.
shared pre_subj_names := dedup(sort
													(proj_ssn_per ,fname,lname,mname,-dob,-ssn),
													left.fname=right.fname and left.lname=right.lname and left.mname=right.mname and
													(left.dob=right.dob or right.dob=0 or ((integer)(((string)right.dob)[7..8])=0 and ((string)left.dob)[1..6]=((string)right.dob)[1..6] )) and
													(left.ssn=right.ssn or right.ssn=''));

// Start Formatting drivers
dlsr := DriversV2_Services.DLEmbed_records(dids);

layout_dl := record
	string20 fname;
	string20 mname;
	string20 lname;
	unsigned6 did;
	dataset(PersonReports.layouts.dl) drivers_licenses {Maxcount(10)};
END;

PersonReports.layouts.dl get_license_info(dlsr l):=transform
		self.ssn := l.ssn;
		self.name_first := l.fname;
		self.name_middle := l.mname;
		self.name_last := l.lname;
		self.name_prefix := l.title;
		self.age := l.age;
		self.dob.year :=(unsigned2)((STRING)l.dob)[1..4];
		self.dob.month :=(unsigned1)((STRING)l.dob)[5..6];
		self.dob.day := (unsigned1)((STRING)l.dob)[7..8];
		self.street_number := l.prim_range;
		self.street_name := l.prim_name;
		self.street_suffix := l.suffix;
		self.city := l.v_city_name;
		self.state := l.st;
		self.zip := l.zip;
		self.zip4 := l.zip4;
		self.county := l.county_name;
		self.sex := l.sex_flag;
		self.race := l.race;
		self.license_type := l.license_type_name;
		self.expiration_date.year :=(unsigned2)((STRING)l.expiration_date)[1..4];
		self.expiration_date.month :=(unsigned1)((STRING)l.expiration_date)[5..6];
		self.expiration_date.day := (unsigned1)((STRING)l.expiration_date)[7..8];
		self.lic_issue_date.year :=(unsigned2)((STRING)l.lic_issue_date)[1..4];
		self.lic_issue_date.month :=(unsigned1)((STRING)l.lic_issue_date)[5..6];
		self.lic_issue_date.day :=(unsigned1)((STRING)l.lic_issue_date)[7..8];
		self.state_name := codes.GENERAL.state_long(l.st);
		self.dl_number := l.dl_number;
		self.height := l.height;
		self.history := l.history;
		Self.src := L.source_code;
END;

layout_dl get_dl(dlsr l):=transform
	self := l;
	self.drivers_licenses := project(l, get_license_info(left));
END;

layout_dl roll_drivers(layout_dl l, dataset(layout_dl) r):=transform
	self.drivers_licenses := choosen(r.drivers_licenses,PersonReports.layouts.max_dl);
	self := l;
END;

dlsr_formatted := project(group(sort(dlsr,did,fname,mname,lname),did,fname,mname,lname),get_dl(left));
shared roll_dlsr := rollup(dlsr_formatted,group,roll_drivers(left,rows(left)));
// End Formatting drivers - use later in AKAs section.

// Get person Addresses with ssn info and residents
shared with_ssn_info := record
	PersonReports.layouts.comp_names;
	unsigned4 dod;
	boolean IsLimitedAccessDMF := false;
	unsigned1 age_at_death;
	string1 death_verification_code;
	string1 deceased;
	personReports.Layouts.identity.ssn_valid;
	personReports.Layouts.identity.ssn_issued_location;
	personReports.Layouts.date.ymd ssn_issued_start_date; 	// single
	personReports.Layouts.date.ymd ssn_issued_end_date;	
	dataset(personReports.Layouts.dl) drivers_licenses {maxcount(10)};
END;

shared with_ssn_info_w_title := record
	with_ssn_info;
	watchdog.layout_best.title;
end;

shared with_ssn_info_w_title add_issuance_w_title(layout_comp_names_w_title l,sslr r):=transform
	self.title := l.title;
	self.ssn_valid := yesNo(r.valid);
	self.ssn_issued_location := r.ssn_issue_place;
	self.ssn_issued_start_date.year :=(unsigned2)((STRING) r.ssn_issue_early)[1..4];
	self.ssn_issued_start_date.month :=(unsigned1)((STRING) r.ssn_issue_early)[5..6];
	self.ssn_issued_start_date.day :=(unsigned1)((STRING) r.ssn_issue_early)[7..8];
	self.ssn_issued_end_date.year :=(unsigned2)((STRING) r.ssn_issue_last)[1..4];
	self.ssn_issued_end_date.month :=(unsigned1)((STRING) r.ssn_issue_last)[5..6];
	self.ssn_issued_end_date.day := (unsigned1)((STRING) r.ssn_issue_last)[7..8];
	self := l;
	self := [];
END;	

shared get_hri_ssn(STRING9 ssn, UNSIGNED6 did) := FUNCTION
	maxHriPer_Value := personReports.layouts.max_hri;
	ssn_hri_rec := RECORD
		STRING9   ssn;
		UNSIGNED6 did;	
		STRING1   valid_ssn;
		UNSIGNED  cnt;
		UNSIGNED4 ssn_issue_early;
		UNSIGNED4 ssn_issue_last;
		STRING2   ssn_issue_place;
		DATASET(risk_indicators.layout_desc) hri_ssn {MAXCOUNT(maxHriPer_Value)};
END;

	ssnDidRecs := DATASET([{ssn,did,'',0,0,0,'',DATASET([],risk_indicators.layout_desc)}],ssn_hri_rec);
	doxie.mac_AddHRISSN(ssnDidRecs,ssnDidRecsHRI,FALSE);
	RETURN NORMALIZE(ssnDidRecsHRI,LEFT.hri_ssn,TRANSFORM(risk_indicators.layout_desc,SELF:=RIGHT));
END;

shared get_id() := macro
  dob :=  (string8)l.dob;
	dod := (string8) l.dod;
	self.drivers_licenses := l.drivers_licenses;
	self.ssn := l.ssn;
	self.age := (string) l.age;
	self.dob.year :=(unsigned2) dob[1..4];
	self.dob.month :=(unsigned1) dob[5..6];
	self.dob.day :=(unsigned1) dob[7..8];
	self.dod.year :=(unsigned2) dod[1..4];
	self.dod.month := (unsigned1)dod[5..6];
	self.dod.day :=(unsigned1) dod[7..8];
	self.name.first := l.fname;
	self.name.middle := l.mname;
	self.name.last := l.lname;
	self.age_at_death := if(l.dod<>0 and l.age<>0, l.age - ut.Age(l.dod),0);
	self.ssn_issued_start_date := l.ssn_issued_start_date;
	self.ssn_issued_end_date := l.ssn_issued_end_date;
	self.ssn_valid := l.ssn_valid;
	self.ssn_issued_location := l.ssn_issued_location;
	self.hri_ssn := get_hri_ssn(l.ssn,l.did);
  self := [];
endmacro;

shared contactcard.layouts.subject_rec identity_flat_w_title(with_ssn_info_w_title l):=transform  
 self.name.title := l.title;
 get_id()
END;

ssn_info :=doxie.fn_SSN_Records (bestrecs,checkrna);

// Start fetching Imposters
with_ssn_info add_issuance_imposters(ssn_info l):=transform
	self.ssn_valid := yesNo(l.valid);
	self.ssn_issued_location := l.ssn_issue_place;
	self.ssn_issued_start_date := project(l,transform(personReports.Layouts.date.ymd, 
																				self.year		:=(integer)((STRING)left.ssn_issue_early)[1..4],
																				self.month	:=(integer)((STRING)left.ssn_issue_early)[5..6],
																				self.day		:=(integer)((STRING)left.ssn_issue_early)[7..8]));
	self.ssn_issued_end_date := project(l,transform(personReports.Layouts.date.ymd, 
																				self.year 	:=(integer)((STRING)left.ssn_issue_last)[1..4],
																				self.month	:=(integer)((STRING)left.ssn_issue_last)[5..6],
																				self.day 		:=(integer)((STRING)left.ssn_issue_last)[7..8]));
	self := l;
	self := [];
END;

pre_names_imposters := join(pre_subj_names,dids,left.did=right.did,left only);
names_imposters := join(pre_names_imposters,bestrecs,left.ssn=right.ssn_unmasked);

with_issuance_info_imposters := join(ssn_info,names_imposters,left.ssn_unmasked=right.ssn and left.did <> right.did,add_issuance_imposters(left),keep(1));


with_ssn_info get_dead(with_ssn_info l,doxie.key_death_masterv2_ssa_did r):=transform
	self.dod := (unsigned4)r.dod8;
	self.death_verification_code := r.VorP_code; //r.death_code;
	self.deceased := 'Y';
	self.IsLimitedAccessDMF := (r.src = MDR.sourceTools.src_Death_Restricted);
	self := l;
	self := [];
END;

is_glb_ok := mod_access.isValidGLB (checkrna);
deathparams := DeathV2_Services.IParam.GetFromDataAccess(mod_access);

imposters_w_d_info  := dedup(sort(
														join(with_issuance_info_imposters,doxie.key_death_masterv2_ssa_did, 
																keyed(left.did =right.l_did) and right.dod8!='' and 
																not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, is_glb_ok, deathparams),
																get_dead(left,right),left outer,limit(1000)),
													did,record,if(death_verification_code<>'',0,1)),
											did,record,except dod, death_verification_code);


with_did := record
	dataset(personReports.Layouts.identity) akas {maxcount(20)};
	unsigned6 did;
	integer3 address_seq_no;
END;

personReports.Layouts.identity identity_flat(with_ssn_info l):=transform
 self.IsLimitedAccessDMF := l.IsLimitedAccessDMF;
	get_id()
END;

with_did do_identity(with_ssn_info l):=transform
	self.akas := project(l,identity_flat(left));
	self.did := l.did;
	self.address_seq_no := l.address_seq_no;
END;
											
proj_imposters := group(sort(project(imposters_w_d_info,do_identity(left)),did),did);

with_did roll_identity(with_did l,dataset(with_did) r):=transform
	self.akas :=choosen(r.akas,PersonReports.layouts.max_akas);
	self.did := l.did;
	self.address_seq_no := l.address_seq_no;
END;

roll_imposters0 := rollup(proj_imposters,group,roll_identity(left,rows(left)));

export imposters :=choosen(project(roll_imposters0,PersonReports.layouts.indiv_imposter),PersonReports.layouts.max_imp);// row({roll_imposters},PersonReports.layouts.indiv_imposter);
// END Imposters Fetch

// Subject_Information : Append issuance to best record for use outside this module
prep_bestrecs := project(bestrecs, transform(layout_comp_names_w_title, self := left, self := []));
bestrecs_w_issuance0 := project(join(prep_bestrecs,sslr,
																(unsigned)left.ssn[1..5] > 0 and left.ssn[1..5]=right.ssn5_unmasked,
																add_issuance_w_title(left,right),keep(1),left outer),
															identity_flat_w_title(left));

Suppress.MAC_Mask(bestrecs_w_issuance0, export bestrecs_w_issuance_contactcard, ssn, null, true, false, maskVal := mod_access.ssn_mask);

// AKAS Section
subj_names := join(pre_subj_names,dids,left.did=right.did);
with_issuance_info_subj0 := join(subj_names,sslr,left.ssn[1..5]=right.ssn5_unmasked,add_issuance_w_title(left,right),keep(1),left outer);
Suppress.MAC_Mask(with_issuance_info_subj0, with_issuance_info_subj, ssn, null, true, false, maskVal := mod_access.ssn_mask);

with_ssn_info_w_title add_dls(with_ssn_info_w_title l, roll_dlsr r):=transform
	self.drivers_licenses := r.drivers_licenses;
	self.title := l.title;
	self := l;
END;

subj_w_dl_info := join(with_issuance_info_subj,roll_dlsr,
											left.did=right.did and 
											left.fname=right.fname and left.mname=right.mname and left.lname=right.lname,
											add_dls(left,right),left outer,keep(1));

proj_names_subj := choosen(sort(project(subj_w_dl_info,identity_flat_w_title(left)),if(ssn_valid=yesNo(true),0,1)),PersonReports.layouts.max_akas);
export Akas :=proj_names_subj;

END;