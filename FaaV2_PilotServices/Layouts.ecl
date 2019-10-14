import faa, iesp, FFD, BatchShare;
	
export Layouts := MODULE

   export pilotRawrec := record
					  recordof(faa.key_airmen_rid);
						boolean isDeepDive := false;
						unsigned2 penalt := 0;
						boolean isDisputed := false;
						dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
	 end;
	 export pilotReportRawrec := record
						recordof(faa.key_airmen_certs);
						boolean isDisputed := false;
						dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
	 end;
	 export pilotUniqueIDPlus := record
					string7 unique_id;  
					string1 letter_code;  
					unsigned6 did;
					unsigned6 airmen_id;
					boolean isDeepDive := false;
	 end;
	 export t_PilotRecordWithPenalty := record
			 iesp.faapilot_Fcra.t_FcraPilotRecord;
			 string7 unique_id := '';
			 unsigned6 airmen_id := 0;
	 end;
		export t_PilotReportWithPenalty := record
		   iesp.faapilot.t_PilotReportCertificate;
			 string7 unique_id := '';
		end;
		
	EXPORT batch_in:=RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.SharePII;
		BatchShare.Layouts.ShareAddress;
	END;

	EXPORT batch_work:=RECORD
		batch_in;
		TYPEOF(BatchShare.Layouts.ShareAcct.acctno) orig_acctno;
		Batchshare.Layouts.ShareErrors;
	END;

	EXPORT airmenRec:=RECORD
		faa.layout_airmen_data_out.date_first_seen;
		faa.layout_airmen_data_out.date_last_seen;
		faa.layout_airmen_data_out.current_flag;
		faa.layout_airmen_data_out.letter_code;
		faa.layout_airmen_data_out.record_type;
		TYPEOF(faa.layout_airmen_data_out.unique_id) pilot_rec_id;
		faa.layout_airmen_data_out.region;
		STRING region_desc;
		faa.layout_airmen_data_out.country;
		faa.layout_airmen_data_out.med_class;
		STRING med_class_desc;
		STRING8 med_date;
		STRING8 med_exp_date;
		faa.layout_airmen_data_out.best_ssn;
		faa.layout_airmen_data_out.title;
		faa.layout_airmen_data_out.fname;
		faa.layout_airmen_data_out.mname;
		faa.layout_airmen_data_out.lname;
		faa.layout_airmen_data_out.name_suffix;
		faa.layout_airmen_data_out.prim_range;
		faa.layout_airmen_data_out.predir;
		faa.layout_airmen_data_out.prim_name;
		faa.layout_airmen_data_out.suffix;
		faa.layout_airmen_data_out.postdir;
		faa.layout_airmen_data_out.unit_desig;
		faa.layout_airmen_data_out.sec_range;
		faa.layout_airmen_data_out.v_city_name;
		faa.layout_airmen_data_out.st;
		faa.layout_airmen_data_out.zip;
		faa.layout_airmen_data_out.zip4;
		faa.layout_airmen_data_out.county_name;
		UNSIGNED airmen_id;
	END;

	EXPORT batch_out:=RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareErrors.error_code;
		airmenRec;
	END;

	EXPORT batch_out_flat:=RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareErrors.error_code;
		BatchShare.MAC_ExpandLayout.Generate(airmenRec,'',FaaV2_PilotServices.Constants.MAX_AIRMEN,FALSE,'_');
	END;

END;	