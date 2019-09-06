/*
One time BWR to update Nucleus Image fields.
*/
IMPORT Data_Services, STD;
EXPORT Update_Incident_Nucleus_Image_hist_data() := FUNCTION

   lay_stats := RECORD
	  STRING Desc;
		UNSIGNED2 CntIN;
		UNSIGNED2 CntGA;
	 END;

	 ds_incident := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::incidnt_raw_new'
												 ,FLAccidents_Ecrash.Layout_Infiles.incident_new
												 ,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"'),MAXLENGTH(60000)))(incident_id != 'Incident_ID');
												
   cntcrashlogicin := COUNT(ds_incident(STD.Str.ToUpperCase(TRIM(Vendor_Code, ALL)) = 'CRASHLOGIC' AND STD.Str.ToUpperCase(TRIM(Loss_State_Abbr, ALL)) = 'IN'));
   cntcrashlogicga := COUNT(ds_incident(STD.Str.ToUpperCase(TRIM(Vendor_Code, ALL)) = 'CRASHLOGIC' AND STD.Str.ToUpperCase(TRIM(Loss_State_Abbr, ALL)) = 'GA'));
		
		FLAccidents_Ecrash.Layout_Infiles.incident_new UpdIncident(ds_incident L) := TRANSFORM
			isVendorIN := STD.Str.ToUpperCase(TRIM(L.Vendor_Code, ALL)) = 'CRASHLOGIC' AND STD.Str.ToUpperCase(TRIM(L.Loss_State_Abbr, ALL)) = 'IN';
			isVendorGA := STD.Str.ToUpperCase(TRIM(L.Vendor_Code, ALL)) = 'CRASHLOGIC' AND STD.Str.ToUpperCase(TRIM(L.Loss_State_Abbr, ALL)) = 'GA';
			
			SELF.Vendor_Code := MAP(isVendorIN => 'Aries', 
															isVendorGA => 'Gears',
															L.Vendor_Code);
			SELF.Vendor_Report_Id  := MAP(isVendorIN => L.State_Report_Number, 
																		isVendorGA => L.State_Report_Number,
																		L.Vendor_Report_Id);
			SELF := L;
		END;
		upd_incident := PROJECT(ds_incident, UpdIncident(LEFT)):INDEPENDENT;
							
		cntariesin := COUNT(upd_incident(STD.Str.ToUpperCase(TRIM(Vendor_Code, ALL)) = 'ARIES' AND STD.Str.ToUpperCase(TRIM(Loss_State_Abbr, ALL)) = 'IN'));
		cntgearsga := COUNT(upd_incident(STD.Str.ToUpperCase(TRIM(Vendor_Code, ALL)) = 'GEARS' AND STD.Str.ToUpperCase(TRIM(Loss_State_Abbr, ALL)) = 'GA'));
		
		OUTPUT(upd_incident,,'~thor_data400::in::ecrash::incident_nucleus_image_hist_'+workunit,overwrite,__compressed__,
					    csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));
							
		incident_out := SEQUENTIAL(
															 FileServices.StartSuperFileTransaction(),
															 FileServices.ClearSuperFile('~thor_data400::in::ecrash::incidnt_raw_new', FALSE),
															 FileServices.AddSuperFile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_nucleus_image_hist_'+workunit),
															 FileServices.FinishSuperFileTransaction()
															);
							
		//Calculating stats
    ds_pre_delete := DATASET([{'CrashLogic', cntcrashlogicin, cntcrashlogicga}], lay_stats);
    ds_post_delete := DATASET([{'Aries IN & Gears GA', cntariesin, cntgearsga}], lay_stats);
		ds_final_stats := ds_pre_delete & ds_post_delete;
							
		do_all :=  SEQUENTIAL(
		                      OUTPUT(ds_pre_delete,,NAMED('CrashLogic')),
													incident_out,
													OUTPUT(ds_post_delete,,NAMED('Aries_Gears')),
													OUTPUT(ds_final_stats,,NAMED('FinalStats'))
												 );
					 
		RETURN do_all;
END;

