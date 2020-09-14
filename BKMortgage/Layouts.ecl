IMPORT $;

EXPORT Layouts := MODULE
	EXPORT Delete_Rec  := RECORD
		STRING5    fips_cd;
		STRING9		 Pid;
		STRING6    Delete_Flag := '';
		STRING8    ln_filedate;
	END;

	EXPORT Assign_Raw_in	:= RECORD
		STRING1		RecType;
		STRING2		DocumentType;
		STRING5		FIPSCode;
		STRING1		MERSIndicator;
		STRING1		MainAddendum;
		STRING8		AssigRecDate;
		STRING8		AssigEffecDate;
		STRING20	AssigDoc;
		STRING10	Assigbk;
		STRING10	Assigpg;
		STRING1		MultiplePageImage;
		STRING50	BKFSImageID;
		STRING8		OrigDOTRecDate;
		STRING8		OrigDOTContractDate;
		STRING20	OrigDOTDoc;
		STRING10	OrigDOTBk;
		STRING10	OrigDOTPg;
		STRING		Origlenderben;
		STRING10	OrigLoanAmnt;
		STRING		AssignorName;
		STRING30	LoanNumber;
		STRING		Assignee;
		STRING18	MERS;
		STRING1		MERSValidation;
		STRING25	AssigneePool;
		STRING22	MSPSvcrLoan;
		STRING		BorrowerName;
		STRING45	APN;
		STRING1		MultiAPNCode;
		STRING45	TaxAcctid;
		STRING70	PropertyFullAdd;
		STRING6		PropertyUnit;
		STRING30	PropertyCity;
		STRING2		PropertyState;
		STRING5		PropertyZip;
		STRING4		PropertyZip4;
		STRING8		DataentryDate;
		STRING4		DataEntryOpercode;
		STRING3		VendorSourceCode;
		STRING1		HIDS_RecordingFlag;
		STRING9		HIDS_DocNumber;
		STRING8		TransferCertificateOfTitle;
		STRING4		HI_Condo_CPR_HPR;
		STRING10	HI_Situs_Unit_Number;
		STRING9		HIDS_Previous_DocNumber;
		STRING8		PrevTransferCertificateOfTitle;
		STRING9		PID;
		STRING1		MatchedOrOrphan;
		STRING9		Deed_PID;
		STRING9		SAM_PID;
		STRING37	AssessorParcelNumber_Matched;
		STRING60	AssessorPropertyFullAdd;
		STRING4		AssessorPropertyUnitType;
		STRING6		AssessorPropertyUnit;
		STRING30	AssessorPropertyCity;
		STRING2		AssessorPropertyState;
		STRING5		AssessorPropertyZip;
		STRING4		AssessorPropertyZip4;
		STRING1		AssessorPropertyAddrSource;
	END;
	
	EXPORT Assign_Raw_out	:= RECORD
		STRING8 ln_filedate := ''; 
		STRING30 bk_infile_type := '';
		Assign_Raw_in;
	END;
	
	//Adding raw_file_name for Property mapping
	EXPORT Assign_Raw_out_ext := RECORD
		Assign_Raw_out;
		STRING100 raw_file_name { virtual(logicalfilename)};
	END;

	EXPORT AssignBase  := RECORD
		UNSIGNED6 record_id;
		STRING8 date_first_seen;
		STRING8 date_last_seen;
		STRING8 date_vendor_first_reported;
		STRING8 date_vendor_last_reported;
		STRING8 process_date;
		STRING2 source;
		Assign_Raw_out;
	//Name parsed, if can be parsed, and without extra information such as AKA, DBA, etc
		STRING	ClnOriglenderben;
		STRING	ClnAssignorName;
		STRING	ClnAssignee;
