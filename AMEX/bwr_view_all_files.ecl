//***********************************************************************************
//**************  I N P U T     P R O C E S S    1  *********************************
infile_name   := '~gwhitaker::in::AMEX_job1_process1';
// infile_name   := '~gwhitaker::in::AMEX_job2_process1';
// infile_name   := '~gwhitaker::in::AMEX_job3_process1';
ds_in1 := dataset (infile_name, amex.layouts.inputProc1, csv(quote('"')));
output(ds_in1,named('input1'));
//***********************************************************************************
//************  O U T P U T     P R O C E S S    1  *********************************
outfile_name1   := '~gwhitaker::out::AMEX_job1_process1_output';
// outfile_name1   := '~gwhitaker::out::AMEX_job2_process1_output';
// outfile_name1   := '~gwhitaker::out::AMEX_job3_process1_output';
ds_out1 := dataset (outfile_name1, AMEX.layouts.outputProc1, thor);
output(ds_out1,named('output1_1'));

infile_name2   := '~gwhitaker::in::AMEX_job1_process2';
// infile_name2   := '~gwhitaker::in::AMEX_job2_process2';
// infile_name2   := '~gwhitaker::in::AMEX_job3_process2';
ds_in2 := dataset (infile_name2, AMEX.layouts.inputProc2, thor);
output(ds_in2,named('output1_2'));
//***********************************************************************************
//************  O U T P U T     P R O C E S S    2  *********************************
outfile_name2_1   := '~gwhitaker::out::AMEX_job1_process2_output';
// outfile_name2_1   := '~gwhitaker::out::AMEX_job2_process2_output';
// outfile_name2_1   := '~gwhitaker::out::AMEX_job3_process2_output';
ds_out2_1 := dataset (outfile_name2_1, AMEX.layouts.outputProc2  , thor);
output(ds_out2_1,named('output2_1'));

outfile_name2_2 := '~gwhitaker::out::AMEX_job1_process2_relDIDs';
// outfile_name2_2 := '~gwhitaker::out::AMEX_job2_process2_relDIDs';
// outfile_name2_2 := '~gwhitaker::out::AMEX_job3_process2_relDIDs';
ds_out2_2 := dataset(outfile_name2_2,AMEX.layouts.inputProc1,csv(quote('"')));
OUTPUT(ds_out2_2,named('output2_2'));
//***********************************************************************************
//************  O U T P U T     P R O C E S S    3  *********************************
outfile_name3_1 := '~gwhitaker::out::AMEX_job1_process3_finaloutput';
// outfile_name3_1 := '~gwhitaker::out::AMEX_job2_process3_finaloutput';
// outfile_name3_1 := '~gwhitaker::out::AMEX_job3_process3_finaloutput';
ds_out3_1 := dataset(outfile_name3_1, amex.layouts.outputFinal,csv(quote('"')));
output(ds_out3_1,named('output3_1'));

outfile_name3_2 := '~gwhitaker::out::AMEX_job1_process3_finaloutputDIDs';
// outfile_name3_2 := '~gwhitaker::out::AMEX_job2_process3_finaloutputDIDs';
// outfile_name3_2 := '~gwhitaker::out::AMEX_job3_process3_finaloutputDIDs';

ds_out3_2 := dataset(outfile_name3_2, AMEX.layouts.outputFinalDIDs,csv(quote('"')));
output(ds_out3_2,named('output3_2'));
//***********************************************************************************
//************  O U T P U T     P R O C E S S    4  *********************************
outfile_name4 := '~gwhitaker::in::AMEX_job1_process5_relDIDs';
// outfile_name4 := '~gwhitaker::in::AMEX_job2_process5_relDIDs';
ds_out4 := dataset(outfile_name4,amex.layouts.inputProc1, CSV(QUOTE('"')));
output(ds_out4,named('output4'));
//***********************************************************************************
//************  O U T P U T     P R O C E S S    5  *********************************
outfile_name5 := '~gwhitaker::in::AMEX_job1_process1_relDIDs';
// outfile_name5 := '~gwhitaker::in::AMEX_job2_process1_relDIDs';
ds_out5 := dataset(outfile_name5, amex.layouts.inputProc1, CSV(QUOTE('"'))); 
output(ds_out5,named('output5'));
