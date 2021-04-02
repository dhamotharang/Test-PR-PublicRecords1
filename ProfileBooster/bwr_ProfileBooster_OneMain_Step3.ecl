// STEP 4 IN PB 1.0 THOR ONE MAIN AUTOMATION PROCESS
// put the 4 output files together into 1 file
// remove the records from input file that were not in the output file - can lose records for some reason
// check counts here?  send email if bad? to scoring qa and todd
// check quality here?  send email if bad?  to scoring qa and todd

#workunit('priority','high'); 

import _Control, STD, ProfileBooster;


EXPORT bwr_ProfileBooster_OneMain_Step3(string IPaddr, string AbsolutePath, string NotifyList) := function

onThor := _Control.Environment.onThor;


original_input := dataset('~thor400::profilebooster::SpringLeaf_full_infile.csv', ProfileBooster.Layouts.LayoutPBInputThor, csv(quote('"')));
EmailList := If(NotifyList = '', ProfileBooster.Constants.ECL_Developers_Slim, ProfileBooster.Constants.ECL_Developers_Slim + ',' + NotifyList);


// copied from ProfileBooster.Layouts.Layout_PB_BatchOutFlat and removed the v1_ so that the field names match batchout, which is what the customer wants
modified_batchoutflat_layout := RECORD
  string30 	AcctNo;
	unsigned6	Seq;
	unsigned6 LexID;
	String2		DoNotMail;
	String2		VerifiedProspectFound;
	String2		VerifiedName;
	String2		VerifiedSSN;
	String2		VerifiedPhone;
	String2		VerifiedCurrResMatchIndex;
	String3		ProspectTimeOnRecord;
	String3		ProspectTimeLastUpdate;
	String2		ProspectLastUpdate12Mo;
	String3		ProspectAge;
	String2		ProspectGender;
	String2		ProspectMaritalStatus;
	String2		ProspectEstimatedIncomeRange;
	String2		ProspectDeceased;
	String2		ProspectCollegeAttending;
	String2		ProspectCollegeAttended;
	String2		ProspectCollegeProgramType;
	String2		ProspectCollegePrivate;
	String2		ProspectCollegeTier;
	String2		ProspectBankingExperience;
	String2		AssetCurrOwner;
	String2		PropCurrOwner;
	String3		PropCurrOwnedCnt;
	String7		PropCurrOwnedAssessedTtl;
	String7		PropCurrOwnedAVMTtl;
	String3		PropTimeLastSale;
	String3		PropEverOwnedCnt;
	String3		PropEverSoldCnt;
	String3		PropSoldCnt12Mo;
	String5		PropSoldRatio;
	String3		PropPurchaseCnt12Mo;
	String2		PPCurrOwner;
	String3		PPCurrOwnedCnt;
	String3		PPCurrOwnedAutoCnt;
	String3		PPCurrOwnedMtrcycleCnt;
	String3		PPCurrOwnedAircrftCnt;
	String3		PPCurrOwnedWtrcrftCnt;
	String3		LifeEvTimeLastMove;
	String2		LifeEvNameChange;
	String2		LifeEvNameChangeCnt12Mo;
	String3		LifeEvTimeFirstAssetPurchase;
	String3		LifeEvTimeLastAssetPurchase;
	String3		LifeEvEverResidedCnt;
	String5		LifeEvLastMoveTaxRatioDiff;
	String2		LifeEvEconTrajectory;
	String2		LifeEvEconTrajectoryIndex;
	String2		ResCurrOwnershipIndex;
	String7		ResCurrAVMValue;
	String7		ResCurrAVMValue12Mo;
	String5		ResCurrAVMRatioDiff12Mo;
	String7		ResCurrAVMValue60Mo;
	String5		ResCurrAVMRatioDiff60Mo;
	String5		ResCurrAVMCntyRatio;
	String5		ResCurrAVMTractRatio;
	String5		ResCurrAVMBlockRatio;
	String2		ResCurrDwellType;
	String2		ResCurrDwellTypeIndex;
	String2		ResCurrMortgageType;
	String7		ResCurrMortgageAmount;
	String3		ResCurrBusinessCnt;
	String2		ResInputOwnershipIndex;
	String7		ResInputAVMValue;
	String7		ResInputAVMValue12Mo;
	String5		ResInputAVMRatioDiff12Mo;
	String7		ResInputAVMValue60Mo;
	String5		ResInputAVMRatioDiff60Mo;
	String5		ResInputAVMCntyRatio;
	String5		ResInputAVMTractRatio;
	String5		ResInputAVMBlockRatio;
	String2		ResInputDwellType;
	String2		ResInputDwellTypeIndex;
	String2		ResInputMortgageType;
	String7		ResInputMortgageAmount;
	String3		ResInputBusinessCnt;
	String3		CrtRecCnt;
	String3		CrtRecCnt12Mo;
	String3		CrtRecTimeNewest;
	String3		CrtRecFelonyCnt;
	String3		CrtRecFelonyCnt12Mo;
	String3		CrtRecFelonyTimeNewest;
	String3		CrtRecMsdmeanCnt;
	String3		CrtRecMsdmeanCnt12Mo;
	String3		CrtRecMsdmeanTimeNewest;
	String3		CrtRecEvictionCnt;
	String3		CrtRecEvictionCnt12Mo;
	String3		CrtRecEvictionTimeNewest;
	String3		CrtRecLienJudgCnt;
	String3		CrtRecLienJudgCnt12Mo;
	String3		CrtRecLienJudgTimeNewest;
	String7		CrtRecLienJudgAmtTtl;
	String3		CrtRecBkrptCnt;
	String3		CrtRecBkrptCnt12Mo;
	String3		CrtRecBkrptTimeNewest;
	String2		CrtRecSeverityIndex;
	String2		OccProfLicense;
	String2		OccProfLicenseCategory;
	String2		OccBusinessAssociation;
	String3		OccBusinessAssociationTime;
	String2		OccBusinessTitleLeadership;
	String2		InterestSportPerson;
	String3		HHTeenagerMmbrCnt;
	String3		HHYoungAdultMmbrCnt;
	String3		HHMiddleAgemmbrCnt;
	String3		HHSeniorMmbrCnt;
	String3		HHElderlyMmbrCnt;
	String3		HHCnt;
	String2		HHEstimatedIncomeRange;
	String3		HHCollegeAttendedMmbrCnt;
	String3		HHCollege2yrAttendedMmbrCnt;
	String3		HHCollege4yrAttendedMmbrCnt;
	String3		HHCollegeGradAttendedMmbrCnt;
	String3		HHCollegePrivateMmbrCnt;
	String2		HHCollegeTierMmbrHighest;
	String3		HHPropCurrOwnerMmbrCnt;
	String3		HHPropCurrOwnedCnt;
	String7		HHPropCurrAVMHighest;
	String3		HHPPCurrOwnedCnt;
	String3		HHPPCurrOwnedAutoCnt;
	String3		HHPPCurrOwnedMtrcycleCnt;
	String3		HHPPCurrOwnedAircrftCnt;
	String3		HHPPCurrOwnedWtrcrftCnt;
	String3		HHCrtRecMmbrCnt;
	String3		HHCrtRecMmbrCnt12Mo;
	String3		HHCrtRecFelonyMmbrCnt;
	String3		HHCrtRecFelonyMmbrCnt12Mo;
	String3		HHCrtRecMsdmeanMmbrCnt;
	String3		HHCrtRecMsdmeanMmbrCnt12Mo;
	String3		HHCrtRecEvictionMmbrCnt;
	String3		HHCrtRecEvictionMmbrCnt12Mo;
	String3		HHCrtRecLienJudgMmbrCnt;
	String3		HHCrtRecLienJudgMmbrCnt12Mo;
	String7		HHCrtRecLienJudgAmtTtl;
	String3		HHCrtRecBkrptMmbrCnt;
	String3		HHCrtRecBkrptMmbrCnt12Mo;
	String3		HHCrtRecBkrptMmbrCnt24Mo;
	String3		HHOccProfLicMmbrCnt;
	String3		HHOccBusinessAssocMmbrCnt;
	String3		HHInterestSportPersonMmbrCnt;
	String3		RaATeenageMmbrCnt;
	String3		RaAYoungAdultMmbrCnt;
	String3		RaAMiddleAgeMmbrCnt;
	String3		RaASeniorMmbrCnt;
	String3		RaAElderlyMmbrCnt;
	String3		RaAHHCnt;
	String3		RaAMmbrCnt;
	String2		RaAMedIncomeRange;
	String3		RaACollegeAttendedMmbrCnt;
	String3		RaACollege2yrAttendedMmbrCnt;
	String3		RaACollege4yrAttendedMmbrCnt;
	String3		RaACollegeGradAttendedMmbrCnt;
	String3		RaACollegePrivateMmbrCnt;
	String3		RaACollegeTopTierMmbrCnt;
	String3		RaACollegeMidTierMmbrCnt;
	String3		RaACollegeLowTierMmbrCnt;
	String3		RaAPropCurrOwnerMmbrCnt;
	String7		RaAPropOwnerAVMHighest;
	String7		RaAPropOwnerAVMMed;
	String3		RaAPPCurrOwnerMmbrCnt;
	String3		RaAPPCurrOwnerAutoMmbrCnt;
	String3		RaAPPCurrOwnerMtrcycleMmbrCnt;
	String3		RaAPPCurrOwnerAircrftMmbrCnt;
	String3		RaAPPCurrOwnerWtrcrftMmbrCnt;
	String3		RaACrtRecMmbrCnt;
	String3		RaACrtRecMmbrCnt12Mo;
	String3		RaACrtRecFelonyMmbrCnt;
	String3		RaACrtRecFelonyMmbrCnt12Mo;
	String3		RaACrtRecMsdmeanMmbrCnt;
	String3		RaACrtRecMsdmeanMmbrCnt12Mo;
	String3		RaACrtRecEvictionMmbrCnt;
	String3		RaACrtRecEvictionMmbrCnt12Mo;
	String3		RaACrtRecLienJudgMmbrCnt;
	String3		RaACrtRecLienJudgMmbrCnt12Mo;
	String7		RaACrtRecLienJudgAmtMax;
	String3		RaACrtRecBkrptMmbrCnt36Mo;
	String3		RaAOccProfLicMmbrCnt;
	String3		RaAOccBusinessAssocMmbrCnt;
	String3		RaAInterestSportPersonMmbrCnt;
	
	// new attributes added for bug RQ-13721
	string25 PPCurrOwnedAutoVIN;
	string4 PPCurrOwnedAutoYear;
	string36 PPCurrOwnedAutoMake;
	string30 PPCurrOwnedAutoModel;
	string20 PPCurrOwnedAutoSeries;
	string25 PPCurrOwnedAutoType;
	
