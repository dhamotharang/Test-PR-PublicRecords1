/*2010-07-28T18:05:05Z (T Leonard)
PreferredFirst update
*/

/* MatchSet:	4 = ssn4
				G = age
				Z = zip5
*/

export MAC_Match_Fuzzies (infile, matchset,
							fnameField, mnameField, lnameField, suffixField,
							ageField, ssnField, zip5Field,
							didField, scoreField,
							outFile,indiv_score = 'false',indiv_score_field = 'score_f',all_scores = 'false') := 
MACRO
IMPORT ut,NID;
#uniquename(didFilter)
%didFilter% := 
#if(~all_scores)
	infile.scorefield != 100 AND 
#end
infile.fnameField != '' AND infile.lnameField != '' AND
					 (
					 #if('G' in matchset)
						(INTEGER)infile.ageField != 0 OR 
					 #end
					 #if('4' in matchset)
						(INTEGER)infile.ssnField != 0 OR 
					 #end
					 #if('Z' in matchset)
						(INTEGER)infile.zip5Field != 0 OR
					 #end
					 FALSE);

#uniquename(DidAble)
%DidAble% := infile(%didFilter%);

#uniquename(did_score_fuzzy)
//#uniquename(match_score)
#uniquename(calculated_age)
#uniquename(calcd_ssn4)
#uniquename(MatchRec)
%MatchRec% := record
	%DidAble%;
	unsigned1	%calculated_age% := 0;
	unsigned2	%calcd_ssn4% := 0;
	//integer4	%match_score% := 0;
end;

#uniquename(Into_InRec)
#uniquename(InRecs)
%MatchRec% %Into_InRec%(%DidAble% L) := Transform	
	self := L;
#if('G' in matchset)
	self.%calculated_age% := IF((INTEGER)L.ageField = 0 or length((trim((string)L.ageField,left,right)))<=3, (INTEGER)(string3)L.ageField, ut.GetAge((string8)L.ageField));
#else
	self.%calculated_age% := 0;
#end
#if('4' in matchset)
	self.%calcd_ssn4% := (unsigned2)(if (length(trim(L.ssnfield))>4,L.ssnfield[(length(trim(L.ssnfield))-3)..length(trim(L.ssnField))],l.ssnfield));
#else
	self.%calcd_ssn4% := 0;
#end
end;
%Inrecs% := project(%DidAble%,%Into_InRec%(LEFT));

#uniquename(tf) // true first
%tf%(STRING fname) := DataLib.PreferredFirstNew(fname,Header_Slimsort.Constants.UsePFNew);

#uniquename(MatchingDistribute)
%MatchingDistribute% := DISTRIBUTE(%InRecs%, HASH((QSTRING)(lnameField), (QSTRING)(%tf%(fnameField)[1]),(INTEGER)zip5Field));

#uniquename(SlimSortDist)
%SlimSortDist% := distribute(Header_Slimsort.file_name_zip_age_ssn4,HASH((QSTRING)(lname), (QSTRING)(%tf%(fname)[1]),(INTEGER)zip));

#uniquename(FullName)
%FullName%(STRING word1, STRING word2) :=
	ut.NBEQ(word1, word2) AND LENGTH(TRIM(word1)) != 1;

#uniquename(PickScore3)
%PickScore3%(STRING fname1, STRING mname1, INTEGER Opt1a, INTEGER Opt2a = 1, INTEGER Opt3a = 1,
			 STRING fname2, STRING mname2, INTEGER Opt1b, INTEGER Opt2b = 1, INTEGER Opt3b = 1,
			 UNSIGNED count1, UNSIGNED count2, UNSIGNED count3, UNSIGNED count4) :=
	
	IF(ut.NZEQ(Opt1a, Opt1b) AND ut.NZEQ(Opt2a, Opt2b) AND ut.NZEQ(Opt3a, Opt3b),
		
		ut.imin4(IF(%FullName%(%tf%(fname1), %tf%(fname2)) AND 
					%FullName%(%tf%(mname1), %tf%(mname2)),			count1, 65535),
				 IF(%FullName%(%tf%(fname1), %tf%(fname2)) AND 
					ut.NBEQ(%tf%(mname1)[1], %tf%(mname2)[1]),		count2, 65535),
				 IF(ut.NBEQ(%tf%(fname1)[1], %tf%(fname2)[1]) AND 
					ut.NBEQ(%tf%(mname1)[1], %tf%(mname2)[1]),		count3, 65535),
				 IF(%FullName%(%tf%(fname1), %tf%(fname2)),			count4, 65535)), 65535);

