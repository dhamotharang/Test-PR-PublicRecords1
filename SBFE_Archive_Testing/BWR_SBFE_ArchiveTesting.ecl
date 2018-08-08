IMPORT data_services, SBFE_Archive_Testing, std;

wuid := WORKUNIT : INDEPENDENT;            
today := Std.Date.Today():INDEPENDENT;
twoYearsAgo := (STRING8)(today - SBFE_Archive_Testing.Constants.TWO_YEARS_ADJ) : INDEPENDENT;
            
// Input files:
file1ToProcess  := data_services.default_data_location+'jpyon::in::amex_8055_gcpfile_out1_archive_12months.csv';
file2ToProcess  := data_services.default_data_location+'jpyon::in::amex_8055_gcpfile_out1_archive.csv';
file3ToProcess  := data_services.default_data_location+'jpyon::in::amex_8055_gcpfile_out2_archive_12months.csv';
file4ToProcess  := data_services.default_data_location+'jpyon::in::amex_8055_gcpfile_out2_archive.csv';
file5ToProcess  := data_services.default_data_location+'jpyon::in::amex_8055_gcpfile_out3_archive_12months.csv';  // 27k
file6ToProcess  := data_services.default_data_location+'jpyon::in::amex_8055_gcpfile_out3_archive.csv';
file7ToProcess  := data_services.default_data_location+'jpyon::in::amex_8055_open1file_out1_archive_12months.csv';
file8ToProcess  := data_services.default_data_location+'jpyon::in::amex_8055_open1file_out1_archive.csv';
file9ToProcess  := data_services.default_data_location+'jpyon::in::amex_8055_open1file_out2_archive_12months.csv';  // 249k
file10ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open1file_out2_archive.csv';
file11ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open1file_out3_archive_12months.csv';
file12ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open1file_out3_archive.csv';
file13ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open2file_out1_archive_12months.csv';
file14ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open2file_out1_archive.csv';
file15ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open2file_out2_archive_12months.csv';
file16ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open2file_out2_archive.csv';
file17ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open2file_out3_archive_12months.csv';
file18ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open2file_out3_archive.csv';
file19ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open3file_out1_archive_12months.csv';
file20ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open3file_out1_archive.csv';
file21ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open3file_out2_archive_12months.csv';
file22ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open3file_out2_archive.csv';
file23ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open3file_out3_archive_12months.csv';
file24ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open3file_out3_archive.csv';
file25ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open3file_out4_archive_12months.csv';
file26ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open3file_out4_archive.csv';
file27ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open3file_out5_archive_12months.csv';
file28ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open3file_out5_archive.csv';
file29ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open4file_out1_archive_12months.csv';
file30ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open4file_out1_archive.csv';
file31ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open4file_out2_archive_12months.csv';
file32ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open4file_out2_archive.csv';
file33ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open4file_out3_archive_12months.csv';
file34ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open4file_out3_archive.csv';
file35ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open5file_out1_archive_12months.csv';
file36ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open5file_out1_archive.csv';
file37ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open5file_out2_archive_12months.csv';
file38ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open5file_out2_archive.csv';
file39ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open5file_out3_archive_12months.csv';
file40ToProcess := data_services.default_data_location+'jpyon::in::amex_8055_open5file_out3_archive.csv';


