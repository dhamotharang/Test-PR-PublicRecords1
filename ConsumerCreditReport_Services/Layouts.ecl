IMPORT BatchShare, iesp, Risk_Indicators;

EXPORT Layouts := MODULE

	EXPORT inputRec := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING100 name_full;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.SharePII;
		BatchShare.Layouts.SharePhone;
		BatchShare.Layouts.ShareAddress;
		BatchShare.Layouts.ShareDid;
	END;

	EXPORT workRec := RECORD
		inputRec;
		STRING20 orig_acctno;
		Batchshare.Layouts.ShareErrors;
		Risk_Indicators.Layouts.tmp_ConsumerStatements;
	END;

	EXPORT ccrResp := RECORD
		STRING20 AccountNumber;
		STRING2 Source;
		STRING12 UniqueId1;
		STRING12 UniqueId2;
		iesp.consumercreditreport_fcra.t_FcraConsumerCreditReportResponse AND NOT ConsumerStatements;
		Risk_Indicators.Layouts.tmp_ConsumerStatements;
	END;

END;