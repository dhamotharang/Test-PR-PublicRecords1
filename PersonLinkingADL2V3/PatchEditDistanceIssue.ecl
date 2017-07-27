/*
This module has two functions that are not necessarily related.  The reason they are together is that the implementation makes sense together.
1) you will never be able to perfectly compute all edit distances at build time.  so, at runtime, we sometimes make mistakes.  this corrects the ugliest of those by applying penaltydivisor.
	(for example, without this patch, an inexact (edit2) match on fname can score higher than an exact match)
2) often a flipped name gets a mainnameweight equal to or within 1 pt of an exact match.  here we ding the flipped name by mainnamepenalty pts.


*/

rec := PersonLinkingADL2V3.Process_xADL2_Layouts.LayoutScoredFetch;


export PatchEditDistanceIssue() := MODULE

export irec := record
	unsigned8 reference,
	rec.NAME_SUFFIX;
	rec.FNAME;
	rec.MNAME;
	rec.LNAME;
	rec.PRIM_RANGE;
	rec.PRIM_NAME;
	rec.SEC_RANGE;
	rec.CITY;
	rec.STATE;
	rec.ZIP;
	rec.ZIP4;
	rec.COUNTY;
	rec.SSN5;
	rec.SSN4;
	// rec.DOB_year;
	// rec.DOB_month;
	// rec.DOB_day;
	rec.PHONE;
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
			PersonLinkingADL2V3.PatchEditDistanceIssue().irec,
			self.reference := left.uniqueid,
			self := left
		)
	);

ENDMACRO;

	//if the output matches the input, we are good.
	//if the score is equal to or higher than the perfect score, and the input doesnt match, then go below perfect

export ApplyIt(
	DATASET(rec) matches
	,DATASET(irec) inputs	
	) := 