// Output files:                           
output1FileName  := '~tgonsiewski::AMEX_1::amex_8055_gcpfile_out1_archive_12months_' + wuid + '.csv';
output2FileName  := '~tgonsiewski::AMEX_2::amex_8055_gcpfile_out1_archive_' + wuid + '.csv';
output3FileName  := '~tgonsiewski::AMEX_3::amex_8055_gcpfile_out2_archive_12months_' + wuid + '.csv';
output4FileName  := '~tgonsiewski::AMEX_4::amex_8055_gcpfile_out2_archive_' + wuid + '.csv';
output5FileName  := '~tgonsiewski::AMEX_5::amex_8055_gcpfile_out3_archive_12months_' + wuid + '.csv';
output6FileName  := '~tgonsiewski::AMEX_6::amex_8055_gcpfile_out3_archive_' + wuid + '.csv';
output7FileName  := '~tgonsiewski::AMEX_7::amex_8055_open1file_out1_archive_12months_' + wuid + '.csv';
output8FileName  := '~tgonsiewski::AMEX_8::amex_8055_open1file_out1_archive_' + wuid + '.csv';
output9FileName  := '~tgonsiewski::AMEX_9::amex_8055_open1file_out2_archive_12months_' + wuid + '.csv';
output10FileName := '~tgonsiewski::AMEX_10::amex_8055_open1file_out2_archive_' + wuid + '.csv';
output11FileName := '~tgonsiewski::AMEX_11_::amex_8055_open1file_out3_archive_12months_' + wuid + '.csv';
output12FileName := '~tgonsiewski::AMEX_12::amex_8055_open1file_out3_archive_' + wuid + '.csv';
output13FileName := '~tgonsiewski::AMEX_13::amex_8055_open2file_out1_archive_12months_' + wuid + '.csv';
output14FileName := '~tgonsiewski::AMEX_14::amex_8055_open2file_out1_archive_' + wuid + '.csv';
output15FileName := '~tgonsiewski::AMEX_15::amex_8055_open2file_out2_archive_12months_' + wuid + '.csv';
output16FileName := '~tgonsiewski::AMEX_16::amex_8055_open2file_out2_archive_' + wuid + '.csv';
output17FileName := '~tgonsiewski::AMEX_17::amex_8055_open2file_out3_archive_12months_' + wuid + '.csv';
output18FileName := '~tgonsiewski::AMEX_18::amex_8055_open2file_out3_archive_' + wuid + '.csv';
output19FileName := '~tgonsiewski::AMEX_19::amex_8055_open3file_out1_archive_12months_' + wuid + '.csv';
output20FileName := '~tgonsiewski::AMEX_20::amex_8055_open3file_out1_archive_' + wuid + '.csv';
output21FileName := '~tgonsiewski::AMEX_21::amex_8055_open3file_out2_archive_12months_' + wuid + '.csv';
output22FileName := '~tgonsiewski::AMEX_22::amex_8055_open3file_out2_archive_' + wuid + '.csv';
output23FileName := '~tgonsiewski::AMEX_23::amex_8055_open3file_out3_archive_12months_' + wuid + '.csv';
output24FileName := '~tgonsiewski::AMEX_24::amex_8055_open3file_out3_archive_' + wuid + '.csv';
output25FileName := '~tgonsiewski::AMEX_25::amex_8055_open3file_out4_archive_12months_' + wuid + '.csv';
output26FileName := '~tgonsiewski::AMEX_26::amex_8055_open3file_out4_archive_' + wuid + '.csv';
output27FileName := '~tgonsiewski::AMEX_27::amex_8055_open3file_out5_archive_12months_' + wuid + '.csv';
output28FileName := '~tgonsiewski::AMEX_28::amex_8055_open3file_out5_archive_' + wuid + '.csv';
output29FileName := '~tgonsiewski::AMEX_29::amex_8055_open4file_out1_archive_12months_' + wuid + '.csv';
output30FileName := '~tgonsiewski::AMEX_30::amex_8055_open4file_out1_archive_' + wuid + '.csv';
output31FileName := '~tgonsiewski::AMEX_31::amex_8055_open4file_out2_archive_12months_' + wuid + '.csv';
output32FileName := '~tgonsiewski::AMEX_32::amex_8055_open4file_out2_archive_' + wuid + '.csv';
output33FileName := '~tgonsiewski::AMEX_33::amex_8055_open4file_out3_archive_12months_' + wuid + '.csv';
output34FileName := '~tgonsiewski::AMEX_34::mex_8055_open4file_out3_archive_' + wuid + '.csv';
output35FileName := '~tgonsiewski::AMEX_35::amex_8055_open5file_out1_archive_12months_' + wuid + '.csv';
output36FileName := '~tgonsiewski::AMEX_36::amex_8055_open5file_out1_archive_' + wuid + '.csv';
output37FileName := '~tgonsiewski::AMEX_37::amex_8055_open5file_out2_archive_12months_' + wuid + '.csv';
output38FileName := '~tgonsiewski::AMEX_38::amex_8055_open5file_out2_archive_' + wuid + '.csv';
output39FileName := '~tgonsiewski::AMEX_39::amex_8055_open5file_out3_archive_12months_' + wuid + '.csv';
output40FileName := '~tgonsiewski::AMEX_40::amex_8055_open5file_out3_archive_' + wuid + '.csv';

