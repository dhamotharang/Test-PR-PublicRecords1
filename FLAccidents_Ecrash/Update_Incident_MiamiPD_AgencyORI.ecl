IMPORT Data_Services;
EXPORT Update_Incident_MiamiPD_AgencyORI:= FUNCTION

	Incident_MiamiPD_Layout := RECORD
		STRING11 Incident_Id,
	END;

	ds_Incident_MPD   :=	DATASET('~Thor_data400::in::ecrash::ModifyMiamiPDIncidents'
																														,Incident_MiamiPD_Layout
																														,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(10000)))(Incident_ID != 'incident_id');                    


	ds_incident := 		DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
																										,FLAccidents_Ecrash.Layout_Infiles.incident_new
																										,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)))(Incident_ID != 'Incident_ID');                    

	FLAccidents_Ecrash.Layout_Infiles.incident_new updateMiamiPDIncidents(ds_incident L, ds_Incident_MPD R) := TRANSFORM
		SELF.ORI_Number := IF (TRIM(L.ORI_Number, LEFT,RIGHT)  = 'FL0130600'  AND L.Contrib_Source <> 'A', 'FL0130000',L.ORI_Number);
		SELF.Report_Agency_ORI := IF (TRIM(L.Report_Agency_ORI,LEFT,RIGHT) = 'FL0130600'  AND L.Contrib_Source <> 'A','FL0130000',L.Report_Agency_ORI);
		SELF := L;
	END;

	Cmbnd_MiamiPDIncidents := JOIN(DISTRIBUTE(ds_incident,HASH64(Incident_Id)),DISTRIBUTE(ds_Incident_MPD,HASH64(Incident_Id)),
																																TRIM(LEFT.Incident_Id,LEFT,RIGHT) = TRIM(RIGHT.Incident_Id,LEFT,RIGHT),
																																updateMiamiPDIncidents(LEFT,RIGHT), LEFT OUTER, LOCAL);


	OUTPUT(Cmbnd_MiamiPDIncidents,,'~thor_data400::in::ecrash::incident_patch_MiamiPDAgency_'+WORKUNIT,OVERWRITE, __COMPRESSED__,
								CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)));

	RETURN SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_patch_MiamiPDAgency_'+WORKUNIT),
		FileServices.FinishSuperFileTransaction()
	);
END;