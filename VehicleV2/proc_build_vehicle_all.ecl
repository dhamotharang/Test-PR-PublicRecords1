IMPORT STD, Orbit_Report, Orbit3, RoxieKeyBuild, dops, Scrubs_VehicleV2, VehicleV2;

//export proc_build_vehicle_all(pVersion) :=
EXPORT proc_build_vehicle_all(
	pSourceIP,
	pDirectory,
	pVersion,
	pContacts,
	pOverride=TRUE,
	pSprayInfutorVin=TRUE,
	pSprayInfutorMotorcycle=TRUE
) := MACRO

	/*#OPTION('multiplePersistInstances',FALSE);*/

	Email_Recipients := IF(pContacts <> '', pContacts + ',', '') + 'cathy.tio@lexisnexis.com';

	VehicleV2.proc_build_stats(pVersion,zDoStatsReference);

	Spray_Experian_Files := VehicleV2.Spray_Experian(
		pSourceIP,
		pDirectory,
		pVersion,
		pOverwrite := pOverride
	) : SUCCESS(OUTPUT('Experian spray was successfully completed.'));

	Exec_Spray_Infutor_VIN_Files := VehicleV2.Spray_Infutor_Vin(
		pSourceIP,
		pDirectory,
		pVersion,
		pOverwrite := pOverride
	) : SUCCESS(OUTPUT('Infutor VIN Vehicle spray was successfully completed.'));

	Spray_Infutor_VIN_Files := IF (
		pSprayInfutorVin,
		Exec_Spray_Infutor_VIN_Files,
		OUTPUT('No New Infutor VIN file available for spray')
	);

	Exec_Spray_Infutor_Motorcycle_Files := VehicleV2.Spray_Infutor_Motorcycle(
		pSourceIP,
		pDirectory,
		pVersion,
		pOverwrite := pOverride
	) : SUCCESS(OUTPUT('Infutor Motorcycle spray was successfully completed.'));

	Spray_Infutor_Motorcycle_Files := IF (
		pSprayInfutorMotorcycle,
		Exec_Spray_Infutor_Motorcycle_Files,
		OUTPUT('No New Infutor Motorcycle file available for spray')
	);

	VINA_Info := VehicleV2.Populate_VINA_Info:
		SUCCESS(OUTPUT('Poulation of VINA information succeeded'));

	//BUG 168876 - Scrub input files
	/*
	Scrub_Experian_Files := Scrubs_VehicleV2_Experian.proc_submit_stats(pVersion):
		SUCCESS(OUTPUT('Scrub Experian input file completed.'));

	Scrub_Infutor_Motorcycle_Files := Scrubs_VehicleV2_Infutor_Motorcycle.proc_submit_stats(pVersion):
		SUCCESS(OUTPUT('Scrub Infutor Motorcycle input file completed.'));

	Scrub_Infutor_VIN_Files := Scrubs_VehicleV2_Infutor_Vin.proc_submit_stats(pVersion):
		SUCCESS(OUTPUT('Scrub Infutor Vin input file completed.'));
	*/

	//DF-23405 - Scrubs_VehicleV2 - use new scrubs attribute and modified some field type 
	Scrubs_Input_Files := Scrubs_VehicleV2.fn_RunScrubs(pVersion,Email_Recipients);
	
	Build_Experian_Base := VehicleV2.Experian_as_Base:
		SUCCESS(OUTPUT('Build Experian Base successfully completed.'));

	Build_NC_Base := VehicleV2.NC_as_Base:
		SUCCESS(OUTPUT('Build NC Base successfully completed.'));

	Build_OH_Base := VehicleV2.OH_As_Base:
		SUCCESS(OUTPUT('Build OH Base successfully completed.'));

	Build_Infutor_Vin_Base := VehicleV2.Infutor_Vin_as_Base:
		SUCCESS(OUTPUT('Build Infutor Vin Base successfully completed.'));

	Build_Infutor_Motorcycle_Base := VehicleV2.Infutor_Motorcycle_as_Base:
		SUCCESS(OUTPUT('Build Infutor Motorcycle Base successfully completed.'));

	Proc_Build_Base := VehicleV2.Proc_build_Vehicle_Base:
		SUCCESS(OUTPUT('Vehicle Base Files created successfully.'));

	Proc_Build_Keys1 := VehicleV2.Proc_build_vehicle_key(pVersion):
		SUCCESS(OUTPUT('Keys created successfully.'));

	Proc_build_booleankeys := VehicleV2.Proc_Build_Boolean_Keys(pVersion):
		SUCCESS(OUTPUT('Boolean Keys created successfully.'));

	proc_build_stats := zDoStatsReference: SUCCESS(OUTPUT('Stats created successfully.'));

	new_records_sample_for_qa := VehicleV2.new_records_sample(pVersion):
		SUCCESS(VehicleV2.Email_notification_lists(pVersion).VehicleV2BuildCompletion),
		FAILURE(STD.System.Email.SendEmail(Email_Recipients,'VehicleV2 build failed',failmessage));

	new_records_sample_OH_for_qa := VehicleV2.New_Records_Sample_OH:
		SUCCESS(VehicleV2.Email_notification_lists(pVersion).VehicleV2BuildCompletion),
		FAILURE(STD.System.Email.SendEmail(Email_Recipients,'VehicleV2 build failed',failmessage));

	new_records_sample_INF_for_qa := VehicleV2.new_records_sample_Infutor:
		SUCCESS(VehicleV2.Email_notification_lists(pVersion).VehicleV2BuildCompletion),
		FAILURE(STD.System.Email.SendEmail(Email_Recipients,'VehicleV2 build failed',failmessage));

	vehicleV2.Mac_is_rebuild_picker_file(rewrite_VINA_subname,rebuild_picker)
	build_picker_file := VehicleCodes.GetMakeModel(pVersion):
		SUCCESS(VehicleV2.Email_notification_lists(pVersion).PickerBuildCompletion),
		FAILURE(STD.System.Email.SendEmail(Email_Recipients,'picker file failed to despray',failmessage));

	proc_picker_file := IF(
		rebuild_picker,
		SEQUENTIAL(
			build_picker_file,
			rewrite_VINA_subname
		),
		STD.System.Email.SendEmail(
			Email_Recipients,
			'no picker file rebuild for this build',
			''
		)
	);

	proc_delete_persist_files := VehicleV2.Delete_persist_files:
		SUCCESS(VehicleV2.Email_notification_lists(pVersion).VehicleV2PersistfilesDeletion),
		FAILURE(STD.System.Email.SendEmail(Email_Recipients,'persist files failed to delete',failmessage));

	update_dops_non_fcra := dops.updateversion('VehicleV2Keys',pVersion,Email_Recipients,,'N|B');

	Orbit_report.Vehicle_Stats(getretval);

	// Create ORBIT build instance
	create_orbit_build_instance := Orbit3.proc_Orbit3_CreateBuild_AddItem(
		'Motor Vehicle Registrations',
		pVersion,
		'N|B',
		email_list := STD.Str.FindReplace(Email_Recipients, ',', ';')
	);

	SEQUENTIAL(
		Spray_Experian_Files,
		Spray_Infutor_VIN_Files,
		Spray_Infutor_Motorcycle_Files,
		VINA_Info,
		/* 
		Scrub_Experian_Files,
		Scrub_Infutor_Motorcycle_Files,
		Scrub_Infutor_VIN_Files,
		*/
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
		create_orbit_build_instance
	);

ENDMACRO;