// Processing
ds_processedInRecs1 := SBFE_Archive_Testing.ProcessSoapCall(file1ToProcess,1,(STRING8)today,wuid);
SBFE_recs1 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs1,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs2 := SBFE_Archive_Testing.ProcessSoapCall(file2ToProcess,2,(STRING8)today,wuid);
SBFE_recs2 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs2,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs3 := SBFE_Archive_Testing.ProcessSoapCall(file3ToProcess,3,(STRING8)today,wuid);
SBFE_recs3 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs3,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs4 := SBFE_Archive_Testing.ProcessSoapCall(file4ToProcess,4,(STRING8)today,wuid);
SBFE_recs4 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs4,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs5 := SBFE_Archive_Testing.ProcessSoapCall(file5ToProcess,5,(STRING8)today,wuid);
SBFE_recs5 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs5,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs6 := SBFE_Archive_Testing.ProcessSoapCall(file6ToProcess,6,(STRING8)today,wuid);
SBFE_recs6 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs6,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs7 := SBFE_Archive_Testing.ProcessSoapCall(file7ToProcess,7,(STRING8)today,wuid);
SBFE_recs7 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs7,twoYearsAgo);   // : INDEPENDENT; //
                   
ds_processedInRecs8 := SBFE_Archive_Testing.ProcessSoapCall(file8ToProcess,8,(STRING8)today,wuid);
SBFE_recs8 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs8,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs9 := SBFE_Archive_Testing.ProcessSoapCall(file9ToProcess,9,(STRING8)today,wuid);
SBFE_recs9 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs9,twoYearsAgo);   //  : INDEPENDENT; //

