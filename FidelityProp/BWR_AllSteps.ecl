#workunit('name','RAIN Build');

// Specify a date in YYYYMMDD format, to use in filenames throughout the process.  Since
// we'll be running for more than one day this is somewhat arbitrary, but typically we'll
// just set curr_date to when we get the ball rolling on the first step, and prev_date to
// the date that was specified for the last successful iteration.
curr_date := '20100803';
prev_date := '20100516';

// This filename prefix will be used in the output of each major step
string fname(string suffix, string prefix='', string in_date=curr_date) := function
	return if(prefix='','~',prefix) + 'thor_data400::cemtemp::RAIN::' + in_date + '::' + suffix;
end;

// Filenames for each step.
f_step1 := fname('step1');
f_step2 := fname('step2');
f_step3 := fname('step3');
f_prev3 := fname('step3',,prev_date);
f_step5 := '~thor_data400::out::FidelityPropSlice400staging::'; // numeric suffix added later

// Datasets referring back to previous steps
#option('skipFileFormatCrcCheck', true);
ds_step1 := dataset(f_step1, FidelityProp.layouts.from_prop_fid_dob, thor);
ds_step2 := dataset(f_step2, FidelityProp.layouts.out, thor); // These three could be out_dob
ds_step3 := dataset(f_step3, FidelityProp.layouts.out, thor);
ds_prev3 := dataset(f_prev3, FidelityProp.layouts.out, thor);


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
s1 := output(step1b,, f_step1, overwrite);


// STEP 2: Warn vesa and run FidelityProp.proc..DoPropWPhones(PropFileJustBuilt) -- 10-24hrs (cmorton2 @ prod 200x)
// #workunit('name','RAIN Step 2');
step2 := FidelityProp.mod_build.DoPropWPhones(ds_step1);
s2 := output(step2,, f_step2, overwrite);


// STEP 3: Patch old unparsed seller names into place as needed -- 0.5hr (dataland 400x)
// #workunit('name','RAIN Step 3');
step3 := FidelityProp.mod_build.DoPatch(ds_step2,ds_prev3);
s3 := output(step3,, f_step3, overwrite);


// STEP 4: Counts
// Send these to the customer in the email announcing the data availability.
// #workunit('name','RAIN Step 4');
step4 := FidelityProp.mod_build.DoCounts(ds_step1, ds_step2);
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


// Run the steps in order
sequential(s1,s2,s3,s4,s5,s6,s7);