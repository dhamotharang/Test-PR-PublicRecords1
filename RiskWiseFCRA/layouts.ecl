IMPORT risk_indicators, riskwise, iesp, liensv2;

EXPORT layouts := MODULE

  export didslim := RECORD
    unsigned6 did;
    string9   ssn;       //need ssn to get corrections later
    string20 fname;
    string20 mname;
    string20 lname;
    string5  name_suffix;
    string10 prim_range;
    string2  predir;
    string28 prim_name;
    string4  suffix;
    string2  postdir;
    string10 unit_desig;
    string8  sec_range;
    string25 city_name;
    string2  st;
    string5  zip;
    string4  zip4;
    string10 lat := '';
    string11 long := '';
    string3 county := '';
    string7 geo_blk := '';
    string10 phone10;
    Risk_Indicators.Layout_ConsumerFlags cflags; // defines if overrides should be used
  end;

  export working := RECORD
    Riskwise.layouts_vru.Layout_Header_Data;
    string20 oldFname;
    string20 newFname;
    string20 oldMname;
    string20 newMname;
    string20 oldLname;
    string20 newLname;
    string5 oldNameSuffix;
    string5 newNameSuffix;
    string10 oldPrimRange;
    string10 newPrimRange;
    string2 oldPredir;
    string2 newPredir;
    string28 oldPrimName;
    string28 newPrimName;
    string4 oldSuffix;
    string4 newSuffix;
    string2 oldPostdir;
    string2 newPostdir;
    string10 oldUnitDesig;
    string10 newUnitDesig;
    string8 oldSecRange;
    string8 newSecRange;
    string25 oldCityName;
    string25 newCityName;
    string2 oldSt;
    string2 newSt;
    string5 oldZip;
    string5 newZip;
    string4 oldZip4;
    string4 newZip4;
    string9 oldSSN;
    string9 newSSN;
    string8 oldDOB;
    string8 newDOB;
    string1 oldDwellType;
    string1 newDwellType;
    string1 oldValid;
    string1 newValid;
    string1 oldPrisonAddr;
    string1 newPrisonAddr;
    string1 oldHighRisk;
    string1 newHighRisk;    
		string2 oldHighRiskAddressSource;
    string2 newHighRiskAddressSource;    
		string50 oldHighRiskAddressDescription;
    string50 newHighRiskAddressDescription;
    string1 oldCorpMil;
    string1 newCorpMil;
    string1 oldDoNotDeliver;
    string1 newDoNotDeliver;
    string1 oldDeliveryStatus;
    string1 newDeliveryStatus;
    string1 oldAddressType;
    string1 newAddressType;
    string1 oldDropIndicator;
    string1 newDropIndicator;    
		unsigned4 oldunit_count;
    unsigned4 newunit_count;    
		string1 oldmail_usage;
    string1 newmail_usage;
    boolean isCorrected;
  end;

export layout_addrflags_input := record
		data addrID;
		string10 prim_range;
    string2  predir;
    string28 prim_name;
    string4  suffix;
    string2  postdir;
    string10 unit_desig;
    string8  sec_range;
    string25 city_name;
    string2  st;
    string5  zip;
end;

export layout_addrflags_output := record
	layout_addrflags_input;
	Risk_Indicators.Layouts.Layout_Addr_Flags2 Addr_Flags;
end;

export layout_addresses_data_input := record
	unsigned6 did;	  // to be used for correcting this data later
	string10 prim_range;
	string2  predir;
	string28 prim_name;
	string4  suffix;
	string2  postdir;
	string10 unit_desig;
	string8  sec_range;
	string25 city_name;
	string2  st;
	string5  zip;
	string4  zip4;
end;

export layout_addresses_data_output := record
	layout_addresses_data_input;
	integer avm_1_yr;
	integer avm_5_yrs;
	integer current_adls_per_address;
	integer current_ssns_per_address;
	integer current_phones_per_address;
end;

// one layout that contains the shell and all consumer statements
export PersonContext_layout := record
	dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MAX_CONSUMER_STATEMENTS)};
	risk_indicators.Layout_Boca_Shell;
end;
export layoutLiens := record
		string50 ptmsid;
		string50 prmsid;
		string porig_name;
		string8  pdate_first_seen := '';
		string8  pdate_last_seen := '';
		unsigned pdid;
		string pname_type; 
  string Party_PersistId;
  integer ConsumerStatementId;
	end;
	export layoutParty := record	
		recordOf(liensv2.layout_liens_party);
		layoutLiens;
	end;
	export layoutMain := record
			layoutLiens;
			recordof(liensv2.Layout_liens_main_module.layout_liens_main);
			STRING DF;
			STRING DF2;
			STRING DF3;
			STRING DF4;
			string mOrigFilingNumber;
			string mcertificateNumber;
			string mirsSerialNumber;
			string mCaseNumberL;
			string msort2Date;
			string mProcessDate;
			string8 mDateFiled ; 
			string8 mReleaseDate    ;  
			string20 mFilingNumber       ;    
			string10 mFilingBook         ;    
			string10 mFilingPage         ;    
			string35 mAgencyCounty       ;    
			string2 mAgencyState         ; 
			string mAmount;
			string mFtdDec;
			boolean misSuits;
   string8 VendorDateLastSeen;
   string PersistId;
	end;

END;
