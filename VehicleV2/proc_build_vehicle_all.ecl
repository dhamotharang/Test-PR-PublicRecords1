export proc_build_vehicle_all(filedate)
 :=
  macro

	import vehicleV2;

	
	Proc_Build_Base				:= VehicleV2.Proc_build_Vehicle_Base		   : success(output('Vehicle Base Files created successfully.'));
	Proc_Build_Keys				:= VehicleV2.Proc_build_vehicle_key(filedate) : success(output('Keys created successfully.'));
	Proc_Accept_to_QA			:= VehicleV2.Proc_AcceptSK_ToQA	           : success(output('keys accept to QA', failure(FileServices.sendemail('wma@seisint.com', 'Vehicle Build Failure', failmessage));
	

	sequential(
		 Proc_Build_Base
		,Proc_Build_Keys
		,Proc_Accept_to_QA
		
	);

  endmacro
 ;


