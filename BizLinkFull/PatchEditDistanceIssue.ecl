
/*
This module has two functions that are not necessarily related.  The reason they are together is that the implementation makes sense together.
1) you will never be able to perfectly compute all edit distances at build time.  so, at runtime, we sometimes make mistakes.  this corrects the ugliest of those by applying penaltydivisor.
	(for example, without this patch, an inexact (edit2) match on fname can score higher than an exact match)
2) often a flipped name gets a mainnameweight equal to or within 1 pt of an exact match.  here we ding the flipped name by mainnamepenalty pts.


*/

rec := BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch;

import ut;

export PatchEditDistanceIssue() := MODULE

export irec := record
	unsigned8 reference,
	// rec.NAME_SUFFIX;
	// rec.FNAME;
	// rec.MNAME;
	// rec.LNAME;
	rec.PRIM_RANGE;
	rec.PRIM_NAME;
	// rec.SEC_RANGE;
	// rec.CITY;
	// rec.STATE;
	// rec.ZIP;
	// rec.ZIP4;
	// rec.COUNTY;
	// rec.SSN5;
	// rec.SSN4;
	// rec.DOB_year;
	// rec.DOB_month;
	// rec.DOB_day;
	// rec.PHONE;
end;

export mac_FormInputs(
	infile
	,outfile
	) :=
MACRO



	outfile :=
	project(
		infile,
		transform(
			BizLinkFull.PatchEditDistanceIssue().irec,
			self.reference := left.uniqueid,
			self := left
		)
	);

ENDMACRO;

	//if the output matches the input, we are good.
	//if the score is equal to or higher than the perfect score, and the input doesnt match, then go below perfect

export ApplyIt(
	DATASET(rec) pmatches
	,DATASET(irec) pinputs	
	) := 
