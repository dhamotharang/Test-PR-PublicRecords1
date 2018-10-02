IMPORT std;

EXPORT Standardize_input (boolean fcra = false, unsigned logType = 0) := MODULE

	EXPORT Accurint := FUNCTION	
		
		inFile := INQL_v2.Files(fcra).Accurint_input;
		lfn		 := nothor(STD.File.SuperFileContents(INQL_v2.Superfile_List(fcra).accurint_bldg));
		
		INQL_v2.layouts.rAccurint_In_Ext tMapping(INQL_v2.layouts.rAccurint_In L) := TRANSFORM
			SELF.src_id   := logType;//'Accurint';
			SELF.filedate	:= (unsigned4)regexfind('[0-9]{8}', lfn[1].name,0);
      fixDate := INQL_v2.fncleanfunctions.tDateAdded(L.orig_dateadded);
      SELF.vendor_f_rpt_date := (unsigned4)fixDate;
      SELF.vendor_l_rpt_date := (unsigned4)fixDate;
			SELF := L;
		END;

		dStd := PROJECT(inFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT Custom := FUNCTION	
		
		inFile := INQL_v2.Files(fcra).Custom_input;
		lfn		 := nothor(STD.File.SuperFileContents(INQL_v2.Superfile_List(fcra).custom_bldg));
		
		INQL_v2.layouts.rCustom_In_Ext tMapping(INQL_v2.layouts.rCustom_In L) := TRANSFORM
			SELF.src_id			:= logType;//'Custom';
			SELF.filedate	:= (unsigned4)regexfind('[0-9]{8}', lfn[1].name,0);
      fixDate := INQL_v2.fncleanfunctions.tDateAdded(L.orig_dateadded);
      SELF.vendor_f_rpt_date := (unsigned4)fixDate;
      SELF.vendor_l_rpt_date := (unsigned4)fixDate;
			SELF := L;
		END;

		dStd := PROJECT(inFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT Batch := FUNCTION	
		
		inFile := INQL_v2.Files(fcra).Batch_input;
		lfn		 := nothor(STD.File.SuperFileContents(INQL_v2.Superfile_List(fcra).Batch_bldg));
		
		INQL_v2.layouts.rBatch_In_Ext tMapping(INQL_v2.layouts.rBatch_In L) := TRANSFORM
			SELF.src_id			:= logType;//'Batch';
			SELF.filedate	:= (unsigned4)regexfind('[0-9]{8}', lfn[1].name,0);
      fixDate := L.orig_datetime_stamp[1..8];
      SELF.vendor_f_rpt_date := (unsigned4)fixDate;
      SELF.vendor_l_rpt_date := (unsigned4)fixDate;
			SELF := L;
		END;

		dStd := PROJECT(inFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT BatchR3 := FUNCTION	
		
		inFile := INQL_v2.Files(fcra).BatchR3_input;
		lfn		 := nothor(STD.File.SuperFileContents(INQL_v2.Superfile_List(fcra).BatchR3_bldg));
		
		INQL_v2.layouts.rBatchR3_In_Ext tMapping(INQL_v2.layouts.rBatchR3_In L) := TRANSFORM
			SELF.src_id			:= logType;//'BatchR3';
			SELF.filedate	:= (unsigned4)regexfind('[0-9]{8}', lfn[1].name,0);
      fixDate := INQL_v2.fncleanfunctions.tDateAdded(L.orig_datetime);
      SELF.vendor_f_rpt_date := (unsigned4)fixDate;
      SELF.vendor_l_rpt_date := (unsigned4)fixDate;
			SELF := L;
		END;

		dStd := PROJECT(inFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT Banko := FUNCTION	
		
		inFile := INQL_v2.Files(fcra).Banko_input;
		lfn		 := nothor(STD.File.SuperFileContents(INQL_v2.Superfile_List(fcra).Banko_bldg));
		
		INQL_v2.layouts.rBanko_In_Ext tMapping(INQL_v2.layouts.rBanko_In L) := TRANSFORM
			SELF.src_id			:= logType;//'Banko';
			SELF.filedate	:= (unsigned4)regexfind('[0-9]{8}', lfn[1].name,0);
      fixDate := INQL_v2.fncleanfunctions.tDateAdded(L.orig_date_added);
      SELF.vendor_f_rpt_date := (unsigned4)fixDate;
      SELF.vendor_l_rpt_date := (unsigned4)fixDate;
			SELF := L;
		END;

		dStd := PROJECT(inFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT Bridger := FUNCTION	
		
		inFile := INQL_v2.Files(fcra).Bridger_input;
		lfn		 := nothor(STD.File.SuperFileContents(INQL_v2.Superfile_List(fcra).Bridger_bldg));
		
		INQL_v2.layouts.rBridger_In_Ext tMapping(INQL_v2.layouts.rBridger_In L) := TRANSFORM
			SELF.src_id			:= logType;//'Bridger';
			SELF.filedate	:= (unsigned4)regexfind('[0-9]{8}', lfn[1].name,0);
      fixDate := INQL_v2.fncleanfunctions.tDateAdded(L.datetime);
      SELF.vendor_f_rpt_date := (unsigned4)fixDate;
      SELF.vendor_l_rpt_date := (unsigned4)fixDate;
			SELF := L;
		END;

		dStd := PROJECT(inFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT Riskwise := FUNCTION	
		
		inFile := INQL_v2.Files(fcra).Riskwise_input;
		lfn		 := nothor(STD.File.SuperFileContents(INQL_v2.Superfile_List(fcra).Riskwise_bldg));
		
		INQL_v2.layouts.rRiskwise_In_Ext tMapping(INQL_v2.layouts.rRiskwise_In L) := TRANSFORM
			SELF.src_id			:= logType;//'Riskwise';
			SELF.filedate	:= (unsigned4)regexfind('[0-9]{8}', lfn[1].name,0);
      fixDate := INQL_v2.fncleanfunctions.tDateAdded(L.orig_date_added);
      SELF.vendor_f_rpt_date := (unsigned4)fixDate;
      SELF.vendor_l_rpt_date := (unsigned4)fixDate;
			SELF := L;
		END;
		
		dStd := PROJECT(inFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	
	EXPORT IDM := FUNCTION	
		
		inFile := INQL_v2.Files(fcra).IDM_input;
		lfn		 := nothor(STD.File.SuperFileContents(INQL_v2.Superfile_List(fcra).IDM_bldg));
		
		INQL_v2.layouts.rIDM_In_Ext tMapping(INQL_v2.layouts.rIDM_In L) := TRANSFORM
			SELF.src_id 			:= logType;//'IDM_BLS';
			SELF.filedate	:= (unsigned4)regexfind('[0-9]{8}', lfn[1].name,0);
      fixDate := INQL_v2.fncleanfunctions.tDateAdded(L.orig_dateadded);
      SELF.vendor_f_rpt_date := (unsigned4)fixDate;
      SELF.vendor_l_rpt_date := (unsigned4)fixDate;
			SELF := L;
		END;

		dStd := PROJECT(inFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT SBA := FUNCTION	
		
		inFile := INQL_v2.Files(fcra).SBA_input;
		lfn		 := nothor(STD.File.SuperFileContents(INQL_v2.Superfile_List(fcra).SBA_bldg));
		
		INQL_v2.layouts.rSBA_In_Ext tMapping(INQL_v2.layouts.rSBA_In L) := TRANSFORM
			SELF.src_id   := logType;//'SBA';
			SELF.filedate	:= (unsigned4)regexfind('[0-9]{8}', lfn[1].name,0);
      SELF.vendor_f_rpt_date := 0;//(unsigned4)fixDate;
      SELF.vendor_l_rpt_date := 0;//(unsigned4)fixDate;
      SELF := L;
		END;

		dStd := PROJECT(inFile, tMapping(LEFT));
		return dStd;
		
	END;	
			
END;
