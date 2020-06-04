import ut; 

EXPORT Proc_TMafterTF_extract(string filedate , string timestamp) := function 

// get all new TM 

Supplemental      := dataset('~thor_data400::base::ecrash_tmaftertf',FLAccidents_Ecrash.Layouts.slim_layout,thor); 
Supplemental_f    := dataset('~thor_data400::base::ecrash_tmaftertf_father',FLAccidents_Ecrash.Layouts.slim_layout,thor); 

j:= join (Supplemental,Supplemental_f  ,  
                                          left.incident_id = right.incident_id                ,
																					transform(FLAccidents_Ecrash.Layouts.slim_layout, 
																					self:= left) , left only  
																					); 

TMrolled := FLAccidents_Ecrash.Fn_roll_Incident ( j); 

TFlatest := join(distribute(FLAccidents_Ecrash.BuildSuppmentalReports.IyetekFull,hash(incident_id)) , dedup(distribute(FLAccidents_Ecrash.BaseFile(report_code ='TF'),hash(incident_id)), incident_id,all,local) , 
                 left.incident_id = right.incident_id ,transform(FLAccidents_Ecrash.Layouts.slim_layout, self:= left), local) ; 

TFrolled := FLAccidents_Ecrash.Fn_roll_Incident ( TFlatest); 	


getupdatedTM := Join(distribute(TMrolled,hash(case_identifier)) , distribute(TFrolled ,hash(case_identifier)),
                      trim(left.case_identifier,left,right) = trim(right.case_identifier ,left,right)and
											trim(left.agency_id ,left,right)= trim(right.agency_id,left,right) and 
											trim(left.loss_state_abbr,left,right) = trim(right.loss_state_abbr ,left,right)and
											trim(left.report_type_id ,left,right)= trim(right.report_type_id,left,right) and
											trim(left.crash_date ,left,right)= trim(right.crash_date,left,right) and
											(left.loss_street            <>  right.loss_street       or
                                      left.loss_cross_street        <>  right.loss_cross_street or
                                      left.last_name                <>  right.last_name         or       
                                      left.first_name               <>  right.first_name        or          
                                      left.middle_name              <>  right.middle_name       or         
                                      left.address                  <>  right.address           or      
                                      left.city                     <>  right.city              or      
                                      left.state                    <>  right.state             or        
                                      left.zip_code                 <>  right.zip_code          or          
                                      left.Drivers_License_Number   <> right.Drivers_License_Number or
                                      left.License_Plate            <> right.License_Plate          or
                                      left.vin                      <> right.vin                    or      
                                      left.Make                     <> right.Make                   or       
                                      left.Model_Yr                 <> right.Model_Yr               or         
                                      left.Model                    <> right.Model     ) , transform( FLAccidents_Ecrash.Layouts.TFafterTF, self := left), local); 
	
	refrTM :=   project ( dedup(getupdatedTM,record,all) , transform(FLAccidents_Ecrash.Layouts.TMout, 
	self.state_report_number  := left.orig_state_report_number ; 
	self.case_identifier  :=  left.orig_case_identifier ;
	self.agency_ori   := left.ORI_Number;
	self.source_id := 'TM'; 
	self.crash_date := left.accident_date; 
	self := left ; 

 )); 


  createfile := sequential(output(refrTM,,'~thor_data400::out::ecrash::'+filedate+'::tmaftertf'
																	,csv(terminator('\n')
																	,separator(','),quote('"'))
																	,overwrite)
													,output('TM after TF THOR file generated in this build'));

despray := if(count(j) > 0 ,createfile,output('TM after TF THOR file not generated in this build'));  

return despray ; 

end; 