EXPORT Mod_Collisions(string month, DATASET(nac.Layouts.Base) FileBase=NAC.Files().BaseBadAddressRemoved) := Module

SHARED threashold:=enum(unsigned1,Low,Medium,High);
SHARED score_threashold:=threashold;
SHARED ssn_threashold:=threashold;
SHARED dob_threashold:=threashold;

//EXPORT FileBase:=NAC.Files().BaseBadAddressRemoved;

//////////////////////////////////
matchset:=['N','S','D'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,1
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_S_D_col:=dsOut;
//////////////////////////////////
matchset:=['V','S','D'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,2
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT V_S_D_col:=dsOut;
//////////////////////////////////
matchset:=['N','S','B'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,3
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.Medium
										);

EXPORT N_S_B_col:=dsOut;
//////////////////////////////////
matchset:=['V','S','B'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,4
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT V_S_B_col:=dsOut;
//////////////////////////////////
matchset:=['N','P','D'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,5
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.Medium
										,dob_threashold.High
										);

EXPORT N_P_D_col:=dsOut;
//////////////////////////////////
matchset:=['V','P','D'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,6
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT V_P_D_col:=dsOut;
//////////////////////////////////
matchset:=['N','P','B'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,7
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.Medium
										,dob_threashold.Medium
										);

EXPORT N_P_B_col:=dsOut;
//////////////////////////////////
matchset:=['V','P','B'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,8
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT V_P_B_col:=dsOut;
//////////////////////////////////
matchset:=['N','D','A','Z'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,9
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_D_A_Z_col:=dsOut;
//////////////////////////////////
matchset:=['N','D','A','C'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,10
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT N_D_A_C_col:=dsOut;
//////////////////////////////////
matchset:=['S'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,50
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
										,dsOut
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

EXPORT S_col:=dsOut;
//////////////////////////////////
matchset:=['L'];
NAC.Mac_find_collisions(
										FileBase
										,matchset
										,0
										,fname, mname, lname, name_suffix
										,clean_ssn, clean_dob
										,client_phone
										,PrepRecSeq
										,Case_Benefit_Month
										,nac.use_month
										,month
										,false
										,DID, DID_score
										,nac.Layouts.slim5
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

concat_srt
					:=
							sort(concat_all
										,SearchBenefitMonth
										,BenefitState
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
										)
										//:persist('~nac::persist::concat_srt')
										;
concat_ddp
					:=
							dedup(concat_srt
										,SearchBenefitMonth
										,BenefitState
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
										)
										//:persist('~nac::persist::concat_ddp')
										;

	Collisions:=join(distribute(concat_ddp        ,hash(BenefitState,SearchBenefitType,SearchBenefitMonth,SearchCaseID,SearchClientID))
									,distribute(Files().Collisions,hash(BenefitState,SearchBenefitType,SearchBenefitMonth,SearchCaseID,SearchClientID))
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