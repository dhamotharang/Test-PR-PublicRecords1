import header,ut;

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


EXPORT fn_find_collisions	(
	infile1
	,matchset
	,priority_
	,score_threshold
	,ssn_threshold
	,dob_threshold
	,fname_match=0
	) := FUNCTIONMACRO
	
	matchChars:=
					 if('L' in matchset,'L','')
					+if('N' in matchset,'N','')
					+if('V' in matchset,'V','')
					+if('W' in matchset,'W','')
					+if('S' in matchset,'S','')
					+if('P' in matchset,'P','')
					+if('D' in matchset,'D','')
					+if('B' in matchset,'B','')
					+if('A' in matchset,'A','')
					+if('C' in matchset,'C','')
					+if('Z' in matchset,'Z','')
					+if('H' in matchset,'H','')
					;	
/*
	ssn_value(string9 l, string9 r) :=
		MAP( l='' or r='' => 0
       ,l = r      => 3
			,(unsigned)l % 10000 = (unsigned)r % 10000 AND 
						(((unsigned)l div 10000) = 0 OR ((unsigned)r div 10000) = 0)  => 1
       ,ut.stringsimilar(l,r) < 4 or ut.stringsimilar(r,l) < 4 => 3-min(ut.stringsimilar(l,r),ut.stringsimilar(r,l))
       ,-10 );
*/			 
	
	infile := infile1;
	
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
			   hash32(lname,fname[1])
			#elseif(fname_match = 2)
			   hash32(lname,prefname[1])
			#else
			   hash32(lname)
			#end
		#else
			hash32(lname)
		#end
		);

	//inf_ddp:=dedup(inf_dis,		record,		all,		local);
	

	match:=join(inf_dis,inf_dis,

		#if('N' in matchset)
			left.lname=right.lname and
		  #if(fname_match = 1)
			   left.fname=right.fname and
			#elseif(fname_match = 2)
			   left.fname<>right.fname and
			   left.prefname=right.prefname and
			#else
				(left.fname=right.fname or
					left.prefname=right.prefname) and
			#end
		#end

		#if('L' in matchset)
			left.did=right.did and
		#end

		#if('V' in matchset)
			left.lname=right.lname and
			//(left.fname<>right.fname or
			//left.fname<>right.prefname) and
		  #if(fname_match = 1)
			   left.fname[1]=right.fname[1] and
				 left.fname<>right.fname and
			#elseif(fname_match = 2)
			   left.prefname[1]=right.prefname[1] and
				 left.prefname<>right.prefname and
			#else
				(left.fname[1]=right.fname[1] or
					left.prefname[1]=right.prefname[1]) and
				 left.fname<>right.fname and
				 left.prefname<>right.prefname and
			#end
			nac_v2.NNEQ_Suffix(left.name_suffix,right.name_suffix)		and
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
		
		/***
			collision options:
				1) inter state: state1 <> state2
				2) intra state: state1=state2 and benefit1=benefit2 and ClientId<>ClientId
				3) informational: state1=state2 and beneft1<>benefit2: NOT IMPLEMENTED YET
		***/	
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
		AND

		left.PrepRecSeq<>right.PrepRecSeq and
		(left.StartDate <= Right.EndDate AND right.StartDate <= left.Enddate)

		//true	//the one just keeps the "and" from messing it up
		//,tr(left,right)
		,nac_v2.xCollisions(left,right, priority_, matchset), SKEW(0.2) //		, KEEP(2)
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

	outfile := dedup(match, RECORD, EXCEPT LexIdScore, ALL);	
	
	return outfile;
	
ENDMACRO;