IMPORT _control, ut, Risk_Reporting;
EXPORT TransactionID_stats (string WU = workunit) := FUNCTION

nonFCRA_transactionID := Score_Logs.Files_Base.Transaction_IDs;

version := ut.GetDate;

DaysToUse:=35;
//start date will be computed from 35 days
FromDateInDays := ut.DaysSince1900(version[1..4],version[5..6],version[7..8]) - DaysToUse;
FromDate := ut.DateFrom_DaysSince1900(FromDateInDays);
BeginDate := FromDate;
	enddate := version;
//thor_data400::out::acclogs_scoring::transaction_ids_father
layout_nonFCRA_weekly := record
	nonFCRA_transactionID.product_code;
	string transaction_date	:= nonFCRA_transactionID.datetime[..8];
	 CountGroup			:= COUNT(GROUP);
	  transaction_id	:= SUM(GROUP,IF(nonFCRA_transactionID.transaction_id<>'',1,0));	
	 RecordCountValid_Login_ID := SUM(GROUP, if(StringLib.StringToLowerCase(TRIM(nonFCRA_transactionID.login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins, 1, 0));
	  RecordCountValid_Customer_ID := SUM(GROUP, if(nonFCRA_transactionID.customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs and nonFCRA_transactionID.customer_id <> '', 1, 0));
		//inputxml 				:= SUM(GROUP,IF(nonFCRA_transactionID.inputxml<>'',1,0));
		//outputxml 			:= SUM(GROUP,IF(nonFCRA_transactionID.outputxml<>'',1,0));
		
	END;
	
	nonFCRA_transactionID_stats := SORT(TABLE(DISTRIBUTE(nonFCRA_transactionID(datetime[1..8] BETWEEN BeginDate AND EndDate), HASH64(DateTime[1..8])), 
	layout_nonFCRA_weekly, product_code, datetime[..8], few), StringLib.StringToUpperCase(Product_code), Transaction_Date);
	


return output(nonFCRA_transactionID_stats);
end;