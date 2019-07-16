IMPORT $;

EXPORT Layouts := MODULE
	EXPORT Delete_Rec  := RECORD
		STRING5    fips_cd;
		STRING9		 Pid;
		STRING6    Delete_Flag := '';
		STRING8    ln_filedate;
	END;

	EXPORT Raw_in	:= RECORD
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
	
	EXPORT Raw_out	:= RECORD
		STRING8 ln_filedate := ''; 
		STRING30 bk_infile_type := '';
		Raw_in;
	END;

	EXPORT base  := RECORD
		UNSIGNED6 record_id;
		STRING8 date_first_seen;
		STRING8 date_last_seen;
		STRING8 date_vendor_first_reported;
		STRING8 date_vendor_last_reported;
		STRING8 process_date;
		STRING2 source;
		Raw_out;
	//Name without extra information such as Trustee, AKA, DBA, Husband and Wife, etc
		STRING	ClnOriglenderben;
		STRING	ClnAssignorName;
		STRING	ClnAssignee;
		STRING	ClnBorrowerName;
END;

END;