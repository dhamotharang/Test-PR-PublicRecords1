/*2016-01-05T00:34:45Z (Chris Albee_prod)
Fix SBFE data. RR Bug # 196604.
*/
IMPORT BIPV2, Business_Credit, Business_Risk_BIP, MDR, ut, Business_Credit_KEL;

EXPORT PD_SBFE(DATASET(Business_Risk_BIP.Layouts.Shell) Shell_pre, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := MODULE
											 
	// Add fifteen minutes to the historydatetime to accommodate for delays in 
	// the real time database information being available in production runs
	SHARED Shell := 
		PROJECT(
			Shell_pre,
			TRANSFORM( Business_Risk_BIP.Layouts.Shell,
				SELF.Clean_Input.HistoryDateTime := IF( ((STRING)LEFT.Clean_Input.HistoryDateTime)[1..6] = Business_Risk_BIP.Constants.NinesDate, LEFT.Clean_Input.HistoryDateTime, Business_Risk_BIP.Common.getFutureTime(LEFT.Clean_Input.HistoryDateTime, 15) ),
				SELF := LEFT
			)
		);
		
	SHARED SBFERaw := Business_Credit.Key_LinkIds().kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																		Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																		0, // ScoreThreshold --> 0 = Give me everything
																		'00000000000100000000', // Flip Pos 12 on
																		Business_Risk_BIP.Constants.Limit_SBFE_LinkIds,
																		Options.KeepLargeBusinesses
																		);

  Business_Risk_BIP.Common.AppendSeq2(SBFERaw, Shell, SHARED SBFESeq);
	
	// Build a unique acct_no based on a hash of record information.
	SHARED RECORDOF(Business_Credit_KEL.File_SBFE_temp.linkids) getacctno_loaddate(SBFESeq le, RECORDOF(Business_Credit.Key_ReleaseDates()) ri) := TRANSFORM 
		SELF.acct_no := HASH(le.sbfe_contributor_number, le.contract_account_number, le.account_type_reported);
		load_datetime := ri.prod_date + ri.prod_time;
		load_Date := MAP(le.version < Business_Risk_BIP.Constants.FirstSBFELoadDate	 																									=> (STRING)le.dt_first_seen,
														(INTEGER)load_datetime=0 and (STRING)le.HistoryDateTime[1..6] = Business_Risk_BIP.Constants.NinesDate	=> (STRING)le.dt_first_seen,
																																																																			load_datetime);
    SELF.load_date := load_date;
		SELF.load_dateYYYYMMDD := load_date[1..8];
		SELF := le;
	END;
	
	SHARED linkid_recs_loaddate := JOIN(SBFESeq, Business_Credit.Key_ReleaseDates(), LEFT.version=RIGHT.version, getacctno_loaddate(LEFT,RIGHT), LEFT OUTER);
	
  SHARED linkid_recs := Business_Risk_BIP.Common.FilterRecords2(linkid_recs_loaddate, load_date, MDR.SourceTools.src_Business_Credit, AllowedSourcesSet);
	
	SHARED mod_SBFE := Business_Credit_KEL.GLUE_fdc_append(linkid_recs);
	
	EXPORT SBFE_data_raw := mod_SBFE.AddIndividualOwner;
	EXPORT SBFE_data_result := mod_SBFE.SBFE_Result;

END; 