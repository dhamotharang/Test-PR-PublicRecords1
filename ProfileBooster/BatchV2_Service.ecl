IMPORT ProfileBooster, iesp, Risk_indicators, Riskwise, address, AutoStandardI, std, ut;

EXPORT BatchV2_Service() := FUNCTION

  batch_in  := dataset( [], ProfileBooster.V2_Layouts.Layout_PB2_In ) : stored('batch_in');
	string5 	IndustryClassVal 					:= '' : stored('IndustryClass');
	string50 	DataRestrictionTemp				:= AutoStandardI.GlobalModule().DataRestrictionMask;
	// Check to see if the default from GlobalModule() is used, if so overwrite it to our default data restriction.  Our default doesn't include spaces.
	STRING50 	DataRestriction						:= IF(DataRestrictionTemp = '1    0', Risk_Indicators.iid_constants.default_DataRestriction, DataRestrictionTemp);
	string50 	DataPermission 						:= risk_indicators.iid_constants.default_DataPermission  : stored('DataPermissionMask');
	string20  AttributesVersionRequest	:= ''  : stored('AttributesVersionRequest'); 
	string50 	Custom_Model 						  := ''  : stored('Custom_Model');

  BOOLEAN DEBUG := False;
	
	PB_wseq := project( batch_in, transform( ProfileBooster.V2_Layouts.Layout_PB2_In, 
																	self.seq := counter; 
                                  
																	cleaned_name := address.CleanPerson73(left.Name_Full);
																	boolean valid_cleaned := left.Name_Full <> '';
																	
																	self.Name_First  := stringlib.stringtouppercase(if(left.Name_First='' AND valid_cleaned, cleaned_name[6..25], left.Name_First));
																	self.Name_Last 	 := stringlib.stringtouppercase(if(left.Name_Last='' AND valid_cleaned, cleaned_name[46..65], left.Name_Last));
																	self.Name_Middle := stringlib.stringtouppercase(if(left.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], left.Name_Middle));
																	self.Name_Suffix := stringlib.stringtouppercase(if(left.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], left.Name_Suffix));	
																	self.Name_Title  := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[1..5],''));
                              
																	street_address := risk_indicators.MOD_AddressClean.street_address(left.street_addr, left.streetnumber, left.streetpredirection, left.streetname, left.streetsuffix, left.streetpostdirection, left.unitdesignation, left.unitnumber);
																	self.street_addr := street_address;
                                  
																	self := left ) );
  
  setvalidmodels :=['PBM1803_0','PB1708_1'];
  custommodel_in := TRIM(std.str.touppercase(Custom_Model),ALL);
  domodel := custommodel_in IN setvalidmodels;
  
  
  attributes := ProfileBooster.V2_Search_Function(PB_wseq, DataRestriction, DataPermission, AttributesVersionRequest,domodel,custommodel_in);  

#IF(DEBUG)

  final := attributes;
  
