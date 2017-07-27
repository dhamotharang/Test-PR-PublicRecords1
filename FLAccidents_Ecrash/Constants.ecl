IMPORT _control;
EXPORT CONSTANTS := MODULE
   	EXPORT LandingZone		 								:= _Control.IPAddress.edata12;
		
		EXPORT InPathForIncident					  := '/super_credit/ecrash/noniyetek/incident/in';
	EXPORT InPathForCommercial					  := '/super_credit/ecrash/noniyetek/commercial/in';
	EXPORT InPathForVehicle					  := '/super_credit/ecrash/noniyetek/vehicle/in';
	EXPORT InPathForCitation					  := '/super_credit/ecrash/noniyetek/citation/in';
	EXPORT InPathForPerson					  := '/super_credit/ecrash/noniyetek/person/in';
  EXPORT InPathForPtyDamage					  := '/super_credit/ecrash/noniyetek/propertyDamage/in';


	EXPORT ProcessPathForIncident					  := '/super_credit/ecrash/noniyetek/incident/process';
	EXPORT ProcessPathForCommercial					  := '/super_credit/ecrash/noniyetek/commercial/process';
	EXPORT ProcessPathForVehicle					  := '/super_credit/ecrash/noniyetek/vehicle/process';
	EXPORT ProcessPathForCitation					  := '/super_credit/ecrash/noniyetek/citation/process';
	EXPORT ProcessPathForPerson					  := '/super_credit/ecrash/noniyetek/person/process';
		EXPORT ProcessPathForPtyDamage					  := '/super_credit/ecrash/noniyetek/propertyDamage/process';


 EXPORT BackupPathForIncident					  := '/super_credit/ecrash/noniyetek/incident/backup';
	EXPORT BackupPathForCommercial					  := '/super_credit/ecrash/noniyetek/commercial/backup';
	EXPORT BackupPathForVehicle					  := '/super_credit/ecrash/noniyetek/vehicle/backup';
	EXPORT BackupPathForCitation					  := '/super_credit/ecrash/noniyetek/citation/backup';
	EXPORT BackupPathForPerson					  := '/super_credit/ecrash/noniyetek/person/backup';
		EXPORT BackupPathForPtyDamage					  := '/super_credit/ecrash/noniyetek/propertyDamage/backup';


	EXPORT DestinationCluster 		        := IF (_control.ThisEnvironment.Name = 'Prod_Thor', 'thor400_30', 'thor200_144');	
	EXPORT SprayCompleteFile							:= '~thor::CD::Spray::Complete';
	EXPORT IncidentFileMask												:= 'dbpec-ala.rs.lexisnexis.net.incident*';
	EXPORT PersonFileMask												  := 'dbpec-ala.rs.lexisnexis.net.person*';
	EXPORT CommercialFileMask											:= 'dbpec-ala.rs.lexisnexis.net.commercial*';
	EXPORT CitationFileMask												:= 'dbpec-ala.rs.lexisnexis.net.citation*';
	EXPORT VehicleFileMask												:= 'dbpec-ala.rs.lexisnexis.net.vehicle*';
	EXPORT PtyDamageFileMask												:= 'dbpec-ala.rs.lexisnexis.net.propertyDamage*';

  
	EXPORT INCIDENT_SPRAYED_DAILY      := '~thor_data400::in::ecrash::incidnt_full';
	EXPORT PERSON_SPRAYED_DAILY      := '~thor_data400::in::ecrash::persn_full';
	EXPORT VEHICLE_SPRAYED_DAILY      := '~thor_data400::in::ecrash::vehicl_full';
	EXPORT CITATION_SPRAYED_DAILY      := '~thor_data400::in::ecrash::citatn_full';
	EXPORT COMMERCIAL_SPRAYED_DAILY      := '~thor_data400::in::ecrash::commercl_full';
	EXPORT PTYDAMAGE_SPRAYED_DAILY      := '~thor_data400::in::ecrash::propertydamage_full';
	
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






