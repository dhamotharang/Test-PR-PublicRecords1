import crim_common, lib_stringlib, crim, address;

comb_layout := record, maxlength(4096)
string ID;
string Name;
string FirstName;
string MiddleName;
string LastName;
string Suffix;
string DateOfBirth;
string Address1;
string City;
string State;
string Zip;
string Alias;
string Caption;
string PreliminaryCaseNumber;
string Jurisdiction;
string Attorney;
string ActionCode;
string Description;
string Degree;
string ChargeDscr;
string OffenseDate;
string ArrestDate;
string Officer;
string Complainant;
string Prosecutor;
string Judge;
string CaseNumber;
string CaseFiled;
string CaseStatus;
string CaseComments;
string PartiesName;
string PartiesType;
string DispositionStatus;
string DispositionStatusDate;
string DispositionCode;
string DispositionDate;
string DispositionActionCode;
string Charge_Number;
string Charge_PleaCode;
string Charge_PleaCodeDate;
string Charge_Decision;
string Charge_DecisionDate;
string Charge_DispositionDate;
string Charge_DispositionCode;
string Charge_TicketNumber;
string Charge_ActionCode;
string Charge_OffenseDescription;
string Charge_Description;
string Charge_DegreeOfOffense;
string Charge_IndictCharge;
string Charge_AMD_Charge;
string Charge_AMD_Charge_DGOF;
string Charge_ACNT_Change_Date;
string Charge_Counts;
string Charge_Misc_Track;
string DispositionCde;
string HazMat;
string Points;
string PriorConviction;
string VehicleYear;
string StateCode;
string LicenseCode;
string LicenseNumber;
string VehicleCode;
string PlateNumber;
string PrimaryStr;
string SecondaryStr;
string OfficerCode;
string SpeedLimit;
string Speed;
string TicketNumber;
string DegreeOfOffense;
string ChargeDescription;
end;


austintown := crim.file_oh_mahoning.austintown;
boardmand := crim.file_oh_mahoning.boardman;
canfield := crim.file_oh_mahoning.canfield;
commonpleas := crim.file_oh_mahoning.commonpleas;
sebring := crim.file_oh_mahoning.sebring;

comb_layout reformatall(crim.Layout_OH_Mahoning.austintown l) := transform
	self.address1 := l.address;
	self := l;
	self := [];
end;

comb_layout reformatall2(crim.Layout_OH_Mahoning.commonpleas l) := transform
	self.address1 := l.address;
	self := l;
	self := [];
end;

inputMain := project(crim.File_OH_Mahoning.austintown + crim.File_OH_Mahoning.canfield + crim.File_OH_Mahoning.boardman + crim.File_OH_Mahoning.sebring, reformatall(left));
inputCommon := project(crim.File_OH_Mahoning.commonpleas, reformatall2(left));

combined := inputMain(name <> 'Name' and PartiesType = 'DEFENDANT') + inputCommon(name <> 'Name' and PartiesType = 'DEFENDANT');


Crim_Common.Layout_In_Court_Offenses tOHCrim(comb_layout l) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

string1 findfelony(string l) := 
if(regexfind('(FEL\\-[1-6] )|(F.[1-6] )|(F[1-6] )|(FELONY)|(felony)|(Felony)', l), 'F', '');

string1 findmisd(string l) := 
if(regexfind('(M.[1-6] )|(M[1-6] )|(MISDEMEANOR)|(misdemeanor)|(Misdemeanor)|(MISD)|(misd)|(Misd)', l), 'M', '');

string1 finddegree(string l) := 
if(regexfind('(1st)|(1ST)|(FIRST)|(first)|(First)', l), '1', 
if(regexfind('(2nd)|(2ND)|(FIRST)|(first)|(First)', l), '2', 
if(regexfind('(3RD)|(3rd)|(THIRD)|(Third)|(third)', l), '3', 
if(regexfind('(4th)|(4TH)|(FOURTH)|(Fourth)|(fourth)', l), '4', 
if(regexfind('(5th)|(5TH)|(FIFTH)|(Fifth)|(fifth)', l), '5', 
if(regexfind('(6th)|(6TH)|(SIXTH)|(Sixth)|(sixth)', l), '6', 
''))))));

