EXPORT Test_ProfileBooster_attribute_report (route,current_dt,previous_dt) := functionmacro

import Scoring_QA_New_Bins, scoring_project_pip, Scoring_Project_Macros;


file1_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.Profile_Booster_Capone_outfile + previous_dt, Scoring_Project_Macros.Global_Output_Layouts.ProfileBooster_layout,thor),(integer)acctno);
// file1_2:= dataset(route + scoring_project_pip.Output_Sample_Names.Profile_Booster_Capone_outfile + previous_dt, Scoring_QA_New_Bins.FP31505_0_Pii_layout,thor);



file2_2:= distribute(dataset(route + scoring_project_pip.Output_Sample_Names.Profile_Booster_Capone_outfile + current_dt, Scoring_Project_Macros.Global_Output_Layouts.ProfileBooster_layout,thor),(integer)acctno);
// file2_2:= dataset(route + scoring_project_pip.Output_Sample_Names.Profile_Booster_Capone_outfile + current_dt, Scoring_QA_New_Bins.FP31505_0_Pii_layout,thor);



file1 := file1_2(errorcode='');
file2 := file2_2(errorcode='');

  
	
aa1:=join(file1,file2,left.acctno=right.acctno,inner);
aa:=aa1(acctno<>'');

DS1:=join(file1,aa,left.acctno=right.acctno,inner);

DS2:=join(file2,aa,left.acctno=right.acctno,inner);

	  		                              
                              Missing_values:= JOIN(DS2,DS1,LEFT.acctno=RIGHT.acctno and LEFT.LexID!=RIGHT.LexID,local);
													
															
										
 								 
   pfc := count(ds1);
   cfc := count(ds2);
	 
   fcd :=cfc-pfc;
pf:=count(Missing_values);
cf:=count(Missing_values);

