/*2017-03-22T17:19:15Z (Srilatha Katukuri)
ECH-4531 Analytics Keys Injury and Accident count correction
*/
/*2017-01-31T00:22:35Z (Srilatha Katukuri)
ECH-4531 - Ananlytics keys injuty and Accident Count correction

*/
import ut, STD; 

//Infile := FLAccidents_Ecrash.File_KeybuildV2.out(report_code in ['EA','TM','TF'] AND report_type_id = 'A' AND work_type_id NOT IN['2','3']) ;
Infile := FLAccidents_Ecrash.File_KeybuildV2.out((report_code in ['EA','TF'] or (report_code = 'TM' and STD.Str.ToUpperCase(report_status) in ['COMPLETED'] )) AND report_type_id = 'A' AND work_type_id NOT IN['2','3']) ;


Layout_eCrash.Consolidation transInFile(Layout_eCrash.Consolidation L) := transform
	self.did := (STRING12) If(L.did = '000000000000', '0', L.did);
	self := L;
end;

ModInfile:= project(InFile,transInFile(left));

tlayout := record Layout_eCrash.Consolidation, string orig_case_identifier , string orig_state_report_number, end; 

// dedup across sources 
tInfile := project (ModInfile, transform( tlayout, 
                self:= left ,
								self.orig_case_identifier := if(left.report_code = 'EA', left.orig_accnbr , left.addl_report_number);
								self.orig_state_report_number := if(left.report_code = 'EA', left.addl_report_number, left.orig_accnbr); 
								
								)); 
	infiledup := dedup (sort(distribute(tInfile	, hash(orig_case_identifier, orig_state_report_number)), orig_case_identifier, orig_state_report_number,	jurisdiction, jurisdiction_state, report_type_id , accident_date,creation_date, vehicle_incident_id,local),orig_case_identifier, orig_state_report_number,	jurisdiction, jurisdiction_state, report_type_id , accident_date,right,local); 
	
// Join back to all records 

 Jformat := join (distribute(ModInfile ,hash(vehicle_incident_id)), distribute(infiledup ,hash(vehicle_incident_id)), left.vehicle_incident_id = right.vehicle_incident_id , local); 
  
EXPORT File_Keybuild_analytics := Jformat ;