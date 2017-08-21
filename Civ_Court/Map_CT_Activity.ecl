Import Civ_Court, Civil_Court;
#option('multiplePersistInstances',FALSE);

Matt_Act := Civ_Court.Map_CT_Joins;
Ct_Civ :=  Civ_Court.File_In_CT;

Civil_Court.Layout_In_Case_Activity tCTCiv(Matt_Act L, Unsigned1 c) := Transform
Self.process_date 			:= civil_court.Version_Development;
Self.vendor							:='04';
Self.state_origin				:='CT';
Self.source_file				:='CT-CIVIL-COURT';
Self.case_key					:= '04'+ Trim(L.LocCode, Left, Right) +(String)L.CaseRefNum;
Self.court_code				:= L.LocCode;
Self.court						:= L.LocDesc;
Self.case_number				:= (String) L.CaseRefNum;
Self.event_type_code := '';
Self.event_type_description_2 := '';
Self.event_date := Choose(c, 	
												If ((integer) L.ReturnDate <> 0, L.ReturnDate, Skip),
												If ((integer) L.InitDispositionDate <> 0, L.InitDispositionDate, Skip),
												If ((integer) L.DispOfAppealDate <> 0, L.DispOfAppealDate, Skip),
												If ((integer) L.AssignedDate <> 0, L.AssignedDate, Skip),
												If ((integer) L.AppealAppellateDate <> 0, L.AppealAppellateDate, Skip),
												If ((integer) L.ReferralDate <> 0, L.ReferralDate, Skip),
												If ((integer) L.AppealSupremeCourtDate <> 0, L.AppealSupremeCourtDate, Skip),
												If ((integer) L.TrialListClaimDate <> 0, L.TrialListClaimDate, Skip),
												If ((integer) L.VerdictTrialCompleteDate <> 0, L.VerdictTrialCompleteDate, Skip),
												If ((integer) L.WritEntryDate <> 0, L.WritEntryDate, Skip),
												If ((integer) L.BR_MST_REINSTATED_DT <> 0, L.BR_MST_REINSTATED_DT, Skip));
Self.event_type_description_1 := Choose(c,		
																		If ((integer) L.ReturnDate <> 0, 'CASE RETURNED', Skip),
																		If ((integer) L.InitDispositionDate <> 0, 'DISPOSITION', Skip),
																		If ((integer) L.DispOfAppealDate <> 0, 'DISPOSITION OF APPEAL', Skip),
																		If ((integer) L.AssignedDate <> 0, 'FIRST ASSIGNMENT', Skip),
																		If ((integer) L.AppealAppellateDate <> 0, 'INTERMEDIATE APPEAL', Skip),
																		If ((integer) L.ReferralDate <> 0, 'REFERRED TO REFEREE', Skip),
																		If ((integer) L.AppealSupremeCourtDate <> 0, 'SUPREME COURT APPEAL', Skip),
																		If ((integer) L.TrialListClaimDate <> 0, 'TRIAL LIST CLAIM', Skip),
																		If ((integer) L.VerdictTrialCompleteDate <> 0, 'VERDICT ENTERED/TRIAL', Skip),
																		If ((integer) L.WritEntryDate <> 0, 'WRIT ENTRY', Skip), 
																		If ((integer) L.BR_MST_REINSTATED_DT <> 0, 'CASE REINSTATED/REENTERED',  Skip));
End;
CT_Activity := Normalize(Matt_Act, 11, tCTCiv(Left, counter));

ddCT_Activity:= dedup(sort(distribute(CT_Activity,hash(case_number)),
									case_number,case_key,court_code,court,case_number,event_date,event_type_description_1,local),
									record, local, left): PERSIST('~thor_200::in::civil_CT_Activity');
									
Export Map_CT_Activity := ddCT_Activity;