pd:=if(pfc!= 0 and cfc=0,1,cf/cfc);
abd:=abs(pd);
ppd:=if(pfc!= 0 and cfc=0,1,(cf/cfc)*100);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_AssetCurrOwner',ave1);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecBkrptCnt',ave2);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecBkrptCnt12Mo',ave3);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecBkrptTimeNewest',ave4);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecCnt',ave5);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecCnt12Mo',ave6);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecEvictionCnt',ave7);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecEvictionCnt12Mo',ave8);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecEvictionTimeNewest',ave9);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecFelonyCnt',ave10);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecFelonyCnt12Mo',ave11);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecFelonyTimeNewest',ave12);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecLienJudgAmtTtl',ave13);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecLienJudgCnt',ave14);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecLienJudgCnt12Mo',ave15);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecLienJudgTimeNewest',ave16);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecMsdmeanCnt',ave17);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecMsdmeanCnt12Mo',ave18);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecMsdmeanTimeNewest',ave19);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecSeverityIndex',ave20);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_CrtRecTimeNewest',ave21);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_DoNotMail',ave22);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCnt',ave23);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCollege2yrAttendedMmbrCnt',ave24);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCollege4yrAttendedMmbrCnt',ave25);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCollegeAttendedMmbrCnt',ave26);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCollegeGradAttendedMmbrCnt',ave27);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCollegePrivateMmbrCnt',ave28);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCollegeTierMmbrHighest',ave29);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecBkrptMmbrCnt',ave30);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecBkrptMmbrCnt12Mo',ave31);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecBkrptMmbrCnt24Mo',ave32);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecEvictionMmbrCnt',ave33);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecEvictionMmbrCnt12Mo',ave34);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecFelonyMmbrCnt',ave35);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecFelonyMmbrCnt12Mo',ave36);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecLienJudgAmtTtl',ave37);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecLienJudgMmbrCnt',ave38);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecLienJudgMmbrCnt12Mo',ave39);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecMmbrCnt',ave40);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecMmbrCnt12Mo',ave41);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecMsdmeanMmbrCnt',ave42);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHCrtRecMsdmeanMmbrCnt12Mo',ave43);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHElderlyMmbrCnt',ave44);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHEstimatedIncomeRange',ave45);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHInterestSportPersonMmbrCnt',ave46);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHMiddleAgeMmbrCnt',ave47);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHOccBusinessAssocMmbrCnt',ave48);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHOccProfLicMmbrCnt',ave49);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHPPCurrOwnedAircrftCnt',ave50);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHPPCurrOwnedAutoCnt',ave51);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHPPCurrOwnedCnt',ave52);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHPPCurrOwnedMtrcycleCnt',ave53);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHPPCurrOwnedWtrcrftCnt',ave54);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHPropCurrAVMHighest',ave55);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHPropCurrOwnedCnt',ave56);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHPropCurrOwnerMmbrCnt',ave57);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHSeniorMmbrCnt',ave58);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHTeenagerMmbrCnt',ave59);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_HHYoungAdultMmbrCnt',ave60);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_InterestSportPerson',ave61);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_LifeEvEconTrajectory',ave62);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_LifeEvEconTrajectoryIndex',ave63);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_LifeEvEverResidedCnt',ave64);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_LifeEvLastMoveTaxRatioDiff',ave65);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_LifeEvNameChange',ave66);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_LifeEvNameChangeCnt12Mo',ave67);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_LifeEvTimeFirstAssetPurchase',ave68);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_LifeEvTimeLastAssetPurchase',ave69);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_LifeEvTimeLastMove',ave70);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_OccBusinessAssociation',ave71);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_OccBusinessAssociationTime',ave72);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_OccBusinessTitleLeadership',ave73);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_OccProfLicense',ave74);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_OccProfLicenseCategory',ave75);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PPCurrOwnedAircrftCnt',ave76);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PPCurrOwnedAutoCnt',ave77);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PPCurrOwnedCnt',ave78);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PPCurrOwnedMtrcycleCnt',ave79);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PPCurrOwnedWtrcrftCnt',ave80);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PPCurrOwner',ave81);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PropCurrOwnedAVMTtl',ave82);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PropCurrOwnedAssessedTtl',ave83);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PropCurrOwnedCnt',ave84);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PropCurrOwner',ave85);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PropEverOwnedCnt',ave86);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PropEverSoldCnt',ave87);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PropPurchaseCnt12Mo',ave88);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PropSoldCnt12Mo',ave89);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PropSoldRatio',ave90);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_PropTimeLastSale',ave91);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectAge',ave92);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectBankingExperience',ave93);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectCollegeAttended',ave94);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectCollegeAttending',ave95);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectCollegePrivate',ave96);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectCollegeProgramType',ave97);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectCollegeTier',ave98);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectDeceased',ave99);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectEstimatedIncomeRange',ave100);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectGender',ave101);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectLastUpdate12Mo',ave102);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectMaritalStatus',ave103);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectTimeLastUpdate',ave104);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ProspectTimeOnRecord',ave105);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACollege2yrAttendedMmbrCnt',ave106);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACollege4yrAttendedMmbrCnt',ave107);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACollegeAttendedMmbrCnt',ave108);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACollegeGradAttendedMmbrCnt',ave109);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACollegeLowTierMmbrCnt',ave110);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACollegeMidTierMmbrCnt',ave111);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACollegePrivateMmbrCnt',ave112);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACollegeTopTierMmbrCnt',ave113);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecBkrptMmbrCnt36Mo',ave114);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecEvictionMmbrCnt',ave115);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecEvictionMmbrCnt12Mo',ave116);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecFelonyMmbrCnt',ave117);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecFelonyMmbrCnt12Mo',ave118);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecLienJudgAmtMax',ave119);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecLienJudgMmbrCnt',ave120);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecLienJudgMmbrCnt12Mo',ave121);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecMmbrCnt',ave122);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecMmbrCnt12Mo',ave123);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecMsdmeanMmbrCnt',ave124);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaACrtRecMsdmeanMmbrCnt12Mo',ave125);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAElderlyMmbrCnt',ave126);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAHHCnt',ave127);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAInterestSportPersonMmbrCnt',ave128);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAMedIncomeRange',ave129);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAMiddleAgeMmbrCnt',ave130);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAMmbrCnt',ave131);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAOccBusinessAssocMmbrCnt',ave132);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAOccProfLicMmbrCnt',ave133);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAPPCurrOwnerAircrftMmbrCnt',ave134);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAPPCurrOwnerAutoMmbrCnt',ave135);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAPPCurrOwnerMmbrCnt',ave136);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAPPCurrOwnerMtrcycleMmbrCnt',ave137);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAPPCurrOwnerWtrcrftMmbrCnt',ave138);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAPropCurrOwnerMmbrCnt',ave139);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAPropOwnerAVMHighest',ave140);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAPropOwnerAVMMed',ave141);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaASeniorMmbrCnt',ave142);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaATeenageMmbrCnt',ave143);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_RaAYoungAdultMmbrCnt',ave144);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrAVMBlockRatio',ave145);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrAVMCntyRatio',ave146);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrAVMRatioDiff12Mo',ave147);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrAVMRatioDiff60Mo',ave148);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrAVMTractRatio',ave149);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrAVMValue',ave150);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrAVMValue12Mo',ave151);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrAVMValue60Mo',ave152);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrBusinessCnt',ave153);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrDwellType',ave154);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrDwellTypeIndex',ave155);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrMortgageAmount',ave156);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrMortgageType',ave157);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResCurrOwnershipIndex',ave158);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputAVMBlockRatio',ave159);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputAVMCntyRatio',ave160);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputAVMRatioDiff12Mo',ave161);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputAVMRatioDiff60Mo',ave162);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputAVMTractRatio',ave163);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputAVMValue',ave164);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputAVMValue12Mo',ave165);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputAVMValue60Mo',ave166);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputBusinessCnt',ave167);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputDwellType',ave168);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputDwellTypeIndex',ave169);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputMortgageAmount',ave170);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputMortgageType',ave171);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_ResInputOwnershipIndex',ave172);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_VerifiedCurrResMatchIndex',ave173);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_VerifiedName',ave174);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_VerifiedPhone',ave175);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_VerifiedProspectFound',ave176);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func(DS2,'v1_VerifiedSSN',ave177);