//DBA name for lendor names only. No DBA field for borrower in Mortgage layout
		STRING	DBAOrigLenderBen;
		STRING	DBAAssignor;
		STRING	DBAAssignee;
		STRING100 raw_file_name; //Needed for property build
		BOOLEAN	new_record; //Used to determine what records to pass to property
	END;
	
	EXPORT Release_Raw_in	:= RECORD
		STRING1		RecType;
		STRING2		DocumentType;
		STRING5		FIPSCode;
		STRING1		MAINAddendum;
		STRING8		ReleaseRecDate;
		STRING8		ReleaseEffecDate;
		STRING8		MortgagePayoffDate;
		STRING20	ReleaseDoc;
		STRING10	ReleaseBk;
		STRING10	ReleasePg;
		STRING1		MultiplePageImage;
		STRING50	BKFSImageID;
		STRING8		OrigDOTRecDate;
		STRING8		OrigDOTContractDate;
		STRING20	OrigDOTDoc;
		STRING10	OrigDOTBk;
		STRING10	OrigDOTPg;
		STRING		OrigLenderBen; //Large variable field so not giving a set length
		STRING10	OrigLoanAmnt;
		STRING30	LoanNumber;
		STRING		CurrentLenderBen; //Large variable length field so not giving a set length
		STRING18	MERS;
		STRING1		MERSValidation;
		STRING22	MSPSvrLoan;
		STRING25	CurrentLenderPool;
		STRING		BorrowerName;
		STRING70	BorrMailFullAddress;
		STRING6		BorrMailUnit;
		STRING30	BorrMailCity;
		STRING2		BorrMailState;
		STRING5		BorrMailZip;
		STRING4		BorrMailZip4;
		STRING45	APN;
		STRING1		MultiAPNCode;
		STRING45	TaxAcctID;
		STRING70	PropertyFullAdd;
		STRING16	PropertyUnit;
		STRING30	PropertyCity;
		STRING2		PropertyState;
		STRING5		PropertyZip;
		STRING4		PropertyZip4;
		STRING8		DataEntryDate;
		STRING4		DataEntryOperCode;
		STRING3		VendorSourceCode;
		STRING1		HIDS_RecordingFlag;
		STRING9		HIDS_DocNumber;
		STRING8		TransferCertificateofTitle;
		STRING4		HI_Condo_CPR_HPR;
		STRING10	HI_Situs_Unit_Number;
		STRING9		HIDS_Previous_DocNumber;
		STRING8		PrevTransferCertificateofTitle;
		STRING9		PID;
		STRING1		MatchedOrOrphan;
		STRING9		Deed_PID;
		STRING9		SAM_PID;
		STRING37	AssessorParcelNumber_Matched;
		STRING60	AssessorPropertyFullAdd;
		STRING4		AssessorPropertyUnitType;
		STRING6		AssessorPropertyUnit;
		STRING30	AssessorPropertyCity;
		STRING2		AssessorPropertyState;
		STRING5		AssessorPropertyZip;
		STRING4		AssessorPropertyZip4;
		STRING1		AssessorPropertyAddrSource;
	END;

	EXPORT Release_Raw_out	:= RECORD
		STRING8 ln_filedate := ''; 
		STRING30 bk_infile_type := '';
		Release_Raw_in;		
	END;
	
	//Adding raw_file_name for Property mapping
	EXPORT Release_Raw_out_ext := RECORD
		Release_Raw_out;
		STRING100 raw_file_name { virtual(logicalfilename)};
	END;
	
	EXPORT ReleaseBase  := RECORD 
		UNSIGNED6 record_id;
		STRING8 date_first_seen;
		STRING8 date_last_seen;
		STRING8 date_vendor_first_reported;
		STRING8 date_vendor_last_reported;
		STRING8 process_date;
		STRING2 source;
		Release_Raw_out;
	//Name parsed, if can be parsed, and without extra information such as AKA, DBA, etc
		STRING	ClnLenderBen;	
		STRING	ClnCurrentLenderBen;
	//DBA name for lendor names only. No DBA field for borrower in Mortgage layout
		STRING	DBALenderBen;
		STRING	DBACurrentLenderBen;
		STRING100 raw_file_name; //Needed for property build
		BOOLEAN	new_record; //Used to determine what records to pass to property
	END;

//Combined both Assignment and Release files for easier processing in LN_Property_Fast build
	EXPORT BKMortgageDeed := RECORD
		STRING8 	date_first_seen;
		STRING8 	date_last_seen;
		STRING8 	date_vendor_first_reported;
		STRING8 	date_vendor_last_reported;
		STRING8 	process_date;
		STRING2 	source;
		STRING8 	ln_filedate;
		STRING30 	bk_infile_type;
		STRING1		RecType;
		STRING2		DocumentType;
		STRING5		FIPSCode;
		STRING1		MERSIndicator;
		STRING1		MainAddendum;
		STRING8		recording_date;
		STRING8		contract_date;
		STRING20	document_number;
		STRING10	recorder_book_number;
		STRING10	recorder_page_number;
		STRING1		MultiplePageImage;
		STRING50	BKFSImageID;
		STRING		lender_name;
		STRING10	loan_amount;
		STRING30	LoanNumber;
		STRING18	MERS;
		STRING1		MERSValidation;
		STRING25	LenderNameID;
		STRING22	MSPSvrLoan;
		STRING		BorrowerName;
		STRING70	BorrMailFullAddress;
		STRING6		BorrMailUnit;
		STRING30	BorrMailCity;
		STRING2		BorrMailState;
		STRING5		BorrMailZip;
		STRING4		BorrMailZip4;
		STRING45	APNNumber;
		STRING1		MultiAPNFlag;
		STRING45	TaxIDNumber;
		STRING70	PropertyStreetAddress;
		STRING6		PropertyUnitNumber;
		STRING30	PropertyCityName;
		STRING2		PropertyState;
		STRING5		PropertyZip;
		STRING4		PropertyZip4;
		STRING8		DataentryDate;
		STRING4		DataEntryOpercode;
		STRING3		DataSourceCode;
		STRING1		HIDS_RecordingFlag;
		STRING9		HIDS_DocNumber;
		STRING8		Hawaii_TCT;
		STRING4		HI_Condo_CPR_HPR;
		STRING10	HI_Situs_Unit_Number;
		STRING9		HIDS_Previous_DocNumber;
		STRING8		PrevTransferCertificateOfTitle;
		STRING8		MortgagePayoffDate;
		STRING		Clnlenderben;
		STRING		BorrowerName1;
		STRING		BorrowerName2;
		STRING		OtherBorrowerName; //Contains additional borrower names if multiple names can be parsed
		STRING		DBALenderBen;
		STRING100 raw_file_name;
		BOOLEAN		new_record; //Used to determine what records to pass to property
	END;

END;