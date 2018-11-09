Import Civ_Court, ut;
#option('multiplePersistInstances',FALSE);

Ct_Civ :=  Civ_Court.File_In_CT;
//Export Map_CT_Joins := Module
Lay_PartyCombined	:= Record	
				Integer4	CaseRefNum;
				Integer4	PartyID;
				Integer4	PartyCatID;
				Integer4	PartyNo;				
				String58	PartyPrefix;
				String40	PartyFirstName;
				String40	PartyMiddleName;
				String300	PartyLastName;
				String40	AddressLine1;
				String40	AddressLine2;
				String33	POBox;
				String40	SecUnitDesig;
				String26	CityTown;
				String2	StateCode;
				String50	Zip;
				String4	ZipPlus4;
				String40	BR_MST_LAST_NM;
				String20	BR_MST_FIRST_NM;
				String3	BR_MST_PREFIX;
				String10	BR_MST_MID_NM;
				String3	BR_MST_SUFFIX;
				String30	BR_MST_OFFICE_ADDRESS_1;
				String30	BR_MST_OFFICE_ADDRESS_2;
				String20	BR_MST_OFFICE_CITY;
				String2	BR_MST_OFFICE_STATE_CD;
				String9	BR_MST_OFFICE_ZIP;
				String8	BR_MST_REINSTATED_DT;				
End;	
Lay_PartyCombined xParty_AttySelfRep(CT_Civ.File_eParty L, CT_Civ.File_eSelfRepAppearance R) := Transform
Self:= L;
Self :=R;
Self := [];
End;
Party_AttySelfRep := Join(Distribute(CT_Civ.File_eParty(caserefnum <> 0), Hash32(PartyID, CaseRefNum)),
															Distribute( CT_Civ.File_eSelfRepAppearance(caserefnum <> 0), Hash32(PartyID, CaseRefNum)),
															Left.CaseRefNum = Right.CaseRefNum and Left.PartyID = Right.PartyID , xParty_AttySelfRep(Left, Right), Left Outer, Local);

dParty_AttySelfRep := Dedup(Sort(Distribute(Party_AttySelfRep, Skew(0.1)), Record, local), Record, local);
Lay_PartyCombined xAttyApp_VBR(CT_Civ.File_eAttyAppearance L, CT_Civ.File_vendor_BarMaster R) := Transform
Self.BR_MST_LAST_NM := ut.CleanSpacesAndUpper(R.BR_MST_LAST_NM);
Self.BR_MST_FIRST_NM := ut.CleanSpacesAndUpper(R.BR_MST_FIRST_NM);
Self.BR_MST_PREFIX := ut.CleanSpacesAndUpper(R.BR_MST_PREFIX);
Self.BR_MST_MID_NM := ut.CleanSpacesAndUpper(R.BR_MST_MID_NM);
Self.BR_MST_SUFFIX := ut.CleanSpacesAndUpper(R.BR_MST_SUFFIX);
Self.BR_MST_OFFICE_ADDRESS_1 := ut.CleanSpacesAndUpper(R.BR_MST_OFFICE_ADDRESS_1);
Self.BR_MST_OFFICE_ADDRESS_2 := ut.CleanSpacesAndUpper(R.BR_MST_OFFICE_ADDRESS_2);
Self.BR_MST_OFFICE_CITY := ut.CleanSpacesAndUpper(R.BR_MST_OFFICE_CITY);
Self.BR_MST_OFFICE_STATE_CD := ut.CleanSpacesAndUpper(R.BR_MST_OFFICE_STATE_CD);
Self.BR_MST_OFFICE_ZIP := ut.CleanSpacesAndUpper(R.BR_MST_OFFICE_ZIP);
Self.BR_MST_REINSTATED_DT :=R.BR_MST_REINSTATED_DT;
Self := L;
Self := [];
End;

 AttyApp_VBR := Join(Distribute(CT_Civ.File_eAttyAppearance(caserefnum<>0 and jurisNo<>''), Hash32(JurisNo)), 
													Distribute(CT_Civ.File_vendor_BarMaster(BR_MST_JURIS_NO <>''), Hash32(BR_MST_JURIS_NO)),
													Left.JurisNo =Right.BR_MST_JURIS_NO, xAttyApp_VBR(Left, Right), Left Outer, Local);
