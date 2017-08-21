import ut, header, Std;

EXPORT Mod_Collisions2(dataset(Layout_Base2) Base) := MODULE

shared FileBase := project(Base
								,transform(NAC_V2.Layout_Base2
									,self.prim_name
											:= if(NAC_V2.fn_IsValidAddress(left.prim_name)
																			,left.prim_name
																			,'')
									,self:=left));

SHARED threashold:=enum(unsigned1,Low,Medium,High);
SHARED score_threashold:=threashold;
SHARED ssn_threashold:=threashold;
SHARED dob_threashold:=threashold;

//////////////////////////////////
matchset:=['N','S','D'];

EXPORT N_S_D_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,1
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

//////////////////////////////////
matchset:=['V','S','D'];

EXPORT V_S_D_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,2
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

//////////////////////////////////
matchset:=['N','S','B'];

EXPORT N_S_B_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,3
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.Medium
										);

//////////////////////////////////
matchset:=['V','S','B'];

EXPORT V_S_B_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,4
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

//////////////////////////////////
matchset:=['N','P','D'];

EXPORT N_P_D_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,5
										,score_threashold.High
										,ssn_threashold.Medium
										,dob_threashold.High
										);
										
//////////////////////////////////
matchset:=['V','P','D'];

EXPORT V_P_D_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,6
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

//////////////////////////////////
matchset:=['N','P','B'];

EXPORT N_P_B_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,7
										,score_threashold.High
										,ssn_threashold.Medium
										,dob_threashold.Medium
										,1
										) +
										NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,7
										,score_threashold.High
										,ssn_threashold.Medium
										,dob_threashold.Medium
										,2
										);

//////////////////////////////////
matchset:=['V','P','B'];

EXPORT V_P_B_col := NAC_V2.fn_find_collisions_ex(
										FileBase
										,matchset
										,8
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										,1
										) +
										NAC_V2.fn_find_collisions_ex(
										FileBase
										,matchset
										,8
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										,2
										);

//////////////////////////////////
matchset:=['N','D','A','Z'];

EXPORT N_D_A_Z_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,9
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

//////////////////////////////////
matchset:=['N','D','A','C'];

EXPORT N_D_A_C_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,10
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

//////////////////////////////////
matchset:=['S'];

EXPORT S_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,50
										,score_threashold.High
										,ssn_threashold.High
										,dob_threashold.High
										);

//////////////////////////////////
matchset:=['L'];

EXPORT L_col := NAC_V2.fn_find_collisions(
										FileBase
										,matchset
										,0
										,score_threashold.Low
										,ssn_threashold.Low
										,dob_threashold.Low
										);

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
			+ L_col
			;
concat_all_d := DISTRIBUTE(concat_all, hash32(BenefitState,SearchBenefitType,SearchCaseID));
concat_srt
					:=
							sort(concat_all_d
									,BenefitState
										,SearchBenefitType			
										,SearchGroupId			
										,SearchCaseID
										,SearchClientID
										,SearchEligibilityStatus
										,SearchLastName
										,SearchFirstName
										,SearchMiddleName
										,SearchSSN
										,SearchDOB
									,CaseState
										,CaseBenefitType			
										,CaseGroupId			
										,CaseID
										,ClientID
										,ClientEligibilityStatus
										,ClientLastName
										,ClientFirstName
										,ClientMiddleName
										,ClientSSN
										,ClientDOB
									,StartDate,EndDate
										,pri
										,LexID
										,OrigSearchSequenceNumber
										,LOCAL
										)
										//:persist('~nac::persist::concat_srt')
										;
				d	:=
							dedup(concat_srt
									,BenefitState
										,SearchBenefitType			
										,SearchGroupId			
										,SearchCaseID
										,SearchClientID
										,SearchEligibilityStatus
										,SearchLastName
										,SearchFirstName
										,SearchMiddleName
										,SearchSSN
										,SearchDOB
									,CaseState
										,CaseBenefitType			
										,CaseGroupId			
										,CaseID
										,ClientID
										,ClientEligibilityStatus
										,ClientLastName
										,ClientFirstName
										,ClientMiddleName
										,ClientSSN
										,ClientDOB
									,StartDate,EndDate
										,LOCAL
										)
										;
			c := DISTRIBUTE(d, hash32(benefitstate,SearchBenefitType,searchcaseid,searchclientid));
			c1 := SORT(c, 	benefitstate, SearchBenefitType, searchgroupid, searchcaseid, searchclientid,SearchEligibilityStatus,SearchLastName,
											casestate, CaseBenefitType, CaseGroupId, caseid, clientid,ClientEligibilityStatus,ClientLastName, startdate, LOCAL);
								
	c2 := ROLLUP(c1, 
									left.benefitstate=right.benefitstate AND left.SearchBenefitType=right.SearchBenefitType and
											left.searchGroupId=right.searchGroupId AND
											left.searchcaseid=right.searchcaseid AND
											left.searchclientid=right.searchclientid AND
										  left.SearchEligibilityStatus=right.SearchEligibilityStatus AND
										  left.SearchLastName=right.SearchLastName
									AND left.casestate=right.casestate AND left.CaseBenefitType=right.CaseBenefitType
										AND	left.caseGroupId=right.caseGroupId
										AND left.caseid=right.caseid AND left.clientid=right.clientid 										
										AND left.ClientEligibilityStatus=right.ClientEligibilityStatus
										AND left.ClientLastName=right.ClientLastName and
										//Std.Date.MonthsBetween((unsigned)left.enddate,(unsigned)right.startdate) <= 1,
										Std.Date.DaysBetween((unsigned)left.enddate,(unsigned)right.startdate) <= 1,
								TRANSFORM(NAC_V2.Layout_Collisions2.Layout_Collisions,
											self.StartDate := min(left.StartDate,right.StartDate);
											self.EndDate := max(left.EndDate,right.EndDate);
											self.MatchCodes := IF(length(trim(left.MatchCodes)) >= length(trim(right.MatchCodes)), left.MatchCodes, right.MatchCodes);
											self := right;), LOCAL);

	export AllCollisions := c2;

END;