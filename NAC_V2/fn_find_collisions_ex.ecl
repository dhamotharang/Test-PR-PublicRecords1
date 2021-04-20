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
/**
This is only used for V_P_B
Since all the matches are fuzzy, the self join has too much skew
Hence, we normalize it over the benefit month

**/

EXPORT fn_find_collisions_ex	(
	infile1
	,matchset
	,priority_
	,score_threshold
	,ssn_threshold
	,dob_threshold
	,fname_match=0
	) := FUNCTIONMACRO
	

	infile2 := infile1;
	infile := NORMALIZE(infile2, Std.Date.MonthsBetween(left.StartDate, left.EndDate) + 1, TRANSFORM(nac_V2.Layout_Base2_Ex,
												self.BenefitMonth := ((string)Std.Date.AdjustCalendar(left.StartDate, 0, COUNTER -1 , 0))[1..6];
												self := LEFT;));

	inf_dis := distribute(
		infile
		(
			// START FILTER
			eligibility_status_indicator <> 'N',

			#if('L' in matchset)
				did > 0,
				age > 17,
				header.sig_near_dob(clean_dob,best_dob),

				#if(score_threshold = 3)
					did_score > 99,
				#elseif(score_threshold = 2)
					did_score > 84,
				#elseif(score_threshold = 1)
					did_score > 74,
				#else
					did_score > 99,
				#end
			#end
		
			#if('S' in matchset OR 'P' in matchset)
				(unsigned)clean_ssn>0,
			#end
			#if('D' in matchset OR 'B' in matchset)
				(unsigned)clean_dob>0,
			#end
			#if('C' in matchset)
				v_city_name<>'',
				st<>'',
			#end
			#if('Z' in matchset)
			  zip<>'',
			#end
			#if('N' in matchset OR 'V' in matchset)
				lname<>'',
				#if(fname_match = 1)
					 fname<>'',
				#elseif(fname_match = 2)
					 prefname<>'',
				#end
			#end
			#if('A' in matchset)
				prim_name <> '',
			#end
			true)  //the one just keeps the commas from messing it up
		,
			// START Distribution
		#if('L' in matchset)
			did
		#elseif('S' in matchset)
			hash32(clean_ssn)
		#elseif('N' in matchset)
			#if(fname_match = 1)
			   hash32(lname,fname)
			#elseif(fname_match = 2)
			   hash32(lname,prefname)
			#else
			   hash32(lname)
			#end
		#elseif('V' in matchset)
			#if(fname_match = 1)
			   hash32(BenefitMonth,lname,fname[1])
			#elseif(fname_match = 2)
			   hash32(BenefitMonth,lname,prefname[1])
			#else
			   hash32(BenefitMonth,lname)
			#end
		#else
			hash32(BenefitMonth,lname)
		#end
		);

	//inf_ddp:=dedup(inf_dis,		record,		all,		local);
	

	match:=join(inf_dis,inf_dis,

		left.BenefitMonth = right.BenefitMonth and
		left.lname=right.lname
		//(left.StartDate <= Right.EndDate AND right.StartDate <= left.Enddate)
		/***
			collision options:
				1) inter state: state1 <> state2
				2) intra state: state1=state2 and benefit1=benefit2 and caseid1<>caseid2
				3) informational: state1=state2 and beneft1<>benefit2: NOT IMPLEMENTED YET
		***/
		AND
		(
			(left.ProgramState <> right.ProgramState AND nac_V2.MatchAllowed(left.ProgramCode,right.ProgramCode))
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
		AND
		#if('N' in matchset)
			left.lname=right.lname and
		  #if(fname_match = 1)
			   left.fname=right.fname and
			#elseif(fname_match = 2)
			   left.prefname=right.prefname and
			#else
				(left.fname=right.fname or
					left.prefname=right.prefname) and
			#end
		#end

		#if('V' in matchset)
		  #if(fname_match = 1)
				 left.fname<>right.fname and
			   left.fname[1]=right.fname[1] and
			#elseif(fname_match = 2)
				 left.prefname<>right.prefname and
				 left.fname[1]<>right.fname[1] and
			   left.prefname[1]=right.prefname[1] and
			#else
				((left.fname[1]=right.fname[1] and left.fname<>right.fname) OR
				 (left.prefname[1]=right.prefname[1] and left.prefname<>right.prefname)) and
			#end
			nac_v2.NNEQ_Suffix(left.name_suffix,right.name_suffix) and
		#end

		#if('S' in matchset)
			left.clean_ssn=right.clean_ssn and
		#end

		#if('D' in matchset)
			left.clean_dob=right.clean_dob and
		#else
			nac_v2.NNEQ_Suffix(left.name_suffix,right.name_suffix)	and
		#end


		#if('A' in matchset)
			left.prim_name=right.prim_name and
			left.prim_range=right.prim_range and
		#end

		#if('C' in matchset)
			left.v_city_name=right.v_city_name and
			left.st=right.st and
		#end

		#if('Z' in matchset)
			left.zip=right.zip and
		#end
		
			#if('P' in matchset)
				left.clean_ssn<>right.clean_ssn and
				#if(ssn_threshold = 3)
					NAC_V2.ssn_value(left.clean_ssn,right.clean_ssn) > 1 and
				#elseif(ssn_threshold = 2)
					//ssn_med(left.SearchCleanSSN, right.CaseCleanSSN) and
					NAC_V2.ssn_value(left.clean_ssn,right.clean_ssn) > 0 and
				#elseif(ssn_threshold = 1)
					NAC_V2.ssn_value(left.clean_ssn,right.clean_ssn) > -1 and
				#else
					NAC_V2.ssn_value(left.clean_ssn,right.clean_ssn) > 1 and
				#end
		#end

		#if('B' in matchset)
			left.clean_dob<>right.clean_dob and
			nac_v2.gens_ok(left.name_suffix,left.clean_dob,right.name_suffix,right.clean_dob) and
			#if(dob_threshold = 3)
				header.sig_near_dob(left.clean_dob,right.clean_dob) and
				//nac_v2.dob_near((integer)left.SearchCleanDOB, (integer)right.CaseCleanDOB) and
				//left.clean_dob = right.clean_dob AND
			#elseif(dob_threshold = 2)
				header.date_value(left.clean_dob,right.clean_dob) > 1 and
				//dob_medium((integer)left.SearchCleanDOB, (integer)right.CaseCleanDOB) and
			#elseif(dob_threshold = 1)
				header.date_value(left.clean_dob,right.clean_dob) > 0 and
			#else
				header.sig_near_dob(left.clean_dob,right.clean_dob) and
			#end
		#end
		
		left.PrepRecSeq<>right.PrepRecSeq 			// do not join to self
		,nac_V2.xCollisions_ex(left,right, priority_, matchset), SKEW(0.2) //		, KEEP(2)
		#if('L' in matchset
				OR 'N' in matchset
				OR 'V' in matchset
				OR 'S' in matchset)
			,LOCAL
		#end
		);

	/***
			collision options:
				1) inter state: state1 <> state2
				2) intra state: state1=state2 and benefit1=benefit2 and caseid1<>caseid2
				3) informational: state1=state2 and beneft1<>benefit2: NOT IMPLEMENTED YET
		***/

	outfile := dedup(match, RECORD, EXCEPT BuildVersion,MatchCodes,ClientSequenceNumber, ALL);	
	
	return outfile;
	
ENDMACRO;