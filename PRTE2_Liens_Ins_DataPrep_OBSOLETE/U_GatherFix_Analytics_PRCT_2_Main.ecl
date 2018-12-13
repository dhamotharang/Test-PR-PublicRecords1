/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_Analytics_PRCT_2_Main

--- spray in the latest Analytics file, join with PROD files gathered in Prod scripts to fill in any missing stuff
--- generate new tmsid and rmsid values that s/b unique but no chance of clashing with Boca values.
--- group by state in order to number the joinints by state - ready to perform final join with party file
--- save this as main file final

Had to alter and re-run with new uniqifier to get more unique tmsid values.
LINE 51 // SAVE TMSID DUPLICATE RECORDS TO USE THEM LATER WHEN WE LEARN HOW
********************************************************************************************* */
IMPORT PRTE2_Liens_Ins,PromoteSupers, PRTE2_Common;

FileName := 'LJTestCases1213_wTMSID.csv';

tmsIDSignificant(STRING S1) := S1[1..2];
anyNonBlank(STRING S1, STRING S2) := IF(TRIM(S1)='',S2,S1);
bestFilingString(STRING S1, STRING S2,STRING S3) := AnyNonBlank(AnyNonBlank(S1,S2),S3);

//---- mini Prod files -----------------------------------------------
Main_Prod_Mini		:=	SORT(PRTE2_Liens_Ins_DataPrep.U_Production_Files.Tmp_Prod_SF_Main_DS,tmsid,rmsid,process_date);
//***********************************************************************************************
sprayFile    := FileServices.SprayVariable(PRTE2_Liens_Ins.Constants.LandingZoneIP,					// file LZ
																					PRTE2_Liens_Ins.Constants.SourcePathForCSV+FileName, 			// path to file on landing zone
																					8192,																// maximum record size
																					',',		// field separator(s)
																					PRTE2_Liens_Ins.Constants.CSVSprayLineSeparator,		// line separator(s)
																					PRTE2_Liens_Ins.Constants.CSVSprayQuote,						// text quote character
																					ThorLib.Cluster(),									// destination THOR cluster
																					PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Analy_TmpFile_Name,
																					-1,												  				// -1 means no timeout
																						,													  			// use default ESP server IP port
																						,														 	 		// use default maximum connections
																					TRUE,												 		 		// allow overwrite
																					PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																					TRUE												  			// compress
																					);																					 
SEQUENTIAL(sprayFile);

//***********************************************************************************************
// OUTPUT(loadedDS(tmsid='HG517040751169SCGREC1'));		// this one tmsid is not found in the data I pulled.
loadedDS := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Analy_TmpFile_DS2(tmsid<>'' and tmsid<>'HG517040751169SCGREC1');
newLayout := PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseAnaly_Joinable_2;
//***********************************************************************************************
newLayout trxIt1(loadedDS L, INTEGER CNT) := TRANSFORM
		SELF.process_date := '';
		SELF.joinINT := CNT;
		SELF := L;
END;
loadedDS2a := PROJECT(loadedDS,trxIt1(LEFT,COUNTER));	// this will be thrown away later
//***********************************************************************************************
// SAVE TMSID DUPLICATE RECORDS TO USE THEM LATER WHEN WE LEARN HOW
//***********************************************************************************************
loadedDS2 := DEDUP(SORT(loadedDS2a,tmsid),tmsid);
OUTPUT(COUNT(loadedDS2a),NAMED('initial'));		
OUTPUT(COUNT(loadedDS2),NAMED('init_deduped'));
dups1 := JOIN(loadedDS2a,loadedDS2,
						left.tmsid=right.tmsid and left.agency_state=right.agency_state and left.joinint=right.joinint,
						TRANSFORM({loadedDS2a},SELF := left;),
						left only);
dups1Set := SET(dups1,tmsid);						
dups2 := loadedDS2a(tmsid IN dups1Set);
build_Main_dups1 := OUTPUT(SORT(dups1,tmsid,joinint),, PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_File_Later1, OVERWRITE);
build_Main_dups2 := OUTPUT(SORT(dups2,tmsid,joinint),, PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_File_Later2, OVERWRITE);
build_Main_dups := SEQUENTIAL(build_Main_dups1, build_Main_dups2);

//***********************************************************************************************
newLayout TransformMainProd(loadedDS2 L, Main_Prod_Mini R) := TRANSFORM
		origFilingNum 					:= TRIM(bestFilingString(L.filing_number,L.case_number,L.orig_filing_number));
		tmsSig 									:= TRIM(tmsIDSignificant(L.tmsid));
		uniqifier								:= INTFORMAT(L.joinint,4,1);;
		origFilingHash					:= (STRING)HASH(origFilingNum); //[9..];
		filingString 						:= TRIM(origFilingHash)+'ICT'+uniqifier;
		tmsSufStart							:= length(TRIM(R.tmsid))-2;		// was 2 go ahead and get a bit more
		rmsSufStart							:= length(TRIM(R.rmsid))-4;		// was 2 go ahead and get a bit more
		rmsSuffix								:= R.rmsid[rmsSufStart..];
		tmsSuffix								:= R.tmsid[tmsSufStart..];
		SELF.oldTmsid 					:= L.tmsid;
		SELF.orig_filing_number := IF(R.orig_filing_number<>'', filingString,'');		// fill from above if not blank
		SELF.case_number 				:= IF(R.case_number<>'', filingString,'');					// fill from above if not blank
		SELF.filing_number 			:= IF(R.filing_number<>'', filingString,'');				// fill from above if not blank
		SELF.tmsid							:= tmsSig+filingString+tmsSuffix;						// string50 tmsid - recalc after altering fields must be unique with simple singles
		SELF.rmsid 							:= tmsSig+'R'+filingString+rmsSuffix;				// string50 rmsid - recalc after altering fields
		SELF.process_date 			:= R.process_date;
		SELF.filing_jurisdiction := R.filing_jurisdiction;
		SELF.filing_state 			:= R.filing_state;
		SELF.record_code				:= R.record_code;
		SELF := L;
END;

MainRecs0 := JOIN(loadedDS2,Main_Prod_Mini,
								left.tmsid = right.tmsid
									and TRIM(left.filing_type_desc) = TRIM(right.filing_type_desc)
								,TransformMainProd(LEFT,RIGHT),
								left OUTER
								)(tmsid<>'');
MainRecs := DEDUP(SORT(MainRecs0, tmsid),tmsid);
// left only how many have no match?
// OUTPUT(COUNT(MainRecs));
// OUTPUT(Choosen(MainRecs,1000));
	
//***********************************************************************************************

//***********************************************************************************************


newLayout trxIt(MainRecs L, INTEGER CNT) := TRANSFORM
		SELF.joinINT := CNT;
		SELF := L;
END;
G_Loaded := GROUP(SORT(MainRecs,agency_state),agency_state);
newAnalyData := UNGROUP(PROJECT(G_Loaded,trxIt(LEFT,COUNTER)));
NewDataSort := SORT(newAnalyData,agency_state,joinint);
build_Main_in := OUTPUT(NewDataSort,, PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_File_Final, OVERWRITE);
delSprayedFile  := FileServices.DeleteLogicalFile (PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Analy_TmpFile_Name);
out1 := OUTPUT(CHOOSEN(PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_Final_DS,1000));

//***********************************************************************************************
SEQUENTIAL( sprayFile, build_Main_dups, build_Main_in, delSprayedFile, out1 );
//***********************************************************************************************
