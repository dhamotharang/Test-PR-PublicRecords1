// STEP 3 IN PB 1.1 THOR ONE MAIN AUTOMATION PROCESS
// put the 4 output files together into 1 file
// pass the lexids to kel to append PB1.1 attributes
// put PB1.0 and PB1.1 into 1 file to get final output file
// remove the records from input file that were not in the output file - can lose records for some reason
// check counts here?  
// check quality here?  
#OPTION('expandSelectCreateRow', true);
#OPTION('outputLimit', 2000);
#OPTION('outputLimitMb', 1000);
#OPTION('splitterSpill', 1);
#OPTION('multiplePersistInstances',FALSE);
#OPTION('defaultSkewError', 1);

import _Control, STD, ProfileBooster, ProfileBooster.ProfileBoosterV2_KEL;

EXPORT bwr_ProfileBooster11_OneMain_Step3(string IPaddr, string AbsolutePath, string NotifyList, string VersionToRun, string2 PB10Version) := function

onThor := _Control.Environment.onThor;

original_filename := '~thor400::profilebooster::SpringLeaf_full_infile.csv';
original_input := dataset(original_filename, ProfileBooster.Layouts.LayoutPBInputThor, csv(quote('"')));
EmailList := If(NotifyList = '', ProfileBooster.Constants.ECL_Developers_Slim, ProfileBooster.Constants.ECL_Developers_Slim + ',' + NotifyList);


// read in the file into renamed layout, dedup it and remove lexid=0 records, which indicate pullid records, they dont want those
original_file1 := '~thor400::out::profile_booster' + if(PB10Version='11','V11','') + '_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part1';
original_file1date := STD.File.GetLogicalFileAttribute(original_file1,'workunit')[2..9] : INDEPENDENT;
original_file2 := '~thor400::out::profile_booster' + if(PB10Version='11','V11','') + '_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part2test';
original_file3 := '~thor400::out::profile_booster' + if(PB10Version='11','V11','') + '_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part3';
original_file4 := '~thor400::out::profile_booster' + if(PB10Version='11','V11','') + '_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part4';
modified_batchoutflat_layout := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.PB10_Modified_BatchOutFlat_Layout;
original_output1 := dataset(original_file1, modified_batchoutflat_layout, csv(quote('"')));
original_output2 := dataset(original_file2, modified_batchoutflat_layout, csv(quote('"')));
original_output3 := dataset(original_file3, modified_batchoutflat_layout, csv(quote('"')));
original_output4 := dataset(original_file4, modified_batchoutflat_layout, csv(quote('"')));

original_output_full := original_output1 + original_output2 + original_output3 + original_output4;// : FAILURE(FileServices.SendEmail(EmailList,'OneMain PB11 Step3 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
dedup_original_output := dedup(sort(original_output_full(lexid<>0), lexid), lexid);	// REMOVE RECORDS WHERE LEXID = 0 (PULLID)


batchout := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.PB10_BatchOut;

// PROJECT THE OUTPUT INTO THE LAYOUT THAT BATCH NEEDS TO RETURN TO CUSTOMER
project_deduped_pre := project(dedup_original_output, transform(batchout, self := left));

// CALL KEL TO GET PB1.1 ATTRIBUTES APPENDED
// STRING8 histDate := (STRING)STD.Date.Today();
STRING8 histDate := original_file1date;
STRING50 DataRestriction := '00000000000000000000000000000000000000000000000000';
STRING50 DataPermission  := '11111111111111111111111111111111111111111111111111';
pb11_attrs := ProfileBooster.getProfileBooster11AttrsOneMain( 
																histDate, 
																80,
																1,
																3,
																DataRestriction,
																DataPermission																
																);
																
// PROJECT KEL attributes back to the layout that batch needs to return to customer
FinalLayout := RECORD
		batchout;
		ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutPersonPB11 -LexID -G_ProcUID;
