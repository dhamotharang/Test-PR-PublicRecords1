IMPORT _control;
EXPORT IYETEK_CONSTANTS := MODULE

EXPORT LandingZone		 								:= _Control.IPAddress.edata12;
	EXPORT DestinationCluster 		        := IF (_control.ThisEnvironment.Name = 'Prod_Thor', 'thor400_92', 'thor200_144');	
	EXPORT SprayCompleteFile							:= '~thor::CD::Spray::Complete';
	EXPORT FileSeparator									:= '/';
		
	EXPORT InPathForIncident					  := '/super_credit/ecrash/iyetek/incident/in';
	EXPORT InPathForCommercial					  := '/super_credit/ecrash/iyetek/commercial/in';
	EXPORT InPathForVehicle					  := '/super_credit/ecrash/iyetek/vehicle/in';
	EXPORT InPathForCitation					  := '/super_credit/ecrash/iyetek/citation/in';
	EXPORT InPathForPerson					  := '/super_credit/ecrash/iyetek/person/in';


	EXPORT ProcessPathForIncident					  := '/super_credit/ecrash/iyetek/incident/process';
	EXPORT ProcessPathForCommercial					  := '/super_credit/ecrash/iyetek/commercial/process';
	EXPORT ProcessPathForVehicle					  := '/super_credit/ecrash/iyetek/vehicle/process';
	EXPORT ProcessPathForCitation					  := '/super_credit/ecrash/iyetek/citation/process';
	EXPORT ProcessPathForPerson					  := '/super_credit/ecrash/iyetek/person/process';

 EXPORT BackupPathForIncident					  := '/super_credit/ecrash/iyetek/incident/backup';
	EXPORT BackupPathForCommercial					  := '/super_credit/ecrash/iyetek/commercial/backup';
	EXPORT BackupPathForVehicle					  := '/super_credit/ecrash/iyetek/vehicle/backup';
	EXPORT BackupPathForCitation					  := '/super_credit/ecrash/iyetek/citation/backup';
	EXPORT BackupPathForPerson					  := '/super_credit/ecrash/iyetek/person/backup';

EXPORT INCIDENT_SPRAYED_DAILY      := '~thor_data400::in::iyetek::incident_raw';
	EXPORT PERSON_SPRAYED_DAILY      := '~thor_data400::in::iyetek::person_new';
	EXPORT VEHICLE_SPRAYED_DAILY      := '~thor_data400::in::iyetek::vehicle_new';
	EXPORT CITATION_SPRAYED_DAILY      := '~thor_data400::in::iyetek::citation_new';
	
	EXPORT IncidentFileMask												:= 'dbpec-ala.rs.lexisnexis.net.iyetek_metadata.*';	
	EXPORT PersonFileMask												  := 'dbpec-ala.rs.lexisnexis.net.iyetek_metadata_person*';
	EXPORT CitationFileMask												:= 'dbpec-ala.rs.lexisnexis.net.iyetek_metadata_citation*';
	EXPORT VehicleFileMask												:= 'dbpec-ala.rs.lexisnexis.net.iyetek_metadata_vehicle*';

END;