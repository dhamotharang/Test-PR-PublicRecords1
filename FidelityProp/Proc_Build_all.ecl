export Proc_Build_all(string curr_date) := function
// Specify a date in YYYYMMDD format, to use in filenames throughout the process.  Since
// we'll be running for more than one day this is somewhat arbitrary, but typically we'll
// just set curr_date to when we get the ball rolling on the first step, and prev_date to
// the date that was specified for the last successful iteration.
prev_date := dataset('~thor_data400::cemtemp::rain::process_dt',{string prevdate},thor,opt)[1].prevdate;

// This filename prefix will be used in the output of each major step
string fname(string suffix, string prefix='', string in_date=curr_date) := function
	return if(prefix='','~',prefix) + 'thor_data400::cemtemp::RAIN::' + in_date + '::' + suffix;
end;

// Filenames for each step.
f_step1 := fname('step1');
f_step2 := fname('step2');
f_step3 := fname('step3');
f_prev1 := fname('step1',,prev_date);
f_prev2 := fname('step2',,prev_date);
f_prev3 := fname('step3',,prev_date);
f_step5 := '~thor_data400::out::FidelityPropSlice400staging::'; // numeric suffix added later

// Datasets referring back to previous steps
#option('skipFileFormatCrcCheck', true);
ds_step1 := dataset(f_step1, FidelityProp.layouts.from_prop_fid_dob, thor);
ds_step2 := dataset(f_step2, FidelityProp.layouts.out_dob, thor); // These three could be out_dob
ds_step3 := dataset(f_step3, FidelityProp.layouts.out_dob, thor);
ds_prev1 := dataset(f_prev1, FidelityProp.layouts.from_prop_fid_dob, thor);
ds_prev2 := dataset(f_prev2, FidelityProp.layouts.out_dob, thor);
ds_prev3 := dataset(f_prev3, FidelityProp.layouts.out_dob, thor);


// ----------------------------------------------------------------------------
// The following steps should run sequentially on a prod thor.  If the process
// fails part way through, one can comment-out the steps that succeeded and
// rerun the remainder.
// ----------------------------------------------------------------------------


// STEP 1:
// A) run FidelityProp.proc.DoProp -- 5.5hrs (dataland 400x)
// B) Lookup DOB in various sources -- 0.5hrs (dataland 400x)
// #workunit('name','RAIN Step 1');
step1a := FidelityProp.mod_build.DoProp();
step1b := FidelityProp.mod_build.DoPropDOB(step1a);
output(count(step1a), named('count1a'));
output(count(step1b), named('count1b'));
s1 := output(step1b,, f_step1, overwrite, __compressed__);


// STEP 2: Warn vesa and run FidelityProp.proc..DoPropWPhones(PropFileJustBuilt) -- 10-24hrs (cmorton2 @ prod 200x)
// #workunit('name','RAIN Step 2');
step2 := FidelityProp.mod_build.DoPropWPhones(ds_step1);
s2 := output(step2,, f_step2, overwrite, __compressed__);


// STEP 3: Patch old unparsed seller names into place as needed -- 0.5hr (dataland 400x)
// #workunit('name','RAIN Step 3');
step3 := FidelityProp.mod_build.DoPatch(ds_step2,ds_prev3);
s3 := output(step3,, f_step3, overwrite, __compressed__);


// STEP 4: Counts
// Send these to the customer in the email announcing the data availability.
// #workunit('name','RAIN Step 4');
step4 := FidelityProp.mod_build.DoCounts(ds_step1, ds_step2, ds_prev1, ds_prev2);
s4 := sequential(step4);


// STEP 5: Run FidelityProp.proc_chuncks -- 0.5hrs (dataland 400x)
//         Split the file into 30 pieces (they want files no bigger than a Gig)
// #workunit('name','RAIN Step 5');
step5 := FidelityProp.proc_chuncks(ds_step3, f_step5);
s5 := sequential(step5);


// STEP 6: Run FidelityProp.proc_despray -- 0.5hrs (dataland 400x)
// #workunit('name','RAIN Step 6');
step6 := FidelityProp.proc_despray(curr_date, f_step5);
s6 := sequential(step6);


// STEP 7: QA
// NOTE: Provides statistics comparing last month's run with this month's run.  We
//			 use it to confirm we didn't screw up anything obvious, but it's generally
//			 not a report that goes to the customer.  In a time crunch it may make sense
//			 to skip this step sometimes.
// #workunit('name','RAIN Step 7');
step7 := FidelityProp.proc_QA(ds_step3, ds_prev3);
s7 := sequential(step7);

// Step8: Set new process date in holder file current date
s8 := output(dataset([{curr_date}],{string prevdate}),,'~thor_data400::cemtemp::rain::process_dt',overwrite);

// Step9: Super File Transactions (moving files into super files to avoid accidental delete between builds).
s9 := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::cemtemp::rain::superfile::Delete',
				                          '~thor_data400::cemtemp::rain::superfile::Old',, true),
				FileServices.ClearSuperFile('~thor_data400::cemtemp::rain::superfile::Old'),
				FileServices.AddSuperFile('~thor_data400::cemtemp::rain::superfile::Old', 
				                          '~thor_data400::cemtemp::rain::superfile::Grandfather',, true),
				FileServices.ClearSuperFile('~thor_data400::cemtemp::rain::superfile::Grandfather'),													
				FileServices.AddSuperFile('~thor_data400::cemtemp::rain::superfile::Grandfather', 
				                          '~thor_data400::cemtemp::rain::superfile::Father',, true),
				FileServices.ClearSuperFile('~thor_data400::cemtemp::rain::superfile::Father'),														
				FileServices.AddSuperFile('~thor_data400::cemtemp::rain::superfile::Father', 
				                          '~thor_data400::cemtemp::rain::superfile',, true),
				FileServices.ClearSuperFile('~thor_data400::cemtemp::rain::superfile'),
				FileServices.AddSuperFile('~thor_data400::cemtemp::rain::superfile', 
				                          '~thor_data400::cemtemp::RAIN::'+curr_date+'::step1'),
				FileServices.AddSuperFile('~thor_data400::cemtemp::rain::superfile', 
				                          '~thor_data400::cemtemp::RAIN::'+curr_date+'::step2'), 
				FileServices.AddSuperFile('~thor_data400::cemtemp::rain::superfile', 
				                          '~thor_data400::cemtemp::RAIN::'+curr_date+'::step3'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_data400::cemtemp::rain::superfile::Delete'));

// Run the steps in order
doBuild := sequential(s1,s2,s3,s4,s5,s6,s7,s8,s9);

return doBuild;
end;