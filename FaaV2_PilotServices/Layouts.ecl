import faa, iesp, FFD;
	
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
		
END;	