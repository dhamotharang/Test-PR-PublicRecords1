IMPORT _control;
EXPORT NtlConstants := MODULE
		EXPORT LandingZone		 								:= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10);
		
		export prefix                        :=   '/data/super_credit/flcrash/alpharetta/cruinquiry/';                

		EXPORT InPathForIntorder					  := prefix + 'int_order/in';
	EXPORT InPathForOrdervs					  := prefix + 'order_version/in';
	EXPORT InPathForVehicle					  := prefix + 'vehicle/in';
	EXPORT InPathForresult					  := prefix + 'result/in';
	EXPORT InPathForVehIncidnt					  := prefix + 'vehicle_incident/in';
  EXPORT InPathForVehpty					  := prefix + 'vehicle_party/in';
  EXPORT InPathForVehinscr					  := prefix + 'vehicle_insurance_carrier/in';
    EXPORT InPathForClient					  := prefix + 'client/in';


	EXPORT ProcessPathForIntorder					  := prefix + 'int_order/process';
	EXPORT ProcessPathForOrdervs					  := prefix + 'order_version/process';
	EXPORT ProcessPathForVehicle					  := prefix + 'vehicle/process';
	EXPORT ProcessPathForVehIncidnt					  := prefix + 'vehicle_incident/process';
	EXPORT ProcessPathForVehpty					  := prefix + 'vehicle_party/process';
		EXPORT ProcessPathForVehinscr					  := prefix + 'vehicle_insurance_carrier/process';
		    EXPORT ProcessPathForClient					  := prefix + 'client/process';
 EXPORT ProcessPathForresult					  := prefix + 'result/process';




 EXPORT BackupPathForIntorder					  := prefix + 'int_order/backup';
	EXPORT BackupPathForOrdervs					  := prefix + 'order_version/backup';
	EXPORT BackupPathForVehicle					  := prefix + 'vehicle/backup';
	EXPORT BackupPathForVehIncidnt					  := prefix + 'vehicle_incident/backup';
	EXPORT BackupPathForVehpty					  := prefix + 'vehicle_party/backup';
		EXPORT BackupPathForVehinscr					  := prefix + 'vehicle_insurance_carrier/backup';
	EXPORT BackupPathForClient					  := prefix + 'client/backup';
	 EXPORT BackupPathForresult					  := prefix + 'result/backup';




	EXPORT DestinationCluster 		        := IF (_control.ThisEnvironment.Name = 'Prod_Thor', 'thor400_44', 'thor40_241');	
	EXPORT SprayCompleteFile							:= '~thor::CD::Spray::Complete';
	EXPORT IntorderFileMask												:= '*.int_order*';
	EXPORT OrdervsFileMask												  := '*.order_version*';
	EXPORT VehicleFileMask											:= '*.vehicle*';
	EXPORT ResultFileMask												:= '*.result*';
	EXPORT VehIncidntFileMask												:= '*.vehicle_incident*';
	EXPORT VehPtyFileMask												:= '*.vehicle_party*';
		EXPORT ClientFileMask												:= '*.client*';
				EXPORT VehinscrFileMask												:= '*.vehicle_insurance_carrier*';



  
	EXPORT INTORDER_SPRAYED_DAILY      := '~thor_data400::in::flcrash::alpharetta::int_order_new';
	EXPORT ORDERVS_SPRAYED_DAILY      := '~thor_data400::in::flcrash::alpharetta::order_version_new';
	EXPORT VEHICLE_SPRAYED_DAILY      := '~thor_data400::in::flcrash::alpharetta::vehicle_new';
	EXPORT RESULT_SPRAYED_DAILY      := '~thor_data400::in::flcrash::alpharetta::result_new';
	EXPORT VEHINCIDENT_SPRAYED_DAILY      := '~thor_data400::in::flcrash::alpharetta::vehicle_incident_new';
	EXPORT VEHPARTY_SPRAYED_DAILY      := '~thor_data400::in::flcrash::alpharetta::vehicle_party_new';
		EXPORT CLIENT_SPRAYED_DAILY      := '~thor_data400::in::flcrash::alpharetta::client_new';
		EXPORT VEHINS_SPRAYED_DAILY      := '~thor_data400::in::flcrash::alpharetta::vehicle_insurance_carrier_new';


	
	EXPORT FILE_DAILY_FILE_LIST := '~thor_data400::temp::flcrash_files_list';

	EXPORT FileSeparator									:= '/';
	
	// the following are constants for the eCrash_Analytics product that are used in keybuilds.
	

END;






