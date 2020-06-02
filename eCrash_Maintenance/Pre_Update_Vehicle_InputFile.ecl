/*
One time BWR to expand Vehicle file layout with new fields.
*/
IMPORT Data_Services, FLAccidents_Ecrash;
EXPORT Pre_Update_Vehicle_InputFile := FUNCTION

 ds_vehicle := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::vehicl_raw'
											,Layout_Vehicle
											,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Vehicle_ID != 'Person_ID');
													 

 FLAccidents_Ecrash.Layout_Infiles.vehicl_NEW ExpandVehicleLayout(ds_vehicle L) := TRANSFORM
																																									  SELF := L;
																																									  SELF := [];
																																								   END;
																									 
 upd_vehicle_layout := PROJECT(ds_vehicle, ExpandVehicleLayout(LEFT));
		
 ds_vehicle_upd := OUTPUT(upd_vehicle_layout,,'~thor_data400::in::ecrash::vehicle_layout_change_'+workunit,overwrite,__compressed__,
				csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

 do_all :=  SEQUENTIAL(
												ds_vehicle_upd, 
												FileServices.StartSuperFileTransaction(),
												FileServices.AddSuperFile('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::vehicle_layout_change_'+workunit),
												FileServices.FinishSuperFileTransaction()
										  );
					 
 RETURN do_all;
END;

