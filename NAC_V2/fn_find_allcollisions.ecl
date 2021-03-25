import header,ut,Std;

// L             LexId
// N             Name
// S             Full SSN
// P             Probable SSN
// D             DOB
// B             Probable DOB
// A             Street Address
// C             City/State Address
// Z             Zip Address
// V             Last Name + Partial First
// W             Last Name
// H             Phone
//
// first name match parameter:
//	0 match either
//  1 match first name
//  2 match preferred name 

strEq  (STRING str1, STRING str2) := str1 = str2 AND str2 <> '';
intEq  (unsigned8 int1, unsigned8 int2) := int1 = int2 AND int2 <> 0;
EXPORT fn_find_allcollisions	(
					dataset($.Layout_Base2) Base 
				) := FUNCTION
	
	infile := NORMALIZE(Base(eligibility_status_indicator <> 'N'),
										Std.Date.MonthsBetween(left.StartDate, left.EndDate) + 1,
										TRANSFORM(nac_V2.Layout_Base2_Ex,
												self.BenefitMonth := ((string)Std.Date.AdjustCalendar(left.StartDate, 0, COUNTER -1 , 0))[1..6];
												self := LEFT;));

	inf_dis := distribute(infile, hash32(BenefitMonth,lname));	//, lname, clean_ssn, clean_dob));
	
	match:=join(inf_dis,inf_dis,
		left.BenefitMonth = right.BenefitMonth 
		AND
			(left.ProgramState <> right.ProgramState
				OR
				(left.GroupId = right.GroupId and 
					nac_v2.GetCollisionCode(left.ProgramCode) = nac_v2.GetCollisionCode(right.ProgramCode)
					and left.CaseId <> right.CaseId
					and left.ClientId <> right.ClientId
				)
				OR
				(left.GroupId <> right.GroupId and 
					nac_v2.GetCollisionCode(left.ProgramCode) = nac_v2.GetCollisionCode(right.ProgramCode)
				)
			)
		AND left.PrepRecSeq<>right.PrepRecSeq
		AND (
		(	
			left.lname=right.lname and
			(
				left.fname=right.fname
				    OR
				strEq(left.prefname,right.prefname)
						OR
			// fuzzy name match
				left.fname[1]=right.fname[1]
						OR
				strEq(left.prefname[1],right.prefname[1]))
						OR
				 (left.fname<>right.fname and
					left.prefname<>right.prefname and
					nac_v2.NNEQ_Suffix(left.name_suffix,right.name_suffix)
				 )			 
			)
			OR
				strEq(left.clean_ssn,right.clean_ssn)
			OR // fuzzy SSN
						//ssn_med(left.SearchCleanSSN, right.CaseCleanSSN) and
				NAC_V2.ssn_value(left.clean_ssn,right.clean_ssn) > 0
			OR
				intEq(left.clean_dob,right.clean_dob)
			OR
			(
				nac_v2.gens_ok(left.name_suffix,left.clean_dob,right.name_suffix,right.clean_dob) and
				header.date_value(left.clean_dob,right.clean_dob) > 1
			)
			OR
				(strEQ(left.prim_name,right.prim_name) and
					strEQ(left.prim_range,right.prim_range)
				)
			OR
			(
				strEQ(left.v_city_name,right.v_city_name) and
				strEQ(left.st,right.st)
			)
			OR
				left.zip=right.zip
		)
		,nac_V2.xCollisions_ex(left,right, 1000, ['U']), SKEW(0.2) //		, KEEP(2)
			,LOCAL
		);

	/***
			collision options:
				1) inter state: state1 <> state2
				2) intra state: state1=state2 and benefit1=benefit2 and caseid1<>caseid2
				3) informational: state1=state2 and beneft1<>benefit2: NOT IMPLEMENTED YET
		***/

	outfile := dedup(match, RECORD, EXCEPT BuildVersion,MatchCodes,ClientSequenceNumber, ALL);	
	
	return outfile;
	
END;