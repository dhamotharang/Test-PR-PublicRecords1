IMPORT PRTE2_LNProperty;

EXPORT Scramble_LNP := MODULE
		SHARED appendSpaceIf(STRING base, STRING appnd) := IF(appnd='',base,base+' '+appnd);
		SHARED replaceIfNotBlank(STRING base, STRING replaceIf) := IF(base='', base, replaceIf);

		SHARED LNP_Gateway_Base_SF						:= PRTE2_LNProperty.Files.LNP_Gateway_Base_SF;
		SHARED LNP_Gateway_Base_SF_DS					:= PRTE2_LNProperty.Files.LNP_Gateway_Base_SF_DS;

		SHARED batch_in_layout := PRTE2_LNProperty.Layouts.batch_in; 
		SHARED ScrambleBase := Layouts_LNP.LNP_XRef_Base;
		SHARED Layout1 	:= Layouts_LNP.LNP_XRef_Layout1;
		SHARED Layout2 	:= Layouts_LNP.LNP_XRef_Layout2;
		SHARED SpreadsheetLayout := PRTE2_LNProperty.Layouts.editable_spreadsheet;
		SHARED DoubleCheckLayout := Layouts_LNP.scramble_double_check;
		SHARED XRefNameLayout := Layouts.Layout_NameAddr_XRef;

// --------------------------------------
		SHARED ScrambleBase xfToScrBase(batch_in_layout L, UNSIGNED4 CNT) := TRANSFORM
				SELF.BaseRec := CNT;
				SELF  := L;
				SELF  := [];
		END;
		SHARED Layout1 xfToLayout1(ScrambleBase L, XRefNameLayout R) := TRANSFORM
				SELF.XRec1 := R.RECNUM;
				SELF  := L;
				SELF  := [];
		END;
		SHARED Layout2 xfToLayout2(Layout1 L, XRefNameLayout R) := TRANSFORM
				SELF.XRec2 := R.RECNUM;
				SELF  := L;
				SELF  := [];
		END;

// --------------------------------------
		SHARED SpreadsheetLayout xfToSpreadsheet(Layout2 L) := TRANSFORM
				SELF  := L;
				SELF  := [];
		END;
		SHARED DoubleCheckLayout xfToDoubleCheck(Layout2 L) := TRANSFORM
				SELF  := L;
				SELF  := [];
		END;

// --------------------------------------
		EXPORT BaseFile := PROJECT(LNP_Gateway_Base_SF_DS, xfToScrBase(LEFT,COUNTER));
		SHARED XRefNames := Files.XRef_NameAddrXRef_SF_DS;
		
		SHARED DS_Layout1 := JOIN(BaseFile,XRefNames,
												LEFT.address = RIGHT.street
												AND LEFT.apt = RIGHT.apt
												AND LEFT.city = RIGHT.city
												AND LEFT.st = RIGHT.state
												AND LEFT.zip[1..5] = RIGHT.zip[1..5],
												xfToLayout1(LEFT,RIGHT),
												LEFT OUTER,LOOKUP);
			
		Initial_Prepared_0 := JOIN(DS_Layout1,XRefNames,
												LEFT.address = RIGHT.mapped_street
												AND LEFT.apt = RIGHT.mapped_apt
												AND LEFT.city = RIGHT.mapped_city
												AND LEFT.st = RIGHT.mapped_state
												AND LEFT.zip[1..5] = RIGHT.mapped_zip[1..5],
												xfToLayout2(LEFT,RIGHT),
												LEFT OUTER,LOOKUP);
		SHARED Initial_Prepared :=	DEDUP(SORT(Initial_Prepared_0, XRec1,matchcodes,ln_fares_id),XRec1);
		initialSort := SORT(Initial_Prepared, XRec1,matchcodes,ln_fares_id);												
		EXPORT INITIAL_DATA := PROJECT(initialSort, xfToDoubleCheck(LEFT));

// --------------------------------------
		SHARED Not_UsableMC := Initial_Prepared( (Xrec1 > 0 AND Xrec2 > 0 ) AND matchcodes='');
		SHARED Not_Usable := Initial_Prepared( (Xrec1 < 1 AND Xrec2 < 1) OR matchcodes='');
		SHARED Usable_DS_Layout2 := Initial_Prepared( (Xrec1 > 0 AND Xrec2 > 0 ) AND matchcodes <> '');
		SHARED Usable_NO_Move := Usable_DS_Layout2(XRec1 = XRec2);
		SHARED Usable_With_Moves := Usable_DS_Layout2(XRec1 <> XRec2);
		PreDoubleCheckRecords := PROJECT(Usable_DS_Layout2,xfToDoubleCheck(LEFT));
		EXPORT DoubleCheckRecords := SORT(PreDoubleCheckRecords, XRec1,matchcodes,ln_fares_id);
		

		// NOTE1: If I add the matchcodes match, then we lose records that don't match both on host and partner
		//        But we decided that was absolutely proper  
		//        basic rule: we must scramble, if a true match not found to scramble, then we need to throw it away.
		SHARED PRELIM_MOVED := JOIN(Usable_With_Moves,Usable_With_Moves,
												LEFT.XRec1 = RIGHT.XRec2 AND LEFT.matchcodes = RIGHT.matchcodes,
												transformScramble_LNP(LEFT,RIGHT),
												INNER);
    SHARED MOVE_SORTED := SORT(PRELIM_MOVED,XRec1,matchcodes,ln_fares_id);
		EXPORT DblCheckPreDedup := SORT(PROJECT(MOVE_SORTED,xfToDoubleCheck(LEFT)),XRec1,matchcodes,ln_fares_id);
		SHARED MOVED := DEDUP(MOVE_SORTED,XRec1,matchcodes,ln_fares_id);
		SHARED PRELIM_DS_AllMoved := Usable_NO_Move + MOVED;
		SHARED DS_AllMoved := SORT(PRELIM_DS_AllMoved,XRec1,matchcodes,ln_fares_id);
		EXPORT DoubleCheckPost := SORT(PROJECT(DS_AllMoved,xfToDoubleCheck(LEFT)),XRec1,matchcodes,ln_fares_id);
		EXPORT DS_Spreadsheet := SORT(PROJECT(DS_AllMoved,xfToSpreadsheet(LEFT)),matchcodes,ln_fares_id);
												
		SHARED count1a := COUNT(Usable_NO_Move);
		SHARED count1 := COUNT(Usable_With_Moves);
		SHARED count2 := COUNT(MOVED);
		SHARED count2a := COUNT(PRELIM_MOVED);
		SHARED out00 := OUTPUT(COUNT(BaseFile),NAMED('Initial_Gateway'));
		SHARED out01 := OUTPUT(COUNT(XRefNames),NAMED('XRefs_Counts'));
		SHARED out1 := OUTPUT(COUNT(Not_Usable),NAMED('Total_Not_Usable_Count'));
		SHARED out2 := OUTPUT(COUNT(Not_UsableMC),NAMED('Not_Usable_for_blank_matchcodes'));
		SHARED out3 := OUTPUT('not_moved='+count1a+'; Pre-Move='+count1+' Post-Move='+count2a+'; Post-Move&Dedup='+count2,NAMED('Move_Dedup_Counts'));
		// SHARED out4 := OUTPUT(initialSort,NAMED('InitialSort_pre_doublecheck'));
		EXPORT AllSteps := SEQUENTIAL(out00,out01,out2,out1,out3);
	
END;