IMPORT BatchShare, FFD, Email_Data;

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
		EXPORT emailRec := RECORD
			Email_Data.Layout_Email.Base.date_first_seen;
			Email_Data.Layout_Email.Base.date_last_seen;
			Email_Data.Layout_Email.Base.date_vendor_first_reported;
			Email_Data.Layout_Email.Base.date_vendor_last_reported;
			Email_Data.Layout_Email.Base.email_src;
			Email_Data.Layout_Email.Base.clean_email;
			Email_Data.Layout_Email.Base.orig_login_date;
			Email_Data.Layout_Email.Base.orig_site;
			Email_Data.Layout_Email.Base.Clean_Name.title;
			Email_Data.Layout_Email.Base.Clean_Name.fname;
			Email_Data.Layout_Email.Base.Clean_Name.mname;
			Email_Data.Layout_Email.Base.Clean_Name.lname;
			Email_Data.Layout_Email.Base.Clean_Name.name_suffix;
			Email_Data.Layout_Email.Base.Clean_Address.prim_range;
			Email_Data.Layout_Email.Base.Clean_Address.predir;
			Email_Data.Layout_Email.Base.Clean_Address.prim_name;
			Email_Data.Layout_Email.Base.Clean_Address.addr_suffix;
			Email_Data.Layout_Email.Base.Clean_Address.postdir;
			Email_Data.Layout_Email.Base.Clean_Address.unit_desig;
			Email_Data.Layout_Email.Base.Clean_Address.sec_range;
			Email_Data.Layout_Email.Base.Clean_Address.p_city_name;
			Email_Data.Layout_Email.Base.Clean_Address.st;
			Email_Data.Layout_Email.Base.Clean_Address.zip;
			Email_Data.Layout_Email.Base.Clean_Address.zip4;
			Email_Data.Layout_Email.Base.Clean_Address.county;
		END;

		EXPORT emailBatchOutRec:=RECORD
			BatchShare.Layouts.ShareAcct;
			UNSIGNED SequenceNumber;
			BatchShare.Layouts.ShareDid;
			BatchShare.Layouts.ShareErrors.error_code;
			emailRec;
			FFD.Layouts.ConsumerFlags;
			STRING12 inquiry_lexid;
		END;

		EXPORT emailWorkRec:=RECORD
			emailBatchOutRec;
			Email_Data.Layout_Email.Base.email_rec_key;
			DATASET(FFD.Layouts.ConsumerStatementBatch) StatementsAndDisputes;
			FFD.Layouts.CommonRawRecordElements;
		END;

	END;

END;
