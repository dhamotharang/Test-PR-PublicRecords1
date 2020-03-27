// STEP 2.1 IN PB 1.1 THOR ONE MAIN AUTOMATION PROCESS
// THIS IS CURRENTLY TAKING IN THE FIRST 60 MILLION RECORD FILE AND RUNNING IT AGAINST PB 1.0 ON THOR
// THIS IS CURRENTLY HARDCODING THE DRM AND DPM - WOULD NEED TO BE DYNAMIC IF MORE THAN 1 CUSTOMER USES THIS ***********************************

// *****************************************************************************************************************
// RUN THIS SCRIPT ON 400 WAY THOR TO OPTIMIZE PERFORMANCE
// 1.  COPY ALL PUBLIC RECORD KEYS THAT PROFILE BOOSTER USES TO THE THOR400_STA CLUSTER
// 2.  MAKE SURE UT.FOREIGN_PROD IS SANDBOXED TO '~' SO YOU'RE READING ALL DATA LOCALLY
// 3.  IF YOU'RE RUNNING A FILE LESS THAN 1 MILLION RECORDS, JUST RUN THE BATCH SERVICE INSTEAD OF THIS THOR JOB
// 4.  onThor is set in _Control.Environment.onThor -- toggle this value as necessary.
// *****************************************************************************************************************

#workunit('priority','high'); 

import _Control, Address, Risk_Indicators;
onThor := _Control.Environment.onThor;

EXPORT bwr_ProfileBooster11_OneMain_Step2_1(string NotifyList ) := FUNCTION

#workunit('name', 'profile booster v11 ' + 	if(onThor, 'thor ', 'roxie ') );
#stored('did_add_force', if(onThor, 'thor', 'roxi') );  // this option is the stored parameter used inside the DID append macro to determine which version of the macro to use
#OPTION('multiplePersistInstances', FALSE); // doesn't rename the persist files for each job
#OPTION('splitterSpill', 1);

eyeball_count := 25;
StepName := 'Step2_1';
EmailList := If(NotifyList = '', ProfileBooster.Constants.ECL_Developers_Slim, ProfileBooster.Constants.ECL_Developers_Slim + ',' + NotifyList);


ds_in := dataset('~thor400::profileboosterV11::springleaf_full_file_pb_in_layout_60mil_part1.csv', ProfileBooster.Layouts.LayoutPBInputThor, csv(quote('"')));							
output(choosen(ds_in, eyeball_count), named('sample_input_records_step2_1'));

search_function_with_acctno := ProfileBooster.OneMain_PB11_Step2_Function(ds_in, eyeball_count, StepName): independent, FAILURE(FileServices.SendEmail(EmailList,'OneMain Step2_1 attribute calculation failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
							
output(choosen(search_function_with_acctno, eyeball_count), named('search_function_with_acctno_Step2_1'));
output(search_function_with_acctno,, '~thor400::out::profile_boosterV11_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part1', csv(quote('"')), EXPIRE(30), OVERWRITE);



// email results of this bwr
FileServices.SendEmail(EmailList, 'OneMain PB11 Step2_1 finished ' + WORKUNIT, 'Input count  ' + count(ds_in) + '    Output count ' + count(search_function_with_acctno)):
FAILURE(FileServices.SendEmail(EmailList,'OneMain PB11 Step2_1 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));

RETURN '';

END;