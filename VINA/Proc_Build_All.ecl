import _Control,RoxieKeybuild,Scrubs_Vina;

export Proc_Build_All(string filedate,string inFilename = 'no file', string EmailList='') := function

processedSuperFile	:= '~thor_data400::in::vintelligence::processed::vin';

//Spray input file
sprayInput := VINA.Spray_VINtelligence(filedate);
//Check for layout change
hasLayoutChange := VINA.fnDetectLayoutChange(filedate);
//Build base
buildbase := VINA.Proc_build_base(filedate);
//Run Scrubs
scrubbase := Scrubs_Vina.Proc_Scrubs_Report(filedate,EmailList);
// Build Roxie Keys
buildkeys := VINA.proc_build_keys(filedate);
//Setup input file for Strata
strata_infile := PROJECT(VINA.file_vina_base,TRANSFORM({VINA.layout_vina_infile},SELF.crlf:='\n';SELF:=LEFT;));

// dops update

dops_update := RoxieKeybuild.updateversion('Vina_VinKeys',filedate,VINA.Email_Notification_Lists().buildsuccess,,'N',,,'B');																	
idops_update:= RoxieKeybuild.updateversion('Vina_VinKeys',filedate,VINA.Email_Notification_Lists().buildsuccess,,'N|F',,,'A');																	


// sample records for QA
f := VINA.file_vina_base;
new_records_sample_for_qa	:= output(choosen(f, 100),named('Sample_Records')) : success(fileservices.sendemail(VINA.Email_Notification_Lists().buildsuccess, 'VINA Stats ' + filedate,	'workunit: ' + workunit));

// Actions

retval := sequential(
						//Create superfiles
						if(NOT fileservices.superfileexists(processedSuperFile),fileservices.createsuperfile(processedSuperFile)),
						sprayInput,
						IF(not hasLayoutChange,
							 SEQUENTIAL(buildbase,
													scrubbase,
													buildkeys,
													dops_update,
													idops_update,													//DF-16616
													new_records_sample_for_qa,
													//move the new file to processed
													FileServices.clearsuperfile(processedSuperFile),
													FileServices.addsuperfile(processedSuperFile,'~thor_data400::in::vintelligence::vin',,true),
													FileServices.clearsuperfile('~thor_data400::in::vintelligence::vin'),
												  VINA.Build_Strata(filedate,false,strata_infile,false)
												)
							)					
						);

return retval;

end;