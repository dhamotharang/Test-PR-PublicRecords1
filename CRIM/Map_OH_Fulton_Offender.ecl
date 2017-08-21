import crim_common, Crim, Address;

comb_layout := record, maxlength(4096)
  string source;
  string ID;
  string Defendant;
  string FirstName;
  string MiddleName;
  string LastName;
  string Suffix;
  string DOB;
  string Address;
  string City;
  string State;
  string Zip;
  string Caption;
  string DefendantAttorney;
  string Type;
  string CaseStatus;
  string PartyType;
  string DispositionStatusDate;
  string DispositionCode;
  string Charge_Decision;
  string Charge_TicketNumber;
  string Charge_OffenseDescription;
  string Charge_Description;
  string Charge_IndictCharge;
  string Charge_AMD_Charge;
  string TypeDescription;
  string CaseNumber;
  string CaseFiled;
  string PartyName;
  string DispositionStatus;
  string DispositionDate;
  string DispositionActionCode;
  string PrelimCaseNumber;
  string Jurisdiction;
  string DegreeOffense;
  string OffenseDate;
  string ArrestDate;
  string Officer;
  string Complainant;
  string Prosecutor;
  string Judge;
  string DriversLicenseNumber;
  string CountyOfResidence;
  string Charge_Number;
  string Charge_PleaCode;
  string Charge_PleaCodeDate;
  string Charge_DecisionDate;
  string Charge_DispositionDate;
  string Charge_DispositionCode;
  string Charge_ActionCode;
  string Charge_DegreeOfOffense;
  string Charge_AMD_Charge_DGOF;
  string Charge_ACNT_Change_Date;
  string Charge_Counts;
  string Charge_Misc_Track;
end;

comb_layout reformat_west(crim.File_OH_Fulton.Fulton_west l) := transform
	self.source := 'W';
	self := l;
	self := [];
end;

new_west := project(crim.File_OH_Fulton.Fulton_west(CaseNumber <> 'CaseNumber'), reformat_west(left));

comb_layout reformat(crim.File_OH_Fulton.Fulton l) := transform
	self.source := 'F';
	self := l;
	self := [];
end;

new_fulton := project(crim.File_OH_Fulton.Fulton(CaseNumber <> 'CaseNumber'), reformat(left));

Crim_Common.Layout_In_Court_Offender tOHOffend(comb_layout l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Development;
self.offender_key		:= '2I'+trim(l.CaseNumber,left,right)+fSlashedMDYtoCYMD(trim(l.CaseFiled,left,right));
self.vendor				:= '2I';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= 'OH Fulton CRIM CT';
self.case_number		:= trim(l.casenumber,left,right);
self.case_court			:= '';
self.case_name			:= trim(if(l.caption <> '' and l.casenumber <> '', regexreplace(l.casenumber, l.caption, ''), l.caption), left, right);
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(l.CaseFiled) between '19010101' and Crim_Common.Version_Production, fSlashedMDYtoCYMD(l.CaseFiled), '');
self.pty_nm				:= l.defendant;
self.pty_nm_fmt			:= 'L';
self.orig_lname			:= trim(l.lastname,left,right);
self.orig_fname			:= trim(l.firstname,left,right);     
self.orig_mname			:= trim(l.middlename,left,right);
self.orig_name_suffix	:= trim(l.suffix,left,right);
self.pty_typ			:= '0';
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= l.id;
self.dl_num				:= l.DriversLicenseNumber;
self.dl_state			:= '';
self.citizenship		:= '';
self.dob				:= if(fSlashedMDYtoCYMD(l.dob) between '19010101' and (string)((integer)Crim_Common.Version_Production - 18), fSlashedMDYtoCYMD(l.dob), '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:=  if(~regexfind('(UNKNOWN)|^(\\(ALSO\\))|^(AKA)|^(A\\K\\A)|^(DBA)|^(D\\B\\A)',l.address) and length(trim(l.address)) > 7,	trim(stringlib.stringfilterout(l.address, '%'),left,right),'');
self.street_address_2	:= '';
self.street_address_3	:= trim(l.city,left,right);
self.street_address_4	:= trim(l.state,left,right);
self.street_address_5	:=  if((length(trim(l.zip,left,right)) = 5 or length(trim(l.zip,left,right)) = 9) and
							 regexfind('[1-9]', l.zip), trim(l.zip,left,right),'');
self.race				:= '';
self.race_desc			:= '';
self.sex				:= '';
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= '';
self.weight				:= '';
self.party_status		:= '';
self.party_status_desc	:= '';
self.prim_range 		:= ''; 
self.predir 			:= '';					   
self.prim_name 			:= '';
self.addr_suffix 		:= '';
self.postdir 			:= '';
self.unit_desig 		:= '';
self.sec_range 			:= '';
self.p_city_name 		:= '';
self.v_city_name 		:= '';
self.state 				:= '';
self.zip5 				:= '';
self.zip4 				:= '';
self.cart 				:= '';
self.cr_sort_sz 		:= '';
self.lot 				:= '';
self.lot_order 			:= '';
self.dpbc 				:= '';
self.chk_digit 			:= '';
self.rec_type 			:= '';
self.ace_fips_st		:= '';
self.ace_fips_county	:= '';
self.geo_lat 			:= '';
self.geo_long 			:= '';
self.msa 				:= '';
self.geo_blk 			:= '';
self.geo_match 			:= '';
self.err_stat 			:= '';
self.title 				:= '';
self.fname 				:= '';
self.mname 				:= '';
self.lname 				:= '';
self.name_suffix 		:= '';
self.cleaning_score 	:= ''; 

end;

pOHOffend := project(new_west + new_fulton, tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend(pty_nm <> '' and ~regexfind('[0-9]|\\&', pty_nm)),hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_OH_Fulton_Offender_Clean');

export Map_OH_Fulton_Offender := fOHOffend;