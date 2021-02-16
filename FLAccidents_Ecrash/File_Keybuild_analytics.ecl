/*2017-03-22T17:19:15Z (Srilatha Katukuri)
ECH-4531 Analytics Keys Injury and Accident count correction
*/
IMPORT STD; 

Infile := Files_eCrash.Ds_Base_Consolidation_Ecrash((report_code IN ['EA','TF'] OR (report_code = 'TM' AND STD.Str.ToUpperCase(report_status) IN ['COMPLETED'] )) AND report_type_id = 'A' AND work_type_id NOT IN['2','3']) ;


Layout_eCrash.Consolidation transInFile(Layout_eCrash.Consolidation L) := TRANSFORM
	SELF.did := (STRING12) IF(L.did = '000000000000', '0', L.did);
	SELF := L;
END;

ModInfile:= PROJECT(InFile,transInFile(LEFT));

tlayout := RECORD Layout_eCrash.Consolidation, 
            STRING orig_case_identifier, 
						STRING orig_state_report_number, 
					 END; 

// dedup across sources 
tInfile := PROJECT (ModInfile, TRANSFORM( tlayout, 
                SELF:= LEFT,
								SELF.orig_case_identifier := IF(LEFT.report_code = 'EA', LEFT.orig_accnbr , LEFT.addl_report_number);
								SELF.orig_state_report_number := IF(LEFT.report_code = 'EA', LEFT.addl_report_number, LEFT.orig_accnbr); 
								
								)); 
	infiledup := DEDUP (SORT(DISTRIBUTE(tInfile, HASH32(orig_case_identifier, orig_state_report_number)), orig_case_identifier, orig_state_report_number,	jurisdiction, jurisdiction_state, report_type_id , accident_date,creation_date, vehicle_incident_id,LOCAL),orig_case_identifier, orig_state_report_number,	jurisdiction, jurisdiction_state, report_type_id , accident_date,RIGHT,LOCAL); 
	
// Join back to all records 

 Jformat := JOIN (DISTRIBUTE(ModInfile, HASH32(vehicle_incident_id)), DISTRIBUTE(infiledup, HASH32(vehicle_incident_id)), LEFT.vehicle_incident_id = RIGHT.vehicle_incident_id, LOCAL); 
  
EXPORT File_Keybuild_analytics := Jformat ;