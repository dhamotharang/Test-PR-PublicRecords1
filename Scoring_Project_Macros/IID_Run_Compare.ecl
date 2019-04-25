import ut, scoring_project_Macros;
a:= ut.GetDate;
fn_LastTwoMonths(string10 date_inp,integer offset) := function
				res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
				return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);
b1:= b +'_1';
a1:= a +'_1';

basefilename := '~scoringqa::out::nonfcra::instantid_xml_generic_'+b1;      //V3 or V4
testfilename := '~scoringqa::out::nonfcra::instantid_xml_generic_'+a1; 

ds_baseline := DATASET(basefilename, scoring_project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout, thor);
ds_testline := DATASET(testfilename, scoring_project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout, thor);

base_date := basefilename[49..56];
test_date := testfilename[49..56];

Scoring_Project_Macros.IID_trans_function(ds_baseline, ds_testline, base_date, test_date);

// EXPORT IID_Run_Compare := 'todo';