average := ave1+ave2+ave3+ave4+ave5+ave6+ave7+ave8+ave9+ave10+ave11+ave12+ave13+ave14+ave15+ave16+ave17+ave18+ave19+ave20+ave21+ave22+ave23+ave24+ave25+ave26+ave27+ave28+ave29+ave30+ave31+ave32+ave33+ave34+ave35+ave36+ave37+ave38+ave39+ave40+ave41+ave42+ave43+ave44+ave45+ave46+ave47+ave48+ave49+ave50+ave51+ave52+ave53+ave54+ave55+ave56+ave57+ave58+ave59+ave60+ave61+ave62+ave63+ave64+ave65+ave66+ave67+ave68+ave69+ave70+ave71+ave72+ave73+ave74+ave75+ave76+ave77+ave78+ave79+ave80+ave81+ave82+ave83+ave84+ave85+ave86+ave87+ave88+ave89+ave90+ave91+ave92+ave93+ave94+ave95+ave96+ave97+ave98+ave99+ave100+ave101+ave102+ave103+ave104+ave105+ave106+ave107+ave108+ave109+ave110+ave111+ave112+ave113+ave114+ave115+ave116+ave117+ave118+ave119+ave120+ave121+ave122+ave123+ave124+ave125+ave126+ave127+ave128+ave129+ave130+ave131+ave132+ave133+ave134+ave135+ave136+ave137+ave138+ave139+ave140+ave141+ave142+ave143+ave144+ave145+ave146+ave147+ave148+ave149+ave150+ave151+ave152+ave153+ave154+ave155+ave156+ave157+ave158+ave159+ave160+ave161+ave162+ave163+ave164+ave165+ave166+ave167+ave168+ave169+ave170+ave171+ave172+ave173+ave174+ave175+ave176+ave177;
Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_AssetCurrOwner',ave2_1);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecBkrptCnt',ave2_2);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecBkrptCnt12Mo',ave2_3);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecBkrptTimeNewest',ave2_4);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecCnt',ave2_5);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecCnt12Mo',ave2_6);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecEvictionCnt',ave2_7);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecEvictionCnt12Mo',ave2_8);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecEvictionTimeNewest',ave2_9);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecFelonyCnt',ave2_10);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecFelonyCnt12Mo',ave2_11);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecFelonyTimeNewest',ave2_12);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecLienJudgAmtTtl',ave2_13);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecLienJudgCnt',ave2_14);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecLienJudgCnt12Mo',ave2_15);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecLienJudgTimeNewest',ave2_16);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecMsdmeanCnt',ave2_17);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecMsdmeanCnt12Mo',ave2_18);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecMsdmeanTimeNewest',ave2_19);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecSeverityIndex',ave2_20);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_CrtRecTimeNewest',ave2_21);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_DoNotMail',ave2_22);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCnt',ave2_23);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCollege2yrAttendedMmbrCnt',ave2_24);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCollege4yrAttendedMmbrCnt',ave2_25);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCollegeAttendedMmbrCnt',ave2_26);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCollegeGradAttendedMmbrCnt',ave2_27);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCollegePrivateMmbrCnt',ave2_28);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCollegeTierMmbrHighest',ave2_29);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecBkrptMmbrCnt',ave2_30);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecBkrptMmbrCnt12Mo',ave2_31);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecBkrptMmbrCnt24Mo',ave2_32);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecEvictionMmbrCnt',ave2_33);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecEvictionMmbrCnt12Mo',ave2_34);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecFelonyMmbrCnt',ave2_35);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecFelonyMmbrCnt12Mo',ave2_36);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecLienJudgAmtTtl',ave2_37);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecLienJudgMmbrCnt',ave2_38);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecLienJudgMmbrCnt12Mo',ave2_39);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecMmbrCnt',ave2_40);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecMmbrCnt12Mo',ave2_41);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecMsdmeanMmbrCnt',ave2_42);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHCrtRecMsdmeanMmbrCnt12Mo',ave2_43);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHElderlyMmbrCnt',ave2_44);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHEstimatedIncomeRange',ave2_45);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHInterestSportPersonMmbrCnt',ave2_46);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHMiddleAgeMmbrCnt',ave2_47);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHOccBusinessAssocMmbrCnt',ave2_48);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHOccProfLicMmbrCnt',ave2_49);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHPPCurrOwnedAircrftCnt',ave2_50);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHPPCurrOwnedAutoCnt',ave2_51);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHPPCurrOwnedCnt',ave2_52);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHPPCurrOwnedMtrcycleCnt',ave2_53);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHPPCurrOwnedWtrcrftCnt',ave2_54);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHPropCurrAVMHighest',ave2_55);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHPropCurrOwnedCnt',ave2_56);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHPropCurrOwnerMmbrCnt',ave2_57);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHSeniorMmbrCnt',ave2_58);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHTeenagerMmbrCnt',ave2_59);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_HHYoungAdultMmbrCnt',ave2_60);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_InterestSportPerson',ave2_61);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_LifeEvEconTrajectory',ave2_62);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_LifeEvEconTrajectoryIndex',ave2_63);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_LifeEvEverResidedCnt',ave2_64);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_LifeEvLastMoveTaxRatioDiff',ave2_65);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_LifeEvNameChange',ave2_66);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_LifeEvNameChangeCnt12Mo',ave2_67);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_LifeEvTimeFirstAssetPurchase',ave2_68);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_LifeEvTimeLastAssetPurchase',ave2_69);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_LifeEvTimeLastMove',ave2_70);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_OccBusinessAssociation',ave2_71);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_OccBusinessAssociationTime',ave2_72);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_OccBusinessTitleLeadership',ave2_73);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_OccProfLicense',ave2_74);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_OccProfLicenseCategory',ave2_75);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PPCurrOwnedAircrftCnt',ave2_76);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PPCurrOwnedAutoCnt',ave2_77);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PPCurrOwnedCnt',ave2_78);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PPCurrOwnedMtrcycleCnt',ave2_79);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PPCurrOwnedWtrcrftCnt',ave2_80);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PPCurrOwner',ave2_81);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PropCurrOwnedAVMTtl',ave2_82);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PropCurrOwnedAssessedTtl',ave2_83);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PropCurrOwnedCnt',ave2_84);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PropCurrOwner',ave2_85);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PropEverOwnedCnt',ave2_86);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PropEverSoldCnt',ave2_87);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PropPurchaseCnt12Mo',ave2_88);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PropSoldCnt12Mo',ave2_89);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PropSoldRatio',ave2_90);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_PropTimeLastSale',ave2_91);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectAge',ave2_92);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectBankingExperience',ave2_93);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectCollegeAttended',ave2_94);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectCollegeAttending',ave2_95);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectCollegePrivate',ave2_96);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectCollegeProgramType',ave2_97);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectCollegeTier',ave2_98);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectDeceased',ave2_99);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectEstimatedIncomeRange',ave2_100);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectGender',ave2_101);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectLastUpdate12Mo',ave2_102);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectMaritalStatus',ave2_103);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectTimeLastUpdate',ave2_104);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ProspectTimeOnRecord',ave2_105);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACollege2yrAttendedMmbrCnt',ave2_106);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACollege4yrAttendedMmbrCnt',ave2_107);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACollegeAttendedMmbrCnt',ave2_108);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACollegeGradAttendedMmbrCnt',ave2_109);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACollegeLowTierMmbrCnt',ave2_110);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACollegeMidTierMmbrCnt',ave2_111);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACollegePrivateMmbrCnt',ave2_112);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACollegeTopTierMmbrCnt',ave2_113);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecBkrptMmbrCnt36Mo',ave2_114);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecEvictionMmbrCnt',ave2_115);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecEvictionMmbrCnt12Mo',ave2_116);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecFelonyMmbrCnt',ave2_117);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecFelonyMmbrCnt12Mo',ave2_118);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecLienJudgAmtMax',ave2_119);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecLienJudgMmbrCnt',ave2_120);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecLienJudgMmbrCnt12Mo',ave2_121);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecMmbrCnt',ave2_122);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecMmbrCnt12Mo',ave2_123);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecMsdmeanMmbrCnt',ave2_124);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaACrtRecMsdmeanMmbrCnt12Mo',ave2_125);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAElderlyMmbrCnt',ave2_126);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAHHCnt',ave2_127);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAInterestSportPersonMmbrCnt',ave2_128);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAMedIncomeRange',ave2_129);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAMiddleAgeMmbrCnt',ave2_130);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAMmbrCnt',ave2_131);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAOccBusinessAssocMmbrCnt',ave2_132);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAOccProfLicMmbrCnt',ave2_133);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAPPCurrOwnerAircrftMmbrCnt',ave2_134);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAPPCurrOwnerAutoMmbrCnt',ave2_135);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAPPCurrOwnerMmbrCnt',ave2_136);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAPPCurrOwnerMtrcycleMmbrCnt',ave2_137);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAPPCurrOwnerWtrcrftMmbrCnt',ave2_138);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAPropCurrOwnerMmbrCnt',ave2_139);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAPropOwnerAVMHighest',ave2_140);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAPropOwnerAVMMed',ave2_141);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaASeniorMmbrCnt',ave2_142);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaATeenageMmbrCnt',ave2_143);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_RaAYoungAdultMmbrCnt',ave2_144);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrAVMBlockRatio',ave2_145);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrAVMCntyRatio',ave2_146);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrAVMRatioDiff12Mo',ave2_147);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrAVMRatioDiff60Mo',ave2_148);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrAVMTractRatio',ave2_149);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrAVMValue',ave2_150);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrAVMValue12Mo',ave2_151);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrAVMValue60Mo',ave2_152);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrBusinessCnt',ave2_153);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrDwellType',ave2_154);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrDwellTypeIndex',ave2_155);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrMortgageAmount',ave2_156);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrMortgageType',ave2_157);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResCurrOwnershipIndex',ave2_158);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputAVMBlockRatio',ave2_159);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputAVMCntyRatio',ave2_160);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputAVMRatioDiff12Mo',ave2_161);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputAVMRatioDiff60Mo',ave2_162);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputAVMTractRatio',ave2_163);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputAVMValue',ave2_164);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputAVMValue12Mo',ave2_165);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputAVMValue60Mo',ave2_166);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputBusinessCnt',ave2_167);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputDwellType',ave2_168);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputDwellTypeIndex',ave2_169);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputMortgageAmount',ave2_170);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputMortgageType',ave2_171);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_ResInputOwnershipIndex',ave2_172);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_VerifiedCurrResMatchIndex',ave2_173);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_VerifiedName',ave2_174);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_VerifiedPhone',ave2_175);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_VerifiedProspectFound',ave2_176);

