IMPORT BatchShare, FFD, FCRA, Prof_LicenseV2, Prof_LicenseV2_Services;

EXPORT Layouts := MODULE

	EXPORT FCRA := MODULE

		EXPORT inputRec:=RECORD
			BatchShare.Layouts.ShareAcct;
			BatchShare.Layouts.ShareDid;
			BatchShare.Layouts.ShareName;
			BatchShare.Layouts.SharePII;
			BatchShare.Layouts.ShareAddress;
		END;

		EXPORT workRec:=RECORD
			inputRec;
			TYPEOF(BatchShare.Layouts.ShareAcct.acctno) orig_acctno;
			Batchshare.Layouts.ShareErrors;
		END;

		// DISCLOSE ONLY
		EXPORT proflicRec:=RECORD
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.date_first_seen;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.date_last_seen;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.profession_or_board;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.license_type;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.status;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.license_number;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.issue_date;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.expiration_date;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.last_renewal_date;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.board_action_indicator;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.source_st;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.vendor;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.education_1_school_attended;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.education_1_dates_attended;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.education_1_degree;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.status_effective_dt;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.fname;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.mname;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.lname;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.name_suffix;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.dob;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.phone;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.prim_range;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.predir;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.prim_name;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.suffix;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.postdir;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.unit_desig;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.sec_range;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.p_city_name;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.st;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.zip;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.zip4;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.county;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.county_name;
		END;

		EXPORT proflicBatchOutRec:=RECORD
			BatchShare.Layouts.ShareAcct;
			UNSIGNED SequenceNumber;
			BatchShare.Layouts.ShareDid;
			BatchShare.Layouts.ShareErrors.error_code;
			proflicRec;
			FFD.Layouts.ConsumerFlags;
			STRING12 inquiry_lexid;
		END;

		EXPORT proflicWorkRec:=RECORD
			proflicBatchOutRec;
			Prof_LicenseV2.Layouts_ProfLic.Layout_Base.prolic_key;
			DATASET(FFD.Layouts.ConsumerStatementBatch) StatementsAndDisputes;
			FFD.Layouts.CommonRawRecordElements;
		END;

	END;

END;