END;
FinalLayout xFormFinal(project_deduped_pre L, pb11_attrs R) := TRANSFORM
		SELF.PurchNewAmt := R.PL_PurchNewAmt;
		SELF.PurchTotEv := R.PL_PurchTotEv;
		SELF.PurchCntEv := R.PL_PurchCntEv;
		SELF.PurchNewMsnc := R.PL_PurchNewagemonths;
		SELF.PurchOldMsnc := R.PL_PurchOldagemonths;
		SELF.PurchItemCntEv := R.PL_PurchItemCntEv;
		SELF.PurchAmtAvg := R.PL_PurchAmtAvg;
		SELF.AstVehAutoCarCntEv := R.PL_AstVehAutoCarCntEv;
		SELF.AstVehAutoCntEv := R.PL_AstVehAutoCntEv;
		SELF.AstVehAutoEliteCntEv := R.PL_AstVehAutoEliteCntEv;
		SELF.AstVehAutoExpCntEv := R.PL_AstVehAutoExpCntEv;
		SELF.AstVehAutoLuxuryCntEv := R.PL_AstVehAutoLuxuryCntEv;
		SELF.AstVehAutoMakeCntEv := R.PL_AstVehAutoMakeCntEv;
		SELF.AstVehAutoOrigOwnCntEv := R.PL_AstVehAutoOrigOwnCntEv;
		SELF.AstVehAutoSUVCntEv := R.PL_AstVehAutoSUVCntEv;
		SELF.AstVehAutoTruckCntEv := R.PL_AstVehAutoTruckCntEv;
		SELF.AstVehAutoVanCntEv := R.PL_AstVehAutoVanCntEv;
		SELF.AstVehAuto2ndFreqMake := R.PL_AstVehAuto2ndFreqMake;
		SELF.AstVehAuto2ndFreqMakeCntEv := R.PL_AstVehAuto2ndFreqMakeCntEv;
		SELF.AstVehAutoFreqMake := R.PL_AstVehAutoFreqMake;
		SELF.AstVehAutoFreqMakeCntEv := R.PL_AstVehAutoFreqMakeCntEv;
		SELF.AstVehAutoNewTypeIndx := R.PL_AstVehAutoNewTypeIndx;
		SELF.AstVehAutoEmrgPriceAvg := (INTEGER)R.PL_AstVehAutoEmrgPriceAvg;
		SELF.AstVehAutoEmrgPriceDiff := R.PL_AstVehAutoEmrgPriceDiff;
		SELF.AstVehAutoEmrgPriceMax := R.PL_AstVehAutoEmrgPriceMax;
		SELF.AstVehAutoNewPrice := R.PL_AstVehAutoNewPrice;
		SELF.AstVehAutoEmrgAgeAvg := R.PL_AstVehAutoEmrgAgeAvg;
		SELF.AstVehAutoEmrgAgeMax := R.PL_AstVehAutoEmrgAgeMax;
		SELF.AstVehAutoEmrgAgeMin := R.PL_AstVehAutoEmrgAgeMin;
		SELF.AstVehAutoEmrgSpanAvg := R.PL_AstVehAutoEmrgSpanAvg;
		SELF.AstVehAutoLastAgeAvg := R.PL_AstVehAutoLastAgeAvg;
		SELF.AstVehAutoLastAgeMax := R.PL_AstVehAutoLastAgeMax;
		SELF.AstVehAutoLastAgeMin := R.PL_AstVehAutoLastAgeMin;
		SELF.AstVehAutoNewMsnc := R.PL_AstVehAutoNewMsnc;
		SELF.AstVehAutoTimeOwnSpanAvg := R.PL_AstVehAutoTimeOwnSpanAvg;
		SELF.AstVehOtherATVCntEv := R.PL_AstVehOtherATVCntEv;
		SELF.AstVehOtherCamperCntEv := R.PL_AstVehOtherCamperCntEv;
		SELF.AstVehOtherCntEv := R.PL_AstVehOtherCntEv;
		SELF.AstVehOtherCommCntEv := R.PL_AstVehOtherCommCntEv;
		SELF.AstVehOtherMtrCntEv := R.PL_AstVehOtherMtrCntEv;
		SELF.AstVehOtherOrigOwnCntEv := R.PL_AstVehOtherOrigOwnCntEv;
		SELF.AstVehOtherScooterCntEv := R.PL_AstVehOtherScooterCntEv;
		SELF.AstVehOtherNewMsnc := R.PL_AstVehOtherNewMsnc;
		SELF.AstVehOtherNewTypeIndx := R.PL_AstVehOtherNewTypeIndx;
		SELF.AstVehOtherNewPrice := R.PL_AstVehOtherNewPrice;
		SELF.AstVehOtherPriceAvg := R.PL_AstVehOtherPriceAvg;
		SELF.AstVehOtherPriceMax := R.PL_AstVehOtherPriceMax;
		SELF.AstVehOtherPriceMin := R.PL_AstVehOtherPriceMin;
		SELF.AstVehAutoEmrgPriceMin := R.PL_AstVehAutoEmrgPriceMin;
		SELF := L;
		SELF := R;
		SELF := [];
	END;
	
