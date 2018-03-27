IMPORT PRTE2, PRTE2_Foreclosure;

EXPORT Scramble_Foreclosures  := MODULE

		EXPORT FRCL_Gateway_Base_SF						:= PRTE2_Foreclosure.Files.FRCL_Gateway_Base_SF;
		EXPORT FRCL_Gateway_Base_SF_DS					:= PRTE2_Foreclosure.Files.FRCL_Gateway_Base_SF_DS;

		// EXPORT FRCL_Gateway_Scramble1					:= PRTE2_Foreclosure.Files.FRCL_Gateway_Scramble1;
		// EXPORT FRCL_Gateway_Scramble1_DS				:= PRTE2_Foreclosure.Files.FRCL_Gateway_Scramble1_DS;
		// EXPORT FRCL_Gateway_Scramble2					:= PRTE2_Foreclosure.Files.FRCL_Gateway_Scramble2;
		// EXPORT FRCL_Gateway_Scramble2_DS				:= PRTE2_Foreclosure.Files.FRCL_Gateway_Scramble2_DS;

		EXPORT batch_in := PRTE2_Foreclosure.Layouts.batch_in; 
		SHARED ScrambleBase := Layouts_Foreclosures.FRLC_XRef_Base;
		EXPORT Layout1 	:= Layouts_Foreclosures.FRCL_XRef_Layout1;
		EXPORT Layout2 	:= Layouts_Foreclosures.FRCL_XRef_Layout2;
		EXPORT SpreadsheetLayout := PRTE2_Foreclosure.Layouts.editable_spreadsheet;
		EXPORT DoubleCheckLayout := Layouts_Foreclosures.scramble_double_check;
		EXPORT XRefNameLayout := Layouts.Layout_NameAddr_XRef;

		SHARED ScrambleBase xfToScrBase(batch_in L, UNSIGNED4 CNT) := TRANSFORM
				SELF.BaseRec := CNT;
				SELF  := L;
				SELF  := [];
		END;
		EXPORT Layout1 xfToLayout1(ScrambleBase L, XRefNameLayout R) := TRANSFORM
				SELF.XRec1 := R.RECNUM;
				SELF  := L;
				SELF  := [];
		END;
		EXPORT Layout2 xfToLayout2(Layout1 L, XRefNameLayout R) := TRANSFORM
				SELF.XRec2 := R.RECNUM;
				SELF  := L;
				SELF  := [];
		END;

		EXPORT SpreadsheetLayout xfToSpreadsheet(Layout2 L) := TRANSFORM
				SELF  := L;
				SELF  := [];
		END;
		EXPORT DoubleCheckLayout xfToDoubleCheck(Layout2 L) := TRANSFORM
				SELF  := L;
				SELF  := [];
		END;

		EXPORT BaseFile := PROJECT(FRCL_Gateway_Base_SF_DS, xfToScrBase(LEFT,COUNTER));
		EXPORT XRefNames := Files.XRef_NameAddrXRef_SF_DS;
		
		// Create the auditable temporary file with the xrec1 and xrec2 fields for easy scrambling audit capabilities
		EXPORT DS_Layout1 := JOIN(BaseFile,XRefNames,
												LEFT.address = RIGHT.street
												AND LEFT.apt = RIGHT.apt
												AND LEFT.city = RIGHT.city
												AND LEFT.st = RIGHT.state
												AND LEFT.zip[1..5] = RIGHT.zip[1..5],
												xfToLayout1(LEFT,RIGHT),
												LEFT OUTER,LOOKUP);			
		EXPORT Initial_Prepared := JOIN(DS_Layout1,XRefNames,
												LEFT.address = RIGHT.mapped_street
												AND LEFT.apt = RIGHT.mapped_apt
												AND LEFT.city = RIGHT.mapped_city
												AND LEFT.st = RIGHT.mapped_state
												AND LEFT.zip[1..5] = RIGHT.mapped_zip[1..5],
												xfToLayout2(LEFT,RIGHT),
												LEFT OUTER,LOOKUP);
		EXPORT INITIAL_DATA := PROJECT(SORT(Initial_Prepared,XRec1),xfToDoubleCheck(LEFT));

		// Filter out any unusable records (those that didn't have any "sister address data"
		EXPORT Not_Usable := Initial_Prepared(Xrec1 < 1 AND Xrec2 < 1);
		EXPORT Usable_DS_Layout2 := Initial_Prepared(Xrec1 > 0 AND Xrec2 > 0);
		
		// We do not do any move for "Custom" records like the Marsupials
		EXPORT Usable_NO_Move := Usable_DS_Layout2(XRec1 = XRec2);
		EXPORT Usable_With_Moves := DEDUP(Usable_DS_Layout2(XRec1 <> XRec2),RECORD);
		PreDoubleCheckRecords := PROJECT(Usable_DS_Layout2,xfToDoubleCheck(LEFT));
		EXPORT DoubleCheckRecords := SORT(PreDoubleCheckRecords,XRec1);
		
		EXPORT PRELIM_MOVED := JOIN(Usable_With_Moves,Usable_With_Moves,
												LEFT.XRec1 = RIGHT.XRec2, 
												transformScramble_Foreclosures(LEFT,RIGHT),
												INNER);

    SHARED MOVE_SORTED := SORT(PRELIM_MOVED,XRec1);												
		EXPORT DblCheckPreDedup := PROJECT(MOVE_SORTED,xfToDoubleCheck(LEFT));
		EXPORT MOVED := DEDUP(MOVE_SORTED,RECORD); // dedup to remove duplicates that the join can create
		
		EXPORT PRELIM_DS_AllMoved := Usable_NO_Move + MOVED;
		EXPORT DS_AllMoved := SORT(PRELIM_DS_AllMoved,XRec1);
		EXPORT DoubleCheckPost := PROJECT(DS_AllMoved,xfToDoubleCheck(LEFT));
		EXPORT DS_Spreadsheet := PROJECT(DS_AllMoved,xfToSpreadsheet(LEFT));
												
		SHARED count1a := COUNT(Usable_NO_Move);
		SHARED count1 := COUNT(Usable_With_Moves);
		SHARED count2 := COUNT(MOVED);
		SHARED count2a := COUNT(PRELIM_MOVED);
		SHARED out00 := OUTPUT(COUNT(BaseFile),NAMED('Initial_Gateway'));
		SHARED out01 := OUTPUT(COUNT(XRefNames),NAMED('XRefs_Counts'));
		SHARED out1 := OUTPUT(COUNT(Not_Usable),NAMED('Total_Not_Usable_Count'));
		SHARED out3 := OUTPUT('not_moved='+count1a+'; Pre-Move='+count1+' Post-Move='+count2a+'; Post-Move&Dedup='+count2,NAMED('Move_Dedup_Counts'));

		EXPORT AllSteps := SEQUENTIAL(out00,out01,out1,out3);

END;