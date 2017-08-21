import crim_common, Crim, Address, lib_stringlib;

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

new_west := project(crim.File_OH_Fulton.Fulton_west, reformat_west(left));

comb_layout reformat(crim.File_OH_Fulton.Fulton l) := transform
	self.source := 'F';
	self := l;
	self := [];
end;

new_fulton := project(crim.File_OH_Fulton.Fulton, reformat(left));

Crim_Common.Layout_In_Court_Offenses tOHCrim(comb_layout l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_Development;
self.offender_key		:= '2I'+trim(l.CaseNumber,left,right)+fSlashedMDYtoCYMD(trim(l.CaseFiled,left,right));
self.vendor 					:= '2I';
self.state_origin 				:= 'OH';
self.source_file 				:= 'OH Fulton CRIM CT';
self.off_comp 					:= l.charge_number;
self.off_delete_flag 			:= '';
self.off_date 					:= if(fSlashedMDYtoCYMD(l.offensedate) between '19010101' and Crim_Common.Version_Development, fSlashedMDYtoCYMD(l.offensedate), '');
self.arr_date 					:= '';
self.num_of_counts 				:= '';
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= l.jurisdiction;
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= l.charge_offensedescription;
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= '';
self.arr_statute 				:= stringlib.stringfilterout(l.charge_actioncode, '*');
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
self.arr_disp_desc_2 			:= '';
self.pros_refer_cd 				:= '';
self.pros_refer 				:= '';
self.pros_assgn_cd 				:= '';
self.pros_assgn 				:= '';
self.pros_chg_rej 				:= '';
self.pros_off_code 				:= '';
self.pros_off_desc_1 			:= '';
self.pros_off_desc_2 			:= '';
self.pros_off_type_cd 			:= '';
self.pros_off_type_desc 		:= '';
self.pros_off_lev 				:= '';
self.pros_act_filed 			:= '';
self.court_case_number 			:= l.casenumber;
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= l.charge_pleacode;
self.court_off_code 			:= '';
self.court_off_desc_1 			:= l.dispositionactioncode;
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= '';
self.court_statute 				:= stringlib.stringfilterout(if(l.charge_offensedescription = l.dispositionactioncode, l.charge_actioncode, ''), '*');
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(fSlashedMDYtoCYMD(l.charge_dispositiondate) between '19010101' and Crim_Common.Version_Development, fSlashedMDYtoCYMD(l.charge_dispositiondate), '');
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= l.charge_dispositioncode;
self.court_disp_desc_2 			:= '';
self.sent_date 					:= '';
self.sent_jail 					:= '';
self.sent_susp_time 			:= '';
self.sent_court_cost 			:= '';
self.sent_court_fine 			:= '';
self.sent_susp_court_fine 		:= '';
self.sent_probation 			:= '';
self.sent_addl_prov_code 		:= '';
self.sent_addl_prov_desc_1 		:= '';
self.sent_addl_prov_desc_2 		:= '';
self.sent_consec 				:= '';
self.sent_agency_rec_cust_ori 	:= '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 				:= '';
self.appeal_off_disp 			:= '';
self.appeal_final_decision 		:= '';

end;

pOHCrim := project(new_fulton + new_west, tOHCrim(left));

fOHOffend:= dedup(sort(distribute(pOHCrim(off_comp <> 'Char'),hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_OH_Fulton_Offenses_Clean');

export Map_OH_Fulton_Offenses := fOHOffend;