Scoring_QA_New_Bins.test_bss_new_bins.Average_func2(DS2,'v1_VerifiedSSN',ave2_177);

average2 := ave2_1+ave2_2+ave2_3+ave2_4+ave2_5+ave2_6+ave2_7+ave2_8+ave2_9+ave2_10+ave2_11+ave2_12+ave2_13+ave2_14+ave2_15+ave2_16+ave2_17+ave2_18+ave2_19+ave2_20+ave2_21+ave2_22+ave2_23+ave2_24+ave2_25+ave2_26+ave2_27+ave2_28+ave2_29+ave2_30+ave2_31+ave2_32+ave2_33+ave2_34+ave2_35+ave2_36+ave2_37+ave2_38+ave2_39+ave2_40+ave2_41+ave2_42+ave2_43+ave2_44+ave2_45+ave2_46+ave2_47+ave2_48+ave2_49+ave2_50+ave2_51+ave2_52+ave2_53+ave2_54+ave2_55+ave2_56+ave2_57+ave2_58+ave2_59+ave2_60+ave2_61+ave2_62+ave2_63+ave2_64+ave2_65+ave2_66+ave2_67+ave2_68+ave2_69+ave2_70+ave2_71+ave2_72+ave2_73+ave2_74+ave2_75+ave2_76+ave2_77+ave2_78+ave2_79+ave2_80+ave2_81+ave2_82+ave2_83+ave2_84+ave2_85+ave2_86+ave2_87+ave2_88+ave2_89+ave2_90+ave2_91+ave2_92+ave2_93+ave2_94+ave2_95+ave2_96+ave2_97+ave2_98+ave2_99+ave2_100+ave2_101+ave2_102+ave2_103+ave2_104+ave2_105+ave2_106+ave2_107+ave2_108+ave2_109+ave2_110+ave2_111+ave2_112+ave2_113+ave2_114+ave2_115+ave2_116+ave2_117+ave2_118+ave2_119+ave2_120+ave2_121+ave2_122+ave2_123+ave2_124+ave2_125+ave2_126+ave2_127+ave2_128+ave2_129+ave2_130+ave2_131+ave2_132+ave2_133+ave2_134+ave2_135+ave2_136+ave2_137+ave2_138+ave2_139+ave2_140+ave2_141+ave2_142+ave2_143+ave2_144+ave2_145+ave2_146+ave2_147+ave2_148+ave2_149+ave2_150+ave2_151+ave2_152+ave2_153+ave2_154+ave2_155+ave2_156+ave2_157+ave2_158+ave2_159+ave2_160+ave2_161+ave2_162+ave2_163+ave2_164+ave2_165+ave2_166+ave2_167+ave2_168+ave2_169+ave2_170+ave2_171+ave2_172+ave2_173+ave2_174+ave2_175+ave2_176+ave2_177;

