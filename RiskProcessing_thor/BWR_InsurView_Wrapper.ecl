#WORKUNIT('name', 'InsurView2 Attributes');

IMPORT lib_fileservices, RiskView, RiskProcessing_thor, STD, UT, data_services;

build_Period 					:= workunit[2..9];
//inputFileName 				:= 'vault::thor::iv20test';  // paste the input file name here.
inputFileName 				:= 'thor::base::cdw::prod::insuranceheader';  // if running on insurance header use this
outputFileNamePrefix	:= 'thor::base::AR::' + workunit + '::';
outputFileNameSuffix	:= 'InsurView20_outputdata'; //Update this suffix for your output file name
outputFileName 				:= outputFileNamePrefix + outputFileNameSuffix;
outputFormat					:= 'thor';   //Change this to thor if you want thor output instead of csv
historyDate						:= '';   // put as of date here in YYYYMMDD format if you want to run on date in the past
RecordsToRun					:= 10000000;  //set this to 0 to run all records
eyeball_count 				:= 10;

sendStartEmail := lib_fileservices.FileServices.sendemail(RiskProcessing_thor.Constants.Email_Target,'*** Insurview 2.0 Ad Hoc attributes - Job has started *** '  + workunit,
          'The Insurview 2.0 Ad Hoc attributes job has started in '  + workunit);

//     define input file record layout

layout_input := RiskProcessing_thor.Layouts.Layout_Insurance_Header;

//Below layout is for custom file not CDW insurance header
// layout_input := RECORD
  // unsigned8 lexid;
  // unsigned4 date_first_seen;
  // unsigned4 date_last_seen;
  // unsigned4 ih_date_first_seen;
  // unsigned4 ih_date_last_seen;
  // string1 active_flag;
  // string10 adl_segmentation;
  // string1 gender;
  // string1 derived_gender;
  // unsigned4 dob;
  // string9 ssn;
  // string25 dl_nbr;
  // string2 dl_state;
  // string20 first_name;
  // string20 middle_name;
  // string28 last_name;
  // string2 suffix;
  // string2 predir;
  // string10 prim_range;
  // string28 prim_name;
  // string4 addr_suffix;
  // string2 postdir;
  // string10 unit_desig;
  // string8 sec_range;
  // string25 city;
  // string2 state;
  // string5 zip;
  // string4 zip4;
  // string3 addrtype;
  // unsigned6 hhid;
  // unsigned6 hhid_indiv;
  // unsigned6 hhid_relat;
  // unsigned8 rid;
 // END;

#IF(inputFileName='thor::base::cdw::prod::insuranceheader')
       Inds := IF(RecordsToRun=0, DATASET('~' + inputFileName, RiskProcessing_thor.Layouts.Layout_Insurance_Header,THOR)(StringLib.StringToUpperCase(adl_segmentation) = 'CORE' and active_flag = 'Y' and LENGTH(TRIM((STRING20)lexid)) <= 12),
CHOOSEN(DATASET('~' + inputFileName, RiskProcessing_thor.Layouts.Layout_Insurance_Header,THOR)(StringLib.StringToUpperCase(adl_segmentation) = 'CORE' and active_flag = 'Y' and LENGTH(TRIM((STRING20)lexid)) <= 12), RecordsToRun));
#ELSE
       Inds := IF(RecordsToRun=0, DATASET('~' + inputFileName, layout_input, thor)(LENGTH(TRIM((STRING20)lexid)) <= 12),
CHOOSEN(DATASET('~' + inputFileName, layout_input, thor)(LENGTH(TRIM((STRING20)lexid)) <= 12), RecordsToRun));
#END


inds_dist := DISTRIBUTE(inds); //Distribute randomly

OUTPUT(CHOOSEN(inds_dist, eyeball_count), NAMED('Sample_InDS'));

//project the distributed input file into the riskview.layouts.Layout_Riskview_Batch_In layout

// You will need to project the layout_input to this Batch_In layout if the input file layout has different column names
BatchIn := PROJECT(inds_dist, TRANSFORM(riskview.layouts.Layout_Riskview_Batch_In,
    SELF.AcctNo := (STRING)LEFT.lexid;
	SELF.lexID := (STRING)LEFT.lexid,
	SELF.SSN := LEFT.ssn;
	SELF.Name_First := LEFT.first_name;
	SELF.Name_Middle := LEFT.middle_name;
	SELF.Name_Last := LEFT.last_name;
	SELF.Name_Suffix := LEFT.suffix;
	SELF.DOB := (STRING)LEFT.dob;
	SELF.Prim_Range := LEFT.prim_range;
	SELF.Predir := LEFT.predir;
	SELF.Prim_Name := LEFT.prim_name;
	SELF.Suffix := LEFT.addr_suffix;
	SELF.Postdir := LEFT.postdir;
	SELF.Unit_Desig := LEFT.unit_desig;
	SELF.Sec_Range := LEFT.sec_range;
	SELF.p_City_name := LEFT.city;
	SELF.St := LEFT.state;
	SELF.Z5 := LEFT.zip;
	SELF.DL_Number := LEFT.dl_nbr;
	SELF.DL_State := LEFT.dl_state;
	SELF.HistoryDateTimeStamp := historyDate;  
	SELF := []));

OUTPUT(CHOOSEN(BatchIn, eyeball_count), NAMED('Sample_BatchIn'));

Result := SEQUENTIAL(sendStartEmail, RiskProcessing_thor.Insurview2_thor(build_Period, BatchIn, eyeball_count, OutputFileName, outputFormat, historyDate));

Result
		: success(lib_fileservices.FileServices.sendemail(RiskProcessing_thor.Constants.Email_Target,'Insurview 2.0 Ad hoc attributes job successful '  + workunit,
          'Insurview 2.0 Ad hoc attributes job successful in ' + Thorlib.group())),
			failure(lib_fileservices.FileServices.sendemail(RiskProcessing_thor.Constants.Email_Target,'*** Insurview 2.0 Ad hoc attributes job failed *** ' + workunit,
          FAILMESSAGE));

