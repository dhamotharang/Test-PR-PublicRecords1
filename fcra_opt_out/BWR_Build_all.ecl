//READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Update Frequency: Quarterly Full Append;
// Step 1:  FTP data from:  we dont know much about this part yet
// Step 2: Execute BWR_AreaCodeChange_Build_All and get a filedate

import _Control;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Actions: Spray Input Files, SuperFile Moves, Build keys, Pull QA Samples
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
filedate := 'Enter Receiving File Date Here';
sourceIP := _Control.IPAddress.edata12;
//GroupName := _Control.TargetGroup.Thor_Dataland_Linux;
GroupName := 'thor400_20';
// vsDate   := ut.GetDate;

sequential(
FileServices.SprayFixed(sourceIP,'/data_build_1/opt_out/FULL_DNS_'+filedate+'.DAT',123,GroupName,'::in::opt_out::'+filedate+'::data.txt'),
// TO DO spray the file when we decide how we will get it
// Risk_Indicators.spray_AreaCode_Change(filedate) sample spray to copy from later
fcra_opt_out.clean_opt_out_data(filedate),
fcra_opt_out.proc_build_keys(filedate)

);