Scoring_QA_New_Bins.test_bss_new_bins.range_function_1(DS2,'v1_AssetCurrOwner',range1);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_2(DS2,'v1_CrtRecBkrptCnt',range2);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_3(DS2,'v1_CrtRecBkrptCnt12Mo',range3);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_4(DS2,'v1_CrtRecBkrptTimeNewest',range4);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_5(DS2,'v1_CrtRecCnt',range5);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_6(DS2,'v1_CrtRecCnt12Mo',range6);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_7(DS2,'v1_CrtRecEvictionCnt',range7);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_8(DS2,'v1_CrtRecEvictionCnt12Mo',range8);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_9(DS2,'v1_CrtRecEvictionTimeNewest',range9);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_10(DS2,'v1_CrtRecFelonyCnt',range10);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_11(DS2,'v1_CrtRecFelonyCnt12Mo',range11);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_12(DS2,'v1_CrtRecFelonyTimeNewest',range12);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_13(DS2,'v1_CrtRecLienJudgAmtTtl',range13);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_14(DS2,'v1_CrtRecLienJudgCnt',range14);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_15(DS2,'v1_CrtRecLienJudgCnt12Mo',range15);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_16(DS2,'v1_CrtRecLienJudgTimeNewest',range16);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_17(DS2,'v1_CrtRecMsdmeanCnt',range17);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_18(DS2,'v1_CrtRecMsdmeanCnt12Mo',range18);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_19(DS2,'v1_CrtRecMsdmeanTimeNewest',range19);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_20(DS2,'v1_CrtRecSeverityIndex',range20);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_21(DS2,'v1_CrtRecTimeNewest',range21);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_22(DS2,'v1_DoNotMail',range22);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_23(DS2,'v1_HHCnt',range23);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_24(DS2,'v1_HHCollege2yrAttendedMmbrCnt',range24);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_25(DS2,'v1_HHCollege4yrAttendedMmbrCnt',range25);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_26(DS2,'v1_HHCollegeAttendedMmbrCnt',range26);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_27(DS2,'v1_HHCollegeGradAttendedMmbrCnt',range27);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_28(DS2,'v1_HHCollegePrivateMmbrCnt',range28);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_29(DS2,'v1_HHCollegeTierMmbrHighest',range29);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_30(DS2,'v1_HHCrtRecBkrptMmbrCnt',range30);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_31(DS2,'v1_HHCrtRecBkrptMmbrCnt12Mo',range31);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_32(DS2,'v1_HHCrtRecBkrptMmbrCnt24Mo',range32);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_33(DS2,'v1_HHCrtRecEvictionMmbrCnt',range33);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_34(DS2,'v1_HHCrtRecEvictionMmbrCnt12Mo',range34);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_35(DS2,'v1_HHCrtRecFelonyMmbrCnt',range35);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_36(DS2,'v1_HHCrtRecFelonyMmbrCnt12Mo',range36);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_37(DS2,'v1_HHCrtRecLienJudgAmtTtl',range37);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_38(DS2,'v1_HHCrtRecLienJudgMmbrCnt',range38);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_39(DS2,'v1_HHCrtRecLienJudgMmbrCnt12Mo',range39);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_40(DS2,'v1_HHCrtRecMmbrCnt',range40);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_41(DS2,'v1_HHCrtRecMmbrCnt12Mo',range41);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_42(DS2,'v1_HHCrtRecMsdmeanMmbrCnt',range42);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_43(DS2,'v1_HHCrtRecMsdmeanMmbrCnt12Mo',range43);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_44(DS2,'v1_HHElderlyMmbrCnt',range44);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_45(DS2,'v1_HHEstimatedIncomeRange',range45);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_46(DS2,'v1_HHInterestSportPersonMmbrCnt',range46);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_47(DS2,'v1_HHMiddleAgeMmbrCnt',range47);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_48(DS2,'v1_HHOccBusinessAssocMmbrCnt',range48);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_49(DS2,'v1_HHOccProfLicMmbrCnt',range49);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_50(DS2,'v1_HHPPCurrOwnedAircrftCnt',range50);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_51(DS2,'v1_HHPPCurrOwnedAutoCnt',range51);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_52(DS2,'v1_HHPPCurrOwnedCnt',range52);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_53(DS2,'v1_HHPPCurrOwnedMtrcycleCnt',range53);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_54(DS2,'v1_HHPPCurrOwnedWtrcrftCnt',range54);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_55(DS2,'v1_HHPropCurrAVMHighest',range55);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_56(DS2,'v1_HHPropCurrOwnedCnt',range56);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_57(DS2,'v1_HHPropCurrOwnerMmbrCnt',range57);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_58(DS2,'v1_HHSeniorMmbrCnt',range58);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_59(DS2,'v1_HHTeenagerMmbrCnt',range59);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_60(DS2,'v1_HHYoungAdultMmbrCnt',range60);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_61(DS2,'v1_InterestSportPerson',range61);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_62(DS2,'v1_LifeEvEconTrajectory',range62);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_63(DS2,'v1_LifeEvEconTrajectoryIndex',range63);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_64(DS2,'v1_LifeEvEverResidedCnt',range64);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_65(DS2,'v1_LifeEvLastMoveTaxRatioDiff',range65);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_66(DS2,'v1_LifeEvNameChange',range66);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_67(DS2,'v1_LifeEvNameChangeCnt12Mo',range67);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_68(DS2,'v1_LifeEvTimeFirstAssetPurchase',range68);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_69(DS2,'v1_LifeEvTimeLastAssetPurchase',range69);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_70(DS2,'v1_LifeEvTimeLastMove',range70);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_71(DS2,'v1_OccBusinessAssociation',range71);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_72(DS2,'v1_OccBusinessAssociationTime',range72);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_73(DS2,'v1_OccBusinessTitleLeadership',range73);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_74(DS2,'v1_OccProfLicense',range74);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_75(DS2,'v1_OccProfLicenseCategory',range75);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_76(DS2,'v1_PPCurrOwnedAircrftCnt',range76);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_77(DS2,'v1_PPCurrOwnedAutoCnt',range77);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_78(DS2,'v1_PPCurrOwnedCnt',range78);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_79(DS2,'v1_PPCurrOwnedMtrcycleCnt',range79);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_80(DS2,'v1_PPCurrOwnedWtrcrftCnt',range80);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_81(DS2,'v1_PPCurrOwner',range81);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_82(DS2,'v1_PropCurrOwnedAVMTtl',range82);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_83(DS2,'v1_PropCurrOwnedAssessedTtl',range83);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_84(DS2,'v1_PropCurrOwnedCnt',range84);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_85(DS2,'v1_PropCurrOwner',range85);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_86(DS2,'v1_PropEverOwnedCnt',range86);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_87(DS2,'v1_PropEverSoldCnt',range87);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_88(DS2,'v1_PropPurchaseCnt12Mo',range88);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_89(DS2,'v1_PropSoldCnt12Mo',range89);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_90(DS2,'v1_PropSoldRatio',range90);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_91(DS2,'v1_PropTimeLastSale',range91);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_92(DS2,'v1_ProspectAge',range92);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_93(DS2,'v1_ProspectBankingExperience',range93);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_94(DS2,'v1_ProspectCollegeAttended',range94);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_95(DS2,'v1_ProspectCollegeAttending',range95);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_96(DS2,'v1_ProspectCollegePrivate',range96);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_97(DS2,'v1_ProspectCollegeProgramType',range97);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_98(DS2,'v1_ProspectCollegeTier',range98);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_99(DS2,'v1_ProspectDeceased',range99);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_100(DS2,'v1_ProspectEstimatedIncomeRange',range100);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_101(DS2,'v1_ProspectLastUpdate12Mo',range101);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_102(DS2,'v1_ProspectTimeLastUpdate',range102);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_103(DS2,'v1_ProspectTimeOnRecord',range103);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_104(DS2,'v1_RaACollege2yrAttendedMmbrCnt',range104);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_105(DS2,'v1_RaACollege4yrAttendedMmbrCnt',range105);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_106(DS2,'v1_RaACollegeAttendedMmbrCnt',range106);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_107(DS2,'v1_RaACollegeGradAttendedMmbrCnt',range107);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_108(DS2,'v1_RaACollegeLowTierMmbrCnt',range108);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_109(DS2,'v1_RaACollegeMidTierMmbrCnt',range109);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_110(DS2,'v1_RaACollegePrivateMmbrCnt',range110);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_111(DS2,'v1_RaACollegeTopTierMmbrCnt',range111);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_112(DS2,'v1_RaACrtRecBkrptMmbrCnt36Mo',range112);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_113(DS2,'v1_RaACrtRecEvictionMmbrCnt',range113);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_114(DS2,'v1_RaACrtRecEvictionMmbrCnt12Mo',range114);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_115(DS2,'v1_RaACrtRecFelonyMmbrCnt',range115);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_116(DS2,'v1_RaACrtRecFelonyMmbrCnt12Mo',range116);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_117(DS2,'v1_RaACrtRecLienJudgAmtMax',range117);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_118(DS2,'v1_RaACrtRecLienJudgMmbrCnt',range118);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_119(DS2,'v1_RaACrtRecLienJudgMmbrCnt12Mo',range119);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_120(DS2,'v1_RaACrtRecMmbrCnt',range120);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_121(DS2,'v1_RaACrtRecMmbrCnt12Mo',range121);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_122(DS2,'v1_RaACrtRecMsdmeanMmbrCnt',range122);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_123(DS2,'v1_RaACrtRecMsdmeanMmbrCnt12Mo',range123);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_124(DS2,'v1_RaAElderlyMmbrCnt',range124);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_125(DS2,'v1_RaAHHCnt',range125);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_126(DS2,'v1_RaAInterestSportPersonMmbrCnt',range126);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_127(DS2,'v1_RaAMedIncomeRange',range127);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_128(DS2,'v1_RaAMiddleAgeMmbrCnt',range128);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_129(DS2,'v1_RaAMmbrCnt',range129);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_130(DS2,'v1_RaAOccBusinessAssocMmbrCnt',range130);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_131(DS2,'v1_RaAOccProfLicMmbrCnt',range131);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_132(DS2,'v1_RaAPPCurrOwnerAircrftMmbrCnt',range132);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_133(DS2,'v1_RaAPPCurrOwnerAutoMmbrCnt',range133);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_134(DS2,'v1_RaAPPCurrOwnerMmbrCnt',range134);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_135(DS2,'v1_RaAPPCurrOwnerMtrcycleMmbrCnt',range135);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_136(DS2,'v1_RaAPPCurrOwnerWtrcrftMmbrCnt',range136);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_137(DS2,'v1_RaAPropCurrOwnerMmbrCnt',range137);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_138(DS2,'v1_RaAPropOwnerAVMHighest',range138);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_139(DS2,'v1_RaAPropOwnerAVMMed',range139);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_140(DS2,'v1_RaASeniorMmbrCnt',range140);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_141(DS2,'v1_RaATeenageMmbrCnt',range141);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_142(DS2,'v1_RaAYoungAdultMmbrCnt',range142);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_143(DS2,'v1_ResCurrAVMBlockRatio',range143);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_144(DS2,'v1_ResCurrAVMCntyRatio',range144);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_145(DS2,'v1_ResCurrAVMRatioDiff12Mo',range145);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_146(DS2,'v1_ResCurrAVMRatioDiff60Mo',range146);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_147(DS2,'v1_ResCurrAVMTractRatio',range147);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_148(DS2,'v1_ResCurrAVMValue',range148);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_149(DS2,'v1_ResCurrAVMValue12Mo',range149);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_150(DS2,'v1_ResCurrAVMValue60Mo',range150);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_151(DS2,'v1_ResCurrBusinessCnt',range151);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_152(DS2,'v1_ResCurrDwellTypeIndex',range152);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_153(DS2,'v1_ResCurrMortgageAmount',range153);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_154(DS2,'v1_ResCurrMortgageType',range154);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_155(DS2,'v1_ResCurrOwnershipIndex',range155);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_156(DS2,'v1_ResInputAVMBlockRatio',range156);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_157(DS2,'v1_ResInputAVMCntyRatio',range157);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_158(DS2,'v1_ResInputAVMRatioDiff12Mo',range158);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_159(DS2,'v1_ResInputAVMRatioDiff60Mo',range159);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_160(DS2,'v1_ResInputAVMTractRatio',range160);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_161(DS2,'v1_ResInputAVMValue',range161);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_162(DS2,'v1_ResInputAVMValue12Mo',range162);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_163(DS2,'v1_ResInputAVMValue60Mo',range163);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_164(DS2,'v1_ResInputBusinessCnt',range164);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_165(DS2,'v1_ResInputDwellTypeIndex',range165);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_166(DS2,'v1_ResInputMortgageAmount',range166);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_167(DS2,'v1_ResInputMortgageType',range167);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_168(DS2,'v1_ResInputOwnershipIndex',range168);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_169(DS2,'v1_VerifiedCurrResMatchIndex',range169);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_170(DS2,'v1_VerifiedName',range170);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_171(DS2,'v1_VerifiedPhone',range171);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_172(DS2,'v1_VerifiedProspectFound',range172);

