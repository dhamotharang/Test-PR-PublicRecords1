IMPORT _control;
EXPORT NAHDBConstants := MODULE
		EXPORT LandingZone		 								:= _control.IPAddress.bctlpedata10;
		
		export prefix                        :=   '/data/super_credit/ecrash/sla_build/';                
		EXPORT InPathForIncident					  := prefix + 'noniyetek/incident/in';
	EXPORT InPathForCommercial					  := prefix + 'noniyetek/commercial/in';
	EXPORT InPathForVehicle					  := prefix + 'noniyetek/vehicle/in';
	EXPORT InPathForCitation					  := prefix + 'noniyetek/citation/in';
	EXPORT InPathForPerson					  := prefix + 'noniyetek/person/in';
  EXPORT InPathForPtyDamage					  := prefix + 'noniyetek/propertyDamage/in';


	EXPORT ProcessPathForIncident					  := prefix + 'noniyetek/incident/process';
	EXPORT ProcessPathForCommercial					  := prefix + 'noniyetek/commercial/process';
	EXPORT ProcessPathForVehicle					  := prefix + 'noniyetek/vehicle/process';
	EXPORT ProcessPathForCitation					  := prefix + 'noniyetek/citation/process';
	EXPORT ProcessPathForPerson					  := prefix + 'noniyetek/person/process';
		EXPORT ProcessPathForPtyDamage					  := prefix + 'noniyetek/propertyDamage/process';


 EXPORT BackupPathForIncident					  := prefix + 'noniyetek/incident/backup';
	EXPORT BackupPathForCommercial					  := prefix + 'noniyetek/commercial/backup';
	EXPORT BackupPathForVehicle					  := prefix + 'noniyetek/vehicle/backup';
	EXPORT BackupPathForCitation					  := prefix + 'noniyetek/citation/backup';
	EXPORT BackupPathForPerson					  := prefix + 'noniyetek/person/backup';
		EXPORT BackupPathForPtyDamage					  := prefix + 'noniyetek/propertyDamage/backup';

	EXPORT DestinationCluster 		        := IF (_control.ThisEnvironment.Name = 'Prod_Thor', 'thor400_44', 'thor400_dev01');	
	EXPORT SprayCompleteFile							:= '~thor::CD::Spray::Complete';
	EXPORT IncidentFileMask												:= 'dbpeccl-ala.risk.regn.net.incident*';
	EXPORT PersonFileMask												  := 'dbpeccl-ala.risk.regn.net.person*';
	EXPORT CommercialFileMask											:= 'dbpeccl-ala.risk.regn.net.commercial*';
	EXPORT CitationFileMask												:= 'dbpeccl-ala.risk.regn.net.citation*';
	EXPORT VehicleFileMask												:= 'dbpeccl-ala.risk.regn.net.vehicle*';
	EXPORT PtyDamageFileMask												:= 'dbpeccl-ala.risk.regn.net.propertyDamage*';

  
	EXPORT INCIDENT_SPRAYED_DAILY      := '~thor_data400::in::ecrash::incidnt_raw_new';
	EXPORT PERSON_SPRAYED_DAILY      := '~thor_data400::in::ecrash::persn_raw';
	EXPORT VEHICLE_SPRAYED_DAILY      := '~thor_data400::in::ecrash::vehicl_raw';
	EXPORT CITATION_SPRAYED_DAILY      := '~thor_data400::in::ecrash::citatn_raw';
	EXPORT COMMERCIAL_SPRAYED_DAILY      := '~thor_data400::in::ecrash::commercl_raw';
	EXPORT PTYDAMAGE_SPRAYED_DAILY      := '~thor_data400::in::ecrash::propertydamage_raw';
	
	EXPORT FILE_DAILY_FILE_LIST := '~thor_data400::temp::ecrash_files_list';

	EXPORT FileSeparator									:= '/';
	
	// the following are constants for the eCrash_Analytics product that are used in keybuilds.
	EXPORT string Auto_Accident 		:= 'AUTO ACCIDENT';
	EXPORT STRING Monday						:= 'MONDAY';
	EXPORT STRING Tuesday						:= 'TUESDAY';
	EXPORT STRING Wednesday					:= 'WEDNESDAY';
	EXPORT STRING Thursday					:= 'THURSDAY';
	EXPORT STRING Friday						:= 'FRIDAY';
	EXPORT STRING Saturday					:= 'SATURDAY';
	EXPORT STRING SUNDAY						:= 'SUNDAY';

	//Collision Types
	EXPORT STRING FRONTREAR					:= 'FRONTREAR';
	EXPORT STRING FRONTFRONT    		:= 'FRONTFRONT'; 
	EXPORT STRING ANGLE							:= 'ANGLE';
	EXPORT STRING SIDESWIPESAME 		:= 'SIDESWIPESAME';
	EXPORT STRING SIDESWIPEOPPOSITE := 'SIDESWIPEOPPOSITE';
	EXPORT STRING REARSIDE					:= 'REARSIDE';
	EXPORT STRING REARREAR					:= 'REARREAR';
	EXPORT STRING OTHER             := 'OTHER';

// Report First Harmful Event
	EXPORT STRING PEDESTRIAN				:= 'PEDESTRIANCOLLISION';
	EXPORT STRING BICYCLE 					:= 'PEDALCYCLECOLLISION';
	EXPORT STRING ANIMAL  					:= 'ANIMALCOLLISION';
	EXPORT STRING TRAIN							:= 'RAILWAYVEHICLECOLLISION';

// Report Vehicle Body Type
	EXPORT STRING PASSENGERCAR      := 'PASSENGERCAR';
	EXPORT STRING SUV								:= 'SUV';
	EXPORT STRING PASSENGERVAN      := 'PASSENGERVAN';
	EXPORT STRING CARGOVAN          := 'CARGOVAN';
	EXPORT STRING PICKUP            := 'PICKUP';
	EXPORT STRING MOTORHOME					:= 'MOTORHOME';
	EXPORT STRING SCHOOLBUS         := 'SCHOOLBUS';
	EXPORT STRING TRANSITBUS        := 'TRANSITBUS';
	EXPORT STRING MOTORCOACH        := 'MOTORCOACH';
	EXPORT STRING OTHERBUS					:= 'OTHERBUS';
	EXPORT STRING MOTORCYCLE				:= 'MOTORCYCLE';
	EXPORT STRING MOPED							:= 'MOPED';
	EXPORT STRING LOWSPEEDVEHICLE		:= 'LOWSPEEDVEHICLE';
	EXPORT STRING ATV								:= 'ATV';
	EXPORT STRING SNOWMOBILE        := 'SNOWMOBILE';
	EXPORT STRING OTHERLIGHTTRUCK   := 'OTHERLIGHTTRUCK';
	EXPORT STRING MEDIUMHEAVYTRUCK  := 'MEDIUMHEAVYTRUCK';

//Injury Status Constants
	EXPORT STRING FATAL             := 'FATAL';
	EXPORT STRING INCAPACITATING    := 'INCAPACITATING';
	EXPORT STRING NONINCAPACITATING := 'NONINCAPACITATING';
	EXPORT STRING POSSIBLE          := 'POSSIBLE';
	EXPORT STRING UNKNOWN						:= 'UNKNOWN';
	EXPORT STRING NOINJURY					:= 'NOINJURY';

END;






