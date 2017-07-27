
IMPORT BatchShare, doxie_crs, DriversV2_Services, VehicleV2_Services, VotersV2_Services, WatercraftV2_Services;

EXPORT Layouts := MODULE

	EXPORT batch_in := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress;
		BatchShare.Layouts.SharePII;	
	END;

	// =========================== INTERMEDIATE LAYOUTS ===========================

	EXPORT layout_drivers_license_raw := RECORD
		BatchShare.Layouts.ShareAcct;
		DriversV2_Services.layouts.result_narrow;
	END;
	
	EXPORT layout_voters_raw := RECORD
		BatchShare.Layouts.ShareAcct;
		VotersV2_Services.layouts.SourceOutput;
	END;

	EXPORT layout_watercraft_raw := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		WatercraftV2_Services.Layouts.WCReportEX AND NOT acctno;
	END;	
	
	EXPORT layout_faa_raw := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		doxie_crs.layout_Faa_Aircraft_records;
	END;
	
	EXPORT layout_RT_mvr_raw := RECORD
		VehicleV2_Services.Layouts_RTBatch_V2.rec_V2 AND NOT acctno;
		VehicleV2_Services.Layouts_RTBatch_V2.rec_out;
	END;	
	EXPORT layout_batch_in_waddr_status := RECORD
		batch_in;
		string4  addr_status := '';
		END;
END;