Scoring_QA_New_Bins.test_bss_new_bins.range_function_173(DS2,'v1_VerifiedSSN',range173);


Scoring_QA_New_Bins.test_bss_new_bins.Distinct_function(DS2, 'v1_ProspectGender',range174);
Scoring_QA_New_Bins.test_bss_new_bins.Distinct_function(DS2, 'v1_ResInputDwellType',range175);
Scoring_QA_New_Bins.test_bss_new_bins.Distinct_function(DS2, 'v1_ResCurrDwellType',range176);
Scoring_QA_New_Bins.test_bss_new_bins.Distinct_function(DS2, 'v1_ProspectMaritalStatus',range177);


Scoring_QA_New_Bins.test_bss_new_bins.Distinct_function2(DS2, 'v1_PPCurrOwnedAutoVIN',range178);
Scoring_QA_New_Bins.test_bss_new_bins.Distinct_function2(DS2, 'v1_PPCurrOwnedAutoYear',range179);
Scoring_QA_New_Bins.test_bss_new_bins.Distinct_function2(DS2, 'v1_PPCurrOwnedAutoMake',range180);
Scoring_QA_New_Bins.test_bss_new_bins.Distinct_function2(DS2, 'v1_PPCurrOwnedAutoModel',range181);
Scoring_QA_New_Bins.test_bss_new_bins.Distinct_function2(DS2, 'v1_PPCurrOwnedAutoSeries',range182);
Scoring_QA_New_Bins.test_bss_new_bins.Distinct_function2(DS2, 'v1_PPCurrOwnedAutoType',range183);




	 result2_stats := range1+range2+range3+range4+range5+range6+range7+range8+range9+range10+range11+range12+range13+range14+range15+range16+range17+range18+range19+range20+range21+range22+range23+range24+range25+range26+range27+range28+range29+range30+range31+range32+range33+range34+range35+range36+range37+range38+range39+range40+range41+range42+range43+range44+range45+range46+range47+range48+range49+range50+range51+range52+range53+range54+range55+range56+range57+range58+range59+range60+range61+range62+range63+range64+range65+range66+range67+range68+range69+range70+range71+range72+range73+range74+range75+range76+range77+range78+range79+range80+range81+range82+range83+range84+range85+range86+range87+range88+range89+range90+range91+range92+range93+range94+range95+range96+range97+range98+range99+range100+range101+range102+range103+range104+range105+range106+range107+range108+range109+range110+range111+range112+range113+range114+range115+range116+range117+range118+range119+range120+range121+range122+range123+range124+range125+range126+range127+range128+range129+range130+range131+range132+range133+range134+range135+range136+range137+range138+range139+range140+range141+range142+range143+range144+range145+range146+range147+range148+range149+range150+range151+range152+range153+range154+range155+range156+range157+range158+range159+range160+range161+range162+range163+range164+range165+range166+range167+range168+range169+range170+range171+range172+range173+range174+range175+range176+range177+range178+range179+range180+range181+range182+range183;



