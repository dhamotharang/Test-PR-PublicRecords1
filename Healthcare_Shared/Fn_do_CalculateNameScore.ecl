IMPORT Healthcare_Shared, STD;
EXPORT Fn_do_CalculateNameScore := MODULE
	/*  Function: getCompleteNameScore
	 *  Calculates and returns the name complete score for a given record.
	 *
	 *	@param STRING prename:	Prename
	 *	@param STRING fname:	First name
	 *	@param STRING mname:	Middle name
	 *	@param STRING lname:	Last name
	 *	@param STRING msuffix:	Maturity suffix
	 *	@param STRING psuffix:	Professional suffix
	 *
	 *  Returns completeScore:	The sum of all name scores.
	 */
	EXPORT getCompleteNameScore(STRING pname, STRING fname, STRING mname, STRING lname, STRING msuffix, STRING psuffix) := FUNCTION
		//Clean up the names
		trim_pname	 := TRIM(pname,	  LEFT, RIGHT);										   
		trim_fname 	 := TRIM(fname,	  LEFT, RIGHT);
		trim_mname 	 := TRIM(mname,	  LEFT, RIGHT);
		trim_lname	 := TRIM(lname,   LEFT, RIGHT);
		trim_msuffix := TRIM(msuffix, LEFT, RIGHT);
		trim_psuffix := TRIM(psuffix, LEFT, RIGHT);
		
		//Assign scores for completeness
		score_pname   := IF(trim_pname <> '', 5, 0);
		score_fname	  := MAP(trim_fname <> '' AND LENGTH(trim_fname) > 2 => 25,
							 trim_fname <> '' => 10,
							 0);
		score_mname	  := MAP(trim_mname <> '' AND LENGTH(trim_mname) > 2 => 25,
							 trim_mname <> '' => 10,
							 0);
		score_lname   := IF(trim_lname	<> '', 25, 0);
		score_msuffix := IF(trim_msuffix 	<> '', 10, 0);											 
		score_psuffix := IF(trim_psuffix 	<> '',  5, 0); //Professional suffix gets score of 5.  Maturity gets 10. (Not same as C++)
		
		completeScore := score_pname + score_fname + score_mname + score_lname + score_msuffix + score_psuffix;
		RETURN completeScore;
	END; //End getCompleteNameScore function
	
	/*  Function: aggWeight
	 *  Calculates and returns the aggregate name weights.
	 *
	 *	@param DATASET 	nameRec:	Recordset of grouped unique names (first/middle/last)
	 *	@param INTEGER 	recDenom:	Total records in MPRD
	 *	@param INTEGER 	recDenomSR:	Total self reported records in MPRD
	 *	@param STRING	lnFKA:		The most recent Formally Known As last name. (NO FKA if no FKA source)
	 *
	 *  Returns nameScore:		The aggregate data for each unique name (first/middle/last).
	 */
	EXPORT aggWeight(DATASET(Healthcare_Shared.Layouts.NameComplete) nameRec, UNSIGNED recDenom, UNSIGNED recDenomSR, STRING lnFKA) := FUNCTION
		nameScore := PROJECT(nameRec, TRANSFORM(Healthcare_Shared.Layouts.NameAggregate,
			rowCnt 			:= LEFT.cnt; 					//Get row count (this unique name occurs)
			rowCntSR 		:= LEFT.cntSR; 					//Get row self reported count (this unique name occurs)
			recDenomFull 	:= SUM(nameRec, cnt_full); 		//Total records that are not blank or initials.
			recDenomFullSR 	:= SUM(nameRec, cnt_fullSR);	//Total self reported records that are not blank or initials.
			
			matchedInitGrp := nameRec(TRIM(name, RIGHT)[1] = TRIM(LEFT.name, RIGHT)[1]); //Filter out names that do not share same first letter (initial)
			
			initCnt := SUM(matchedInitGrp, cnt); 			//Total names that have same first letter (initial)
			initCnt_selfRpt := SUM(matchedInitGrp, cntSR); 	//Total self reported names that have same first letter (initial)
			
			pctI 	:= (initCnt/recDenom) * 100; 												//Percent of MPRD with matching first initial
			pctIsr 	:= (initCnt_selfRpt/recDenomSR) * 100; 										//Percent of MPRD self-reported with matching first initial
			pctNsr 	:= IF(LEFT.isInit OR LEFT.isBlank, 0, (rowCntSR/recDenomFullSR) * 100); 	//Percent of the MPRD self-reported records with matching name (initials and blanks are excluded â€“ counted in pctI and pctIsr)
			pctN 	:= IF(LEFT.isInit OR LEFT.isBlank, 0, (rowCnt/recDenomFull) * 100); 		//Percent of the MPRD records with matching name (initials and blanks are excluded â€“ counted in pctI and pctIsr)
			weight 	:= IF(lnFKA = LEFT.name, 1, TRUNCATE((pctN + pctNsr + pctI + pctIsr)/4)); 	//Calculate weight(rounded down). Penalize most recent FKA last names.

			SELF.name 		 := LEFT.name;
			SELF.cnt 		 := LEFT.cnt;
			SELF.cntSR 		 := LEFT.cntSR;
			SELF.pctI 		 := pctI;
			SELF.pctIsr 	 := pctIsr;
			SELF.pctNsr 	 := pctNsr;
			SELF.pctN 		 := pctN;
			SELF.weight 	 := weight;
			SELF.finalWeight := weight;
		));
		RETURN nameScore;
	END; //End aggWeight function
	
	/*  Function: calcWeight
	 *  Calculates the weight for a single given name
	 *
	 *	@param DATASET	inRec:			Recordset of grouped unique names (first/middle/last)
	 *	@param STRING 	rowInputName:	The name we're calculating the weight of
	 *	@param INTEGER 	recDenom:		Total records in MPRD
	 *	@param INTEGER 	recDenomSR:		Total self reported records in MPRD
	 *	@param STRING 	lnFKA:			The most recent Formally Known As last name. (NO FKA if no FKA source)
	 *
	 *  Returns nameScore:	The aggregate data for the matched unique name (first/middle/last).
	 */
	EXPORT calcWeight(DATASET(Healthcare_Shared.Layouts.NameComplete) nameRec, STRING rowInputName, UNSIGNED recDenom, UNSIGNED recDenomSR, STRING lnFKA) := FUNCTION
		matchedNameGrp := nameRec(TRIM(name, RIGHT) = TRIM(rowInputName, RIGHT)); 		//Filter out names that do not match the rowInputName
		matchedInitGrp := nameRec(TRIM(name, RIGHT)[1] = TRIM(rowInputName, RIGHT)[1]);	//Filter out names that do not share same first letter (initial)
		
		rowCnt 			:= matchedNameGrp[1].cnt; 		//Get row count (this unique name occurs)
		rowCntSR 		:= matchedNameGrp[1].cntSR; 	//Get row self reported count (this unique name occurs)
		recDenomFull 	:= SUM(nameRec, cnt_full);		//Total records that are not blank or initials.
		recDenomFullSR 	:= SUM(nameRec, cnt_fullSR);	//Total self reported records that are not blank or initials.	
		
		initCnt 	:= SUM(matchedInitGrp, cnt); 	//Total names that have same initial
		initCntSR	:= SUM(matchedInitGrp, cntSR); 	//Total self reported names that have same initial
		
		nameScore := PROJECT(matchedNameGrp, TRANSFORM(Healthcare_Shared.Layouts.NameComplete,
			pctI 	:= (initCnt/recDenom) * 100; 												//Percent of MPRD with matching first initial
			pctIsr 	:= (initCntSR/recDenomSR) * 100; 											//Percent of MPRD self-reported with matching first initial
			pctNsr 	:= IF(LEFT.isInit OR LEFT.isBlank, 0, (rowCntSR/recDenomFullSR) * 100); 	//Percent of the MPRD self-reported records with matching name (initials and blanks are excluded â€“ counted in pctI and pctIsr)
			pctN 	:= IF(LEFT.isInit OR LEFT.isBlank, 0, (rowCnt/recDenomFull) * 100); 		//Percent of the MPRD records with matching name (initials and blanks are excluded â€“ counted in pctI and pctIsr)
			weight 	:= IF(lnFKA = LEFT.name, 1, TRUNCATE((pctN + pctNsr + pctI + pctIsr)/4)); 	//Calculate weight(rounded down) Penalize most recent FKA last names
			
			SELF.qa_recDenom 		:= recDenom;
			SELF.qa_recDenomSR 		:= recDenomSR;
			SELF.qa_rowCnt			:= rowCnt;
			SELF.qa_rowCntSR 		:= rowCntSR;
			SELF.qa_recDenomFull 	:= recDenomFull;
			SELF.qa_recDenomFullSR	:= recDenomFullSR;
			SELF.initCnt 			:= initCnt;
			SELF.initCntSR 			:= initCntSR;
			SELF.name 				:= LEFT.name;
			SELF.pctI 				:= pctI;
			SELF.pctIsr 			:= pctIsr;
			SELF.pctNsr 			:= pctNsr;
			SELF.pctN 				:= pctN;
			SELF.weight 			:= weight;
			SELF 					:= LEFT;
			SELF 					:= [];
		));
		RETURN nameScore;
	END; //End calcWeight function
END; //End Fn_do_CalculateNameScore module