self.process_date		:= Crim_Common.Version_Production;
self.offender_key		:= '2O'+trim(l.CaseNumber,left,right)+fSlashedMDYtoCYMD(trim(l.CaseFiled,left,right))+l.id;
self.vendor				:= '2O';
self.state_origin 				:= 'OH';
self.source_file 				:= 'OH Mahoning CRIM CT';
self.off_comp 					:= l.charge_number;
self.off_delete_flag 			:= '';
self.off_date 					:=  if(fSlashedMDYtoCYMD(l.offensedate) between '19010102' and Crim_Common.Version_Production, fSlashedMDYtoCYMD(l.offensedate), '');
self.arr_date 					:= if(fSlashedMDYtoCYMD(l.arrestdate) between '19010102' and Crim_Common.Version_Production, fSlashedMDYtoCYMD(l.arrestdate), '');
self.num_of_counts 				:= l.charge_counts;
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= regexreplace('(\\(DO NOT USE\\))', l.jurisdiction, '');
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= regexreplace('DEGREE', trim(regexreplace( '\\(.*\\)|' + ' .\\-. |' + ' [0-9]+\\.[0-9A-Z_]+ ' + '\\.[0-9]+\\.[0-9A-Z_]+ ', trim(regexreplace('(^(NA)$)|(^[0-9\\-\\.] )', if(l.charge_amd_charge = '', '',l.charge_offensedescription), '') + ' ', left), ' '), left, right), '');
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= regexreplace('[^MF0-9]', regexreplace('^(NA)$', regexreplace('(MM)' , regexreplace('(CONVERSION)' , if(l.charge_amd_charge = '', '',l.charge_degreeofoffense), ''), 'M'), ''), '');
self.arr_statute 				:= regexreplace('^(NA)$', if(l.charge_amd_charge = '', '',l.charge_actioncode), '');
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
self.court_case_number 			:= '';
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= if(regexfind('(NOT GUILTY)', l.charge_pleacode), 'NOT GUILTY', if(regexfind('(GUILTY)', l.charge_pleacode), 'GUILTY', ''));
self.court_off_code 			:= '';
self.court_off_desc_1 			:= regexreplace('DEGREE', trim(regexreplace( '\\(.*\\)|' + ' .\\-. |' + ' [0-9]+\\.[0-9A-Z_]+ ' + '\\.[0-9]+\\.[0-9A-Z_]+ ', trim(regexreplace('(^(NA)$)|(^[0-9\\-\\.] )', if(l.charge_amd_charge = '', l.charge_offensedescription,l.charge_amd_charge), '') + ' ', left), ' '), left, right), '');
self.court_off_desc_2			:= '';//regexreplace('^(NA)$', if(l.charge_amd_charge = '' and length(l.charge_description) > 3, if(l.charge_offensedescription = l.charge_description,'' , l.charge_description),''), '');
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= regexreplace('[^MF0-9]',regexreplace('(MM)' , regexreplace('(CONVERSION)|(FELONY/LIFE)' , if(l.charge_amd_charge = '', l.charge_degreeofoffense, l.charge_amd_charge_dgof), ''), 'M'), '');
self.court_statute 				:= regexreplace('^(NA)$', if(l.charge_amd_charge = '',trim(l.Charge_actionCode,left,right), ''), '');
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(fSlashedMDYtoCYMD(l.charge_dispositiondate) between '19010102' and Crim_Common.Version_Production, fSlashedMDYtoCYMD(l.charge_dispositiondate), '');
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= regexreplace('NO PLEA', if(regexfind('(PLEA)|(DISMISS)|(G/NC)|(GUILTY)', l.dispositioncode),
									trim(regexreplace('\\(.*\\)',l.dispositioncode, ''), left),
									if(regexfind('(PLEA)|(DISMISS)|(G/NC)|(GUILTY)', l.charge_dispositioncode), trim(regexreplace('\\(.*\\)',l.charge_dispositioncode, ''), left, right), 
									if(regexfind('(PLEA)|(DISMISS)|(G/NC)|(GUILTY)', l.charge_decision), trim(regexreplace('\\(.*\\)',l.charge_decision, ''), left, right), ''))), '');
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