result4_stats:=average+average2;
	 
	 

	 
	  compare_layout_stats := RECORD
		  string file_version;
			string mode;
      string field_name;
      string distribution_type;		
      STRING50 attribute_value; 
			decimal20_4 Count1;
      decimal20_4 file_count;
      decimal20_4 ds_count;

     						
    END;
		
		
		compare_layout_stats func(result4_stats l):=transform
                                         self.file_version:='ProflieBooster_CapOne_v1';
																				 self.mode:='batch';
																				 self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 self:=l;
		
		end;
		
		result4_stats_project:= project(result4_stats,func(left));		
     	

compare_layout_stats func1(result2_stats l):=transform
                                         self.file_version:='ProflieBooster_CapOne_v1';
																				 self.mode:='batch';
																			   self.file_count:=count(file2),
																				 self.ds_count:=count(ds2),
																				 
																				 self:=l;
		
		end;
		
		result2_stats_project:= project(result2_stats,func1(left));


			compare_layout := RECORD
            		  string file_version;
            			string mode;
                  string field_name;
                  string distribution_type;
            			decimal20_4 p_file_count;
                  decimal20_4 c_file_count;
                  decimal20_4 file_count_diff;
									decimal20_4 matched_file_count;
                  STRING50 attribute_value; 
                  decimal20_4 p_frequency;
                  decimal20_4 c_frequency;
                  decimal20_4 frequency_diff;
            			decimal20_4 perc_frequency_diff;
               	  decimal20_4 p_proportion;
                  decimal20_4 c_proportion;
                  decimal20_4 proportion_diff;
            			decimal20_4 abs_proportion_diff;
            			decimal20_4 perc_proportion_diff;
            			decimal20_4 PSI;
            								
                        END;	

		  did_results := DATASET([{'ProflieBooster_CapOne_v1','batch','did','<DID not equal>',count(file1),count(file2),count(file2)-count(file1),pfc,'<DID not equal>',pf,cf,'','','','',pd,abd,ppd,0}
	                    ], compare_layout);
   	
											
				
   
		
		FileNameNewLogical:='~ScoringQA::bss::stats::'+ scoring_project_pip.Output_Sample_Names.Profile_Booster_Capone_outfile[2..] + current_dt;
		
		FileNameNewLogical1:='~ScoringQA::bss::averages::'+ scoring_project_pip.Output_Sample_Names.Profile_Booster_Capone_outfile[2..] + current_dt;
		
		FileNameNewLogical2:='~ScoringQA::bss::dids::'+ scoring_project_pip.Output_Sample_Names.Profile_Booster_Capone_outfile[2..] + current_dt;
		
	SaveNewFile := output(result2_stats_project,,FileNameNewLogical,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 	 
	 SaveNewFile1 :=output(result4_stats_project,,FileNameNewLogical1,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 SaveNewFile2 :=output(did_results,,FileNameNewLogical2,CSV(HEADING(single), QUOTE('"')),overwrite,EXPIRE(10));
	 
	 res:=FileServices.AddSuperFile( '~ScoringQA::bss::stats::' + current_dt , FileNameNewLogical)	;					
		
	 res1:=FileServices.AddSuperFile( '~ScoringQA::bss::averages::' +current_dt , FileNameNewLogical1)	;		
	 
	 res2:=FileServices.AddSuperFile( '~ScoringQA::bss::dids::' +current_dt , FileNameNewLogical2)	;	
						
	 
seq:=sequential(SaveNewFile,SaveNewFile1,SaveNewFile2,res,res1,res2);

return seq;

endmacro;
