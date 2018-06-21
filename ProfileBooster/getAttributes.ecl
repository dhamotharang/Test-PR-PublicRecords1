import Risk_Indicators, Models, iesp, doxie, ut;

EXPORT getAttributes(DATASET(ProfileBooster.Layouts.Layout_PB_Shell) PBShell, 
										 string50 DataPermissionMask = risk_indicators.iid_constants.default_DataPermission) := FUNCTION

ProfileBooster.Layouts.Layout_PB_BatchOut getAttr(PBShell le) := transform
	noDid 	:= le.did = 0;
	nines		:= 9999999;
	maxcnt	:= 255;
	maxmths	:= 960;
	self.seq																								:= le.seq;
	self.AcctNo																							:= le.AcctNo;
	self.LexID																							:= le.did;
	self.attributes.version1.DoNotMail											:= if(noDid, '-1', le.DoNotMail);
	self.attributes.version1.VerifiedProspectFound					:= if(noDid, '-1', '1');  
	self.attributes.version1.VerifiedName										:= if(noDid or le.fname = '' or le.lname = '', '-1', map(le.firstcount > 0 and le.lastcount > 0 => '3',
																																																									 le.lastcount > 0												=> '2',
																																																									 le.firstcount > 0											=> '1',
																																																																														 '0'));
	self.attributes.version1.VerifiedSSN										:= if(noDid or le.ssn = '', '-1', if(le.socscount > 0, '1', '0'));
	self.attributes.version1.VerifiedPhone									:= if(noDid or le.phone10 = '', '-1', if(le.phonecount > 0, '1', '0'));
	self.attributes.version1.VerifiedCurrResMatchIndex			:= map(noDid															=> '-1', 
																																 le.VerifiedCurrResMatchIndex = ''	=> '0',
																																																			 le.VerifiedCurrResMatchIndex);
	TimeOnRecord 		:= if(le.dt_first_seen = 0, '-1', (string)min(ut.MonthsApart((string6)le.dt_first_seen,(string6)le.HistoryDate),maxmths));
	TimeLastUpdate 	:= if(le.dt_last_seen = 0, '-1', (string)min(ut.MonthsApart((string6)le.dt_last_seen,(string6)le.HistoryDate), le.CrtRecTimeNewest, maxmths));
	self.attributes.version1.ProspectTimeOnRecord						:= if(noDid, '-1', TimeOnRecord);
	self.attributes.version1.ProspectTimeLastUpdate					:= if(noDid, '-1', TimeLastUpdate);
	self.attributes.version1.ProspectLastUpdate12Mo					:= if(noDid, '-1', if(TimeLastUpdate<>'-1' and (integer)TimeLastUpdate <= 12, '1', '0'));
	// cap age at 120 and if under 18, return 0
	self.attributes.version1.ProspectAge										:= if(noDid or le.ProspectAge = 0, '-1', (string)min(if(le.ProspectAge > 17, le.ProspectAge, 0),120)); 
	self.attributes.version1.ProspectGender									:= map(noDid						=> '-1',
																																 le.title = 'MR'	=> 'M',
																																 le.title = 'MS'	=> 'F',
																																 le.gender = 'M'	=> 'M',
																																 le.gender = 'F' 	=> 'F', 
																																										 '0');
	self.attributes.version1.ProspectMaritalStatus					:= if(noDid, '-1', if(stringlib.stringtouppercase(le.marital_status) = 'Y', 'M', '0'));
	self.attributes.version1.ProspectEstimatedIncomeRange		:= if(noDid, '-1', le.ProspectEstimatedIncomeRange);
	
	isDeceased	:= le.dod > 0 or (Risk_Indicators.iid_constants.deathSSA_ok(DataPermissionMask) and le.dodSSA > 0);
	self.attributes.version1.ProspectDeceased								:= if(noDid, '-1', if(isDeceased, '1', '0'));
	self.attributes.version1.ProspectCollegeAttending				:= if(noDid, '-1', le.ProspectCollegeAttending);
	self.attributes.version1.ProspectCollegeAttended				:= if(noDid, '-1', le.ProspectCollegeAttended);
	self.attributes.version1.ProspectCollegeProgramType			:= if(noDid, '-1', le.ProspectCollegeProgramType);
	self.attributes.version1.ProspectCollegePrivate					:= if(noDid, '-1', le.ProspectCollegePrivate);
	self.attributes.version1.ProspectCollegeTier						:= if(noDid, '-1', le.ProspectCollegeTier);
	self.attributes.version1.AssetCurrOwner									:= if(noDid, '-1', if(le.PPCurrOwner = 1 and le.PropCurrOwner = 1, '1', '0'));
	self.attributes.version1.PropCurrOwner									:= if(noDid, '-1', (string)le.PropCurrOwner);
	self.attributes.version1.PropCurrOwnedCnt								:= if(noDid, '-1', (string)min(le.PropCurrOwnedCnt,maxcnt));
	self.attributes.version1.PropCurrOwnedAssessedTtl				:= if(noDid, '-1', (string)min(le.PropCurrOwnedAssessedTtl,nines));
	self.attributes.version1.PropCurrOwnedAVMTtl						:= if(noDid, '-1', (string)min(le.PropCurrOwnedAVMTtl,nines));
	self.attributes.version1.PropTimeLastSale								:= if(noDid or le.PropTimeLastSale = nines, '-1', (string)min(le.PropTimeLastSale,maxmths));
	self.attributes.version1.PropEverOwnedCnt								:= if(noDid, '-1', (string)min(le.PropEverOwnedCnt,maxcnt));
	self.attributes.version1.PropEverSoldCnt								:= if(noDid, '-1', (string)min(le.PropEverSoldCnt,maxcnt));
	self.attributes.version1.PropSoldCnt12Mo								:= if(noDid, '-1', (string)min(le.PropSoldCnt12Mo,maxcnt));
	self.attributes.version1.PropSoldRatio									:= if(noDid, '-1', le.PropSoldRatio);
	self.attributes.version1.PropPurchaseCnt12Mo						:= if(noDid, '-1', (string)min(le.PropPurchaseCnt12Mo,maxcnt));
	self.attributes.version1.PPCurrOwner										:= if(noDid, '-1', (string)le.PPCurrOwner);
	self.attributes.version1.PPCurrOwnedCnt									:= if(noDid, '-1', (string)min(le.PPCurrOwnedCnt,maxcnt));
	self.attributes.version1.PPCurrOwnedAutoCnt							:= if(noDid, '-1', (string)min(le.PPCurrOwnedAutoCnt,maxcnt));
	self.attributes.version1.PPCurrOwnedMtrcycleCnt					:= if(noDid, '-1', (string)min(le.PPCurrOwnedMtrcycleCnt,maxcnt));
	self.attributes.version1.PPCurrOwnedAircrftCnt					:= if(noDid, '-1', (string)min(le.PPCurrOwnedAircrftCnt,maxcnt));
	self.attributes.version1.PPCurrOwnedWtrcrftCnt					:= if(noDid, '-1', (string)min(le.PPCurrOwnedWtrcrftCnt,maxcnt));
	self.attributes.version1.LifeEvTimeLastMove							:= if(noDid or le.LifeEvTimeLastMove = nines, '-1', (string)min(le.LifeEvTimeLastMove,maxmths));
	self.attributes.version1.LifeEvNameChange								:= if(noDid, '-1', le.LifeEvNameChange);
	self.attributes.version1.LifeEvNameChangeCnt12Mo				:= if(noDid, '-1', le.LifeEvNameChangeCnt12Mo);
	notOwner	 																							:= le.PropEverOwnedCnt = 0 and le.PPCurrOwnedCnt = 0;
	self.attributes.version1.LifeEvTimeFirstAssetPurchase 	:= if(noDid or (notOwner and le.LifeEvTimeFirstAssetPurchase = 0), '-1', (string)min(le.LifeEvTimeFirstAssetPurchase,maxmths));
	self.attributes.version1.LifeEvTimeLastAssetPurchase 		:= if(noDid or (notOwner and le.LifeEvTimeFirstAssetPurchase = 0), '-1', (string)min(le.LifeEvTimeLastAssetPurchase,maxmths));
	self.attributes.version1.LifeEvEverResidedCnt						:= if(noDid, '-1', (string)min(le.LifeEvEverResidedCnt,maxcnt));
	self.attributes.version1.LifeEvLastMoveTaxRatioDiff 		:= map(noDid	=> '-1',
																																 le.LifeEvTimeLastMove > 60 or le.curr_AssessedAmount = 0 or le.prev_AssessedAmount = 0	=> '0', 
																																 trim((string)(decimal4_2)min(le.curr_AssessedAmount / le.prev_AssessedAmount, 99.0)));
	self.attributes.version1.LifeEvEconTrajectory						:= map(noDid																							=> '-1', 
																																 self.attributes.version1.LifeEvTimeLastMove = '-1'	=> '0', //if we couldn't determine last move, set to 0
																																																											 le.LifeEvEconTrajectory);
	self.attributes.version1.LifeEvEconTrajectoryIndex			:= map(noDid																							=> '-1', 
																																 self.attributes.version1.LifeEvTimeLastMove = '-1'	=> '0', //if we couldn't determine last move, set to 0
																																																											 le.LifeEvEconTrajectoryIndex);
	self.attributes.version1.ResCurrOwnershipIndex					:= map(noDid										=> '-1',
																																 le.curr_addr_type = 'P' 	=> '0', //if curr addr is PO Box, set ownership index to '0'
																																														 (string)le.ResCurrOwnershipIndex);
	self.attributes.version1.ResCurrAVMValue								:= if(noDid, '-1', (string)min(le.ResCurrAVMValue,nines));
	self.attributes.version1.ResCurrAVMValue12Mo						:= if(noDid, '-1', (string)min(le.ResCurrAVMValue12Mo,nines));
	self.attributes.version1.ResCurrAVMRatioDiff12Mo				:= if(noDid, '-1', le.ResCurrAVMRatioDiff12Mo);
	self.attributes.version1.ResCurrAVMValue60Mo						:= if(noDid, '-1', (string)min(le.ResCurrAVMValue60Mo,nines));
	self.attributes.version1.ResCurrAVMRatioDiff60Mo				:= if(noDid, '-1', le.ResCurrAVMRatioDiff60Mo);
	self.attributes.version1.ResCurrAVMCntyRatio						:= if(noDid, '-1', le.ResCurrAVMCntyRatio);
	self.attributes.version1.ResCurrAVMTractRatio						:= if(noDid, '-1', le.ResCurrAVMTractRatio);
	self.attributes.version1.ResCurrAVMBlockRatio						:= if(noDid, '-1', le.ResCurrAVMBlockRatio);
	self.attributes.version1.ResCurrDwellType								:= if(noDid, '-1', if(le.curr_addr_type in ['S','H','P','F','G','R','U'], le.curr_addr_type, '-1'));
	self.attributes.version1.ResCurrDwellTypeIndex					:= if(noDid, '-1', map(le.curr_addr_type in ['S','G','R']	=> '3',
																																								 le.curr_addr_type in ['P']					=> '2',
																																								 le.curr_addr_type in ['H','F']			=> '1',
																																																											 '0'));
	self.attributes.version1.ResCurrMortgageType						:= if(noDid, '-1', if(le.ResCurrMortgageType='', '0', le.ResCurrMortgageType));
	self.attributes.version1.ResCurrMortgageAmount					:= if(noDid, '-1', (string)min(le.ResCurrMortgageAmount,nines));
	self.attributes.version1.ResCurrBusinessCnt							:= if(noDid, '-1', (string)min(le.ResCurrBusinessCnt,maxcnt));
	self.attributes.version1.ResInputOwnershipIndex					:= map(noDid or le.in_streetAddress = ''	=> '-1', 
																																 le.addr_type = 'P'									=> '0', //if input addr is PO Box, set ownership index to '0'
																																																			 (string)le.ResInputOwnershipIndex);
	self.attributes.version1.ResInputAVMValue								:= if(noDid or le.in_streetAddress = '', '-1', (string)min(le.ResInputAVMValue,nines));
	self.attributes.version1.ResInputAVMValue12Mo						:= if(noDid or le.in_streetAddress = '', '-1', (string)min(le.ResInputAVMValue12Mo,nines));
	self.attributes.version1.ResInputAVMRatioDiff12Mo				:= if(noDid or le.in_streetAddress = '', '-1', le.ResInputAVMRatioDiff12Mo);
	self.attributes.version1.ResInputAVMValue60Mo						:= if(noDid or le.in_streetAddress = '', '-1', (string)min(le.ResInputAVMValue60Mo,nines));
	self.attributes.version1.ResInputAVMRatioDiff60Mo				:= if(noDid or le.in_streetAddress = '', '-1', le.ResInputAVMRatioDiff60Mo);
	self.attributes.version1.ResInputAVMCntyRatio						:= if(noDid or le.in_streetAddress = '', '-1', le.ResInputAVMCntyRatio);
	self.attributes.version1.ResInputAVMTractRatio					:= if(noDid or le.in_streetAddress = '', '-1', le.ResInputAVMTractRatio);
	self.attributes.version1.ResInputAVMBlockRatio					:= if(noDid or le.in_streetAddress = '', '-1', le.ResInputAVMBlockRatio);
	self.attributes.version1.ResInputDwellType							:= if(noDid or le.in_streetAddress = '', '-1', if(le.addr_type in ['S','H','P','F','G','R','U'], le.addr_type, '0'));
	self.attributes.version1.ResInputDwellTypeIndex					:= if(noDid or le.in_streetAddress = '', '-1', map(le.addr_type in ['S','G','R']	=> '3',
																																																						 le.addr_type in ['P']					=> '2',
																																																						 le.addr_type in ['H','F']			=> '1',
																																																																							 '0'));
	self.attributes.version1.ResInputMortgageType						:= if(noDid or le.in_streetAddress = '', '-1', if(le.ResInputMortgageType='', '0', le.ResInputMortgageType));
	self.attributes.version1.ResInputMortgageAmount					:= if(noDid or le.in_streetAddress = '', '-1', (string)min(le.ResInputMortgageAmount,nines));
	self.attributes.version1.ResInputBusinessCnt						:= if(noDid or le.in_streetAddress = '', '-1', (string)min(le.ResInputBusinessCnt,maxcnt));	
	self.attributes.version1.ProspectBankingExperience			:= map(noDid 																																																												=> '-1',
																																 self.attributes.version1.propcurrowner = '-1' and self.attributes.version1.ppcurrowner = '-1'																=> '0',
																																 (integer)self.attributes.version1.PropEverOwnedCnt > 2 or self.attributes.version1.ppcurrowner = '1'													=> '2',
																																 (integer)self.attributes.version1.prospecttimeonrecord > 0 and (integer)self.attributes.version1.prospecttimeonrecord < 96		=> '0',
																																																																																																 '1');

	self.attributes.version1.CrtRecCnt											:= if(noDid, '-1', (string)min(le.CrtRecCnt,maxcnt));
	self.attributes.version1.CrtRecCnt12Mo									:= if(noDid, '-1', (string)min(le.CrtRecCnt12Mo,maxcnt));
	self.attributes.version1.CrtRecTimeNewest								:= if(noDid or le.CrtRecTimeNewest = nines, '-1', (string)min(le.CrtRecTimeNewest,maxmths));
	self.attributes.version1.CrtRecFelonyCnt								:= if(noDid, '-1', (string)min(le.CrtRecFelonyCnt,maxcnt));
	self.attributes.version1.CrtRecFelonyCnt12Mo						:= if(noDid, '-1', (string)min(le.CrtRecFelonyCnt12Mo,maxcnt));
	self.attributes.version1.CrtRecFelonyTimeNewest					:= if(noDid or le.CrtRecFelonyTimeNewest = nines, '-1', (string)min(le.CrtRecFelonyTimeNewest,maxmths));
	self.attributes.version1.CrtRecMsdmeanCnt								:= if(noDid, '-1', (string)min(le.CrtRecMsdmeanCnt,maxcnt));
	self.attributes.version1.CrtRecMsdmeanCnt12Mo						:= if(noDid, '-1', (string)min(le.CrtRecMsdmeanCnt12Mo,maxcnt));
	self.attributes.version1.CrtRecMsdmeanTimeNewest				:= if(noDid or le.CrtRecMsdmeanTimeNewest = nines, '-1', (string)min(le.CrtRecMsdmeanTimeNewest,maxmths));
	self.attributes.version1.CrtRecEvictionCnt							:= if(noDid, '-1', (string)min(le.CrtRecEvictionCnt,maxcnt));
	self.attributes.version1.CrtRecEvictionCnt12Mo					:= if(noDid, '-1', (string)min(le.CrtRecEvictionCnt12Mo,maxcnt));
	self.attributes.version1.CrtRecEvictionTimeNewest				:= if(noDid or le.CrtRecEvictionTimeNewest = nines, '-1', (string)min(le.CrtRecEvictionTimeNewest,maxmths));
	self.attributes.version1.CrtRecLienJudgCnt							:= if(noDid, '-1', (string)min(le.CrtRecLienJudgCnt,maxcnt));
	self.attributes.version1.CrtRecLienJudgCnt12Mo					:= if(noDid, '-1', (string)min(le.CrtRecLienJudgCnt12Mo,maxcnt));
	self.attributes.version1.CrtRecLienJudgTimeNewest				:= if(noDid or le.CrtRecLienJudgTimeNewest = nines, '-1', (string)min(le.CrtRecLienJudgTimeNewest,maxmths));
	self.attributes.version1.CrtRecLienJudgAmtTtl						:= if(noDid, '-1', (string)min(le.CrtRecLienJudgAmtTtl, nines));
	self.attributes.version1.CrtRecBkrptCnt									:= if(noDid, '-1', (string)min(le.CrtRecBkrptCnt,maxcnt));
	self.attributes.version1.CrtRecBkrptCnt12Mo							:= if(noDid, '-1', (string)min(le.CrtRecBkrptCnt12Mo,maxcnt));
	self.attributes.version1.CrtRecBkrptTimeNewest					:= if(noDid or le.CrtRecBkrptTimeNewest = nines, '-1', (string)min(le.CrtRecBkrptTimeNewest,maxmths));
	self.attributes.version1.CrtRecSeverityIndex						:= if(noDid, '-1', le.CrtRecSeverityIndex);
	self.attributes.version1.OccProfLicense									:= if(noDid, '-1', (string)le.OccProfLicense);
	self.attributes.version1.OccProfLicenseCategory					:= if(noDid, '-1', le.OccProfLicenseCategory);
	self.attributes.version1.OccBusinessAssociation					:= if(noDid, '-1', (string)le.OccBusinessAssociation);
	self.attributes.version1.OccBusinessAssociationTime			:= if(noDid or le.OccBusinessAssociationTime = nines, '-1', (string)min(le.OccBusinessAssociationTime,maxmths));
	self.attributes.version1.OccBusinessTitleLeadership			:= if(noDid, '-1', (string)le.OccBusinessTitleLeadership);
	self.attributes.version1.InterestSportPerson						:= if(noDid, '-1', (string)le.InterestSportPerson);	
	//include our prospect in the appropriate age bucket for household members
	HHTeenagerMmbrCnt			:= le.HHTeenagerMmbrCnt + if(le.ProspectAge between 13 and 19, 1, 0);
	HHYoungAdultMmbrCnt		:= le.HHYoungAdultMmbrCnt + if(le.ProspectAge between 20 and 39, 1, 0);
	HHMiddleAgemmbrCnt		:= le.HHMiddleAgemmbrCnt + if(le.ProspectAge between 40 and 64, 1, 0);
	HHSeniorMmbrCnt		  	:= le.HHSeniorMmbrCnt + if(le.ProspectAge between 65 and 79, 1, 0);
	HHElderlyMmbrCnt			:= le.HHElderlyMmbrCnt + if(le.ProspectAge > 79, 1, 0);
	self.attributes.version1.HHTeenagerMmbrCnt							:= if(noDid, '-1', (string)min(HHTeenagerMmbrCnt,maxcnt));
	self.attributes.version1.HHYoungAdultMmbrCnt						:= if(noDid, '-1', (string)min(HHYoungAdultMmbrCnt,maxcnt));
	self.attributes.version1.HHMiddleAgemmbrCnt							:= if(noDid, '-1', (string)min(HHMiddleAgemmbrCnt,maxcnt));
	self.attributes.version1.HHSeniorMmbrCnt								:= if(noDid, '-1', (string)min(HHSeniorMmbrCnt,maxcnt));
	self.attributes.version1.HHElderlyMmbrCnt								:= if(noDid, '-1', (string)min(HHElderlyMmbrCnt,maxcnt));
	self.attributes.version1.HHCnt													:= if(noDid, '-1', (string)min(le.HHCnt+1,maxcnt)); //add 1 to include the prospect  
	self.attributes.version1.HHEstimatedIncomeRange					:= if(noDid, '-1', le.HHEstimatedIncomeRange);
	self.attributes.version1.HHCollegeAttendedMmbrCnt 			:= if(noDid, '-1', (string)min(le.HHCollegeAttendedMmbrCnt,maxcnt));
	self.attributes.version1.HHCollege2yrAttendedMmbrCnt		:= if(noDid, '-1', (string)min(le.HHCollege2yrAttendedMmbrCnt,maxcnt));
	self.attributes.version1.HHCollege4yrAttendedMmbrCnt 		:= if(noDid, '-1', (string)min(le.HHCollege4yrAttendedMmbrCnt,maxcnt));
	self.attributes.version1.HHCollegeGradAttendedMmbrCnt 	:= if(noDid, '-1', (string)min(le.HHCollegeGradAttendedMmbrCnt,maxcnt));
	self.attributes.version1.HHCollegePrivateMmbrCnt				:= if(noDid, '-1', (string)min(le.HHCollegePrivateMmbrCnt,maxcnt));
	self.attributes.version1.HHCollegeTierMmbrHighest				:= if(noDid, '-1', (string)le.HHCollegeTierMmbrHighest);
	self.attributes.version1.HHPropCurrOwnerMmbrCnt					:= if(noDid, '-1', (string)min(le.HHPropCurrOwnerMmbrCnt,maxcnt));
	self.attributes.version1.HHPropCurrOwnedCnt							:= if(noDid, '-1', (string)min(le.HHPropCurrOwnedCnt,maxcnt));
	self.attributes.version1.HHPropCurrAVMHighest						:= if(noDid, '-1', (string)min(le.HHPropCurrAVMHighest,nines));
	self.attributes.version1.HHPPCurrOwnedCnt								:= if(noDid, '-1', (string)min(le.HHPPCurrOwnedCnt,maxcnt));
	self.attributes.version1.HHPPCurrOwnedAutoCnt						:= if(noDid, '-1', (string)min(le.HHPPCurrOwnedAutoCnt,maxcnt));
	self.attributes.version1.HHPPCurrOwnedMtrcycleCnt				:= if(noDid, '-1', (string)min(le.HHPPCurrOwnedMtrcycleCnt,maxcnt));
	self.attributes.version1.HHPPCurrOwnedAircrftCnt				:= if(noDid, '-1', (string)min(le.HHPPCurrOwnedAircrftCnt,maxcnt));
	self.attributes.version1.HHPPCurrOwnedWtrcrftCnt				:= if(noDid, '-1', (string)min(le.HHPPCurrOwnedWtrcrftCnt,maxcnt));
	self.attributes.version1.HHCrtRecMmbrCnt								:= if(noDid, '-1', (string)min(le.HHCrtRecMmbrCnt,maxcnt));
	self.attributes.version1.HHCrtRecMmbrCnt12Mo						:= if(noDid, '-1', (string)min(le.HHCrtRecMmbrCnt12Mo,maxcnt));
	self.attributes.version1.HHCrtRecFelonyMmbrCnt					:= if(noDid, '-1', (string)min(le.HHCrtRecFelonyMmbrCnt,maxcnt));
	self.attributes.version1.HHCrtRecFelonyMmbrCnt12Mo			:= if(noDid, '-1', (string)min(le.HHCrtRecFelonyMmbrCnt12Mo,maxcnt));
	self.attributes.version1.HHCrtRecMsdmeanMmbrCnt					:= if(noDid, '-1', (string)min(le.HHCrtRecMsdmeanMmbrCnt,maxcnt));
	self.attributes.version1.HHCrtRecMsdmeanMmbrCnt12Mo			:= if(noDid, '-1', (string)min(le.HHCrtRecMsdmeanMmbrCnt12Mo,maxcnt));
	self.attributes.version1.HHCrtRecEvictionMmbrCnt				:= if(noDid, '-1', (string)min(le.HHCrtRecEvictionMmbrCnt,maxcnt));
	self.attributes.version1.HHCrtRecEvictionMmbrCnt12Mo		:= if(noDid, '-1', (string)min(le.HHCrtRecEvictionMmbrCnt12Mo,maxcnt));
	self.attributes.version1.HHCrtRecLienJudgMmbrCnt				:= if(noDid, '-1', (string)min(le.HHCrtRecLienJudgMmbrCnt,maxcnt));
	self.attributes.version1.HHCrtRecLienJudgMmbrCnt12Mo		:= if(noDid, '-1', (string)min(le.HHCrtRecLienJudgMmbrCnt12Mo,maxcnt));
	self.attributes.version1.HHCrtRecLienJudgAmtTtl					:= if(noDid, '-1', (string)min(le.HHCrtRecLienJudgAmtTtl,nines));
	self.attributes.version1.HHCrtRecBkrptMmbrCnt						:= if(noDid, '-1', (string)min(le.HHCrtRecBkrptMmbrCnt,maxcnt));
	self.attributes.version1.HHCrtRecBkrptMmbrCnt12Mo				:= if(noDid, '-1', (string)min(le.HHCrtRecBkrptMmbrCnt12Mo,maxcnt));
	self.attributes.version1.HHCrtRecBkrptMmbrCnt24Mo				:= if(noDid, '-1', (string)min(le.HHCrtRecBkrptMmbrCnt24Mo,maxcnt));
	self.attributes.version1.HHOccProfLicMmbrCnt						:= if(noDid, '-1', (string)min(le.HHOccProfLicMmbrCnt,maxcnt));
	self.attributes.version1.HHOccBusinessAssocMmbrCnt			:= if(noDid, '-1', (string)min(le.HHOccBusinessAssocMmbrCnt,maxcnt));
	self.attributes.version1.HHInterestSportPersonMmbrCnt		:= if(noDid, '-1', (string)min(le.HHInterestSportPersonMmbrCnt,maxcnt));	
	self.attributes.version1.RaATeenageMmbrCnt							:= if(noDid, '-1', (string)min(le.RaATeenageMmbrCnt,maxcnt));
	self.attributes.version1.RaAYoungAdultMmbrCnt						:= if(noDid, '-1', (string)min(le.RaAYoungAdultMmbrCnt,maxcnt));
	self.attributes.version1.RaAMiddleAgeMmbrCnt						:= if(noDid, '-1', (string)min(le.RaAMiddleAgeMmbrCnt,maxcnt));
	self.attributes.version1.RaASeniorMmbrCnt								:= if(noDid, '-1', (string)min(le.RaASeniorMmbrCnt,maxcnt));
	self.attributes.version1.RaAElderlyMmbrCnt							:= if(noDid, '-1', (string)min(le.RaAElderlyMmbrCnt,maxcnt));
	self.attributes.version1.RaAHHCnt												:= if(noDid, '-1', (string)min(le.RaAHHCnt,maxcnt));
	self.attributes.version1.RaAMmbrCnt											:= if(noDid, '-1', (string)min(le.RaAMmbrCnt,maxcnt));
	self.attributes.version1.RaAMedIncomeRange							:= map(noDid													=> '-1', 
																																 le.RaAMedIncomeRange > 150000	=> '11',
																																 le.RaAMedIncomeRange > 120000	=> '10',
																																 le.RaAMedIncomeRange > 100000	=> '9',
																																 le.RaAMedIncomeRange > 80000		=> '8',
																																 le.RaAMedIncomeRange > 60000		=> '7',
																																 le.RaAMedIncomeRange > 50000		=> '6',
																																 le.RaAMedIncomeRange > 40000		=> '5',
																																 le.RaAMedIncomeRange > 35000		=> '4',
																																 le.RaAMedIncomeRange > 30000		=> '3',
																																 le.RaAMedIncomeRange > 25000		=> '2',
																																 le.RaAMedIncomeRange > 0				=> '1',
																																																	 '-1');	
	self.attributes.version1.RaACollegeAttendedMmbrCnt			:= if(noDid, '-1', (string)min(le.RaACollegeAttendedMmbrCnt,maxcnt));
	self.attributes.version1.RaACollege2yrAttendedMmbrCnt		:= if(noDid, '-1', (string)min(le.RaACollege2yrAttendedMmbrCnt,maxcnt));
	self.attributes.version1.RaACollege4yrAttendedMmbrCnt		:= if(noDid, '-1', (string)min(le.RaACollege4yrAttendedMmbrCnt,maxcnt));
	self.attributes.version1.RaACollegeGradAttendedMmbrCnt	:= if(noDid, '-1', (string)min(le.RaACollegeGradAttendedMmbrCnt,maxcnt));
	self.attributes.version1.RaACollegePrivateMmbrCnt				:= if(noDid, '-1', (string)min(le.RaACollegePrivateMmbrCnt,maxcnt));
	self.attributes.version1.RaACollegeTopTierMmbrCnt				:= if(noDid, '-1', (string)min(le.RaACollegeTopTierMmbrCnt,maxcnt));
	self.attributes.version1.RaACollegeMidTierMmbrCnt				:= if(noDid, '-1', (string)min(le.RaACollegeMidTierMmbrCnt,maxcnt));
	self.attributes.version1.RaACollegeLowTierMmbrCnt				:= if(noDid, '-1', (string)min(le.RaACollegeLowTierMmbrCnt,maxcnt));
	self.attributes.version1.RaAPropCurrOwnerMmbrCnt				:= if(noDid, '-1', (string)min(le.RaAPropCurrOwnerMmbrCnt,maxcnt));
	self.attributes.version1.RaAPropOwnerAVMHighest					:= if(noDid, '-1', (string)min(le.RaAPropOwnerAVMHighest,nines));
	self.attributes.version1.RaAPropOwnerAVMMed							:= if(noDid, '-1', (string)min(le.RaAPropOwnerAVMMed,nines));
	self.attributes.version1.RaAPPCurrOwnerMmbrCnt					:= if(noDid, '-1', (string)min(le.RaAPPCurrOwnerMmbrCnt,maxcnt));
	self.attributes.version1.RaAPPCurrOwnerAutoMmbrCnt 			:= if(noDid, '-1', (string)min(le.RaAPPCurrOwnerAutoMmbrCnt,maxcnt));
	self.attributes.version1.RaAPPCurrOwnerMtrcycleMmbrCnt 	:= if(noDid, '-1', (string)min(le.RaAPPCurrOwnerMtrcycleMmbrCnt,maxcnt));
	self.attributes.version1.RaAPPCurrOwnerAircrftMmbrCnt 	:= if(noDid, '-1', (string)min(le.RaAPPCurrOwnerAircrftMmbrCnt,maxcnt));
	self.attributes.version1.RaAPPCurrOwnerWtrcrftMmbrCnt		:= if(noDid, '-1', (string)min(le.RaAPPCurrOwnerWtrcrftMmbrCnt,maxcnt));
	self.attributes.version1.RaACrtRecMmbrCnt								:= if(noDid, '-1', (string)min(le.RaACrtRecMmbrCnt,maxcnt));
	self.attributes.version1.RaACrtRecMmbrCnt12Mo						:= if(noDid, '-1', (string)min(le.RaACrtRecMmbrCnt12Mo,maxcnt));
	self.attributes.version1.RaACrtRecFelonyMmbrCnt					:= if(noDid, '-1', (string)min(le.RaACrtRecFelonyMmbrCnt,maxcnt));
	self.attributes.version1.RaACrtRecFelonyMmbrCnt12Mo			:= if(noDid, '-1', (string)min(le.RaACrtRecFelonyMmbrCnt12Mo,maxcnt));
	self.attributes.version1.RaACrtRecMsdmeanMmbrCnt				:= if(noDid, '-1', (string)min(le.RaACrtRecMsdmeanMmbrCnt,maxcnt));
	self.attributes.version1.RaACrtRecMsdmeanMmbrCnt12Mo		:= if(noDid, '-1', (string)min(le.RaACrtRecMsdmeanMmbrCnt12Mo,maxcnt));
	self.attributes.version1.RaACrtRecEvictionMmbrCnt				:= if(noDid, '-1', (string)min(le.RaACrtRecEvictionMmbrCnt,maxcnt));
	self.attributes.version1.RaACrtRecEvictionMmbrCnt12Mo		:= if(noDid, '-1', (string)min(le.RaACrtRecEvictionMmbrCnt12Mo,maxcnt));
	self.attributes.version1.RaACrtRecLienJudgMmbrCnt				:= if(noDid, '-1', (string)min(le.RaACrtRecLienJudgMmbrCnt,maxcnt));
	self.attributes.version1.RaACrtRecLienJudgMmbrCnt12Mo		:= if(noDid, '-1', (string)min(le.RaACrtRecLienJudgMmbrCnt12Mo,maxcnt));
	self.attributes.version1.RaACrtRecLienJudgAmtMax				:= if(noDid, '-1', (string)min(le.RaACrtRecLienJudgAmtMax, nines));
	self.attributes.version1.RaACrtRecBkrptMmbrCnt36Mo			:= if(noDid, '-1', (string)min(le.RaACrtRecBkrptMmbrCnt36Mo,maxcnt));
	self.attributes.version1.RaAOccProfLicMmbrCnt						:= if(noDid, '-1', (string)min(le.RaAOccProfLicMmbrCnt,maxcnt));
	self.attributes.version1.RaAOccBusinessAssocMmbrCnt			:= if(noDid, '-1', (string)min(le.RaAOccBusinessAssocMmbrCnt,maxcnt));
	self.attributes.version1.RaAInterestSportPersonMmbrCnt	:= if(noDid, '-1', (string)min(le.RaAInterestSportPersonMmbrCnt,maxcnt));
	
	// new attributes for RQ-13721
	self.attributes.version1.PPCurrOwnedAutoVIN	:= if(noDid, '-1', le.PPCurrOwnedAutoVIN);
	self.attributes.version1.PPCurrOwnedAutoYear	:= if(noDid, '-1', le.PPCurrOwnedAutoYear);
	self.attributes.version1.PPCurrOwnedAutoMake	:= if(noDid, '-1', le.PPCurrOwnedAutoMake);
	self.attributes.version1.PPCurrOwnedAutoModel	:= if(noDid, '-1', le.PPCurrOwnedAutoModel);
	self.attributes.version1.PPCurrOwnedAutoSeries	:= if(noDid, '-1', le.PPCurrOwnedAutoSeries);
	self.attributes.version1.PPCurrOwnedAutoType	:= if(noDid, '-1', le.PPCurrOwnedAutoType);
			
	self	:= le;
	self	:= [];
end;

attr := project(PBShell, getAttr(left)); 
																						
return attr;	
	
END;