Lay_PartyCombined xParty_AttyApp_VBR(Party_AttySelfRep L, AttyApp_VBR R) := Transform
Self:= L;
Self :=R;
Self := [];
End;
Party_AttyApp_VBR := Join(	Distribute(Party_AttySelfRep(caserefnum <> 0), Hash32(PartyID, CaseRefNum)), 
															Distribute(AttyApp_VBR(caserefnum <> 0), Hash32(PartyID, CaseRefNum)),
															Left.CaseRefNum = Right.CaseRefNum and Left.PartyID = Right.PartyID , xParty_AttyApp_VBR(Left, Right), Left Outer, Local):INDEPENDENT;
dParty_AttyApp_VBR := Dedup(Sort(Distribute(Party_AttyApp_VBR, Skew(0.1)), record, local), record, local);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Lay_MatterActivity := Record
		Integer4	CaseRefNum;
		String10	LocCode;
		String10	CTMajorCd;
		String10	CTMinorCd;
		String100	CTDesc;
		String50	PlaintCapName;
		String10	PlaintETAL;
		String50	DefnCapName;
		String10	DefnETAL;
		String100	LocDesc;
		String2	ListTypeCode;
		String30	ListTypeDesc;
		String100	DocName;
		String50	DispositionDockLegCode;
		String19	WritEntryDate;
		String19	TrialListClaimDate;
		String19	VerdictTrialCompleteDate;
		String19	InitDispositionDate;
		String19	AppealAppellateDate;
		String19	AppealSupremeCourtDate;
		String19	DispOfAppealDate;
		String19	ReturnDate;
		String19	FileDate;
		String19	DispositionDate;
		String19	AssignedDate;
		String19	ReferralDate;
End;

// ACTIVITY AND MATTER FILE JOINS

Lay_MatterActivity xJudCase_CaseType(CT_Civ.File_JUDCase L, CT_Civ.File_CaseType R) := Transform
Self.LocDesc := Map(	L.LocCode = 'AAN' => 'CT CIVIL: ANSONIA-MILFORD', 
										L.LocCode = 'DBD' => 'CT CIVIL: DANBURY', 
										L.LocCode = 'FBT' => 'CT CIVIL: FAIRFIELD', 
										L.LocCode = 'FST' => 'CT CIVIL: STAMFORD-NORWALK', 
										L.LocCode = 'HHB' => 'CT CIVIL: NEW BRITAIN', 
										L.LocCode = 'HHD' => 'CT CIVIL: HARTFORD', 
										L.LocCode = 'KNL' or L.LocCode = 'KNO'=> 'CT CIVIL: NEW LONDON', 
										L.LocCode = 'LLI' => 'CT CIVIL: LITCHFIELD', 
										L.LocCode = 'MMX' => 'CT CIVIL: MIDDLESEX', 
										L.LocCode = 'NNH' or L.LocCode = 'NNI' => 'CT CIVIL: NEW HAVEN', 
										L.LocCode = 'QGY' => 'CT CIVIL: GRAVEYARD', 
										L.LocCode = 'TSR' => 'CT CIVIL: GA19', 
										L.LocCode = 'TTD' => 'CT CIVIL: TOLLAND', 
										L.LocCode = 'UWY' => 'CT CIVIL: WATERBURY', 
										L.LocCode = 'WWM' => 'CT CIVIL: WINDHAM', '');
Self.ListTypeCode := Map(	L.ListTypeID =-1 => 'NO',
												L.ListTypeID =1 => '00',
												L.ListTypeID =2 => 'AA',
												L.ListTypeID =3 => 'CT',
												L.ListTypeID =8 => 'HD',
												L.ListTypeID =9 => 'JY', '');
Self.ListTypeDesc := Map(	L.ListTypeID =-1 => 'NO LIST TYPE', 
												L.ListTypeID =1 => 'REMOVED FROM TRIAL LIST', 
												L.ListTypeID =2 => 'ADMINISTRATIVE APPEALS', 
												L.ListTypeID =3 => 'COURT',  
												L.ListTypeID =8 => 'HEARINGS IN DAMAGES', 
												L.ListTypeID =9 => 'JURY', '');