project_deduped_pb11 := JOIN(project_deduped_pre, pb11_attrs,
											LEFT.lexid = RIGHT.LexID,
											xFormFinal(LEFT,RIGHT), LEFT OUTER);
											
// Add back in KEL defaults for LexID missing
project_deduped_pre := PROJECT(project_deduped_pb11,
		TRANSFORM(FinalLayout,
			SELF.PurchNewAmt := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.PurchNewAmt);
			SELF.PurchTotEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.PurchTotEv);
			SELF.PurchCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.PurchCntEv);
			SELF.PurchNewMsnc := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.PurchNewMsnc);
			SELF.PurchOldMsnc := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.PurchOldMsnc);
			SELF.PurchItemCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.PurchItemCntEv);
			SELF.PurchAmtAvg := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.PurchAmtAvg);
			SELF.AstVehAutoCarCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoCarCntEv);
			SELF.AstVehAutoCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoCntEv);
			SELF.AstVehAutoEliteCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoEliteCntEv);
			SELF.AstVehAutoExpCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoExpCntEv);
			SELF.AstVehAutoLuxuryCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoLuxuryCntEv);
			SELF.AstVehAutoMakeCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoMakeCntEv);
			SELF.AstVehAutoOrigOwnCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoOrigOwnCntEv);
			SELF.AstVehAutoSUVCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoSUVCntEv);
			SELF.AstVehAutoTruckCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoTruckCntEv);
			SELF.AstVehAutoVanCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoVanCntEv);
			SELF.AstVehAuto2ndFreqMake := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, LEFT.AstVehAuto2ndFreqMake);
			SELF.AstVehAuto2ndFreqMakeCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAuto2ndFreqMakeCntEv);
			SELF.AstVehAutoFreqMake := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, LEFT.AstVehAutoFreqMake);
			SELF.AstVehAutoFreqMakeCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoFreqMakeCntEv);
			SELF.AstVehAutoNewTypeIndx := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoNewTypeIndx);
			SELF.AstVehAutoEmrgPriceAvg := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoEmrgPriceAvg);
			SELF.AstVehAutoEmrgPriceDiff := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoEmrgPriceDiff);
			SELF.AstVehAutoEmrgPriceMax := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoEmrgPriceMax);
			SELF.AstVehAutoNewPrice := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoNewPrice);
			SELF.AstVehAutoEmrgAgeAvg := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoEmrgAgeAvg);
			SELF.AstVehAutoEmrgAgeMax := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoEmrgAgeMax);
			SELF.AstVehAutoEmrgAgeMin := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoEmrgAgeMin);
			SELF.AstVehAutoEmrgSpanAvg := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoEmrgSpanAvg);
			SELF.AstVehAutoLastAgeAvg := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoLastAgeAvg);
			SELF.AstVehAutoLastAgeMax := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoLastAgeMax);
			SELF.AstVehAutoLastAgeMin := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoLastAgeMin);
			SELF.AstVehAutoNewMsnc := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoNewMsnc);
			SELF.AstVehAutoTimeOwnSpanAvg := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoTimeOwnSpanAvg);
			SELF.AstVehOtherATVCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherATVCntEv);
			SELF.AstVehOtherCamperCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherCamperCntEv);
			SELF.AstVehOtherCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherCntEv);
			SELF.AstVehOtherCommCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherCommCntEv);
			SELF.AstVehOtherMtrCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherMtrCntEv);
			SELF.AstVehOtherOrigOwnCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherOrigOwnCntEv);
			SELF.AstVehOtherScooterCntEv := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherScooterCntEv);
			SELF.AstVehOtherNewMsnc := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherNewMsnc);
			SELF.AstVehOtherNewTypeIndx := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherNewTypeIndx);
			SELF.AstVehOtherNewPrice := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherNewPrice);
			SELF.AstVehOtherPriceAvg := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherPriceAvg);
			SELF.AstVehOtherPriceMax := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherPriceMax);
			SELF.AstVehOtherPriceMin := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehOtherPriceMin);
			SELF.AstVehAutoEmrgPriceMin := IF(LEFT.astvehauto2ndfreqmake='',ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AstVehAutoEmrgPriceMin);
			SELF := LEFT)); 
			
			
