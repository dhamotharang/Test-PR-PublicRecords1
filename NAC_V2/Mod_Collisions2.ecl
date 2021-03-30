﻿import ut, header, Std;

EXPORT Mod_Collisions2(dataset(Layout_Base2) Base) := MODULE
/**
suppress address if:
1) it does not clean correctly
2) It hais an invalid prim name
3) The address category is not blank
**/ 

shared FileBase := $.fn_suppress_addr(Base);

shared threashold:=enum(unsigned1,Low,Medium,High);
shared score_threashold:=threashold;
shared ssn_threashold:=threashold;
shared dob_threashold:=threashold;

/*
Best Match
// L             LexId
Exact Matches
// N             Name: last name, first or preferred first
// S             Full SSN
// D             DOB
Address Matches
// A             Address: prim range & prim name
// C             City/State 
// Z             Zip 
Fuzzy Matches
// P             Fuzzy SSN
// B             Fuzzy DOB
// V             Partial name (Last Name + First Initial)
// W             Last Name only
Future Use
// H             Phone
*/
/*
Search Types
Match Set				Priority
L									0							LexId
NSD								1							Name, SSN, DOB
VSD								2							Partial Name, SSN, DOB
NSB								3							Name, SSN, Fuzzy DOB
VSB								4							Partial Name, SSN, Fuzzy DOB
NPD								5							Name, Fuzzy SSN, DOB
VPD								6							Partial Name, Fuzzy SSN, DOB
NPB								7							Name, Fuzzy SSN, Fuzzy DOB
VPB								8							Partial Name, Fuzzy SSN, Fuzzy DOB
NDAZ							9							Name, DOB, Address, Zip
NDAC							10						Name, DOB, Address, City
S									50						SSN

*/

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
concat_all_d := DISTRIBUTE(concat_all, hash32(SearchGroupId,SearchCaseID,SearchClientID));
concat_srt
					:=
							sort(concat_all_d
									,SearchGroupId			
										,SearchCaseID
										,SearchClientID
									  ,BenefitState
										,SearchBenefitType			
										,SearchEligibilityStatus
										,SearchSSN
										,SearchDOB
									,CaseGroupId			
										,CaseID
										,ClientID
									  ,CaseState
										,CaseBenefitType			
										,ClientEligibilityStatus
										,ClientSSN
										,ClientDOB
									,-StartDate			//,EndDate  Choose match with most recent start date
										,pri
										,LexID
										,OrigSearchSequenceNumber
										,LOCAL
										)
										//:persist('~nac::persist::concat_srt')
										;
				d	:=
							dedup(concat_srt
									,SearchGroupId			
										,SearchCaseID
										,SearchClientID
									  ,BenefitState
										,SearchBenefitType			
										,SearchEligibilityStatus
										,SearchSSN
										,SearchDOB
									,CaseGroupId			
										,CaseID
										,ClientID
									  ,CaseState
										,CaseBenefitType			
										,ClientEligibilityStatus
										,ClientSSN
										,ClientDOB
									//,StartDate,EndDate
										,LOCAL
										)
										;
			c := DISTRIBUTE(d, hash32(SearchGroupId,SearchCaseID,SearchClientID));
			c1 := SORT(c, 	SearchGroupId,SearchCaseID,SearchClientID,
											benefitstate, SearchBenefitType, SearchEligibilityStatus,SearchLastName,
											casestate, CaseBenefitType, CaseGroupId, caseid, clientid,ClientEligibilityStatus,ClientLastName, startdate, LOCAL);
								
	c2 := ROLLUP(c1, 
										left.searchGroupId=right.searchGroupId AND
											left.searchcaseid=right.searchcaseid AND
											left.searchclientid=right.searchclientid AND
									left.benefitstate=right.benefitstate AND left.SearchBenefitType=right.SearchBenefitType and
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