FUNCTION

	penaltydivisor := 2;
	mainnamepenalty := 3;		//
	MainnameProximity := 1;	//if the imperfect 1 is even within 1 of equal, i am going to ding it.  (Wuid:W20110728-102517,4318,4443)


	weightthreshold := 30; //if it scores less than 30, we dont even bother messing with it here (performance)

	r := record
		unsigned8 reference;
		pmatches.proxid;
		// matches.MainnameWeight;
		// matches.FNAMEWeight;
		// matches.FNAME;
		// boolean isPerfectFnameMatch := false;
		// matches.MNAMEWeight;
		// matches.MNAME;
		// boolean isPerfectMnameMatch := false;
		// matches.LNAMEWeight;
		// matches.LNAME;
		// boolean isPerfectLnameMatch := false;	
		pmatches.PRIM_NAMEWeight;
		pmatches.PRIM_NAME;
		boolean isPerfectPRIM_NAMEMatch := false;

		pmatches.PRIM_RangeWeight;
		pmatches.PRIM_Range;
		boolean isPerfectPRIM_RangeMatch := false;		
	end;
	
	//** DO SOME WORK TO GET THE MATCHES DOWN TO A MANAGABLE SIZE FOR PERFORMANCE REASONS
	
	//slim it down
	ms := 
	project(
		pmatches(weight >= weightthreshold, (PRIM_NAMEWeight > 0 or PRIM_RangeWeight > 0)),
		transform(
			r,
			self.prim_name := if(left.prim_nameweight = 0, '', left.prim_name),  //I want to ignore the ones that are not a good match, and this will help my dedup
			self.prim_range := if(left.prim_rangeweight = 0, '', left.prim_range),  
			self := left
		)
	);
	
	//local dedup since its cheap
	mld := dedup(ms, local, all);
	
	//distribute for join and dedup again
	mdd := 
	dedup( 
		distribute(mld , hash((unsigned8)reference)),
		local, all
	);
	
	//** NOW, LETS FIND THE PERFECT MATCHES
	pm :=
		join(
			mdd,
			distribute(project(pinputs, {pinputs.reference, pinputs.prim_name, pinputs.prim_range}), hash((unsigned8)reference)),
			left.reference = right.reference,
			transform(
				r,
				self.reference := left.reference,
				self.isPerfectPRIM_NAMEMatch := left.PRIM_NAME = right.PRIM_NAME,
				self.isPerfectPRIM_RangeMatch := left.PRIM_Range = right.PRIM_Range,
				self := left
			),
			local
	)
	
	//new filter. Ok??????????????????
	(isPerfectPRIM_NAMEMatch or isPerfectPRIM_RangeMatch)
	;
	
	// and roll them up 
	ru :=
	rollup(
		sort(pm, reference, local),
		transform(
			r,
			// self.prim_name := right.prim_name,
			// self.prim_nameweight := ut.max2( left.prim_nameweight , right.prim_nameweight ),
			// self.isPerfectprim_nameMatch :=  right.isPerfectprim_nameMatch,
			// self.prim_range := right.prim_range,
			// self.prim_rangeweight := ut.max2( left.prim_rangeweight , right.prim_rangeweight ),			
			// self.isPerfectprim_rangeMatch :=  right.isPerfectprim_rangeMatch,
			
			self.prim_name := if(left.isPerfectprim_nameMatch, left.prim_name, right.prim_name),
			self.prim_nameweight := if(left.isPerfectprim_nameMatch, ut.max2(left.prim_nameweight , right.prim_nameweight), right.prim_nameweight ),
			self.isPerfectprim_nameMatch := if(left.isPerfectprim_nameMatch, left.isPerfectprim_nameMatch, right.isPerfectprim_nameMatch),			

			self.prim_range := if(left.isPerfectprim_rangeMatch, left.prim_range, right.prim_range),
			self.prim_rangeweight := if(left.isPerfectprim_rangeMatch, ut.max2(left.prim_rangeweight , right.prim_rangeweight), right.prim_rangeweight ),
			self.isPerfectprim_rangeMatch := if(left.isPerfectprim_rangeMatch, left.isPerfectprim_rangeMatch, right.isPerfectprim_rangeMatch),				
	
			self := right
		),
		reference,
		local
	);
	

		//** Find the cases where right is a perfect match, and left is not, and left scores >= right
		//** In this case, cut the left weight by penaltydivisor
		
		rec xf(rec le, r ri) := transform

			sPRIM_NAMEWeight :=  if(le.prim_name = ri.prim_name, ri.PRIM_NAMEWeight, le.prim_nameweight);
			sPRIM_RangeWeight := if(le.prim_range = ri.prim_range, ri.PRIM_rangeWeight, le.prim_rangeweight);
					

			self.PRIM_NAMEWeight := sPRIM_NAMEWeight;
			self.PRIM_rangeWeight := sPRIM_rangeWeight;
			
			pts_lost := (le.PRIM_NAMEWeight - sPRIM_NAMEWeight) + (le.PRIM_rangeWeight - sPRIM_rangeWeight);
			
			self.weight := le.weight - pts_lost;
	
			self := le;
		
		end;
	
		//** Apply the results of what we just learned back to the inf
		outf := 
		join(
			distribute(pmatches, hash((unsigned8)reference)),
			ru,
			left.reference = right.reference,
			xf(left, right),
			left outer,
			local
		);	
		
		// output(outf, named('outf'));
	
	out_data := outf;
	
	// output(pinputs, named('pinputs'));
	// output(pmatches, all, named('pmatches'));
	// output(dedup(pmatches, reference, prim_range, prim_rangeweight, prim_name, prim_nameweight, all) , all, named('pmatches_ddp'));
	// output(pm,all, named('pm'));
	// output(ru,all, named('ru'));
	// output(out_data, all, named('out_data2'));
	// output(dedup(out_data, reference, prim_range, prim_rangeweight, prim_name, prim_nameweight, all) , all, named('out_data2_ddp'));
	// return matches;
	
	return out_data;

END;	
	
END;//MODULE

/*
http://dataland_esp:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3DW20130522-154512
is a pretty good example of how this should work
*/