//Profile Booster 1.1 Modifications
FinalLayout PB11_xfm1(project_deduped_pre l) := TRANSFORM
		Modification1 := l.v1_VerifiedProspectFound = '1' and l.PurchCntEv = -99999;
		SELF.PurchCntEv := IF(Modification1,0,l.PurchCntEv);
		SELF.PurchItemCntEv := IF(Modification1,0,l.PurchItemCntEv);
		SELF.PurchOldMsnc := IF(Modification1,-99998,l.PurchOldMsnc);
		SELF.PurchNewMsnc := IF(Modification1,-99998,l.PurchNewMsnc);
		SELF.PurchTotEv := IF(Modification1,-99998,l.PurchTotEv);
		SELF.PurchAmtAvg := IF(Modification1,-99998,l.PurchAmtAvg);
		SELF.PurchNewAmt := IF(Modification1,-99998,l.PurchNewAmt);
		SELF.AstVehAutoCntEv := IF(Modification1,0,l.AstVehAutoCntEv);
		SELF.AstVehAutoCarCntEv := IF(Modification1,0,l.AstVehAutoCarCntEv);
		SELF.AstVehAutoSUVCntEv := IF(Modification1,0,l.AstVehAutoSUVCntEv);
		SELF.AstVehAutoTruckCntEv := IF(Modification1,0,l.AstVehAutoTruckCntEv);
		SELF.AstVehAutoVanCntEv := IF(Modification1,0,l.AstVehAutoVanCntEv);
		SELF.AstVehAutoNewTypeIndx := IF(Modification1,-99998,l.AstVehAutoNewTypeIndx);
		SELF.AstVehAutoExpCntEv := IF(Modification1,0,l.AstVehAutoExpCntEv);
		SELF.AstVehAutoEliteCntEv := IF(Modification1,0,l.AstVehAutoEliteCntEv);
		SELF.AstVehAutoLuxuryCntEv := IF(Modification1,0,l.AstVehAutoLuxuryCntEv);
		SELF.AstVehAutoOrigOwnCntEv := IF(Modification1,0,l.AstVehAutoOrigOwnCntEv);
		SELF.AstVehAutoMakeCntEv := IF(Modification1,0,l.AstVehAutoMakeCntEv);
		SELF.AstVehAutoFreqMake := IF(Modification1,'-99998',l.AstVehAutoFreqMake);
		SELF.AstVehAutoFreqMakeCntEv := IF(Modification1,0,l.AstVehAutoFreqMakeCntEv);
		SELF.AstVehAuto2ndFreqMake := IF(Modification1,'-99998',l.AstVehAuto2ndFreqMake);
		SELF.AstVehAuto2ndFreqMakeCntEv := IF(Modification1,0,l.AstVehAuto2ndFreqMakeCntEv);
		SELF.AstVehAutoEmrgPriceAvg := IF(Modification1,-99998,l.AstVehAutoEmrgPriceAvg);
		SELF.AstVehAutoEmrgPriceMax := IF(Modification1,-99998,l.AstVehAutoEmrgPriceMax);
		SELF.AstVehAutoEmrgPriceMin := IF(Modification1,-99998,l.AstVehAutoEmrgPriceMin);
		SELF.AstVehAutoNewPrice := IF(Modification1,-99998,l.AstVehAutoNewPrice);
		SELF.AstVehAutoEmrgPriceDiff := IF(Modification1,-99998,l.AstVehAutoEmrgPriceDiff);
		SELF.AstVehAutoLastAgeAvg := IF(Modification1,-99998,l.AstVehAutoLastAgeAvg);
		SELF.AstVehAutoLastAgeMax := IF(Modification1,-99998,l.AstVehAutoLastAgeMax);
		SELF.AstVehAutoLastAgeMin := IF(Modification1,-99998,l.AstVehAutoLastAgeMin);
		SELF.AstVehAutoEmrgAgeAvg := IF(Modification1,-99998,l.AstVehAutoEmrgAgeAvg);
		SELF.AstVehAutoEmrgAgeMax := IF(Modification1,-99998,l.AstVehAutoEmrgAgeMax);
		SELF.AstVehAutoEmrgAgeMin := IF(Modification1,-99998,l.AstVehAutoEmrgAgeMin);
		SELF.AstVehAutoEmrgSpanAvg := IF(Modification1,-99998,l.AstVehAutoEmrgSpanAvg);
		SELF.AstVehAutoNewMsnc := IF(Modification1,-99998,l.AstVehAutoNewMsnc);
		SELF.AstVehAutoTimeOwnSpanAvg := IF(Modification1,-99998,l.AstVehAutoTimeOwnSpanAvg);
		SELF.AstVehOtherCntEv := IF(Modification1,0,l.AstVehOtherCntEv);
		SELF.AstVehOtherATVCntEv := IF(Modification1,0,l.AstVehOtherATVCntEv);
		SELF.AstVehOtherCamperCntEv := IF(Modification1,0,l.AstVehOtherCamperCntEv);
		SELF.AstVehOtherCommCntEv := IF(Modification1,0,l.AstVehOtherCommCntEv);
		SELF.AstVehOtherMtrCntEv := IF(Modification1,0,l.AstVehOtherMtrCntEv);
		SELF.AstVehOtherScooterCntEv := IF(Modification1,0,l.AstVehOtherScooterCntEv);
		SELF.AstVehOtherNewTypeIndx := IF(Modification1,-99998,l.AstVehOtherNewTypeIndx);
		SELF.AstVehOtherOrigOwnCntEv := IF(Modification1,0,l.AstVehOtherOrigOwnCntEv);
		SELF.AstVehOtherNewMsnc := IF(Modification1,-99998,l.AstVehOtherNewMsnc);
		SELF.AstVehOtherPriceAvg := IF(Modification1,-99998,l.AstVehOtherPriceAvg);
		SELF.AstVehOtherPriceMax := IF(Modification1,-99998,l.AstVehOtherPriceMax);
		SELF.AstVehOtherPriceMin := IF(Modification1,-99998,l.AstVehOtherPriceMin);
		SELF.AstVehOtherNewPrice := IF(Modification1,-99998,l.AstVehOtherNewPrice);

		SELF := l;
		SELF := [];
	END;	
