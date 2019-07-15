import Orbit_Report,RoxieKeyBuild, dops, Scrubs_VehicleV2;

//export proc_build_vehicle_all(process_date)	:=
export proc_build_vehicle_all(process_date, file_date='')	:=
  macro
  
  #workunit('name','VehicleV2 build ' + process_date);
	#OPTION('multiplePersistInstances',FALSE);

	import vehicleV2;
	
  Email_Recipients := 'cathy.tio@lexisnexis.com,charles.pettola@lexisnexisrisk.com';
	
  VehicleV2.proc_build_stats(process_date,zDoStatsReference)			// now a macro
  
	Spray_NC_Files							:= VehicleV2.Spray_NC_Update(process_date)							: success(output('NC Vehicle spray was successfully completed.'));
	Spray_OH_Files							:= VehicleV2.Spray_OH_Vehicle_In_Fixed									: success(output('OH Vehicle spray was successfully completed.'));
	Spray_Infutor_VIN_Files			:= VehicleV2.Spray_Infutor_Vin(process_date,file_date)	: success(output('Infutor VIN Vehicle spray was successfully completed.'));
	Spray_Infutor_Motorcycle_Files	:= VehicleV2.Spray_Infutor_Motorcycle(process_date)	: success(output('Infutor Motorcycle spray was successfully completed.'));
	
	VINA_Info										:= VehicleV2.Populate_VINA_Info													: success(output('Poulation of VINA information succeeded'));

	//BUG 168876 - Scrub input files
	// Scrub_Experian_Files				:= Scrubs_VehicleV2_Experian.proc_submit_stats(process_date)					  : success(output('Scrub Experian input file completed.'));
	// Scrub_Infutor_Motorcycle_Files:= Scrubs_VehicleV2_Infutor_Motorcycle.proc_submit_stats(process_date): success(output('Scrub Infutor Motorcycle input file completed.'));
	// Scrub_Infutor_VIN_Files			:= Scrubs_VehicleV2_Infutor_Vin.proc_submit_stats(process_date)					: success(output('Scrub Infutor Vin input file completed.'));
	// Scrub_OH_Direct_Files				:= Scrubs_VehicleV2_OH_Direct.proc_submit_stats(process_date)						: success(output('Scrub OH Direct input file completed.'));
	
	//DF-23405 - Scrubs_VehicleV2 - use new scrubs attribute and modified some field type 
	Scrubs_Input_Files				:= Scrubs_VehicleV2.fn_RunScrubs(process_date,Email_Recipients);
	
	Build_Experian_Base									:=	VehicleV2.Experian_as_Base													:	success(output('Build Experian Base successfully completed.'));
	Build_NC_Base															:=	VehicleV2.NC_as_Base																:	success(output('Build NC Base successfully completed.'));
	Build_OH_Base															:=	VehicleV2.OH_As_Base																:	success(output('Build OH Base successfully completed.'));
  Build_Infutor_Vin_Base					:=	VehicleV2.Infutor_Vin_as_Base												:	success(output('Build Infutor Vin Base successfully completed.'));
  Build_Infutor_Motorcycle_Base	:=	VehicleV2.Infutor_Motorcycle_as_Base							:	success(output('Build Infutor Motorcycle Base successfully completed.'));
	
	Proc_Build_Base													:= VehicleV2.Proc_build_Vehicle_Base		   							: success(output('Vehicle Base Files created successfully.'));
	Proc_Build_Keys1												:= VehicleV2.Proc_build_vehicle_key(process_date)				: success(output('Keys created successfully.'));
  Proc_build_booleankeys     := VehicleV2.Proc_Build_Boolean_Keys(process_date) 			: success(output('Boolean Keys created successfully.'));
	
	proc_build_stats            := zDoStatsReference                           					: success(output('Stats created successfully.'));
  new_records_sample_for_qa		:= VehicleV2.new_records_sample(process_date)      			: success(VehicleV2.Email_notification_lists(process_date).VehicleV2BuildCompletion),failure(FileServices.sendemail(Email_Recipients,'VehicleV2 build failed',failmessage));
	new_records_sample_OH_for_qa:= VehicleV2.New_Records_Sample_OH             					: success(VehicleV2.Email_notification_lists(process_date).VehicleV2BuildCompletion),failure(FileServices.sendemail(Email_Recipients,'VehicleV2 build failed',failmessage));
	new_records_sample_INF_for_qa:= VehicleV2.new_records_sample_Infutor       					: success(VehicleV2.Email_notification_lists(process_date).VehicleV2BuildCompletion),failure(FileServices.sendemail(Email_Recipients,'VehicleV2 build failed',failmessage));
  
  vehicleV2.Mac_is_rebuild_picker_file(rewrite_VINA_subname,rebuild_picker)
  build_picker_file           := VehicleCodes.GetMakeModel(process_date)							: success(VehicleV2.Email_notification_lists(process_date).PickerBuildCompletion),failure(FileServices.sendemail(Email_Recipients,'picker file failed to despray',failmessage));
	proc_picker_file            := if(rebuild_picker,sequential(build_picker_file,rewrite_VINA_subname),FileServices.sendemail('kgummadi@seisint.com;wma@seisint.com','no picker file rebuild for this build',''));	

	proc_delete_persist_files   := VehicleV2.Delete_persist_files              					: success(VehicleV2.Email_notification_lists(process_date).VehicleV2PersistfilesDeletion),failure(FileServices.sendemail(Email_Recipients,'persist files failed to delete',failmessage));

	update_dops_non_fcra				:= dops.updateversion('VehicleV2Keys',process_date,Email_Recipients,,'N|B');
	//update_dops_fcra						:= RoxieKeyBuild.updateversion('FCRA_VehicleV2Keys',process_date,Email_Recipients,,'F');
	//update_dops									:= parallel(update_dops_non_fcra,update_dops_fcra);

	Orbit_report.Vehicle_Stats(getretval);

	// Create orbitI build instance
	createOrbitIBldInstance	:=	VehicleV2.Proc_OrbitI_CreateBuild(process_date);
	
	// Update DOPS in Alpharetta
	updateIDops	:=	dops.updateversion('VehicleV2Keys',process_date,Email_Recipients,,'N',,,'A');

	sequential(	Spray_NC_Files,
							Spray_OH_Files,
							Spray_Infutor_VIN_Files,
							Spray_Infutor_Motorcycle_Files,
							VINA_Info,
							// Scrub_Experian_Files,
							// Scrub_Infutor_Motorcycle_Files,
							// Scrub_Infutor_VIN_Files,
							// Scrub_OH_Direct_Files,
							Scrubs_Input_Files,
							Build_Experian_Base,
							Build_NC_Base,
							Build_OH_Base,
							Build_Infutor_Vin_Base,
							Build_Infutor_Motorcycle_Base,
							Proc_Build_Base,
							Proc_Build_Keys1,
							Proc_build_booleankeys,
							update_dops_non_fcra,
							proc_build_stats,
							new_records_sample_for_qa,
							new_records_sample_OH_for_qa,
							new_records_sample_INF_for_qa,
							proc_picker_file,
							proc_delete_persist_files,
							getretval,
							createOrbitIBldInstance,
							updateIDops
						);
endmacro;