pOHCrimtemp := project(combined,tOHCrim(left));

Crim_Common.Layout_In_Court_Offenses tOHCrim2(Crim_Common.Layout_In_Court_Offenses l) := Transform

string repLev(string l) := 
regexreplace('(\\[M.[1-6]\\] )|(\\[F.[1-6]\\] )|(M.[1-6] )|(M[1-6] )|(MISDEMEANOR)|(misdemeanor)|(Misdemeanor)|(MISD)|(misd)|(Misd)|(FEL\\-[1-6] )|(F.[1-6] )|(F[1-6] )|(FELONY)|(felony)|(Felony)', l, '');

// string1 findmisd(string l) := 
// if(regexfind('', l), 'M', '');

string repDeg(string l) := 
regexreplace('(1st)|(1ST)|(FIRST)|(first)|(First)|(2nd)|(2ND)|(FIRST)|(first)|(First)|(3RD)|(3rd)|(THIRD)|(Third)|(third)|(4th)|(4TH)|(FOURTH)|(Fourth)|(fourth)|(5th)|(5TH)|(FIFTH)|(Fifth)|(fifth)|(6th)|(6TH)|(SIXTH)|(Sixth)|(sixth)', l, '');

self.court_off_lev := if(l.court_off_lev[1..1] = 'F', stringlib.stringfindreplace(regexreplace('[^A-Z0-9]', l.court_off_lev, ''), 'FF', 'F'), if(trim(l.court_off_lev,left)[1..1] = 'M', 
						'M' + regexreplace('1' , regexreplace('2' , regexreplace('3' , regexreplace('4' , regexreplace('5' , regexreplace('6' , trim(l.court_off_lev,left)[2..2], 'F'), 'E'), 'D'), 'C'), 'B'), 'A'), l.court_off_lev[1..1]));
self.arr_off_lev := if(l.arr_off_lev[1..1] = 'F', stringlib.stringfindreplace(regexreplace('[^A-Z0-9]', l.arr_off_lev, ''), 'FF', 'F'), if(trim(l.arr_off_lev,left)[1..1] = 'M', 
						'M' + regexreplace('1' , regexreplace('2' , regexreplace('3' , regexreplace('4' , regexreplace('5' , regexreplace('6' , trim(l.arr_off_lev, left)[2..2], 'F'), 'E'), 'D'), 'C'), 'B'), 'A'), l.arr_off_lev[1..1]));
self.arr_off_desc_1 := trim(regexreplace('\\-$|/$|/ +/' ,trim(repDeg(repLev(l.arr_off_desc_1)), left, right), ''), left, right);
self.court_off_desc_1 := trim(regexreplace('\\-$|/$|/ +/' ,trim(repDeg(repLev(l.court_off_desc_1)), left, right), ''), left, right);

self := l;
end;

pOHCrim := project(pOHCrimtemp,tOHCrim2(left))
			(off_date + arr_date + arr_off_desc_1 + arr_off_lev + arr_statute + court_off_desc_1 + court_off_lev + court_statute <> '');


fOHOffend:= dedup(sort(distribute(pOHCrim,hash(offender_key)),
									offender_key,off_comp,-arr_off_desc_1, court_off_desc_1, -court_disp_date,local),
									offender_key,off_comp,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_OH_Mahoning_Offenses_Clean');

export map_OH_Mahoning_Offenses	:= fOHOffend;