Xfm1Result := PROJECT(project_deduped_pre, PB11_xfm1(LEFT));	
	
FinalLayout PB11_xfm2(Xfm1Result l) := TRANSFORM
		Modification2 := l.v1_VerifiedProspectFound = '-1' and l.PurchCntEv <> -99999;
		SELF.v1_VerifiedProspectFound := IF(Modification2,'1',l.v1_VerifiedProspectFound);
		SELF := l;
		SELF := [];
	END;
Xfm2Result := PROJECT(Xfm1Result, PB11_xfm2(LEFT));	
	
FinalLayout PB11_xfm3(Xfm2Result l) := TRANSFORM
		Modification3 := l.PurchCntEv = 0;
		SELF.PurchItemCntEv := IF(Modification3,0,l.PurchItemCntEv);
		SELF.PurchOldMsnc := IF(Modification3,-99998,l.PurchOldMsnc);
		SELF.PurchNewMsnc := IF(Modification3,-99998,l.PurchNewMsnc);
		SELF.PurchTotEv := IF(Modification3,-99998,l.PurchTotEv);
		SELF.PurchAmtAvg := IF(Modification3,-99998,l.PurchAmtAvg);
		SELF.PurchNewAmt := IF(Modification3,-99998,l.PurchNewAmt);
		SELF := l;
		SELF := [];
	END;
Xfm3Result := PROJECT(Xfm2Result, PB11_xfm3(LEFT));	
	