FUNCTION

	penaltydivisor := 2;
	mainnamepenalty := 3;		//
	MainnameProximity := 1;	//if the imperfect 1 is even within 1 of equal, i am going to ding it.  (Wuid:W20110728-102517,4318,4443)


	weightthreshold := 30; //if it scores less than 30, we dont even bother messing with it here (performance)

	r := record
		unsigned8 reference;
		matches.did;
		matches.MainnameWeight;
		matches.FNAMEWeight;
		matches.FNAME;
		boolean isPerfectFnameMatch := false;
		matches.MNAMEWeight;
		matches.MNAME;
		boolean isPerfectMnameMatch := false;
		matches.LNAMEWeight;
		matches.LNAME;
		boolean isPerfectLnameMatch := false;	
		matches.PRIM_NAMEWeight;
		matches.PRIM_NAME;
		boolean isPerfectPRIM_NAMEMatch := false;
	end;
	
	//** DO SOME WORK TO GET THE MATCHES DOWN TO A MANAGABLE SIZE FOR PERFORMANCE REASONS
	
	//slim it down
	ms := 
	project(
		matches(weight >= weightthreshold, (FNAMEWeight > 0 or LNAMEWeight > 0 or PRIM_NAMEWeight > 0)),
		transform(
			r,
			self.fname := if(left.fnameweight = 0, '', left.fname),  //I want to ignore the ones that are not a good match, and this will help my dedup
			self.mname := if(left.mnameweight = 0, '', left.mname),
			self.lname := if(left.lnameweight = 0, '', left.lname),
			self.prim_name := if(left.prim_nameweight = 0, '', left.prim_name),  
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
			distribute(project(inputs, {inputs.reference, inputs.fname, inputs.mname, inputs.lname, inputs.prim_name}), hash((unsigned8)reference)),
			left.reference = right.reference,
			transform(
				r,
				self.reference := left.reference,
				self.isPerfectFnameMatch := left.fname = right.fname,
				self.isPerfectMnameMatch := left.mname = right.mname,
				self.isPerfectLnameMatch := left.lname = right.lname,
				self.isPerfectPRIM_NAMEMatch := left.PRIM_NAME = right.PRIM_NAME,
				self := left
			),
			local
	);
	
	// and roll them up 
	ru :=
	rollup(
		sort(pm, reference, local),
		transform(
			r,
			self.fname := if(left.isPerfectFnameMatch, left.fname, right.fname),
			self.fnameweight := if(left.isPerfectFnameMatch, left.fnameweight , right.fnameweight ),
			self.isPerfectFnameMatch := if(left.isPerfectFnameMatch, left.isPerfectFnameMatch, right.isPerfectFnameMatch),
			self.mname := if (left.isPerfectMnameMatch, left.mname, right.mname),
			self.mnameweight := if(left.isPerfectMnameMatch, left.mnameweight, right.mnameweight),
			self.isPerfectMnameMatch := if(left.isPerfectMnameMatch, left.isPerfectMnameMatch, right.isPerfectMnameMatch),
			self.lname := if(left.isPerfectlnameMatch, left.lname, right.lname),
			self.lnameweight := if(left.isPerfectlnameMatch, left.lnameweight , right.lnameweight ),
			self.isPerfectlnameMatch := if(left.isPerfectlnameMatch, left.isPerfectlnameMatch, right.isPerfectlnameMatch),
			self.prim_name := if(left.isPerfectprim_nameMatch, left.prim_name, right.prim_name),
			self.prim_nameweight := if(left.isPerfectprim_nameMatch, left.prim_nameweight , right.prim_nameweight ),
			self.isPerfectprim_nameMatch := if(left.isPerfectprim_nameMatch, left.isPerfectprim_nameMatch, right.isPerfectprim_nameMatch),
			self := right
		),
		reference,
		local
	);
	

		//** Find the cases where right is a perfect match, and left is not, and left scores >= right
		//** In this case, cut the left weight by penaltydivisor
		
		rec xf(rec le, r ri) := transform

			fname_wrong := le.FNAMEWeight >= ri.FNAMEWeight and ri.isPerfectFnameMatch and le.fname <> ri.fname;
			mname_wrong := le.MNAMEWeight >= ri.MNAMEWeight and ri.isPerfectMnameMatch and le.mname <> ri.mname;
			lname_wrong := le.LNAMEWeight >= ri.LNAMEWeight and ri.isPerfectLnameMatch and le.lname <> ri.lname;
			riMainnameWeight := ri.FNAMEWeight + ri.LNAMEWeight;//estimated
			mainname_wrong := (ri.isPerfectFnameMatch and ri.isPerfectLnameMatch) and (le.MainnameWeight + MainnameProximity >= riMainnameWeight) and (le.FNAMEWeight = 0 or le.LNAMEWeight = 0) 
			and (riMainnameWeight > mainnamepenalty);//to make sure we dont go negative
		  pname_wrong := le.PRIM_NAMEWeight >= ri.PRIM_NAMEWeight and ri.isPerfectPRIM_NAMEMatch and le.prim_name <> ri.prim_name;

			sFNAMEWeight := if(fname_wrong, ri.FNAMEWeight div penaltydivisor, le.FNAMEWeight);
			sLNAMEWeight := if(lname_wrong, ri.LNAMEWeight div penaltydivisor, le.LNAMEWeight);
			sMNAMEWeight :=IF(mname_wrong, ri.MNAMEWeight div penaltydivisor, le.MNAMEWeight);
			sMainnameWeight := if(mainname_wrong, riMainnameWeight - mainnamepenalty, le.MainnameWeight);
			sPRIM_NAMEWeight := if(pname_wrong, ri.PRIM_NAMEWeight div penaltydivisor, le.PRIM_NAMEWeight);
					
			self.FNAMEWeight := sFNAMEWeight;
			self.LNAMEWeight := sLNAMEWeight;
			self.MNAMEWeight := sMNAMEWeight;
			self.MainnameWeight := sMainnameWeight;
			self.PRIM_NAMEWeight := sPRIM_NAMEWeight;
			
			pts_lost := (le.FNAMEWeight - sFNAMEWeight) + (le.LNAMEWeight - sLNAMEWeight) + (le.MainnameWeight - sMainnameWeight) + (le.PRIM_NAMEWeight - sPRIM_NAMEWeight);
			
			self.weight := le.weight - pts_lost;
	
			self := le;
		
		end;
	
		//** Apply the results of what we just learned back to the inf
		outf := 
		join(
			distribute(matches, hash((unsigned8)reference)),
			ru,
			left.reference = right.reference,
			xf(left, right),
			left outer,
			local
		);	
		
		// output(outf, named('outf'));
	
	out_data := outf;
	
	// output(inputs, named('inputs'));
	// output(matches, all, named('matches'));
	// output(pm,all, named('pm'));
	// output(ru,all, named('ru'));
	// output(out_data, all, named('out_data2'));
	// return matches;
	
	return out_data;

END;	
	
END;//MODULE