#ELSE
	ProfileBooster.V2_Layouts.Layout_PB2_BatchOutFlat addAcct(attributes le, PB_wSeq ri) := transform
		self.AcctNo 																	:= ri.AcctNo;
		self.seq																			:= le.seq;
		self.LexID 																		:= le.LexID;
		
		self.VerDoNotMailFlag := le.attributes.version2.VerDoNotMailFlag;
		self.VerProspectFoundFlag := le.attributes.version2.VerProspectFoundFlag;
		self.VerInpNameIndx := le.attributes.version2.VerInpNameIndx;
		self.VerInpSSNFlag := le.attributes.version2.VerInpSSNFlag;
		self.VerInpPhoneFlag := le.attributes.version2.VerInpPhoneFlag;
		self.VerInpAddrMatchIndx := le.attributes.version2.VerInpAddrMatchIndx;
		self.VerInpEmailFlag := le.attributes.version2.VerInpEmailFlag;

		self.DemUpdtOldMsnc := le.attributes.version2.DemUpdtOldMsnc;
		self.DemUpdtNewMsnc := le.attributes.version2.DemUpdtNewMsnc;
		self.DemUpdtFlag1Y := le.attributes.version2.DemUpdtFlag1Y;
		self.DemAge := le.attributes.version2.DemAge;
		self.DemGender := le.attributes.version2.DemGender;
		self.DemIsMarriedFlag := le.attributes.version2.DemIsMarriedFlag;
		self.DemEstInc := le.attributes.version2.DemEstInc;
		self.DemDeceasedFlag := le.attributes.version2.DemDeceasedFlag;
		self.DemEduCollCurrFlag := le.attributes.version2.DemEduCollCurrFlag;
		self.DemEduCollFlagEv := le.attributes.version2.DemEduCollFlagEv;
		// self.DemEduCollNewPrgmIndx := le.attributes.version2.DemEduCollNewPrgmIndx;
		// self.DemEduCollNewPrivateFlag := le.attributes.version2.DemEduCollNewPrivateFlag;
		self.DemEduCollNewTierIndx := le.attributes.version2.DemEduCollNewTierIndx;
		self.DemBankingIndx := le.attributes.version2.DemBankingIndx;

		self.IntSportPersonFlagEv := le.attributes.version2.IntSportPersonFlagEv;
		self.IntSportPersonFlag1Y := le.attributes.version2.IntSportPersonFlag1Y;
		self.IntSportPersonFlag5Y := le.attributes.version2.IntSportPersonFlag5Y;
		self.IntSportPersonTravelerFlagEv := le.attributes.version2.IntSportPersonTravelerFlagEv;

		self.LifeMoveNewMsnc := le.attributes.version2.LifeMoveNewMsnc;
		self.LifeNameLastChngFlag := le.attributes.version2.LifeNameLastChngFlag;
		self.LifeNameLastChngFlag1Y := le.attributes.version2.LifeNameLastChngFlag1Y;
		self.LifeNameLastCntEv := le.attributes.version2.LifeNameLastCntEv;
		self.LifeNameLastChngNewMsnc := le.attributes.version2.LifeNameLastChngNewMsnc;
		self.LifeAstPurchOldMsnc := le.attributes.version2.LifeAstPurchOldMsnc;
		self.LifeAstPurchNewMsnc := le.attributes.version2.LifeAstPurchNewMsnc;
		self.LifeAddrCnt := le.attributes.version2.LifeAddrCnt;
		self.LifeAddrCurrToPrevValRatio5Y := le.attributes.version2.LifeAddrCurrToPrevValRatio5Y;
		self.LifeAddrEconTrajType := le.attributes.version2.LifeAddrEconTrajType;
		self.LifeAddrEconTrajIndx := le.attributes.version2.LifeAddrEconTrajIndx;

		self.AstCurrFlag := le.attributes.version2.AstCurrFlag;
		self.AstPropCurrFlag := le.attributes.version2.AstPropCurrFlag;
		self.AstPropCurrCntEv := le.attributes.version2.AstPropCurrCntEv;
		self.AstPropCurrValTot := le.attributes.version2.AstPropCurrValTot;
		self.AstPropCurrAVMTot := le.attributes.version2.AstPropCurrAVMTot;
		self.AstPropSaleNewMsnc := le.attributes.version2.AstPropSaleNewMsnc;
		self.AstPropCntEv := le.attributes.version2.AstPropCntEv;
		self.AstPropSoldCntEv := le.attributes.version2.AstPropSoldCntEv;
		self.AstPropSoldCnt1Y := le.attributes.version2.AstPropSoldCnt1Y;
		self.AstPropSoldNewRatio := le.attributes.version2.AstPropSoldNewRatio;
		self.AstPropPurchCnt1Y := le.attributes.version2.AstPropPurchCnt1Y;
		self.AstPropAirCrftCntEv := le.attributes.version2.AstPropAirCrftCntEv;
		self.AstPropWtrcrftCntEv := le.attributes.version2.AstPropWtrcrftCntEv;

		self.CurrAddrOwnershipIndx := le.attributes.version2.CurrAddrOwnershipIndx;
		self.CurrAddrHasPoolFlag := le.attributes.version2.CurrAddrHasPoolFlag;
		self.CurrAddrIsMobileHomeFlag := le.attributes.version2.CurrAddrIsMobileHomeFlag;
		self.CurrAddrBathCnt := le.attributes.version2.CurrAddrBathCnt;
		self.CurrAddrParkingCnt := le.attributes.version2.CurrAddrParkingCnt;
		self.CurrAddrBuildYr := le.attributes.version2.CurrAddrBuildYr;
		self.CurrAddrBedCnt := le.attributes.version2.CurrAddrBedCnt;
		self.CurrAddrBldgSize := le.attributes.version2.CurrAddrBldgSize;
		self.CurrAddrLat := le.attributes.version2.CurrAddrLat;
		self.CurrAddrLng := le.attributes.version2.CurrAddrLng;
		self.CurrAddrIsCollegeFlag := le.attributes.version2.CurrAddrIsCollegeFlag;
		self.CurrAddrAVMVal := le.attributes.version2.CurrAddrAVMVal;
		self.CurrAddrAVMValA1Y := le.attributes.version2.CurrAddrAVMValA1Y;
		self.CurrAddrAVMRatio1Y := le.attributes.version2.CurrAddrAVMRatio1Y;
		self.CurrAddrAVMValA5Y := le.attributes.version2.CurrAddrAVMValA5Y;
		self.CurrAddrAVMRatio5Y := le.attributes.version2.CurrAddrAVMRatio5Y;
		self.CurrAddrMedAVMCtyRatio := le.attributes.version2.CurrAddrMedAVMCtyRatio;
		self.CurrAddrMedAVMCenTractRatio := le.attributes.version2.CurrAddrMedAVMCenTractRatio;
		self.CurrAddrMedAVMCenBlockRatio := le.attributes.version2.CurrAddrMedAVMCenBlockRatio;
		self.CurrAddrType := le.attributes.version2.CurrAddrType;
		self.CurrAddrTypeIndx := le.attributes.version2.CurrAddrTypeIndx;
		self.CurrAddrBusRegCnt := le.attributes.version2.CurrAddrBusRegCnt;
		self.CurrAddrIsVacantFlag := le.attributes.version2.CurrAddrIsVacantFlag;
		// self.CurrAddrForeclosure := le.attributes.version2.CurrAddrForeclosure;
		self.CurrAddrStatus := le.attributes.version2.CurrAddrStatus;
		self.CurrAddrIsAptFlag := le.attributes.version2.CurrAddrIsAptFlag;

		self.PurchNewAmt := le.attributes.version2.PurchNewAmt;
		self.PurchTotEv := le.attributes.version2.PurchTotEv;
		self.PurchCntEv := le.attributes.version2.PurchCntEv;
		self.PurchNewMSnc := le.attributes.version2.PurchNewMSnc;
		self.PurchOldMsnc := le.attributes.version2.PurchOldMsnc;
		self.PurchItemCntEv := le.attributes.version2.PurchItemCntEv;
		self.PurchAmtAvg := le.attributes.version2.PurchAmtAvg;

		self.AstVehAutoCntEv := le.attributes.version2.AstVehAutoCntEv;
		self.AstVehAutoCarCntEv := le.attributes.version2.AstVehAutoCarCntEv;
		self.AstVehAutoSUVCntEv := le.attributes.version2.AstVehAutoSUVCntEv;
		self.AstVehAutoTruckCntEv := le.attributes.version2.AstVehAutoTruckCntEv;
		self.AstVehAutoVanCntEv := le.attributes.version2.AstVehAutoVanCntEv;
		self.AstVehAutoNewTypeIndx := le.attributes.version2.AstVehAutoNewTypeIndx;
		self.AstVehAutoExpCntEv := le.attributes.version2.AstVehAutoExpCntEv;
		self.AstVehAutoEliteCntEv := le.attributes.version2.AstVehAutoEliteCntEv;
		self.AstVehAutoLuxuryCntEv := le.attributes.version2.AstVehAutoLuxuryCntEv;
		self.AstVehAutoOrigOwnCntEv := le.attributes.version2.AstVehAutoOrigOwnCntEv;
		self.AstVehAutoMakeCntEv := le.attributes.version2.AstVehAutoMakeCntEv;
		self.AstVehAutoFreqMake := le.attributes.version2.AstVehAutoFreqMake;
		self.AstVehAutoFreqMakeCntEv := le.attributes.version2.AstVehAutoFreqMakeCntEv;
		self.AstVehAuto2ndFreqMake := le.attributes.version2.AstVehAuto2ndFreqMake;
		self.AstVehAuto2ndFreqMakeCntEv := le.attributes.version2.AstVehAuto2ndFreqMakeCntEv;
		self.AstVehAutoEmrgPriceAvg := le.attributes.version2.AstVehAutoEmrgPriceAvg;
		self.AstVehAutoEmrgPriceMax := le.attributes.version2.AstVehAutoEmrgPriceMax;
		self.AstVehAutoEmrgPriceMin := le.attributes.version2.AstVehAutoEmrgPriceMin;
		self.AstVehAutoNewPrice := le.attributes.version2.AstVehAutoNewPrice;
		self.AstVehAutoEmrgPriceDiff := le.attributes.version2.AstVehAutoEmrgPriceDiff;
		self.AstVehAutoLastAgeAvg := le.attributes.version2.AstVehAutoLastAgeAvg;
		self.AstVehAutoLastAgeMax := le.attributes.version2.AstVehAutoLastAgeMax;
		self.AstVehAutoLastAgeMin := le.attributes.version2.AstVehAutoLastAgeMin;
		self.AstVehAutoEmrgAgeAvg := le.attributes.version2.AstVehAutoEmrgAgeAvg;
		self.AstVehAutoEmrgAgeMax := le.attributes.version2.AstVehAutoEmrgAgeMax;
		self.AstVehAutoEmrgAgeMin := le.attributes.version2.AstVehAutoEmrgAgeMin;
		self.AstVehAutoEmrgSpanAvg := le.attributes.version2.AstVehAutoEmrgSpanAvg;
		self.AstVehAutoNewMsnc := le.attributes.version2.AstVehAutoNewMsnc;
		self.AstVehAutoTimeOwnSpanAvg := le.attributes.version2.AstVehAutoTimeOwnSpanAvg;
		self.AstVehOtherCntEv := le.attributes.version2.AstVehOtherCntEv;
		self.AstVehOtherATVCntEv := le.attributes.version2.AstVehOtherATVCntEv;
		self.AstVehOtherCamperCntEv := le.attributes.version2.AstVehOtherCamperCntEv;
		self.AstVehOtherCommCntEv := le.attributes.version2.AstVehOtherCommCntEv;
		self.AstVehOtherMtrCntEv := le.attributes.version2.AstVehOtherMtrCntEv;
		self.AstVehOtherScooterCntEv := le.attributes.version2.AstVehOtherScooterCntEv;
		self.AstVehOtherNewTypeIndx := le.attributes.version2.AstVehOtherNewTypeIndx;
		self.AstVehOtherOrigOwnCntEv := le.attributes.version2.AstVehOtherOrigOwnCntEv;
		self.AstVehOtherNewMsnc := le.attributes.version2.AstVehOtherNewMsnc;
		self.AstVehOtherPriceAvg := le.attributes.version2.AstVehOtherPriceAvg;
		self.AstVehOtherPriceMax := le.attributes.version2.AstVehOtherPriceMax;
		self.AstVehOtherPriceMin := le.attributes.version2.AstVehOtherPriceMin;
		self.AstVehOtherNewPrice := le.attributes.version2.AstVehOtherNewPrice;
		
		self.ProfLicFlagEv := le.attributes.version2.ProfLicFlagEv;
		self.ProfLicActivNewIndx := le.attributes.version2.ProfLicActivNewIndx;
		self.BusAssocFlagEv := le.attributes.version2.BusAssocFlagEv;
		self.BusAssocOldMSnc := le.attributes.version2.BusAssocOldMSnc;
		self.BusLeadershipTitleFlag := le.attributes.version2.BusLeadershipTitleFlag;
		self.BusAssocCntEv := le.attributes.version2.BusAssocCntEv;
		self.BusAssocSmBusFlag := le.attributes.version2.BusAssocSmBusFlag;
		self.ProfLicActvNewTitleType := le.attributes.version2.ProfLicActvNewTitleType;
		self.BusUCCFilingCntEv := le.attributes.version2.BusUCCFilingCntEv;
		self.BusUCCFilingActiveCnt := le.attributes.version2.BusUCCFilingActiveCnt;

		self.EmrgAge := le.attributes.version2.EmrgAge;
		self.EmrgAtOrAfter21Flag := le.attributes.version2.EmrgAtOrAfter21Flag;
		self.EmrgRecordType := le.attributes.version2.EmrgRecordType;
		self.EmrgAddressSeverityIndex := le.attributes.version2.EmrgAddressSeverityIndex;
		self.EmrgLexIDsAtAddressCnt := le.attributes.version2.EmrgLexIDsAtAddressCnt;
		self.EmrgMidAgeFlagFlag := le.attributes.version2.EmrgMidAgeFlagFlag;

		self.DrgCntEv := le.attributes.version2.DrgCntEv;
		self.DrgCnt1Y := le.attributes.version2.DrgCnt1Y;
		self.DrgNewMsnc := le.attributes.version2.DrgNewMsnc;
		self.DrgCrimFelCnt7Y := le.attributes.version2.DrgCrimFelCnt7Y;
		self.DrgCrimFelCnt1Y := le.attributes.version2.DrgCrimFelCnt1Y;
		self.DrgCrimFelNewMsnc := le.attributes.version2.DrgCrimFelNewMsnc;
		self.DrgCrimNFelCnt7Y := le.attributes.version2.DrgCrimNFelCnt7Y;
		self.DrgCrimNFelCnt1Y := le.attributes.version2.DrgCrimNFelCnt1Y;
		self.DrgCrimNFelNewMsnc := le.attributes.version2.DrgCrimNFelNewMsnc;
		self.DrgEvictCnt7Y := le.attributes.version2.DrgEvictCnt7Y;
		self.DrgEvictCnt1Y := le.attributes.version2.DrgEvictCnt1Y;
		self.DrgEvictNewMsnc := le.attributes.version2.DrgEvictNewMsnc;
		self.DrgLnJCnt10Y := le.attributes.version2.DrgLnJCnt10Y;
		self.DrgLnJCnt1Y := le.attributes.version2.DrgLnJCnt1Y;
		self.DrgLnJNewMsnc := le.attributes.version2.DrgLnJNewMsnc;
		self.DrgLnJAmtTot := le.attributes.version2.DrgLnJAmtTot;
		self.DrgBkCntEv := le.attributes.version2.DrgBkCntEv;
		self.DrgBkCnt1Y := le.attributes.version2.DrgBkCnt1Y;
		self.DrgBkNewMsnc := le.attributes.version2.DrgBkNewMsnc;
		self.DrgFrClCnt7Y := le.attributes.version2.DrgFrClCnt7Y;
		self.DrgFrClCnt1Y := le.attributes.version2.DrgFrClCnt1Y;
		self.DrgFrClNewMsnc := le.attributes.version2.DrgFrClNewMsnc;

		self.InpAddrOwnershipIndx := le.attributes.version2.InpAddrOwnershipIndx;
		// self.ResInputProspectRent := le.attributes.version2.ResInputProspectRent;
		// self.ResInputRentValue := le.attributes.version2.ResInputRentValue;
		self.InpAddrHasPoolFlag := le.attributes.version2.InpAddrHasPoolFlag;
		self.InpAddrIsMobileHomeFlag := le.attributes.version2.InpAddrIsMobileHomeFlag;
		self.InpAddrBathCnt := le.attributes.version2.InpAddrBathCnt;
		self.InpAddrParkingCnt := le.attributes.version2.InpAddrParkingCnt;
		self.InpAddrBuildYr := le.attributes.version2.InpAddrBuildYr;
		self.InpAddrBedCnt := le.attributes.version2.InpAddrBedCnt;
		self.InpAddrBldgSize := le.attributes.version2.InpAddrBldgSize;
		self.InpAddrLat := le.attributes.version2.InpAddrLat;
		self.InpAddrLng := le.attributes.version2.InpAddrLng;
		self.InpAddrIsCollegeFlag := le.attributes.version2.InpAddrIsCollegeFlag;
		self.InpAddrAVMVal := le.attributes.version2.InpAddrAVMVal;
		self.InpAddrAVMValA1Y := le.attributes.version2.InpAddrAVMValA1Y;
		self.InpAddrAVMRatio1Y := le.attributes.version2.InpAddrAVMRatio1Y;
		self.InpAddrAVMValA5Y := le.attributes.version2.InpAddrAVMValA5Y;
		self.InpAddrAVMRatio5Y := le.attributes.version2.InpAddrAVMRatio5Y;
		self.InpAddrMedAVMCtyRatio := le.attributes.version2.InpAddrMedAVMCtyRatio;
		self.InpAddrMedAVMCenTractRatio := le.attributes.version2.InpAddrMedAVMCenTractRatio;
		self.InpAddrMedAVMCenBlockRatio := le.attributes.version2.InpAddrMedAVMCenBlockRatio;
		self.InpAddrType := le.attributes.version2.InpAddrType;
		self.InpAddrTypeIndex := le.attributes.version2.InpAddrTypeIndex;
		self.InpAddrBusRegCnt := le.attributes.version2.InpAddrBusRegCnt;
		self.InpAddrIsVacantFlag := le.attributes.version2.InpAddrIsVacantFlag;
		self.InpAddrForeclosure := le.attributes.version2.InpAddrForeclosure;
		self.InpAddrIsAptFlag := le.attributes.version2.InpAddrIsAptFlag;

		self.HHID := le.attributes.version2.HHID;
		self.HHTeenagerMmbrCnt := le.attributes.version2.HHTeenagerMmbrCnt;
		self.HHYoungAdultMmbrCnt := le.attributes.version2.HHYoungAdultMmbrCnt;
		self.HHMiddleAgeMmbrCnt := le.attributes.version2.HHMiddleAgeMmbrCnt;
		self.HHSeniorMmbrCnt := le.attributes.version2.HHSeniorMmbrCnt;
		self.HHElderlyMmbrCnt := le.attributes.version2.HHElderlyMmbrCnt;
		self.HHMmbrsAgeMed := le.attributes.version2.HHMmbrsAgeMed;
		self.HHMmbrsAgeAvg := le.attributes.version2.HHMmbrsAgeAvg;
		self.HHComplexTotalCnt := le.attributes.version2.HHComplexTotalCnt;
		self.HHUnitsInComplexCnt := le.attributes.version2.HHUnitsInComplexCnt;
		self.HHCnt := le.attributes.version2.HHCnt;
		self.HHEstimatedIncomeTotal := le.attributes.version2.HHEstimatedIncomeTotal;
		self.HHEstimatedIncomeAvg := le.attributes.version2.HHEstimatedIncomeAvg;
		self.HHCollegeAttendedMmbrCnt := le.attributes.version2.HHCollegeAttendedMmbrCnt;
		self.HHCollege2yrAttendedMmbrCnt := le.attributes.version2.HHCollege2yrAttendedMmbrCnt;
		self.HHCollege4yrAttendedMmbrCnt := le.attributes.version2.HHCollege4yrAttendedMmbrCnt;
		self.HHCollegeGradAttendedMmbrCnt := le.attributes.version2.HHCollegeGradAttendedMmbrCnt;
		self.HHCollegePrivateMmbrCnt := le.attributes.version2.HHCollegePrivateMmbrCnt;
		self.HHCollegeTierMmbrHighest := le.attributes.version2.HHCollegeTierMmbrHighest;
		self.HHCollegeTierMmbrAvg := le.attributes.version2.HHCollegeTierMmbrAvg;
		self.HHTimeSinceAddition := le.attributes.version2.HHTimeSinceAddition;
		self.HHTimeSinceDeparture := le.attributes.version2.HHTimeSinceDeparture;
		self.HHAdditionCnt6Mo := le.attributes.version2.HHAdditionCnt6Mo;
		self.HHAdditionUnder25Cnt6M := le.attributes.version2.HHAdditionUnder25Cnt6M;
		self.HHAdditionOver60Cnt6M := le.attributes.version2.HHAdditionOver60Cnt6M;
		self.HHDepartureCnt6M := le.attributes.version2.HHDepartureCnt6M;

		self.HHMembersOwnPropCnt := le.attributes.version2.HHMembersOwnPropCnt;
		self.HHPropertiesOwnedCnt := le.attributes.version2.HHPropertiesOwnedCnt;
		self.HHMembersPropAVMMax := le.attributes.version2.HHMembersPropAVMMax;
		self.HHMemberPropAVMAvg := le.attributes.version2.HHMemberPropAVMAvg;
		self.HHMemberPropAVMTtl := le.attributes.version2.HHMemberPropAVMTtl;
		self.HHMemberPropAVMTtl1Y := le.attributes.version2.HHMemberPropAVMTtl1Y;
		self.HHMemberPropAVMTtl5Y := le.attributes.version2.HHMemberPropAVMTtl5Y;
		self.HHVehicleOwnedCnt := le.attributes.version2.HHVehicleOwnedCnt;
		self.HHAutoOwnedCnt := le.attributes.version2.HHAutoOwnedCnt;
		self.HHMotorcycleOwnedCnt := le.attributes.version2.HHMotorcycleOwnedCnt;
		self.HHAircraftOwnedCnt := le.attributes.version2.HHAircraftOwnedCnt;
		self.HHWatercraftOwnedCnt := le.attributes.version2.HHWatercraftOwnedCnt;

		self.HHWithOutdoorSportInterestCnt := le.attributes.version2.HHWithOutdoorSportInterestCnt;

		self.HHMmbrWDrgCnt10Y := le.attributes.version2.HHMmbrWDrgCnt10Y;
		self.HHMmbrWDrgCnt1Y := le.attributes.version2.HHMmbrWDrgCnt1Y;
		self.HHMmbrWDrgNewMsnc := le.attributes.version2.HHMmbrWDrgNewMsnc;
		self.HHMmbrWDrgCrimFelCnt10Y := le.attributes.version2.HHMmbrWDrgCrimFelCnt10Y;
		self.HHMmbrWDrgCrimFelCnt1Y := le.attributes.version2.HHMmbrWDrgCrimFelCnt1Y;
		self.HHMmbrWDrgCrimFelNewMsnc := le.attributes.version2.HHMmbrWDrgCrimFelNewMsnc;
		self.HHMmbrWDrgCrimNFelCnt10Y := le.attributes.version2.HHMmbrWDrgCrimNFelCnt10Y;
		self.HHMmbrWDrgCrimNFelCnt1Y := le.attributes.version2.HHMmbrWDrgCrimNFelCnt1Y;
		self.HHMmbrWDrgCrimNFelNewMsnc := le.attributes.version2.HHMmbrWDrgCrimNFelNewMsnc;
		self.HHMmbrWDrgEvictCnt10Y := le.attributes.version2.HHMmbrWDrgEvictCnt10Y;
		self.HHMmbrWDrgEvictCnt1Y := le.attributes.version2.HHMmbrWDrgEvictCnt1Y;
		self.HHMmbrWDrgEvictNewMsnc := le.attributes.version2.HHMmbrWDrgEvictNewMsnc;
		self.HHMmbrWDrgLnJCnt10Y := le.attributes.version2.HHMmbrWDrgLnJCnt10Y;
		self.HHMmbrWDrgLnJCnt1Y := le.attributes.version2.HHMmbrWDrgLnJCnt1Y;
		self.HHDrgLnJAmtTot := le.attributes.version2.HHDrgLnJAmtTot;
		self.HHMmbrWDrgLnJNewMsnc := le.attributes.version2.HHMmbrWDrgLnJNewMsnc;
		self.HHMmbrWDrgBkCnt10Y := le.attributes.version2.HHMmbrWDrgBkCnt10Y;
		self.HHMmbrWDrgBkCnt1Y := le.attributes.version2.HHMmbrWDrgBkCnt1Y;
		self.HHMmbrWDrgBkCnt2Y := le.attributes.version2.HHMmbrWDrgBkCnt2Y;
		self.HHMmbrWDrgBkNewMsnc := le.attributes.version2.HHMmbrWDrgBkNewMsnc;
		self.HHMmbrWDrgFrClCnt10Y := le.attributes.version2.HHMmbrWDrgFrClCnt10Y;
		self.HHMmbrWDrgFrClNewMSnc := le.attributes.version2.HHMmbrWDrgFrClNewMSnc;

		self.HHMmbrsWithProfLicCnt := le.attributes.version2.HHMmbrsWithProfLicCnt;
		self.HHMmbrsAssocWithBusCnt := le.attributes.version2.HHMmbrsAssocWithBusCnt;
		self.HHProfLicenseCat1Cnt := le.attributes.version2.HHProfLicenseCat1Cnt;
		self.HHProfLicenseCat2Cnt := le.attributes.version2.HHProfLicenseCat2Cnt;
		self.HHProfLicenseCat3Cnt := le.attributes.version2.HHProfLicenseCat3Cnt;
		self.HHProfLicenseCat4Cnt := le.attributes.version2.HHProfLicenseCat4Cnt;
		self.HHProfLicenseCat5Cnt := le.attributes.version2.HHProfLicenseCat5Cnt;
		self.HHProfLicenseUncatCnt := le.attributes.version2.HHProfLicenseUncatCnt;

		self.HHMostRecentPurchAmt := le.attributes.version2.HHMostRecentPurchAmt;
		self.HHPurchTtl := le.attributes.version2.HHPurchTtl;
		self.HHPurchOrdersCnt := le.attributes.version2.HHPurchOrdersCnt;
		self.HHTimeNewestLastPurch := le.attributes.version2.HHTimeNewestLastPurch;
		self.HHTimeSinceFirstPurch := le.attributes.version2.HHTimeSinceFirstPurch;
		self.HHPurchItemsCnt := le.attributes.version2.HHPurchItemsCnt;
		self.HHPurchOrderDollarAvg := le.attributes.version2.HHPurchOrderDollarAvg;

		self.HHNewAutoCnt := le.attributes.version2.HHNewAutoCnt;
		self.HHUniqueAutoMakeCnt := le.attributes.version2.HHUniqueAutoMakeCnt;
		self.HHAvgAutoPrice := le.attributes.version2.HHAvgAutoPrice;
		self.HHAutoPriceLastTwoDiff := le.attributes.version2.HHAutoPriceLastTwoDiff;
		self.HHAvgInitialAutoAge := le.attributes.version2.HHAvgInitialAutoAge;
		self.HHAvgTerminalAutoAge := le.attributes.version2.HHAvgTerminalAutoAge;
		self.HHAvgAutoTimeOnFile := le.attributes.version2.HHAvgAutoTimeOnFile;
		self.HHAvgVehOtherPrice := le.attributes.version2.HHAvgVehOtherPrice;
		self.HHAvgTimeBetweenAutos := le.attributes.version2.HHAvgTimeBetweenAutos;
		self.HHCamperCnt := le.attributes.version2.HHCamperCnt;
		self.HHCarCnt := le.attributes.version2.HHCarCnt;
		self.HHMaxAutoAgeFirstSeen := le.attributes.version2.HHMaxAutoAgeFirstSeen;
		self.HHMaxAutoAgeLastSeen := le.attributes.version2.HHMaxAutoAgeLastSeen;
		self.HHMaxAutoPrice := le.attributes.version2.HHMaxAutoPrice;
		self.HHMaxVehOtherPrice := le.attributes.version2.HHMaxVehOtherPrice;
		self.HHMinInitialAutoAge := le.attributes.version2.HHMinInitialAutoAge;
		self.HHMinTerminalAutoAge := le.attributes.version2.HHMinTerminalAutoAge;
		self.HHMinAutoPrice := le.attributes.version2.HHMinAutoPrice;
		self.HHMinVehOtherPrice := le.attributes.version2.HHMinVehOtherPrice;
		self.HHMostFrequentAutoMake := le.attributes.version2.HHMostFrequentAutoMake;
		self.HHMostFrequentAutoMakeCnt := le.attributes.version2.HHMostFrequentAutoMakeCnt;
		self.HHMostRecentAutoPrice := le.attributes.version2.HHMostRecentAutoPrice;
		self.HHMostRecentAutoType := le.attributes.version2.HHMostRecentAutoType;
		self.HHMostRecentVehOtherPrice := le.attributes.version2.HHMostRecentVehOtherPrice;
		self.HHMostRecentVehOtherType := le.attributes.version2.HHMostRecentVehOtherType;
		self.HHNewEliteAutoCnt := le.attributes.version2.HHNewEliteAutoCnt;
		self.HHNewExpensiveAutoCnt := le.attributes.version2.HHNewExpensiveAutoCnt;
		self.HHNewLuxuryAutoCnt := le.attributes.version2.HHNewLuxuryAutoCnt;
		self.HHNewOtherCnt := le.attributes.version2.HHNewOtherCnt;
		self.HHVehOtherCnt := le.attributes.version2.HHVehOtherCnt;
		self.HHSecondMostFrequentAutoMake := le.attributes.version2.HHSecondMostFrequentAutoMake;
		self.HHSecondMostFrequentAutoMakeCnt := le.attributes.version2.HHSecondMostFrequentAutoMakeCnt;
		self.HHSUVCnt := le.attributes.version2.HHSUVCnt;
		self.HHTruckCnt := le.attributes.version2.HHTruckCnt;
		self.HHATVCnt := le.attributes.version2.HHATVCnt;
		self.HHTSncMostRecentAuto := le.attributes.version2.HHTSncMostRecentAuto;
		self.HHTSncMostRecentVehOther := le.attributes.version2.HHTSncMostRecentVehOther;
		self.HHVanCnt := le.attributes.version2.HHVanCnt;

		self.RelWhoAreTeensCnt := le.attributes.version2.RelWhoAreTeensCnt;
		self.RelWhoAreYngAdultCnt := le.attributes.version2.RelWhoAreYngAdultCnt;
		self.RelWhoAreMiddleAgeCnt := le.attributes.version2.RelWhoAreMiddleAgeCnt;
		self.RelWhoAreSeniorCnt := le.attributes.version2.RelWhoAreSeniorCnt;
		self.RelWhoAreElderlyCnt := le.attributes.version2.RelWhoAreElderlyCnt;
		self.RelUniqueHHCnt := le.attributes.version2.RelUniqueHHCnt;
		self.RelCnt := le.attributes.version2.RelCnt;
		self.RelMedianIncome := le.attributes.version2.RelMedianIncome;
		self.RelAttendedCollegeCnt := le.attributes.version2.RelAttendedCollegeCnt;
		self.RelAttended2YrCollegeCnt := le.attributes.version2.RelAttended2YrCollegeCnt;
		self.RelAttended4YrCollegeCnt := le.attributes.version2.RelAttended4YrCollegeCnt;
		self.RelAttendedGradSchoolCnt := le.attributes.version2.RelAttendedGradSchoolCnt;
		self.RelAttendedPrivateCollegeCnt := le.attributes.version2.RelAttendedPrivateCollegeCnt;
		self.RelAttendedTopTierCollegeCnt := le.attributes.version2.RelAttendedTopTierCollegeCnt;
		self.RelAttendedMidTierCollegeCnt := le.attributes.version2.RelAttendedMidTierCollegeCnt;
		self.RelAttendedLowTierCollegeCnt := le.attributes.version2.RelAttendedLowTierCollegeCnt;
		self.DistClosestRel := le.attributes.version2.DistClosestRel;
		self.NonZeroDistanceClosestRel := le.attributes.version2.NonZeroDistanceClosestRel;
		self.RelWithin25MiCnt1Y := le.attributes.version2.RelWithin25MiCnt1Y;
		self.RelWithin100MiCnt1Y := le.attributes.version2.RelWithin100MiCnt1Y;
		self.RelWithin500MiCnt1Y := le.attributes.version2.RelWithin500MiCnt1Y;
		self.RelOver500MiCnt1Y := le.attributes.version2.RelOver500MiCnt1Y;
		self.DistanceFromRelAvg1Y := le.attributes.version2.DistanceFromRelAvg1Y;
		self.RelWithCrimeWithin25MiCnt7Y := le.attributes.version2.RelWithCrimeWithin25MiCnt7Y;
		self.DistClosestRelWithCrime7Y := le.attributes.version2.DistClosestRelWithCrime7Y;
		self.IncomeOfRelAvg := le.attributes.version2.IncomeOfRelAvg;
		self.IncomeOfRelMax := le.attributes.version2.IncomeOfRelMax;
		self.CurrHomeValueForRelAvg := le.attributes.version2.CurrHomeValueForRelAvg;

		self.RelMembersOwnPropCnt := le.attributes.version2.RelMembersOwnPropCnt;
		self.RelPropertiesOwnedCnt := le.attributes.version2.RelPropertiesOwnedCnt;
		self.RelMembersPropAVMMax := le.attributes.version2.RelMembersPropAVMMax;
		self.RelMemberPropAVMAvg := le.attributes.version2.RelMemberPropAVMAvg;
		self.RelMemberPropAVMTtl := le.attributes.version2.RelMemberPropAVMTtl;
		self.RelMemberPropAVMTtl1Yr := le.attributes.version2.RelMemberPropAVMTtl1Yr;
		self.RaAMemberPropAVMTtl5Yr := le.attributes.version2.RaAMemberPropAVMTtl5Yr;
		self.RelVehicleOwnedCnt := le.attributes.version2.RelVehicleOwnedCnt;
		self.RelAutoOwnedCnt := le.attributes.version2.RelAutoOwnedCnt;
		self.RelMotorcycleOwnedCnt := le.attributes.version2.RelMotorcycleOwnedCnt;
		self.RelAircraftOwnedCnt := le.attributes.version2.RelAircraftOwnedCnt;
		self.RelWatercraftOwnedCnt := le.attributes.version2.RelWatercraftOwnedCnt;

		self.RelWithOutdoorSportInterestCnt := le.attributes.version2.RelWithOutdoorSportInterestCnt;

		self.RelMmbrsWithCourtRecsCnt := le.attributes.version2.RelMmbrsWithCourtRecsCnt;
		self.RelMmbrsWithCourtRecsCnt1Y := le.attributes.version2.RelMmbrsWithCourtRecsCnt1Y;
		self.RelMmbrsCrtRecTimeNewest := le.attributes.version2.RelMmbrsCrtRecTimeNewest;
		self.RelMmbrsWithFelonyCnt := le.attributes.version2.RelMmbrsWithFelonyCnt;
		self.RelMmbrsWithFelonyCnt1Y := le.attributes.version2.RelMmbrsWithFelonyCnt1Y;
		self.RelMmbrsWithFelonyTimeNewest := le.attributes.version2.RelMmbrsWithFelonyTimeNewest;
		self.RelMmbrsWithMsdmCnt := le.attributes.version2.RelMmbrsWithMsdmCnt;
		self.RelMmbrsWithMsdmCnt1Y := le.attributes.version2.RelMmbrsWithMsdmCnt1Y;
		self.RelMmbrsWithMsdmTimeNewest := le.attributes.version2.RelMmbrsWithMsdmTimeNewest;
		self.RelMmbrsWithEvictionCnt := le.attributes.version2.RelMmbrsWithEvictionCnt;
		self.RelMmbrsWithEvictionCnt1Y := le.attributes.version2.RelMmbrsWithEvictionCnt1Y;
		self.RelMmbrsWithEvictionTimeNewest := le.attributes.version2.RelMmbrsWithEvictionTimeNewest;
		self.RelMmbrsWithLienJudgCnt := le.attributes.version2.RelMmbrsWithLienJudgCnt;
		self.RelMmbrsWithLienJudgCnt1Y := le.attributes.version2.RelMmbrsWithLienJudgCnt1Y;
		self.RelLienJudgTtl := le.attributes.version2.RelLienJudgTtl;
		self.RelLienJudgTimeNewest := le.attributes.version2.RelLienJudgTimeNewest;
		self.RelMmbrsWithBkCnt := le.attributes.version2.RelMmbrsWithBkCnt;
		self.RelMmbrsWithBkCnt1Y := le.attributes.version2.RelMmbrsWithBkCnt1Y;
		self.RelMmbrsWithBkCnt2Y := le.attributes.version2.RelMmbrsWithBkCnt2Y;
		self.RelMmbrsWithBkCntTimeNewest := le.attributes.version2.RelMmbrsWithBkCntTimeNewest;
		self.RelMmbrsWithForeclosures := le.attributes.version2.RelMmbrsWithForeclosures;
		self.RelForeclosuresTimeNewest := le.attributes.version2.RelForeclosuresTimeNewest;

		self.RelMmbrsWithProfLicCnt := le.attributes.version2.RelMmbrsWithProfLicCnt;
		self.RelMmbrsAssocWithBusCnt := le.attributes.version2.RelMmbrsAssocWithBusCnt;
		self.RelProfLicenseCat1Cnt := le.attributes.version2.RelProfLicenseCat1Cnt;
		self.RelProfLicenseCat2Cnt := le.attributes.version2.RelProfLicenseCat2Cnt;
		self.RelProfLicenseCat3Cnt := le.attributes.version2.RelProfLicenseCat3Cnt;
		self.RelProfLicenseCat4Cnt := le.attributes.version2.RelProfLicenseCat4Cnt;
		self.RelProfLicenseCat5Cnt := le.attributes.version2.RelProfLicenseCat5Cnt;
		self.RelProfLicenseUncatCnt := le.attributes.version2.RelProfLicenseUncatCnt;

		self.RelPurchLastAmt := le.attributes.version2.RelPurchLastAmt;
		self.RelPurchTotal := le.attributes.version2.RelPurchTotal;
		self.RelPurchOrdersCnt := le.attributes.version2.RelPurchOrdersCnt;
		self.RelPurchItemsCnt := le.attributes.version2.RelPurchItemsCnt;
		self.RelPurchOrderDollarAvg := le.attributes.version2.RelPurchOrderDollarAvg;

		self.NBHDHHCnt := le.attributes.version2.NBHDHHCnt;
		self.NBHDHHSizeAvg := le.attributes.version2.NBHDHHSizeAvg;
		self.NBHDMmbrCnt := le.attributes.version2.NBHDMmbrCnt;
		self.NBHDMmbrAgeAvg := le.attributes.version2.NBHDMmbrAgeAvg;
		self.NBHDMarriedMmbrPct := le.attributes.version2.NBHDMarriedMmbrPct;
		self.NBHDMedIncome := le.attributes.version2.NBHDMedIncome;
		self.NBHDCollegeAttendedMmbrPct := le.attributes.version2.NBHDCollegeAttendedMmbrPct;
		self.NBHDCollege2yrAttendedMmbrPct := le.attributes.version2.NBHDCollege2yrAttendedMmbrPct;
		self.NBHDCollege4yrAttendedMmbrPct := le.attributes.version2.NBHDCollege4yrAttendedMmbrPct;
		self.NBHDCollegePrivateMmbrPct := le.attributes.version2.NBHDCollegePrivateMmbrPct;
		self.NBHDCollegeTopTierMmbrPct := le.attributes.version2.NBHDCollegeTopTierMmbrPct;
		self.NBHDCollegeCurrentAttendingPct := le.attributes.version2.NBHDCollegeCurrentAttendingPct;
		self.NBHDCollegeMidTierMmbrPct := le.attributes.version2.NBHDCollegeMidTierMmbrPct;
		self.NBHDCollegeLowTierMmbrPct := le.attributes.version2.NBHDCollegeLowTierMmbrPct;
		self.NBHDBusinessCnt := le.attributes.version2.NBHDBusinessCnt;
		self.NBHDValueChangeIndex := le.attributes.version2.NBHDValueChangeIndex;
		// self.NBHDPropCurrOwnershipHHPct := le.attributes.version2.NBHDPropCurrOwnershipHHPct;
		// self.NBHDPropOwnerMmbrPct := le.attributes.version2.NBHDPropOwnerMmbrPct;
		// self.NBHDPPCurrOwnedHHPct := le.attributes.version2.NBHDPPCurrOwnedHHPct;
		// self.NBHDPPCurrOwnedAutoHHPct := le.attributes.version2.NBHDPPCurrOwnedAutoHHPct;
		// self.NBHDPPCurrOwnedMtrcycleHHPct := le.attributes.version2.NBHDPPCurrOwnedMtrcycleHHPct;
		// self.NBHDPPCurrOwnedAircraftHHPct := le.attributes.version2.NBHDPPCurrOwnedAircraftHHPct;
		// self.NBHDPPCurrOwnedWtrcrftHHPct := le.attributes.version2.NBHDPPCurrOwnedWtrcrftHHPct;
		// self.NBHDOccProfLicenseMmbrPct := le.attributes.version2.NBHDOccProfLicenseMmbrPct;
		// self.NBHDOccBusinessAssociationMmbrPct := le.attributes.version2.NBHDOccBusinessAssociationMmbrPct;
		// self.NBHDInterestSportsPersonMmbrPct := le.attributes.version2.NBHDInterestSportsPersonMmbrPct;
		// self.NBHDCrtRcrdMmbrPct1Y := le.attributes.version2.NBHDCrtRcrdMmbrPct1Y;
		// self.NBHDCrtRcrdFelonyMmbrPct := le.attributes.version2.NBHDCrtRcrdFelonyMmbrPct;
		// self.NBHDCrtRcrdMsdmeanMmbrPct := le.attributes.version2.NBHDCrtRcrdMsdmeanMmbrPct;
		// self.NBHDCrtRcrdEvictionMmbrPct := le.attributes.version2.NBHDCrtRcrdEvictionMmbrPct;
		// self.NBHDCrtRcrdLienJudgeMmbrPct := le.attributes.version2.NBHDCrtRcrdLienJudgeMmbrPct;
		// self.NBHDCrtRcrdBkrptMmbrPct := le.attributes.version2.NBHDCrtRcrdBkrptMmbrPct;
		// self.NBHDCrtRcrdBkrptMmbrPct1Y := le.attributes.version2.NBHDCrtRcrdBkrptMmbrPct1Y;
		// self.NBHDRiskViewBankScoreAvg := le.attributes.version2.NBHDRiskViewBankScoreAvg;
		// self.NBHDTelecomScoreAvg := le.attributes.version2.NBHDTelecomScoreAvg;
		// self.NBHDShortTermLendingScoreAvg := le.attributes.version2.NBHDShortTermLendingScoreAvg;
		// self.NBHDAutoScoreAvg := le.attributes.version2.NBHDAutoScoreAvg;
		// self.NBHDAdditionPct6Mo := le.attributes.version2.NBHDAdditionPct6Mo;
		// self.NBHDAdditionUnder25Pct6M := le.attributes.version2.NBHDAdditionUnder25Pct6M;
		// self.NBHDAdditionOver60Pct6M := le.attributes.version2.NBHDAdditionOver60Pct6M;
		// self.NBHDDeparturePct6M := le.attributes.version2.NBHDDeparturePct6M;
		
		// self.score1                                   := le.attributes.version1.score1;
    // self.scorename1                               := custommodel_in;
		self := le;
    self := [];
	end;	
	
	final := join(attributes, PB_wSeq, 
								left.seq = right.seq,
								addAcct(left, right), left outer); 