Self.CTDesc :=  ut.CleanSpacesAndUpper(R.CTDesc);
Self := L;
Self := R;
Self := [];
End;
//JudCase+CaseType
JudCase_CaseType := Join(Distribute(CT_Civ.File_JUDCase, Hash32(CTMajorCd, CTMinorCd)), 
											CT_Civ.File_CaseType, 
											Trim(Trim(Left.CTMajorCd, left, right) + Trim(Left.CTMinorCd, left, right)) = Trim(Trim(Right.CTMajorCd, left, right) + Trim(Right.CTMinorCd, left, right)),
											xJudCase_CaseType(Left, Right), Left Outer, Lookup, local);

Lay_MatterActivity xJcCtDoc(JudCase_CaseType L, CT_Civ.File_DocumentType R) := Transform
Self.DocName := ut.CleanSpacesAndUpper(R.DocName);
Self := L;
Self :=  R;
Self := [];
End;
//JudCase+CaseType+DocumentType
JcCt_Doc := join(Distribute(JudCase_CaseType, Hash32(DispositionDockLegCode)),
										CT_Civ.File_DocumentType,
										Left.DispositionDockLegCode = Right.DockLegCode, xJcCtDoc(Left, Right),  Left outer, Lookup, local);

Lay_MatterActivity xJcCtDoc_Kpd(JcCt_Doc L, CT_Civ.File_KeyPointDates R) := Transform
Self.WritEntryDate := CT_Civ.DateConversion(R.WritEntryDate[1..10]);
Self.TrialListClaimDate := CT_Civ.DateConversion(R.TrialListClaimDate[1..10]);
Self.VerdictTrialCompleteDate := CT_Civ.DateConversion(R.VerdictTrialCompleteDate[1..10]);
Self.InitDispositionDate := CT_Civ.DateConversion(R.InitDispositionDate[1..10]);
Self.AppealAppellateDate := CT_Civ.DateConversion(R.AppealAppellateDate[1..10]);
Self.AppealSupremeCourtDate := CT_Civ.DateConversion(R.AppealSupremeCourtDate[1..10]);
Self.DispOfAppealDate := CT_Civ.DateConversion(R.DispOfAppealDate[1..10]);
Self.ReturnDate := CT_Civ.DateConversion(R.ReturnDate[1..10]);
Self.FileDate := CT_Civ.DateConversion(R.FileDate[1..10]);
Self.DispositionDate := CT_Civ.DateConversion(R.DispositionDate[1..10]);
Self.AssignedDate := CT_Civ.DateConversion(R.AssignedDate[1..10]);
Self.ReferralDate := CT_Civ.DateConversion(R.ReferralDate[1..10]);
Self := L;
Self := [];
End;
//JudCase+CaseType+DocumentType+KeyPointDates
JcCtDoc_Kpd := join(Distribute(JcCt_Doc(caserefnum<>0), Hash32(CaseRefNum)),
										Distribute(CT_Civ.File_KeyPointDates(caserefnum<>0), Hash32(CaseRefNum)),
										Left.CaseRefNum = Right.CaseRefNum, xJcCtDoc_Kpd(Left, Right), Left outer, Local);
dJcCtDoc_Kpd := Dedup(Sort(Distribute(JcCtDoc_Kpd, Skew(0.1)), record, local), record, local):INDEPENDENT;

Lay_PartyMap := Record
Lay_PartyCombined;
Lay_MatterActivity and not caserefnum;
End;

Lay_PartyMap xform1(dParty_AttyApp_VBR L , dJcCtDoc_Kpd R) := Transform
Self := L;
Self := R;
Self := [];
End;


PartyMap := Join(dParty_AttyApp_VBR(Caserefnum<>0), dJcCtDoc_Kpd(Caserefnum<>0),
												Left.Caserefnum = Right.Caserefnum, xform1(Left, Right), Left Outer, Local);
dPartyMap := Dedup(Sort(Distribute(PartyMap, Skew(0.1)), record, local), record, local);
Export Map_CT_Joins := dPartyMap : Persist('~thor40::MappedJoins::CT::Civ_court');