ds_processedInRecs10 := SBFE_Archive_Testing.ProcessSoapCall(file10ToProcess,10,(STRING8)today,wuid);
SBFE_recs10 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs10,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs11 := SBFE_Archive_Testing.ProcessSoapCall(file11ToProcess,11,(STRING8)today,wuid);
SBFE_recs11 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs11,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs12 := SBFE_Archive_Testing.ProcessSoapCall(file12ToProcess,12,(STRING8)today,wuid);
SBFE_recs12 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs12,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs13 := SBFE_Archive_Testing.ProcessSoapCall(file13ToProcess,13,(STRING8)today,wuid);
SBFE_recs13 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs13,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs14 := SBFE_Archive_Testing.ProcessSoapCall(file14ToProcess,14,(STRING8)today,wuid);
SBFE_recs14 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs14,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs15 := SBFE_Archive_Testing.ProcessSoapCall(file15ToProcess,15,(STRING8)today,wuid);
SBFE_recs15 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs15,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs16 := SBFE_Archive_Testing.ProcessSoapCall(file16ToProcess,16,(STRING8)today,wuid);
SBFE_recs16 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs16,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs17 := SBFE_Archive_Testing.ProcessSoapCall(file17ToProcess,17,(STRING8)today,wuid);
SBFE_recs17 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs17,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs18 := SBFE_Archive_Testing.ProcessSoapCall(file18ToProcess,18,(STRING8)today,wuid);
SBFE_recs18 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs18,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs19 := SBFE_Archive_Testing.ProcessSoapCall(file19ToProcess,19,(STRING8)today,wuid);
SBFE_recs19 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs19,twoYearsAgo); // : INDEPENDENT
; //
ds_processedInRecs20 := SBFE_Archive_Testing.ProcessSoapCall(file20ToProcess,20,(STRING8)today,wuid);
SBFE_recs20 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs20,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs21 := SBFE_Archive_Testing.ProcessSoapCall(file21ToProcess,21,(STRING8)today,wuid);
SBFE_recs21 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs21,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs22 := SBFE_Archive_Testing.ProcessSoapCall(file22ToProcess,22,(STRING8)today,wuid);
SBFE_recs22 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs22,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs23 := SBFE_Archive_Testing.ProcessSoapCall(file23ToProcess,23,(STRING8)today,wuid);
SBFE_recs23 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs23,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs24 := SBFE_Archive_Testing.ProcessSoapCall(file24ToProcess,24,(STRING8)today,wuid);
SBFE_recs24 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs24,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs25 := SBFE_Archive_Testing.ProcessSoapCall(file25ToProcess,25,(STRING8)today,wuid);
SBFE_recs25 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs25,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs26 := SBFE_Archive_Testing.ProcessSoapCall(file26ToProcess,26,(STRING8)today,wuid);
SBFE_recs26 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs26,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs27 := SBFE_Archive_Testing.ProcessSoapCall(file27ToProcess,27,(STRING8)today,wuid);
SBFE_recs27 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs27,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs28 := SBFE_Archive_Testing.ProcessSoapCall(file28ToProcess,28,(STRING8)today,wuid);
SBFE_recs28 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs28,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs29 := SBFE_Archive_Testing.ProcessSoapCall(file29ToProcess,29,(STRING8)today,wuid);
SBFE_recs29 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs29,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs30 := SBFE_Archive_Testing.ProcessSoapCall(file30ToProcess,30,(STRING8)today,wuid);
SBFE_recs30 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs30,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs31 := SBFE_Archive_Testing.ProcessSoapCall(file31ToProcess,31,(STRING8)today,wuid);
SBFE_recs31 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs31,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs32 := SBFE_Archive_Testing.ProcessSoapCall(file32ToProcess,32,(STRING8)today,wuid);
SBFE_recs32 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs32,twoYearsAgo);   //: INDEPENDENT; // 

ds_processedInRecs33 := SBFE_Archive_Testing.ProcessSoapCall(file33ToProcess,33,(STRING8)today,wuid);
SBFE_recs33 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs33,twoYearsAgo);   //: INDEPENDENT; // 

ds_processedInRecs34 := SBFE_Archive_Testing.ProcessSoapCall(file34ToProcess,34,(STRING8)today,wuid);
SBFE_recs34 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs34,twoYearsAgo);   // : INDEPENDENT; //
;   // 
ds_processedInRecs35 := SBFE_Archive_Testing.ProcessSoapCall(file35ToProcess,35,(STRING8)today,wuid);
SBFE_recs35 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs35,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs36 := SBFE_Archive_Testing.ProcessSoapCall(file36ToProcess,36,(STRING8)today,wuid);
SBFE_recs36 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs36,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs37 := SBFE_Archive_Testing.ProcessSoapCall(file37ToProcess,37,(STRING8)today,wuid);
SBFE_recs37 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs37,twoYearsAgo);   //: INDEPENDENT; // 

ds_processedInRecs38 := SBFE_Archive_Testing.ProcessSoapCall(file38ToProcess,38,(STRING8)today,wuid);
SBFE_recs38 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs38,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs39 := SBFE_Archive_Testing.ProcessSoapCall(file39ToProcess,39,(STRING8)today,wuid);
SBFE_recs39 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs39,twoYearsAgo);   // : INDEPENDENT; //