FinalLayout PB11_xfm4(Xfm2Result l) := TRANSFORM
		Modification4 := l.PurchCntEv > 0;
		SELF.PurchItemCntEv := IF(Modification4 AND l.PurchItemCntEv=0,-99997,l.PurchItemCntEv);
		SELF.PurchOldMsnc := IF(Modification4 AND l.PurchOldMsnc=-99998,-99997,l.PurchOldMsnc);
		SELF.PurchNewMsnc := IF(Modification4 AND l.PurchNewMsnc=-99998,-99997,l.PurchNewMsnc);
		SELF.PurchTotEv := IF(Modification4 AND l.PurchTotEv=-99998,-99997,l.PurchTotEv);
		SELF.PurchAmtAvg := IF(Modification4 AND l.PurchAmtAvg=-99998,-99997,l.PurchAmtAvg);
		SELF.PurchNewAmt := IF(Modification4 AND l.PurchNewAmt=-99998,-99997,l.PurchNewAmt);
		SELF := l;
		SELF := [];
	END;
project_deduped := PROJECT(Xfm3Result, PB11_xfm4(LEFT));			

// Join the input to the output and only keep the matching records as output can lose records, need to be the same count
inlayout_whatCustomerWants := RECORD
  unsigned6 lexid;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  string addressline1;
  string addressline2;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
 END;
reducedInput := join(original_input, project_deduped, left.lexid=right.lexid, transform(inlayout_whatCustomerWants, 
											self.lexid := left.lexid;
											self.fname := left.Name_First;
											self.mname := left.Name_Middle;
											self.lname := left.Name_Last;
											self.name_suffix := left.Name_Suffix;
											self.addressline1 := left.addressline1;
											self.addressline2 := left.addressline2;
											self.city_name := left.city_name;
											self.st := left.st;
											self.zip := left.z5;
											self.zip4 := left.z4));
											
 reducedOutput := join(reducedInput, project_deduped, left.lexid=right.lexid, transform(FinalLayout, self := right));  // reduce output if there is no Input record - don't ask
 
 NewLexidCount := count(project_deduped) - count(reducedOutput);
											
 output(NewLexidCount, NAMED('NewLexidCount'));
 output(choosen(original_input, 100), NAMED('original_input'));
 output(choosen(project_deduped_pre, 100), NAMED('project_deduped_pre_sample'));
 output(choosen(pb11_attrs(PL_AstVehAutoCntEv>0), 100), NAMED('pb11_attrs_sample_withVeh'));
 output(choosen(pb11_attrs, 100), NAMED('pb11_attrs_sample'));
 output(choosen(project_deduped_pb11, 100), NAMED('project_deduped_pb11_sample')); 
 output(choosen(project_deduped, 100), NAMED('project_deduped_sample'));
 Output(choosen(reducedOutput,100), NAMED('dedup_original_output'));
 output(count(reducedOutput), NAMED('count_dedup_original_output'));
 // output(reducedOutput,, '~thor400::profileboosterV11::LN_Output_springleaf_layout_ProfBooster.csv', csv(heading(single), quote('"'), terminator('\r\n')));
 output(reducedOutput,, '~thor400::profileboosterV11::LN_Output_springleaf_layout_ProfBooster.csv', csv(heading(single), quote('"'), terminator('\r\n')), overwrite);
											
 output(choosen(reducedInput, 10), NAMED('reduced_input'));
 output(count(reducedInput), NAMED('count_reduced_input'));
 // this has to be the exact name, needs CR/LF
 // output(reducedInput,, '~thor400::profileboosterV11::LN_Output_springleaf_layout_PII.csv', csv(heading(single), quote('"'), terminator('\r\n')));
 output(reducedInput,, '~thor400::profileboosterV11::LN_Output_springleaf_layout_PII.csv', csv(heading(single), quote('"'), terminator('\r\n')), overwrite);
 
 
 ded := count(dedup(sort(original_input, lexid), lexid));
 output(ded, named('count_dedup_input'));
 
 ded2 := count(dedup(sort(original_output_full, lexid), lexid));
 output(ded2, named('count_dedup_output'));
 
 // t := table(original_output_full, {lexid, lexidcount := count(group)}, lexid); 
 // output(t(lexidcount>1), named('count_output_with_lexid'));
 	
 RETURN 'SUCCESSFUL';

END;