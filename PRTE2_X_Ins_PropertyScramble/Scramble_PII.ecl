IMPORT PRTE2_PropertyInfo;

EXPORT Scramble_PII  := MODULE

		SHARED PII_Gateway_Base_SF						:= PRTE2_PropertyInfo.Files.PII_Gateway_Base_SF;
		SHARED PII_Gateway_Base_SF_DS					:= PRTE2_PropertyInfo.Files.PII_Gateway_Base_SF_DS;

		SHARED batch_in_layout := PRTE2_PropertyInfo.Layouts.batch_in; 
		SHARED SpreadsheetLayout := PRTE2_PropertyInfo.Layouts.editable_spreadsheet;
		SHARED ScrambleBase := Layouts_PII.PII_XRef_Base;
		SHARED Layout1 	:= Layouts_PII.PII_XRef_Layout1;
		SHARED Layout2 	:= Layouts_PII.PII_XRef_Layout2;
		SHARED DoubleCheckLayout := Layouts_PII.scramble_double_check;
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

		EXPORT BaseFile := PROJECT(PII_Gateway_Base_SF_DS, xfToScrBase(LEFT,COUNTER));
		SHARED XRefNames := Files.XRef_NameAddrXRef_SF_DS;
		
		SHARED DS_Layout1 := JOIN(BaseFile,XRefNames,
												LEFT.i_address = RIGHT.street
												AND LEFT.apt = RIGHT.apt
												AND LEFT.p_city_name = RIGHT.city
												AND LEFT.st = RIGHT.state
												AND LEFT.zip[1..5] = RIGHT.zip[1..5],
												xfToLayout1(LEFT,RIGHT),
												LEFT OUTER,LOOKUP);
			
		SHARED DS_Initial_Data := JOIN(DS_Layout1,XRefNames,
												LEFT.i_address = RIGHT.mapped_street
												AND LEFT.apt = RIGHT.mapped_apt
												AND LEFT.p_city_name = RIGHT.mapped_city
												AND LEFT.st = RIGHT.mapped_state
												AND LEFT.zip[1..5] = RIGHT.mapped_zip[1..5],
												xfToLayout2(LEFT,RIGHT),
												LEFT OUTER,LOOKUP);
		EXPORT INITIAL_DATA := PROJECT(SORT(DS_Initial_Data,XRec1,i_datasource),xfToDoubleCheck(LEFT));
// --------------------------------------
		
		SHARED Not_UsableSRC := DS_Initial_Data( (Xrec1 > 0 AND Xrec2 > 0 ) AND i_datasource='');
		SHARED Not_Usable := DS_Initial_Data(Xrec1 < 1 AND Xrec2 < 1 OR i_datasource='');
		SHARED Usable_DS_Layout2 := DS_Initial_Data(Xrec1 > 0 AND Xrec2 > 0 AND i_datasource <> '');
		
		SHARED Usable_NO_Move := Usable_DS_Layout2(XRec1 = XRec2);
		SHARED Usable_With_Moves := Usable_DS_Layout2(XRec1 <> XRec2);
		EXPORT DoubleCheckRecords := PROJECT(SORT(Usable_DS_Layout2,XRec1,i_datasource),xfToDoubleCheck(LEFT));
		
		// NOTE1: If I add the i_datasource match, then we lose records that are not both on left and right
		//        But we decided that was absolutely proper  
		//        basic rule: we must scramble, if a match not found to scramble, then we need to throw it away.
		SHARED PRELIM_MOVED := JOIN(Usable_With_Moves,Usable_With_Moves,
												LEFT.XRec1 = RIGHT.XRec2 AND LEFT.i_datasource = RIGHT.i_datasource,
												transformScramble_PII(LEFT,RIGHT),
												INNER);
    SHARED MOVE_SORTED := SORT(PRELIM_MOVED,XRec1,i_datasource);												
		EXPORT DblCheckPreDedup := PROJECT(MOVE_SORTED,xfToDoubleCheck(LEFT));
		SHARED MOVED := DEDUP(MOVE_SORTED,XRec1,i_datasource); 
		SHARED PRELIM_DS_AllMoved := Usable_NO_Move + MOVED;
		SHARED DS_AllMoved := SORT(PRELIM_DS_AllMoved,XRec1);
		EXPORT DoubleCheckPost := PROJECT(DS_AllMoved,xfToDoubleCheck(LEFT));
		EXPORT DS_Spreadsheet := PROJECT(DS_AllMoved,xfToSpreadsheet(LEFT));
												
		SHARED count1a := COUNT(Usable_NO_Move);
		SHARED count1 := COUNT(Usable_With_Moves);
		SHARED count2 := COUNT(MOVED);
		SHARED count2a := COUNT(PRELIM_MOVED);
		SHARED out00 := OUTPUT(COUNT(BaseFile),NAMED('Initial_Gateway'));
		SHARED out01 := OUTPUT(COUNT(XRefNames),NAMED('XRefs_Counts'));
		SHARED out1 := OUTPUT(COUNT(Not_Usable),NAMED('Total_Not_Usable_Count'));
		SHARED out2 := OUTPUT(COUNT(Not_UsableSRC),NAMED('Not_Usable_for_i_datasource'));
		SHARED out3 := OUTPUT('not_moved='+count1a+'; Pre-Move='+count1+' Post-Move='+count2a+'; Post-Move&Dedup='+count2,NAMED('Move_Dedup_Counts'));

		EXPORT AllSteps := SEQUENTIAL(out00,out01,out2,out1,out3);

END;