#END
/* ********************
 *  Debugging Section *
 **********************/

// OUTPUT(glba, NAMED('glba'));																					 
// OUTPUT(batch_in, NAMED('batch_in'));																					 
 //OUTPUT(PB_wseq, NAMED('PB_wseq'));																					 
 //OUTPUT(attributes, NAMED('attributes1'));
																					 
RETURN OUTPUT(final, NAMED('Results'));																					 

END;

/*--SOAP--
<message name="Profile Booster Batch Service">
	<part name="batch_in"  type="tns:XmlDataSet" cols="80" rows="50"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="AttributesVersionRequest" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
 </message>
*/
/*--INFO-- Profile Booster Batch Service*/
/*--HELP--
<pre>
&lt;dataset&gt;
   &lt;row&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;LexID&gt;&lt;/LexID&gt;
      &lt;Name_Full&gt;&lt;/Name_Full&gt;
      &lt;Name_Title&gt;&lt;/Name_Title&gt;
      &lt;Name_First&gt;&lt;/Name_First&gt;
      &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
      &lt;Name_Last&gt;&lt;/Name_Last&gt;
      &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;DOB&gt;&lt;/DOB&gt;
      &lt;Phone10&gt;&lt;/Phone10&gt;
      &lt;street_addr&gt;&lt;/street_addr&gt;
      &lt;streetnumber&gt;&lt;/streetnumber&gt;
      &lt;streetpredirection&gt;&lt;/streetpredirection&gt;
      &lt;streetname&gt;&lt;/streetname&gt;
      &lt;streetsuffix&gt;&lt;/streetsuffix&gt;
      &lt;streetpostdirection&gt;&lt;/streetpostdirection&gt;
      &lt;unitdesignation&gt;&lt;/unitdesignation&gt;
      &lt;unitnumber&gt;&lt;/unitnumber&gt;
      &lt;City_name&gt;&lt;/City_name&gt;
      &lt;St&gt;&lt;/St&gt;
      &lt;Z5&gt;&lt;/Z5&gt;
      &lt;country&gt;&lt;/country&gt;
			&lt;emailAddress&gt;&lt;/emailAddress&gt;
      &lt;HistoryDate&gt;&lt;/HistoryDate&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/