#uniquename(j1)
#uniquename(j2)
#uniquename(j3)
#uniquename(joiner)
%MatchRec% %joiner%(%MatchingDistribute%  L, Header_Slimsort.Layout_Name_Age_Zip_SSN4 R) :=
TRANSFORM
		integer4 localscore := 
ut.max2(
10000 div 
	ut.imin2(
	ut.imin4(
// *********** By All Three Fields *****************
#if('G' in matchset AND 'Z' in matchset AND '4' in matchset)
		// age, zip5 and ssn4
		%PickScore3%(L.fnameField, L.mnameField, (INTEGER)L.%calculated_age%, (INTEGER)L.zip5Field, (INTEGER)L.%calcd_ssn4%,
				     R.fname,		 R.mname,	   (INTEGER)R.age,	   (INTEGER)R.zip,		(INTEGER)R.ssn4,
					 R.Count_A_Z_S_F_M_L, R.Count_A_Z_S_F_Mi_L, R.Count_A_Z_S_Fi_Mi_L, R.Count_A_Z_S_F_L),
#else
		65535,
#end
// *********** By Just Two Fields *****************
#if('G' in matchset AND 'Z' in matchset)
		// age, zip5
		%PickScore3%(L.fnameField, L.mnameField, (INTEGER)L.%calculated_age%, (INTEGER)L.zip5Field,,
				     R.fname,		R.mname,	   (INTEGER)R.age,	   (INTEGER)R.zip,,
					 R.Count_A_Z_F_M_L, R.Count_A_Z_F_Mi_L, R.Count_A_Z_Fi_Mi_L, R.Count_A_Z_F_L),
#else
		65535,
#end
#if('G' in matchset AND '4' in matchset)
		// age, ssn4
		%PickScore3%(L.fnameField, L.mnameField, (INTEGER)L.%calculated_age%, (INTEGER)L.%calcd_ssn4%,,
				     R.fname,		 R.mname,	   (INTEGER)R.age,	   (INTEGER)R.ssn4,,
					 R.Count_A_S_F_M_L, R.Count_A_S_F_Mi_L, R.Count_A_S_Fi_Mi_L, R.Count_A_S_F_L),
#else
		65535,
#end
#if('Z' in matchset AND '4' in matchset)
		// zip5, ssn4
		%PickScore3%(L.fnameField, L.mnameField, (INTEGER)L.zip5Field, (INTEGER)L.%calcd_ssn4%,,
				     R.fname,		 R.mname,	   (INTEGER)R.zip,	    (INTEGER)R.ssn4,,
					 R.Count_Z_S_F_M_L, R.Count_Z_S_F_Mi_L, R.Count_Z_S_Fi_Mi_L, R.Count_Z_S_F_L)
#else
		65535
#end
		),

	ut.imin4(
// *********** By Just One Field *****************
		// age
#if('G' in matchset)
		%PickScore3%(L.fnameField, L.mnameField, (INTEGER)L.%calculated_age%,,,
				     R.fname, 	 R.mname,	   (INTEGER)R.age,,,
					 R.Count_A_F_M_L, R.Count_A_F_Mi_L, 65535, R.Count_A_F_L),					 
#else
		65535,
#end
		// zip5
#if('Z' in matchset)
		%PickScore3%(L.fnameField, L.mnameField, (INTEGER)L.zip5Field,,,
				     R.fname, 	 R.mname,	   (INTEGER)R.zip,,,
					 R.Count_Z_F_M_L, R.Count_Z_F_Mi_L, R.Count_Z_Fi_Mi_L, R.Count_Z_F_L),	
#else
		65535,
#end
		// ssn4
#if('4' in matchset)
		%PickScore3%(L.fnameField, L.mnameField, (INTEGER)L.%calcd_ssn4%,,,
				     R.fname, 	 R.mname,	   (INTEGER)R.ssn4,,,
					 R.Count_S_F_M_L, R.Count_S_F_Mi_L, R.Count_S_Fi_Mi_L, R.Count_S_F_L),	
#else
		65535,
#end
		65535)) 
		// Subtract points for each wrong answer
		-  (20 * (
#if('G' in matchset)
						IF(ut.NNEQ_Int((STRING)L.%calculated_age%, (STRING)R.age), 0, 1) + 
#end
#if('Z' in matchset)
						IF(ut.NNEQ_Int((STRING)L.zip5field, (STRING)R.zip), 0, 1) +
#end
#if('4' in matchset)
						IF(ut.NNEQ_Int((STRING)L.%calcd_ssn4%, (STRING)R.ssn4), 0, 1) +
#end
						0))
		// Subtract points if only zip5 matched
		- IF(
#if('G' in matchset)
				~ut.NZEQ((INTEGER)L.%calculated_age%, (INTEGER)R.age) AND
#end
#if('Z' in matchset)
				ut.NZEQ((INTEGER)L.zip5field, (INTEGER)R.zip) AND
#end
#if('4' in matchset)
				~ut.NZEQ((INTEGER)L.%calcd_ssn4%, (INTEGER)R.ssn4) AND
#end
				TRUE, 20, 0), 0);