ds_processedInRecs40 := SBFE_Archive_Testing.ProcessSoapCall(file40ToProcess,40,(STRING8)today,wuid);
SBFE_recs40 := SBFE_Archive_Testing.Get_SBFE_Data(ds_processedInRecs40,twoYearsAgo);   // : INDEPENDENT; //

          
PARALLEL( 
/*            OUTPUT(SBFE_recs1,, output1FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs1,5000),, output1FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(COUNT(SBFE_recs1), NAMED('count_SBFE_recs1'));
            // OUTPUT(CHOOSEN(SBFE_recs1,5000), NAMED('ds_SBFE_recs1')), 
            
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_1')),
           
            OUTPUT(SBFE_recs2,, output2FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs2,5000),, output2FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs2,5000), NAMED('ds_SBFE_recs2')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_2')),
            
            OUTPUT(SBFE_recs3,, output3FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs3,5000),, output3FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs3,5000), NAMED('ds_SBFE_recs3')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_3')),
            
            OUTPUT(SBFE_recs4,, output4FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs4,5000),, output4FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs4,5000), NAMED('ds_SBFE_recs4')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_4')),
 */     
            OUTPUT(SBFE_recs5,, output5FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs5,5000),, output5FileName,CSV(QUOTE('"'))), // Write to disk.
            OUTPUT(CHOOSEN(SBFE_recs5,3000), NAMED('ds_SBFE_recs5')), 
           // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_5')),
  /*           
            OUTPUT(SBFE_recs6,, output6FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs6,5000),, output6FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs6,5000), NAMED('ds_SBFE_recs6')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_6')),
            
            OUTPUT(SBFE_recs7,, output7FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs7,5000),, output7FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs7,5000), NAMED('ds_SBFE_recs7')), 
            // OUTPUUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_7')),
            
            OUTPUT(SBFE_recs8,, output8FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs8,5000),, output8FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs8,5000), NAMED('ds_SBFE_recs8')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_8')),

            OUTPUT(SBFE_recs9,, output9FileName,CSV(QUOTE('"'))),  // Write to disk.
           // OUTPUT(CHOOSEN(SBFE_recs9,5000),, output9FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs9,5000), NAMED('ds_SBFE_recs9')), 
            // OUTPUT(COUNT(SBFE_recs9), NAMED('count_ds_SBFE_recs9')), 
            // OUTPUT(CHOOSEN(ds_processedInRecs9,5000), NAMED('ds_processedInRecs9')), 
            // OUTPUT(COUNT(ds_processedInRecs9), NAMED('count_ds_processedInRecs9')),
            // OUTPUT(CHOOSEN(SBFE_recs9(seleid != 0),5000), NAMED('ds_SBFE_recs9_seleidNot0')), 
            // OUTPUT(COUNT(SBFE_recs9(seleid != 0)), NAMED('count_ds_SBFE_recs9_seleidNot0')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_9')),
            
            OUTPUT(SBFE_recs10,, output10FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs10,5000),, output10FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs10,5000), NAMED('ds_SBFE_recs10')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_10')),
            
            OUTPUT(SBFE_recs11,, output11FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs11,5000),, output11FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs11,5000), NAMED('ds_SBFE_recs11')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_11')),
            
            OUTPUT(SBFE_recs12,, output12FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs12,5000),, output12FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs12,5000), NAMED('ds_SBFE_recs12')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_12')),
            
            OUTPUT(SBFE_recs13,, output13FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs13,5000),, output13FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs13,5000), NAMED('ds_SBFE_recs13')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_13')),
            
            OUTPUT(SBFE_recs14,, output14FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs14,5000),, output14FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs14,5000), NAMED('ds_SBFE_recs14')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_14')),
            
            OUTPUT(SBFE_recs15,, output15FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs15,5000),, output15FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs15,5000), NAMED('ds_SBFE_recs15')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_15')),
            
            OUTPUT(SBFE_recs16,, output16FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs16,5000),, output16FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs16,5000), NAMED('ds_SBFE_recs16')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_16')),
            
            OUTPUT(SBFE_recs17,, output17FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs17,5000),, output17FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs17,5000), NAMED('ds_SBFE_recs17')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_17')),
            
            OUTPUT(SBFE_recs18,, output18FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs18,5000),, output18FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs18,5000), NAMED('ds_SBFE_recs18')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_18')),
            
            OUTPUT(SBFE_recs19,, output19FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs19,5000),, output19FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs19,5000), NAMED('ds_SBFE_recs19')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_19')),
            
            OUTPUT(SBFE_recs20,, output20FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs20,5000),, output20FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs20,5000), NAMED('ds_SBFE_recs20')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_20')),
            
            OUTPUT(SBFE_recs21,, output21FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs21,5000),, output21FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs21,5000), NAMED('ds_SBFE_recs21')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_21')),
            
            OUTPUT(SBFE_recs22,, output22FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs22,5000),, output22FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs22,5000), NAMED('ds_SBFE_recs22')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_22')),
            
            OUTPUT(SBFE_recs23,, output23FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs23,5000),, output23FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs23,5000), NAMED('ds_SBFE_recs23')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_23')),
            
            OUTPUT(SBFE_recs24,, output24FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs24,5000),, output24FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs24,5000), NAMED('ds_SBFE_recs24')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_24')),
            
            OUTPUT(SBFE_recs25,, output25FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs25,5000),, output25FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs25,5000), NAMED('ds_SBFE_recs25')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_25')),
            
            OUTPUT(SBFE_recs26,, output26FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs26,5000),, output26FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs26,5000), NAMED('ds_SBFE_recs26')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_26')),
            
            OUTPUT(SBFE_recs27,, output27FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs27,5000),, output27FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs27,5000), NAMED('ds_SBFE_recs27')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_27')),
            
            OUTPUT(SBFE_recs28,, output28FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs28,5000),, output28FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs28,5000), NAMED('ds_SBFE_recs28')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_28')),
            
            OUTPUT(SBFE_recs29,, output29FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs29,5000),, output29FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs29,5000), NAMED('ds_SBFE_recs29')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_29')),
            
            OUTPUT(SBFE_recs30,, output30FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs30,5000),, output30FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs30,5000), NAMED('ds_SBFE_recs30')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_30')),
            
            OUTPUT(SBFE_recs31,, output31FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs31,5000),, output31FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs31,5000), NAMED('ds_SBFE_recs31')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_31')),
            
            OUTPUT(SBFE_recs32,, output32FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs32,5000),, output32FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs32,5000), NAMED('ds_SBFE_recs32')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_32')),
            
            OUTPUT(SBFE_recs33,, output33FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs33,5000),, output33FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs33,5000), NAMED('ds_SBFE_recs33')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_33')),
            
            OUTPUT(SBFE_recs34,, output34FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs34,5000),, output34FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs34,5000), NAMED('ds_SBFE_recs34')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_34')),
            
            OUTPUT(SBFE_recs35,, output35FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs35,5000),, output35FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs35,5000), NAMED('ds_SBFE_recs35')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_35')),
            
            OUTPUT(SBFE_recs36,, output36FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs36,5000),, output36FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs36,5000), NAMED('ds_SBFE_recs36')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_36')),
            
            OUTPUT(SBFE_recs37,, output37FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs37,5000),, output37FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs37,5000), NAMED('ds_SBFE_recs37')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_37')),
            
            OUTPUT(SBFE_recs38,, output38FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs38,5000),, output38FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs38,5000), NAMED('ds_SBFE_recs38')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_38')),
            
            OUTPUT(SBFE_recs39,, output39FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs39,5000),, output39FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs39,5000), NAMED('ds_SBFE_recs39')), 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_39')),
            
            OUTPUT(SBFE_recs40,, output40FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs40,5000),, output40FileName,CSV(QUOTE('"'))), // Write to disk.
            // OUTPUT(CHOOSEN(SBFE_recs40,5000), NAMED('ds_SBFE_recs40')) 
            // OUTPUT(Std.Date.Today() + ' - ' + STD.Date.CurrentTime(TRUE), NAMED('outTime_40'))
*/       );
            