// for future use, possible custom model return
	String3 	score1 := '';
	string15 	scorename1 := '';
	String2 	reason1 := '';
	String2 	reason2 := '';
	String2 	reason3 := '';
	String2 	reason4 := '';
	String2 	reason5 := '';
	String2 	reason6 := '';
END; 
// read in the file into renamed layout, dedup it and remove lexid=0 records, which indicate pullid records, they dont want those
original_output1 := dataset('~thor400::out::profile_booster_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part1', modified_batchoutflat_layout, csv(quote('"')));
original_output2 := dataset('~thor400::out::profile_booster_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part2', modified_batchoutflat_layout, csv(quote('"')));
original_output3 := dataset('~thor400::out::profile_booster_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part3', modified_batchoutflat_layout, csv(quote('"')));
original_output4 := dataset('~thor400::out::profile_booster_attributes_' + if(onThor, 'thor_', 'roxie_') + 'part4', modified_batchoutflat_layout, csv(quote('"')));

original_output_full := original_output1 + original_output2 + original_output3 + original_output4 : FAILURE(FileServices.SendEmail(EmailList,'OneMain Step3 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
dedup_original_output := dedup(sort(original_output_full(lexid<>0), lexid), lexid);	// REMOVE RECORDS WHERE LEXID = 0 (PULLID)




batchout := RECORD
  unsigned6 LexID;
  string2 DoNotMail;
  string2 VerifiedSSN;
  string2 VerifiedPhone;
  string3 ProspectTimeOnRecord;
  string3 ProspectTimeLastUpdate;
  string2 ProspectLastUpdate12Mo;
  string3 ProspectAge;
  string2 ProspectGender;
  string2 ProspectMaritalStatus;
  string2 ProspectEstimatedIncomeRange;
  string2 ProspectDeceased;
  string2 ProspectCollegeAttending;
  string2 ProspectCollegeAttended;
  string2 ProspectCollegeProgramType;
  string2 ProspectCollegePrivate;
  string2 ProspectCollegeTier;
  string2 ProspectBankingExperience;
  string2 AssetCurrOwner;
  string2 PropCurrOwner;
  string3 PropCurrOwnedCnt;
  string7 PropCurrOwnedAssessedTtl;
  string7 PropCurrOwnedAVMTtl;
  string3 PropTimeLastSale;
  string3 PropEverOwnedCnt;
  string3 PropEverSoldCnt;
  string3 PropSoldCnt12Mo;
  string5 PropSoldRatio;
  string3 PropPurchaseCnt12Mo;
  string2 PPCurrOwner;
  string3 PPCurrOwnedCnt;
  string3 PPCurrOwnedAutoCnt;
  string3 PPCurrOwnedMtrcycleCnt;
  string3 PPCurrOwnedAircrftCnt;
  string3 PPCurrOwnedWtrcrftCnt;
  string3 LifeEvTimeLastMove;
  string2 LifeEvNameChange;
  string2 LifeEvNameChangeCnt12Mo;
  string3 LifeEvTimeFirstAssetPurchase;
  string3 LifeEvTimeLastAssetPurchase;
  string3 LifeEvEverResidedCnt;
  string5 LifeEvLastMoveTaxRatioDiff;
  string2 LifeEvEconTrajectory;
  string2 LifeEvEconTrajectoryIndex;
  string2 ResCurrOwnershipIndex;
  string7 ResCurrAVMValue;
  string7 ResCurrAVMValue12Mo;
  string5 ResCurrAVMRatioDiff12Mo;
  string7 ResCurrAVMValue60Mo;
  string5 ResCurrAVMRatioDiff60Mo;
  string5 ResCurrAVMCntyRatio;
  string5 ResCurrAVMTractRatio;
  string5 ResCurrAVMBlockRatio;
  string2 ResCurrDwellType;
  string2 ResCurrDwellTypeIndex;
  string2 ResCurrMortgageType;
  string7 ResCurrMortgageAmount;
  string3 ResCurrBusinessCnt;
  string3 CrtRecCnt;
  string3 CrtRecCnt12Mo;
  string3 CrtRecTimeNewest;
  string3 CrtRecFelonyCnt;
  string3 CrtRecFelonyCnt12Mo;
  string3 CrtRecFelonyTimeNewest;
  string3 CrtRecMsdmeanCnt;
  string3 CrtRecMsdmeanCnt12Mo;
  string3 CrtRecMsdmeanTimeNewest;
  string3 CrtRecEvictionCnt;
  string3 CrtRecEvictionCnt12Mo;
  string3 CrtRecEvictionTimeNewest;
  string3 CrtRecLienJudgCnt;
  string3 CrtRecLienJudgCnt12Mo;
  string3 CrtRecLienJudgTimeNewest;
  string7 CrtRecLienJudgAmtTtl;
  string3 CrtRecBkrptCnt;
  string3 CrtRecBkrptCnt12Mo;
  string3 CrtRecBkrptTimeNewest;
  string2 CrtRecSeverityIndex;
  string2 OccProfLicense;
  string2 OccProfLicenseCategory;
  string2 OccBusinessAssociation;
  string3 OccBusinessAssociationTime;
  string2 OccBusinessTitleLeadership;
  string2 InterestSportPerson;
  string3 HHTeenagerMmbrCnt;
  string3 HHYoungAdultMmbrCnt;
  string3 HHMiddleAgeMmbrCnt;
  string3 HHSeniorMmbrCnt;
  string3 HHElderlyMmbrCnt;
  string3 HHCnt;
  string2 HHEstimatedIncomeRange;
  string3 HHCollegeAttendedMmbrCnt;
  string3 HHCollege2yrAttendedMmbrCnt;
  string3 HHCollege4yrAttendedMmbrCnt;
  string3 HHCollegeGradAttendedMmbrCnt;
  string3 HHCollegePrivateMmbrCnt;
  string2 HHCollegeTierMmbrHighest;
  string3 HHPropCurrOwnerMmbrCnt;
  string3 HHPropCurrOwnedCnt;
  string7 HHPropCurrAVMHighest;
  string3 HHPPCurrOwnedCnt;
  string3 HHPPCurrOwnedAutoCnt;
  string3 HHPPCurrOwnedMtrcycleCnt;
  string3 HHPPCurrOwnedAircrftCnt;
  string3 HHPPCurrOwnedWtrcrftCnt;
  string3 HHCrtRecMmbrCnt;
  string3 HHCrtRecMmbrCnt12Mo;
  string3 HHCrtRecFelonyMmbrCnt;
  string3 HHCrtRecFelonyMmbrCnt12Mo;
  string3 HHCrtRecMsdmeanMmbrCnt;
  string3 HHCrtRecMsdmeanMmbrCnt12Mo;
  string3 HHCrtRecEvictionMmbrCnt;
  string3 HHCrtRecEvictionMmbrCnt12Mo;
  string3 HHCrtRecLienJudgMmbrCnt;
  string3 HHCrtRecLienJudgMmbrCnt12Mo;
  string7 HHCrtRecLienJudgAmtTtl;
  string3 HHCrtRecBkrptMmbrCnt;
  string3 HHCrtRecBkrptMmbrCnt12Mo;
  string3 HHCrtRecBkrptMmbrCnt24Mo;
  string3 HHOccProfLicMmbrCnt;
  string3 HHOccBusinessAssocMmbrCnt;
  string3 HHInterestSportPersonMmbrCnt;
  string3 RaATeenageMmbrCnt;
  string3 RaAYoungAdultMmbrCnt;
  string3 RaAMiddleAgeMmbrCnt;
  string3 RaASeniorMmbrCnt;
  string3 RaAElderlyMmbrCnt;
  string3 RaAHHCnt;
  string3 RaAMmbrCnt;
  string2 RaAMedIncomeRange;
  string3 RaACollegeAttendedMmbrCnt;
  string3 RaACollege2yrAttendedMmbrCnt;
  string3 RaACollege4yrAttendedMmbrCnt;
  string3 RaACollegeGradAttendedMmbrCnt;
  string3 RaACollegePrivateMmbrCnt;
  string3 RaACollegeTopTierMmbrCnt;
  string3 RaACollegeMidTierMmbrCnt;
  string3 RaACollegeLowTierMmbrCnt;
  string3 RaAPropCurrOwnerMmbrCnt;
  string7 RaAPropOwnerAVMHighest;
  string7 RaAPropOwnerAVMMed;
  string3 RaAPPCurrOwnerMmbrCnt;
  string3 RaAPPCurrOwnerAutoMmbrCnt;
  string3 RaAPPCurrOwnerMtrcycleMmbrCnt;
  string3 RaAPPCurrOwnerAircrftMmbrCnt;
  string3 RaAPPCurrOwnerWtrcrftMmbrCnt;
  string3 RaACrtRecMmbrCnt;
  string3 RaACrtRecMmbrCnt12Mo;
  string3 RaACrtRecFelonyMmbrCnt;
  string3 RaACrtRecFelonyMmbrCnt12Mo;
  string3 RaACrtRecMsdmeanMmbrCnt;
  string3 RaACrtRecMsdmeanMmbrCnt12Mo;
  string3 RaACrtRecEvictionMmbrCnt;
  string3 RaACrtRecEvictionMmbrCnt12Mo;
  string3 RaACrtRecLienJudgMmbrCnt;
  string3 RaACrtRecLienJudgMmbrCnt12Mo;
  string7 RaACrtRecLienJudgAmtMax;
  string3 RaACrtRecBkrptMmbrCnt36Mo;
  string3 RaAOccProfLicMmbrCnt;
  string3 RaAOccBusinessAssocMmbrCnt;
  string3 RaAInterestSportPersonMmbrCnt;
END;

// PROJECT THE OUTPUT INTO THE LAYOUT THAT BATCH NEEDS TO RETURN TO CUSTOMER
project_deduped := project(dedup_original_output, transform(batchout, self := left));


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
											
 reducedOutput := join(reducedInput, project_deduped, left.lexid=right.lexid, transform(batchout, self := right));  // reduce output if there is no Input record - don't ask
 reducedOutputListGen := join(reducedInput, dedup_original_output, left.lexid=right.lexid, transform(modified_batchoutflat_layout, self := right));  // reduce output if there is no Input record - don't ask

 NewLexidCount := count(project_deduped) - count(reducedOutput);
 
 Assert(count(reducedOutput) = count(reducedInput),'FAIL COUNTS', FAIL): FAILURE(FileServices.SendEmail(EmailList,'OneMain Step3 Input Output file counts do not match', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));	
											
 output(NewLexidCount, NAMED('NewLexidCount'));
 output(choosen(original_input, 10), NAMED('original_input'));
 Output(choosen(reducedOutput,10), NAMED('dedup_original_output'));
 output(count(reducedOutput), NAMED('count_dedup_original_output'));
 output(reducedOutput,, '~thor400::profilebooster::LN_Output_springleaf_layout_ProfBooster.csv', csv(heading(single), quote('"'), terminator('\r\n')), overwrite);
 
 output(count(reducedOutputListGen), NAMED('count_all_attributeFile'));
 output(reducedOutputListGen,, '~thor400::profilebooster::PB10ListGen_Attributes.csv', csv(heading(single), quote('"')), overwrite);
 output(reducedInput,, '~thor400::profilebooster::PB10ListGen_layout_PII.csv', csv(heading(single), quote('"'), terminator('\r\n')), overwrite);
											
 output(choosen(reducedInput, 10), NAMED('reduced_input'));
 output(count(reducedInput), NAMED('count_reduced_input'));
 // this has to be the exact name, needs CR/LF
 output(reducedInput,, '~thor400::profilebooster::LN_Output_springleaf_layout_PII.csv', csv(heading(single), quote('"'), terminator('\r\n')), overwrite);
 
 
 ded := count(dedup(sort(original_input, lexid), lexid));
 output(ded, named('count_dedup_input'));
 
 ded2 := count(dedup(sort(original_output_full, lexid), lexid));
 output(ded2, named('count_dedup_output'));
 
 t := table(original_output_full, {lexid, lexidcount := count(group)}, lexid); 
 output(t(lexidcount>1), named('count_output_with_lexid'));
 	
 
 desprayPath := AbsolutePath  + '/' +  'LN_Output_springleaf_layout_ProfBooster.csv';
 desprayPathPII := AbsolutePath +  '/' + 'LN_Output_springleaf_layout_PII.csv';

STD.File.DeSpray('~thor400::profilebooster::LN_Output_springleaf_layout_ProfBooster.csv', IPaddr, desprayPath): FAILURE(FileServices.SendEmail(EmailList,'OneMain Step3 Despray failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
STD.File.DeSpray('~thor400::profilebooster::LN_Output_springleaf_layout_PII.csv', IPaddr, desprayPathPII): FAILURE(FileServices.SendEmail(EmailList,'OneMain Step3 PII Despray failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));	
	

// email results of this bwr
	
	FileServices.SendEmail(EmailList, 'OneMain Step3 finished ' + WORKUNIT, 'Original Input count  ' + ded + '    Original Output count ' + ded2 +
																																			' Duplicate LexID count ' + count(t(lexidcount>1)) + '  Reduced Input count ' + count(reducedInput) + '   Output count ' + count(reducedOutput) + '   New LexID Output count ' + NewLexidCount):
	FAILURE(FileServices.SendEmail(EmailList,'OneMain Step3 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));



RETURN 'SUCCESSFUL';

END;