/*	SELF.%match_score% :=
#if('G' in matchset)
						MAP(~ut.NNEQ_Int((STRING)L.%calculated_age%, (STRING)R.age) 	=> -3, 
							(INTEGER)L.%calculated_age% = 0 OR (INTEGER)R.age = 0	=> 0,
							(INTEGER)L.%calculated_age% = (INTEGER)R.age			=> 1, 0) + 
#end
#if('Z' in matchset)
						MAP(~ut.NNEQ_Int((STRING)L.zip5field, (STRING)R.zip) => -1, 
							(INTEGER)L.zip5field = 0 OR (INTEGER)R.zip = 0	=> 0,
							(INTEGER)L.zip5field = (INTEGER)R.zip			=> 3, 0) + 
#end
#if('4' in matchset)
						MAP(~ut.NNEQ_Int((STRING)L.%calcd_ssn4%, (STRING)R.ssn4) => -2, 
							(INTEGER)L.%calcd_ssn4% = 0 OR (INTEGER)R.ssn4 = 0	 => 0,
							(INTEGER)L.%calcd_ssn4% = (INTEGER)R.ssn4			 => 2, 0) + 
#end
						0;*/
	SELF.scorefield := did_add.compute_score(l.didfield, r.did, l.scorefield, localscore);
	SELF.didField := did_add.pick_DID(l.didfield, r.did, l.scorefield, self.scorefield);
	#if(indiv_score)
		self.indiv_score_field := if (self.didfield = r.did, localscore,l.indiv_score_field);
	#end
	SELF.temp_id := L.temp_id;
	SELF := L;
END;

#uniquename(emptyset)
%emptyset% := %MatchingDistribute%(false);

//-----------------
// output(%matchingDistribute%);
//----------------


