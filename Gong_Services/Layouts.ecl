IMPORT BatchShare, FFD, FCRA, Gong_Services;

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
		EXPORT gongRec := RECORD
			FCRA.Layout_Override_Gong.dt_first_seen;
			FCRA.Layout_Override_Gong.dt_last_seen;
			FCRA.Layout_Override_Gong.src;
			FCRA.Layout_Override_Gong.phone10;
			FCRA.Layout_Override_Gong.listing_type_bus;
			FCRA.Layout_Override_Gong.listing_type_res;
			FCRA.Layout_Override_Gong.listing_type_gov;
			FCRA.Layout_Override_Gong.publish_code;
			FCRA.Layout_Override_Gong.disc_cnt12;
			FCRA.Layout_Override_Gong.name_prefix;
			FCRA.Layout_Override_Gong.name_first;
			FCRA.Layout_Override_Gong.name_middle;
			FCRA.Layout_Override_Gong.name_last;
			FCRA.Layout_Override_Gong.name_suffix;
			FCRA.Layout_Override_Gong.prim_range;
			FCRA.Layout_Override_Gong.predir;
			FCRA.Layout_Override_Gong.prim_name;
			FCRA.Layout_Override_Gong.suffix;
			FCRA.Layout_Override_Gong.postdir;
			FCRA.Layout_Override_Gong.unit_desig;
			FCRA.Layout_Override_Gong.sec_range;
			FCRA.Layout_Override_Gong.p_city_name;
			FCRA.Layout_Override_Gong.st;
			FCRA.Layout_Override_Gong.z5;
			FCRA.Layout_Override_Gong.z4;
		END;

		EXPORT gongBatchOutRec:=RECORD
			BatchShare.Layouts.ShareAcct;
			UNSIGNED SequenceNumber;
			BatchShare.Layouts.ShareDid;
			BatchShare.Layouts.ShareErrors.error_code;
			gongRec;
			FFD.Layouts.ConsumerFlags;
			STRING12 inquiry_lexid;
		END;

		EXPORT gongWorkRec := RECORD
			gongBatchOutRec;
			FCRA.Layout_Override_Gong.persistent_record_id;
			DATASET(FFD.Layouts.ConsumerStatementBatch) StatementsAndDisputes;
			FFD.Layouts.CommonRawRecordElements;
		END;

	END;

END;
