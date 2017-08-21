EXPORT Mod_Collisions(string month) := Module

SHARED threashold:=enum(unsigned1,Low,Medium,High);
SHARED score_threashold:=threashold;
SHARED ssn_threashold:=threashold;
SHARED dob_threashold:=threashold;

EXPORT FileBase:=NAC_V2.Files().BaseBadAddressRemoved;

//////////////////////////////////
matchset:=['N','S','D'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,1
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_S_D_col:=dsOut;
//////////////////////////////////
matchset:=['V','S','D'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,2
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT V_S_D_col:=dsOut;
//////////////////////////////////
matchset:=['N','S','B'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,3
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.Medium
										);

EXPORT N_S_B_col:=dsOut;
//////////////////////////////////
matchset:=['V','S','B'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,4
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT V_S_B_col:=dsOut;
//////////////////////////////////
matchset:=['N','P','D'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,5
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.Medium
										,dob_threashold.High
										);

EXPORT N_P_D_col:=dsOut;
//////////////////////////////////
matchset:=['V','P','D'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,6
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT V_P_D_col:=dsOut;
//////////////////////////////////
matchset:=['N','P','B'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,7
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.Medium
										,dob_threashold.Medium
										);

EXPORT N_P_B_col:=dsOut;
//////////////////////////////////
matchset:=['V','P','B'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,8
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT V_P_B_col:=dsOut;
//////////////////////////////////
matchset:=['N','D','A','Z'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,9
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_D_A_Z_col:=dsOut;
//////////////////////////////////
matchset:=['N','D','A','C'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,10
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_D_A_C_col:=dsOut;
//////////////////////////////////
matchset:=['S'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,50
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT S_col:=dsOut;
//////////////////////////////////
matchset:=['L'];
NAC_V2.Mac_find_collisions(
										FileBase
										,matchset
										,0
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,NAC_V2.use_month
										,month
										,false
										,DID, DID_score
										,NAC_V2.Layouts.slim5
										,dsOut
										,score_threashold.Low
										,ssn_threashold.Low
										,dob_threashold.Low
										);

EXPORT L_col:=dsOut;
//////////////////////////////////
concat_all :=
			N_S_D_col
			+ N_S_B_col
			+ N_P_D_col
			+ N_P_B_col
			+ V_S_D_col
			+ V_S_B_col
			+ V_P_D_col
			+ V_P_B_col
			+ N_D_A_Z_col
			+ N_D_A_C_col
			+ S_col
			+
			L_col
			;
concat_all_d := DISTRIBUTE(concat_all, hash64(BenefitState,SearchBenefitType,SearchBenefitMonth,SearchCaseID));
concat_srt
					:=
							sort(concat_all_d
										,BenefitState
								,SearchBenefitType			// **** For POC
										,SearchBenefitMonth
										,SearchCaseID
										,SearchLastName
										,SearchFirstName
										,SearchMiddleName
										,SearchSSN
										,SearchDOB
										,CaseState
										,CaseID
										,ClientLastName
										,ClientFirstName
										,ClientMiddleName
										,ClientSSN
										,ClientDOB
										,pri
										,LexID
										,OrigSearchSequenceNumber
										,SearchClientID
										,LOCAL)
										:persist('~nac::persist::concat_srt')
										;
concat_ddp
					:=
							dedup(concat_srt
										,BenefitState
								,SearchBenefitType			// **** For POC
										,SearchBenefitMonth
										,SearchCaseID
										,SearchLastName
										,SearchFirstName
										,SearchMiddleName
										,SearchSSN
										,SearchDOB
										,CaseState
										,CaseID
										,ClientLastName
										,ClientFirstName
										,ClientMiddleName
										,ClientSSN
										,ClientDOB
										,LOCAL)
										:persist('~nac::persist::concat_ddp')
										;

	Collisions:=join(distribute(concat_ddp        ,hash64(BenefitState,SearchBenefitType,SearchBenefitMonth,SearchCaseID,SearchClientID))
									,distribute(Files().Collisions,hash64(BenefitState,SearchBenefitType,SearchBenefitMonth,SearchCaseID,SearchClientID))
									,   left.BenefitState=right.BenefitState
									and left.SearchBenefitType=right.SearchBenefitType
									and left.SearchBenefitMonth=right.SearchBenefitMonth
									and left.SearchCaseID=right.SearchCaseID
									and left.SearchClientID=right.SearchClientID
									and left.casestate=right.casestate
									and left.caseid=right.caseid
									and left.clientid=right.clientid
									,left only
									,local);


EXPORT NewCollisions := Collisions;

END;