#if('G' in matchset)
%j1% := JOIN(distribute(%MatchingDistribute%((INTEGER)%calculated_age% != 0),HASH((QSTRING)(lnamefield), (QSTRING)(%tf%(fnamefield)[1]),(INTEGER)%calculated_age%)), distribute(%SlimSortDist%, HASH((QSTRING)(lname), (QSTRING)(%tf%(fname)[1]),(INTEGER)age)), 
			LEFT.lnameField = RIGHT.lname AND
				%tf%(LEFT.fnameField)[1] = RIGHT.fname[1] AND
				(INTEGER)LEFT.%calculated_age% = (INTEGER)RIGHT.age,
			%joiner%(LEFT, RIGHT), LEFT OUTER, LOCAL,
			atmost(LEFT.lnameField = RIGHT.lname AND
				  %tf%(LEFT.fnameField)[1] = RIGHT.fname[1] AND
				  (INTEGER)LEFT.%calculated_age% = (INTEGER)RIGHT.age,50));
#else
%j1% := %emptyset%;
#end

//------------------
//  output(%j1%);
//------------------

#if('4' in matchset)
%j2% := JOIN(distribute(%MatchingDistribute%((INTEGER)%calcd_ssn4% != 0),HASH((QSTRING)(lnamefield), (QSTRING)(%tf%(fnamefield)[1]),(INTEGER)%calcd_ssn4%)), distribute(%SlimSortDist%,HASH((QSTRING)(lname), (QSTRING)(%tf%(fname)[1]),(INTEGER)ssn4)), 
			LEFT.lnameField = RIGHT.lname AND
				%tf%(LEFT.fnameField)[1] = RIGHT.fname[1] AND
				(INTEGER)LEFT.%calcd_ssn4% = (INTEGER)RIGHT.ssn4, 
			%joiner%(LEFT, RIGHT), LEFT OUTER, LOCAL,
			atmost(LEFT.lnameField = RIGHT.lname AND
				%tf%(LEFT.fnameField)[1] = RIGHT.fname[1] AND
				(INTEGER)LEFT.%calcd_ssn4% = (INTEGER)RIGHT.ssn4,50));
#else
%j2% := %emptyset%;
#end

//------------------
// output(%j2%);
//------------------


#if('Z' in matchset)
%j3% := JOIN(%MatchingDistribute%((INTEGER)zip5Field != 0), %SlimSortDist%, 
			LEFT.lnameField = RIGHT.lname AND
				%tf%(LEFT.fnameField)[1] = RIGHT.fname[1] AND
				(INTEGER)LEFT.zip5Field = (INTEGER)RIGHT.zip,
			%joiner%(LEFT, RIGHT), LEFT OUTER, LOCAL,
			atmost(LEFT.lnameField = RIGHT.lname AND
				%tf%(LEFT.fnameField)[1] = RIGHT.fname[1] AND
				(INTEGER)LEFT.zip5Field = (INTEGER)RIGHT.zip,50));
#else
%j3% := %emptyset%;
#end

//------------------
// output(%j3%);
//------------------
	
#uniquename(bestMatchSort)
#uniquename(dedupFinal)
// %bestMatchSort% := SORT(DISTRIBUTE(%j%, HASH(%UID%)), %uid%, -%did_score_fuzzy%, -%match_score%, didfield, LOCAL);
// %dedupFinal% := DEDUP(%bestMatchSort%, LEFT.%uid% = RIGHT.%uid%, LOCAL);


#uniquename(prefinals)
%prefinals% := dedup(sort(distribute(%j1% + %j2% + %j3%,hash(temp_id)),temp_id,didfield,-scorefield,local),temp_id,didfield,local);

//-------------
// output(%prefinals%);
//-------------

#uniquename(p1)
#uniquename(p2)

%p1% := %prefinals%(didfield = 0);
%p2% := %prefinals%(didfield != 0);

#uniquename(losezeros)
%p1% %losezeros%(%p1% L, %p2% R) := transform
	self := if (R.didfield = 0, L, R);
end;

#uniquename(finals)
%finals% := join(%p1%,%p2%, left.temp_id = right.temp_id, 
				%losezeros%(LEFT,RIGHT),full outer,local);
			
#uniquename(StripID)
infile %StripID%(%MatchRec% L) :=
TRANSFORM
	SELF := L;
END;

outFile := PROJECT(%finals%, %StripID%(LEFT)) + infile(~%didFilter%);

ENDMACRO;