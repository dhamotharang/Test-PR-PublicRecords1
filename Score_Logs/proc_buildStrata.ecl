IMPORT STRATA, UT,Risk_Reporting;
	
EXPORT proc_buildstrata(STRING version = ut.GetDate) := FUNCTION
	
	//adding nonFCRA transaction_id 
	
	nonFCRA_transactionID := pull(Score_Logs.Key_ScoreLogs_XMLTransactionID); 
	
	//how many daily files processed
DaysToUse:=30;
//start date will be computed from 60 days
FromDateInDays:=ut.DaysSince1900(version[1..4],version[5..6],version[7..8]) - DaysToUse;
FromDate:=ut.DateFrom_DaysSince1900(FromDateInDays);
BeginDate := FromDate;
	enddate := version;
	
	layout_nonFCRA_weekly := record
	nonFCRA_transactionID.product;
	string transaction_date	:= nonFCRA_transactionID.datetime[..8];
	 CountGroup			:= COUNT(GROUP);
	  transaction_id	:= SUM(GROUP,IF(nonFCRA_transactionID.transaction_id<>'',1,0));	
	 RecordCountValid_Login_ID := SUM(GROUP, if(StringLib.StringToLowerCase(TRIM(nonFCRA_transactionID.login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins, 1, 0));
	  RecordCountValid_Customer_ID := SUM(GROUP, if(nonFCRA_transactionID.customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs and nonFCRA_transactionID.customer_id <> '', 1, 0));
		inputxml 				:= SUM(GROUP,IF(nonFCRA_transactionID.inputxml<>'',1,0));
		outputxml 			:= SUM(GROUP,IF(nonFCRA_transactionID.outputxml<>'',1,0));
		
	END;
	
	nonFCRA_transactiondate_stats := SORT(TABLE(DISTRIBUTE(nonFCRA_transactionID(datetime[1..8] BETWEEN BeginDate AND EndDate), HASH64(DateTime[1..8])), 
	layout_nonFCRA_weekly, product, datetime[..8], few), StringLib.StringToUpperCase(Product), Transaction_Date);
	
	nonFCRA_transactiondate_dist := output(nonFCRA_transactiondate_stats, all);
//adding FCRA transaction_id 
	
	FCRA_transactionID := pull(Score_Logs.Key_FCRA_ScoreLogs_XMLTransactionID); 
	
	layout_fcra_weekly := record
	FCRA_transactionID.product;
	string transaction_date	:= FCRA_transactionID.datetime[..8];
	 CountGroup			:= COUNT(GROUP);
	  transaction_id	:= SUM(GROUP,IF(FCRA_transactionID.transaction_id<>'',1,0));	
	 RecordCountValid_Login_ID := SUM(GROUP, if(StringLib.StringToLowerCase(TRIM(FCRA_transactionID.login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins, 1, 0));
	  RecordCountValid_Customer_ID := SUM(GROUP, if(FCRA_transactionID.customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs and FCRA_transactionID.customer_id <> '', 1, 0));
		inputxml 				:= SUM(GROUP,IF(FCRA_transactionID.inputxml<>'',1,0));
		outputxml 			:= SUM(GROUP,IF(FCRA_transactionID.outputxml<>'',1,0));
		
	END;
	
	FCRA_transactiondate_stats := SORT(TABLE(DISTRIBUTE(FCRA_transactionID(datetime[1..8] BETWEEN BeginDate AND EndDate), HASH64(DateTime[1..8])), 
	layout_fcra_weekly, product, datetime[..8], few), StringLib.StringToUpperCase(Product), Transaction_Date);
FCRA_transactiondate_dist := output(FCRA_transactiondate_stats, all);

layout_nonFCRA := record
	nonFCRA_transactionID.product;
	 CountGroup			:= COUNT(GROUP);
	  transaction_id	:= SUM(GROUP,IF(nonFCRA_transactionID.transaction_id<>'',1,0));	
	 RecordCountValid_Login_ID := SUM(GROUP, if(StringLib.StringToLowerCase(TRIM(nonFCRA_transactionID.login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins, 1, 0));
	  RecordCountValid_Customer_ID := SUM(GROUP, if(nonFCRA_transactionID.customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs and nonFCRA_transactionID.customer_id <> '', 1, 0));
		inputxml 				:= SUM(GROUP,IF(nonFCRA_transactionID.inputxml<>'',1,0));
		outputxml 			:= SUM(GROUP,IF(nonFCRA_transactionID.outputxml<>'',1,0));
		
	END;
	
	nonFCRA_loginID_stats := SORT(TABLE(nonFCRA_transactionID, layout_nonFCRA, product, few), StringLib.StringToUpperCase(Product));

strata.createXMLStats(nonFCRA_loginID_stats,'ScoringLogsOutcome','NonFCRA_LoginID',version,'wenhong.ma@lexisnexisrisk.com',strataResults_nonfcra_loginID);


//adding FCRA transaction_id 
		
	layout_fcra := record
	FCRA_transactionID.product;
	 CountGroup			:= COUNT(GROUP);
	  transaction_id	:= SUM(GROUP,IF(FCRA_transactionID.transaction_id<>'',1,0));	
	 RecordCountValid_Login_ID := SUM(GROUP, if(StringLib.StringToLowerCase(TRIM(FCRA_transactionID.login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins, 1, 0));
	  RecordCountValid_Customer_ID := SUM(GROUP, if(FCRA_transactionID.customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs and FCRA_transactionID.customer_id <> '', 1, 0));
		inputxml 				:= SUM(GROUP,IF(FCRA_transactionID.inputxml<>'',1,0));
		outputxml 			:= SUM(GROUP,IF(FCRA_transactionID.outputxml<>'',1,0));
		
	END;
	
	FCRA_loginID_stats := SORT(TABLE(FCRA_transactionID,layout_fcra, product, few), StringLib.StringToUpperCase(Product));
strata.createXMLStats(FCRA_loginID_stats,'ScoringLogsOutcome','FCRA_LoginID',version,'wenhong.ma@lexisnexisrisk.com',strataResults_FCRA_loginID);
	
Emailnotification := 'Jason.Allerdings@lexisnexisrisk.com; Sudhir.Kasavajjala@lexisnexisrisk.com; Darren.knowles@lexisnexisrisk.com; Wenhong.Ma@lexisnexisrisk.com; valerie.minnis@lexisnexisrisk.com; hamid.kahvazadeh@lexisnexisrisk.com';  
	
	pValidate_nonFCRA:= if(count(nonFCRA_transactiondate_stats((unsigned)RecordCountValid_Login_ID < score_logs.alert_monitor_constants.nonfcra_count)) > 0, FileServices.SendEmail(Emailnotification,'SAOT BUILD failed '+ Version ,'nonFCRA stats has 0 count per transaction date' + failmessage)); 

	pValidate_FCRA:= if(count(FCRA_transactiondate_stats((unsigned)RecordCountValid_Login_ID < score_logs.alert_monitor_constants.fcra_count)) > 0, FileServices.SendEmail(Emailnotification,'SAOT BUILD failed '+ Version ,'FCRA stats has 0 or small count per transaction date' + failmessage)); 

  RETURN sequential(nonFCRA_transactiondate_dist, FCRA_transactiondate_dist, strataResults_nonFCRA_loginID, strataResults_FCRA_loginID,pValidate_nonFCRA,pValidate_FCRA);
	
END;