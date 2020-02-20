IMPORT Models, Risk_Indicators,RiskWise, STD, Business_Risk_BIP, LNSmallBusiness;



EXPORT BBFM1811_1_0 (GROUPED DATASET(risk_indicators.Layout_Boca_Shell) clam,
                    grouped DATASET(Risk_Indicators.Layout_Output) iid, 
                     string30 account_value,
                     dataset(riskwise.Layout_IP2O) ips,
                     //string model_name='', //we are passing in attribute group name if paro attributes are requested instead of model name
                     boolean suppressCompromisedDLs=false,
                     unsigned1 DPPA=0, unsigned1 GLB=0,
                     string DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
                     string DataPermission=risk_indicators.iid_constants.default_DataPermission,
                     string32 appType = '',
                    grouped DATASET(Business_Risk_BIP.Layouts.Shell) busShell,
                    UNSIGNED BusShellVersion
                    ) := FUNCTION
 num_reasons   := 4;
 boolean business_only := FALSE;



// first run the clam thru atrribute as model was built from attributes 

FDA_attributes := Models.getFDAttributes( clam,
                                          iid,
                                          (string30)account_value,
                                          ips,
                                          '',
                                          false,
                                           DPPA, 
                                           GLB,
                                           DataRestriction,
                                           DataPermission,
                                           (string32)appType                                      
                                           );
                                           
 FDA_attributesplusclam_layout := record 
                     risk_indicators.Layout_Boca_Shell clam;
                     Business_Risk_BIP.Layouts.Shell busShell;
                     FDA_attributes;
                     string StolenIdentityIndex_V3;
                     string SyntheticIdentityIndex_V3;
                     string ManipulatedIdentityIndex_V3;
                     string VulnerableVictimIndex_V3;
                     string FriendlyFraudIndex_V3;
                     string SuspiciousActivityIndex_V3;
                     end;                                          
                                           
 FDA_attributesplusclam := join(FDA_attributes,clam,left.input.seq = RIGHT.seq,         
      transform (FDA_attributesplusclam_layout, 
      self.StolenIdentityIndex_V3   := right.FD_Scores.StolenIdentityIndex_V3,
      self.SyntheticIdentityIndex_V3  := right.FD_Scores.SyntheticIdentityIndex_V3,
      self.ManipulatedIdentityIndex_V3 := right.FD_Scores.ManipulatedIdentityIndex_V3,
      self.VulnerableVictimIndex_V3   := right.FD_Scores.VulnerableVictimIndex_V3,
      self.FriendlyFraudIndex_V3   := right.FD_Scores.FriendlyFraudIndex_V3,
      self.SuspiciousActivityIndex_V3 := right.FD_Scores.SuspiciousActivityIndex_V3,
      self.clam := right,
      self:=left,
      self:=[]
      ));
      
 
      
 FDA_attr_clam_busshell := join(FDA_attributesplusclam, busShell,
                                left.input.seq = right.Seq,
                                transform (FDA_attributesplusclam_layout,
                                self.busshell := right,
                                self := left
                                ));
 
 
 SBFA_atributes  := LNSmallBusiness.getSmallBusinessAttributes(ungroup(busShell),(UNSIGNED)BusShellVersion); 
 
 
	MODEL_DEBUG := FALSE;
	// MODEL_DEBUG := TRUE;

	isFCRA := False;


	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
                    
      unsigned seq                              ;
      integer beta_synthidindex                ;//:= (integer)le.version202.IdentitySyntheticRiskLevel;
			integer friendlyfraudindex               ;//:= (integer)le.FriendlyFraudIndex_V3;
			integer inputaddrlenofres                ;//:= (integer)le.version2.InputAddrLenOfRes;
			integer beta_srch_ssn_id_diff01          ;//:= (integer)le.version202.SearchSSNIdentitySearchCtDiff;
			integer beta_srch_perbestssn             ;//:= (integer)le.version202.SearchSSNBestSearchCt ;
			integer beta_srch_perphone_count01       ;//:= (integer)le.version202.SearchPhnSearchCt1Month;
			integer beta_m_src_credentialed_fs       ;//:= (integer)le.version202.SourceTypeCredentialAgeOldest;
			integer divaddrphonecount                ;//:= (integer)le.version2.divaddrphonecount;
			integer suspiciousactivityindex          ;//:= (integer)le.SuspiciousActivityIndex_V3;
			integer identityrisklevel                ;//:= (integer)le.version2.identityrisklevel;
			integer inputaddrassessedtotal           ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inputaddrassessedtotal);
			integer beta_srch_perphone_count03       ;//:= (integer)le.version202.SearchPhnSearchCt3Month;
			integer divssnaddrcount                  ;//:= (integer)le.version2.divssnaddrcount;
			integer beta_srch_perphone_count06       ;//:= (integer)le.version202.SearchPhnSearchCtNew;
			integer searchbankingsearchcount         ;//:= (integer)le.version2.searchbankingsearchcount;
			integer beta_srch_phnsperid_1subs        ;//:= (integer)le.version202.VariationSearchPhone1SubCt;
			integer beta_addr_bureau_only            ;//:= (integer)le.version202.SourceCreditBureauVerAddr;
			integer beta_srch_corraddrssn_id         ;//:= (integer)le.version202.CorrSearchVerSSNAddrCt;
			integer sourcecreditbureauagechange      ;//:= (integer)le.version2.sourcecreditbureauagechange;
			integer correlationrisklevel             ;//:= (integer)le.version2.correlationrisklevel;
			integer beta_srch_ssnsperid_count03      ;//:= (integer)le.version202.VariationSearchSSNCt3Month;
			integer sourcerisklevel                  ;//:= (integer)le.version2.sourcerisklevel;
			integer businessactivity06month          ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.BusinessActivity06Month);
			integer idverdob                         ;//:= (integer)le.version2.idverdob;
			integer busexeclinkbusaddrauthrepowned   ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busexeclinkbusaddrauthrepowned);
			integer divaddridentitycountnew          ;//:= (integer)le.version2.divaddridentitycountnew;
			integer beta_srch_dobsperssn_count01     ;//:= (integer)le.version202.DivSearchSSNDOBCt1Month;
			integer sourcedriverslicense             ;//:= (integer)le.version201.sourcedriverslicense;
			integer inputaddrageoldest               ;//:= (integer)le.version2.inputaddrageoldest;
			integer divaddridentitycount             ;//:= (integer)le.version2.divaddridentitycount;
			integer beta_rel_count_for_bureau_only   ;//:= (integer)le.version202.AssocCBOIdentityCt;
			integer inputaddroccupantowned           ;//:= (integer)le.version2.inputaddroccupantowned;
			integer beta_srch_ssnsperaddr_count06    ;//:= (integer)le.version202.DivSearchAddrSSNCtNew;
			integer searchssnsearchcountyear         ;//:= (integer)le.version2.searchssnsearchcountyear;
			integer prevaddragenewest                ;//:= (integer)le.version2.prevaddragenewest;
			integer searchcount                      ;//:= (integer)le.version2.searchcount;
			string prevaddrstatus                   ;//:= (integer)le.version2.prevaddrstatus;
			integer prevaddrageoldest                ;//:= (integer)le.version2.prevaddrageoldest;
			integer busaddrpersonnameoverlap         ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busaddrpersonnameoverlap);
			integer inputphoneproblems               ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inputphoneproblems);
			integer divaddridentitymsourcecount      ;//:= (integer)le.version2.divaddridentitymsourcecount;
			integer beta_srch_corrnameaddrssn        ;//:= (integer)le.version202.CorrSearchSSNAddrNameCt;
			integer beta_srch_corrdobaddr            ;//:= (integer)le.version202.CorrSearchAddrDOBCt;
			integer divssnlnamecount                 ;//:= (integer)le.version2.divssnlnamecount;
			integer businessrecordtimeoldest         ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.businessrecordtimeoldest);
			integer beta_srch_addrsperssn_count01    ;//:= (integer)le.version202.DivSearchSSNAddrCt1Month;
			integer vulnerablevictimindex            ;//:= (integer)le.VulnerableVictimIndex_V3;
			integer beta_srch_addrsperid_count06     ;//:= (integer)le.version202.VariationSearchAddrCtNew;
			integer searchlocatesearchcount          ;//:= (integer)le.version2.searchlocatesearchcount;
			integer searchbankingsearchcountyear     ;//:= (integer)le.version2.searchbankingsearchcountyear;
			integer divaddrphonemsourcecount         ;//:= (integer)le.version2.divaddrphonemsourcecount;
			integer associatejudgmentcount           ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.associatejudgmentcount);
			integer inputaddrsqfootage               ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inputaddrsqfootage);
			integer sbfeavgutilever                  ;//:= (integer)rt.sbfeavgutilever;
			integer variationdobcountnew             ;//:= (integer)le.version2.variationdobcountnew;
			integer beta_srch_phonesperid_count01    ;//:= (integer)le.version202.VariationSearchPhoneCtMonth;
			integer idverrisklevel                   ;//:= (integer)le.version2.idverrisklevel;
			integer idverphone                       ;//:= (integer)le.version2.idverphone;
			integer divsearchssnidentitycount        ;//:= (integer)le.version2.divsearchssnidentitycount;
			integer beta_srch_ssnsperaddr_count03    ;//:= (integer)le.version202.DivSearchAddrSSNCt3Month;
			integer beta_m_src_other_fs              ;//:= (integer)le.version202.SourceTypeOtherAgeOldest;
			integer correlationphonelastnamecount    ;//:= (integer)le.version2.correlationphonelastnamecount;
			integer identityrecordcount              ;//:= (integer)le.version2.identityrecordcount;
			integer syntheticidentityindex           ;//:= (integer)le.SyntheticIdentityIndex_V3;
			integer beta_srch_corraddrssn            ;//:= (integer)le.version202.CorrSearchSSNAddrCt;
			integer curraddrlenofres                 ;//:= (integer)le.version2.curraddrlenofres;
			integer sourceaccidents                  ;//:= (integer)le.version2.sourceaccidents;
			integer beta_corraddrdob                 ;//:= (integer)le.version202.CorrAddrDOBCt;
			integer divphoneidentitycount            ;//:= (integer)le.version2.divphoneidentitycount;
			integer sourcecreditbureauageoldest      ;//:= (integer)le.version2.sourcecreditbureauageoldest;
			integer associatebankruptcount           ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.associatebankruptcount);
			integer assocsuspicousidentitiescount    ;//:= (integer)le.version2.assocsuspicousidentitiescount;
			integer beta_srch_idsperphone            ;//:= (integer)le.version202.DivSearchPhoneIdentityCt;
			integer validationssnproblems            ;//:= (integer)le.version2.validationssnproblems;
			integer divaddrssncountnew               ;//:= (integer)le.version2.divaddrssncountnew;
			integer businessactivity12month          ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.businessactivity12month);
			integer idveraddressassoccount           ;//:= (integer)le.version2.idveraddressassoccount;
			integer beta_srch_addrsperid_count01     ;//:= (integer)le.version202.VariationSearchAddrCtMonth;
			integer divaddrssnmsourcecount           ;//:= (integer)le.version2.divaddrssnmsourcecount;
			integer verificationbusinputphone        ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.verificationbusinputphone);
			integer correlationaddrnamecount         ;//:= (integer)le.version2.correlationaddrnamecount;
			integer divaddrssncount                  ;//:= (integer)le.version2.divaddrssncount;
			integer correlationssnaddrcount          ;//:= (integer)le.version2.correlationssnaddrcount;
			integer sourceproperty                   ;//:= (integer)le.version2.sourceproperty;
			integer sbfeavgbalance03m                ;//:= (integer)rt.SBFEAvgBalance03M;
			integer divaddrsuspidentitycountnew      ;//:= (integer)le.version2.divaddrsuspidentitycountnew;
			integer beta_srch_corrdobssn_id          ;//:= (integer)le.version202.CorrSearchVerSSNDOBCt;
			integer searchphonesearchcountyear       ;//:= (integer)le.version2.searchphonesearchcountyear;
			integer beta_sum_src_credentialed        ;//:= (integer)le.version202.SourceTypeCredentialCt;
			integer searchaddrsearchcountyear        ;//:= (integer)le.version2.searchaddrsearchcountyear;
			integer variationrisklevel               ;//:= (integer)le.version2.variationrisklevel;
			integer sbfeverbusaddr                   ;//:= (integer)rt.SBFEVerBusAddr;
			integer sourcephonedirectoryassistance   ;//:= (integer)le.version2.sourcephonedirectoryassistance;
			integer idveraddress                     ;//:= (integer)le.version2.idveraddress;
			integer beta_srch_ssnsperaddr_count01    ;//:= (integer)le.version202.DivSearchAddrSSNCt1Month;
			integer assochighrisktopologycount       ;//:= (integer)le.version2.assochighrisktopologycount;
			integer beta_srch_lnamesperid_count03    ;//:= (integer)le.version202.VariationSearchLNameCt3Month;
			integer inquiry03month                   ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inquiry03month);
			integer searchaddrsearchcount            ;//:= (integer)le.version2.searchaddrsearchcount;
			integer sourcepublicrecord               ;//:= (integer)le.version2.sourcepublicrecord;
			integer sbfeopencount06m                 ;//:= (integer)rt.SBFEOpenCount06M;
			integer divssnaddrmsourcecount           ;//:= (integer)le.version2.divssnaddrmsourcecount;
			integer beta_cpnindex                    ;//:= (integer)le.version202.IdentityManipSSNRiskLevel;
			integer idverssnsourcecount              ;//:= (integer)le.version2.idverssnsourcecount;
			integer searchssnsearchcountmonth        ;//:= (integer)le.version2.searchssnsearchcountmonth;
			integer identityageoldest                ;//:= (integer)le.version2.identityageoldest;
			integer variationlastnamecount           ;//:= (integer)le.version2.variationlastnamecount;
			integer beta_srch_corrnamephone          ;//:= (integer)le.version202.CorrSearchNamePhoneCt;
			integer searchfraudsearchcountyear       ;//:= (integer)le.version2.searchfraudsearchcountyear;
			integer variationphonecountnew           ;//:= (integer)le.version2.variationphonecountnew;
			integer searchcountyear                  ;//:= (integer)le.version2.searchcountyear;
			integer businessactivity03month          ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.businessactivity03month);
			integer busfeinpersonaddroverlap         ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busfeinpersonaddroverlap);
			integer inquirycredit12month             ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inquirycredit12month);
			integer beta_sum_src_other               ;//:= (integer)le.version202.SourceTypeOtherCt;
			integer searchphonesearchcount           ;//:= (integer)le.version2.searchphonesearchcount;
			integer idveraddresssourcecount          ;//:= (integer)le.version2.idveraddresssourcecount;
			integer variationaddrchangeage           ;//:= (integer)le.version2.variationaddrchangeage;
			integer searchcomponentrisklevel         ;//:= (integer)le.version2.searchcomponentrisklevel;
			integer sbferecentbalancecardamt         ;//:= (integer)rt.SBFERecentBalanceCardAmt;
			integer beta_fla_fld_bureau_no_ssn_flag  ;//:= (integer)le.version202.SourceCreditBureauNotSSNVer;
			integer sbfehighbalancecard60m           ;//:= (integer)rt.SBFEHighBalanceCard60M;
			integer beta_srch_addrsperid_count03     ;//:= (integer)le.version202.VariationSearchAddrCt3Month;
			integer divphoneidentitymsourcecount     ;//:= (integer)le.version2.divphoneidentitymsourcecount;
			integer searchcountmonth                 ;//:= (integer)le.version2.searchcountmonth;
			integer sbfetimeoldest                   ;//:= (integer)rt.SBFETimeOldest;
			integer sbfeclosedvoluntarycount         ;//:= (integer)rt.SBFEClosedVoluntaryCount;
			integer sbfeavgbalanceever               ;//:= (integer)rt.SBFEAvgBalanceEver;
			integer inputaddractivephonelist         ;//:= (integer)le.version2.inputaddractivephonelist;
			integer variationphonecount              ;//:= (integer)le.version2.variationphonecount;
			integer searchphonesearchcountmonth      ;//:= (integer)le.version2.searchphonesearchcountmonth;
			integer assoccount                       ;//:= (integer)le.version2.assoccount;
			integer sbfehighbalance24m               ;//:= (integer)rt.sbfehighbalance24m;
			integer validationphoneproblems          ;//:= (integer)le.version2.validationphoneproblems;
			integer beta_srch_corrnamessn_id         ;//:= (integer)le.version202.CorrSearchVerSSNNameCt;
			integer curraddrageoldest                ;//:= (integer)le.version2.curraddrageoldest;
			integer variationsearchphonecount        ;//:= (integer)le.version2.variationsearchphonecount;
			integer divsearchaddridentitycount       ;//:= (integer)le.version2.divsearchaddridentitycount;
			integer divaddrphonecountnew             ;//:= (integer)le.version2.divaddrphonecountnew;
			integer beta_corrnamedob                 ;//:= (integer)le.version202.CorrNameDOBCt;
			integer divsearchaddrsuspidentitycount   ;//:= (integer)le.version2.divsearchaddrsuspidentitycount;
			integer searchfraudsearchcount           ;//:= (integer)le.version2.searchfraudsearchcount;
			integer associatecountycount             ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.associatecountycount);
			integer sourcevehicleregistration        ;//:= (integer)le.version201.sourcevehicleregistration;
			integer idverdobsourcecount              ;//:= (integer)le.version2.idverdobsourcecount;
			integer idverssncreditbureaucount        ;//:= (integer)le.version2.idverssncreditbureaucount;
			integer variationsearchaddrcount         ;//:= (integer)le.version2.variationsearchaddrcount;
			integer beta_srch_nonbank_recency        ;//:= (integer)le.version202.SearchNonBankSearchCtRecency;
			integer beta_srch_corraddrphone          ;//:= (integer)le.version202.CorrSearchAddrPhoneCt;
			integer searchfraudsearchcountmonth      ;//:= (integer)le.version2.searchfraudsearchcountmonth;
			integer beta_dob_bureau_only             ;//:= (integer)le.version202.SourceCreditBureauVerDOB;
			integer inquiryconsumerphone             ;//:=  if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inquiryconsumerphone);
			integer beta_srch_corrnamephone_id       ;//:= (integer)le.version202.CorrSearchVerNamePhoneCt;
			integer sbfelastpaymentamt               ;//:= (integer)rt.SBFELastPaymentAmt;
			integer beta_hh_members_for_bureau_only  ;//:= (integer)le.version202.AssocCBOHHMemberCt;
			integer divrisklevel                     ;//:= (integer)le.version2.divrisklevel;
			integer sbfeopencount36m                 ;//:= (integer)rt.SBFEOpenCount36M;
			integer sbfehighutilrevolvingamt         ;//:= (integer)rt.SBFEHighUtilRevolvingAmt;
			integer sbfelimitcardamt06m              ;//:= (integer)rt.SBFELimitCardAmt06M;
			integer searchlocatesearchcountyear      ;//:= (integer)le.version2.searchlocatesearchcountyear;
			integer componentcharrisklevel           ;//:= (integer)le.version2.componentcharrisklevel;
			integer busexeclinkauthrepnameonfile     ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busexeclinkauthrepnameonfile);
			integer searchhighrisksearchcount        ;//:= (integer)le.version2.searchhighrisksearchcount;
			integer identitysourcecount              ;//:= (integer)le.version2.identitysourcecount;
			integer correlationssnnamecount          ;//:= (integer)le.version2.correlationssnnamecount;
			integer beta_srch_corrdobaddr_id         ;//:= (integer)le.version202.CorrSearchVerAddrDOBCt;
			integer sourcecreditbureau               ;//:= (integer)le.version2.sourcecreditbureau;
			integer sbfebalanceamt12m                ;//:= (integer)rt.sbfebalanceamt12m;
			integer searchbankingsearchcountmonth    ;//:= (integer)le.version2.searchbankingsearchcountmonth;
			integer beta_srch_dobsperid_count01      ;//:= (integer)le.version202.VariationSearchDOBCtMonth;
			integer beta_srch_corrnamessn            ;//:= (integer)le.version202.CorrSearchSSNNameCt;
			integer assocrisklevel                   ;//:= (integer)le.version2.assocrisklevel;
			integer sbfetimeoldestcard               ;//:= (integer)rt.sbfetimeoldestcard;
			integer sbfehighutilcardamt              ;//:= (integer)rt.sbfehighutilcardamt;
			integer divphoneaddrcount                ;//:= (integer)le.version2.divphoneaddrcount;
			integer searchunverifiedaddrcountyear    ;//:= (integer)le.version2.searchunverifiedaddrcountyear;
			integer beta_srch_idsperphone_count01    ;//:= (integer)le.version202.DivSearchPhoneIdentityCt1Month;
			integer curraddractivephonelist          ;//:= (integer)le.version2.curraddractivephonelist;
			integer sbfedelqavgamt84m                ;//:= (integer)rt.sbfedelqavgamt84m;
			integer variationmsourcesssncount        ;//:= (integer)le.version2.variationmsourcesssncount;
			integer sbfeavgutilcardever              ;//:= (integer)rt.SBFEAvgUtilCardEver;
			integer sbfeopencount84m                 ;//:= (integer)rt.SBFEOpenCount84M;
			integer variationsearchssncount          ;//:= (integer)le.version2.variationsearchssncount;
			integer searchssnsearchcount             ;//:= (integer)le.version2.searchssnsearchcount;
			integer sbfehighbalanceloan24m           ;//:= (integer)rt.sbfehighbalanceloan24m;
			integer beta_srch_idsperssn_count03      ;//:= (integer)le.version202.DivSearchSSNIdentityCt3Month;
			integer variationaddrstability           ;//:= (integer)le.version2.variationaddrstability;
			integer sourcefirstreportingidentity     ;//:= (integer)le.version2.sourcefirstreportingidentity;
			integer sbfehighbalance84m               ;//:= (integer)rt.sbfehighbalance84m;
			integer businessrecordupdated12month     ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.businessrecordupdated12month);
			integer prevaddrlenofres                 ;//:= (integer)le.version2.prevaddrlenofres;
			string curraddrstatus                   ;//:= (integer)le.version2.curraddrstatus;
			integer searchvelocityrisklevel          ;//:= (integer)le.version2.searchvelocityrisklevel;
			integer addrchangedistance               ;//:= (integer)le.version2.addrchangedistance;
			integer sourcepublicrecordcount          ;//:= (integer)le.version2.sourcepublicrecordcount;
			integer beta_srch_corrdobphone           ;//:= (integer)le.version202.CorrSearchDOBPhoneCt;
			integer beta_srch_phonesperid_count03    ;//:= (integer)le.version202.VariationSearchPhoneCt3Month;
			integer variationaddrcountyear           ;//:= (integer)le.version2.variationaddrcountyear;
			integer sbfedelq01amt12m                 ;//:= (integer)rt.sbfedelq01amt12m;
			integer inputaddrlotsize                 ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inputaddrlotsize);
			integer sbfelegalstructure               ;//:= (integer)rt.sbfelegalstructure;
			integer beta_srch_corrphonessn           ;//:= (integer)le.version202.CorrSearchSSNPhoneCt;
			integer beta_srch_idsperssn_count01      ;//:= (integer)le.version202.DivSearchSSNIdentityCt1Month;
			integer beta_srch_addrsperssn_count03    ;//:= (integer)le.version202.DivSearchSSNAddrCt3Month;
			integer idverssn                         ;//:= (integer)le.version2.idverssn;
			integer beta_ssn_bureau_only             ;//:= (integer)le.version202.SourceCreditBureauVerSSN;
			integer beta_corrssndob                  ;//:= (integer)le.version202.CorrSSNDOBCt;
			integer divssnidentitymsourceurelcount   ;//:= (integer)le.version2.divssnidentitymsourceurelcount;
			integer verificationbusinputaddr         ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.verificationbusinputaddr);
			integer beta_srch_primrangesperid_1subs  ;//:= (integer)le.version202.VariationSearchAddr1SubCt;
			integer associatecount                   ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.associatecount);
			integer sbfetimenewest                   ;//:= (integer)rt.sbfetimenewest;
			integer sbfeavgbalance84m                ;//:= (integer)rt.sbfeavgbalance84m;
			integer sbfeavgutilcard12m               ;//:= (integer)rt.sbfeavgutilcard12m;
			integer divssnidentitymsourcecount       ;//:= (integer)le.version2.divssnidentitymsourcecount;
			integer beta_bureau_only_index           ;//:= (integer)le.version202.SourceCreditBureauCBOCt;
			integer sbfeavgbalanceloan24m            ;//:= (integer)rt.sbfeavgbalanceloan24m;
			integer beta_srch_corrnamephonessn       ;//:= (integer)le.version202.CorrSearchSSNNamePhoneCt;
			integer sbfedelq91revcountever           ;//:= (integer)rt.sbfedelq91revcountever;
			integer variationmsourcesssnunrelcount   ;//:= (integer)le.version2.variationmsourcesssnunrelcount;
			integer sbfeprincipalaccountcount        ;//:= (integer)rt.sbfeprincipalaccountcount;
			integer busexeclinkauthrepssnonfile      ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busexeclinkauthrepssnonfile);
			integer sbfebalancecount12m              ;//:= (integer)rt.sbfebalancecount12m;
			integer sbfetimeoldestcycle              ;//:= (integer)rt.sbfetimeoldestcycle;
			integer searchunverifieddobcountyear     ;//:= (integer)le.version2.searchunverifieddobcountyear;
			integer beta_srch_corraddrphone_id       ;//:= (integer)le.version202.CorrSearchVerAddrPhoneCt;
			integer divssnidentitycount              ;//:= (integer)le.version2.divssnidentitycount;
			integer variationlastnamecountnew        ;//:= (integer)le.version2.variationlastnamecountnew;
			integer sostimeincorporation             ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.sostimeincorporation);
			integer sbfeavgbalance06m                ;//:= (integer)rt.sbfeavgbalance06m;
			integer sbfeavgutilcard36m               ;//:= (integer)rt.sbfeavgutilcard36m;
			integer sbfebalancecountever             ;//:= (integer)rt.sbfebalancecountever;
			integer sbfedelq91cardcountever          ;//:= (integer)rt.sbfedelq91cardcountever;
			integer sbfebalanceamt60m                ;//:= (integer)rt.SBFEBalanceAmt60M;
			integer sbfeavgbalancecardever           ;//:= (integer)rt.sbfeavgbalancecardever;
			integer divssnaddrcountnew               ;//:= (integer)le.version2.divssnaddrcountnew;
			integer sbfelastpaymentcardamt           ;//:= (integer)rt.sbfelastpaymentcardamt;
			integer busfeinpersonoverlap             ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busfeinpersonoverlap);
			integer sbfehighbalance03m               ;//:= (integer)rt.sbfehighbalance03m;
			integer beta_srch_lnamesperaddr_count03  ;//:= (integer)le.version202.DivSearchAddrLNameCt3Month;
			integer sbfehitindex                     ;//:= (integer)rt.sbfehitindex;
			integer beta_srch_corrnameaddrphnssn     ;//:= (integer)le.version202.CorrSearchVerSSNAddrNamePhneCt;
			integer sbfeavgbalancecard12m            ;//:= (integer)rt.sbfeavgbalancecard12m;
			integer idveraddressmatchescurrent       ;//:= (integer)le.version201.idveraddressmatchescurrent;
			integer stolenidentityindex              ;//:= (integer)le.StolenIdentityIndex_V3;
			string curraddrdwelltype                ;//:= (integer)le.version2.curraddrdwelltype;
			integer sbfebalancecount03m              ;//:= (integer)rt.sbfebalancecount03m;
			integer beta_srch_idsperssn_count06      ;//:= (integer)le.version202.DivSearchSSNIdentityCtNew;
			integer beta_source_type                 ;//:= (integer)le.version202.SourceTypeIndicator;
			integer sbfehighbalance12m               ;//:= (integer)rt.sbfehighbalance12m;
			integer sbfeavgutilcard24m               ;//:= (integer)rt.sbfeavgutilcard24m;
			integer assoccreditbureauonlycount       ;//:= (integer)le.version2.assoccreditbureauonlycount;
			integer variationdobcount                ;//:= (integer)le.version2.variationdobcount;
			integer sbfeavgutil12m                   ;//:= (integer)rt.sbfeavgutil12m;
			integer sbfeavgutil84m                   ;//:= (integer)rt.sbfeavgutil84m;
			integer sbfepaymentduecardamt            ;//:= (integer)rt.sbfepaymentduecardamt;
			integer verificationbusinputname         ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.verificationbusinputname);
			integer businessrecordtimenewest         ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.businessrecordtimenewest);
			integer beta_input_lname_isbestmatch     ;//:= (integer)le.version202.IDVerLNameBest;
			integer beta_srch_corrnamephonessn_id    ;//:= (integer)le.version202.CorrSearchVerSSNNamePhoneCt;
			integer idveraddressnotcurrent           ;//:= (integer)le.version2.idveraddressnotcurrent;
			integer beta_srch_corrdobssn             ;//:= (integer)le.version202.CorrSearchSSNDOBCt;
			integer sbfetimenewestcycle              ;//:= (integer)rt.sbfetimenewestcycle;
			integer inputphonemobile                 ;//:= if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inputphonemobile);

                    real model1_attrsv4_tree_0           ;// := model1_attrsv4_tree_0;
                    real  model1_attrsv4_tree_1           ;// := model1_attrsv4_tree_1;
                    real  model1_attrsv4_tree_2           ;// := model1_attrsv4_tree_2;
                    real  model1_attrsv4_tree_3           ;// := model1_attrsv4_tree_3;
                    real  model1_attrsv4_tree_4           ;// := model1_attrsv4_tree_4;
                    real  model1_attrsv4_tree_5           ;// := model1_attrsv4_tree_5;
                    real  model1_attrsv4_tree_6           ;// := model1_attrsv4_tree_6;
                    real  model1_attrsv4_tree_7           ;// := model1_attrsv4_tree_7;
                    real  model1_attrsv4_tree_8           ;// := model1_attrsv4_tree_8;
                    real  model1_attrsv4_tree_9           ;// := model1_attrsv4_tree_9;
                    real  model1_attrsv4_tree_10          ;// := model1_attrsv4_tree_10;
                    real  model1_attrsv4_tree_11          ;// := model1_attrsv4_tree_11;
                    real  model1_attrsv4_tree_12          ;// := model1_attrsv4_tree_12;
                    real  model1_attrsv4_tree_13          ;// := model1_attrsv4_tree_13;
                    real  model1_attrsv4_tree_14          ;// := model1_attrsv4_tree_14;
                    real  model1_attrsv4_tree_15          ;// := model1_attrsv4_tree_15;
                    real  model1_attrsv4_tree_16          ;// := model1_attrsv4_tree_16;
                    real  model1_attrsv4_tree_17          ;// := model1_attrsv4_tree_17;
                    real  model1_attrsv4_tree_18          ;// := model1_attrsv4_tree_18;
                    real  model1_attrsv4_tree_19          ;// := model1_attrsv4_tree_19;
                    real  model1_attrsv4_tree_20          ;// := model1_attrsv4_tree_20;
                    real  model1_attrsv4_tree_21          ;// := model1_attrsv4_tree_21;
                    real  model1_attrsv4_tree_22          ;// := model1_attrsv4_tree_22;
                    real  model1_attrsv4_tree_23          ;// := model1_attrsv4_tree_23;
                    real  model1_attrsv4_tree_24          ;// := model1_attrsv4_tree_24;
                    real  model1_attrsv4_tree_25          ;// := model1_attrsv4_tree_25;
                    real  model1_attrsv4_tree_26          ;// := model1_attrsv4_tree_26;
                    real  model1_attrsv4_tree_27          ;// := model1_attrsv4_tree_27;
                    real  model1_attrsv4_tree_28          ;// := model1_attrsv4_tree_28;
                    real  model1_attrsv4_tree_29          ;// := model1_attrsv4_tree_29;
                    real  model1_attrsv4_tree_30          ;// := model1_attrsv4_tree_30;
                    real  model1_attrsv4_tree_31          ;// := model1_attrsv4_tree_31;
                    real  model1_attrsv4_tree_32          ;// := model1_attrsv4_tree_32;
                    real  model1_attrsv4_tree_33          ;// := model1_attrsv4_tree_33;
                    real  model1_attrsv4_tree_34          ;// := model1_attrsv4_tree_34;
                    real  model1_attrsv4_tree_35          ;// := model1_attrsv4_tree_35;
                    real  model1_attrsv4_tree_36          ;// := model1_attrsv4_tree_36;
                    real  model1_attrsv4_tree_37          ;// := model1_attrsv4_tree_37;
                    real  model1_attrsv4_tree_38          ;// := model1_attrsv4_tree_38;
                    real  model1_attrsv4_tree_39          ;// := model1_attrsv4_tree_39;
                    real  model1_attrsv4_tree_40          ;// := model1_attrsv4_tree_40;
                    real  model1_attrsv4_tree_41          ;// := model1_attrsv4_tree_41;
                    real  model1_attrsv4_tree_42          ;// := model1_attrsv4_tree_42;
                    real  model1_attrsv4_tree_43          ;// := model1_attrsv4_tree_43;
                    real  model1_attrsv4_tree_44          ;// := model1_attrsv4_tree_44;
                    real  model1_attrsv4_tree_45          ;// := model1_attrsv4_tree_45;
                    real  model1_attrsv4_tree_46          ;// := model1_attrsv4_tree_46;
                    real  model1_attrsv4_tree_47          ;// := model1_attrsv4_tree_47;
                    real  model1_attrsv4_tree_48          ;// := model1_attrsv4_tree_48;
                    real  model1_attrsv4_tree_49          ;// := model1_attrsv4_tree_49;
                    real  model1_attrsv4_tree_50          ;// := model1_attrsv4_tree_50;
                    real  model1_attrsv4_tree_51          ;// := model1_attrsv4_tree_51;
                    real  model1_attrsv4_tree_52          ;// := model1_attrsv4_tree_52;
                    real  model1_attrsv4_tree_53          ;// := model1_attrsv4_tree_53;
                    real  model1_attrsv4_tree_54          ;// := model1_attrsv4_tree_54;
                    real  model1_attrsv4_tree_55          ;// := model1_attrsv4_tree_55;
                    real  model1_attrsv4_tree_56          ;// := model1_attrsv4_tree_56;
                    real  model1_attrsv4_tree_57          ;// := model1_attrsv4_tree_57;
                    real  model1_attrsv4_tree_58          ;// := model1_attrsv4_tree_58;
                    real  model1_attrsv4_tree_59          ;// := model1_attrsv4_tree_59;
                    real  model1_attrsv4_tree_60          ;// := model1_attrsv4_tree_60;
                    real  model1_attrsv4_tree_61          ;// := model1_attrsv4_tree_61;
                    real  model1_attrsv4_tree_62          ;// := model1_attrsv4_tree_62;
                    real  model1_attrsv4_tree_63          ;// := model1_attrsv4_tree_63;
                    real  model1_attrsv4_tree_64          ;// := model1_attrsv4_tree_64;
                    real  model1_attrsv4_tree_65          ;// := model1_attrsv4_tree_65;
                    real  model1_attrsv4_tree_66          ;// := model1_attrsv4_tree_66;
                    real  model1_attrsv4_tree_67          ;// := model1_attrsv4_tree_67;
                    real  model1_attrsv4_tree_68          ;// := model1_attrsv4_tree_68;
                    real  model1_attrsv4_tree_69          ;// := model1_attrsv4_tree_69;
                    real  model1_attrsv4_tree_70          ;// := model1_attrsv4_tree_70;
                    real  model1_attrsv4_tree_71          ;// := model1_attrsv4_tree_71;
                    real  model1_attrsv4_tree_72          ;// := model1_attrsv4_tree_72;
                    real  model1_attrsv4_tree_73          ;// := model1_attrsv4_tree_73;
                    real  model1_attrsv4_tree_74          ;// := model1_attrsv4_tree_74;
                    real  model1_attrsv4_tree_75          ;// := model1_attrsv4_tree_75;
                    real  model1_attrsv4_tree_76          ;// := model1_attrsv4_tree_76;
                    real  model1_attrsv4_tree_77          ;// := model1_attrsv4_tree_77;
                    real  model1_attrsv4_tree_78          ;// := model1_attrsv4_tree_78;
                    real  model1_attrsv4_tree_79          ;// := model1_attrsv4_tree_79;
                    real  model1_attrsv4_tree_80          ;// := model1_attrsv4_tree_80;
                    real  model1_attrsv4_tree_81          ;// := model1_attrsv4_tree_81;
                    real  model1_attrsv4_tree_82          ;// := model1_attrsv4_tree_82;
                    real  model1_attrsv4_tree_83          ;// := model1_attrsv4_tree_83;
                    real  model1_attrsv4_tree_84          ;// := model1_attrsv4_tree_84;
                    real  model1_attrsv4_tree_85          ;// := model1_attrsv4_tree_85;
                    real  model1_attrsv4_tree_86          ;// := model1_attrsv4_tree_86;
                    real  model1_attrsv4_tree_87          ;// := model1_attrsv4_tree_87;
                    real  model1_attrsv4_tree_88          ;// := model1_attrsv4_tree_88;
                    real  model1_attrsv4_tree_89          ;// := model1_attrsv4_tree_89;
                    real  model1_attrsv4_tree_90          ;// := model1_attrsv4_tree_90;
                    real  model1_attrsv4_tree_91          ;// := model1_attrsv4_tree_91;
                    real  model1_attrsv4_tree_92          ;// := model1_attrsv4_tree_92;
                    real  model1_attrsv4_tree_93          ;// := model1_attrsv4_tree_93;
                    real  model1_attrsv4_tree_94          ;// := model1_attrsv4_tree_94;
                    real  model1_attrsv4_tree_95          ;// := model1_attrsv4_tree_95;
                    real  model1_attrsv4_tree_96          ;// := model1_attrsv4_tree_96;
                    real  model1_attrsv4_tree_97          ;// := model1_attrsv4_tree_97;
                    real  model1_attrsv4_tree_98          ;// := model1_attrsv4_tree_98;
                    real  model1_attrsv4_tree_99          ;// := model1_attrsv4_tree_99;
                    real  model1_attrsv4_tree_100         ;// := model1_attrsv4_tree_100;
                    real  model1_attrsv4_tree_101         ;// := model1_attrsv4_tree_101;
                    real  model1_attrsv4_tree_102         ;// := model1_attrsv4_tree_102;
                    real  model1_attrsv4_tree_103         ;// := model1_attrsv4_tree_103;
                    real  model1_attrsv4_tree_104         ;// := model1_attrsv4_tree_104;
                    real  model1_attrsv4_tree_105         ;// := model1_attrsv4_tree_105;
                    real  model1_attrsv4_tree_106         ;// := model1_attrsv4_tree_106;
                    real  model1_attrsv4_tree_107         ;// := model1_attrsv4_tree_107;
                    real  model1_attrsv4_tree_108         ;// := model1_attrsv4_tree_108;
                    real  model1_attrsv4_tree_109         ;// := model1_attrsv4_tree_109;
                    real  model1_attrsv4_tree_110         ;// := model1_attrsv4_tree_110;
                    real  model1_attrsv4_tree_111         ;// := model1_attrsv4_tree_111;
                    real  model1_attrsv4_tree_112         ;// := model1_attrsv4_tree_112;
                    real  model1_attrsv4_tree_113         ;// := model1_attrsv4_tree_113;
                    real  model1_attrsv4_tree_114         ;// := model1_attrsv4_tree_114;
                    real  model1_attrsv4_tree_115         ;// := model1_attrsv4_tree_115;
                    real  model1_attrsv4_tree_116         ;// := model1_attrsv4_tree_116;
                    real  model1_attrsv4_tree_117         ;// := model1_attrsv4_tree_117;
                    real  model1_attrsv4_tree_118         ;// := model1_attrsv4_tree_118;
                    real  model1_attrsv4_tree_119         ;// := model1_attrsv4_tree_119;
                    real  model1_attrsv4_tree_120         ;// := model1_attrsv4_tree_120;
                    real  model1_attrsv4_tree_121         ;// := model1_attrsv4_tree_121;
                    real  model1_attrsv4_tree_122         ;// := model1_attrsv4_tree_122;
                    real  model1_attrsv4_tree_123         ;// := model1_attrsv4_tree_123;
                    real  model1_attrsv4_tree_124         ;// := model1_attrsv4_tree_124;
                    real  model1_attrsv4_tree_125         ;// := model1_attrsv4_tree_125;
                    real  model1_attrsv4_tree_126         ;// := model1_attrsv4_tree_126;
                    real  model1_attrsv4_tree_127         ;// := model1_attrsv4_tree_127;
                    real  model1_attrsv4_tree_128         ;// := model1_attrsv4_tree_128;
                    real  model1_attrsv4_tree_129         ;// := model1_attrsv4_tree_129;
                    real  model1_attrsv4_tree_130         ;// := model1_attrsv4_tree_130;
                    real  model1_attrsv4_tree_131         ;// := model1_attrsv4_tree_131;
                    real  model1_attrsv4_tree_132         ;// := model1_attrsv4_tree_132;
                    real  model1_attrsv4_tree_133         ;// := model1_attrsv4_tree_133;
                    real  model1_attrsv4_tree_134         ;// := model1_attrsv4_tree_134;
                    real  model1_attrsv4_tree_135         ;// := model1_attrsv4_tree_135;
                    real  model1_attrsv4_tree_136         ;// := model1_attrsv4_tree_136;
                    real  model1_attrsv4_tree_137         ;// := model1_attrsv4_tree_137;
                    real  model1_attrsv4_tree_138         ;// := model1_attrsv4_tree_138;
                    real  model1_attrsv4_tree_139         ;// := model1_attrsv4_tree_139;
                    real  model1_attrsv4_tree_140         ;// := model1_attrsv4_tree_140;
                    real  model1_attrsv4_tree_141         ;// := model1_attrsv4_tree_141;
                    real  model1_attrsv4_tree_142         ;// := model1_attrsv4_tree_142;
                    real  model1_attrsv4_tree_143         ;// := model1_attrsv4_tree_143;
                    real  model1_attrsv4_tree_144         ;// := model1_attrsv4_tree_144;
                    real  model1_attrsv4_tree_145         ;// := model1_attrsv4_tree_145;
                    real  model1_attrsv4_tree_146         ;// := model1_attrsv4_tree_146;
                    real  model1_attrsv4_tree_147         ;// := model1_attrsv4_tree_147;
                    real  model1_attrsv4_tree_148         ;// := model1_attrsv4_tree_148;
                    real  model1_attrsv4_tree_149         ;// := model1_attrsv4_tree_149;
                    real  model1_attrsv4_tree_150         ;// := model1_attrsv4_tree_150;
                    real  model1_attrsv4_tree_151         ;// := model1_attrsv4_tree_151;
                    real  model1_attrsv4_tree_152         ;// := model1_attrsv4_tree_152;
                    real  model1_attrsv4_tree_153         ;// := model1_attrsv4_tree_153;
                    real  model1_attrsv4_tree_154         ;// := model1_attrsv4_tree_154;
                    real  model1_attrsv4_tree_155         ;// := model1_attrsv4_tree_155;
                    real  model1_attrsv4_tree_156         ;// := model1_attrsv4_tree_156;
                    real  model1_attrsv4_tree_157         ;// := model1_attrsv4_tree_157;
                    real  model1_attrsv4_tree_158         ;// := model1_attrsv4_tree_158;
                    real  model1_attrsv4_tree_159         ;// := model1_attrsv4_tree_159;
                    real  model1_attrsv4_tree_160         ;// := model1_attrsv4_tree_160;
                    real  model1_attrsv4_tree_161         ;// := model1_attrsv4_tree_161;
                    real  model1_attrsv4_tree_162         ;// := model1_attrsv4_tree_162;
                    real  model1_attrsv4_tree_163         ;// := model1_attrsv4_tree_163;
                    real  model1_attrsv4_tree_164         ;// := model1_attrsv4_tree_164;
                    real  model1_attrsv4_tree_165         ;// := model1_attrsv4_tree_165;
                    real  model1_attrsv4_tree_166         ;// := model1_attrsv4_tree_166;
                    real  model1_attrsv4_tree_167         ;// := model1_attrsv4_tree_167;
                    real  model1_attrsv4_tree_168         ;// := model1_attrsv4_tree_168;
                    real  model1_attrsv4_tree_169         ;// := model1_attrsv4_tree_169;
                    real  model1_attrsv4_tree_170         ;// := model1_attrsv4_tree_170;
                    real  model1_attrsv4_tree_171         ;// := model1_attrsv4_tree_171;
                    real  model1_attrsv4_tree_172         ;// := model1_attrsv4_tree_172;
                    real  model1_attrsv4_tree_173         ;// := model1_attrsv4_tree_173;
                    real  model1_attrsv4_tree_174         ;// := model1_attrsv4_tree_174;
                    real  model1_attrsv4_tree_175         ;// := model1_attrsv4_tree_175;
                    real  model1_attrsv4_tree_176         ;// := model1_attrsv4_tree_176;
                    real  model1_attrsv4_tree_177         ;// := model1_attrsv4_tree_177;
                    real  model1_attrsv4_tree_178         ;// := model1_attrsv4_tree_178;
                    real  model1_attrsv4_tree_179         ;// := model1_attrsv4_tree_179;
                    real  model1_attrsv4_tree_180         ;// := model1_attrsv4_tree_180;
                    real  model1_attrsv4_tree_181         ;// := model1_attrsv4_tree_181;
                    real  model1_attrsv4_tree_182         ;// := model1_attrsv4_tree_182;
                    real  model1_attrsv4_tree_183         ;// := model1_attrsv4_tree_183;
                    real  model1_attrsv4_tree_184         ;// := model1_attrsv4_tree_184;
                    real  model1_attrsv4_tree_185         ;// := model1_attrsv4_tree_185;
                    real  model1_attrsv4_tree_186         ;// := model1_attrsv4_tree_186;
                    real  model1_attrsv4_tree_187         ;// := model1_attrsv4_tree_187;
                    real  model1_attrsv4_tree_188         ;// := model1_attrsv4_tree_188;
                    real  model1_attrsv4_tree_189         ;// := model1_attrsv4_tree_189;
                    real  model1_attrsv4_tree_190         ;// := model1_attrsv4_tree_190;
                    real  model1_attrsv4_tree_191         ;// := model1_attrsv4_tree_191;
                    real  model1_attrsv4_tree_192         ;// := model1_attrsv4_tree_192;
                    real  model1_attrsv4_tree_193         ;// := model1_attrsv4_tree_193;
                    real  model1_attrsv4_tree_194         ;// := model1_attrsv4_tree_194;
                    real  model1_attrsv4_tree_195         ;// := model1_attrsv4_tree_195;
                    real  model1_attrsv4_tree_196         ;// := model1_attrsv4_tree_196;
                    real  model1_attrsv4_tree_197         ;// := model1_attrsv4_tree_197;
                    real  model1_attrsv4_tree_198         ;// := model1_attrsv4_tree_198;
                    real  model1_attrsv4_tree_199         ;// := model1_attrsv4_tree_199;
                    real  model1_attrsv4_tree_200         ;// := model1_attrsv4_tree_200;
                    real  model1_attrsv4_tree_201         ;// := model1_attrsv4_tree_201;
                    real  model1_attrsv4_tree_202         ;// := model1_attrsv4_tree_202;
                    real  model1_attrsv4_tree_203         ;// := model1_attrsv4_tree_203;
                    real  model1_attrsv4_tree_204         ;// := model1_attrsv4_tree_204;
                    real  model1_attrsv4_tree_205         ;// := model1_attrsv4_tree_205;
                    real  model1_attrsv4_tree_206         ;// := model1_attrsv4_tree_206;
                    real  model1_attrsv4_tree_207         ;// := model1_attrsv4_tree_207;
                    real  model1_attrsv4_tree_208         ;// := model1_attrsv4_tree_208;
                    real  model1_attrsv4_tree_209         ;// := model1_attrsv4_tree_209;
                    real  model1_attrsv4_tree_210         ;// := model1_attrsv4_tree_210;
                    real  model1_attrsv4_tree_211         ;// := model1_attrsv4_tree_211;
                    real  model1_attrsv4_tree_212         ;// := model1_attrsv4_tree_212;
                    real  model1_attrsv4_tree_213         ;// := model1_attrsv4_tree_213;
                    real  model1_attrsv4_tree_214         ;// := model1_attrsv4_tree_214;
                    real  model1_attrsv4_tree_215         ;// := model1_attrsv4_tree_215;
                    real  model1_attrsv4_tree_216         ;// := model1_attrsv4_tree_216;
                    real  model1_attrsv4_tree_217         ;// := model1_attrsv4_tree_217;
                    real  model1_attrsv4_tree_218         ;// := model1_attrsv4_tree_218;
                    real  model1_attrsv4_tree_219         ;// := model1_attrsv4_tree_219;
                    real  model1_attrsv4_tree_220         ;// := model1_attrsv4_tree_220;
                    real  model1_attrsv4_tree_221         ;// := model1_attrsv4_tree_221;
                    real  model1_attrsv4_tree_222         ;// := model1_attrsv4_tree_222;
                    real  model1_attrsv4_tree_223         ;// := model1_attrsv4_tree_223;
                    real  model1_attrsv4_tree_224         ;// := model1_attrsv4_tree_224;
                    real  model1_attrsv4_tree_225         ;// := model1_attrsv4_tree_225;
                    real  model1_attrsv4_tree_226         ;// := model1_attrsv4_tree_226;
                    real  model1_attrsv4_tree_227         ;// := model1_attrsv4_tree_227;
                    real  model1_attrsv4_tree_228         ;// := model1_attrsv4_tree_228;
                    real  model1_attrsv4_tree_229         ;// := model1_attrsv4_tree_229;
                    real  model1_attrsv4_tree_230         ;// := model1_attrsv4_tree_230;
                    real  model1_attrsv4_tree_231         ;// := model1_attrsv4_tree_231;
                    real  model1_attrsv4_tree_232         ;// := model1_attrsv4_tree_232;
                    real  model1_attrsv4_tree_233         ;// := model1_attrsv4_tree_233;
                    real  model1_attrsv4_tree_234         ;// := model1_attrsv4_tree_234;
                    real  model1_attrsv4_tree_235         ;// := model1_attrsv4_tree_235;
                    real  model1_attrsv4_tree_236         ;// := model1_attrsv4_tree_236;
                    real  model1_attrsv4_tree_237         ;// := model1_attrsv4_tree_237;
                    real  model1_attrsv4_tree_238         ;// := model1_attrsv4_tree_238;
                    real  model1_attrsv4_tree_239         ;// := model1_attrsv4_tree_239;
                    real  model1_attrsv4_tree_240         ;// := model1_attrsv4_tree_240;
                    real  model1_attrsv4_tree_241         ;// := model1_attrsv4_tree_241;
                    real  model1_attrsv4_tree_242         ;// := model1_attrsv4_tree_242;
                    real  model1_attrsv4_tree_243         ;// := model1_attrsv4_tree_243;
                    real  model1_attrsv4_tree_244         ;// := model1_attrsv4_tree_244;
                    real  model1_attrsv4_tree_245         ;// := model1_attrsv4_tree_245;
                    real  model1_attrsv4_tree_246         ;// := model1_attrsv4_tree_246;
                    real  model1_attrsv4_tree_247         ;// := model1_attrsv4_tree_247;
                    real  model1_attrsv4_tree_248         ;// := model1_attrsv4_tree_248;
                    real  model1_attrsv4_tree_249         ;// := model1_attrsv4_tree_249;
                    real  model1_attrsv4_tree_250         ;// := model1_attrsv4_tree_250;
                    real  model1_attrsv4_tree_251         ;// := model1_attrsv4_tree_251;
                    real  model1_attrsv4_tree_252         ;// := model1_attrsv4_tree_252;
                    real  model1_attrsv4_tree_253         ;// := model1_attrsv4_tree_253;
                    real  model1_attrsv4_tree_254         ;// := model1_attrsv4_tree_254;
                    real  model1_attrsv4_tree_255         ;// := model1_attrsv4_tree_255;
                    real  model1_attrsv4_tree_256         ;// := model1_attrsv4_tree_256;
                    real  model1_attrsv4_tree_257         ;// := model1_attrsv4_tree_257;
                    real  model1_attrsv4_tree_258         ;// := model1_attrsv4_tree_258;
                    real  model1_attrsv4_tree_259         ;// := model1_attrsv4_tree_259;
                    real  model1_attrsv4_tree_260         ;// := model1_attrsv4_tree_260;
                    real  model1_attrsv4_tree_261         ;// := model1_attrsv4_tree_261;
                    real  model1_attrsv4_tree_262         ;// := model1_attrsv4_tree_262;
                    real  model1_attrsv4_tree_263         ;// := model1_attrsv4_tree_263;
                    real  model1_attrsv4_tree_264         ;// := model1_attrsv4_tree_264;
                    real  model1_attrsv4_tree_265         ;// := model1_attrsv4_tree_265;
                    real  model1_attrsv4_tree_266         ;// := model1_attrsv4_tree_266;
                    real  model1_attrsv4_tree_267         ;// := model1_attrsv4_tree_267;
                    real  model1_attrsv4_tree_268         ;// := model1_attrsv4_tree_268;
                    real  model1_attrsv4_tree_269         ;// := model1_attrsv4_tree_269;
                    real  model1_attrsv4_tree_270         ;// := model1_attrsv4_tree_270;
                    real  model1_attrsv4_tree_271         ;// := model1_attrsv4_tree_271;
                    real  model1_attrsv4_tree_272         ;// := model1_attrsv4_tree_272;
                    real  model1_attrsv4_tree_273         ;// := model1_attrsv4_tree_273;
                    real  model1_attrsv4_tree_274         ;// := model1_attrsv4_tree_274;
                    real  model1_attrsv4_tree_275         ;// := model1_attrsv4_tree_275;
                    real  model1_attrsv4_tree_276         ;// := model1_attrsv4_tree_276;
                    real  model1_attrsv4_tree_277         ;// := model1_attrsv4_tree_277;
                    real  model1_attrsv4_tree_278         ;// := model1_attrsv4_tree_278;
                    real  model1_attrsv4_tree_279         ;// := model1_attrsv4_tree_279;
                    real  model1_attrsv4_tree_280         ;// := model1_attrsv4_tree_280;
                    real  model1_attrsv4_gbm_logit        ;// := model1_attrsv4_gbm_logit;
                    real  pbr                             ;// := pbr;
                    real  sbr                             ;// := sbr;
                    real  offset                          ;// := offset;
                    integer  base                            ;// := base;
                    integer  pts                             ;// := pts;
                    real  lgt                             ;// := lgt;
                    integer  bbfm1811_1_0                    ;// := bbfm1811_1_0;
                    string5 bbfm_wc1                       ;
                    string5 bbfm_wc2                         ;
                    string5 bbfm_wc3                         ;
                    string5 bbfm_wc4 ;



Risk_Indicators.Layout_Boca_Shell clam;
Business_Risk_BIP.Layouts.OutputLayout busShell;
			 
    
 
		END;
    
    

    
    layout_debug doModel (SBFA_atributes rt, FDA_attr_clam_busshell le ) := TRANSFORM
   #else
    models.layout_ModelOut doModel(SBFA_atributes rt, FDA_attr_clam_busshell le) := TRANSFORM
		
  #end	   
    
    
    
    
  /* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */  
  MaxSASLength := 1000;
  
   
   
  beta_synthidindex                := (integer)le.version202.IdentitySyntheticRiskLevel;
	friendlyfraudindex               := (integer)le.FriendlyFraudIndex_V3;
	inputaddrlenofres                := (integer)le.version2.InputAddrLenOfRes;
	beta_srch_ssn_id_diff01          := (integer)le.version202.SearchSSNIdentitySearchCtDiff;
	beta_srch_perbestssn             := (integer)le.version202.SearchSSNBestSearchCt ;
	beta_srch_perphone_count01       := (integer)le.version202.SearchPhnSearchCt1Month;
	beta_m_src_credentialed_fs       := (integer)le.version202.SourceTypeCredentialAgeOldest;
	divaddrphonecount                := (integer)le.version2.divaddrphonecount;
	suspiciousactivityindex          := (integer)le.SuspiciousActivityIndex_V3;
	identityrisklevel                := (integer)le.version2.identityrisklevel;
	inputaddrassessedtotal           := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inputaddrassessedtotal);
	beta_srch_perphone_count03       := (integer)le.version202.SearchPhnSearchCt3Month;
	divssnaddrcount                  := (integer)le.version2.divssnaddrcount;
	beta_srch_perphone_count06       := (integer)le.version202.SearchPhnSearchCtNew;
	searchbankingsearchcount         := (integer)le.version2.searchbankingsearchcount;
	beta_srch_phnsperid_1subs        := (integer)le.version202.VariationSearchPhone1SubCt;
	beta_addr_bureau_only            := (integer)le.version202.SourceCreditBureauVerAddr;
	beta_srch_corraddrssn_id         := (integer)le.version202.CorrSearchVerSSNAddrCt;
	sourcecreditbureauagechange      := (integer)le.version2.sourcecreditbureauagechange;
	correlationrisklevel             := (integer)le.version2.correlationrisklevel;
	beta_srch_ssnsperid_count03      := (integer)le.version202.VariationSearchSSNCt3Month;
	sourcerisklevel                  := (integer)le.version2.sourcerisklevel;
	businessactivity06month          := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.BusinessActivity06Month);
	idverdob                         := (integer)le.version2.idverdob;
	busexeclinkbusaddrauthrepowned   := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busexeclinkbusaddrauthrepowned);
	divaddridentitycountnew          := (integer)le.version2.divaddridentitycountnew;
	beta_srch_dobsperssn_count01     := (integer)le.version202.DivSearchSSNDOBCt1Month;
	sourcedriverslicense             := (integer)le.version201.sourcedriverslicense;
	inputaddrageoldest               := (integer)le.version2.inputaddrageoldest;
	divaddridentitycount             := (integer)le.version2.divaddridentitycount;
	beta_rel_count_for_bureau_only   := (integer)le.version202.AssocCBOIdentityCt;
	inputaddroccupantowned           := (integer)le.version2.inputaddroccupantowned;
	beta_srch_ssnsperaddr_count06    := (integer)le.version202.DivSearchAddrSSNCtNew;
	searchssnsearchcountyear         := (integer)le.version2.searchssnsearchcountyear;
	prevaddragenewest                := (integer)le.version2.prevaddragenewest;
	searchcount                      := (integer)le.version2.searchcount;
	prevaddrstatus                   := (string)le.version2.prevaddrstatus;
	prevaddrageoldest                := (integer)le.version2.prevaddrageoldest;
	busaddrpersonnameoverlap         := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busaddrpersonnameoverlap);
	inputphoneproblems               := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inputphoneproblems);
	divaddridentitymsourcecount      := (integer)le.version2.divaddridentitymsourcecount;
	beta_srch_corrnameaddrssn        := (integer)le.version202.CorrSearchSSNAddrNameCt;
	beta_srch_corrdobaddr            := (integer)le.version202.CorrSearchAddrDOBCt;
	divssnlnamecount                 := (integer)le.version2.divssnlnamecount;
	businessrecordtimeoldest         := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.businessrecordtimeoldest);
	beta_srch_addrsperssn_count01    := (integer)le.version202.DivSearchSSNAddrCt1Month;
	vulnerablevictimindex            := (integer)le.VulnerableVictimIndex_V3;
	beta_srch_addrsperid_count06     := (integer)le.version202.VariationSearchAddrCtNew;
	searchlocatesearchcount          := (integer)le.version2.searchlocatesearchcount;
	searchbankingsearchcountyear     := (integer)le.version2.searchbankingsearchcountyear;
	divaddrphonemsourcecount         := (integer)le.version2.divaddrphonemsourcecount;
	associatejudgmentcount           := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.associatejudgmentcount);
	inputaddrsqfootage               := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inputaddrsqfootage);
	sbfeavgutilever                  := (integer)rt.sbfeavgutilever;
	variationdobcountnew             := (integer)le.version2.variationdobcountnew;
	beta_srch_phonesperid_count01    := (integer)le.version202.VariationSearchPhoneCtMonth;
	idverrisklevel                   := (integer)le.version2.idverrisklevel;
	idverphone                       := (integer)le.version2.idverphone;
	divsearchssnidentitycount        := (integer)le.version2.divsearchssnidentitycount;
	beta_srch_ssnsperaddr_count03    := (integer)le.version202.DivSearchAddrSSNCt3Month;
	beta_m_src_other_fs              := (integer)le.version202.SourceTypeOtherAgeOldest;
	correlationphonelastnamecount    := (integer)le.version2.correlationphonelastnamecount;
	identityrecordcount              := (integer)le.version2.identityrecordcount;
	syntheticidentityindex           := (integer)le.SyntheticIdentityIndex_V3;
	beta_srch_corraddrssn            := (integer)le.version202.CorrSearchSSNAddrCt;
	curraddrlenofres                 := (integer)le.version2.curraddrlenofres;
	sourceaccidents                  := (integer)le.version2.sourceaccidents;
	beta_corraddrdob                 := (integer)le.version202.CorrAddrDOBCt;
	divphoneidentitycount            := (integer)le.version2.divphoneidentitycount;
	sourcecreditbureauageoldest      := (integer)le.version2.sourcecreditbureauageoldest;
	associatebankruptcount           := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.associatebankruptcount);
	assocsuspicousidentitiescount    := (integer)le.version2.assocsuspicousidentitiescount;
	beta_srch_idsperphone            := (integer)le.version202.DivSearchPhoneIdentityCt;
	validationssnproblems            := (integer)le.version2.validationssnproblems;
	divaddrssncountnew               := (integer)le.version2.divaddrssncountnew;
	businessactivity12month          := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.businessactivity12month);
	idveraddressassoccount           := (integer)le.version2.idveraddressassoccount;
	beta_srch_addrsperid_count01     := (integer)le.version202.VariationSearchAddrCtMonth;
	divaddrssnmsourcecount           := (integer)le.version2.divaddrssnmsourcecount;
	verificationbusinputphone        := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.verificationbusinputphone);
	correlationaddrnamecount         := (integer)le.version2.correlationaddrnamecount;
	divaddrssncount                  := (integer)le.version2.divaddrssncount;
	correlationssnaddrcount          := (integer)le.version2.correlationssnaddrcount;
	sourceproperty                   := (integer)le.version2.sourceproperty;
	sbfeavgbalance03m                := (integer)rt.SBFEAvgBalance03M;
	divaddrsuspidentitycountnew      := (integer)le.version2.divaddrsuspidentitycountnew;
	beta_srch_corrdobssn_id          := (integer)le.version202.CorrSearchVerSSNDOBCt;
	searchphonesearchcountyear       := (integer)le.version2.searchphonesearchcountyear;
	beta_sum_src_credentialed        := (integer)le.version202.SourceTypeCredentialCt;
	searchaddrsearchcountyear        := (integer)le.version2.searchaddrsearchcountyear;
	variationrisklevel               := (integer)le.version2.variationrisklevel;
	sbfeverbusaddr                   := (integer)rt.SBFEVerBusAddr;
	sourcephonedirectoryassistance   := (integer)le.version2.sourcephonedirectoryassistance;
	idveraddress                     := (integer)le.version2.idveraddress;
	beta_srch_ssnsperaddr_count01    := (integer)le.version202.DivSearchAddrSSNCt1Month;
	assochighrisktopologycount       := (integer)le.version2.assochighrisktopologycount;
	beta_srch_lnamesperid_count03    := (integer)le.version202.VariationSearchLNameCt3Month;
	inquiry03month                   := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inquiry03month);
	searchaddrsearchcount            := (integer)le.version2.searchaddrsearchcount;
	sourcepublicrecord               := (integer)le.version2.sourcepublicrecord;
	sbfeopencount06m                 := (integer)rt.SBFEOpenCount06M;
	divssnaddrmsourcecount           := (integer)le.version2.divssnaddrmsourcecount;
	beta_cpnindex                    := (integer)le.version202.IdentityManipSSNRiskLevel;
	idverssnsourcecount              := (integer)le.version2.idverssnsourcecount;
	searchssnsearchcountmonth        := (integer)le.version2.searchssnsearchcountmonth;
	identityageoldest                := (integer)le.version2.identityageoldest;
	variationlastnamecount           := (integer)le.version2.variationlastnamecount;
	beta_srch_corrnamephone          := (integer)le.version202.CorrSearchNamePhoneCt;
	searchfraudsearchcountyear       := (integer)le.version2.searchfraudsearchcountyear;
	variationphonecountnew           := (integer)le.version2.variationphonecountnew;
	searchcountyear                  := (integer)le.version2.searchcountyear;
	businessactivity03month          := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.businessactivity03month);
	busfeinpersonaddroverlap         := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busfeinpersonaddroverlap);
	inquirycredit12month             := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inquirycredit12month);
	beta_sum_src_other               := (integer)le.version202.SourceTypeOtherCt;
	searchphonesearchcount           := (integer)le.version2.searchphonesearchcount;
	idveraddresssourcecount          := (integer)le.version2.idveraddresssourcecount;
	variationaddrchangeage           := (integer)le.version2.variationaddrchangeage;
	searchcomponentrisklevel         := (integer)le.version2.searchcomponentrisklevel;
	sbferecentbalancecardamt         := (integer)rt.SBFERecentBalanceCardAmt;
	beta_fla_fld_bureau_no_ssn_flag  := (integer)le.version202.SourceCreditBureauNotSSNVer;
	sbfehighbalancecard60m           := (integer)rt.SBFEHighBalanceCard60M;
	beta_srch_addrsperid_count03     := (integer)le.version202.VariationSearchAddrCt3Month;
	divphoneidentitymsourcecount     := (integer)le.version2.divphoneidentitymsourcecount;
	searchcountmonth                 := (integer)le.version2.searchcountmonth;
	sbfetimeoldest                   := (integer)rt.SBFETimeOldest;
	sbfeclosedvoluntarycount         := (integer)rt.SBFEClosedVoluntaryCount;
	sbfeavgbalanceever               := (integer)rt.SBFEAvgBalanceEver;
	inputaddractivephonelist         := (integer)le.version2.inputaddractivephonelist;
	variationphonecount              := (integer)le.version2.variationphonecount;
	searchphonesearchcountmonth      := (integer)le.version2.searchphonesearchcountmonth;
	assoccount                       := (integer)le.version2.assoccount;
	sbfehighbalance24m               := (integer)rt.sbfehighbalance24m;
	validationphoneproblems          := (integer)le.version2.validationphoneproblems;
	beta_srch_corrnamessn_id         := (integer)le.version202.CorrSearchVerSSNNameCt;
	curraddrageoldest                := (integer)le.version2.curraddrageoldest;
	variationsearchphonecount        := (integer)le.version2.variationsearchphonecount;
	divsearchaddridentitycount       := (integer)le.version2.divsearchaddridentitycount;
	divaddrphonecountnew             := (integer)le.version2.divaddrphonecountnew;
	beta_corrnamedob                 := (integer)le.version202.CorrNameDOBCt;
	divsearchaddrsuspidentitycount   := (integer)le.version2.divsearchaddrsuspidentitycount;
	searchfraudsearchcount           := (integer)le.version2.searchfraudsearchcount;
	associatecountycount             := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.associatecountycount);
	sourcevehicleregistration        := (integer)le.version201.sourcevehicleregistration;
	idverdobsourcecount              := (integer)le.version2.idverdobsourcecount;
	idverssncreditbureaucount        := (integer)le.version2.idverssncreditbureaucount;
	variationsearchaddrcount         := (integer)le.version2.variationsearchaddrcount;
	beta_srch_nonbank_recency        := (integer)le.version202.SearchNonBankSearchCtRecency;
	beta_srch_corraddrphone          := (integer)le.version202.CorrSearchAddrPhoneCt;
	searchfraudsearchcountmonth      := (integer)le.version2.searchfraudsearchcountmonth;
	beta_dob_bureau_only             := (integer)le.version202.SourceCreditBureauVerDOB;
	inquiryconsumerphone             :=  if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inquiryconsumerphone);
	beta_srch_corrnamephone_id       := (integer)le.version202.CorrSearchVerNamePhoneCt;
	sbfelastpaymentamt               := (integer)rt.SBFELastPaymentAmt;
	beta_hh_members_for_bureau_only  := (integer)le.version202.AssocCBOHHMemberCt;
	divrisklevel                     := (integer)le.version2.divrisklevel;
	sbfeopencount36m                 := (integer)rt.SBFEOpenCount36M;
	sbfehighutilrevolvingamt         := (integer)rt.SBFEHighUtilRevolvingAmt;
	sbfelimitcardamt06m              := (integer)rt.SBFELimitCardAmt06M;
	searchlocatesearchcountyear      := (integer)le.version2.searchlocatesearchcountyear;
	componentcharrisklevel           := (integer)le.version2.componentcharrisklevel;
	busexeclinkauthrepnameonfile     := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busexeclinkauthrepnameonfile);
	searchhighrisksearchcount        := (integer)le.version2.searchhighrisksearchcount;
	identitysourcecount              := (integer)le.version2.identitysourcecount;
	correlationssnnamecount          := (integer)le.version2.correlationssnnamecount;
	beta_srch_corrdobaddr_id         := (integer)le.version202.CorrSearchVerAddrDOBCt;
	sourcecreditbureau               := (integer)le.version2.sourcecreditbureau;
	sbfebalanceamt12m                := (integer)rt.sbfebalanceamt12m;
	searchbankingsearchcountmonth    := (integer)le.version2.searchbankingsearchcountmonth;
	beta_srch_dobsperid_count01      := (integer)le.version202.VariationSearchDOBCtMonth;
	beta_srch_corrnamessn            := (integer)le.version202.CorrSearchSSNNameCt;
	assocrisklevel                   := (integer)le.version2.assocrisklevel;
	sbfetimeoldestcard               := (integer)rt.sbfetimeoldestcard;
	sbfehighutilcardamt              := (integer)rt.sbfehighutilcardamt;
	divphoneaddrcount                := (integer)le.version2.divphoneaddrcount;
	searchunverifiedaddrcountyear    := (integer)le.version2.searchunverifiedaddrcountyear;
	beta_srch_idsperphone_count01    := (integer)le.version202.DivSearchPhoneIdentityCt1Month;
	curraddractivephonelist          := (integer)le.version2.curraddractivephonelist;
	sbfedelqavgamt84m                := (integer)rt.sbfedelqavgamt84m;
	variationmsourcesssncount        := (integer)le.version2.variationmsourcesssncount;
	sbfeavgutilcardever              := (integer)rt.SBFEAvgUtilCardEver;
	sbfeopencount84m                 := (integer)rt.SBFEOpenCount84M;
	variationsearchssncount          := (integer)le.version2.variationsearchssncount;
	searchssnsearchcount             := (integer)le.version2.searchssnsearchcount;
	sbfehighbalanceloan24m           := (integer)rt.sbfehighbalanceloan24m;
	beta_srch_idsperssn_count03      := (integer)le.version202.DivSearchSSNIdentityCt3Month;
	variationaddrstability           := (integer)le.version2.variationaddrstability;
	sourcefirstreportingidentity     := (integer)le.version2.sourcefirstreportingidentity;
	sbfehighbalance84m               := (integer)rt.sbfehighbalance84m;
	businessrecordupdated12month     := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.businessrecordupdated12month);
	prevaddrlenofres                 := (integer)le.version2.prevaddrlenofres;
	curraddrstatus                   := (string)le.version2.curraddrstatus;
	searchvelocityrisklevel          := (integer)le.version2.searchvelocityrisklevel;
	addrchangedistance               := (integer)le.version2.addrchangedistance;
	sourcepublicrecordcount          := (integer)le.version2.sourcepublicrecordcount;
	beta_srch_corrdobphone           := (integer)le.version202.CorrSearchDOBPhoneCt;
	beta_srch_phonesperid_count03    := (integer)le.version202.VariationSearchPhoneCt3Month;
	variationaddrcountyear           := (integer)le.version2.variationaddrcountyear;
	sbfedelq01amt12m                 := (integer)rt.sbfedelq01amt12m;
	inputaddrlotsize                 := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inputaddrlotsize);
	sbfelegalstructure               := (integer)rt.sbfelegalstructure;
	beta_srch_corrphonessn           := (integer)le.version202.CorrSearchSSNPhoneCt;
	beta_srch_idsperssn_count01      := (integer)le.version202.DivSearchSSNIdentityCt1Month;
	beta_srch_addrsperssn_count03    := (integer)le.version202.DivSearchSSNAddrCt3Month;
	idverssn                         := (integer)le.version2.idverssn;
	beta_ssn_bureau_only             := (integer)le.version202.SourceCreditBureauVerSSN;
	beta_corrssndob                  := (integer)le.version202.CorrSSNDOBCt;
	divssnidentitymsourceurelcount   := (integer)le.version2.divssnidentitymsourceurelcount;
	verificationbusinputaddr         := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.verificationbusinputaddr);
	beta_srch_primrangesperid_1subs  := (integer)le.version202.VariationSearchAddr1SubCt;
	associatecount                   := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.associatecount);
	sbfetimenewest                   := (integer)rt.sbfetimenewest;
	sbfeavgbalance84m                := (integer)rt.sbfeavgbalance84m;
	sbfeavgutilcard12m               := (integer)rt.sbfeavgutilcard12m;
	divssnidentitymsourcecount       := (integer)le.version2.divssnidentitymsourcecount;
	beta_bureau_only_index           := (integer)le.version202.SourceCreditBureauCBOCt;
	sbfeavgbalanceloan24m            := (integer)rt.sbfeavgbalanceloan24m;
	beta_srch_corrnamephonessn       := (integer)le.version202.CorrSearchSSNNamePhoneCt;
	sbfedelq91revcountever           := (integer)rt.sbfedelq91revcountever;
	variationmsourcesssnunrelcount   := (integer)le.version2.variationmsourcesssnunrelcount;
	sbfeprincipalaccountcount        := (integer)rt.sbfeprincipalaccountcount;
	busexeclinkauthrepssnonfile      := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busexeclinkauthrepssnonfile);
	sbfebalancecount12m              := (integer)rt.sbfebalancecount12m;
	sbfetimeoldestcycle              := (integer)rt.sbfetimeoldestcycle;
	searchunverifieddobcountyear     := (integer)le.version2.searchunverifieddobcountyear;
	beta_srch_corraddrphone_id       := (integer)le.version202.CorrSearchVerAddrPhoneCt;
	divssnidentitycount              := (integer)le.version2.divssnidentitycount;
	variationlastnamecountnew        := (integer)le.version2.variationlastnamecountnew;
	sostimeincorporation             := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.sostimeincorporation);
	sbfeavgbalance06m                := (integer)rt.sbfeavgbalance06m;
	sbfeavgutilcard36m               := (integer)rt.sbfeavgutilcard36m;
	sbfebalancecountever             := (integer)rt.sbfebalancecountever;
	sbfedelq91cardcountever          := (integer)rt.sbfedelq91cardcountever;
	sbfebalanceamt60m                := (integer)rt.SBFEBalanceAmt60M;
	sbfeavgbalancecardever           := (integer)rt.sbfeavgbalancecardever;
	divssnaddrcountnew               := (integer)le.version2.divssnaddrcountnew;
	sbfelastpaymentcardamt           := (integer)rt.sbfelastpaymentcardamt;
	busfeinpersonoverlap             := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.busfeinpersonoverlap);
	sbfehighbalance03m               := (integer)rt.sbfehighbalance03m;
	beta_srch_lnamesperaddr_count03  := (integer)le.version202.DivSearchAddrLNameCt3Month;
	sbfehitindex                     := (integer)rt.sbfehitindex;
	beta_srch_corrnameaddrphnssn     := (integer)le.version202.CorrSearchVerSSNAddrNamePhneCt;
	sbfeavgbalancecard12m            := (integer)rt.sbfeavgbalancecard12m;
	idveraddressmatchescurrent       := (integer)le.version201.idveraddressmatchescurrent;
	stolenidentityindex              := (integer)le.StolenIdentityIndex_V3;
	curraddrdwelltype                := (string)le.version2.curraddrdwelltype;
	sbfebalancecount03m              := (integer)rt.sbfebalancecount03m;
	beta_srch_idsperssn_count06      := (integer)le.version202.DivSearchSSNIdentityCtNew;
	beta_source_type                 := (integer)le.version202.SourceTypeIndicator;
	sbfehighbalance12m               := (integer)rt.sbfehighbalance12m;
	sbfeavgutilcard24m               := (integer)rt.sbfeavgutilcard24m;
	assoccreditbureauonlycount       := (integer)le.version2.assoccreditbureauonlycount;
	variationdobcount                := (integer)le.version2.variationdobcount;
	sbfeavgutil12m                   := (integer)rt.sbfeavgutil12m;
	sbfeavgutil84m                   := (integer)rt.sbfeavgutil84m;
	sbfepaymentduecardamt            := (integer)rt.sbfepaymentduecardamt;
	verificationbusinputname         := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.verificationbusinputname);
	businessrecordtimenewest         := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.businessrecordtimenewest);
	beta_input_lname_isbestmatch     := (integer)le.version202.IDVerLNameBest;
	beta_srch_corrnamephonessn_id    := (integer)le.version202.CorrSearchVerSSNNamePhoneCt;
	idveraddressnotcurrent           := (integer)le.version2.idveraddressnotcurrent;
	beta_srch_corrdobssn             := (integer)le.version202.CorrSearchSSNDOBCt;
	sbfetimenewestcycle              := (integer)rt.sbfetimenewestcycle;
	inputphonemobile                 := if((integer)rt.sbfehitindex in[0, 2],-1,(integer)rt.inputphonemobile);
  


//***Begining of the SAS code that was converted to ECL ****//

NULL := -999999999;

model1_attrsv4_tree_0 := -2.95692197736146;



model1_attrsv4_tree_1_c4 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => -0.0297091411356615,
    beta_srch_ssn_id_diff01 >= 0.5                                   => 0.0484150624539813,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.0238748452011937,
                                                                        -0.0238748452011937);

model1_attrsv4_tree_1_c3 := map(
    NULL < inputaddrlenofres AND inputaddrlenofres < 0.5 => 0.114230725481145,
    inputaddrlenofres >= 0.5                             => model1_attrsv4_tree_1_c4,
    inputaddrlenofres = NULL                             => -0.019008648390404,
                                                            -0.019008648390404);

model1_attrsv4_tree_1_c2 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_1_c3,
    friendlyfraudindex >= 6.5                              => 0.204603455220393,
    friendlyfraudindex = NULL                              => -0.0105779288969807,
                                                              -0.0105779288969807);

model1_attrsv4_tree_1_c5 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 1.5 => 0.0877789271762551,
   beta_srch_perbestssn >= 1.5                                => 0.318983028867889,
   beta_srch_perbestssn = NULL                                => 0.172874881271092,
                                                                  0.172874881271092);

model1_attrsv4_tree_1 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 1.5 => model1_attrsv4_tree_1_c2,
    beta_synthidindex >= 1.5                             => model1_attrsv4_tree_1_c5,
    beta_synthidindex = NULL                             => 0.00188301669934124,
                                                            0.00188301669934124);

model1_attrsv4_tree_2_c9 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 9.5 => -0.0272394597541327,
    divaddrphonecount >= 9.5                             => 0.109419334870591,
    divaddrphonecount = NULL                             => 0.0365827213766748,
                                                            0.0365827213766748);

model1_attrsv4_tree_2_c8 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 2.5 => model1_attrsv4_tree_2_c9,
    beta_srch_perbestssn >= 2.5                                => 0.194319017228312,
    beta_srch_perbestssn = NULL                                => 0.0713106712863974,
                                                                  0.0713106712863974);

model1_attrsv4_tree_2_c10 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => -0.0246986749687041,
    suspiciousactivityindex >= 5.5                                   => 0.0918284110587358,
    suspiciousactivityindex = NULL                                   => -0.0205427020788366,
                                                                        -0.0205427020788366);

model1_attrsv4_tree_2_c7 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 1.5 => model1_attrsv4_tree_2_c8,
    beta_m_src_credentialed_fs >= 1.5                                      => model1_attrsv4_tree_2_c10,
    beta_m_src_credentialed_fs = NULL                                      => -0.00973642285939727,
                                                                              -0.00973642285939727);

model1_attrsv4_tree_2 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 1.5 => model1_attrsv4_tree_2_c7,
    beta_srch_perphone_count01 >= 1.5                                      => 0.259118255905868,
    beta_srch_perphone_count01 = NULL                                      => -0.00282482852321475,
                                                                              -0.00282482852321475);

model1_attrsv4_tree_3_c14 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 0.5 => -0.00772027516029623,
    beta_srch_perphone_count03 >= 0.5                                      => 0.062347092759375,
    beta_srch_perphone_count03 = NULL                                      => 0.00180608729271123,
                                                                              0.00180608729271123);

model1_attrsv4_tree_3_c13 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 138859 => model1_attrsv4_tree_3_c14,
    inputaddrassessedtotal >= 138859                                  => -0.0353108908067307,
    inputaddrassessedtotal = NULL                                     => -0.0180725416997219,
                                                                         -0.0180725416997219);

model1_attrsv4_tree_3_c15 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 3.5 => 0.0431798335208558,
    divssnaddrcount >= 3.5                           => 0.173432575644748,
    divssnaddrcount = NULL                           => 0.0999566698312705,
                                                        0.0999566698312705);

model1_attrsv4_tree_3_c12 := map(
    NULL < identityrisklevel AND identityrisklevel < 3.5 => model1_attrsv4_tree_3_c13,
    identityrisklevel >= 3.5                             => model1_attrsv4_tree_3_c15,
    identityrisklevel = NULL                             => -0.011359164087118,
                                                            -0.011359164087118);

model1_attrsv4_tree_3 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 1.5 => model1_attrsv4_tree_3_c12,
    beta_srch_ssn_id_diff01 >= 1.5                                   => 0.184392346919485,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00554202012795954,
                                                                        -0.00554202012795954);

model1_attrsv4_tree_4_c19 := map(
    NULL < beta_srch_phnsperid_1subs AND beta_srch_phnsperid_1subs < -1 => 0.0522412145453591,
    beta_srch_phnsperid_1subs >= -1                                     => 0.166408555962723,
    beta_srch_phnsperid_1subs = NULL                                    => 0.106957359740778,
                                                                           0.106957359740778);

model1_attrsv4_tree_4_c18 := map(
    NULL < searchbankingsearchcount AND searchbankingsearchcount < 0.5 => 0.00631573877902103,
    searchbankingsearchcount >= 0.5                                    => model1_attrsv4_tree_4_c19,
    searchbankingsearchcount = NULL                                    => 0.0497336945418465,
                                                                          0.0497336945418465);

model1_attrsv4_tree_4_c20 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => -0.0291585711766445,
    suspiciousactivityindex >= 5.5                                   => 0.0804024564365013,
    suspiciousactivityindex = NULL                                   => -0.0254477312630399,
                                                                        -0.0254477312630399);

model1_attrsv4_tree_4_c17 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 0.5 => model1_attrsv4_tree_4_c18,
    beta_m_src_credentialed_fs >= 0.5                                      => model1_attrsv4_tree_4_c20,
    beta_m_src_credentialed_fs = NULL                                      => -0.0162354883446823,
                                                                              -0.0162354883446823);

model1_attrsv4_tree_4 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 3.5 => model1_attrsv4_tree_4_c17,
    beta_srch_perphone_count06 >= 3.5                                      => 0.153197506338916,
    beta_srch_perphone_count06 = NULL                                      => -0.0108408057309357,
                                                                              -0.0108408057309357);

model1_attrsv4_tree_5_c23 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => -0.0365361864182689,
    divaddrphonecount >= 7.5                             => 0.00987647283301785,
    divaddrphonecount = NULL                             => -0.0239986719546146,
                                                            -0.0239986719546146);

model1_attrsv4_tree_5_c22 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 1.5 => model1_attrsv4_tree_5_c23,
    beta_srch_perphone_count03 >= 1.5                                      => 0.0761377386086199,
    beta_srch_perphone_count03 = NULL                                      => -0.0187939640964281,
                                                                              -0.0187939640964281);

model1_attrsv4_tree_5_c25 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 3.5 => 0.161246175373954,
    sourcecreditbureauagechange >= 3.5                                       => 0.00474181234178043,
    sourcecreditbureauagechange = NULL                                       => 0.0438679030998239,
                                                                                0.0438679030998239);

model1_attrsv4_tree_5_c24 := map(
    NULL < beta_srch_corraddrssn_id AND beta_srch_corraddrssn_id < 0.5 => model1_attrsv4_tree_5_c25,
    beta_srch_corraddrssn_id >= 0.5                                    => 0.210312662679729,
    beta_srch_corraddrssn_id = NULL                                    => 0.0774007301214165,
                                                                          0.0774007301214165);

model1_attrsv4_tree_5 := map(
    NULL < beta_addr_bureau_only AND beta_addr_bureau_only < 0.5 => model1_attrsv4_tree_5_c22,
    beta_addr_bureau_only >= 0.5                                 => model1_attrsv4_tree_5_c24,
    beta_addr_bureau_only = NULL                                 => -0.00640662847309243,
                                                                    -0.00640662847309243);

model1_attrsv4_tree_6_c29 := map(
    NULL < correlationrisklevel AND correlationrisklevel < 8.5 => -0.0237582368777806,
    correlationrisklevel >= 8.5                                => 0.0876308790095259,
    correlationrisklevel = NULL                                => -0.0198091573612357,
                                                                  -0.0198091573612357);

model1_attrsv4_tree_6_c28 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 1.5 => model1_attrsv4_tree_6_c29,
    beta_srch_perphone_count03 >= 1.5                                      => 0.0600977144921336,
    beta_srch_perphone_count03 = NULL                                      => -0.0160591700792996,
                                                                              -0.0160591700792996);

model1_attrsv4_tree_6_c30 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 1.5 => 0.0423579560110452,
    beta_srch_perbestssn >= 1.5                                => 0.125109713231423,
    beta_srch_perbestssn = NULL                                => 0.0684772422133474,
                                                                  0.0684772422133474);

model1_attrsv4_tree_6_c27 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 1.5 => model1_attrsv4_tree_6_c28,
    beta_synthidindex >= 1.5                             => model1_attrsv4_tree_6_c30,
    beta_synthidindex = NULL                             => -0.00901446905491235,
                                                            -0.00901446905491235);

model1_attrsv4_tree_6 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_6_c27,
    friendlyfraudindex >= 6.5                              => 0.150360606163625,
    friendlyfraudindex = NULL                              => -0.00254925373944337,
                                                              -0.00254925373944337);

model1_attrsv4_tree_7_c34 := map(
    NULL < beta_srch_ssnsperid_count03 AND beta_srch_ssnsperid_count03 < 0.5 => 0.00513112463815313,
    beta_srch_ssnsperid_count03 >= 0.5                                       => 0.0899452135043202,
    beta_srch_ssnsperid_count03 = NULL                                       => 0.0145722513656657,
                                                                                0.0145722513656657);

model1_attrsv4_tree_7_c33 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 5.5 => model1_attrsv4_tree_7_c34,
    friendlyfraudindex >= 5.5                              => 0.12501274546878,
    friendlyfraudindex = NULL                              => 0.0247213360367957,
                                                              0.0247213360367957);

model1_attrsv4_tree_7_c32 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => -0.0304041274603972,
    divaddrphonecount >= 7.5                             => model1_attrsv4_tree_7_c33,
    divaddrphonecount = NULL                             => -0.0134805111982428,
                                                            -0.0134805111982428);

model1_attrsv4_tree_7_c35 := map(
    NULL < sourcerisklevel AND sourcerisklevel < 4.5 => 0.0336816604863723,
    sourcerisklevel >= 4.5                           => 0.20396436706454,
    sourcerisklevel = NULL                           => 0.0856153891788338,
                                                        0.0856153891788338);

model1_attrsv4_tree_7 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_7_c32,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_7_c35,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00551077015376569,
                                                                        -0.00551077015376569);

model1_attrsv4_tree_8_c38 := map(
    NULL < correlationrisklevel AND correlationrisklevel < 7.5 => 0.0137720074916848,
    correlationrisklevel >= 7.5                                => 0.0932606211229878,
    correlationrisklevel = NULL                                => 0.0347560891389729,
                                                                  0.0347560891389729);

model1_attrsv4_tree_8_c39 := map(
    NULL < idverdob AND idverdob < 6.5 => 0.0613225170879211,
    idverdob >= 6.5                    => -0.0242954849650943,
    idverdob = NULL                    => -0.0205764530009165,
                                          -0.0205764530009165);

model1_attrsv4_tree_8_c37 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => model1_attrsv4_tree_8_c38,
    businessactivity06month >= 0.5                                   => model1_attrsv4_tree_8_c39,
    businessactivity06month = NULL                                   => -0.0106799218560607,
                                                                        -0.0106799218560607);

model1_attrsv4_tree_8_c40 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 0.5 => 0.0214322602108709,
    beta_srch_perphone_count03 >= 0.5                                      => 0.125035307791855,
    beta_srch_perphone_count03 = NULL                                      => 0.0646253675113976,
                                                                              0.0646253675113976);

model1_attrsv4_tree_8 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_8_c37,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_8_c40,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00458800811713662,
                                                                        -0.00458800811713662);

model1_attrsv4_tree_9_c44 := map(
    NULL < busexeclinkbusaddrauthrepowned AND busexeclinkbusaddrauthrepowned < -0.5 => 0.0289815188714175,
    busexeclinkbusaddrauthrepowned >= -0.5                                          => -0.0251657932721728,
    busexeclinkbusaddrauthrepowned = NULL                                           => -0.0167586344385475,
                                                                                       -0.0167586344385475);

model1_attrsv4_tree_9_c43 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_9_c44,
    friendlyfraudindex >= 6.5                              => 0.0743303029111036,
    friendlyfraudindex = NULL                              => -0.0134284003747858,
                                                              -0.0134284003747858);

model1_attrsv4_tree_9_c45 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 3.5 => 0.0190704922129494,
    divssnaddrcount >= 3.5                           => 0.117594225361855,
    divssnaddrcount = NULL                           => 0.0621228798074293,
                                                        0.0621228798074293);

model1_attrsv4_tree_9_c42 := map(
    NULL < identityrisklevel AND identityrisklevel < 3.5 => model1_attrsv4_tree_9_c43,
    identityrisklevel >= 3.5                             => model1_attrsv4_tree_9_c45,
    identityrisklevel = NULL                             => -0.00906614790429401,
                                                            -0.00906614790429401);

model1_attrsv4_tree_9 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 1.5 => model1_attrsv4_tree_9_c42,
    beta_srch_ssn_id_diff01 >= 1.5                                   => 0.11578640522504,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00559147779361916,
                                                                        -0.00559147779361916);

model1_attrsv4_tree_10_c50 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => 0.0121710841631026,
    businessactivity06month >= 0.5                                   => -0.0259233646357615,
    businessactivity06month = NULL                                   => -0.0193111688673903,
                                                                        -0.0193111688673903);

model1_attrsv4_tree_10_c49 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0543675112798201,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_10_c50,
    sourcedriverslicense = NULL                                => -0.0166913974736276,
                                                                  -0.0166913974736276);

model1_attrsv4_tree_10_c48 := map(
    NULL < beta_srch_dobsperssn_count01 AND beta_srch_dobsperssn_count01 < 0.5 => model1_attrsv4_tree_10_c49,
    beta_srch_dobsperssn_count01 >= 0.5                                        => 0.0822816672360164,
    beta_srch_dobsperssn_count01 = NULL                                        => -0.0131734562499055,
                                                                                  -0.0131734562499055);

model1_attrsv4_tree_10_c47 := map(
    NULL < divaddridentitycountnew AND divaddridentitycountnew < 4.5 => model1_attrsv4_tree_10_c48,
    divaddridentitycountnew >= 4.5                                   => 0.0998208504771825,
    divaddridentitycountnew = NULL                                   => -0.00982507018706738,
                                                                        -0.00982507018706738);

model1_attrsv4_tree_10 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 3.5 => model1_attrsv4_tree_10_c47,
    beta_srch_perphone_count06 >= 3.5                                      => 0.10588233069606,
    beta_srch_perphone_count06 = NULL                                      => -0.00646846398220307,
                                                                              -0.00646846398220307);

model1_attrsv4_tree_11_c53 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => -0.0235671718006437,
    divaddrphonecount >= 7.5                             => 0.0695287870251447,
    divaddrphonecount = NULL                             => 0.0255031119154123,
                                                            0.0255031119154123);

model1_attrsv4_tree_11_c52 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 2.5 => model1_attrsv4_tree_11_c53,
    beta_srch_perbestssn >= 2.5                                => 0.102346020454869,
    beta_srch_perbestssn = NULL                                => 0.0438127730495792,
                                                                  0.0438127730495792);

model1_attrsv4_tree_11_c55 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 3.5 => 0.0266357424085343,
    sourcecreditbureauagechange >= 3.5                                       => -0.026522087267486,
    sourcecreditbureauagechange = NULL                                       => -0.0213007022216172,
                                                                                -0.0213007022216172);

model1_attrsv4_tree_11_c54 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 1.5 => model1_attrsv4_tree_11_c55,
    beta_srch_ssn_id_diff01 >= 1.5                                   => 0.0602649126836318,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.019034379498326,
                                                                        -0.019034379498326);

model1_attrsv4_tree_11 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 0.5 => model1_attrsv4_tree_11_c52,
    beta_m_src_credentialed_fs >= 0.5                                      => model1_attrsv4_tree_11_c54,
    beta_m_src_credentialed_fs = NULL                                      => -0.0111340181049218,
                                                                              -0.0111340181049218);

model1_attrsv4_tree_12_c57 := map(
    NULL < divaddridentitycount AND divaddridentitycount < 22.5 => 0.0186054968745867,
    divaddridentitycount >= 22.5                                => 0.145110863922222,
    divaddridentitycount = NULL                                 => 0.0657126005199523,
                                                                   0.0657126005199523);

model1_attrsv4_tree_12_c59 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 1.5 => 0.00463558707290404,
    beta_srch_perbestssn >= 1.5                                => 0.0751188869891141,
    beta_srch_perbestssn = NULL                                => 0.0297954485619816,
                                                                  0.0297954485619816);

model1_attrsv4_tree_12_c60 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => -0.0230487960524843,
    suspiciousactivityindex >= 5.5                                   => 0.0577679600893619,
    suspiciousactivityindex = NULL                                   => -0.0203564382880777,
                                                                        -0.0203564382880777);

model1_attrsv4_tree_12_c58 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < -1 => model1_attrsv4_tree_12_c59,
    beta_m_src_credentialed_fs >= -1                                      => model1_attrsv4_tree_12_c60,
    beta_m_src_credentialed_fs = NULL                                     => -0.0152860530037743,
                                                                             -0.0152860530037743);

model1_attrsv4_tree_12 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 4.5 => model1_attrsv4_tree_12_c57,
    inputaddrageoldest >= 4.5                              => model1_attrsv4_tree_12_c58,
    inputaddrageoldest = NULL                              => -0.00892460214919859,
                                                              -0.00892460214919859);

model1_attrsv4_tree_13_c64 := map(
    NULL < beta_srch_ssnsperaddr_count06 AND beta_srch_ssnsperaddr_count06 < 0.5 => 0.011946173905216,
    beta_srch_ssnsperaddr_count06 >= 0.5                                         => 0.0796043594291432,
    beta_srch_ssnsperaddr_count06 = NULL                                         => 0.0251019322015351,
                                                                                    0.0251019322015351);

model1_attrsv4_tree_13_c65 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 3.5 => -0.0252676812414026,
    suspiciousactivityindex >= 3.5                                   => 0.0446497291786339,
    suspiciousactivityindex = NULL                                   => -0.0201677732779556,
                                                                        -0.0201677732779556);

model1_attrsv4_tree_13_c63 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => model1_attrsv4_tree_13_c64,
    inputaddroccupantowned >= -0.5                                  => model1_attrsv4_tree_13_c65,
    inputaddroccupantowned = NULL                                   => -0.0124033604023359,
                                                                       -0.0124033604023359);

model1_attrsv4_tree_13_c62 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 7.5 => model1_attrsv4_tree_13_c63,
    beta_rel_count_for_bureau_only >= 7.5                                          => 0.102236873400695,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00959904939932629,
                                                                                      -0.00959904939932629);

model1_attrsv4_tree_13 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_13_c62,
    friendlyfraudindex >= 6.5                              => 0.0820556970981013,
    friendlyfraudindex = NULL                              => -0.00631331320413549,
                                                              -0.00631331320413549);

model1_attrsv4_tree_14_c68 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => 0.069084103929351,
    inputaddroccupantowned >= -0.5                                  => -0.00271085014077397,
    inputaddroccupantowned = NULL                                   => 0.0257937282267703,
                                                                       0.0257937282267703);

model1_attrsv4_tree_14_c69 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 5.5 => 0.0374268728241624,
    inputaddrageoldest >= 5.5                              => -0.0270267357357631,
    inputaddrageoldest = NULL                              => -0.0222807889145848,
                                                              -0.0222807889145848);

model1_attrsv4_tree_14_c67 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < -1.5 => model1_attrsv4_tree_14_c68,
    beta_m_src_credentialed_fs >= -1.5                                      => model1_attrsv4_tree_14_c69,
    beta_m_src_credentialed_fs = NULL                                       => -0.0166228434939005,
                                                                               -0.0166228434939005);

model1_attrsv4_tree_14_c70 := map(
    NULL < searchssnsearchcountyear AND searchssnsearchcountyear < 2.5 => 0.120623975112412,
    searchssnsearchcountyear >= 2.5                                    => 0.0233821013856504,
    searchssnsearchcountyear = NULL                                    => 0.0695515624407935,
                                                                          0.0695515624407935);

model1_attrsv4_tree_14 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 8.5 => model1_attrsv4_tree_14_c67,
    beta_srch_perbestssn >= 8.5                                => model1_attrsv4_tree_14_c70,
    beta_srch_perbestssn = NULL                                => -0.0117856952362455,
                                                                  -0.0117856952362455);

model1_attrsv4_tree_15_c73 := map(
    NULL < prevaddragenewest AND prevaddragenewest < 1.5 => -0.021277787375603,
    prevaddragenewest >= 1.5                             => 0.0641702451951093,
    prevaddragenewest = NULL                             => -0.0184230130150166,
                                                            -0.0184230130150166);

model1_attrsv4_tree_15_c74 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 0.5 => 0.00724704695334312,
    beta_srch_perphone_count06 >= 0.5                                      => 0.0878291714667414,
    beta_srch_perphone_count06 = NULL                                      => 0.0263873120573239,
                                                                              0.0263873120573239);

model1_attrsv4_tree_15_c72 := map(
    NULL < beta_addr_bureau_only AND beta_addr_bureau_only < 0.5 => model1_attrsv4_tree_15_c73,
    beta_addr_bureau_only >= 0.5                                 => model1_attrsv4_tree_15_c74,
    beta_addr_bureau_only = NULL                                 => -0.012814726014956,
                                                                    -0.012814726014956);

model1_attrsv4_tree_15_c75 := map(
    NULL < searchcount AND searchcount < 7.5 => 0.0999558734773002,
    searchcount >= 7.5                       => 0.0189098578721041,
    searchcount = NULL                       => 0.055500253103142,
                                                0.055500253103142);

model1_attrsv4_tree_15 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 1.5 => model1_attrsv4_tree_15_c72,
    beta_srch_perphone_count03 >= 1.5                                      => model1_attrsv4_tree_15_c75,
    beta_srch_perphone_count03 = NULL                                      => -0.00899617647462837,
                                                                              -0.00899617647462837);

model1_attrsv4_tree_16_c80 := map(
    NULL < busaddrpersonnameoverlap AND busaddrpersonnameoverlap < 0.5 => 0.0774871106817357,
    busaddrpersonnameoverlap >= 0.5                                    => 0.00212908477483008,
    busaddrpersonnameoverlap = NULL                                    => 0.0418821718358124,
                                                                          0.0418821718358124);

model1_attrsv4_tree_16_c79 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 7.5 => model1_attrsv4_tree_16_c80,
    prevaddrageoldest >= 7.5                             => 0.000500866881774559,
    prevaddrageoldest = NULL                             => 0.00779361100463652,
                                                            0.00779361100463652);

model1_attrsv4_tree_16_c78 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_16_c79,
    beta_srch_ssn_id_diff01 >= 0.5                                   => 0.0770428584981595,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.0135900294985388,
                                                                        0.0135900294985388);

model1_attrsv4_tree_16_c77 := map(
    ((string)prevaddrstatus in ['O'])                => -0.0248825974633672,
    ((string)prevaddrstatus in ['', '-1', 'R', 'U']) => model1_attrsv4_tree_16_c78,
    prevaddrstatus = ''                    => -0.0121620374833101,
                                                -0.0121620374833101);

model1_attrsv4_tree_16 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_16_c77,
    friendlyfraudindex >= 6.5                              => 0.0773556781360577,
    friendlyfraudindex = NULL                              => -0.00884734848514011,
                                                              -0.00884734848514011);

model1_attrsv4_tree_17_c84 := map(
    NULL < divaddridentitymsourcecount AND divaddridentitymsourcecount < 14.5 => 0.0284302430251034,
    divaddridentitymsourcecount >= 14.5                                       => 0.0989846164038808,
    divaddridentitymsourcecount = NULL                                        => 0.0553936978195406,
                                                                                 0.0553936978195406);

model1_attrsv4_tree_17_c83 := map(
    NULL < inputphoneproblems AND inputphoneproblems < 1.5 => model1_attrsv4_tree_17_c84,
    inputphoneproblems >= 1.5                              => -0.000866290789235144,
    inputphoneproblems = NULL                              => 0.0222562699740575,
                                                              0.0222562699740575);

model1_attrsv4_tree_17_c85 := map(
    NULL < beta_srch_corrnameaddrssn AND beta_srch_corrnameaddrssn < 1.5 => -0.0239030626169559,
    beta_srch_corrnameaddrssn >= 1.5                                     => 0.0339779931567787,
    beta_srch_corrnameaddrssn = NULL                                     => -0.0197305229990698,
                                                                            -0.0197305229990698);

model1_attrsv4_tree_17_c82 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => model1_attrsv4_tree_17_c83,
    inputaddroccupantowned >= -0.5                                  => model1_attrsv4_tree_17_c85,
    inputaddroccupantowned = NULL                                   => -0.0119465118776261,
                                                                       -0.0119465118776261);

model1_attrsv4_tree_17 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 3.5 => model1_attrsv4_tree_17_c82,
    beta_srch_perphone_count06 >= 3.5                                      => 0.0744178215455285,
    beta_srch_perphone_count06 = NULL                                      => -0.00952260723674042,
                                                                              -0.00952260723674042);

model1_attrsv4_tree_18_c89 := map(
    NULL < divssnlnamecount AND divssnlnamecount < 1.5 => -0.0170440270120094,
    divssnlnamecount >= 1.5                            => 0.0438834072553326,
    divssnlnamecount = NULL                            => 0.015527242879337,
                                                          0.015527242879337);

model1_attrsv4_tree_18_c88 := map(
    NULL < beta_srch_corrdobaddr AND beta_srch_corrdobaddr < 0.5 => model1_attrsv4_tree_18_c89,
    beta_srch_corrdobaddr >= 0.5                                 => 0.0815416690538159,
    beta_srch_corrdobaddr = NULL                                 => 0.0295798187481617,
                                                                    0.0295798187481617);

model1_attrsv4_tree_18_c87 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 11.5 => 0.0932091404252742,
    inputaddrageoldest >= 11.5                              => model1_attrsv4_tree_18_c88,
    inputaddrageoldest = NULL                               => 0.0432617713367636,
                                                               0.0432617713367636);

model1_attrsv4_tree_18_c90 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 1.5 => -0.0218270659007014,
    beta_srch_perphone_count03 >= 1.5                                      => 0.0302398708110636,
    beta_srch_perphone_count03 = NULL                                      => -0.0189294537941931,
                                                                              -0.0189294537941931);

model1_attrsv4_tree_18 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => model1_attrsv4_tree_18_c87,
    businessactivity06month >= 0.5                                   => model1_attrsv4_tree_18_c90,
    businessactivity06month = NULL                                   => -0.0076059571429906,
                                                                        -0.0076059571429906);

model1_attrsv4_tree_19_c93 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 10.5 => 0.00589640784559278,
    divaddrphonecount >= 10.5                             => 0.0928100208355577,
    divaddrphonecount = NULL                              => 0.0381651476277749,
                                                             0.0381651476277749);

model1_attrsv4_tree_19_c95 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 4.5 => -0.00305096061581613,
    beta_srch_perbestssn >= 4.5                                => 0.0716558524844161,
    beta_srch_perbestssn = NULL                                => 0.00700193507841038,
                                                                  0.00700193507841038);

model1_attrsv4_tree_19_c94 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 9.5 => model1_attrsv4_tree_19_c95,
    businessrecordtimeoldest >= 9.5                                    => -0.0316248662859465,
    businessrecordtimeoldest = NULL                                    => -0.0198975837355396,
                                                                          -0.0198975837355396);

model1_attrsv4_tree_19_c92 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 10.5 => model1_attrsv4_tree_19_c93,
    prevaddrageoldest >= 10.5                             => model1_attrsv4_tree_19_c94,
    prevaddrageoldest = NULL                              => -0.0146897208592482,
                                                             -0.0146897208592482);

model1_attrsv4_tree_19 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 2.5 => model1_attrsv4_tree_19_c92,
    beta_srch_perphone_count03 >= 2.5                                      => 0.0662341122090981,
    beta_srch_perphone_count03 = NULL                                      => -0.0122849088388209,
                                                                              -0.0122849088388209);

model1_attrsv4_tree_20_c100 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 182.5 => -0.00915361936726102,
    beta_m_src_credentialed_fs >= 182.5                                      => 0.0558139971099155,
    beta_m_src_credentialed_fs = NULL                                        => 0.0165610599042232,
                                                                                0.0165610599042232);

model1_attrsv4_tree_20_c99 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 1.5 => model1_attrsv4_tree_20_c100,
    businessrecordtimeoldest >= 1.5                                    => -0.025994795133233,
    businessrecordtimeoldest = NULL                                    => -0.0170047460487378,
                                                                          -0.0170047460487378);

model1_attrsv4_tree_20_c98 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 5.5 => model1_attrsv4_tree_20_c99,
    beta_rel_count_for_bureau_only >= 5.5                                          => 0.0583854921284683,
    beta_rel_count_for_bureau_only = NULL                                          => -0.0147011554377676,
                                                                                      -0.0147011554377676);

model1_attrsv4_tree_20_c97 := map(
    NULL < beta_srch_addrsperssn_count01 AND beta_srch_addrsperssn_count01 < 0.5 => model1_attrsv4_tree_20_c98,
    beta_srch_addrsperssn_count01 >= 0.5                                         => 0.0770995113690667,
    beta_srch_addrsperssn_count01 = NULL                                         => -0.0113292506243811,
                                                                                    -0.0113292506243811);

model1_attrsv4_tree_20 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 2.5 => model1_attrsv4_tree_20_c97,
    beta_srch_perphone_count03 >= 2.5                                      => 0.061577968271375,
    beta_srch_perphone_count03 = NULL                                      => -0.00911108287967532,
                                                                              -0.00911108287967532);

model1_attrsv4_tree_21_c104 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 35.5 => 0.00756734651236646,
    businessrecordtimeoldest >= 35.5                                    => -0.0309430810301973,
    businessrecordtimeoldest = NULL                                     => -0.0130454437249657,
                                                                           -0.0130454437249657);

model1_attrsv4_tree_21_c103 := map(
    NULL < beta_srch_dobsperssn_count01 AND beta_srch_dobsperssn_count01 < 0.5 => model1_attrsv4_tree_21_c104,
    beta_srch_dobsperssn_count01 >= 0.5                                        => 0.0605249747454115,
    beta_srch_dobsperssn_count01 = NULL                                        => -0.0108223171233,
                                                                                  -0.0108223171233);

model1_attrsv4_tree_21_c105 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 0.5 => 0.0136625428336268,
    beta_srch_perbestssn >= 0.5                                => 0.07025375295207,
    beta_srch_perbestssn = NULL                                => 0.0420897553582401,
                                                                  0.0420897553582401);

model1_attrsv4_tree_21_c102 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 2.5 => model1_attrsv4_tree_21_c103,
    beta_synthidindex >= 2.5                             => model1_attrsv4_tree_21_c105,
    beta_synthidindex = NULL                             => -0.0080611288748701,
                                                            -0.0080611288748701);

model1_attrsv4_tree_21 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 2.5 => model1_attrsv4_tree_21_c102,
    beta_srch_perphone_count03 >= 2.5                                      => 0.0570824478905073,
    beta_srch_perphone_count03 = NULL                                      => -0.00621744274000093,
                                                                              -0.00621744274000093);

model1_attrsv4_tree_22_c109 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 3.5 => -0.0221983764596247,
    vulnerablevictimindex >= 3.5                                 => 0.0641967568946176,
    vulnerablevictimindex = NULL                                 => -0.0190264039269016,
                                                                    -0.0190264039269016);

model1_attrsv4_tree_22_c108 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_22_c109,
    friendlyfraudindex >= 6.5                              => 0.0342032223810134,
    friendlyfraudindex = NULL                              => -0.0173170029241204,
                                                              -0.0173170029241204);

model1_attrsv4_tree_22_c107 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 6.5 => model1_attrsv4_tree_22_c108,
    beta_rel_count_for_bureau_only >= 6.5                                          => 0.0585185191270364,
    beta_rel_count_for_bureau_only = NULL                                          => -0.0152584714676742,
                                                                                      -0.0152584714676742);

model1_attrsv4_tree_22_c110 := map(
    NULL < beta_srch_addrsperid_count06 AND beta_srch_addrsperid_count06 < 0.5 => 0.00359827623553847,
    beta_srch_addrsperid_count06 >= 0.5                                        => 0.0803541729140506,
    beta_srch_addrsperid_count06 = NULL                                        => 0.0365918557033168,
                                                                                  0.0365918557033168);

model1_attrsv4_tree_22 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_22_c107,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_22_c110,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.011161806467136,
                                                                        -0.011161806467136);

model1_attrsv4_tree_23_c113 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 16.5 => 0.0472618420583458,
    inputaddrageoldest >= 16.5                              => -0.00423729186474803,
    inputaddrageoldest = NULL                               => 0.0104653929744068,
                                                               0.0104653929744068);

model1_attrsv4_tree_23_c112 := map(
    NULL < searchlocatesearchcount AND searchlocatesearchcount < 1.5 => model1_attrsv4_tree_23_c113,
    searchlocatesearchcount >= 1.5                                   => 0.113047634536131,
    searchlocatesearchcount = NULL                                   => 0.026606421880738,
                                                                        0.026606421880738);

model1_attrsv4_tree_23_c115 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 48.5 => -0.0213714164996615,
    divaddrphonecount >= 48.5                             => 0.0378651743940867,
    divaddrphonecount = NULL                              => -0.0175081605718084,
                                                             -0.0175081605718084);

model1_attrsv4_tree_23_c114 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 3.5 => model1_attrsv4_tree_23_c115,
    beta_srch_perphone_count06 >= 3.5                                      => 0.0327719777105925,
    beta_srch_perphone_count06 = NULL                                      => -0.0158712675652076,
                                                                              -0.0158712675652076);

model1_attrsv4_tree_23 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => model1_attrsv4_tree_23_c112,
    businessactivity06month >= 0.5                                   => model1_attrsv4_tree_23_c114,
    businessactivity06month = NULL                                   => -0.0081671771916387,
                                                                        -0.0081671771916387);

model1_attrsv4_tree_24_c118 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 2.5 => -0.00972786836042877,
    divaddrphonemsourcecount >= 2.5                                    => 0.0378272604326028,
    divaddrphonemsourcecount = NULL                                    => 0.013241720546885,
                                                                          0.013241720546885);

model1_attrsv4_tree_24_c117 := map(
    NULL < searchbankingsearchcountyear AND searchbankingsearchcountyear < 0.5 => model1_attrsv4_tree_24_c118,
    searchbankingsearchcountyear >= 0.5                                        => 0.0592104273885926,
    searchbankingsearchcountyear = NULL                                        => 0.0227890673524704,
                                                                                  0.0227890673524704);

model1_attrsv4_tree_24_c120 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => -0.0155514064045038,
    associatejudgmentcount >= 0.5                                  => 0.0720118576156426,
    associatejudgmentcount = NULL                                  => -0.012690501101416,
                                                                      -0.012690501101416);

model1_attrsv4_tree_24_c119 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => model1_attrsv4_tree_24_c120,
    suspiciousactivityindex >= 5.5                                   => 0.0592678819627899,
    suspiciousactivityindex = NULL                                   => -0.010001733562189,
                                                                        -0.010001733562189);

model1_attrsv4_tree_24 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 1.5 => model1_attrsv4_tree_24_c117,
    beta_m_src_credentialed_fs >= 1.5                                      => model1_attrsv4_tree_24_c119,
    beta_m_src_credentialed_fs = NULL                                      => -0.0059802202424666,
                                                                              -0.0059802202424666);

model1_attrsv4_tree_25_c125 := map(
    NULL < inputaddrsqfootage AND inputaddrsqfootage < 1675 => -0.00940736282097051,
    inputaddrsqfootage >= 1675                              => -0.0369692831413521,
    inputaddrsqfootage = NULL                               => -0.020775610077461,
                                                               -0.020775610077461);

model1_attrsv4_tree_25_c124 := map(
    NULL < beta_srch_addrsperssn_count01 AND beta_srch_addrsperssn_count01 < 0.5 => model1_attrsv4_tree_25_c125,
    beta_srch_addrsperssn_count01 >= 0.5                                         => 0.0276967199439034,
    beta_srch_addrsperssn_count01 = NULL                                         => -0.018789039174946,
                                                                                    -0.018789039174946);

model1_attrsv4_tree_25_c123 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 19.5 => model1_attrsv4_tree_25_c124,
    divaddrphonemsourcecount >= 19.5                                    => 0.0464500603570797,
    divaddrphonemsourcecount = NULL                                     => -0.0156370746278527,
                                                                           -0.0156370746278527);

model1_attrsv4_tree_25_c122 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_25_c123,
    friendlyfraudindex >= 6.5                              => 0.049409314733513,
    friendlyfraudindex = NULL                              => -0.0132104409162126,
                                                              -0.0132104409162126);

model1_attrsv4_tree_25 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 7.5 => model1_attrsv4_tree_25_c122,
    beta_rel_count_for_bureau_only >= 7.5                                          => 0.0579349322138813,
    beta_rel_count_for_bureau_only = NULL                                          => -0.0113311291731535,
                                                                                      -0.0113311291731535);

model1_attrsv4_tree_26_c128 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => 0.04451024153057,
    inputaddroccupantowned >= -0.5                                  => 0.00248908847411393,
    inputaddroccupantowned = NULL                                   => 0.0124153451016232,
                                                                       0.0124153451016232);

model1_attrsv4_tree_26_c129 := map(
    NULL < sbfeavgutilever AND sbfeavgutilever < 55.5 => -0.0243106542273464,
    sbfeavgutilever >= 55.5                           => 0.0851025956054832,
    sbfeavgutilever = NULL                            => -0.0201859483804739,
                                                         -0.0201859483804739);

model1_attrsv4_tree_26_c127 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 1.5 => model1_attrsv4_tree_26_c128,
    businessrecordtimeoldest >= 1.5                                    => model1_attrsv4_tree_26_c129,
    businessrecordtimeoldest = NULL                                    => -0.0127792144408919,
                                                                          -0.0127792144408919);

model1_attrsv4_tree_26_c130 := map(
    NULL < variationdobcountnew AND variationdobcountnew < 0.5 => 0.00792727043631049,
    variationdobcountnew >= 0.5                                => 0.0717379880196935,
    variationdobcountnew = NULL                                => 0.029002369821648,
                                                                  0.029002369821648);

model1_attrsv4_tree_26 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_26_c127,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_26_c130,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00955690829611583,
                                                                        -0.00955690829611583);

model1_attrsv4_tree_27_c134 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 5.5 => 0.0434807473950381,
    businessrecordtimeoldest >= 5.5                                    => -0.0109388534052916,
    businessrecordtimeoldest = NULL                                    => 0.00380624591652272,
                                                                          0.00380624591652272);

model1_attrsv4_tree_27_c133 := map(
    NULL < searchlocatesearchcount AND searchlocatesearchcount < 0.5 => -0.0209119519821481,
    searchlocatesearchcount >= 0.5                                   => model1_attrsv4_tree_27_c134,
    searchlocatesearchcount = NULL                                   => -0.0130254864532108,
                                                                        -0.0130254864532108);

model1_attrsv4_tree_27_c132 := map(
    NULL < beta_srch_phonesperid_count01 AND beta_srch_phonesperid_count01 < 0.5 => model1_attrsv4_tree_27_c133,
    beta_srch_phonesperid_count01 >= 0.5                                         => 0.0485603245862065,
    beta_srch_phonesperid_count01 = NULL                                         => -0.0109252682231805,
                                                                                    -0.0109252682231805);

model1_attrsv4_tree_27_c135 := map(
    NULL < idverrisklevel AND idverrisklevel < 1.5 => 0.00187767315921568,
    idverrisklevel >= 1.5                          => 0.0711398696417425,
    idverrisklevel = NULL                          => 0.0334854215540196,
                                                      0.0334854215540196);

model1_attrsv4_tree_27 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 1.5 => model1_attrsv4_tree_27_c132,
    beta_srch_perphone_count03 >= 1.5                                      => model1_attrsv4_tree_27_c135,
    beta_srch_perphone_count03 = NULL                                      => -0.00828576496283752,
                                                                              -0.00828576496283752);

model1_attrsv4_tree_28_c138 := map(
    NULL < divsearchssnidentitycount AND divsearchssnidentitycount < 0.5 => 0.0275472995422393,
    divsearchssnidentitycount >= 0.5                                     => 0.114211200761662,
    divsearchssnidentitycount = NULL                                     => 0.0676694760327126,
                                                                            0.0676694760327126);

model1_attrsv4_tree_28_c137 := map(
    NULL < idverphone AND idverphone < 0.5 => model1_attrsv4_tree_28_c138,
    idverphone >= 0.5                      => 0.0136518844689275,
    idverphone = NULL                      => 0.033228729733655,
                                              0.033228729733655);

model1_attrsv4_tree_28_c140 := map(
    NULL < beta_srch_ssnsperaddr_count03 AND beta_srch_ssnsperaddr_count03 < 0.5 => 0.000576244497266593,
    beta_srch_ssnsperaddr_count03 >= 0.5                                         => 0.0708597628186702,
    beta_srch_ssnsperaddr_count03 = NULL                                         => 0.00936168428744205,
                                                                                    0.00936168428744205);

model1_attrsv4_tree_28_c139 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 8.5 => -0.023387787714617,
    divaddrphonecount >= 8.5                             => model1_attrsv4_tree_28_c140,
    divaddrphonecount = NULL                             => -0.014831943217921,
                                                            -0.014831943217921);

model1_attrsv4_tree_28 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 4.5 => model1_attrsv4_tree_28_c137,
    sourcecreditbureauagechange >= 4.5                                       => model1_attrsv4_tree_28_c139,
    sourcecreditbureauagechange = NULL                                       => -0.00807624485019945,
                                                                                -0.00807624485019945);

model1_attrsv4_tree_29_c144 := map(
    NULL < correlationphonelastnamecount AND correlationphonelastnamecount < 0.5 => 0.135457099094909,
    correlationphonelastnamecount >= 0.5                                         => 0.00000761222196714226,
    correlationphonelastnamecount = NULL                                         => 0.0546711551385473,
                                                                                    0.0546711551385473);

model1_attrsv4_tree_29_c143 := map(
    NULL < beta_m_src_other_fs AND beta_m_src_other_fs < 108.5 => -0.0055326030589793,
    beta_m_src_other_fs >= 108.5                               => model1_attrsv4_tree_29_c144,
    beta_m_src_other_fs = NULL                                 => 0.00140731143064913,
                                                                  0.00140731143064913);

model1_attrsv4_tree_29_c142 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 69.5 => model1_attrsv4_tree_29_c143,
    businessrecordtimeoldest >= 69.5                                    => -0.0416608711373792,
    businessrecordtimeoldest = NULL                                     => -0.0148646069320152,
                                                                           -0.0148646069320152);

model1_attrsv4_tree_29_c145 := map(
    NULL < identityrecordcount AND identityrecordcount < 52.5 => 0.0710399531966964,
    identityrecordcount >= 52.5                               => 0.00565934274640289,
    identityrecordcount = NULL                                => 0.0282312201637661,
                                                                 0.0282312201637661);

model1_attrsv4_tree_29 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_29_c142,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_29_c145,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.0114494659168779,
                                                                        -0.0114494659168779);

model1_attrsv4_tree_30_c150 := map(
    NULL < beta_srch_corraddrssn AND beta_srch_corraddrssn < 2.5 => -0.0183161228605204,
    beta_srch_corraddrssn >= 2.5                                 => 0.0433403943514725,
    beta_srch_corraddrssn = NULL                                 => -0.0165440983260903,
                                                                    -0.0165440983260903);

model1_attrsv4_tree_30_c149 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 1.5 => model1_attrsv4_tree_30_c150,
    vulnerablevictimindex >= 1.5                                 => 0.0573419498191268,
    vulnerablevictimindex = NULL                                 => -0.0131546563430063,
                                                                    -0.0131546563430063);

model1_attrsv4_tree_30_c148 := map(
    NULL < divaddridentitycountnew AND divaddridentitycountnew < 4.5 => model1_attrsv4_tree_30_c149,
    divaddridentitycountnew >= 4.5                                   => 0.0529392790289254,
    divaddridentitycountnew = NULL                                   => -0.0112784838747791,
                                                                        -0.0112784838747791);

model1_attrsv4_tree_30_c147 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 2.5 => model1_attrsv4_tree_30_c148,
    beta_srch_perphone_count03 >= 2.5                                      => 0.0375441031459265,
    beta_srch_perphone_count03 = NULL                                      => -0.0099078594569665,
                                                                              -0.0099078594569665);

model1_attrsv4_tree_30 := map(
    NULL < syntheticidentityindex AND syntheticidentityindex < 2.5 => model1_attrsv4_tree_30_c147,
    syntheticidentityindex >= 2.5                                  => 0.0540341761597424,
    syntheticidentityindex = NULL                                  => -0.00827914722899373,
                                                                      -0.00827914722899373);

model1_attrsv4_tree_31_c152 := map(
    NULL < curraddrlenofres AND curraddrlenofres < 67.5 => 0.0111264248544661,
    curraddrlenofres >= 67.5                            => 0.121708736380682,
    curraddrlenofres = NULL                             => 0.046911682165337,
                                                           0.046911682165337);

model1_attrsv4_tree_31_c155 := map(
    NULL < sourceaccidents AND sourceaccidents < 0.5 => -0.012732189819793,
    sourceaccidents >= 0.5                           => 0.0353311110966001,
    sourceaccidents = NULL                           => 0.00255919347651698,
                                                        0.00255919347651698);

model1_attrsv4_tree_31_c154 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 21.5 => model1_attrsv4_tree_31_c155,
    businessrecordtimeoldest >= 21.5                                    => -0.0312149954909237,
    businessrecordtimeoldest = NULL                                     => -0.0180087668967968,
                                                                           -0.0180087668967968);

model1_attrsv4_tree_31_c153 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 3.5 => model1_attrsv4_tree_31_c154,
    beta_srch_perphone_count06 >= 3.5                                      => 0.0346031126154794,
    beta_srch_perphone_count06 = NULL                                      => -0.0166332039067011,
                                                                              -0.0166332039067011);

model1_attrsv4_tree_31 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 2.5 => model1_attrsv4_tree_31_c152,
    sourcecreditbureauagechange >= 2.5                                       => model1_attrsv4_tree_31_c153,
    sourcecreditbureauagechange = NULL                                       => -0.0109831043668052,
                                                                                -0.0109831043668052);

model1_attrsv4_tree_32_c159 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 207 => 0.0287200452860615,
    sourcecreditbureauageoldest >= 207                                       => 0.129679621854278,
    sourcecreditbureauageoldest = NULL                                       => 0.0681929624405523,
                                                                                0.0681929624405523);

model1_attrsv4_tree_32_c158 := map(
    NULL < divphoneidentitycount AND divphoneidentitycount < 0.5 => model1_attrsv4_tree_32_c159,
    divphoneidentitycount >= 0.5                                 => 0.0104683730365234,
    divphoneidentitycount = NULL                                 => 0.0411165582290816,
                                                                    0.0411165582290816);

model1_attrsv4_tree_32_c157 := map(
    NULL < beta_corraddrdob AND beta_corraddrdob < 1.5 => model1_attrsv4_tree_32_c158,
    beta_corraddrdob >= 1.5                            => -0.0168047093105269,
    beta_corraddrdob = NULL                            => 0.0207354653820266,
                                                          0.0207354653820266);

model1_attrsv4_tree_32_c160 := map(
    NULL < beta_srch_addrsperssn_count01 AND beta_srch_addrsperssn_count01 < 0.5 => -0.0181071261193932,
    beta_srch_addrsperssn_count01 >= 0.5                                         => 0.0425749234988525,
    beta_srch_addrsperssn_count01 = NULL                                         => -0.0153241881645904,
                                                                                    -0.0153241881645904);

model1_attrsv4_tree_32 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => model1_attrsv4_tree_32_c157,
    businessactivity06month >= 0.5                                   => model1_attrsv4_tree_32_c160,
    businessactivity06month = NULL                                   => -0.00875010510054917,
                                                                        -0.00875010510054917);

model1_attrsv4_tree_33_c164 := map(
    NULL < beta_srch_ssnsperaddr_count06 AND beta_srch_ssnsperaddr_count06 < 0.5 => -0.00299636592941336,
    beta_srch_ssnsperaddr_count06 >= 0.5                                         => 0.0519274066630022,
    beta_srch_ssnsperaddr_count06 = NULL                                         => 0.00806629464948454,
                                                                                    0.00806629464948454);

model1_attrsv4_tree_33_c163 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => model1_attrsv4_tree_33_c164,
    inputaddroccupantowned >= -0.5                                  => -0.0239833495878557,
    inputaddroccupantowned = NULL                                   => -0.0181388076356247,
                                                                       -0.0181388076356247);

model1_attrsv4_tree_33_c165 := map(
    NULL < assocsuspicousidentitiescount AND assocsuspicousidentitiescount < 1.5 => 0.0016260256022622,
    assocsuspicousidentitiescount >= 1.5                                         => 0.134730175513587,
    assocsuspicousidentitiescount = NULL                                         => 0.0703859893005297,
                                                                                    0.0703859893005297);

model1_attrsv4_tree_33_c162 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_33_c163,
    associatebankruptcount >= 0.5                                  => model1_attrsv4_tree_33_c165,
    associatebankruptcount = NULL                                  => -0.0135573182675775,
                                                                      -0.0135573182675775);

model1_attrsv4_tree_33 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0494164687510346,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_33_c162,
    sourcedriverslicense = NULL                                => -0.0111363920213431,
                                                                  -0.0111363920213431);

model1_attrsv4_tree_34_c168 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 4.5 => -0.0190356662649641,
    beta_rel_count_for_bureau_only >= 4.5                                          => 0.0413174853538547,
    beta_rel_count_for_bureau_only = NULL                                          => -0.0168730450390741,
                                                                                      -0.0168730450390741);

model1_attrsv4_tree_34_c170 := map(
    NULL < divaddridentitymsourcecount AND divaddridentitymsourcecount < 12.5 => 0.00795242061215302,
    divaddridentitymsourcecount >= 12.5                                       => 0.0850412407076215,
    divaddridentitymsourcecount = NULL                                        => 0.0525827901411085,
                                                                                 0.0525827901411085);

model1_attrsv4_tree_34_c169 := map(
    NULL < beta_srch_idsperphone AND beta_srch_idsperphone < 0.5 => 0.000396948169204807,
    beta_srch_idsperphone >= 0.5                                 => model1_attrsv4_tree_34_c170,
    beta_srch_idsperphone = NULL                                 => 0.0147254307915483,
                                                                    0.0147254307915483);

model1_attrsv4_tree_34_c167 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 3.5 => model1_attrsv4_tree_34_c168,
    friendlyfraudindex >= 3.5                              => model1_attrsv4_tree_34_c169,
    friendlyfraudindex = NULL                              => -0.00877847003606666,
                                                              -0.00877847003606666);

model1_attrsv4_tree_34 := map(
    NULL < beta_srch_addrsperssn_count01 AND beta_srch_addrsperssn_count01 < 0.5 => model1_attrsv4_tree_34_c167,
    beta_srch_addrsperssn_count01 >= 0.5                                         => 0.0380792905705159,
    beta_srch_addrsperssn_count01 = NULL                                         => -0.0067008146129446,
                                                                                    -0.0067008146129446);

model1_attrsv4_tree_35_c175 := map(
    NULL < divaddrssncountnew AND divaddrssncountnew < 1.5 => -0.00419872782435506,
    divaddrssncountnew >= 1.5                              => 0.0441624147106822,
    divaddrssncountnew = NULL                              => 0.00225306959693877,
                                                              0.00225306959693877);

model1_attrsv4_tree_35_c174 := map(
    NULL < validationssnproblems AND validationssnproblems < 1.5 => model1_attrsv4_tree_35_c175,
    validationssnproblems >= 1.5                                 => -0.0493889602485075,
    validationssnproblems = NULL                                 => -0.00128219310970053,
                                                                    -0.00128219310970053);

model1_attrsv4_tree_35_c173 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_35_c174,
    beta_srch_ssn_id_diff01 >= 0.5                                   => 0.0302079576357512,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.00137488325503141,
                                                                        0.00137488325503141);

model1_attrsv4_tree_35_c172 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 173960 => model1_attrsv4_tree_35_c173,
    inputaddrassessedtotal >= 173960                                  => -0.0272188047951112,
    inputaddrassessedtotal = NULL                                     => -0.0128492121088995,
                                                                         -0.0128492121088995);

model1_attrsv4_tree_35 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 3.5 => model1_attrsv4_tree_35_c172,
    beta_synthidindex >= 3.5                             => 0.0440104547188324,
    beta_synthidindex = NULL                             => -0.0113338483467453,
                                                            -0.0113338483467453);

model1_attrsv4_tree_36_c178 := map(
    NULL < beta_srch_ssnsperaddr_count06 AND beta_srch_ssnsperaddr_count06 < 0.5 => 0.0251025267841604,
    beta_srch_ssnsperaddr_count06 >= 0.5                                         => 0.0885094693719807,
    beta_srch_ssnsperaddr_count06 = NULL                                         => 0.0426987118085316,
                                                                                    0.0426987118085316);

model1_attrsv4_tree_36_c179 := map(
    NULL < idveraddressassoccount AND idveraddressassoccount < 4.5 => -0.00139496483626367,
    idveraddressassoccount >= 4.5                                  => 0.093541870771391,
    idveraddressassoccount = NULL                                  => 0.0062782183903455,
                                                                      0.0062782183903455);

model1_attrsv4_tree_36_c177 := map(
    NULL < businessactivity12month AND businessactivity12month < 0.5 => model1_attrsv4_tree_36_c178,
    businessactivity12month >= 0.5                                   => model1_attrsv4_tree_36_c179,
    businessactivity12month = NULL                                   => 0.0153399840146323,
                                                                        0.0153399840146323);

model1_attrsv4_tree_36_c180 := map(
    NULL < beta_srch_addrsperid_count01 AND beta_srch_addrsperid_count01 < 0.5 => -0.0255032775553308,
    beta_srch_addrsperid_count01 >= 0.5                                        => 0.0273575862870848,
    beta_srch_addrsperid_count01 = NULL                                        => -0.022674395388764,
                                                                                  -0.022674395388764);

model1_attrsv4_tree_36 := map(
    NULL < correlationphonelastnamecount AND correlationphonelastnamecount < 0.5 => model1_attrsv4_tree_36_c177,
    correlationphonelastnamecount >= 0.5                                         => model1_attrsv4_tree_36_c180,
    correlationphonelastnamecount = NULL                                         => -0.00761209411572019,
                                                                                    -0.00761209411572019);

model1_attrsv4_tree_37_c184 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 369.5 => -0.0316822265140702,
    sourcecreditbureauageoldest >= 369.5                                       => 0.0283006164819336,
    sourcecreditbureauageoldest = NULL                                         => -0.0151834491864981,
                                                                                  -0.0151834491864981);

model1_attrsv4_tree_37_c185 := map(
    NULL < verificationbusinputphone AND verificationbusinputphone < 0.5 => 0.0859118944904898,
    verificationbusinputphone >= 0.5                                     => -0.00551570371822176,
    verificationbusinputphone = NULL                                     => 0.0443538953047118,
                                                                            0.0443538953047118);

model1_attrsv4_tree_37_c183 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 12.5 => model1_attrsv4_tree_37_c184,
    divaddrssnmsourcecount >= 12.5                                  => model1_attrsv4_tree_37_c185,
    divaddrssnmsourcecount = NULL                                   => 0.00969782910833591,
                                                                       0.00969782910833591);

model1_attrsv4_tree_37_c182 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 4.5 => -0.0146889299185587,
    friendlyfraudindex >= 4.5                              => model1_attrsv4_tree_37_c183,
    friendlyfraudindex = NULL                              => -0.0102729492299048,
                                                              -0.0102729492299048);

model1_attrsv4_tree_37 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0395646408688778,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_37_c182,
    sourcedriverslicense = NULL                                => -0.00827474396651026,
                                                                  -0.00827474396651026);

model1_attrsv4_tree_38_c189 := map(
    NULL < correlationaddrnamecount AND correlationaddrnamecount < 0.5 => 0.0499488993465947,
    correlationaddrnamecount >= 0.5                                    => 0.000908208173087613,
    correlationaddrnamecount = NULL                                    => 0.00523262184129556,
                                                                          0.00523262184129556);

model1_attrsv4_tree_38_c188 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 21.5 => model1_attrsv4_tree_38_c189,
    businessrecordtimeoldest >= 21.5                                    => -0.0243630042106047,
    businessrecordtimeoldest = NULL                                     => -0.0118535127866056,
                                                                           -0.0118535127866056);

model1_attrsv4_tree_38_c187 := map(
    NULL < sbfeavgutilever AND sbfeavgutilever < 55.5 => model1_attrsv4_tree_38_c188,
    sbfeavgutilever >= 55.5                           => 0.0841892072390712,
    sbfeavgutilever = NULL                            => -0.0090439489983256,
                                                         -0.0090439489983256);

model1_attrsv4_tree_38_c190 := map(
    NULL < divaddrssncount AND divaddrssncount < 13.5 => -0.00737497869462767,
    divaddrssncount >= 13.5                           => 0.0609134763261306,
    divaddrssncount = NULL                            => 0.0248778776125526,
                                                         0.0248778776125526);

model1_attrsv4_tree_38 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_38_c187,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_38_c190,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00629980123239842,
                                                                        -0.00629980123239842);

model1_attrsv4_tree_39_c195 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => 0.0165966414814795,
    businessactivity06month >= 0.5                                   => -0.0142996114805466,
    businessactivity06month = NULL                                   => -0.00912740061883271,
                                                                        -0.00912740061883271);

model1_attrsv4_tree_39_c194 := map(
    NULL < correlationssnaddrcount AND correlationssnaddrcount < 0.5 => -0.050826861780374,
    correlationssnaddrcount >= 0.5                                   => model1_attrsv4_tree_39_c195,
    correlationssnaddrcount = NULL                                   => -0.0114622213118128,
                                                                        -0.0114622213118128);

model1_attrsv4_tree_39_c193 := map(
    NULL < prevaddragenewest AND prevaddragenewest < 1.5 => model1_attrsv4_tree_39_c194,
    prevaddragenewest >= 1.5                             => 0.0600285847626363,
    prevaddragenewest = NULL                             => -0.00937397068987687,
                                                            -0.00937397068987687);

model1_attrsv4_tree_39_c192 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0407596876401298,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_39_c193,
    sourcedriverslicense = NULL                                => -0.0073925965377761,
                                                                  -0.0073925965377761);

model1_attrsv4_tree_39 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 3.5 => model1_attrsv4_tree_39_c192,
    beta_srch_perphone_count06 >= 3.5                                      => 0.0403661691610284,
    beta_srch_perphone_count06 = NULL                                      => -0.00580439230109416,
                                                                              -0.00580439230109416);

model1_attrsv4_tree_40_c200 := map(
    NULL < divaddrsuspidentitycountnew AND divaddrsuspidentitycountnew < 0.5 => 0.00432295716133647,
    divaddrsuspidentitycountnew >= 0.5                                       => -0.0373037183268348,
    divaddrsuspidentitycountnew = NULL                                       => -0.00778125344160694,
                                                                                -0.00778125344160694);

model1_attrsv4_tree_40_c199 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 54.5 => model1_attrsv4_tree_40_c200,
    sourcecreditbureauagechange >= 54.5                                       => 0.0675564347350996,
    sourcecreditbureauagechange = NULL                                        => 0.00432658930107804,
                                                                                 0.00432658930107804);

model1_attrsv4_tree_40_c198 := map(
    NULL < sbfeavgbalance03m AND sbfeavgbalance03m < 24 => model1_attrsv4_tree_40_c199,
    sbfeavgbalance03m >= 24                             => 0.0747290725627782,
    sbfeavgbalance03m = NULL                            => 0.0131268997087906,
                                                           0.0131268997087906);

model1_attrsv4_tree_40_c197 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_40_c198,
    beta_srch_ssn_id_diff01 >= 0.5                                   => 0.0492413314203462,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.0162224224269239,
                                                                        0.0162224224269239);

model1_attrsv4_tree_40 := map(
    NULL < sourceproperty AND sourceproperty < 0.5 => model1_attrsv4_tree_40_c197,
    sourceproperty >= 0.5                          => -0.0139606421822718,
    sourceproperty = NULL                          => -0.00349623063144215,
                                                      -0.00349623063144215);

model1_attrsv4_tree_41_c205 := map(
    NULL < identityrecordcount AND identityrecordcount < 90.5 => 0.0709687467321629,
    identityrecordcount >= 90.5                               => -0.00449856608254076,
    identityrecordcount = NULL                                => 0.0373266916219938,
                                                                 0.0373266916219938);

model1_attrsv4_tree_41_c204 := map(
    NULL < searchphonesearchcountyear AND searchphonesearchcountyear < 0.5 => model1_attrsv4_tree_41_c205,
    searchphonesearchcountyear >= 0.5                                      => -0.00705168263945588,
    searchphonesearchcountyear = NULL                                      => 0.0119349414002365,
                                                                              0.0119349414002365);

model1_attrsv4_tree_41_c203 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 2.5 => 0.0639565257087259,
    sourcecreditbureauagechange >= 2.5                                       => model1_attrsv4_tree_41_c204,
    sourcecreditbureauagechange = NULL                                       => 0.0172766581978705,
                                                                                0.0172766581978705);

model1_attrsv4_tree_41_c202 := map(
    NULL < beta_srch_corrdobssn_id AND beta_srch_corrdobssn_id < 0.5 => -0.0131726694132777,
    beta_srch_corrdobssn_id >= 0.5                                   => model1_attrsv4_tree_41_c203,
    beta_srch_corrdobssn_id = NULL                                   => -0.00514835855329448,
                                                                        -0.00514835855329448);

model1_attrsv4_tree_41 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 3.5 => model1_attrsv4_tree_41_c202,
    beta_srch_perphone_count06 >= 3.5                                      => 0.0369865477235811,
    beta_srch_perphone_count06 = NULL                                      => -0.00377698660371692,
                                                                              -0.00377698660371692);

model1_attrsv4_tree_42_c209 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 22.5 => -0.00681217064802881,
    divaddrphonemsourcecount >= 22.5                                    => 0.0540863220741209,
    divaddrphonemsourcecount = NULL                                     => -0.005043762204166,
                                                                           -0.005043762204166);

model1_attrsv4_tree_42_c208 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 3.5 => model1_attrsv4_tree_42_c209,
    beta_rel_count_for_bureau_only >= 3.5                                          => 0.0318927838238827,
    beta_rel_count_for_bureau_only = NULL                                          => -0.0037766767700429,
                                                                                      -0.0037766767700429);

model1_attrsv4_tree_42_c207 := map(
    NULL < validationssnproblems AND validationssnproblems < 0.5 => model1_attrsv4_tree_42_c208,
    validationssnproblems >= 0.5                                 => -0.0428996770098728,
    validationssnproblems = NULL                                 => -0.00613866910992519,
                                                                    -0.00613866910992519);

model1_attrsv4_tree_42_c210 := map(
    NULL < beta_sum_src_credentialed AND beta_sum_src_credentialed < 2.5 => 0.0561959902503232,
    beta_sum_src_credentialed >= 2.5                                     => -0.00887848355161791,
    beta_sum_src_credentialed = NULL                                     => 0.0235604535399842,
                                                                            0.0235604535399842);

model1_attrsv4_tree_42 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_42_c207,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_42_c210,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00382017628041575,
                                                                        -0.00382017628041575);

model1_attrsv4_tree_43_c215 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 248.5 => 0.014353485835992,
    beta_m_src_credentialed_fs >= 248.5                                      => 0.137205131163929,
    beta_m_src_credentialed_fs = NULL                                        => 0.033267336267775,
                                                                                0.033267336267775);

model1_attrsv4_tree_43_c214 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 13.5 => model1_attrsv4_tree_43_c215,
    businessrecordtimeoldest >= 13.5                                    => -0.0137488158140875,
    businessrecordtimeoldest = NULL                                     => 0.00659752646293273,
                                                                           0.00659752646293273);

model1_attrsv4_tree_43_c213 := map(
    NULL < correlationphonelastnamecount AND correlationphonelastnamecount < 0.5 => model1_attrsv4_tree_43_c214,
    correlationphonelastnamecount >= 0.5                                         => -0.0202119170500509,
    correlationphonelastnamecount = NULL                                         => -0.00953070487395273,
                                                                                    -0.00953070487395273);

model1_attrsv4_tree_43_c212 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 1.5 => model1_attrsv4_tree_43_c213,
    beta_srch_perphone_count01 >= 1.5                                      => 0.0294048457922751,
    beta_srch_perphone_count01 = NULL                                      => -0.00854225399872209,
                                                                              -0.00854225399872209);

model1_attrsv4_tree_43 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 7.5 => model1_attrsv4_tree_43_c212,
    beta_rel_count_for_bureau_only >= 7.5                                          => 0.0459969431240152,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00720450010703231,
                                                                                      -0.00720450010703231);

model1_attrsv4_tree_44_c220 := map(
    NULL < sourcephonedirectoryassistance AND sourcephonedirectoryassistance < 0.5 => -0.0168262946037571,
    sourcephonedirectoryassistance >= 0.5                                          => 0.0487648923680312,
    sourcephonedirectoryassistance = NULL                                          => 0.0138187681617506,
                                                                                      0.0138187681617506);

model1_attrsv4_tree_44_c219 := map(
    NULL < sbfeverbusaddr AND sbfeverbusaddr < 0.5 => model1_attrsv4_tree_44_c220,
    sbfeverbusaddr >= 0.5                          => 0.0615698446588059,
    sbfeverbusaddr = NULL                          => 0.0260477023866062,
                                                      0.0260477023866062);

model1_attrsv4_tree_44_c218 := map(
    NULL < variationrisklevel AND variationrisklevel < 2.5 => -0.0127473715302872,
    variationrisklevel >= 2.5                              => model1_attrsv4_tree_44_c219,
    variationrisklevel = NULL                              => -0.00789181916012402,
                                                              -0.00789181916012402);

model1_attrsv4_tree_44_c217 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 1.5 => 0.0340511595235496,
    inputaddrageoldest >= 1.5                              => model1_attrsv4_tree_44_c218,
    inputaddrageoldest = NULL                              => -0.00586117385953464,
                                                              -0.00586117385953464);

model1_attrsv4_tree_44 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 5.5 => model1_attrsv4_tree_44_c217,
    searchaddrsearchcountyear >= 5.5                                     => 0.0611761487619694,
    searchaddrsearchcountyear = NULL                                     => -0.00413780872610447,
                                                                            -0.00413780872610447);

model1_attrsv4_tree_45_c224 := map(
    NULL < divaddridentitymsourcecount AND divaddridentitymsourcecount < 2.5 => 0.0460903086954466,
    divaddridentitymsourcecount >= 2.5                                       => -0.00856996660431453,
    divaddridentitymsourcecount = NULL                                       => -0.00546546792448249,
                                                                                -0.00546546792448249);

model1_attrsv4_tree_45_c225 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 3.5 => 0.00873832525740974,
    friendlyfraudindex >= 3.5                              => 0.0916063368727942,
    friendlyfraudindex = NULL                              => 0.0354784823601376,
                                                              0.0354784823601376);

model1_attrsv4_tree_45_c223 := map(
    NULL < beta_srch_corrdobssn_id AND beta_srch_corrdobssn_id < 1.5 => model1_attrsv4_tree_45_c224,
    beta_srch_corrdobssn_id >= 1.5                                   => model1_attrsv4_tree_45_c225,
    beta_srch_corrdobssn_id = NULL                                   => -0.00221281400593272,
                                                                        -0.00221281400593272);

model1_attrsv4_tree_45_c222 := map(
    NULL < searchphonesearchcountyear AND searchphonesearchcountyear < 2.5 => model1_attrsv4_tree_45_c223,
    searchphonesearchcountyear >= 2.5                                      => -0.0350873578383905,
    searchphonesearchcountyear = NULL                                      => -0.00369479780448753,
                                                                              -0.00369479780448753);

model1_attrsv4_tree_45 := map(
    NULL < divaddridentitycountnew AND divaddridentitycountnew < 4.5 => model1_attrsv4_tree_45_c222,
    divaddridentitycountnew >= 4.5                                   => 0.0460774601272349,
    divaddridentitycountnew = NULL                                   => -0.00235658143556858,
                                                                        -0.00235658143556858);

model1_attrsv4_tree_46_c229 := map(
    NULL < assochighrisktopologycount AND assochighrisktopologycount < 0.5 => -0.0179396486255511,
    assochighrisktopologycount >= 0.5                                      => 0.0225935334228155,
    assochighrisktopologycount = NULL                                      => -0.0130236018643771,
                                                                              -0.0130236018643771);

model1_attrsv4_tree_46_c230 := map(
    NULL < beta_srch_lnamesperid_count03 AND beta_srch_lnamesperid_count03 < 0.5 => -0.0115519236248731,
    beta_srch_lnamesperid_count03 >= 0.5                                         => 0.0520991630968545,
    beta_srch_lnamesperid_count03 = NULL                                         => 0.0201227877769345,
                                                                                    0.0201227877769345);

model1_attrsv4_tree_46_c228 := map(
    NULL < beta_srch_ssnsperaddr_count01 AND beta_srch_ssnsperaddr_count01 < 0.5 => model1_attrsv4_tree_46_c229,
    beta_srch_ssnsperaddr_count01 >= 0.5                                         => model1_attrsv4_tree_46_c230,
    beta_srch_ssnsperaddr_count01 = NULL                                         => -0.011265901885911,
                                                                                    -0.011265901885911);

model1_attrsv4_tree_46_c227 := map(
    NULL < idveraddress AND idveraddress < 0.5 => 0.0526741254856582,
    idveraddress >= 0.5                        => model1_attrsv4_tree_46_c228,
    idveraddress = NULL                        => -0.00960674817688129,
                                                  -0.00960674817688129);

model1_attrsv4_tree_46 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_46_c227,
    friendlyfraudindex >= 6.5                              => 0.0332100745806281,
    friendlyfraudindex = NULL                              => -0.0080415105524912,
                                                              -0.0080415105524912);

model1_attrsv4_tree_47_c232 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => -0.0134865818428184,
    suspiciousactivityindex >= 5.5                                   => 0.0424649288471115,
    suspiciousactivityindex = NULL                                   => -0.0114721400680484,
                                                                        -0.0114721400680484);

model1_attrsv4_tree_47_c235 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 0.5 => 0.000667505982999537,
    beta_srch_perbestssn >= 0.5                                => 0.0530784573828827,
    beta_srch_perbestssn = NULL                                => 0.0308387955129026,
                                                                  0.0308387955129026);

model1_attrsv4_tree_47_c234 := map(
    NULL < identityrecordcount AND identityrecordcount < 80.5 => model1_attrsv4_tree_47_c235,
    identityrecordcount >= 80.5                               => -0.0233554974916477,
    identityrecordcount = NULL                                => 0.0096110670255607,
                                                                 0.0096110670255607);

model1_attrsv4_tree_47_c233 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 6.5 => 0.0648495970031621,
    inputaddrageoldest >= 6.5                              => model1_attrsv4_tree_47_c234,
    inputaddrageoldest = NULL                              => 0.0182709887724297,
                                                              0.0182709887724297);

model1_attrsv4_tree_47 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 4.5 => model1_attrsv4_tree_47_c232,
    divaddrphonemsourcecount >= 4.5                                    => model1_attrsv4_tree_47_c233,
    divaddrphonemsourcecount = NULL                                    => -0.0068633580755498,
                                                                          -0.0068633580755498);

model1_attrsv4_tree_48_c239 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 12.5 => -0.016308186146276,
    searchaddrsearchcount >= 12.5                                 => 0.0331149084155097,
    searchaddrsearchcount = NULL                                  => -0.0139506477275241,
                                                                     -0.0139506477275241);

model1_attrsv4_tree_48_c238 := map(
    NULL < searchbankingsearchcount AND searchbankingsearchcount < 7.5 => model1_attrsv4_tree_48_c239,
    searchbankingsearchcount >= 7.5                                    => -0.0529913005194301,
    searchbankingsearchcount = NULL                                    => -0.0159213218793666,
                                                                          -0.0159213218793666);

model1_attrsv4_tree_48_c237 := map(
    NULL < divaddridentitycountnew AND divaddridentitycountnew < 4.5 => model1_attrsv4_tree_48_c238,
    divaddridentitycountnew >= 4.5                                   => 0.0283035049490329,
    divaddridentitycountnew = NULL                                   => -0.0145531820753151,
                                                                        -0.0145531820753151);

model1_attrsv4_tree_48_c240 := map(
    NULL < divaddrssncount AND divaddrssncount < 13.5 => -0.00425651680980874,
    divaddrssncount >= 13.5                           => 0.0560693240423293,
    divaddrssncount = NULL                            => 0.0195840447496607,
                                                         0.0195840447496607);

model1_attrsv4_tree_48 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => model1_attrsv4_tree_48_c237,
    inquiry03month >= 0.5                          => model1_attrsv4_tree_48_c240,
    inquiry03month = NULL                          => -0.0108657174795984,
                                                      -0.0108657174795984);

model1_attrsv4_tree_49_c244 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 20.5 => 0.0138699244164668,
    businessrecordtimeoldest >= 20.5                                    => -0.0251495738107164,
    businessrecordtimeoldest = NULL                                     => -0.00940664205845025,
                                                                           -0.00940664205845025);

model1_attrsv4_tree_49_c243 := map(
    NULL < validationssnproblems AND validationssnproblems < 0.5 => model1_attrsv4_tree_49_c244,
    validationssnproblems >= 0.5                                 => -0.0398473687959086,
    validationssnproblems = NULL                                 => -0.0112782685398704,
                                                                    -0.0112782685398704);

model1_attrsv4_tree_49_c245 := map(
    NULL < sourcepublicrecord AND sourcepublicrecord < 0.5 => -0.00550129005106134,
    sourcepublicrecord >= 0.5                              => 0.0789269943399809,
    sourcepublicrecord = NULL                              => 0.0308248275829096,
                                                              0.0308248275829096);

model1_attrsv4_tree_49_c242 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => model1_attrsv4_tree_49_c243,
    inquiry03month >= 0.5                          => model1_attrsv4_tree_49_c245,
    inquiry03month = NULL                          => -0.00695029535398071,
                                                      -0.00695029535398071);

model1_attrsv4_tree_49 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 5.5 => model1_attrsv4_tree_49_c242,
    searchaddrsearchcountyear >= 5.5                                     => 0.048826548182646,
    searchaddrsearchcountyear = NULL                                     => -0.0053059308629245,
                                                                            -0.0053059308629245);

model1_attrsv4_tree_50_c249 := map(
    NULL < sbfeopencount06m AND sbfeopencount06m < 0.5 => -0.0116226907515722,
    sbfeopencount06m >= 0.5                            => 0.0573162722237853,
    sbfeopencount06m = NULL                            => -0.00894693394077374,
                                                          -0.00894693394077374);

model1_attrsv4_tree_50_c248 := map(
    NULL < searchssnsearchcountyear AND searchssnsearchcountyear < 2.5 => model1_attrsv4_tree_50_c249,
    searchssnsearchcountyear >= 2.5                                    => -0.0416814524865036,
    searchssnsearchcountyear = NULL                                    => -0.0109891186173984,
                                                                          -0.0109891186173984);

model1_attrsv4_tree_50_c247 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => model1_attrsv4_tree_50_c248,
    suspiciousactivityindex >= 5.5                                   => 0.029650730256108,
    suspiciousactivityindex = NULL                                   => -0.00943464439798681,
                                                                        -0.00943464439798681);

model1_attrsv4_tree_50_c250 := map(
    NULL < divssnaddrmsourcecount AND divssnaddrmsourcecount < 2.5 => -0.00737588401781496,
    divssnaddrmsourcecount >= 2.5                                  => 0.0553736417916364,
    divssnaddrmsourcecount = NULL                                  => 0.0242603352444501,
                                                                      0.0242603352444501);

model1_attrsv4_tree_50 := map(
    NULL < identityrisklevel AND identityrisklevel < 3.5 => model1_attrsv4_tree_50_c247,
    identityrisklevel >= 3.5                             => model1_attrsv4_tree_50_c250,
    identityrisklevel = NULL                             => -0.0075273813993583,
                                                            -0.0075273813993583);

model1_attrsv4_tree_51_c255 := map(
    NULL < idverssnsourcecount AND idverssnsourcecount < 4.5 => 0.00503297009770229,
    idverssnsourcecount >= 4.5                               => 0.0715307978335923,
    idverssnsourcecount = NULL                               => 0.0301218941152725,
                                                                0.0301218941152725);

model1_attrsv4_tree_51_c254 := map(
    NULL < beta_addr_bureau_only AND beta_addr_bureau_only < 0.5 => -0.00756594067177692,
    beta_addr_bureau_only >= 0.5                                 => model1_attrsv4_tree_51_c255,
    beta_addr_bureau_only = NULL                                 => -0.00448084954827932,
                                                                    -0.00448084954827932);

model1_attrsv4_tree_51_c253 := map(
    NULL < beta_cpnindex AND beta_cpnindex < 2.5 => model1_attrsv4_tree_51_c254,
    beta_cpnindex >= 2.5                         => -0.0281454269795217,
    beta_cpnindex = NULL                         => -0.00856196153704196,
                                                    -0.00856196153704196);

model1_attrsv4_tree_51_c252 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 1.5 => model1_attrsv4_tree_51_c253,
    beta_srch_perphone_count01 >= 1.5                                      => 0.0241935578213696,
    beta_srch_perphone_count01 = NULL                                      => -0.00776884968817001,
                                                                              -0.00776884968817001);

model1_attrsv4_tree_51 := map(
    NULL < syntheticidentityindex AND syntheticidentityindex < 2.5 => model1_attrsv4_tree_51_c252,
    syntheticidentityindex >= 2.5                                  => 0.0316799290116279,
    syntheticidentityindex = NULL                                  => -0.00674541439171299,
                                                                      -0.00674541439171299);

model1_attrsv4_tree_52_c259 := map(
    NULL < idverssnsourcecount AND idverssnsourcecount < 5.5 => -0.0146322273061015,
    idverssnsourcecount >= 5.5                               => 0.0718013080897094,
    idverssnsourcecount = NULL                               => 0.0102696276871154,
                                                                0.0102696276871154);

model1_attrsv4_tree_52_c258 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 5.5 => model1_attrsv4_tree_52_c259,
    divaddrphonemsourcecount >= 5.5                                    => 0.0427687153977907,
    divaddrphonemsourcecount = NULL                                    => 0.0158694704926471,
                                                                          0.0158694704926471);

model1_attrsv4_tree_52_c257 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_52_c258,
    friendlyfraudindex >= 6.5                              => 0.0496190236696711,
    friendlyfraudindex = NULL                              => 0.0186997712876196,
                                                              0.0186997712876196);

model1_attrsv4_tree_52_c260 := map(
    NULL < searchssnsearchcountmonth AND searchssnsearchcountmonth < 0.5 => -0.00542625624297593,
    searchssnsearchcountmonth >= 0.5                                     => -0.0496094793892927,
    searchssnsearchcountmonth = NULL                                     => -0.00785390586639993,
                                                                            -0.00785390586639993);

model1_attrsv4_tree_52 := map(
    NULL < idverphone AND idverphone < 1.5 => model1_attrsv4_tree_52_c257,
    idverphone >= 1.5                      => model1_attrsv4_tree_52_c260,
    idverphone = NULL                      => 0.00103280825660801,
                                              0.00103280825660801);

model1_attrsv4_tree_53_c265 := map(
    NULL < identityageoldest AND identityageoldest < 326.5 => 0.0140242449234401,
    identityageoldest >= 326.5                             => 0.0845542407474441,
    identityageoldest = NULL                               => 0.0333553971031536,
                                                              0.0333553971031536);

model1_attrsv4_tree_53_c264 := map(
    NULL < correlationrisklevel AND correlationrisklevel < 3.5 => -0.0105131807476533,
    correlationrisklevel >= 3.5                                => model1_attrsv4_tree_53_c265,
    correlationrisklevel = NULL                                => 0.0180984492311473,
                                                                  0.0180984492311473);

model1_attrsv4_tree_53_c263 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 13.5 => model1_attrsv4_tree_53_c264,
    businessrecordtimeoldest >= 13.5                                    => -0.0185221638771111,
    businessrecordtimeoldest = NULL                                     => -0.00675608687616368,
                                                                           -0.00675608687616368);

model1_attrsv4_tree_53_c262 := map(
    NULL < identityageoldest AND identityageoldest < 114.5 => -0.0280907665897905,
    identityageoldest >= 114.5                             => model1_attrsv4_tree_53_c263,
    identityageoldest = NULL                               => -0.00952716724470749,
                                                              -0.00952716724470749);

model1_attrsv4_tree_53 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 1.5 => 0.0425869166793632,
    sourcedriverslicense >= 1.5                                => model1_attrsv4_tree_53_c262,
    sourcedriverslicense = NULL                                => -0.00709353785391362,
                                                                  -0.00709353785391362);

model1_attrsv4_tree_54_c270 := map(
    NULL < sourcepublicrecord AND sourcepublicrecord < 0.5 => -0.0141467179985654,
    sourcepublicrecord >= 0.5                              => 0.0241447544514471,
    sourcepublicrecord = NULL                              => 0.00295818997481414,
                                                              0.00295818997481414);

model1_attrsv4_tree_54_c269 := map(
    NULL < beta_srch_addrsperid_count01 AND beta_srch_addrsperid_count01 < 0.5 => model1_attrsv4_tree_54_c270,
    beta_srch_addrsperid_count01 >= 0.5                                        => 0.0430151355564408,
    beta_srch_addrsperid_count01 = NULL                                        => 0.00519591273438475,
                                                                                  0.00519591273438475);

model1_attrsv4_tree_54_c268 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 2.5 => -0.0222095037143809,
    variationlastnamecount >= 2.5                                  => model1_attrsv4_tree_54_c269,
    variationlastnamecount = NULL                                  => -0.00596438198223846,
                                                                      -0.00596438198223846);

model1_attrsv4_tree_54_c267 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 5.5 => model1_attrsv4_tree_54_c268,
    searchaddrsearchcountyear >= 5.5                                     => 0.045546856182459,
    searchaddrsearchcountyear = NULL                                     => -0.00454617680169615,
                                                                            -0.00454617680169615);

model1_attrsv4_tree_54 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0412255791421457,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_54_c267,
    sourcedriverslicense = NULL                                => -0.00268939802284219,
                                                                  -0.00268939802284219);

model1_attrsv4_tree_55_c273 := map(
    NULL < validationssnproblems AND validationssnproblems < 0.5 => -0.00466157914642515,
    validationssnproblems >= 0.5                                 => -0.0367265238821685,
    validationssnproblems = NULL                                 => -0.00652952357801074,
                                                                    -0.00652952357801074);

model1_attrsv4_tree_55_c272 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 1.5 => 0.0285343759871153,
    inputaddrageoldest >= 1.5                              => model1_attrsv4_tree_55_c273,
    inputaddrageoldest = NULL                              => -0.0049132618823071,
                                                              -0.0049132618823071);

model1_attrsv4_tree_55_c275 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 141.5 => 0.0571818698126108,
    beta_m_src_credentialed_fs >= 141.5                                      => 0.0306834348457908,
    beta_m_src_credentialed_fs = NULL                                        => 0.0438667358243082,
                                                                                0.0438667358243082);

model1_attrsv4_tree_55_c274 := map(
    NULL < divaddridentitycount AND divaddridentitycount < 12.5 => -0.0191911143174169,
    divaddridentitycount >= 12.5                                => model1_attrsv4_tree_55_c275,
    divaddridentitycount = NULL                                 => 0.0186435957676182,
                                                                   0.0186435957676182);

model1_attrsv4_tree_55 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_55_c272,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_55_c274,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00305204789345688,
                                                                        -0.00305204789345688);

model1_attrsv4_tree_56_c279 := map(
    NULL < searchbankingsearchcount AND searchbankingsearchcount < 1.5 => 0.0820879598204554,
    searchbankingsearchcount >= 1.5                                    => 0.00496964296746463,
    searchbankingsearchcount = NULL                                    => 0.038442274112167,
                                                                          0.038442274112167);

model1_attrsv4_tree_56_c278 := map(
    NULL < beta_srch_corrnamephone AND beta_srch_corrnamephone < -1.5 => -0.00637249069257547,
    beta_srch_corrnamephone >= -1.5                                   => model1_attrsv4_tree_56_c279,
    beta_srch_corrnamephone = NULL                                    => 0.00207295415835836,
                                                                         0.00207295415835836);

model1_attrsv4_tree_56_c277 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_56_c278,
    beta_srch_ssn_id_diff01 >= 0.5                                   => 0.044828229757387,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.00582616050209167,
                                                                        0.00582616050209167);

model1_attrsv4_tree_56_c280 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 2.5 => -0.0138147688139362,
    beta_synthidindex >= 2.5                             => -0.0320261616432006,
    beta_synthidindex = NULL                             => -0.014474004753457,
                                                            -0.014474004753457);

model1_attrsv4_tree_56 := map(
    NULL < idverphone AND idverphone < 0.5 => model1_attrsv4_tree_56_c277,
    idverphone >= 0.5                      => model1_attrsv4_tree_56_c280,
    idverphone = NULL                      => -0.00792911656847236,
                                              -0.00792911656847236);

model1_attrsv4_tree_57_c282 := map(
    NULL < divphoneidentitycount AND divphoneidentitycount < 0.5 => 0.0565813204116487,
    divphoneidentitycount >= 0.5                                 => -0.00793740909864154,
    divphoneidentitycount = NULL                                 => 0.0226973833307049,
                                                                    0.0226973833307049);

model1_attrsv4_tree_57_c285 := map(
    NULL < searchfraudsearchcountyear AND searchfraudsearchcountyear < 2.5 => 0.0757625661525629,
    searchfraudsearchcountyear >= 2.5                                      => -0.012462411459678,
    searchfraudsearchcountyear = NULL                                      => 0.0364289303004388,
                                                                              0.0364289303004388);

model1_attrsv4_tree_57_c284 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 3.5 => -0.00473262873836793,
    searchaddrsearchcountyear >= 3.5                                     => model1_attrsv4_tree_57_c285,
    searchaddrsearchcountyear = NULL                                     => -0.00204452692358872,
                                                                            -0.00204452692358872);

model1_attrsv4_tree_57_c283 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 2.5 => -0.0434797240398274,
    divssnaddrcount >= 2.5                           => model1_attrsv4_tree_57_c284,
    divssnaddrcount = NULL                           => -0.00504601646734453,
                                                        -0.00504601646734453);

model1_attrsv4_tree_57 := map(
    NULL < correlationaddrnamecount AND correlationaddrnamecount < 0.5 => model1_attrsv4_tree_57_c282,
    correlationaddrnamecount >= 0.5                                    => model1_attrsv4_tree_57_c283,
    correlationaddrnamecount = NULL                                    => -0.00322699166926487,
                                                                          -0.00322699166926487);

model1_attrsv4_tree_58_c290 := map(
    NULL < searchcountyear AND searchcountyear < 4.5 => 0.0522520161823801,
    searchcountyear >= 4.5                           => -0.00781974638909441,
    searchcountyear = NULL                           => 0.0230743029333782,
                                                        0.0230743029333782);

model1_attrsv4_tree_58_c289 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 7.5 => -0.00895911195913504,
    beta_srch_perbestssn >= 7.5                                => model1_attrsv4_tree_58_c290,
    beta_srch_perbestssn = NULL                                => -0.00717759259276116,
                                                                  -0.00717759259276116);

model1_attrsv4_tree_58_c288 := map(
    NULL < searchphonesearchcountyear AND searchphonesearchcountyear < 2.5 => model1_attrsv4_tree_58_c289,
    searchphonesearchcountyear >= 2.5                                      => -0.031891040949198,
    searchphonesearchcountyear = NULL                                      => -0.00836154498502616,
                                                                              -0.00836154498502616);

model1_attrsv4_tree_58_c287 := map(
    NULL < variationphonecountnew AND variationphonecountnew < 0.5 => model1_attrsv4_tree_58_c288,
    variationphonecountnew >= 0.5                                  => 0.0673877417118586,
    variationphonecountnew = NULL                                  => -0.00556555382962876,
                                                                      -0.00556555382962876);

model1_attrsv4_tree_58 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 8.5 => model1_attrsv4_tree_58_c287,
    variationlastnamecount >= 8.5                                  => 0.0726094557400417,
    variationlastnamecount = NULL                                  => -0.00331617855427504,
                                                                      -0.00331617855427504);

model1_attrsv4_tree_59_c294 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 5 => 0.0344009789308061,
    sourcedriverslicense >= 5                                => -0.0270969034872591,
    sourcedriverslicense = NULL                              => 0.0103720050058667,
                                                                0.0103720050058667);

model1_attrsv4_tree_59_c293 := map(
    NULL < idveraddressassoccount AND idveraddressassoccount < 0.5 => 0.0485896609297052,
    idveraddressassoccount >= 0.5                                  => model1_attrsv4_tree_59_c294,
    idveraddressassoccount = NULL                                  => 0.021810700166366,
                                                                      0.021810700166366);

model1_attrsv4_tree_59_c292 := map(
    NULL < idverrisklevel AND idverrisklevel < 1.5 => -0.0134300393365804,
    idverrisklevel >= 1.5                          => model1_attrsv4_tree_59_c293,
    idverrisklevel = NULL                          => 0.00695755626847982,
                                                      0.00695755626847982);

model1_attrsv4_tree_59_c295 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 4.5 => -0.0215994671702747,
    divaddrphonemsourcecount >= 4.5                                    => 0.0155254317931631,
    divaddrphonemsourcecount = NULL                                    => -0.0162245890943092,
                                                                          -0.0162245890943092);

model1_attrsv4_tree_59 := map(
    NULL < businessactivity03month AND businessactivity03month < 0.5 => model1_attrsv4_tree_59_c292,
    businessactivity03month >= 0.5                                   => model1_attrsv4_tree_59_c295,
    businessactivity03month = NULL                                   => -0.0121513111944795,
                                                                        -0.0121513111944795);

model1_attrsv4_tree_60_c299 := map(
    NULL < divaddridentitymsourcecount AND divaddridentitymsourcecount < 19.5 => 0.0649991332465724,
    divaddridentitymsourcecount >= 19.5                                       => 0.0231645178013793,
    divaddridentitymsourcecount = NULL                                        => 0.0420089391730879,
                                                                                 0.0420089391730879);

model1_attrsv4_tree_60_c300 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 5.5 => 0.008227235578681,
    friendlyfraudindex >= 5.5                              => 0.0384360716600578,
    friendlyfraudindex = NULL                              => 0.0118898299332367,
                                                              0.0118898299332367);

model1_attrsv4_tree_60_c298 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 1.5 => model1_attrsv4_tree_60_c299,
    beta_m_src_credentialed_fs >= 1.5                                      => model1_attrsv4_tree_60_c300,
    beta_m_src_credentialed_fs = NULL                                      => 0.0173705203031113,
                                                                              0.0173705203031113);

model1_attrsv4_tree_60_c297 := map(
    NULL < validationssnproblems AND validationssnproblems < 0.5 => model1_attrsv4_tree_60_c298,
    validationssnproblems >= 0.5                                 => -0.0394289383815829,
    validationssnproblems = NULL                                 => 0.0111885485397662,
                                                                    0.0111885485397662);

model1_attrsv4_tree_60 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => -0.0128858239403197,
    divaddrphonecount >= 7.5                             => model1_attrsv4_tree_60_c297,
    divaddrphonecount = NULL                             => -0.00511275414663157,
                                                            -0.00511275414663157);

model1_attrsv4_tree_61_c304 := map(
    NULL < busfeinpersonaddroverlap AND busfeinpersonaddroverlap < 1.5 => 0.00299336589276819,
    busfeinpersonaddroverlap >= 1.5                                    => 0.0586504641806398,
    busfeinpersonaddroverlap = NULL                                    => 0.00691069476181002,
                                                                          0.00691069476181002);

model1_attrsv4_tree_61_c303 := map(
    NULL < idverrisklevel AND idverrisklevel < 5 => model1_attrsv4_tree_61_c304,
    idverrisklevel >= 5                          => 0.0530966893510652,
    idverrisklevel = NULL                        => 0.010665894065802,
                                                    0.010665894065802);

model1_attrsv4_tree_61_c305 := map(
    NULL < inquirycredit12month AND inquirycredit12month < 0.5 => -0.0219570215992455,
    inquirycredit12month >= 0.5                                => 0.0555814744728696,
    inquirycredit12month = NULL                                => -0.017524491454591,
                                                                  -0.017524491454591);

model1_attrsv4_tree_61_c302 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 8384.5 => model1_attrsv4_tree_61_c303,
    inputaddrassessedtotal >= 8384.5                                  => model1_attrsv4_tree_61_c305,
    inputaddrassessedtotal = NULL                                     => -0.00673464039287725,
                                                                         -0.00673464039287725);

model1_attrsv4_tree_61 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_61_c302,
    friendlyfraudindex >= 6.5                              => 0.0286620456172341,
    friendlyfraudindex = NULL                              => -0.00540726466749808,
                                                              -0.00540726466749808);

model1_attrsv4_tree_62_c309 := map(
    NULL < beta_sum_src_other AND beta_sum_src_other < 3.5 => 0.000279988684922156,
    beta_sum_src_other >= 3.5                              => 0.0930986917818379,
    beta_sum_src_other = NULL                              => 0.0042272745721981,
                                                              0.0042272745721981);

model1_attrsv4_tree_62_c310 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 13.5 => 0.0525289133742183,
    sourcecreditbureauagechange >= 13.5                                       => 0.00645358810492705,
    sourcecreditbureauagechange = NULL                                        => 0.0274309719673686,
                                                                                 0.0274309719673686);

model1_attrsv4_tree_62_c308 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 5.5 => model1_attrsv4_tree_62_c309,
    friendlyfraudindex >= 5.5                              => model1_attrsv4_tree_62_c310,
    friendlyfraudindex = NULL                              => 0.00636674592122806,
                                                              0.00636674592122806);

model1_attrsv4_tree_62_c307 := map(
    NULL < busexeclinkbusaddrauthrepowned AND busexeclinkbusaddrauthrepowned < 0.5 => model1_attrsv4_tree_62_c308,
    busexeclinkbusaddrauthrepowned >= 0.5                                          => -0.0305557985031904,
    busexeclinkbusaddrauthrepowned = NULL                                          => -0.00617833041995645,
                                                                                      -0.00617833041995645);

model1_attrsv4_tree_62 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 1.5 => 0.0371111729782278,
    inputaddrageoldest >= 1.5                              => model1_attrsv4_tree_62_c307,
    inputaddrageoldest = NULL                              => -0.00414658250103224,
                                                              -0.00414658250103224);

model1_attrsv4_tree_63_c315 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 0.5 => -0.0228851572578266,
    beta_srch_perbestssn >= 0.5                                => 0.03313157262741,
    beta_srch_perbestssn = NULL                                => 0.00185215776448594,
                                                                  0.00185215776448594);

model1_attrsv4_tree_63_c314 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 1.5 => model1_attrsv4_tree_63_c315,
    searchphonesearchcount >= 1.5                                  => -0.0296608951068868,
    searchphonesearchcount = NULL                                  => -0.00812828541422812,
                                                                      -0.00812828541422812);

model1_attrsv4_tree_63_c313 := map(
    NULL < divssnaddrmsourcecount AND divssnaddrmsourcecount < 9.5 => model1_attrsv4_tree_63_c314,
    divssnaddrmsourcecount >= 9.5                                  => 0.0835935046317249,
    divssnaddrmsourcecount = NULL                                  => 0.0161064627813998,
                                                                      0.0161064627813998);

model1_attrsv4_tree_63_c312 := map(
    NULL < beta_addr_bureau_only AND beta_addr_bureau_only < 0.5 => -0.0120184971765468,
    beta_addr_bureau_only >= 0.5                                 => model1_attrsv4_tree_63_c313,
    beta_addr_bureau_only = NULL                                 => -0.00826620753711452,
                                                                    -0.00826620753711452);

model1_attrsv4_tree_63 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => model1_attrsv4_tree_63_c312,
    suspiciousactivityindex >= 5.5                                   => 0.0416833376026916,
    suspiciousactivityindex = NULL                                   => -0.00644022180676784,
                                                                        -0.00644022180676784);

model1_attrsv4_tree_64_c320 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => -0.00799964716439618,
    inquiry03month >= 0.5                          => 0.024184996737789,
    inquiry03month = NULL                          => -0.00453106111699036,
                                                      -0.00453106111699036);

model1_attrsv4_tree_64_c319 := map(
    NULL < idveraddresssourcecount AND idveraddresssourcecount < 1.5 => -0.0494184190586403,
    idveraddresssourcecount >= 1.5                                   => model1_attrsv4_tree_64_c320,
    idveraddresssourcecount = NULL                                   => -0.0064953188829507,
                                                                        -0.0064953188829507);

model1_attrsv4_tree_64_c318 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 5.5 => model1_attrsv4_tree_64_c319,
    vulnerablevictimindex >= 5.5                                 => 0.0612797484036042,
    vulnerablevictimindex = NULL                                 => -0.00475135902845307,
                                                                    -0.00475135902845307);

model1_attrsv4_tree_64_c317 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 3.5 => model1_attrsv4_tree_64_c318,
    beta_synthidindex >= 3.5                             => 0.0230901872226434,
    beta_synthidindex = NULL                             => -0.00401292901982871,
                                                            -0.00401292901982871);

model1_attrsv4_tree_64 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_64_c317,
    friendlyfraudindex >= 6.5                              => 0.025462301773377,
    friendlyfraudindex = NULL                              => -0.00284504251670169,
                                                              -0.00284504251670169);

model1_attrsv4_tree_65_c323 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 2.5 => 0.00996135273742535,
    beta_srch_perbestssn >= 2.5                                => -0.0269210610764419,
    beta_srch_perbestssn = NULL                                => -0.000720439241454236,
                                                                  -0.000720439241454236);

model1_attrsv4_tree_65_c325 := map(
    NULL < variationaddrchangeage AND variationaddrchangeage < 56.5 => 0.0294563157458513,
    variationaddrchangeage >= 56.5                                  => 0.120950216463302,
    variationaddrchangeage = NULL                                   => 0.0651765372588285,
                                                                       0.0651765372588285);

model1_attrsv4_tree_65_c324 := map(
    NULL < divaddridentitymsourcecount AND divaddridentitymsourcecount < 5.5 => -0.0291219515140211,
    divaddridentitymsourcecount >= 5.5                                       => model1_attrsv4_tree_65_c325,
    divaddridentitymsourcecount = NULL                                       => 0.0395442797120938,
                                                                                0.0395442797120938);

model1_attrsv4_tree_65_c322 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 2.5 => model1_attrsv4_tree_65_c323,
    variationlastnamecount >= 2.5                                  => model1_attrsv4_tree_65_c324,
    variationlastnamecount = NULL                                  => 0.0203306067824998,
                                                                      0.0203306067824998);

model1_attrsv4_tree_65 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => model1_attrsv4_tree_65_c322,
    inputaddroccupantowned >= -0.5                                  => -0.00737258604325912,
    inputaddroccupantowned = NULL                                   => -0.00236118300142961,
                                                                       -0.00236118300142961);

model1_attrsv4_tree_66_c328 := map(
    NULL < divaddridentitycountnew AND divaddridentitycountnew < 1.5 => -0.00249657164548213,
    divaddridentitycountnew >= 1.5                                   => -0.0253020232741491,
    divaddridentitycountnew = NULL                                   => -0.00802907350801011,
                                                                        -0.00802907350801011);

model1_attrsv4_tree_66_c329 := map(
    NULL < correlationphonelastnamecount AND correlationphonelastnamecount < 0.5 => 0.0552227893820075,
    correlationphonelastnamecount >= 0.5                                         => -0.00282080564199073,
    correlationphonelastnamecount = NULL                                         => 0.0220550207968657,
                                                                                    0.0220550207968657);

model1_attrsv4_tree_66_c327 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 6.5 => model1_attrsv4_tree_66_c328,
    beta_srch_perbestssn >= 6.5                                => model1_attrsv4_tree_66_c329,
    beta_srch_perbestssn = NULL                                => -0.00572526917039158,
                                                                  -0.00572526917039158);

model1_attrsv4_tree_66_c330 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 3.5 => -0.0102107131024267,
    beta_srch_perbestssn >= 3.5                                => -0.0468177203699695,
    beta_srch_perbestssn = NULL                                => -0.02885006083957,
                                                                  -0.02885006083957);

model1_attrsv4_tree_66 := map(
    NULL < searchcomponentrisklevel AND searchcomponentrisklevel < 1.5 => model1_attrsv4_tree_66_c327,
    searchcomponentrisklevel >= 1.5                                    => model1_attrsv4_tree_66_c330,
    searchcomponentrisklevel = NULL                                    => -0.00691423251564651,
                                                                          -0.00691423251564651);

model1_attrsv4_tree_67_c335 := map(
    NULL < identityrisklevel AND identityrisklevel < 3.5 => -0.00475308098204891,
    identityrisklevel >= 3.5                             => 0.0270892986837873,
    identityrisklevel = NULL                             => -0.0033065168945208,
                                                            -0.0033065168945208);

model1_attrsv4_tree_67_c334 := map(
    NULL < beta_fla_fld_bureau_no_ssn_flag AND beta_fla_fld_bureau_no_ssn_flag < 0.5 => model1_attrsv4_tree_67_c335,
    beta_fla_fld_bureau_no_ssn_flag >= 0.5                                           => -0.0444532932680714,
    beta_fla_fld_bureau_no_ssn_flag = NULL                                           => -0.00520048695101532,
                                                                                        -0.00520048695101532);

model1_attrsv4_tree_67_c333 := map(
    NULL < sbferecentbalancecardamt AND sbferecentbalancecardamt < 12784.5 => model1_attrsv4_tree_67_c334,
    sbferecentbalancecardamt >= 12784.5                                    => 0.073877389481428,
    sbferecentbalancecardamt = NULL                                        => -0.00240781201078881,
                                                                              -0.00240781201078881);

model1_attrsv4_tree_67_c332 := map(
    NULL < searchfraudsearchcountyear AND searchfraudsearchcountyear < 2.5 => model1_attrsv4_tree_67_c333,
    searchfraudsearchcountyear >= 2.5                                      => -0.0293890261619267,
    searchfraudsearchcountyear = NULL                                      => -0.00424269128873406,
                                                                              -0.00424269128873406);

model1_attrsv4_tree_67 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 5.5 => model1_attrsv4_tree_67_c332,
    searchaddrsearchcountyear >= 5.5                                     => 0.041802301417797,
    searchaddrsearchcountyear = NULL                                     => -0.00306984713488845,
                                                                            -0.00306984713488845);

model1_attrsv4_tree_68_c340 := map(
    NULL < beta_srch_addrsperid_count03 AND beta_srch_addrsperid_count03 < 0.5 => 0.0118561229937,
    beta_srch_addrsperid_count03 >= 0.5                                        => -0.0307492644590266,
    beta_srch_addrsperid_count03 = NULL                                        => 0.00733836906101925,
                                                                                  0.00733836906101925);

model1_attrsv4_tree_68_c339 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 270 => model1_attrsv4_tree_68_c340,
    beta_m_src_credentialed_fs >= 270                                      => 0.0795701544478781,
    beta_m_src_credentialed_fs = NULL                                      => 0.0175612064612856,
                                                                              0.0175612064612856);

model1_attrsv4_tree_68_c338 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_68_c339,
    beta_srch_ssn_id_diff01 >= 0.5                                   => 0.0423785842955092,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.0196179787863645,
                                                                        0.0196179787863645);

model1_attrsv4_tree_68_c337 := map(
    NULL < sbfehighbalancecard60m AND sbfehighbalancecard60m < 840.5 => model1_attrsv4_tree_68_c338,
    sbfehighbalancecard60m >= 840.5                                  => -0.0251343007600976,
    sbfehighbalancecard60m = NULL                                    => 0.011185427595859,
                                                                        0.011185427595859);

model1_attrsv4_tree_68 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 141916.5 => model1_attrsv4_tree_68_c337,
    inputaddrassessedtotal >= 141916.5                                  => -0.0185027152009329,
    inputaddrassessedtotal = NULL                                       => -0.0043448320086892,
                                                                           -0.0043448320086892);

model1_attrsv4_tree_69_c342 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 0.5 => 0.00864456671389491,
    beta_srch_perphone_count03 >= 0.5                                      => 0.045037911225066,
    beta_srch_perphone_count03 = NULL                                      => 0.0147798431832111,
                                                                              0.0147798431832111);

model1_attrsv4_tree_69_c345 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 25.5 => -0.0246766406215602,
    sourcecreditbureauagechange >= 25.5                                       => 0.0331128026891296,
    sourcecreditbureauagechange = NULL                                        => 0.00750414741811806,
                                                                                 0.00750414741811806);

model1_attrsv4_tree_69_c344 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 3.5 => 0.0597805878592922,
    sourcecreditbureauagechange >= 3.5                                       => model1_attrsv4_tree_69_c345,
    sourcecreditbureauagechange = NULL                                       => 0.0130888459591192,
                                                                                0.0130888459591192);

model1_attrsv4_tree_69_c343 := map(
    NULL < searchlocatesearchcount AND searchlocatesearchcount < 0.5 => -0.0175218446771637,
    searchlocatesearchcount >= 0.5                                   => model1_attrsv4_tree_69_c344,
    searchlocatesearchcount = NULL                                   => -0.00740977967669076,
                                                                        -0.00740977967669076);

model1_attrsv4_tree_69 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => model1_attrsv4_tree_69_c342,
    inputaddroccupantowned >= -0.5                                  => model1_attrsv4_tree_69_c343,
    inputaddroccupantowned = NULL                                   => -0.00331202620987397,
                                                                       -0.00331202620987397);

model1_attrsv4_tree_70_c349 := map(
    NULL < divaddrssncountnew AND divaddrssncountnew < 1.5 => 0.00018435054504764,
    divaddrssncountnew >= 1.5                              => 0.0375281641048171,
    divaddrssncountnew = NULL                              => 0.00466032289122081,
                                                              0.00466032289122081);

model1_attrsv4_tree_70_c348 := map(
    NULL < validationssnproblems AND validationssnproblems < 1 => model1_attrsv4_tree_70_c349,
    validationssnproblems >= 1                                 => -0.0405587937976802,
    validationssnproblems = NULL                               => 0.000934884300373855,
                                                                  0.000934884300373855);

model1_attrsv4_tree_70_c350 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 2.5 => -0.00158017975542977,
    searchaddrsearchcount >= 2.5                                 => 0.0514938888537273,
    searchaddrsearchcount = NULL                                 => 0.0259488932147405,
                                                                    0.0259488932147405);

model1_attrsv4_tree_70_c347 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_70_c348,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_70_c350,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.00293376328008799,
                                                                        0.00293376328008799);

model1_attrsv4_tree_70 := map(
    NULL < divphoneidentitymsourcecount AND divphoneidentitymsourcecount < 0.5 => model1_attrsv4_tree_70_c347,
    divphoneidentitymsourcecount >= 0.5                                        => -0.023412620382508,
    divphoneidentitymsourcecount = NULL                                        => -0.00677214504089666,
                                                                                  -0.00677214504089666);

model1_attrsv4_tree_71_c355 := map(
    NULL < divaddridentitymsourcecount AND divaddridentitymsourcecount < 13.5 => 0.0159539188297861,
    divaddridentitymsourcecount >= 13.5                                       => 0.0616077807111738,
    divaddridentitymsourcecount = NULL                                        => 0.03878084977048,
                                                                                 0.03878084977048);

model1_attrsv4_tree_71_c354 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => 0.00431495217580794,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_71_c355,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.00677158990132796,
                                                                        0.00677158990132796);

model1_attrsv4_tree_71_c353 := map(
    NULL < sbfetimeoldest AND sbfetimeoldest < 10.5 => model1_attrsv4_tree_71_c354,
    sbfetimeoldest >= 10.5                          => -0.0263357864742719,
    sbfetimeoldest = NULL                           => -0.00290849442721822,
                                                       -0.00290849442721822);

model1_attrsv4_tree_71_c352 := map(
    NULL < searchcountmonth AND searchcountmonth < 1.5 => model1_attrsv4_tree_71_c353,
    searchcountmonth >= 1.5                            => -0.0314833764137733,
    searchcountmonth = NULL                            => -0.0038068583107133,
                                                          -0.0038068583107133);

model1_attrsv4_tree_71 := map(
    NULL < sbfeavgutilever AND sbfeavgutilever < 62.5 => model1_attrsv4_tree_71_c352,
    sbfeavgutilever >= 62.5                           => 0.0676497433135265,
    sbfeavgutilever = NULL                            => -0.0020372962421885,
                                                         -0.0020372962421885);

model1_attrsv4_tree_72_c360 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 4.5 => -0.00085398590180905,
    searchaddrsearchcountyear >= 4.5                                     => 0.0376436607847864,
    searchaddrsearchcountyear = NULL                                     => 0.0007025887970759,
                                                                            0.0007025887970759);

model1_attrsv4_tree_72_c359 := map(
    NULL < sbfeavgbalanceever AND sbfeavgbalanceever < 5162.5 => model1_attrsv4_tree_72_c360,
    sbfeavgbalanceever >= 5162.5                              => 0.0680022169956348,
    sbfeavgbalanceever = NULL                                 => 0.00406146316270271,
                                                                 0.00406146316270271);

model1_attrsv4_tree_72_c358 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 3.5 => model1_attrsv4_tree_72_c359,
    vulnerablevictimindex >= 3.5                                 => 0.0885450499649373,
    vulnerablevictimindex = NULL                                 => 0.00666210127886648,
                                                                    0.00666210127886648);

model1_attrsv4_tree_72_c357 := map(
    NULL < sbfeclosedvoluntarycount AND sbfeclosedvoluntarycount < 0.5 => model1_attrsv4_tree_72_c358,
    sbfeclosedvoluntarycount >= 0.5                                    => -0.0425405579953232,
    sbfeclosedvoluntarycount = NULL                                    => -0.00199205092012121,
                                                                          -0.00199205092012121);

model1_attrsv4_tree_72 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 7.5 => model1_attrsv4_tree_72_c357,
    beta_rel_count_for_bureau_only >= 7.5                                          => 0.0370478451522812,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00106209113160408,
                                                                                      -0.00106209113160408);

model1_attrsv4_tree_73_c365 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 155.5 => -0.0329880222058783,
    sourcecreditbureauageoldest >= 155.5                                       => 0.0164899118794175,
    sourcecreditbureauageoldest = NULL                                         => -0.0112565374311601,
                                                                                  -0.0112565374311601);

model1_attrsv4_tree_73_c364 := map(
    NULL < assocsuspicousidentitiescount AND assocsuspicousidentitiescount < 0.5 => 0.0282239895413756,
    assocsuspicousidentitiescount >= 0.5                                         => model1_attrsv4_tree_73_c365,
    assocsuspicousidentitiescount = NULL                                         => 0.00260685371950127,
                                                                                    0.00260685371950127);

model1_attrsv4_tree_73_c363 := map(
    NULL < inputaddractivephonelist AND inputaddractivephonelist < 0.5 => model1_attrsv4_tree_73_c364,
    inputaddractivephonelist >= 0.5                                    => 0.0586865614266745,
    inputaddractivephonelist = NULL                                    => 0.0158917553511035,
                                                                          0.0158917553511035);

model1_attrsv4_tree_73_c362 := map(
    NULL < beta_addr_bureau_only AND beta_addr_bureau_only < 0.5 => -0.00859753676679445,
    beta_addr_bureau_only >= 0.5                                 => model1_attrsv4_tree_73_c363,
    beta_addr_bureau_only = NULL                                 => -0.0055251895217963,
                                                                    -0.0055251895217963);

model1_attrsv4_tree_73 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 2.5 => model1_attrsv4_tree_73_c362,
    beta_srch_perphone_count03 >= 2.5                                      => 0.0215115672316205,
    beta_srch_perphone_count03 = NULL                                      => -0.00466434938931723,
                                                                              -0.00466434938931723);

model1_attrsv4_tree_74_c369 := map(
    NULL < variationphonecount AND variationphonecount < 0.5 => -0.011562512390779,
    variationphonecount >= 0.5                               => 0.0532694291796777,
    variationphonecount = NULL                               => 0.00112452823970534,
                                                                0.00112452823970534);

model1_attrsv4_tree_74_c368 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 4.5 => model1_attrsv4_tree_74_c369,
    friendlyfraudindex >= 4.5                              => 0.040190761714243,
    friendlyfraudindex = NULL                              => 0.00941297947192691,
                                                              0.00941297947192691);

model1_attrsv4_tree_74_c370 := map(
    NULL < searchphonesearchcountmonth AND searchphonesearchcountmonth < 0.5 => -0.0099406282938979,
    searchphonesearchcountmonth >= 0.5                                       => -0.046362728945409,
    searchphonesearchcountmonth = NULL                                       => -0.0110939768495983,
                                                                                -0.0110939768495983);

model1_attrsv4_tree_74_c367 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 5.5 => model1_attrsv4_tree_74_c368,
    sourcecreditbureauagechange >= 5.5                                       => model1_attrsv4_tree_74_c370,
    sourcecreditbureauagechange = NULL                                       => -0.00754566110820861,
                                                                                -0.00754566110820861);

model1_attrsv4_tree_74 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 4.5 => model1_attrsv4_tree_74_c367,
    vulnerablevictimindex >= 4.5                                 => 0.0536576287219558,
    vulnerablevictimindex = NULL                                 => -0.0053227114304149,
                                                                    -0.0053227114304149);

model1_attrsv4_tree_75_c373 := map(
    NULL < assoccount AND assoccount < 6.5 => -0.00221603209968433,
    assoccount >= 6.5                      => 0.0787758880309075,
    assoccount = NULL                      => 0.0369490748179258,
                                              0.0369490748179258);

model1_attrsv4_tree_75_c375 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 69 => 0.0633997496842107,
    beta_m_src_credentialed_fs >= 69                                      => 0.0108114985013954,
    beta_m_src_credentialed_fs = NULL                                     => 0.0252986200393611,
                                                                             0.0252986200393611);

model1_attrsv4_tree_75_c374 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 4.5 => -0.00523394266825781,
    searchaddrsearchcount >= 4.5                                 => model1_attrsv4_tree_75_c375,
    searchaddrsearchcount = NULL                                 => 0.00442051749103283,
                                                                    0.00442051749103283);

model1_attrsv4_tree_75_c372 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 8.5 => model1_attrsv4_tree_75_c373,
    inputaddrageoldest >= 8.5                              => model1_attrsv4_tree_75_c374,
    inputaddrageoldest = NULL                              => 0.00951132036438199,
                                                              0.00951132036438199);

model1_attrsv4_tree_75 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => -0.00878742321482929,
    divaddrphonecount >= 7.5                             => model1_attrsv4_tree_75_c372,
    divaddrphonecount = NULL                             => -0.00291369915555887,
                                                            -0.00291369915555887);

model1_attrsv4_tree_76_c380 := map(
    NULL < syntheticidentityindex AND syntheticidentityindex < 1.5 => 0.000603122248925248,
    syntheticidentityindex >= 1.5                                  => 0.0360054223749313,
    syntheticidentityindex = NULL                                  => 0.00198527621596298,
                                                                      0.00198527621596298);

model1_attrsv4_tree_76_c379 := map(
    NULL < validationphoneproblems AND validationphoneproblems < 3.5 => model1_attrsv4_tree_76_c380,
    validationphoneproblems >= 3.5                                   => -0.0292528367651786,
    validationphoneproblems = NULL                                   => -0.00319253419110144,
                                                                        -0.00319253419110144);

model1_attrsv4_tree_76_c378 := map(
    NULL < sbfehighbalance24m AND sbfehighbalance24m < 25301.5 => model1_attrsv4_tree_76_c379,
    sbfehighbalance24m >= 25301.5                              => 0.0718183718484626,
    sbfehighbalance24m = NULL                                  => -0.000152178779225548,
                                                                  -0.000152178779225548);

model1_attrsv4_tree_76_c377 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 1.5 => model1_attrsv4_tree_76_c378,
    vulnerablevictimindex >= 1.5                                 => 0.0676385741682748,
    vulnerablevictimindex = NULL                                 => 0.0019020864616078,
                                                                    0.0019020864616078);

model1_attrsv4_tree_76 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 136.5 => model1_attrsv4_tree_76_c377,
    businessrecordtimeoldest >= 136.5                                    => -0.0391887502656602,
    businessrecordtimeoldest = NULL                                      => -0.00688786375339977,
                                                                            -0.00688786375339977);

model1_attrsv4_tree_77_c385 := map(
    NULL < beta_srch_corrnamessn_id AND beta_srch_corrnamessn_id < 0.5 => -0.00733348632946267,
    beta_srch_corrnamessn_id >= 0.5                                    => 0.0422115717794207,
    beta_srch_corrnamessn_id = NULL                                    => 0.00943857614319435,
                                                                          0.00943857614319435);

model1_attrsv4_tree_77_c384 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 16.5 => 0.0560573855891577,
    inputaddrageoldest >= 16.5                              => model1_attrsv4_tree_77_c385,
    inputaddrageoldest = NULL                               => 0.0170312161181069,
                                                               0.0170312161181069);

model1_attrsv4_tree_77_c383 := map(
    NULL < curraddrlenofres AND curraddrlenofres < 8.5 => -0.0211888651988744,
    curraddrlenofres >= 8.5                            => model1_attrsv4_tree_77_c384,
    curraddrlenofres = NULL                            => 0.0106958222041508,
                                                          0.0106958222041508);

model1_attrsv4_tree_77_c382 := map(
    NULL < businessactivity03month AND businessactivity03month < 0.5 => model1_attrsv4_tree_77_c383,
    businessactivity03month >= 0.5                                   => -0.0093421264908222,
    businessactivity03month = NULL                                   => -0.00576773719380327,
                                                                        -0.00576773719380327);

model1_attrsv4_tree_77 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 7.5 => model1_attrsv4_tree_77_c382,
    beta_rel_count_for_bureau_only >= 7.5                                          => 0.0322379989425574,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00474588485428791,
                                                                                      -0.00474588485428791);

model1_attrsv4_tree_78_c387 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 3.5 => 0.0417663777972329,
    businessrecordtimeoldest >= 3.5                                    => 0.00188329207163708,
    businessrecordtimeoldest = NULL                                    => 0.0219230691357296,
                                                                          0.0219230691357296);

model1_attrsv4_tree_78_c390 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 9.5 => -0.0333787912926673,
    curraddrageoldest >= 9.5                             => -0.0043371891660146,
    curraddrageoldest = NULL                             => -0.00652377850959078,
                                                            -0.00652377850959078);

model1_attrsv4_tree_78_c389 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_78_c390,
    associatejudgmentcount >= 0.5                                  => 0.0653846970922484,
    associatejudgmentcount = NULL                                  => -0.00421724541997572,
                                                                      -0.00421724541997572);

model1_attrsv4_tree_78_c388 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0289829582949863,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_78_c389,
    sourcedriverslicense = NULL                                => -0.00306588834291486,
                                                                  -0.00306588834291486);

model1_attrsv4_tree_78 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 1.5 => model1_attrsv4_tree_78_c387,
    inputaddrageoldest >= 1.5                              => model1_attrsv4_tree_78_c388,
    inputaddrageoldest = NULL                              => -0.00186948306740429,
                                                              -0.00186948306740429);

model1_attrsv4_tree_79_c395 := map(
    NULL < searchssnsearchcountyear AND searchssnsearchcountyear < 2.5 => -0.00293107589197483,
    searchssnsearchcountyear >= 2.5                                    => -0.0592106029846788,
    searchssnsearchcountyear = NULL                                    => -0.00551179494737219,
                                                                          -0.00551179494737219);

model1_attrsv4_tree_79_c394 := map(
    NULL < divsearchaddridentitycount AND divsearchaddridentitycount < 2.5 => model1_attrsv4_tree_79_c395,
    divsearchaddridentitycount >= 2.5                                      => 0.0473289604743341,
    divsearchaddridentitycount = NULL                                      => -0.00148685756901819,
                                                                              -0.00148685756901819);

model1_attrsv4_tree_79_c393 := map(
    NULL < variationsearchphonecount AND variationsearchphonecount < 1.5 => model1_attrsv4_tree_79_c394,
    variationsearchphonecount >= 1.5                                     => 0.0458024466797768,
    variationsearchphonecount = NULL                                     => 0.000926048561960146,
                                                                            0.000926048561960146);

model1_attrsv4_tree_79_c392 := map(
    NULL < divaddrssncount AND divaddrssncount < 9.5 => -0.0266386294048363,
    divaddrssncount >= 9.5                           => model1_attrsv4_tree_79_c393,
    divaddrssncount = NULL                           => -0.00933462020801455,
                                                        -0.00933462020801455);

model1_attrsv4_tree_79 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 5.5 => model1_attrsv4_tree_79_c392,
    vulnerablevictimindex >= 5.5                                 => 0.0464550231242332,
    vulnerablevictimindex = NULL                                 => -0.00776882597298213,
                                                                    -0.00776882597298213);

model1_attrsv4_tree_80_c400 := map(
    NULL < sbfeclosedvoluntarycount AND sbfeclosedvoluntarycount < 0.5 => 0.00853612088935695,
    sbfeclosedvoluntarycount >= 0.5                                    => -0.040467194670124,
    sbfeclosedvoluntarycount = NULL                                    => -0.000645932578057817,
                                                                          -0.000645932578057817);

model1_attrsv4_tree_80_c399 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 0.5 => model1_attrsv4_tree_80_c400,
    beta_srch_perphone_count01 >= 0.5                                      => 0.0345397977707659,
    beta_srch_perphone_count01 = NULL                                      => 0.000768761280031267,
                                                                              0.000768761280031267);

model1_attrsv4_tree_80_c398 := map(
    NULL < searchphonesearchcountmonth AND searchphonesearchcountmonth < 0.5 => model1_attrsv4_tree_80_c399,
    searchphonesearchcountmonth >= 0.5                                       => -0.0370573180214247,
    searchphonesearchcountmonth = NULL                                       => -0.000778579639804215,
                                                                                -0.000778579639804215);

model1_attrsv4_tree_80_c397 := map(
    NULL < identityrisklevel AND identityrisklevel < 2.5 => model1_attrsv4_tree_80_c398,
    identityrisklevel >= 2.5                             => 0.0353149710107509,
    identityrisklevel = NULL                             => 0.000735078999560054,
                                                            0.000735078999560054);

model1_attrsv4_tree_80 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 1.5 => -0.0437779642402352,
    divssnaddrcount >= 1.5                           => model1_attrsv4_tree_80_c397,
    divssnaddrcount = NULL                           => -0.00172153706603242,
                                                        -0.00172153706603242);

model1_attrsv4_tree_81_c404 := map(
    NULL < divaddrphonecountnew AND divaddrphonecountnew < 3.5 => -0.00562015405544899,
    divaddrphonecountnew >= 3.5                                => -0.0346217245169073,
    divaddrphonecountnew = NULL                                => -0.00658192088390933,
                                                                  -0.00658192088390933);

model1_attrsv4_tree_81_c403 := map(
    NULL < searchcount AND searchcount < 22.5 => model1_attrsv4_tree_81_c404,
    searchcount >= 22.5                       => -0.037565062551301,
    searchcount = NULL                        => -0.00796267397727841,
                                                 -0.00796267397727841);

model1_attrsv4_tree_81_c402 := map(
    NULL < variationphonecountnew AND variationphonecountnew < 0.5 => model1_attrsv4_tree_81_c403,
    variationphonecountnew >= 0.5                                  => 0.0528934929947398,
    variationphonecountnew = NULL                                  => -0.00569867967028368,
                                                                      -0.00569867967028368);

model1_attrsv4_tree_81_c405 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 116 => 0.110773303475249,
    businessrecordtimeoldest >= 116                                    => -0.00799083592568222,
    businessrecordtimeoldest = NULL                                    => 0.050820252335356,
                                                                          0.050820252335356);

model1_attrsv4_tree_81 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_81_c402,
    associatebankruptcount >= 0.5                                  => model1_attrsv4_tree_81_c405,
    associatebankruptcount = NULL                                  => -0.00292605281717683,
                                                                      -0.00292605281717683);

model1_attrsv4_tree_82_c409 := map(
    NULL < beta_corrnamedob AND beta_corrnamedob < 1.5 => 0.00931521569357724,
    beta_corrnamedob >= 1.5                            => -0.0196228321074408,
    beta_corrnamedob = NULL                            => -0.00931385067558855,
                                                          -0.00931385067558855);

model1_attrsv4_tree_82_c408 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 0.5 => model1_attrsv4_tree_82_c409,
    beta_rel_count_for_bureau_only >= 0.5                                          => -0.0266645700503993,
    beta_rel_count_for_bureau_only = NULL                                          => -0.0100421075223802,
                                                                                      -0.0100421075223802);

model1_attrsv4_tree_82_c410 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 5 => -0.0169131326053634,
    sourcedriverslicense >= 5                                => 0.0824495403651077,
    sourcedriverslicense = NULL                              => 0.0275634924385618,
                                                                0.0275634924385618);

model1_attrsv4_tree_82_c407 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 5.5 => model1_attrsv4_tree_82_c408,
    searchphonesearchcount >= 5.5                                  => model1_attrsv4_tree_82_c410,
    searchphonesearchcount = NULL                                  => -0.00717179882654866,
                                                                      -0.00717179882654866);

model1_attrsv4_tree_82 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 7.5 => model1_attrsv4_tree_82_c407,
    beta_rel_count_for_bureau_only >= 7.5                                          => 0.0272625160502367,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00625409184987961,
                                                                                      -0.00625409184987961);

model1_attrsv4_tree_83_c413 := map(
    NULL < searchcount AND searchcount < 7.5 => -0.00291824498224249,
    searchcount >= 7.5                       => -0.0299217577293913,
    searchcount = NULL                       => -0.0114191643252465,
                                                -0.0114191643252465);

model1_attrsv4_tree_83_c415 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => 0.0402129778119377,
    businessactivity06month >= 0.5                                   => -0.00594685900365483,
    businessactivity06month = NULL                                   => 0.00109014613489917,
                                                                        0.00109014613489917);

model1_attrsv4_tree_83_c414 := map(
    NULL < correlationaddrnamecount AND correlationaddrnamecount < 2.5 => 0.0609221954960618,
    correlationaddrnamecount >= 2.5                                    => model1_attrsv4_tree_83_c415,
    correlationaddrnamecount = NULL                                    => 0.00787781560024114,
                                                                          0.00787781560024114);

model1_attrsv4_tree_83_c412 := map(
    NULL < sourceaccidents AND sourceaccidents < 0.5 => model1_attrsv4_tree_83_c413,
    sourceaccidents >= 0.5                           => model1_attrsv4_tree_83_c414,
    sourceaccidents = NULL                           => -0.00471288850787087,
                                                        -0.00471288850787087);

model1_attrsv4_tree_83 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_83_c412,
    associatejudgmentcount >= 0.5                                  => 0.0663237515765663,
    associatejudgmentcount = NULL                                  => -0.00251812439205453,
                                                                      -0.00251812439205453);

model1_attrsv4_tree_84_c419 := map(
    NULL < searchfraudsearchcount AND searchfraudsearchcount < 8.5 => -0.00680590082898327,
    searchfraudsearchcount >= 8.5                                  => -0.0475371854724974,
    searchfraudsearchcount = NULL                                  => -0.00885118074260909,
                                                                      -0.00885118074260909);

model1_attrsv4_tree_84_c420 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 2.5 => -0.00234809342985661,
    friendlyfraudindex >= 2.5                              => 0.0522573177492053,
    friendlyfraudindex = NULL                              => 0.0204293018409676,
                                                              0.0204293018409676);

model1_attrsv4_tree_84_c418 := map(
    NULL < divsearchaddrsuspidentitycount AND divsearchaddrsuspidentitycount < 0.5 => model1_attrsv4_tree_84_c419,
    divsearchaddrsuspidentitycount >= 0.5                                          => model1_attrsv4_tree_84_c420,
    divsearchaddrsuspidentitycount = NULL                                          => -0.00611015806475682,
                                                                                      -0.00611015806475682);

model1_attrsv4_tree_84_c417 := map(
    NULL < variationphonecountnew AND variationphonecountnew < 0.5 => model1_attrsv4_tree_84_c418,
    variationphonecountnew >= 0.5                                  => 0.0536349213577876,
    variationphonecountnew = NULL                                  => -0.00348107916804164,
                                                                      -0.00348107916804164);

model1_attrsv4_tree_84 := map(
    NULL < beta_srch_addrsperssn_count01 AND beta_srch_addrsperssn_count01 < 0.5 => model1_attrsv4_tree_84_c417,
    beta_srch_addrsperssn_count01 >= 0.5                                         => 0.0256583964801816,
    beta_srch_addrsperssn_count01 = NULL                                         => -0.00214093818893703,
                                                                                    -0.00214093818893703);

model1_attrsv4_tree_85_c424 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => 0.0170557430904779,
    inputaddroccupantowned >= -0.5                                  => -0.00320612741319402,
    inputaddroccupantowned = NULL                                   => 0.000668725767719678,
                                                                       0.000668725767719678);

model1_attrsv4_tree_85_c423 := map(
    NULL < associatecountycount AND associatecountycount < 1.5 => model1_attrsv4_tree_85_c424,
    associatecountycount >= 1.5                                => -0.0437805684774477,
    associatecountycount = NULL                                => -0.00520501421643458,
                                                                  -0.00520501421643458);

model1_attrsv4_tree_85_c425 := map(
    NULL < divaddrssncount AND divaddrssncount < 13.5 => -0.00452640645301586,
    divaddrssncount >= 13.5                           => 0.0435426727559769,
    divaddrssncount = NULL                            => 0.0192478312785076,
                                                         0.0192478312785076);

model1_attrsv4_tree_85_c422 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 0.5 => model1_attrsv4_tree_85_c423,
    beta_srch_perphone_count01 >= 0.5                                      => model1_attrsv4_tree_85_c425,
    beta_srch_perphone_count01 = NULL                                      => -0.00354932167131139,
                                                                              -0.00354932167131139);

model1_attrsv4_tree_85 := map(
    NULL < searchcountmonth AND searchcountmonth < 1.5 => model1_attrsv4_tree_85_c422,
    searchcountmonth >= 1.5                            => -0.0317594807346846,
    searchcountmonth = NULL                            => -0.00454066924217049,
                                                          -0.00454066924217049);

model1_attrsv4_tree_86_c429 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0225702976449297,
    sourcedriverslicense >= 0.5                                => -0.00652314096289415,
    sourcedriverslicense = NULL                                => -0.00538667851727603,
                                                                  -0.00538667851727603);

model1_attrsv4_tree_86_c430 := map(
    NULL < sourcevehicleregistration AND sourcevehicleregistration < 0.5 => 0.0512457821505795,
    sourcevehicleregistration >= 0.5                                     => -0.00508462258905694,
    sourcevehicleregistration = NULL                                     => 0.0192805127943572,
                                                                            0.0192805127943572);

model1_attrsv4_tree_86_c428 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 0.5 => model1_attrsv4_tree_86_c429,
    beta_srch_perphone_count01 >= 0.5                                      => model1_attrsv4_tree_86_c430,
    beta_srch_perphone_count01 = NULL                                      => -0.00381853214731347,
                                                                              -0.00381853214731347);

model1_attrsv4_tree_86_c427 := map(
    NULL < searchphonesearchcountyear AND searchphonesearchcountyear < 2.5 => model1_attrsv4_tree_86_c428,
    searchphonesearchcountyear >= 2.5                                      => -0.0371061410897004,
    searchphonesearchcountyear = NULL                                      => -0.00503222717438154,
                                                                              -0.00503222717438154);

model1_attrsv4_tree_86 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 5.5 => model1_attrsv4_tree_86_c427,
    searchaddrsearchcountyear >= 5.5                                     => 0.0361056583683838,
    searchaddrsearchcountyear = NULL                                     => -0.0038097334058937,
                                                                            -0.0038097334058937);

model1_attrsv4_tree_87_c435 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 4.5 => 0.0473300517234558,
    sourcecreditbureauagechange >= 4.5                                       => 0.000534217576328139,
    sourcecreditbureauagechange = NULL                                       => 0.00938288439687592,
                                                                                0.00938288439687592);

model1_attrsv4_tree_87_c434 := map(
    NULL < idverssncreditbureaucount AND idverssncreditbureaucount < 2.5 => -0.0296214113793309,
    idverssncreditbureaucount >= 2.5                                     => model1_attrsv4_tree_87_c435,
    idverssncreditbureaucount = NULL                                     => -0.000113347174497674,
                                                                            -0.000113347174497674);

model1_attrsv4_tree_87_c433 := map(
    NULL < busfeinpersonaddroverlap AND busfeinpersonaddroverlap < 1.5 => model1_attrsv4_tree_87_c434,
    busfeinpersonaddroverlap >= 1.5                                    => 0.0720811466348417,
    busfeinpersonaddroverlap = NULL                                    => 0.0108379762738269,
                                                                          0.0108379762738269);

model1_attrsv4_tree_87_c432 := map(
    NULL < idverdobsourcecount AND idverdobsourcecount < 1.5 => model1_attrsv4_tree_87_c433,
    idverdobsourcecount >= 1.5                               => -0.00992290041053097,
    idverdobsourcecount = NULL                               => -0.00558654376454154,
                                                                -0.00558654376454154);

model1_attrsv4_tree_87 := map(
    NULL < searchcountmonth AND searchcountmonth < 1.5 => model1_attrsv4_tree_87_c432,
    searchcountmonth >= 1.5                            => -0.032882211084455,
    searchcountmonth = NULL                            => -0.00646850282652931,
                                                          -0.00646850282652931);

model1_attrsv4_tree_88_c437 := map(
    NULL < variationsearchaddrcount AND variationsearchaddrcount < 1.5 => -0.0128378147308285,
    variationsearchaddrcount >= 1.5                                    => -0.0480919741902968,
    variationsearchaddrcount = NULL                                    => -0.0206601662218352,
                                                                          -0.0206601662218352);

model1_attrsv4_tree_88_c439 := map(
    NULL < assoccount AND assoccount < 10.5 => 0.00164082215452598,
    assoccount >= 10.5                      => 0.0689542618462117,
    assoccount = NULL                       => 0.0326169182958327,
                                               0.0326169182958327);

model1_attrsv4_tree_88_c440 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 15.5 => -0.00305012118629141,
    searchaddrsearchcount >= 15.5                                 => -0.0687125661421931,
    searchaddrsearchcount = NULL                                  => -0.00541907155935354,
                                                                     -0.00541907155935354);

model1_attrsv4_tree_88_c438 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 4.5 => model1_attrsv4_tree_88_c439,
    sourcecreditbureauagechange >= 4.5                                       => model1_attrsv4_tree_88_c440,
    sourcecreditbureauagechange = NULL                                       => -0.00181935057640878,
                                                                                -0.00181935057640878);

model1_attrsv4_tree_88 := map(
    NULL < curraddrlenofres AND curraddrlenofres < 14.5 => model1_attrsv4_tree_88_c437,
    curraddrlenofres >= 14.5                            => model1_attrsv4_tree_88_c438,
    curraddrlenofres = NULL                             => -0.00474323187232636,
                                                           -0.00474323187232636);

model1_attrsv4_tree_89_c444 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 9.5 => -0.00922000659553833,
    beta_srch_perbestssn >= 9.5                                => 0.0414703290189874,
    beta_srch_perbestssn = NULL                                => -0.00763916546736746,
                                                                  -0.00763916546736746);

model1_attrsv4_tree_89_c443 := map(
    NULL < beta_srch_corrnamephone AND beta_srch_corrnamephone < 2.5 => model1_attrsv4_tree_89_c444,
    beta_srch_corrnamephone >= 2.5                                   => -0.0410269813738018,
    beta_srch_corrnamephone = NULL                                   => -0.00881280916486585,
                                                                        -0.00881280916486585);

model1_attrsv4_tree_89_c445 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 12.5 => 0.0751094549938986,
    businessrecordtimeoldest >= 12.5                                    => -0.00962340858833904,
    businessrecordtimeoldest = NULL                                     => 0.0177300575773555,
                                                                           0.0177300575773555);

model1_attrsv4_tree_89_c442 := map(
    NULL < assochighrisktopologycount AND assochighrisktopologycount < 0.5 => model1_attrsv4_tree_89_c443,
    assochighrisktopologycount >= 0.5                                      => model1_attrsv4_tree_89_c445,
    assochighrisktopologycount = NULL                                      => -0.00531913268768459,
                                                                              -0.00531913268768459);

model1_attrsv4_tree_89 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.026759861850678,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_89_c442,
    sourcedriverslicense = NULL                                => -0.00422209160087737,
                                                                  -0.00422209160087737);

model1_attrsv4_tree_90_c449 := map(
    NULL < sourcerisklevel AND sourcerisklevel < 5.5 => -0.00360446313689026,
    sourcerisklevel >= 5.5                           => 0.0721739511450227,
    sourcerisklevel = NULL                           => 0.0119850138620721,
                                                        0.0119850138620721);

model1_attrsv4_tree_90_c448 := map(
    NULL < busfeinpersonaddroverlap AND busfeinpersonaddroverlap < 1.5 => -0.009901382927948,
    busfeinpersonaddroverlap >= 1.5                                    => model1_attrsv4_tree_90_c449,
    busfeinpersonaddroverlap = NULL                                    => -0.00652914042364225,
                                                                          -0.00652914042364225);

model1_attrsv4_tree_90_c450 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 12.5 => 0.0686600305585159,
    businessrecordtimeoldest >= 12.5                                    => 0.00057877359147433,
    businessrecordtimeoldest = NULL                                     => 0.0225190224187436,
                                                                           0.0225190224187436);

model1_attrsv4_tree_90_c447 := map(
    NULL < assochighrisktopologycount AND assochighrisktopologycount < 0.5 => model1_attrsv4_tree_90_c448,
    assochighrisktopologycount >= 0.5                                      => model1_attrsv4_tree_90_c450,
    assochighrisktopologycount = NULL                                      => -0.00293671062284477,
                                                                              -0.00293671062284477);

model1_attrsv4_tree_90 := map(
    NULL < divaddrsuspidentitycountnew AND divaddrsuspidentitycountnew < 2.5 => model1_attrsv4_tree_90_c447,
    divaddrsuspidentitycountnew >= 2.5                                       => 0.0397896482287123,
    divaddrsuspidentitycountnew = NULL                                       => -0.00192901348011937,
                                                                                -0.00192901348011937);

model1_attrsv4_tree_91_c455 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 87 => -0.0127203054008476,
    sourcecreditbureauageoldest >= 87                                       => 0.0404806142175425,
    sourcecreditbureauageoldest = NULL                                      => 0.0256510895852387,
                                                                               0.0256510895852387);

model1_attrsv4_tree_91_c454 := map(
    NULL < divphoneidentitycount AND divphoneidentitycount < 0.5 => model1_attrsv4_tree_91_c455,
    divphoneidentitycount >= 0.5                                 => -0.0171049129474033,
    divphoneidentitycount = NULL                                 => 0.00212858662449047,
                                                                    0.00212858662449047);

model1_attrsv4_tree_91_c453 := map(
    NULL < assochighrisktopologycount AND assochighrisktopologycount < 0.5 => model1_attrsv4_tree_91_c454,
    assochighrisktopologycount >= 0.5                                      => 0.0763775606783295,
    assochighrisktopologycount = NULL                                      => 0.010263331164932,
                                                                              0.010263331164932);

model1_attrsv4_tree_91_c452 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 10.5 => model1_attrsv4_tree_91_c453,
    businessrecordtimeoldest >= 10.5                                    => -0.0191955638567649,
    businessrecordtimeoldest = NULL                                     => -0.00893186422970641,
                                                                           -0.00893186422970641);

model1_attrsv4_tree_91 := map(
    NULL < sbfeavgutilever AND sbfeavgutilever < 55.5 => model1_attrsv4_tree_91_c452,
    sbfeavgutilever >= 55.5                           => 0.0678430272769314,
    sbfeavgutilever = NULL                            => -0.00663223894165382,
                                                         -0.00663223894165382);

model1_attrsv4_tree_92_c458 := map(
    NULL < beta_srch_nonbank_recency AND beta_srch_nonbank_recency < 0.5 => -0.0100539714881992,
    beta_srch_nonbank_recency >= 0.5                                     => 0.0312435164958958,
    beta_srch_nonbank_recency = NULL                                     => -0.00643078703634924,
                                                                            -0.00643078703634924);

model1_attrsv4_tree_92_c457 := map(
    NULL < divaddridentitycount AND divaddridentitycount < 56.5 => model1_attrsv4_tree_92_c458,
    divaddridentitycount >= 56.5                                => -0.0412506611662317,
    divaddridentitycount = NULL                                 => -0.00778381941728837,
                                                                   -0.00778381941728837);

model1_attrsv4_tree_92_c460 := map(
    NULL < beta_srch_corraddrssn_id AND beta_srch_corraddrssn_id < 1.5 => -0.0315193082435845,
    beta_srch_corraddrssn_id >= 1.5                                    => 0.0167381818513525,
    beta_srch_corraddrssn_id = NULL                                    => -0.0105217743854821,
                                                                          -0.0105217743854821);

model1_attrsv4_tree_92_c459 := map(
    NULL < searchcount AND searchcount < 7.5 => 0.0429524236319022,
    searchcount >= 7.5                       => model1_attrsv4_tree_92_c460,
    searchcount = NULL                       => 0.0122954435869247,
                                                0.0122954435869247);

model1_attrsv4_tree_92 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 1.5 => model1_attrsv4_tree_92_c457,
    beta_srch_perphone_count06 >= 1.5                                      => model1_attrsv4_tree_92_c459,
    beta_srch_perphone_count06 = NULL                                      => -0.00561961583405125,
                                                                              -0.00561961583405125);

model1_attrsv4_tree_93_c464 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 22.5 => -0.00566025456279881,
    divaddrphonemsourcecount >= 22.5                                    => 0.0419570374604544,
    divaddrphonemsourcecount = NULL                                     => -0.00436148424296393,
                                                                           -0.00436148424296393);

model1_attrsv4_tree_93_c463 := map(
    NULL < syntheticidentityindex AND syntheticidentityindex < 1.5 => model1_attrsv4_tree_93_c464,
    syntheticidentityindex >= 1.5                                  => -0.0305806393041298,
    syntheticidentityindex = NULL                                  => -0.00518447629301361,
                                                                      -0.00518447629301361);

model1_attrsv4_tree_93_c465 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 2.5 => -0.0100525925198985,
    variationlastnamecount >= 2.5                                  => 0.0404338855954873,
    variationlastnamecount = NULL                                  => 0.0199489567755065,
                                                                      0.0199489567755065);

model1_attrsv4_tree_93_c462 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_93_c463,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_93_c465,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00328245391621312,
                                                                        -0.00328245391621312);

model1_attrsv4_tree_93 := map(
    NULL < divaddrsuspidentitycountnew AND divaddrsuspidentitycountnew < 2.5 => model1_attrsv4_tree_93_c462,
    divaddrsuspidentitycountnew >= 2.5                                       => 0.03201558325081,
    divaddrsuspidentitycountnew = NULL                                       => -0.00241665300456916,
                                                                                -0.00241665300456916);

model1_attrsv4_tree_94_c469 := map(
    NULL < searchfraudsearchcountmonth AND searchfraudsearchcountmonth < 0.5 => -0.016804378306215,
    searchfraudsearchcountmonth >= 0.5                                       => -0.0451925122175598,
    searchfraudsearchcountmonth = NULL                                       => -0.0182502201701908,
                                                                                -0.0182502201701908);

model1_attrsv4_tree_94_c470 := map(
    NULL < beta_dob_bureau_only AND beta_dob_bureau_only < 0.5 => -0.00182940229148109,
    beta_dob_bureau_only >= 0.5                                => 0.0475941655621802,
    beta_dob_bureau_only = NULL                                => 0.00394737836673906,
                                                                  0.00394737836673906);

model1_attrsv4_tree_94_c468 := map(
    NULL < searchlocatesearchcount AND searchlocatesearchcount < 0.5 => model1_attrsv4_tree_94_c469,
    searchlocatesearchcount >= 0.5                                   => model1_attrsv4_tree_94_c470,
    searchlocatesearchcount = NULL                                   => -0.0108754342603326,
                                                                        -0.0108754342603326);

model1_attrsv4_tree_94_c467 := map(
    NULL < beta_srch_corraddrphone AND beta_srch_corraddrphone < 2.5 => model1_attrsv4_tree_94_c468,
    beta_srch_corraddrphone >= 2.5                                   => 0.0393613549579392,
    beta_srch_corraddrphone = NULL                                   => -0.00927081937129689,
                                                                        -0.00927081937129689);

model1_attrsv4_tree_94 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0251089611279369,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_94_c467,
    sourcedriverslicense = NULL                                => -0.00789238477580874,
                                                                  -0.00789238477580874);

model1_attrsv4_tree_95_c474 := map(
    NULL < inquiryconsumerphone AND inquiryconsumerphone < 0.5 => 0.0349429171530675,
    inquiryconsumerphone >= 0.5                                => -0.0207829461458394,
    inquiryconsumerphone = NULL                                => 0.00995501411967231,
                                                                  0.00995501411967231);

model1_attrsv4_tree_95_c473 := map(
    NULL < beta_addr_bureau_only AND beta_addr_bureau_only < 0.5 => model1_attrsv4_tree_95_c474,
    beta_addr_bureau_only >= 0.5                                 => 0.0374451504501998,
    beta_addr_bureau_only = NULL                                 => 0.0140397740733407,
                                                                    0.0140397740733407);

model1_attrsv4_tree_95_c472 := map(
    NULL < beta_srch_ssnsperaddr_count06 AND beta_srch_ssnsperaddr_count06 < 0.5 => -0.00481293612327288,
    beta_srch_ssnsperaddr_count06 >= 0.5                                         => model1_attrsv4_tree_95_c473,
    beta_srch_ssnsperaddr_count06 = NULL                                         => -0.000498664889399028,
                                                                                    -0.000498664889399028);

model1_attrsv4_tree_95_c475 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 100233.5 => 0.0464935099503778,
    inputaddrassessedtotal >= 100233.5                                  => -0.00119157512949123,
    inputaddrassessedtotal = NULL                                       => 0.0236679478979286,
                                                                           0.0236679478979286);

model1_attrsv4_tree_95 := map(
    NULL < variationsearchphonecount AND variationsearchphonecount < 1.5 => model1_attrsv4_tree_95_c472,
    variationsearchphonecount >= 1.5                                     => model1_attrsv4_tree_95_c475,
    variationsearchphonecount = NULL                                     => 0.000703966077140154,
                                                                            0.000703966077140154);

model1_attrsv4_tree_96_c478 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 11.5 => -0.0188933044218917,
    divssnaddrcount >= 11.5                           => 0.0367189441143331,
    divssnaddrcount = NULL                            => 0.0067386784425411,
                                                         0.0067386784425411);

model1_attrsv4_tree_96_c477 := map(
    NULL < idveraddressassoccount AND idveraddressassoccount < 0.5 => 0.0506747629662709,
    idveraddressassoccount >= 0.5                                  => model1_attrsv4_tree_96_c478,
    idveraddressassoccount = NULL                                  => 0.0223552177692779,
                                                                      0.0223552177692779);

model1_attrsv4_tree_96_c480 := map(
    NULL < searchcount AND searchcount < 10.5 => 0.0744966794292229,
    searchcount >= 10.5                       => -0.013606783406059,
    searchcount = NULL                        => 0.0278046234155719,
                                                 0.0278046234155719);

model1_attrsv4_tree_96_c479 := map(
    NULL < beta_srch_corrdobaddr AND beta_srch_corrdobaddr < 1.5 => -0.00378002681173253,
    beta_srch_corrdobaddr >= 1.5                                 => model1_attrsv4_tree_96_c480,
    beta_srch_corrdobaddr = NULL                                 => -0.00118817226292189,
                                                                    -0.00118817226292189);

model1_attrsv4_tree_96 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 2.5 => model1_attrsv4_tree_96_c477,
    sourcecreditbureauagechange >= 2.5                                       => model1_attrsv4_tree_96_c479,
    sourcecreditbureauagechange = NULL                                       => 0.000905190482865693,
                                                                                0.000905190482865693);

model1_attrsv4_tree_97_c485 := map(
    NULL < idveraddressassoccount AND idveraddressassoccount < 1.5 => 0.0131658759203364,
    idveraddressassoccount >= 1.5                                  => -0.0254762781993603,
    idveraddressassoccount = NULL                                  => 0.00170062140130552,
                                                                      0.00170062140130552);

model1_attrsv4_tree_97_c484 := map(
    NULL < sbfelastpaymentamt AND sbfelastpaymentamt < 55.5 => model1_attrsv4_tree_97_c485,
    sbfelastpaymentamt >= 55.5                              => 0.0754676550124185,
    sbfelastpaymentamt = NULL                               => 0.00911378293388854,
                                                               0.00911378293388854);

model1_attrsv4_tree_97_c483 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 1.5 => model1_attrsv4_tree_97_c484,
    beta_srch_perphone_count06 >= 1.5                                      => 0.0381588708224673,
    beta_srch_perphone_count06 = NULL                                      => 0.0117265344680935,
                                                                              0.0117265344680935);

model1_attrsv4_tree_97_c482 := map(
    NULL < beta_srch_corrnamephone_id AND beta_srch_corrnamephone_id < 1.5 => model1_attrsv4_tree_97_c483,
    beta_srch_corrnamephone_id >= 1.5                                      => -0.0226720700493998,
    beta_srch_corrnamephone_id = NULL                                      => 0.00860791524462617,
                                                                              0.00860791524462617);

model1_attrsv4_tree_97 := map(
    ((string)prevaddrstatus in ['O'])                => -0.0182789100258005,
    ((string)prevaddrstatus in ['', '-1', 'R', 'U']) => model1_attrsv4_tree_97_c482,
    prevaddrstatus = ''                   => -0.00897632213152788,
                                                -0.00897632213152788);

model1_attrsv4_tree_98_c489 := map(
    NULL < divrisklevel AND divrisklevel < 2.5 => 0.00171056291540449,
    divrisklevel >= 2.5                        => 0.0371063832802298,
    divrisklevel = NULL                        => 0.00365218772971197,
                                                  0.00365218772971197);

model1_attrsv4_tree_98_c488 := map(
    NULL < searchfraudsearchcountmonth AND searchfraudsearchcountmonth < 0.5 => model1_attrsv4_tree_98_c489,
    searchfraudsearchcountmonth >= 0.5                                       => -0.0267134821403066,
    searchfraudsearchcountmonth = NULL                                       => 0.00174018847035588,
                                                                                0.00174018847035588);

model1_attrsv4_tree_98_c490 := map(
    NULL < inputphoneproblems AND inputphoneproblems < 3.5 => -0.0245370780975582,
    inputphoneproblems >= 3.5                              => 0.110408541147353,
    inputphoneproblems = NULL                              => 0.0476431368473943,
                                                              0.0476431368473943);

model1_attrsv4_tree_98_c487 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_98_c488,
    associatebankruptcount >= 0.5                                  => model1_attrsv4_tree_98_c490,
    associatebankruptcount = NULL                                  => 0.00414377685346919,
                                                                      0.00414377685346919);

model1_attrsv4_tree_98 := map(
    NULL < beta_hh_members_for_bureau_only AND beta_hh_members_for_bureau_only < 3.5 => model1_attrsv4_tree_98_c487,
    beta_hh_members_for_bureau_only >= 3.5                                           => -0.0404698369434091,
    beta_hh_members_for_bureau_only = NULL                                           => 0.00273381830422822,
                                                                                        0.00273381830422822);

model1_attrsv4_tree_99_c495 := map(
    NULL < beta_corraddrdob AND beta_corraddrdob < 1.5 => 0.0503009475089067,
    beta_corraddrdob >= 1.5                            => 0.00798529405571897,
    beta_corraddrdob = NULL                            => 0.0357845910552347,
                                                          0.0357845910552347);

model1_attrsv4_tree_99_c494 := map(
    NULL < businessactivity06month AND businessactivity06month < 2.5 => model1_attrsv4_tree_99_c495,
    businessactivity06month >= 2.5                                   => -0.0220627373746568,
    businessactivity06month = NULL                                   => 0.0222670022812394,
                                                                        0.0222670022812394);

model1_attrsv4_tree_99_c493 := map(
    NULL < validationphoneproblems AND validationphoneproblems < 3.5 => model1_attrsv4_tree_99_c494,
    validationphoneproblems >= 3.5                                   => -0.0236648300051705,
    validationphoneproblems = NULL                                   => 0.0120735742604586,
                                                                        0.0120735742604586);

model1_attrsv4_tree_99_c492 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 13.5 => -0.00301417859311428,
    divaddrphonecount >= 13.5                             => model1_attrsv4_tree_99_c493,
    divaddrphonecount = NULL                              => -0.000281578318423602,
                                                             -0.000281578318423602);

model1_attrsv4_tree_99 := map(
    NULL < sbfeopencount36m AND sbfeopencount36m < 3.5 => model1_attrsv4_tree_99_c492,
    sbfeopencount36m >= 3.5                            => -0.0591803545189313,
    sbfeopencount36m = NULL                            => -0.00180961260664432,
                                                          -0.00180961260664432);

model1_attrsv4_tree_100_c498 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => -0.00772202753617542,
    friendlyfraudindex >= 6.5                              => -0.028233142394182,
    friendlyfraudindex = NULL                              => -0.00832314758268507,
                                                              -0.00832314758268507);

model1_attrsv4_tree_100_c497 := map(
    NULL < variationsearchphonecount AND variationsearchphonecount < 1.5 => model1_attrsv4_tree_100_c498,
    variationsearchphonecount >= 1.5                                     => 0.0302278682979542,
    variationsearchphonecount = NULL                                     => -0.006665908630018,
                                                                            -0.006665908630018);

model1_attrsv4_tree_100_c500 := map(
    NULL < divaddridentitycount AND divaddridentitycount < 13.5 => 0.0212434916235051,
    divaddridentitycount >= 13.5                                => 0.070454879686183,
    divaddridentitycount = NULL                                 => 0.0489842740835475,
                                                                   0.0489842740835475);

model1_attrsv4_tree_100_c499 := map(
    NULL < sbfehighutilrevolvingamt AND sbfehighutilrevolvingamt < 1493.5 => model1_attrsv4_tree_100_c500,
    sbfehighutilrevolvingamt >= 1493.5                                    => -0.00976965978611374,
    sbfehighutilrevolvingamt = NULL                                       => 0.0260356787368092,
                                                                             0.0260356787368092);

model1_attrsv4_tree_100 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => model1_attrsv4_tree_100_c497,
    inquiry03month >= 0.5                          => model1_attrsv4_tree_100_c499,
    inquiry03month = NULL                          => -0.00338803725480537,
                                                      -0.00338803725480537);

model1_attrsv4_tree_101_c505 := map(
    NULL < beta_srch_ssnsperaddr_count03 AND beta_srch_ssnsperaddr_count03 < 0.5 => -0.00101038969332424,
    beta_srch_ssnsperaddr_count03 >= 0.5                                         => 0.0460753076198072,
    beta_srch_ssnsperaddr_count03 = NULL                                         => 0.00629752057739412,
                                                                                    0.00629752057739412);

model1_attrsv4_tree_101_c504 := map(
    NULL < identityrisklevel AND identityrisklevel < 2.5 => model1_attrsv4_tree_101_c505,
    identityrisklevel >= 2.5                             => 0.0360359944196355,
    identityrisklevel = NULL                             => 0.00963451104154001,
                                                            0.00963451104154001);

model1_attrsv4_tree_101_c503 := map(
    NULL < divaddrssncount AND divaddrssncount < 35.5 => model1_attrsv4_tree_101_c504,
    divaddrssncount >= 35.5                           => -0.029044741516305,
    divaddrssncount = NULL                            => 0.00565492843196158,
                                                         0.00565492843196158);

model1_attrsv4_tree_101_c502 := map(
    NULL < beta_m_src_other_fs AND beta_m_src_other_fs < 131.5 => model1_attrsv4_tree_101_c503,
    beta_m_src_other_fs >= 131.5                               => 0.0589025816625833,
    beta_m_src_other_fs = NULL                                 => 0.0104597671746574,
                                                                  0.0104597671746574);

model1_attrsv4_tree_101 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 11.5 => model1_attrsv4_tree_101_c502,
    businessrecordtimeoldest >= 11.5                                    => -0.0101175254808975,
    businessrecordtimeoldest = NULL                                     => -0.00291061991639299,
                                                                           -0.00291061991639299);

model1_attrsv4_tree_102_c510 := map(
    NULL < prevaddragenewest AND prevaddragenewest < 1.5 => -0.0103448957730167,
    prevaddragenewest >= 1.5                             => 0.0329553039825458,
    prevaddragenewest = NULL                             => -0.00909378928585817,
                                                            -0.00909378928585817);

model1_attrsv4_tree_102_c509 := map(
    NULL < variationphonecountnew AND variationphonecountnew < 0.5 => model1_attrsv4_tree_102_c510,
    variationphonecountnew >= 0.5                                  => 0.0439631322525441,
    variationphonecountnew = NULL                                  => -0.00668274451933766,
                                                                      -0.00668274451933766);

model1_attrsv4_tree_102_c508 := map(
    NULL < sbfelimitcardamt06m AND sbfelimitcardamt06m < 54900 => model1_attrsv4_tree_102_c509,
    sbfelimitcardamt06m >= 54900                               => 0.0890136055649916,
    sbfelimitcardamt06m = NULL                                 => -0.0041618432255561,
                                                                  -0.0041618432255561);

model1_attrsv4_tree_102_c507 := map(
    NULL < idverdob AND idverdob < 5.5 => 0.043987766217702,
    idverdob >= 5.5                    => model1_attrsv4_tree_102_c508,
    idverdob = NULL                    => -0.00231448978897266,
                                          -0.00231448978897266);

model1_attrsv4_tree_102 := map(
    NULL < searchphonesearchcountyear AND searchphonesearchcountyear < 2.5 => model1_attrsv4_tree_102_c507,
    searchphonesearchcountyear >= 2.5                                      => -0.040562365120419,
    searchphonesearchcountyear = NULL                                      => -0.0038840959936122,
                                                                              -0.0038840959936122);

model1_attrsv4_tree_103_c514 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 6.5 => 0.0148199632723486,
    divaddrphonecount >= 6.5                             => 0.0559814368501369,
    divaddrphonecount = NULL                             => 0.0333911331693979,
                                                            0.0333911331693979);

model1_attrsv4_tree_103_c513 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 30.5 => model1_attrsv4_tree_103_c514,
    divaddrphonecount >= 30.5                             => -0.00714223401961024,
    divaddrphonecount = NULL                              => 0.023181217000882,
                                                             0.023181217000882);

model1_attrsv4_tree_103_c512 := map(
    NULL < divssnaddrmsourcecount AND divssnaddrmsourcecount < 1.5 => -0.0219498726748747,
    divssnaddrmsourcecount >= 1.5                                  => model1_attrsv4_tree_103_c513,
    divssnaddrmsourcecount = NULL                                  => 0.0122429567168722,
                                                                      0.0122429567168722);

model1_attrsv4_tree_103_c515 := map(
    NULL < searchlocatesearchcountyear AND searchlocatesearchcountyear < 0.5 => -0.009155962810309,
    searchlocatesearchcountyear >= 0.5                                       => 0.0377741687899474,
    searchlocatesearchcountyear = NULL                                       => -0.00640279577886231,
                                                                                -0.00640279577886231);

model1_attrsv4_tree_103 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 1.5 => model1_attrsv4_tree_103_c512,
    beta_m_src_credentialed_fs >= 1.5                                      => model1_attrsv4_tree_103_c515,
    beta_m_src_credentialed_fs = NULL                                      => -0.00409846221571021,
                                                                              -0.00409846221571021);

model1_attrsv4_tree_104_c517 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 8.5 => 0.0060038277433222,
    divaddrphonecount >= 8.5                             => 0.0488869285066103,
    divaddrphonecount = NULL                             => 0.0195659665147852,
                                                            0.0195659665147852);

model1_attrsv4_tree_104_c520 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 1.5 => 0.0051455798523794,
    beta_srch_perphone_count03 >= 1.5                                      => 0.0284266859983371,
    beta_srch_perphone_count03 = NULL                                      => 0.00665289847662802,
                                                                              0.00665289847662802);

model1_attrsv4_tree_104_c519 := map(
    NULL < busexeclinkauthrepnameonfile AND busexeclinkauthrepnameonfile < 0.5 => model1_attrsv4_tree_104_c520,
    busexeclinkauthrepnameonfile >= 0.5                                        => -0.0204181053168879,
    busexeclinkauthrepnameonfile = NULL                                        => -0.00675999250533635,
                                                                                  -0.00675999250533635);

model1_attrsv4_tree_104_c518 := map(
    NULL < componentcharrisklevel AND componentcharrisklevel < 6.5 => model1_attrsv4_tree_104_c519,
    componentcharrisklevel >= 6.5                                  => -0.0360056618602807,
    componentcharrisklevel = NULL                                  => -0.0079017384996734,
                                                                      -0.0079017384996734);

model1_attrsv4_tree_104 := map(
    NULL < beta_corrnamedob AND beta_corrnamedob < 0.5 => model1_attrsv4_tree_104_c517,
    beta_corrnamedob >= 0.5                            => model1_attrsv4_tree_104_c518,
    beta_corrnamedob = NULL                            => -0.00499301219035926,
                                                          -0.00499301219035926);

model1_attrsv4_tree_105_c524 := map(
    NULL < beta_srch_lnamesperid_count03 AND beta_srch_lnamesperid_count03 < 0.5 => -0.000956940891580173,
    beta_srch_lnamesperid_count03 >= 0.5                                         => 0.0311711123378538,
    beta_srch_lnamesperid_count03 = NULL                                         => 0.0022099924168676,
                                                                                    0.0022099924168676);

model1_attrsv4_tree_105_c523 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 4.5 => model1_attrsv4_tree_105_c524,
    suspiciousactivityindex >= 4.5                                   => -0.0329370554056704,
    suspiciousactivityindex = NULL                                   => 0.000607375456405963,
                                                                        0.000607375456405963);

model1_attrsv4_tree_105_c522 := map(
    NULL < searchssnsearchcountmonth AND searchssnsearchcountmonth < 0.5 => model1_attrsv4_tree_105_c523,
    searchssnsearchcountmonth >= 0.5                                     => -0.0307669236629558,
    searchssnsearchcountmonth = NULL                                     => -0.000843323203199618,
                                                                            -0.000843323203199618);

model1_attrsv4_tree_105_c525 := map(
    NULL < beta_srch_corrnamephone_id AND beta_srch_corrnamephone_id < -1.5 => -0.0020281536760088,
    beta_srch_corrnamephone_id >= -1.5                                      => 0.0545108847754901,
    beta_srch_corrnamephone_id = NULL                                       => 0.0261230830425199,
                                                                               0.0261230830425199);

model1_attrsv4_tree_105 := map(
    NULL < searchhighrisksearchcount AND searchhighrisksearchcount < 0.5 => model1_attrsv4_tree_105_c522,
    searchhighrisksearchcount >= 0.5                                     => model1_attrsv4_tree_105_c525,
    searchhighrisksearchcount = NULL                                     => 0.000676717148858631,
                                                                            0.000676717148858631);

model1_attrsv4_tree_106_c529 := map(
    NULL < identitysourcecount AND identitysourcecount < 7.5 => 0.0919570301705252,
    identitysourcecount >= 7.5                               => 0.0112878033558541,
    identitysourcecount = NULL                               => 0.0272257631790617,
                                                                0.0272257631790617);

model1_attrsv4_tree_106_c528 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 112.5 => -0.0135843968517181,
    beta_m_src_credentialed_fs >= 112.5                                      => model1_attrsv4_tree_106_c529,
    beta_m_src_credentialed_fs = NULL                                        => 0.0107566202568313,
                                                                                0.0107566202568313);

model1_attrsv4_tree_106_c530 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => 0.0136833085516604,
    divaddrphonecount >= 7.5                             => 0.0663860640618113,
    divaddrphonecount = NULL                             => 0.0324018734397485,
                                                            0.0324018734397485);

model1_attrsv4_tree_106_c527 := map(
    NULL < beta_srch_ssnsperaddr_count03 AND beta_srch_ssnsperaddr_count03 < 0.5 => model1_attrsv4_tree_106_c528,
    beta_srch_ssnsperaddr_count03 >= 0.5                                         => model1_attrsv4_tree_106_c530,
    beta_srch_ssnsperaddr_count03 = NULL                                         => 0.0142265613419866,
                                                                                    0.0142265613419866);

model1_attrsv4_tree_106 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 22.5 => model1_attrsv4_tree_106_c527,
    businessrecordtimeoldest >= 22.5                                    => -0.0136184819025735,
    businessrecordtimeoldest = NULL                                     => -0.00173836793337324,
                                                                           -0.00173836793337324);

model1_attrsv4_tree_107_c535 := map(
    NULL < beta_addr_bureau_only AND beta_addr_bureau_only < 0.5 => 0.0157617327529013,
    beta_addr_bureau_only >= 0.5                                 => 0.0434961754083029,
    beta_addr_bureau_only = NULL                                 => 0.0208509346687324,
                                                                    0.0208509346687324);

model1_attrsv4_tree_107_c534 := map(
    NULL < correlationssnnamecount AND correlationssnnamecount < 2.5 => -0.018612060630448,
    correlationssnnamecount >= 2.5                                   => model1_attrsv4_tree_107_c535,
    correlationssnnamecount = NULL                                   => 0.0128035787645858,
                                                                        0.0128035787645858);

model1_attrsv4_tree_107_c533 := map(
    NULL < divaddrssncount AND divaddrssncount < 20.5 => -0.0122818185407504,
    divaddrssncount >= 20.5                           => model1_attrsv4_tree_107_c534,
    divaddrssncount = NULL                            => -0.00584481093032452,
                                                         -0.00584481093032452);

model1_attrsv4_tree_107_c532 := map(
    NULL < beta_srch_addrsperssn_count01 AND beta_srch_addrsperssn_count01 < 0.5 => model1_attrsv4_tree_107_c533,
    beta_srch_addrsperssn_count01 >= 0.5                                         => 0.0395369550780487,
    beta_srch_addrsperssn_count01 = NULL                                         => -0.00468773721988794,
                                                                                    -0.00468773721988794);

model1_attrsv4_tree_107 := map(
    NULL < searchphonesearchcountmonth AND searchphonesearchcountmonth < 0.5 => model1_attrsv4_tree_107_c532,
    searchphonesearchcountmonth >= 0.5                                       => -0.0329534807703212,
    searchphonesearchcountmonth = NULL                                       => -0.00576103550093033,
                                                                                -0.00576103550093033);

model1_attrsv4_tree_108_c540 := map(
    NULL < searchbankingsearchcount AND searchbankingsearchcount < 3.5 => 0.0547451089081195,
    searchbankingsearchcount >= 3.5                                    => -0.0160021264220021,
    searchbankingsearchcount = NULL                                    => 0.0196826960905519,
                                                                          0.0196826960905519);

model1_attrsv4_tree_108_c539 := map(
    NULL < beta_srch_corrdobaddr_id AND beta_srch_corrdobaddr_id < 1.5 => -0.0115697728512616,
    beta_srch_corrdobaddr_id >= 1.5                                    => model1_attrsv4_tree_108_c540,
    beta_srch_corrdobaddr_id = NULL                                    => -0.0086886990720893,
                                                                          -0.0086886990720893);

model1_attrsv4_tree_108_c538 := map(
    NULL < identityrisklevel AND identityrisklevel < 3.5 => model1_attrsv4_tree_108_c539,
    identityrisklevel >= 3.5                             => 0.0222482600868299,
    identityrisklevel = NULL                             => -0.0073370066993237,
                                                            -0.0073370066993237);

model1_attrsv4_tree_108_c537 := map(
    NULL < validationssnproblems AND validationssnproblems < 1.5 => model1_attrsv4_tree_108_c538,
    validationssnproblems >= 1.5                                 => -0.0382728812690999,
    validationssnproblems = NULL                                 => -0.00915853508031782,
                                                                    -0.00915853508031782);

model1_attrsv4_tree_108 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_108_c537,
    associatejudgmentcount >= 0.5                                  => 0.0611260088819333,
    associatejudgmentcount = NULL                                  => -0.00700358443996578,
                                                                      -0.00700358443996578);

model1_attrsv4_tree_109_c544 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 69.5 => 0.072026776249253,
    businessrecordtimeoldest >= 69.5                                    => -0.0531130444361063,
    businessrecordtimeoldest = NULL                                     => 0.020833213241606,
                                                                           0.020833213241606);

model1_attrsv4_tree_109_c545 := map(
    NULL < searchlocatesearchcountyear AND searchlocatesearchcountyear < 0.5 => -0.0070903115317899,
    searchlocatesearchcountyear >= 0.5                                       => 0.043786474682545,
    searchlocatesearchcountyear = NULL                                       => -0.00425932978695409,
                                                                                -0.00425932978695409);

model1_attrsv4_tree_109_c543 := map(
    NULL < sourcecreditbureau AND sourcecreditbureau < 2.5 => model1_attrsv4_tree_109_c544,
    sourcecreditbureau >= 2.5                              => model1_attrsv4_tree_109_c545,
    sourcecreditbureau = NULL                              => -0.00261880691435878,
                                                              -0.00261880691435878);

model1_attrsv4_tree_109_c542 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 3.5 => model1_attrsv4_tree_109_c543,
    beta_synthidindex >= 3.5                             => -0.0244978434290202,
    beta_synthidindex = NULL                             => -0.00314754148455359,
                                                            -0.00314754148455359);

model1_attrsv4_tree_109 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 25.5 => model1_attrsv4_tree_109_c542,
    divssnaddrcount >= 25.5                           => 0.0632100266218264,
    divssnaddrcount = NULL                            => -0.00155120376123974,
                                                         -0.00155120376123974);

model1_attrsv4_tree_110_c550 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 137.5 => -0.0296808521583351,
    sourcecreditbureauageoldest >= 137.5                                       => 0.0361775124434747,
    sourcecreditbureauageoldest = NULL                                         => 0.0186929908677729,
                                                                                  0.0186929908677729);

model1_attrsv4_tree_110_c549 := map(
    NULL < sbfebalanceamt12m AND sbfebalanceamt12m < 1819.5 => model1_attrsv4_tree_110_c550,
    sbfebalanceamt12m >= 1819.5                             => 0.104232963181494,
    sbfebalanceamt12m = NULL                                => 0.0277393044865621,
                                                               0.0277393044865621);

model1_attrsv4_tree_110_c548 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 310.5 => model1_attrsv4_tree_110_c549,
    sourcecreditbureauageoldest >= 310.5                                       => -0.0163040607037716,
    sourcecreditbureauageoldest = NULL                                         => 0.00919376420858323,
                                                                                  0.00919376420858323);

model1_attrsv4_tree_110_c547 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 2.5 => -0.0185264240039137,
    variationlastnamecount >= 2.5                                  => model1_attrsv4_tree_110_c548,
    variationlastnamecount = NULL                                  => -0.00217757313233299,
                                                                      -0.00217757313233299);

model1_attrsv4_tree_110 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.027332157647095,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_110_c547,
    sourcedriverslicense = NULL                                => -0.00100135980645485,
                                                                  -0.00100135980645485);

model1_attrsv4_tree_111_c553 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 0.5 => -0.000670286798915386,
    beta_rel_count_for_bureau_only >= 0.5                                          => -0.0222881776951546,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00201196675513013,
                                                                                      -0.00201196675513013);

model1_attrsv4_tree_111_c554 := map(
    NULL < divphoneidentitycount AND divphoneidentitycount < 0.5 => 0.0467237941963678,
    divphoneidentitycount >= 0.5                                 => 0.000980724497300569,
    divphoneidentitycount = NULL                                 => 0.0170362390274368,
                                                                    0.0170362390274368);

model1_attrsv4_tree_111_c552 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 6.5 => model1_attrsv4_tree_111_c553,
    beta_srch_perbestssn >= 6.5                                => model1_attrsv4_tree_111_c554,
    beta_srch_perbestssn = NULL                                => -0.000582404591527939,
                                                                  -0.000582404591527939);

model1_attrsv4_tree_111_c555 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 237 => -0.0454873644632241,
    sourcecreditbureauageoldest >= 237                                       => 0.000933735448630535,
    sourcecreditbureauageoldest = NULL                                       => -0.021632077008521,
                                                                                -0.021632077008521);

model1_attrsv4_tree_111 := map(
    NULL < searchcomponentrisklevel AND searchcomponentrisklevel < 1.5 => model1_attrsv4_tree_111_c552,
    searchcomponentrisklevel >= 1.5                                    => model1_attrsv4_tree_111_c555,
    searchcomponentrisklevel = NULL                                    => -0.00165474639390306,
                                                                          -0.00165474639390306);

model1_attrsv4_tree_112_c559 := map(
    NULL < assoccount AND assoccount < 22.5 => 0.00930221531268869,
    assoccount >= 22.5                      => -0.0389718902341632,
    assoccount = NULL                       => 0.0012647493227634,
                                               0.0012647493227634);

model1_attrsv4_tree_112_c558 := map(
    NULL < searchcount AND searchcount < 3.5 => 0.0636443682419223,
    searchcount >= 3.5                       => model1_attrsv4_tree_112_c559,
    searchcount = NULL                       => 0.0104478116897824,
                                                0.0104478116897824);

model1_attrsv4_tree_112_c557 := map(
    NULL < beta_srch_corrdobssn_id AND beta_srch_corrdobssn_id < 0.5 => -0.0126920077576782,
    beta_srch_corrdobssn_id >= 0.5                                   => model1_attrsv4_tree_112_c558,
    beta_srch_corrdobssn_id = NULL                                   => -0.00606248124764957,
                                                                        -0.00606248124764957);

model1_attrsv4_tree_112_c560 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 16.5 => 0.0362535197667287,
    inputaddrageoldest >= 16.5                              => -0.000281546600233849,
    inputaddrageoldest = NULL                               => 0.016653162273723,
                                                               0.016653162273723);

model1_attrsv4_tree_112 := map(
    NULL < identityrisklevel AND identityrisklevel < 3.5 => model1_attrsv4_tree_112_c557,
    identityrisklevel >= 3.5                             => model1_attrsv4_tree_112_c560,
    identityrisklevel = NULL                             => -0.00481419234659301,
                                                            -0.00481419234659301);

model1_attrsv4_tree_113_c565 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => 0.00181608317691013,
    beta_srch_ssn_id_diff01 >= 0.5                                   => 0.031913390188279,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.00387593015656971,
                                                                        0.00387593015656971);

model1_attrsv4_tree_113_c564 := map(
    NULL < identityageoldest AND identityageoldest < 340.5 => model1_attrsv4_tree_113_c565,
    identityageoldest >= 340.5                             => -0.0315388123672297,
    identityageoldest = NULL                               => -0.00777096548183466,
                                                              -0.00777096548183466);

model1_attrsv4_tree_113_c563 := map(
    NULL < searchbankingsearchcountmonth AND searchbankingsearchcountmonth < 0.5 => model1_attrsv4_tree_113_c564,
    searchbankingsearchcountmonth >= 0.5                                         => 0.032940066832853,
    searchbankingsearchcountmonth = NULL                                         => -0.00644770186165182,
                                                                                    -0.00644770186165182);

model1_attrsv4_tree_113_c562 := map(
    NULL < searchphonesearchcountyear AND searchphonesearchcountyear < 2.5 => model1_attrsv4_tree_113_c563,
    searchphonesearchcountyear >= 2.5                                      => -0.0341352569724736,
    searchphonesearchcountyear = NULL                                      => -0.00766436791531988,
                                                                              -0.00766436791531988);

model1_attrsv4_tree_113 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_113_c562,
    associatejudgmentcount >= 0.5                                  => 0.052064881641338,
    associatejudgmentcount = NULL                                  => -0.0059598303690096,
                                                                      -0.0059598303690096);

model1_attrsv4_tree_114_c570 := map(
    NULL < beta_srch_corraddrssn_id AND beta_srch_corraddrssn_id < -1.5 => 0.00805754658538232,
    beta_srch_corraddrssn_id >= -1.5                                    => 0.0783862093018222,
    beta_srch_corraddrssn_id = NULL                                     => 0.0374858522610557,
                                                                           0.0374858522610557);

model1_attrsv4_tree_114_c569 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 33.5 => model1_attrsv4_tree_114_c570,
    inputaddrageoldest >= 33.5                              => -0.000955585277431289,
    inputaddrageoldest = NULL                               => 0.0072631299506607,
                                                               0.0072631299506607);

model1_attrsv4_tree_114_c568 := map(
    NULL < divaddrssncount AND divaddrssncount < 34.5 => model1_attrsv4_tree_114_c569,
    divaddrssncount >= 34.5                           => 0.0797036160403582,
    divaddrssncount = NULL                            => 0.01335014301792,
                                                         0.01335014301792);

model1_attrsv4_tree_114_c567 := map(
    NULL < sourceaccidents AND sourceaccidents < 0.5 => -0.00788176557995619,
    sourceaccidents >= 0.5                           => model1_attrsv4_tree_114_c568,
    sourceaccidents = NULL                           => -0.000209507516984618,
                                                        -0.000209507516984618);

model1_attrsv4_tree_114 := map(
    NULL < searchfraudsearchcountmonth AND searchfraudsearchcountmonth < 0.5 => model1_attrsv4_tree_114_c567,
    searchfraudsearchcountmonth >= 0.5                                       => -0.0263675898661884,
    searchfraudsearchcountmonth = NULL                                       => -0.00178269407336362,
                                                                                -0.00178269407336362);

model1_attrsv4_tree_115_c575 := map(
    NULL < sourcepublicrecord AND sourcepublicrecord < 0.5 => -0.032893573303607,
    sourcepublicrecord >= 0.5                              => 0.0406701030174713,
    sourcepublicrecord = NULL                              => -0.000480459215775547,
                                                              -0.000480459215775547);

model1_attrsv4_tree_115_c574 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 4.5 => model1_attrsv4_tree_115_c575,
    variationlastnamecount >= 4.5                                  => 0.0750253709328839,
    variationlastnamecount = NULL                                  => 0.0216188081448077,
                                                                      0.0216188081448077);

model1_attrsv4_tree_115_c573 := map(
    NULL < divsearchaddrsuspidentitycount AND divsearchaddrsuspidentitycount < 0.5 => -0.00549165187550624,
    divsearchaddrsuspidentitycount >= 0.5                                          => model1_attrsv4_tree_115_c574,
    divsearchaddrsuspidentitycount = NULL                                          => -0.00295004624860181,
                                                                                      -0.00295004624860181);

model1_attrsv4_tree_115_c572 := map(
    NULL < identitysourcecount AND identitysourcecount < 3.5 => 0.0302787992029411,
    identitysourcecount >= 3.5                               => model1_attrsv4_tree_115_c573,
    identitysourcecount = NULL                               => -0.00180085144637774,
                                                                -0.00180085144637774);

model1_attrsv4_tree_115 := map(
    NULL < beta_hh_members_for_bureau_only AND beta_hh_members_for_bureau_only < 2.5 => model1_attrsv4_tree_115_c572,
    beta_hh_members_for_bureau_only >= 2.5                                           => -0.0244478248875676,
    beta_hh_members_for_bureau_only = NULL                                           => -0.0026714780197065,
                                                                                        -0.0026714780197065);

model1_attrsv4_tree_116_c580 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 6.5 => 0.0207655721766057,
    beta_m_src_credentialed_fs >= 6.5                                      => -0.00900512146853117,
    beta_m_src_credentialed_fs = NULL                                      => -0.00555987362188686,
                                                                              -0.00555987362188686);

model1_attrsv4_tree_116_c579 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 25.5 => model1_attrsv4_tree_116_c580,
    divaddrssnmsourcecount >= 25.5                                  => -0.0261155766684306,
    divaddrssnmsourcecount = NULL                                   => -0.007408600824978,
                                                                       -0.007408600824978);

model1_attrsv4_tree_116_c578 := map(
    NULL < sbfeopencount06m AND sbfeopencount06m < 0.5 => model1_attrsv4_tree_116_c579,
    sbfeopencount06m >= 0.5                            => 0.0427765032900291,
    sbfeopencount06m = NULL                            => -0.00538713428444356,
                                                          -0.00538713428444356);

model1_attrsv4_tree_116_c577 := map(
    NULL < searchfraudsearchcount AND searchfraudsearchcount < 11.5 => model1_attrsv4_tree_116_c578,
    searchfraudsearchcount >= 11.5                                  => -0.0450213034144339,
    searchfraudsearchcount = NULL                                   => -0.00660768216987246,
                                                                       -0.00660768216987246);

model1_attrsv4_tree_116 := map(
    NULL < sbfeavgutilever AND sbfeavgutilever < 57.5 => model1_attrsv4_tree_116_c577,
    sbfeavgutilever >= 57.5                           => 0.0542669628378612,
    sbfeavgutilever = NULL                            => -0.00494224376871748,
                                                         -0.00494224376871748);

model1_attrsv4_tree_117_c585 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => 0.0495498838743454,
    inputaddroccupantowned >= -0.5                                  => 0.0113886369810712,
    inputaddroccupantowned = NULL                                   => 0.0181091521359212,
                                                                       0.0181091521359212);

model1_attrsv4_tree_117_c584 := map(
    NULL < beta_srch_corrnamessn AND beta_srch_corrnamessn < -2.5 => model1_attrsv4_tree_117_c585,
    beta_srch_corrnamessn >= -2.5                                 => -0.00984927881715691,
    beta_srch_corrnamessn = NULL                                  => -0.00357967209694166,
                                                                     -0.00357967209694166);

model1_attrsv4_tree_117_c583 := map(
    NULL < beta_srch_dobsperid_count01 AND beta_srch_dobsperid_count01 < 0.5 => model1_attrsv4_tree_117_c584,
    beta_srch_dobsperid_count01 >= 0.5                                       => 0.0300090376283585,
    beta_srch_dobsperid_count01 = NULL                                       => -0.00214979841482285,
                                                                                -0.00214979841482285);

model1_attrsv4_tree_117_c582 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 7.5 => model1_attrsv4_tree_117_c583,
    searchphonesearchcount >= 7.5                                  => 0.0883924209102909,
    searchphonesearchcount = NULL                                  => 0.000431806092006751,
                                                                      0.000431806092006751);

model1_attrsv4_tree_117 := map(
    NULL < searchfraudsearchcountyear AND searchfraudsearchcountyear < 2.5 => model1_attrsv4_tree_117_c582,
    searchfraudsearchcountyear >= 2.5                                      => -0.0296481239172824,
    searchfraudsearchcountyear = NULL                                      => -0.00202992402903649,
                                                                              -0.00202992402903649);

model1_attrsv4_tree_118_c589 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 0.5 => -0.000669979741082827,
    beta_srch_perbestssn >= 0.5                                => 0.0416879658889031,
    beta_srch_perbestssn = NULL                                => 0.0204438270037102,
                                                                  0.0204438270037102);

model1_attrsv4_tree_118_c590 := map(
    NULL < assocrisklevel AND assocrisklevel < 1.5 => -0.0236613829579377,
    assocrisklevel >= 1.5                          => 0.0192040676152946,
    assocrisklevel = NULL                          => -0.00549936081200804,
                                                      -0.00549936081200804);

model1_attrsv4_tree_118_c588 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 6.5 => model1_attrsv4_tree_118_c589,
    divssnaddrcount >= 6.5                           => model1_attrsv4_tree_118_c590,
    divssnaddrcount = NULL                           => 0.0040602038593167,
                                                        0.0040602038593167);

model1_attrsv4_tree_118_c587 := map(
    NULL < beta_m_src_other_fs AND beta_m_src_other_fs < 126.5 => model1_attrsv4_tree_118_c588,
    beta_m_src_other_fs >= 126.5                               => 0.062823197195884,
    beta_m_src_other_fs = NULL                                 => 0.0100442154007187,
                                                                  0.0100442154007187);

model1_attrsv4_tree_118 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 1.5 => model1_attrsv4_tree_118_c587,
    businessrecordtimeoldest >= 1.5                                    => -0.00661272370614586,
    businessrecordtimeoldest = NULL                                    => -0.00275491375262205,
                                                                          -0.00275491375262205);

model1_attrsv4_tree_119_c593 := map(
    NULL < beta_srch_corrdobssn_id AND beta_srch_corrdobssn_id < 0.5 => -0.0110856447041481,
    beta_srch_corrdobssn_id >= 0.5                                   => 0.0203987087298272,
    beta_srch_corrdobssn_id = NULL                                   => -0.00319949000206404,
                                                                        -0.00319949000206404);

model1_attrsv4_tree_119_c592 := map(
    NULL < searchphonesearchcountyear AND searchphonesearchcountyear < 2.5 => model1_attrsv4_tree_119_c593,
    searchphonesearchcountyear >= 2.5                                      => -0.0414277191819019,
    searchphonesearchcountyear = NULL                                      => -0.00471536778729395,
                                                                              -0.00471536778729395);

model1_attrsv4_tree_119_c595 := map(
    NULL < inputaddractivephonelist AND inputaddractivephonelist < 0.5 => 0.00881384577228317,
    inputaddractivephonelist >= 0.5                                    => 0.0947603540260153,
    inputaddractivephonelist = NULL                                    => 0.0531122663259689,
                                                                          0.0531122663259689);

model1_attrsv4_tree_119_c594 := map(
    NULL < sbfetimeoldestcard AND sbfetimeoldestcard < 5.5 => model1_attrsv4_tree_119_c595,
    sbfetimeoldestcard >= 5.5                              => -0.00742174667242454,
    sbfetimeoldestcard = NULL                              => 0.0243866351577498,
                                                              0.0243866351577498);

model1_attrsv4_tree_119 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => model1_attrsv4_tree_119_c592,
    inquiry03month >= 0.5                          => model1_attrsv4_tree_119_c594,
    inquiry03month = NULL                          => -0.00175025805327063,
                                                      -0.00175025805327063);

model1_attrsv4_tree_120_c600 := map(
    NULL < divphoneaddrcount AND divphoneaddrcount < 0.5 => 0.0480056998990252,
    divphoneaddrcount >= 0.5                             => 0.00330801105235136,
    divphoneaddrcount = NULL                             => 0.0161069087397249,
                                                            0.0161069087397249);

model1_attrsv4_tree_120_c599 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 4.5 => 0.05234145010132,
    sourcecreditbureauagechange >= 4.5                                       => model1_attrsv4_tree_120_c600,
    sourcecreditbureauagechange = NULL                                       => 0.0230005194625016,
                                                                                0.0230005194625016);

model1_attrsv4_tree_120_c598 := map(
    NULL < sbfehighutilcardamt AND sbfehighutilcardamt < 4979 => model1_attrsv4_tree_120_c599,
    sbfehighutilcardamt >= 4979                               => -0.0359162292771378,
    sbfehighutilcardamt = NULL                                => 0.0108722369079772,
                                                                 0.0108722369079772);

model1_attrsv4_tree_120_c597 := map(
    NULL < searchphonesearchcountyear AND searchphonesearchcountyear < 2.5 => model1_attrsv4_tree_120_c598,
    searchphonesearchcountyear >= 2.5                                      => -0.0329515853486175,
    searchphonesearchcountyear = NULL                                      => 0.00530845403286129,
                                                                              0.00530845403286129);

model1_attrsv4_tree_120 := map(
    NULL < beta_srch_corrdobssn_id AND beta_srch_corrdobssn_id < 0.5 => -0.0121108197133735,
    beta_srch_corrdobssn_id >= 0.5                                   => model1_attrsv4_tree_120_c597,
    beta_srch_corrdobssn_id = NULL                                   => -0.00712742842700961,
                                                                        -0.00712742842700961);

model1_attrsv4_tree_121_c605 := map(
    NULL < sourceaccidents AND sourceaccidents < 0.5 => -0.018211401360519,
    sourceaccidents >= 0.5                           => 0.00937804052288638,
    sourceaccidents = NULL                           => -0.00815368679770316,
                                                        -0.00815368679770316);

model1_attrsv4_tree_121_c604 := map(
    NULL < beta_srch_dobsperid_count01 AND beta_srch_dobsperid_count01 < 0.5 => model1_attrsv4_tree_121_c605,
    beta_srch_dobsperid_count01 >= 0.5                                       => 0.0605444233305098,
    beta_srch_dobsperid_count01 = NULL                                       => -0.00628521430147767,
                                                                                -0.00628521430147767);

model1_attrsv4_tree_121_c603 := map(
    NULL < searchphonesearchcountmonth AND searchphonesearchcountmonth < 0.5 => model1_attrsv4_tree_121_c604,
    searchphonesearchcountmonth >= 0.5                                       => -0.0365441238947692,
    searchphonesearchcountmonth = NULL                                       => -0.00746024302426285,
                                                                                -0.00746024302426285);

model1_attrsv4_tree_121_c602 := map(
    NULL < inputaddrlenofres AND inputaddrlenofres < 0.5 => 0.0239135110933618,
    inputaddrlenofres >= 0.5                             => model1_attrsv4_tree_121_c603,
    inputaddrlenofres = NULL                             => -0.0059734790477023,
                                                            -0.0059734790477023);

model1_attrsv4_tree_121 := map(
    NULL < assoccount AND assoccount < 0.5 => 0.0435214573198389,
    assoccount >= 0.5                      => model1_attrsv4_tree_121_c602,
    assoccount = NULL                      => -0.00475945230661167,
                                              -0.00475945230661167);

model1_attrsv4_tree_122_c610 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 12.5 => 0.0635989780972371,
    businessrecordtimeoldest >= 12.5                                    => -0.00441626704760897,
    businessrecordtimeoldest = NULL                                     => 0.0180395599208481,
                                                                           0.0180395599208481);

model1_attrsv4_tree_122_c609 := map(
    NULL < assochighrisktopologycount AND assochighrisktopologycount < 0.5 => -0.00570574758368452,
    assochighrisktopologycount >= 0.5                                      => model1_attrsv4_tree_122_c610,
    assochighrisktopologycount = NULL                                      => -0.00349083142616963,
                                                                              -0.00349083142616963);

model1_attrsv4_tree_122_c608 := map(
    NULL < assoccount AND assoccount < 20.5 => model1_attrsv4_tree_122_c609,
    assoccount >= 20.5                      => -0.0302868299924523,
    assoccount = NULL                       => -0.00731980279490495,
                                               -0.00731980279490495);

model1_attrsv4_tree_122_c607 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 8.5 => model1_attrsv4_tree_122_c608,
    variationlastnamecount >= 8.5                                  => 0.0461413995492901,
    variationlastnamecount = NULL                                  => -0.00561219682322304,
                                                                      -0.00561219682322304);

model1_attrsv4_tree_122 := map(
    NULL < variationphonecountnew AND variationphonecountnew < 0.5 => model1_attrsv4_tree_122_c607,
    variationphonecountnew >= 0.5                                  => 0.0389461360496676,
    variationphonecountnew = NULL                                  => -0.00382565989199865,
                                                                      -0.00382565989199865);

model1_attrsv4_tree_123_c613 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 4.5 => 0.0144396908954225,
    beta_srch_perbestssn >= 4.5                                => 0.0525978770233509,
    beta_srch_perbestssn = NULL                                => 0.0221114418514974,
                                                                  0.0221114418514974);

model1_attrsv4_tree_123_c615 := map(
    NULL < curraddrlenofres AND curraddrlenofres < 72.5 => -0.00381413111690967,
    curraddrlenofres >= 72.5                            => 0.111969764366613,
    curraddrlenofres = NULL                             => 0.0540778166248515,
                                                           0.0540778166248515);

model1_attrsv4_tree_123_c614 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 159.5 => model1_attrsv4_tree_123_c615,
    sourcecreditbureauageoldest >= 159.5                                       => -0.00959314070190762,
    sourcecreditbureauageoldest = NULL                                         => -0.0018493756216261,
                                                                                  -0.0018493756216261);

model1_attrsv4_tree_123_c612 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 41.5 => model1_attrsv4_tree_123_c613,
    inputaddrageoldest >= 41.5                              => model1_attrsv4_tree_123_c614,
    inputaddrageoldest = NULL                               => 0.00347447316583288,
                                                               0.00347447316583288);

model1_attrsv4_tree_123 := map(
    NULL < beta_cpnindex AND beta_cpnindex < 2.5 => model1_attrsv4_tree_123_c612,
    beta_cpnindex >= 2.5                         => -0.0175798466935116,
    beta_cpnindex = NULL                         => -0.000572524637319419,
                                                    -0.000572524637319419);

model1_attrsv4_tree_124_c619 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 2.5 => -0.0344414462148762,
    divaddrphonecount >= 2.5                             => 0.00434741149398911,
    divaddrphonecount = NULL                             => -0.00397041307352694,
                                                            -0.00397041307352694);

model1_attrsv4_tree_124_c620 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 191357 => -0.00418442278406434,
    inputaddrassessedtotal >= 191357                                  => 0.100512410591774,
    inputaddrassessedtotal = NULL                                     => 0.0479035540198353,
                                                                         0.0479035540198353);

model1_attrsv4_tree_124_c618 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_124_c619,
    associatebankruptcount >= 0.5                                  => model1_attrsv4_tree_124_c620,
    associatebankruptcount = NULL                                  => -0.00132472228799895,
                                                                      -0.00132472228799895);

model1_attrsv4_tree_124_c617 := map(
    NULL < divaddrssncount AND divaddrssncount < 42.5 => model1_attrsv4_tree_124_c618,
    divaddrssncount >= 42.5                           => -0.0340829969550923,
    divaddrssncount = NULL                            => -0.00265642430099909,
                                                         -0.00265642430099909);

model1_attrsv4_tree_124 := map(
    NULL < prevaddragenewest AND prevaddragenewest < 1.5 => model1_attrsv4_tree_124_c617,
    prevaddragenewest >= 1.5                             => 0.0383529908159366,
    prevaddragenewest = NULL                             => -0.00137971609452845,
                                                            -0.00137971609452845);

model1_attrsv4_tree_125_c624 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => 0.0310661262163477,
    businessactivity06month >= 0.5                                   => 0.009712655595413,
    businessactivity06month = NULL                                   => 0.0145946210207564,
                                                                        0.0145946210207564);

model1_attrsv4_tree_125_c623 := map(
    NULL < divssnaddrmsourcecount AND divssnaddrmsourcecount < 1.5 => -0.0251563209625911,
    divssnaddrmsourcecount >= 1.5                                  => model1_attrsv4_tree_125_c624,
    divssnaddrmsourcecount = NULL                                  => 0.0086238672861148,
                                                                      0.0086238672861148);

model1_attrsv4_tree_125_c622 := map(
    NULL < beta_sum_src_credentialed AND beta_sum_src_credentialed < 1.5 => model1_attrsv4_tree_125_c623,
    beta_sum_src_credentialed >= 1.5                                     => -0.00916324436265687,
    beta_sum_src_credentialed = NULL                                     => -0.00369406470157622,
                                                                            -0.00369406470157622);

model1_attrsv4_tree_125_c625 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 278.5 => 0.0759622217326139,
    sourcecreditbureauageoldest >= 278.5                                       => -0.0143805485373934,
    sourcecreditbureauageoldest = NULL                                         => 0.0339669496149152,
                                                                                  0.0339669496149152);

model1_attrsv4_tree_125 := map(
    NULL < searchlocatesearchcountyear AND searchlocatesearchcountyear < 0.5 => model1_attrsv4_tree_125_c622,
    searchlocatesearchcountyear >= 0.5                                       => model1_attrsv4_tree_125_c625,
    searchlocatesearchcountyear = NULL                                       => -0.00142019213907108,
                                                                                -0.00142019213907108);

model1_attrsv4_tree_126_c630 := map(
    NULL < sourceaccidents AND sourceaccidents < 0.5 => -0.0141582689979775,
    sourceaccidents >= 0.5                           => 0.0160053478854212,
    sourceaccidents = NULL                           => -0.00283249804913174,
                                                        -0.00283249804913174);

model1_attrsv4_tree_126_c629 := map(
    NULL < searchunverifiedaddrcountyear AND searchunverifiedaddrcountyear < 0.5 => model1_attrsv4_tree_126_c630,
    searchunverifiedaddrcountyear >= 0.5                                         => -0.0504401760988397,
    searchunverifiedaddrcountyear = NULL                                         => -0.00447673897307367,
                                                                                    -0.00447673897307367);

model1_attrsv4_tree_126_c628 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0250218264626653,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_126_c629,
    sourcedriverslicense = NULL                                => -0.00332579418536052,
                                                                  -0.00332579418536052);

model1_attrsv4_tree_126_c627 := map(
    NULL < searchbankingsearchcountmonth AND searchbankingsearchcountmonth < 0.5 => model1_attrsv4_tree_126_c628,
    searchbankingsearchcountmonth >= 0.5                                         => 0.0409149496995319,
    searchbankingsearchcountmonth = NULL                                         => -0.0019571878191694,
                                                                                    -0.0019571878191694);

model1_attrsv4_tree_126 := map(
    NULL < searchphonesearchcountmonth AND searchphonesearchcountmonth < 0.5 => model1_attrsv4_tree_126_c627,
    searchphonesearchcountmonth >= 0.5                                       => -0.0334375776909104,
    searchphonesearchcountmonth = NULL                                       => -0.00319709940138184,
                                                                                -0.00319709940138184);

model1_attrsv4_tree_127_c635 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 19.5 => 0.0381014857105683,
    beta_m_src_credentialed_fs >= 19.5                                      => 0.00731460762699608,
    beta_m_src_credentialed_fs = NULL                                       => 0.00978201512593801,
                                                                               0.00978201512593801);

model1_attrsv4_tree_127_c634 := map(
    NULL < curraddractivephonelist AND curraddractivephonelist < 0.5 => -0.0138951567217978,
    curraddractivephonelist >= 0.5                                   => model1_attrsv4_tree_127_c635,
    curraddractivephonelist = NULL                                   => -0.00211140727415984,
                                                                        -0.00211140727415984);

model1_attrsv4_tree_127_c633 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 3.5 => model1_attrsv4_tree_127_c634,
    beta_srch_perphone_count06 >= 3.5                                      => 0.033492541501094,
    beta_srch_perphone_count06 = NULL                                      => -0.00113131859416036,
                                                                              -0.00113131859416036);

model1_attrsv4_tree_127_c632 := map(
    NULL < beta_srch_idsperphone_count01 AND beta_srch_idsperphone_count01 < 0.5 => model1_attrsv4_tree_127_c633,
    beta_srch_idsperphone_count01 >= 0.5                                         => -0.0334606144392436,
    beta_srch_idsperphone_count01 = NULL                                         => -0.00220296474242468,
                                                                                    -0.00220296474242468);

model1_attrsv4_tree_127 := map(
    NULL < divaddrsuspidentitycountnew AND divaddrsuspidentitycountnew < 2.5 => model1_attrsv4_tree_127_c632,
    divaddrsuspidentitycountnew >= 2.5                                       => 0.0339270250182851,
    divaddrsuspidentitycountnew = NULL                                       => -0.00129119377440676,
                                                                                -0.00129119377440676);

model1_attrsv4_tree_128_c640 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 9.5 => -0.0242100511719528,
    curraddrageoldest >= 9.5                             => -0.00154310936645211,
    curraddrageoldest = NULL                             => -0.00351467692215204,
                                                            -0.00351467692215204);

model1_attrsv4_tree_128_c639 := map(
    NULL < sbfedelqavgamt84m AND sbfedelqavgamt84m < 79.5 => model1_attrsv4_tree_128_c640,
    sbfedelqavgamt84m >= 79.5                             => 0.0616166497004652,
    sbfedelqavgamt84m = NULL                              => -0.00161352795636285,
                                                             -0.00161352795636285);

model1_attrsv4_tree_128_c638 := map(
    NULL < beta_srch_addrsperssn_count01 AND beta_srch_addrsperssn_count01 < 0.5 => model1_attrsv4_tree_128_c639,
    beta_srch_addrsperssn_count01 >= 0.5                                         => 0.0299500591258244,
    beta_srch_addrsperssn_count01 = NULL                                         => -0.000733873895293528,
                                                                                    -0.000733873895293528);

model1_attrsv4_tree_128_c637 := map(
    NULL < searchcountmonth AND searchcountmonth < 1.5 => model1_attrsv4_tree_128_c638,
    searchcountmonth >= 1.5                            => -0.0319216793177255,
    searchcountmonth = NULL                            => -0.00175792827574094,
                                                          -0.00175792827574094);

model1_attrsv4_tree_128 := map(
    NULL < variationphonecountnew AND variationphonecountnew < 0.5 => model1_attrsv4_tree_128_c637,
    variationphonecountnew >= 0.5                                  => 0.0492181982161708,
    variationphonecountnew = NULL                                  => 0.00015367646770575,
                                                                      0.00015367646770575);

model1_attrsv4_tree_129_c644 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 245.5 => 0.00532090614358499,
    sourcecreditbureauageoldest >= 245.5                                       => -0.0184063824256541,
    sourcecreditbureauageoldest = NULL                                         => -0.0068933260460154,
                                                                                  -0.0068933260460154);

model1_attrsv4_tree_129_c645 := map(
    NULL < searchfraudsearchcount AND searchfraudsearchcount < 4.5 => -0.00465851871807584,
    searchfraudsearchcount >= 4.5                                  => -0.0478276448495318,
    searchfraudsearchcount = NULL                                  => -0.0257676508792724,
                                                                      -0.0257676508792724);

model1_attrsv4_tree_129_c643 := map(
    NULL < searchfraudsearchcountmonth AND searchfraudsearchcountmonth < 0.5 => model1_attrsv4_tree_129_c644,
    searchfraudsearchcountmonth >= 0.5                                       => model1_attrsv4_tree_129_c645,
    searchfraudsearchcountmonth = NULL                                       => -0.00795991099427264,
                                                                                -0.00795991099427264);

model1_attrsv4_tree_129_c642 := map(
    NULL < sbfeavgutilcardever AND sbfeavgutilcardever < 55.5 => model1_attrsv4_tree_129_c643,
    sbfeavgutilcardever >= 55.5                               => 0.0546762992632553,
    sbfeavgutilcardever = NULL                                => -0.00624613574993834,
                                                                 -0.00624613574993834);

model1_attrsv4_tree_129 := map(
    NULL < variationmsourcesssncount AND variationmsourcesssncount < 1.5 => model1_attrsv4_tree_129_c642,
    variationmsourcesssncount >= 1.5                                     => 0.0686602541882714,
    variationmsourcesssncount = NULL                                     => -0.00430280959588101,
                                                                            -0.00430280959588101);

model1_attrsv4_tree_130_c650 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 127.5 => 0.101119280518088,
    curraddrageoldest >= 127.5                             => 0.0210211001520959,
    curraddrageoldest = NULL                               => 0.0698105455216088,
                                                              0.0698105455216088);

model1_attrsv4_tree_130_c649 := map(
    NULL < curraddrlenofres AND curraddrlenofres < 18.5 => -0.0113667426980092,
    curraddrlenofres >= 18.5                            => model1_attrsv4_tree_130_c650,
    curraddrlenofres = NULL                             => 0.0494172267737536,
                                                           0.0494172267737536);

model1_attrsv4_tree_130_c648 := map(
    NULL < correlationphonelastnamecount AND correlationphonelastnamecount < 0.5 => model1_attrsv4_tree_130_c649,
    correlationphonelastnamecount >= 0.5                                         => 0.00731607376993992,
    correlationphonelastnamecount = NULL                                         => 0.0255243783390998,
                                                                                    0.0255243783390998);

model1_attrsv4_tree_130_c647 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 6.5 => -0.00225252072941333,
    divaddrphonecount >= 6.5                             => model1_attrsv4_tree_130_c648,
    divaddrphonecount = NULL                             => 0.00830581941371036,
                                                            0.00830581941371036);

model1_attrsv4_tree_130 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 2.5 => -0.0102231447912065,
    variationlastnamecount >= 2.5                                  => model1_attrsv4_tree_130_c647,
    variationlastnamecount = NULL                                  => 0.000675731795364898,
                                                                      0.000675731795364898);

model1_attrsv4_tree_131_c655 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 243614 => 0.0755948615444641,
    inputaddrassessedtotal >= 243614                                  => -0.0134974928948163,
    inputaddrassessedtotal = NULL                                     => 0.0309246002657162,
                                                                         0.0309246002657162);

model1_attrsv4_tree_131_c654 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => -0.0024807985797398,
    inquiry03month >= 0.5                          => model1_attrsv4_tree_131_c655,
    inquiry03month = NULL                          => 0.000613251519723231,
                                                      0.000613251519723231);

model1_attrsv4_tree_131_c653 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 1.5 => model1_attrsv4_tree_131_c654,
    beta_srch_ssn_id_diff01 >= 1.5                                   => -0.028672825602802,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.000137673534700493,
                                                                        -0.000137673534700493);

model1_attrsv4_tree_131_c652 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 10.5 => model1_attrsv4_tree_131_c653,
    beta_srch_perbestssn >= 10.5                                => 0.0296603525766049,
    beta_srch_perbestssn = NULL                                 => 0.000833371090522009,
                                                                   0.000833371090522009);

model1_attrsv4_tree_131 := map(
    NULL < sbfeopencount84m AND sbfeopencount84m < 5.5 => model1_attrsv4_tree_131_c652,
    sbfeopencount84m >= 5.5                            => -0.0548630953042799,
    sbfeopencount84m = NULL                            => -0.000848031668566352,
                                                          -0.000848031668566352);

model1_attrsv4_tree_132_c660 := map(
    NULL < beta_srch_ssnsperaddr_count03 AND beta_srch_ssnsperaddr_count03 < 0.5 => -0.00895387406272924,
    beta_srch_ssnsperaddr_count03 >= 0.5                                         => 0.0168599160539698,
    beta_srch_ssnsperaddr_count03 = NULL                                         => -0.00520455123309918,
                                                                                    -0.00520455123309918);

model1_attrsv4_tree_132_c659 := map(
    NULL < identityrecordcount AND identityrecordcount < 146.5 => model1_attrsv4_tree_132_c660,
    identityrecordcount >= 146.5                               => -0.0470786369135664,
    identityrecordcount = NULL                                 => -0.00858775550662037,
                                                                  -0.00858775550662037);

model1_attrsv4_tree_132_c658 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 24.5 => model1_attrsv4_tree_132_c659,
    divssnaddrcount >= 24.5                           => 0.0455673857545864,
    divssnaddrcount = NULL                            => -0.00678489549024217,
                                                         -0.00678489549024217);

model1_attrsv4_tree_132_c657 := map(
    NULL < divaddrssncount AND divaddrssncount < 42.5 => model1_attrsv4_tree_132_c658,
    divaddrssncount >= 42.5                           => -0.0409105229355636,
    divaddrssncount = NULL                            => -0.00824060992404602,
                                                         -0.00824060992404602);

model1_attrsv4_tree_132 := map(
    NULL < idverdob AND idverdob < 5.5 => 0.036974142168488,
    idverdob >= 5.5                    => model1_attrsv4_tree_132_c657,
    idverdob = NULL                    => -0.0065237290073248,
                                          -0.0065237290073248);

model1_attrsv4_tree_133_c664 := map(
    NULL < searchlocatesearchcountyear AND searchlocatesearchcountyear < 0.5 => 0.000636990788513464,
    searchlocatesearchcountyear >= 0.5                                       => 0.0473505589428356,
    searchlocatesearchcountyear = NULL                                       => 0.00361712272818314,
                                                                                0.00361712272818314);

model1_attrsv4_tree_133_c665 := map(
    NULL < idverdobsourcecount AND idverdobsourcecount < 1.5 => 0.0973697669951813,
    idverdobsourcecount >= 1.5                               => -0.00504978550839143,
    idverdobsourcecount = NULL                               => 0.0223696222484706,
                                                                0.0223696222484706);

model1_attrsv4_tree_133_c663 := map(
    NULL < busfeinpersonaddroverlap AND busfeinpersonaddroverlap < 1.5 => model1_attrsv4_tree_133_c664,
    busfeinpersonaddroverlap >= 1.5                                    => model1_attrsv4_tree_133_c665,
    busfeinpersonaddroverlap = NULL                                    => 0.00609019379679841,
                                                                          0.00609019379679841);

model1_attrsv4_tree_133_c662 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 116.5 => model1_attrsv4_tree_133_c663,
    businessrecordtimeoldest >= 116.5                                    => -0.030937721392199,
    businessrecordtimeoldest = NULL                                      => -0.0040193401689948,
                                                                            -0.0040193401689948);

model1_attrsv4_tree_133 := map(
    NULL < validationssnproblems AND validationssnproblems < 1.5 => model1_attrsv4_tree_133_c662,
    validationssnproblems >= 1.5                                 => -0.031172168338432,
    validationssnproblems = NULL                                 => -0.00572279589849251,
                                                                    -0.00572279589849251);

model1_attrsv4_tree_134_c670 := map(
    NULL < variationaddrchangeage AND variationaddrchangeage < 56.5 => 0.0082785550156646,
    variationaddrchangeage >= 56.5                                  => 0.0680948002465424,
    variationaddrchangeage = NULL                                   => 0.0361138374498354,
                                                                       0.0361138374498354);

model1_attrsv4_tree_134_c669 := map(
    NULL < beta_sum_src_credentialed AND beta_sum_src_credentialed < 1.5 => model1_attrsv4_tree_134_c670,
    beta_sum_src_credentialed >= 1.5                                     => 0.00037140064441459,
    beta_sum_src_credentialed = NULL                                     => 0.0112886973702639,
                                                                            0.0112886973702639);

model1_attrsv4_tree_134_c668 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 5.5 => model1_attrsv4_tree_134_c669,
    friendlyfraudindex >= 5.5                              => 0.0419409800144861,
    friendlyfraudindex = NULL                              => 0.0148643420954581,
                                                              0.0148643420954581);

model1_attrsv4_tree_134_c667 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => -0.00041358882232603,
    divaddrphonecount >= 7.5                             => model1_attrsv4_tree_134_c668,
    divaddrphonecount = NULL                             => 0.0040895913405799,
                                                            0.0040895913405799);

model1_attrsv4_tree_134 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 79.5 => -0.0181046367695189,
    sourcecreditbureauageoldest >= 79.5                                       => model1_attrsv4_tree_134_c667,
    sourcecreditbureauageoldest = NULL                                        => 0.00183876160299913,
                                                                                 0.00183876160299913);

model1_attrsv4_tree_135_c675 := map(
    NULL < searchssnsearchcountyear AND searchssnsearchcountyear < 3.5 => 0.00552724023705128,
    searchssnsearchcountyear >= 3.5                                    => -0.0476257231836509,
    searchssnsearchcountyear = NULL                                    => 0.00392876719432639,
                                                                          0.00392876719432639);

model1_attrsv4_tree_135_c674 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => model1_attrsv4_tree_135_c675,
    suspiciousactivityindex >= 5.5                                   => -0.0273158946921192,
    suspiciousactivityindex = NULL                                   => 0.00300003303953431,
                                                                        0.00300003303953431);

model1_attrsv4_tree_135_c673 := map(
    NULL < variationsearchssncount AND variationsearchssncount < 1.5 => model1_attrsv4_tree_135_c674,
    variationsearchssncount >= 1.5                                   => -0.0319573294029293,
    variationsearchssncount = NULL                                   => 0.000178205336733285,
                                                                        0.000178205336733285);

model1_attrsv4_tree_135_c672 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 24.5 => model1_attrsv4_tree_135_c673,
    divssnaddrcount >= 24.5                           => 0.0466087706804133,
    divssnaddrcount = NULL                            => 0.00157800842513988,
                                                         0.00157800842513988);

model1_attrsv4_tree_135 := map(
    NULL < sbfeavgutilever AND sbfeavgutilever < 55.5 => model1_attrsv4_tree_135_c672,
    sbfeavgutilever >= 55.5                           => 0.0591157497497555,
    sbfeavgutilever = NULL                            => 0.00330142662047624,
                                                         0.00330142662047624);

model1_attrsv4_tree_136_c680 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 14.5 => 0.00170215639057644,
    divaddrphonemsourcecount >= 14.5                                    => -0.036009100863125,
    divaddrphonemsourcecount = NULL                                     => -0.00104355262257461,
                                                                           -0.00104355262257461);

model1_attrsv4_tree_136_c679 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 2.5 => 0.0253146813836732,
    sourcecreditbureauagechange >= 2.5                                       => model1_attrsv4_tree_136_c680,
    sourcecreditbureauagechange = NULL                                       => 0.00101174989998848,
                                                                                0.00101174989998848);

model1_attrsv4_tree_136_c678 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 2.5 => model1_attrsv4_tree_136_c679,
    beta_srch_perphone_count03 >= 2.5                                      => 0.0317333721342521,
    beta_srch_perphone_count03 = NULL                                      => 0.00180007831958468,
                                                                              0.00180007831958468);

model1_attrsv4_tree_136_c677 := map(
    NULL < searchssnsearchcount AND searchssnsearchcount < 10.5 => model1_attrsv4_tree_136_c678,
    searchssnsearchcount >= 10.5                                => -0.0437704149042205,
    searchssnsearchcount = NULL                                 => 0.000271090217254234,
                                                                   0.000271090217254234);

model1_attrsv4_tree_136 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_136_c677,
    associatejudgmentcount >= 0.5                                  => 0.0684949587938579,
    associatejudgmentcount = NULL                                  => 0.00231458816754401,
                                                                      0.00231458816754401);

model1_attrsv4_tree_137_c684 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 2.5 => -0.0160986847061692,
    variationlastnamecount >= 2.5                                  => 0.00852338838274955,
    variationlastnamecount = NULL                                  => -0.00163717815854054,
                                                                      -0.00163717815854054);

model1_attrsv4_tree_137_c683 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_137_c684,
    associatejudgmentcount >= 0.5                                  => 0.0604834223812734,
    associatejudgmentcount = NULL                                  => 0.0000764935804888066,
                                                                      0.0000764935804888066);

model1_attrsv4_tree_137_c685 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 0.5 => -0.00334889537131126,
    beta_srch_perphone_count01 >= 0.5                                      => -0.031972426630171,
    beta_srch_perphone_count01 = NULL                                      => -0.0166713684457114,
                                                                              -0.0166713684457114);

model1_attrsv4_tree_137_c682 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 2.5 => model1_attrsv4_tree_137_c683,
    beta_srch_perphone_count06 >= 2.5                                      => model1_attrsv4_tree_137_c685,
    beta_srch_perphone_count06 = NULL                                      => -0.00080305290055801,
                                                                              -0.00080305290055801);

model1_attrsv4_tree_137 := map(
    NULL < sbfehighbalanceloan24m AND sbfehighbalanceloan24m < 15481 => model1_attrsv4_tree_137_c682,
    sbfehighbalanceloan24m >= 15481                                  => 0.0787381971793604,
    sbfehighbalanceloan24m = NULL                                    => 0.00122299780902482,
                                                                        0.00122299780902482);

model1_attrsv4_tree_138_c690 := map(
    NULL < correlationphonelastnamecount AND correlationphonelastnamecount < 0.5 => 0.0212284888310476,
    correlationphonelastnamecount >= 0.5                                         => -0.0019822550794182,
    correlationphonelastnamecount = NULL                                         => 0.00664624430555538,
                                                                                    0.00664624430555538);

model1_attrsv4_tree_138_c689 := map(
    NULL < correlationssnnamecount AND correlationssnnamecount < 0.5 => -0.0374383957244113,
    correlationssnnamecount >= 0.5                                   => model1_attrsv4_tree_138_c690,
    correlationssnnamecount = NULL                                   => 0.00347908105597981,
                                                                        0.00347908105597981);

model1_attrsv4_tree_138_c688 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 136.5 => model1_attrsv4_tree_138_c689,
    businessrecordtimeoldest >= 136.5                                    => -0.0450630322282656,
    businessrecordtimeoldest = NULL                                      => -0.00761901641457331,
                                                                            -0.00761901641457331);

model1_attrsv4_tree_138_c687 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 2.5 => 0.0352855216014866,
    prevaddrageoldest >= 2.5                             => model1_attrsv4_tree_138_c688,
    prevaddrageoldest = NULL                             => -0.00643701609223623,
                                                            -0.00643701609223623);

model1_attrsv4_tree_138 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 7.5 => model1_attrsv4_tree_138_c687,
    beta_rel_count_for_bureau_only >= 7.5                                          => 0.0332970453913159,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00548114951881115,
                                                                                      -0.00548114951881115);

model1_attrsv4_tree_139_c694 := map(
    NULL < identityrisklevel AND identityrisklevel < 1.5 => -0.00393236543581609,
    identityrisklevel >= 1.5                             => 0.0347099152241245,
    identityrisklevel = NULL                             => -0.00225928968314622,
                                                            -0.00225928968314622);

model1_attrsv4_tree_139_c693 := map(
    NULL < correlationssnnamecount AND correlationssnnamecount < 2.5 => -0.0303626510158192,
    correlationssnnamecount >= 2.5                                   => model1_attrsv4_tree_139_c694,
    correlationssnnamecount = NULL                                   => -0.00594174880950841,
                                                                        -0.00594174880950841);

model1_attrsv4_tree_139_c692 := map(
    NULL < beta_hh_members_for_bureau_only AND beta_hh_members_for_bureau_only < 2.5 => model1_attrsv4_tree_139_c693,
    beta_hh_members_for_bureau_only >= 2.5                                           => -0.0268089597630251,
    beta_hh_members_for_bureau_only = NULL                                           => -0.00685802177869036,
                                                                                        -0.00685802177869036);

model1_attrsv4_tree_139_c695 := map(
    NULL < identityageoldest AND identityageoldest < 345 => 0.0749508673491672,
    identityageoldest >= 345                             => -0.0039412823832796,
    identityageoldest = NULL                             => 0.0356935296832607,
                                                            0.0356935296832607);

model1_attrsv4_tree_139 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_139_c692,
    associatebankruptcount >= 0.5                                  => model1_attrsv4_tree_139_c695,
    associatebankruptcount = NULL                                  => -0.0047605514354008,
                                                                      -0.0047605514354008);

model1_attrsv4_tree_140_c698 := map(
    NULL < variationaddrstability AND variationaddrstability < 1.5 => 0.0247963665472343,
    variationaddrstability >= 1.5                                  => -0.00366849901552896,
    variationaddrstability = NULL                                  => -0.00116841858752195,
                                                                      -0.00116841858752195);

model1_attrsv4_tree_140_c699 := map(
    NULL < idveraddresssourcecount AND idveraddresssourcecount < 4.5 => -0.0428111117389526,
    idveraddresssourcecount >= 4.5                                   => -0.0070270913707868,
    idveraddresssourcecount = NULL                                   => -0.0171057947819756,
                                                                        -0.0171057947819756);

model1_attrsv4_tree_140_c697 := map(
    NULL < beta_srch_idsperssn_count03 AND beta_srch_idsperssn_count03 < 0.5 => model1_attrsv4_tree_140_c698,
    beta_srch_idsperssn_count03 >= 0.5                                       => model1_attrsv4_tree_140_c699,
    beta_srch_idsperssn_count03 = NULL                                       => -0.00270307013946362,
                                                                                -0.00270307013946362);

model1_attrsv4_tree_140_c700 := map(
    NULL < searchlocatesearchcount AND searchlocatesearchcount < 0.5 => 0.00692181139433544,
    searchlocatesearchcount >= 0.5                                   => 0.0886772698732526,
    searchlocatesearchcount = NULL                                   => 0.0457649025268526,
                                                                        0.0457649025268526);

model1_attrsv4_tree_140 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_140_c697,
    associatebankruptcount >= 0.5                                  => model1_attrsv4_tree_140_c700,
    associatebankruptcount = NULL                                  => -0.000176791375488176,
                                                                      -0.000176791375488176);

model1_attrsv4_tree_141_c704 := map(
    NULL < correlationphonelastnamecount AND correlationphonelastnamecount < 1.5 => 0.00651490072307868,
    correlationphonelastnamecount >= 1.5                                         => -0.0291569714184812,
    correlationphonelastnamecount = NULL                                         => -0.00270926363970665,
                                                                                    -0.00270926363970665);

model1_attrsv4_tree_141_c705 := map(
    NULL < sourcefirstreportingidentity AND sourcefirstreportingidentity < 1.5 => -0.00604694816269649,
    sourcefirstreportingidentity >= 1.5                                        => 0.0609143239373074,
    sourcefirstreportingidentity = NULL                                        => 0.0268892873011266,
                                                                                  0.0268892873011266);

model1_attrsv4_tree_141_c703 := map(
    NULL < searchlocatesearchcount AND searchlocatesearchcount < 3.5 => model1_attrsv4_tree_141_c704,
    searchlocatesearchcount >= 3.5                                   => model1_attrsv4_tree_141_c705,
    searchlocatesearchcount = NULL                                   => -0.000877043324798502,
                                                                        -0.000877043324798502);

model1_attrsv4_tree_141_c702 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 2.5 => model1_attrsv4_tree_141_c703,
    beta_synthidindex >= 2.5                             => -0.0207538012263139,
    beta_synthidindex = NULL                             => -0.0016648123668112,
                                                            -0.0016648123668112);

model1_attrsv4_tree_141 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 21.5 => 0.0360084014565192,
    sourcecreditbureauageoldest >= 21.5                                       => model1_attrsv4_tree_141_c702,
    sourcecreditbureauageoldest = NULL                                        => -0.000758522788985796,
                                                                                 -0.000758522788985796);

model1_attrsv4_tree_142_c710 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 75.5 => 0.0558078595432324,
    beta_m_src_credentialed_fs >= 75.5                                      => -0.00607703363500419,
    beta_m_src_credentialed_fs = NULL                                       => 0.00939418965955495,
                                                                               0.00939418965955495);

model1_attrsv4_tree_142_c709 := map(
    NULL < busfeinpersonaddroverlap AND busfeinpersonaddroverlap < 1.5 => -0.00884922212308768,
    busfeinpersonaddroverlap >= 1.5                                    => model1_attrsv4_tree_142_c710,
    busfeinpersonaddroverlap = NULL                                    => -0.00625323467617561,
                                                                          -0.00625323467617561);

model1_attrsv4_tree_142_c708 := map(
    NULL < sbfehighbalance84m AND sbfehighbalance84m < 23046 => model1_attrsv4_tree_142_c709,
    sbfehighbalance84m >= 23046                              => 0.0713211315075258,
    sbfehighbalance84m = NULL                                => -0.0036757127452686,
                                                                -0.0036757127452686);

model1_attrsv4_tree_142_c707 := map(
    NULL < sbfeclosedvoluntarycount AND sbfeclosedvoluntarycount < 0.5 => model1_attrsv4_tree_142_c708,
    sbfeclosedvoluntarycount >= 0.5                                    => -0.0445224780103739,
    sbfeclosedvoluntarycount = NULL                                    => -0.0105396332905445,
                                                                          -0.0105396332905445);

model1_attrsv4_tree_142 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_142_c707,
    associatejudgmentcount >= 0.5                                  => 0.0418715114146475,
    associatejudgmentcount = NULL                                  => -0.00910574348257231,
                                                                      -0.00910574348257231);

model1_attrsv4_tree_143_c715 := map(
    ((string)curraddrstatus in ['R', 'U'])      => -0.0168799629166041,
    ((string)curraddrstatus in ['', '-1', 'O']) => 0.0328696105987936,
    curraddrstatus = ''               => 0.00208534411412762,
                                           0.00208534411412762);

model1_attrsv4_tree_143_c714 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 4.5 => model1_attrsv4_tree_143_c715,
    variationlastnamecount >= 4.5                                  => 0.0377885069781164,
    variationlastnamecount = NULL                                  => 0.0102308418251016,
                                                                      0.0102308418251016);

model1_attrsv4_tree_143_c713 := map(
    NULL < prevaddrlenofres AND prevaddrlenofres < 107.5 => model1_attrsv4_tree_143_c714,
    prevaddrlenofres >= 107.5                            => 0.0878977739658112,
    prevaddrlenofres = NULL                              => 0.0312480209735984,
                                                            0.0312480209735984);

model1_attrsv4_tree_143_c712 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 4.5 => -0.0100869702234366,
    divaddrphonecount >= 4.5                             => model1_attrsv4_tree_143_c713,
    divaddrphonecount = NULL                             => 0.0135592925342979,
                                                            0.0135592925342979);

model1_attrsv4_tree_143 := map(
    NULL < businessrecordupdated12month AND businessrecordupdated12month < 0.5 => model1_attrsv4_tree_143_c712,
    businessrecordupdated12month >= 0.5                                        => -0.00688611519456041,
    businessrecordupdated12month = NULL                                        => -0.00146615333436308,
                                                                                  -0.00146615333436308);

model1_attrsv4_tree_144_c720 := map(
    NULL < assoccount AND assoccount < 37.5 => -0.00419669590558532,
    assoccount >= 37.5                      => 0.0567345667312919,
    assoccount = NULL                       => -0.0022212832544177,
                                               -0.0022212832544177);

model1_attrsv4_tree_144_c719 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 79.5 => -0.0327057571183823,
    sourcecreditbureauageoldest >= 79.5                                       => model1_attrsv4_tree_144_c720,
    sourcecreditbureauageoldest = NULL                                        => -0.00415249861438613,
                                                                                 -0.00415249861438613);

model1_attrsv4_tree_144_c718 := map(
    NULL < beta_srch_corrnameaddrssn AND beta_srch_corrnameaddrssn < 2.5 => model1_attrsv4_tree_144_c719,
    beta_srch_corrnameaddrssn >= 2.5                                     => 0.0341167040263386,
    beta_srch_corrnameaddrssn = NULL                                     => -0.00293052204755103,
                                                                            -0.00293052204755103);

model1_attrsv4_tree_144_c717 := map(
    NULL < identityageoldest AND identityageoldest < 33.5 => 0.0383363353692389,
    identityageoldest >= 33.5                             => model1_attrsv4_tree_144_c718,
    identityageoldest = NULL                              => -0.00172246398295128,
                                                             -0.00172246398295128);

model1_attrsv4_tree_144 := map(
    NULL < componentcharrisklevel AND componentcharrisklevel < 6.5 => model1_attrsv4_tree_144_c717,
    componentcharrisklevel >= 6.5                                  => -0.0295682713315156,
    componentcharrisklevel = NULL                                  => -0.00287176027681891,
                                                                      -0.00287176027681891);

model1_attrsv4_tree_145_c723 := map(
    NULL < sourcerisklevel AND sourcerisklevel < 7.5 => 0.00135429960538822,
    sourcerisklevel >= 7.5                           => -0.0269853407625124,
    sourcerisklevel = NULL                           => 0.000397687272294524,
                                                        0.000397687272294524);

model1_attrsv4_tree_145_c724 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 2.5 => -0.0077354379060905,
    divaddrphonemsourcecount >= 2.5                                    => -0.0360710149144001,
    divaddrphonemsourcecount = NULL                                    => -0.0166273553773174,
                                                                          -0.0166273553773174);

model1_attrsv4_tree_145_c722 := map(
    NULL < searchvelocityrisklevel AND searchvelocityrisklevel < 3.5 => model1_attrsv4_tree_145_c723,
    searchvelocityrisklevel >= 3.5                                   => model1_attrsv4_tree_145_c724,
    searchvelocityrisklevel = NULL                                   => -0.00262758052938372,
                                                                        -0.00262758052938372);

model1_attrsv4_tree_145_c725 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 114.5 => 0.0653369513753602,
    businessrecordtimeoldest >= 114.5                                    => -0.00927565285081082,
    businessrecordtimeoldest = NULL                                      => 0.0289405590699109,
                                                                            0.0289405590699109);

model1_attrsv4_tree_145 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_145_c722,
    associatebankruptcount >= 0.5                                  => model1_attrsv4_tree_145_c725,
    associatebankruptcount = NULL                                  => -0.0011012907610216,
                                                                      -0.0011012907610216);

model1_attrsv4_tree_146_c730 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 4.5 => 0.00154483800957997,
    searchaddrsearchcount >= 4.5                                 => 0.0473747292717326,
    searchaddrsearchcount = NULL                                 => 0.0150521411781805,
                                                                    0.0150521411781805);

model1_attrsv4_tree_146_c729 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 0.5 => model1_attrsv4_tree_146_c730,
    beta_srch_perphone_count01 >= 0.5                                      => 0.0441645478191733,
    beta_srch_perphone_count01 = NULL                                      => 0.0178070236480443,
                                                                              0.0178070236480443);

model1_attrsv4_tree_146_c728 := map(
    NULL < sourceproperty AND sourceproperty < 0.5 => model1_attrsv4_tree_146_c729,
    sourceproperty >= 0.5                          => -0.00968413152764588,
    sourceproperty = NULL                          => -0.00105498380993527,
                                                      -0.00105498380993527);

model1_attrsv4_tree_146_c727 := map(
    NULL < inputaddrlenofres AND inputaddrlenofres < 5.5 => -0.0153847454260078,
    inputaddrlenofres >= 5.5                             => model1_attrsv4_tree_146_c728,
    inputaddrlenofres = NULL                             => -0.00240599623568714,
                                                            -0.00240599623568714);

model1_attrsv4_tree_146 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 5.5 => model1_attrsv4_tree_146_c727,
    searchaddrsearchcountyear >= 5.5                                     => 0.028315043472193,
    searchaddrsearchcountyear = NULL                                     => -0.00158000601712621,
                                                                            -0.00158000601712621);

model1_attrsv4_tree_147_c735 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 10.5 => 0.0259418891060059,
    beta_m_src_credentialed_fs >= 10.5                                      => -0.00270483848527093,
    beta_m_src_credentialed_fs = NULL                                       => 0.00604832827873031,
                                                                               0.00604832827873031);

model1_attrsv4_tree_147_c734 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => model1_attrsv4_tree_147_c735,
    inputaddroccupantowned >= -0.5                                  => -0.00917238272245109,
    inputaddroccupantowned = NULL                                   => -0.00664858007947117,
                                                                       -0.00664858007947117);

model1_attrsv4_tree_147_c733 := map(
    NULL < addrchangedistance AND addrchangedistance < 2.5 => model1_attrsv4_tree_147_c734,
    addrchangedistance >= 2.5                              => -0.038004567486866,
    addrchangedistance = NULL                              => -0.00746139730040065,
                                                              -0.00746139730040065);

model1_attrsv4_tree_147_c732 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 5.5 => model1_attrsv4_tree_147_c733,
    searchaddrsearchcountyear >= 5.5                                     => 0.0319119122774902,
    searchaddrsearchcountyear = NULL                                     => -0.00640138338743778,
                                                                            -0.00640138338743778);

model1_attrsv4_tree_147 := map(
    NULL < prevaddragenewest AND prevaddragenewest < 1.5 => model1_attrsv4_tree_147_c732,
    prevaddragenewest >= 1.5                             => 0.0380140354563193,
    prevaddragenewest = NULL                             => -0.00517576923538128,
                                                            -0.00517576923538128);

model1_attrsv4_tree_148_c738 := map(
    NULL < beta_srch_corrdobssn_id AND beta_srch_corrdobssn_id < -0.5 => 0.0131411042488547,
    beta_srch_corrdobssn_id >= -0.5                                   => 0.0610659365309033,
    beta_srch_corrdobssn_id = NULL                                    => 0.0369843043891774,
                                                                         0.0369843043891774);

model1_attrsv4_tree_148_c737 := map(
    NULL < divssnlnamecount AND divssnlnamecount < 1.5 => -0.0164653731801799,
    divssnlnamecount >= 1.5                            => model1_attrsv4_tree_148_c738,
    divssnlnamecount = NULL                            => 0.0121836539969956,
                                                          0.0121836539969956);

model1_attrsv4_tree_148_c740 := map(
    NULL < beta_srch_corrdobphone AND beta_srch_corrdobphone < -2.5 => 0.0276769995561739,
    beta_srch_corrdobphone >= -2.5                                  => -0.00647850261944767,
    beta_srch_corrdobphone = NULL                                   => -0.0023751111753333,
                                                                       -0.0023751111753333);

model1_attrsv4_tree_148_c739 := map(
    NULL < sourcepublicrecordcount AND sourcepublicrecordcount < 9.5 => model1_attrsv4_tree_148_c740,
    sourcepublicrecordcount >= 9.5                                   => -0.0513003314281779,
    sourcepublicrecordcount = NULL                                   => -0.00378020805710969,
                                                                        -0.00378020805710969);

model1_attrsv4_tree_148 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 2.5 => model1_attrsv4_tree_148_c737,
    sourcecreditbureauagechange >= 2.5                                       => model1_attrsv4_tree_148_c739,
    sourcecreditbureauagechange = NULL                                       => -0.00236830988015462,
                                                                                -0.00236830988015462);

model1_attrsv4_tree_149_c745 := map(
    NULL < beta_cpnindex AND beta_cpnindex < 2.5 => -0.00115584889925377,
    beta_cpnindex >= 2.5                         => -0.0283164193293311,
    beta_cpnindex = NULL                         => -0.00544206976018186,
                                                    -0.00544206976018186);

model1_attrsv4_tree_149_c744 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 23.5 => 0.030855432282156,
    sourcecreditbureauageoldest >= 23.5                                       => model1_attrsv4_tree_149_c745,
    sourcecreditbureauageoldest = NULL                                        => -0.0044704890142461,
                                                                                 -0.0044704890142461);

model1_attrsv4_tree_149_c743 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 68.5 => model1_attrsv4_tree_149_c744,
    divaddrphonecount >= 68.5                             => -0.0356303124117835,
    divaddrphonecount = NULL                              => -0.00559449065984866,
                                                             -0.00559449065984866);

model1_attrsv4_tree_149_c742 := map(
    NULL < beta_sum_src_credentialed AND beta_sum_src_credentialed < 6.5 => model1_attrsv4_tree_149_c743,
    beta_sum_src_credentialed >= 6.5                                     => 0.0960503786081417,
    beta_sum_src_credentialed = NULL                                     => -0.00224572558706603,
                                                                            -0.00224572558706603);

model1_attrsv4_tree_149 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 7.5 => model1_attrsv4_tree_149_c742,
    beta_rel_count_for_bureau_only >= 7.5                                          => 0.020523870605501,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00164426455556426,
                                                                                      -0.00164426455556426);

model1_attrsv4_tree_150_c749 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 11.5 => 0.0337574210895316,
    inputaddrageoldest >= 11.5                              => 0.000416989353398291,
    inputaddrageoldest = NULL                               => 0.00661749647505723,
                                                               0.00661749647505723);

model1_attrsv4_tree_150_c748 := map(
    NULL < businessrecordupdated12month AND businessrecordupdated12month < 0.5 => model1_attrsv4_tree_150_c749,
    businessrecordupdated12month >= 0.5                                        => -0.012458753359425,
    businessrecordupdated12month = NULL                                        => -0.00721398391624798,
                                                                                  -0.00721398391624798);

model1_attrsv4_tree_150_c750 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 6.5 => 0.0486284290741293,
    businessrecordtimeoldest >= 6.5                                    => 0.0108330130790691,
    businessrecordtimeoldest = NULL                                    => 0.0212010162995039,
                                                                          0.0212010162995039);

model1_attrsv4_tree_150_c747 := map(
    NULL < assochighrisktopologycount AND assochighrisktopologycount < 0.5 => model1_attrsv4_tree_150_c748,
    assochighrisktopologycount >= 0.5                                      => model1_attrsv4_tree_150_c750,
    assochighrisktopologycount = NULL                                      => -0.00364562083027279,
                                                                              -0.00364562083027279);

model1_attrsv4_tree_150 := map(
    NULL < searchphonesearchcountmonth AND searchphonesearchcountmonth < 0.5 => model1_attrsv4_tree_150_c747,
    searchphonesearchcountmonth >= 0.5                                       => -0.0358053771219071,
    searchphonesearchcountmonth = NULL                                       => -0.0047605935130252,
                                                                                -0.0047605935130252);

model1_attrsv4_tree_151_c754 := map(
    NULL < divssnaddrmsourcecount AND divssnaddrmsourcecount < 11.5 => 0.00937225848984734,
    divssnaddrmsourcecount >= 11.5                                  => 0.064143125390543,
    divssnaddrmsourcecount = NULL                                   => 0.0241671174889438,
                                                                       0.0241671174889438);

model1_attrsv4_tree_151_c753 := map(
    NULL < beta_srch_phonesperid_count03 AND beta_srch_phonesperid_count03 < 0.5 => model1_attrsv4_tree_151_c754,
    beta_srch_phonesperid_count03 >= 0.5                                         => -0.026073337706653,
    beta_srch_phonesperid_count03 = NULL                                         => 0.0175080275695275,
                                                                                    0.0175080275695275);

model1_attrsv4_tree_151_c755 := map(
    NULL < divaddrssncount AND divaddrssncount < 29.5 => -0.0043748609911407,
    divaddrssncount >= 29.5                           => -0.041691986353689,
    divaddrssncount = NULL                            => -0.00785425952756848,
                                                         -0.00785425952756848);

model1_attrsv4_tree_151_c752 := map(
    NULL < prevaddrlenofres AND prevaddrlenofres < 27.5 => model1_attrsv4_tree_151_c753,
    prevaddrlenofres >= 27.5                            => model1_attrsv4_tree_151_c755,
    prevaddrlenofres = NULL                             => -0.00260667563994701,
                                                           -0.00260667563994701);

model1_attrsv4_tree_151 := map(
    NULL < beta_hh_members_for_bureau_only AND beta_hh_members_for_bureau_only < 2.5 => model1_attrsv4_tree_151_c752,
    beta_hh_members_for_bureau_only >= 2.5                                           => -0.0225660379392372,
    beta_hh_members_for_bureau_only = NULL                                           => -0.00334102953586429,
                                                                                        -0.00334102953586429);

model1_attrsv4_tree_152_c760 := map(
    NULL < correlationssnnamecount AND correlationssnnamecount < 6.5 => 0.0122955340430096,
    correlationssnnamecount >= 6.5                                   => 0.0935460418844777,
    correlationssnnamecount = NULL                                   => 0.0188745225321973,
                                                                        0.0188745225321973);

model1_attrsv4_tree_152_c759 := map(
    NULL < correlationphonelastnamecount AND correlationphonelastnamecount < 0.5 => model1_attrsv4_tree_152_c760,
    correlationphonelastnamecount >= 0.5                                         => -0.00527566280469745,
    correlationphonelastnamecount = NULL                                         => 0.00464631952765949,
                                                                                    0.00464631952765949);

model1_attrsv4_tree_152_c758 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 7.5 => model1_attrsv4_tree_152_c759,
    searchphonesearchcount >= 7.5                                  => 0.0609231085935591,
    searchphonesearchcount = NULL                                  => 0.00668520287631183,
                                                                      0.00668520287631183);

model1_attrsv4_tree_152_c757 := map(
    NULL < sbfedelq01amt12m AND sbfedelq01amt12m < -48.5 => model1_attrsv4_tree_152_c758,
    sbfedelq01amt12m >= -48.5                            => -0.0229020403608811,
    sbfedelq01amt12m = NULL                              => -0.00061155445344034,
                                                            -0.00061155445344034);

model1_attrsv4_tree_152 := map(
    NULL < variationaddrcountyear AND variationaddrcountyear < 1.5 => model1_attrsv4_tree_152_c757,
    variationaddrcountyear >= 1.5                                  => -0.0456802434851359,
    variationaddrcountyear = NULL                                  => -0.00167449523248976,
                                                                      -0.00167449523248976);

model1_attrsv4_tree_153_c765 := map(
    NULL < beta_srch_corrphonessn AND beta_srch_corrphonessn < 0.5 => -0.00746054179184363,
    beta_srch_corrphonessn >= 0.5                                  => -0.0441933985806374,
    beta_srch_corrphonessn = NULL                                  => -0.0158291160199357,
                                                                      -0.0158291160199357);

model1_attrsv4_tree_153_c764 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 4.5 => 0.0098723510150609,
    divaddrphonemsourcecount >= 4.5                                    => model1_attrsv4_tree_153_c765,
    divaddrphonemsourcecount = NULL                                    => 0.00452282199728568,
                                                                          0.00452282199728568);

model1_attrsv4_tree_153_c763 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0225044063778134,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_153_c764,
    sourcedriverslicense = NULL                                => 0.00554749479142735,
                                                                  0.00554749479142735);

model1_attrsv4_tree_153_c762 := map(
    NULL < sbfelegalstructure AND sbfelegalstructure < -48 => model1_attrsv4_tree_153_c763,
    sbfelegalstructure >= -48                              => 0.0666177036515224,
    sbfelegalstructure = NULL                              => 0.00965040288021927,
                                                              0.00965040288021927);

model1_attrsv4_tree_153 := map(
    NULL < inputaddrlotsize AND inputaddrlotsize < 8008.5 => model1_attrsv4_tree_153_c762,
    inputaddrlotsize >= 8008.5                            => -0.0219188161010225,
    inputaddrlotsize = NULL                               => -0.0017487655773942,
                                                             -0.0017487655773942);

model1_attrsv4_tree_154_c770 := map(
    NULL < searchssnsearchcount AND searchssnsearchcount < 8.5 => 0.00368592776151474,
    searchssnsearchcount >= 8.5                                => 0.058484619302554,
    searchssnsearchcount = NULL                                => 0.00627752736146432,
                                                                  0.00627752736146432);

model1_attrsv4_tree_154_c769 := map(
    NULL < beta_srch_addrsperssn_count03 AND beta_srch_addrsperssn_count03 < 0.5 => model1_attrsv4_tree_154_c770,
    beta_srch_addrsperssn_count03 >= 0.5                                         => -0.0245606540677933,
    beta_srch_addrsperssn_count03 = NULL                                         => 0.00418468094196134,
                                                                                    0.00418468094196134);

model1_attrsv4_tree_154_c768 := map(
    NULL < correlationssnnamecount AND correlationssnnamecount < 2.5 => -0.0238455281264981,
    correlationssnnamecount >= 2.5                                   => model1_attrsv4_tree_154_c769,
    correlationssnnamecount = NULL                                   => 0.000310473090209756,
                                                                        0.000310473090209756);

model1_attrsv4_tree_154_c767 := map(
    NULL < beta_srch_idsperssn_count01 AND beta_srch_idsperssn_count01 < 0.5 => model1_attrsv4_tree_154_c768,
    beta_srch_idsperssn_count01 >= 0.5                                       => 0.0318230914758134,
    beta_srch_idsperssn_count01 = NULL                                       => 0.001176036016212,
                                                                                0.001176036016212);

model1_attrsv4_tree_154 := map(
    NULL < searchcountmonth AND searchcountmonth < 1.5 => model1_attrsv4_tree_154_c767,
    searchcountmonth >= 1.5                            => -0.0348447761596083,
    searchcountmonth = NULL                            => 0.000105606220421109,
                                                          0.000105606220421109);

model1_attrsv4_tree_155_c775 := map(
    NULL < idverssnsourcecount AND idverssnsourcecount < 4.5 => 0.022956718356807,
    idverssnsourcecount >= 4.5                               => -0.00836992554982052,
    idverssnsourcecount = NULL                               => 0.00245469741850618,
                                                                0.00245469741850618);

model1_attrsv4_tree_155_c774 := map(
    NULL < identityageoldest AND identityageoldest < 115.5 => -0.0264754986664412,
    identityageoldest >= 115.5                             => model1_attrsv4_tree_155_c775,
    identityageoldest = NULL                               => -0.000858959978252958,
                                                              -0.000858959978252958);

model1_attrsv4_tree_155_c773 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 1.5 => 0.0301916913324768,
    sourcedriverslicense >= 1.5                                => model1_attrsv4_tree_155_c774,
    sourcedriverslicense = NULL                                => -0.0000291512768972374,
                                                                  -0.0000291512768972374);

model1_attrsv4_tree_155_c772 := map(
    NULL < idverssn AND idverssn < 3.5 => -0.0455415936317591,
    idverssn >= 3.5                    => model1_attrsv4_tree_155_c773,
    idverssn = NULL                    => -0.00230697418972519,
                                          -0.00230697418972519);

model1_attrsv4_tree_155 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 6.5 => model1_attrsv4_tree_155_c772,
    beta_rel_count_for_bureau_only >= 6.5                                          => 0.0231170321498549,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00168336648705624,
                                                                                      -0.00168336648705624);

model1_attrsv4_tree_156_c780 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 7.5 => -0.00122987399316398,
    searchphonesearchcount >= 7.5                                  => 0.0515209112389769,
    searchphonesearchcount = NULL                                  => 0.000487593432998746,
                                                                      0.000487593432998746);

model1_attrsv4_tree_156_c779 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 7.5 => model1_attrsv4_tree_156_c780,
    beta_srch_perbestssn >= 7.5                                => 0.0278418809310661,
    beta_srch_perbestssn = NULL                                => 0.00181899680679848,
                                                                  0.00181899680679848);

model1_attrsv4_tree_156_c778 := map(
    NULL < prevaddragenewest AND prevaddragenewest < 1.5 => model1_attrsv4_tree_156_c779,
    prevaddragenewest >= 1.5                             => 0.0356292350416032,
    prevaddragenewest = NULL                             => 0.00283475503702867,
                                                            0.00283475503702867);

model1_attrsv4_tree_156_c777 := map(
    NULL < searchssnsearchcountyear AND searchssnsearchcountyear < 3.5 => model1_attrsv4_tree_156_c778,
    searchssnsearchcountyear >= 3.5                                    => -0.031314161157628,
    searchssnsearchcountyear = NULL                                    => 0.00161277580610984,
                                                                          0.00161277580610984);

model1_attrsv4_tree_156 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 5.5 => model1_attrsv4_tree_156_c777,
    beta_rel_count_for_bureau_only >= 5.5                                          => 0.0226094190497132,
    beta_rel_count_for_bureau_only = NULL                                          => 0.00226644488822202,
                                                                                      0.00226644488822202);

model1_attrsv4_tree_157_c785 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 0.5 => 0.00881673177796028,
    beta_srch_perphone_count01 >= 0.5                                      => 0.0285456238379011,
    beta_srch_perphone_count01 = NULL                                      => 0.0100743184825525,
                                                                              0.0100743184825525);

model1_attrsv4_tree_157_c784 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 0.5 => model1_attrsv4_tree_157_c785,
    beta_rel_count_for_bureau_only >= 0.5                                          => 0.0272002189496363,
    beta_rel_count_for_bureau_only = NULL                                          => 0.0110574356161394,
                                                                                      0.0110574356161394);

model1_attrsv4_tree_157_c783 := map(
    NULL < validationssnproblems AND validationssnproblems < 0.5 => model1_attrsv4_tree_157_c784,
    validationssnproblems >= 0.5                                 => -0.0313540180631304,
    validationssnproblems = NULL                                 => 0.00815440563167604,
                                                                    0.00815440563167604);

model1_attrsv4_tree_157_c782 := map(
    NULL < inputaddrsqfootage AND inputaddrsqfootage < 2081.5 => model1_attrsv4_tree_157_c783,
    inputaddrsqfootage >= 2081.5                              => -0.0227299396930271,
    inputaddrsqfootage = NULL                                 => -0.00170820015510129,
                                                                 -0.00170820015510129);

model1_attrsv4_tree_157 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 1.5 => model1_attrsv4_tree_157_c782,
    beta_srch_ssn_id_diff01 >= 1.5                                   => -0.0249907806109352,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00236164993676267,
                                                                        -0.00236164993676267);

model1_attrsv4_tree_158_c789 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 29.5 => 0.000235789925877696,
    prevaddrageoldest >= 29.5                             => -0.0409863690875678,
    prevaddrageoldest = NULL                              => -0.0151288329791338,
                                                             -0.0151288329791338);

model1_attrsv4_tree_158_c788 := map(
    NULL < busexeclinkauthrepnameonfile AND busexeclinkauthrepnameonfile < 1.5 => model1_attrsv4_tree_158_c789,
    busexeclinkauthrepnameonfile >= 1.5                                        => 0.0325264986623911,
    busexeclinkauthrepnameonfile = NULL                                        => 0.000300557183491048,
                                                                                  0.000300557183491048);

model1_attrsv4_tree_158_c790 := map(
    NULL < beta_ssn_bureau_only AND beta_ssn_bureau_only < 0.5 => 0.0164806121657929,
    beta_ssn_bureau_only >= 0.5                                => 0.0873211675106695,
    beta_ssn_bureau_only = NULL                                => 0.0422408141093844,
                                                                  0.0422408141093844);

model1_attrsv4_tree_158_c787 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 62.5 => model1_attrsv4_tree_158_c788,
    inputaddrageoldest >= 62.5                              => model1_attrsv4_tree_158_c790,
    inputaddrageoldest = NULL                               => 0.0157978614222578,
                                                               0.0157978614222578);

model1_attrsv4_tree_158 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => model1_attrsv4_tree_158_c787,
    inputaddroccupantowned >= -0.5                                  => -0.00433431445280019,
    inputaddroccupantowned = NULL                                   => -0.000659242724664594,
                                                                       -0.000659242724664594);

model1_attrsv4_tree_159_c794 := map(
    NULL < idverdob AND idverdob < 4.5 => 0.0454412355249508,
    idverdob >= 4.5                    => -0.00473449995872393,
    idverdob = NULL                    => -0.00309521646892241,
                                          -0.00309521646892241);

model1_attrsv4_tree_159_c793 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 5.5 => 0.0404719882540415,
    prevaddrageoldest >= 5.5                             => model1_attrsv4_tree_159_c794,
    prevaddrageoldest = NULL                             => -0.0018507684101866,
                                                            -0.0018507684101866);

model1_attrsv4_tree_159_c792 := map(
    NULL < curraddrlenofres AND curraddrlenofres < 2.5 => -0.0339152717058096,
    curraddrlenofres >= 2.5                            => model1_attrsv4_tree_159_c793,
    curraddrlenofres = NULL                            => -0.00327693787696185,
                                                          -0.00327693787696185);

model1_attrsv4_tree_159_c795 := map(
    NULL < componentcharrisklevel AND componentcharrisklevel < 3.5 => 0.00216203280542019,
    componentcharrisklevel >= 3.5                                  => 0.0456805013007273,
    componentcharrisklevel = NULL                                  => 0.0196924406091835,
                                                                      0.0196924406091835);

model1_attrsv4_tree_159 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 3.5 => model1_attrsv4_tree_159_c792,
    searchaddrsearchcountyear >= 3.5                                     => model1_attrsv4_tree_159_c795,
    searchaddrsearchcountyear = NULL                                     => -0.00174384020913658,
                                                                            -0.00174384020913658);

model1_attrsv4_tree_160_c799 := map(
    NULL < sbfeavgbalanceever AND sbfeavgbalanceever < 6137.5 => 0.0218018645051003,
    sbfeavgbalanceever >= 6137.5                              => 0.121702997742832,
    sbfeavgbalanceever = NULL                                 => 0.0302638848369147,
                                                                 0.0302638848369147);

model1_attrsv4_tree_160_c798 := map(
    NULL < beta_corrssndob AND beta_corrssndob < 1.5 => model1_attrsv4_tree_160_c799,
    beta_corrssndob >= 1.5                           => -0.00729425198354546,
    beta_corrssndob = NULL                           => 0.00789892645081235,
                                                        0.00789892645081235);

model1_attrsv4_tree_160_c797 := map(
    NULL < divssnaddrmsourcecount AND divssnaddrmsourcecount < 4.5 => -0.0154513719955939,
    divssnaddrmsourcecount >= 4.5                                  => model1_attrsv4_tree_160_c798,
    divssnaddrmsourcecount = NULL                                  => 0.00250947680939513,
                                                                      0.00250947680939513);

model1_attrsv4_tree_160_c800 := map(
    NULL < associatecountycount AND associatecountycount < 0.5 => -0.0336953178886495,
    associatecountycount >= 0.5                                => 0.00827548060873433,
    associatecountycount = NULL                                => -0.0158703703340377,
                                                                  -0.0158703703340377);

model1_attrsv4_tree_160 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_160_c797,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_160_c800,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.00107030009910747,
                                                                        0.00107030009910747);

model1_attrsv4_tree_161_c805 := map(
    NULL < assoccount AND assoccount < 11.5 => -0.00570577900222078,
    assoccount >= 11.5                      => 0.0457421261315104,
    assoccount = NULL                       => 0.0178437405725493,
                                               0.0178437405725493);

model1_attrsv4_tree_161_c804 := map(
    NULL < beta_srch_corraddrphone AND beta_srch_corraddrphone < 0.5 => -0.00460794325340005,
    beta_srch_corraddrphone >= 0.5                                   => model1_attrsv4_tree_161_c805,
    beta_srch_corraddrphone = NULL                                   => -0.000922810855790036,
                                                                        -0.000922810855790036);

model1_attrsv4_tree_161_c803 := map(
    NULL < searchcountmonth AND searchcountmonth < 1.5 => model1_attrsv4_tree_161_c804,
    searchcountmonth >= 1.5                            => -0.0316063819165912,
    searchcountmonth = NULL                            => -0.00185733586271799,
                                                          -0.00185733586271799);

model1_attrsv4_tree_161_c802 := map(
    NULL < sbfeopencount84m AND sbfeopencount84m < 5.5 => model1_attrsv4_tree_161_c803,
    sbfeopencount84m >= 5.5                            => -0.058910993020432,
    sbfeopencount84m = NULL                            => -0.00358453247369481,
                                                          -0.00358453247369481);

model1_attrsv4_tree_161 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 3.5 => model1_attrsv4_tree_161_c802,
    vulnerablevictimindex >= 3.5                                 => 0.0630409369750015,
    vulnerablevictimindex = NULL                                 => -0.000803233395294044,
                                                                    -0.000803233395294044);

model1_attrsv4_tree_162_c810 := map(
    NULL < curraddrlenofres AND curraddrlenofres < 146.5 => 0.00618810109747966,
    curraddrlenofres >= 146.5                            => -0.0298180384969424,
    curraddrlenofres = NULL                              => -0.00590034081645531,
                                                            -0.00590034081645531);

model1_attrsv4_tree_162_c809 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 8.5 => model1_attrsv4_tree_162_c810,
    searchphonesearchcount >= 8.5                                  => 0.0551795376140963,
    searchphonesearchcount = NULL                                  => -0.00405822217068609,
                                                                      -0.00405822217068609);

model1_attrsv4_tree_162_c808 := map(
    NULL < identitysourcecount AND identitysourcecount < 3.5 => 0.0209065864082953,
    identitysourcecount >= 3.5                               => model1_attrsv4_tree_162_c809,
    identitysourcecount = NULL                               => -0.00293314146406,
                                                                -0.00293314146406);

model1_attrsv4_tree_162_c807 := map(
    NULL < divssnidentitymsourceurelcount AND divssnidentitymsourceurelcount < 0.5 => -0.0330136380365219,
    divssnidentitymsourceurelcount >= 0.5                                          => model1_attrsv4_tree_162_c808,
    divssnidentitymsourceurelcount = NULL                                          => -0.00573386484505101,
                                                                                      -0.00573386484505101);

model1_attrsv4_tree_162 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 1.5 => model1_attrsv4_tree_162_c807,
    beta_srch_perphone_count01 >= 1.5                                      => 0.0220445577455791,
    beta_srch_perphone_count01 = NULL                                      => -0.0050459557950472,
                                                                              -0.0050459557950472);

model1_attrsv4_tree_163_c815 := map(
    NULL < correlationrisklevel AND correlationrisklevel < 5.5 => 0.00833236940163303,
    correlationrisklevel >= 5.5                                => 0.0480255771541499,
    correlationrisklevel = NULL                                => 0.0223255970194558,
                                                                  0.0223255970194558);

model1_attrsv4_tree_163_c814 := map(
    NULL < divaddrssncountnew AND divaddrssncountnew < 1.5 => 0.000431225819771042,
    divaddrssncountnew >= 1.5                              => model1_attrsv4_tree_163_c815,
    divaddrssncountnew = NULL                              => 0.00300983018901478,
                                                              0.00300983018901478);

model1_attrsv4_tree_163_c813 := map(
    NULL < validationssnproblems AND validationssnproblems < 1.5 => model1_attrsv4_tree_163_c814,
    validationssnproblems >= 1.5                                 => -0.0403650411632327,
    validationssnproblems = NULL                                 => 0.00090436264080344,
                                                                    0.00090436264080344);

model1_attrsv4_tree_163_c812 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 3.5 => model1_attrsv4_tree_163_c813,
    beta_rel_count_for_bureau_only >= 3.5                                          => 0.0242836958182821,
    beta_rel_count_for_bureau_only = NULL                                          => 0.00166362152490842,
                                                                                      0.00166362152490842);

model1_attrsv4_tree_163 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 1.5 => -0.0380964917785016,
    divssnaddrcount >= 1.5                           => model1_attrsv4_tree_163_c812,
    divssnaddrcount = NULL                           => -0.000558818770588795,
                                                        -0.000558818770588795);

model1_attrsv4_tree_164_c819 := map(
    NULL < beta_srch_corrdobaddr AND beta_srch_corrdobaddr < -2.5 => -0.0329276240263383,
    beta_srch_corrdobaddr >= -2.5                                 => 0.0019659492860808,
    beta_srch_corrdobaddr = NULL                                  => -0.00237702764979968,
                                                                     -0.00237702764979968);

model1_attrsv4_tree_164_c820 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 199117.5 => 0.0016928112024948,
    inputaddrassessedtotal >= 199117.5                                  => 0.0760401779560903,
    inputaddrassessedtotal = NULL                                       => 0.0388664945792925,
                                                                           0.0388664945792925);

model1_attrsv4_tree_164_c818 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_164_c819,
    associatebankruptcount >= 0.5                                  => model1_attrsv4_tree_164_c820,
    associatebankruptcount = NULL                                  => -0.00027705197622065,
                                                                      -0.00027705197622065);

model1_attrsv4_tree_164_c817 := map(
    NULL < beta_srch_corrdobphone AND beta_srch_corrdobphone < 2.5 => model1_attrsv4_tree_164_c818,
    beta_srch_corrdobphone >= 2.5                                  => -0.0309606825227082,
    beta_srch_corrdobphone = NULL                                  => -0.00126733421361653,
                                                                      -0.00126733421361653);

model1_attrsv4_tree_164 := map(
    NULL < variationphonecountnew AND variationphonecountnew < 0.5 => model1_attrsv4_tree_164_c817,
    variationphonecountnew >= 0.5                                  => 0.0452364526803233,
    variationphonecountnew = NULL                                  => 0.000717851028789866,
                                                                      0.000717851028789866);

model1_attrsv4_tree_165_c823 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 4.5 => -0.00185043133105962,
    vulnerablevictimindex >= 4.5                                 => 0.040354464267901,
    vulnerablevictimindex = NULL                                 => -0.000405233390852787,
                                                                    -0.000405233390852787);

model1_attrsv4_tree_165_c825 := map(
    NULL < divaddrssncountnew AND divaddrssncountnew < 0.5 => -0.0297292640126786,
    divaddrssncountnew >= 0.5                              => 0.041005736689599,
    divaddrssncountnew = NULL                              => -0.00752384607069776,
                                                              -0.00752384607069776);

model1_attrsv4_tree_165_c824 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 0.5 => model1_attrsv4_tree_165_c825,
    searchphonesearchcount >= 0.5                                  => -0.0402331266394392,
    searchphonesearchcount = NULL                                  => -0.0244575883919998,
                                                                      -0.0244575883919998);

model1_attrsv4_tree_165_c822 := map(
    NULL < validationphoneproblems AND validationphoneproblems < 0.5 => model1_attrsv4_tree_165_c823,
    validationphoneproblems >= 0.5                                   => model1_attrsv4_tree_165_c824,
    validationphoneproblems = NULL                                   => -0.00518767542676913,
                                                                        -0.00518767542676913);

model1_attrsv4_tree_165 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 6.5 => model1_attrsv4_tree_165_c822,
    beta_rel_count_for_bureau_only >= 6.5                                          => -0.0375631705708694,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00611159875517388,
                                                                                      -0.00611159875517388);

model1_attrsv4_tree_166_c829 := map(
    NULL < beta_hh_members_for_bureau_only AND beta_hh_members_for_bureau_only < 0.5 => -0.00368226129226962,
    beta_hh_members_for_bureau_only >= 0.5                                           => 0.0359428118902956,
    beta_hh_members_for_bureau_only = NULL                                           => -0.00217294302034194,
                                                                                        -0.00217294302034194);

model1_attrsv4_tree_166_c828 := map(
    NULL < beta_hh_members_for_bureau_only AND beta_hh_members_for_bureau_only < 3.5 => model1_attrsv4_tree_166_c829,
    beta_hh_members_for_bureau_only >= 3.5                                           => -0.0322103618286348,
    beta_hh_members_for_bureau_only = NULL                                           => -0.00299544415281063,
                                                                                        -0.00299544415281063);

model1_attrsv4_tree_166_c827 := map(
    NULL < prevaddragenewest AND prevaddragenewest < 2.5 => model1_attrsv4_tree_166_c828,
    prevaddragenewest >= 2.5                             => 0.0465632096237208,
    prevaddragenewest = NULL                             => -0.00156139551641986,
                                                            -0.00156139551641986);

model1_attrsv4_tree_166_c830 := map(
    NULL < inputphoneproblems AND inputphoneproblems < 1.5 => -0.0412669104343274,
    inputphoneproblems >= 1.5                              => -0.00564523164503871,
    inputphoneproblems = NULL                              => -0.0213399317056659,
                                                              -0.0213399317056659);

model1_attrsv4_tree_166 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 10.5 => model1_attrsv4_tree_166_c827,
    divaddrphonemsourcecount >= 10.5                                    => model1_attrsv4_tree_166_c830,
    divaddrphonemsourcecount = NULL                                     => -0.00344595415331972,
                                                                           -0.00344595415331972);

model1_attrsv4_tree_167_c834 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 2.5 => -0.00094690777874059,
    divaddrphonemsourcecount >= 2.5                                    => 0.0443915048698869,
    divaddrphonemsourcecount = NULL                                    => 0.0189093313374466,
                                                                          0.0189093313374466);

model1_attrsv4_tree_167_c833 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 9.5 => model1_attrsv4_tree_167_c834,
    beta_m_src_credentialed_fs >= 9.5                                      => 0.00297717266482819,
    beta_m_src_credentialed_fs = NULL                                      => 0.00434051166429648,
                                                                              0.00434051166429648);

model1_attrsv4_tree_167_c832 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 1.5 => -0.019308202614223,
    variationlastnamecount >= 1.5                                  => model1_attrsv4_tree_167_c833,
    variationlastnamecount = NULL                                  => -0.0000549142542384193,
                                                                      -0.0000549142542384193);

model1_attrsv4_tree_167_c835 := map(
    NULL < verificationbusinputaddr AND verificationbusinputaddr < 0.5 => -0.0531881359905125,
    verificationbusinputaddr >= 0.5                                    => -0.001119661331286,
    verificationbusinputaddr = NULL                                    => -0.0255426592170469,
                                                                          -0.0255426592170469);

model1_attrsv4_tree_167 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 27.5 => model1_attrsv4_tree_167_c832,
    divaddrssnmsourcecount >= 27.5                                  => model1_attrsv4_tree_167_c835,
    divaddrssnmsourcecount = NULL                                   => -0.00190037125980026,
                                                                       -0.00190037125980026);

model1_attrsv4_tree_168_c839 := map(
    NULL < beta_srch_corraddrssn_id AND beta_srch_corraddrssn_id < -0.5 => 0.0152395069409951,
    beta_srch_corraddrssn_id >= -0.5                                    => 0.0596056728797823,
    beta_srch_corraddrssn_id = NULL                                     => 0.0249963816080313,
                                                                           0.0249963816080313);

model1_attrsv4_tree_168_c840 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 2.5 => 0.0271187067861921,
    beta_srch_perbestssn >= 2.5                                => -0.0321140490643244,
    beta_srch_perbestssn = NULL                                => 0.0017332399931136,
                                                                  0.0017332399931136);

model1_attrsv4_tree_168_c838 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 1.5 => model1_attrsv4_tree_168_c839,
    searchphonesearchcount >= 1.5                                  => model1_attrsv4_tree_168_c840,
    searchphonesearchcount = NULL                                  => 0.0168652700314271,
                                                                      0.0168652700314271);

model1_attrsv4_tree_168_c837 := map(
    NULL < sourcerisklevel AND sourcerisklevel < 5.5 => -0.0087202930347566,
    sourcerisklevel >= 5.5                           => model1_attrsv4_tree_168_c838,
    sourcerisklevel = NULL                           => -0.00410292765919836,
                                                        -0.00410292765919836);

model1_attrsv4_tree_168 := map(
    NULL < divaddridentitycount AND divaddridentitycount < 60.5 => model1_attrsv4_tree_168_c837,
    divaddridentitycount >= 60.5                                => -0.0440946666453982,
    divaddridentitycount = NULL                                 => -0.00536681752338486,
                                                                   -0.00536681752338486);

model1_attrsv4_tree_169_c843 := map(
    NULL < divaddrssncountnew AND divaddrssncountnew < 1.5 => -0.024906201945284,
    divaddrssncountnew >= 1.5                              => 0.0231064440944685,
    divaddrssncountnew = NULL                              => -0.00141800100497342,
                                                              -0.00141800100497342);

model1_attrsv4_tree_169_c842 := map(
    NULL < curraddrlenofres AND curraddrlenofres < 8.5 => model1_attrsv4_tree_169_c843,
    curraddrlenofres >= 8.5                            => 0.0467718931368281,
    curraddrlenofres = NULL                            => 0.0150259439154517,
                                                          0.0150259439154517);

model1_attrsv4_tree_169_c845 := map(
    NULL < searchcount AND searchcount < 19.5 => 0.000485015566455612,
    searchcount >= 19.5                       => -0.0349825350380864,
    searchcount = NULL                        => -0.00223572920949987,
                                                 -0.00223572920949987);

model1_attrsv4_tree_169_c844 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 59.5 => -0.0390976791541148,
    sourcecreditbureauageoldest >= 59.5                                       => model1_attrsv4_tree_169_c845,
    sourcecreditbureauageoldest = NULL                                        => -0.00410875652465317,
                                                                                 -0.00410875652465317);

model1_attrsv4_tree_169 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 11.5 => model1_attrsv4_tree_169_c842,
    prevaddrageoldest >= 11.5                             => model1_attrsv4_tree_169_c844,
    prevaddrageoldest = NULL                              => -0.00220431228273707,
                                                             -0.00220431228273707);

model1_attrsv4_tree_170_c849 := map(
    NULL < searchcount AND searchcount < 3.5 => 0.0276241368980414,
    searchcount >= 3.5                       => -0.0274394807331386,
    searchcount = NULL                       => -0.000536252027493595,
                                                -0.000536252027493595);

model1_attrsv4_tree_170_c848 := map(
    NULL < searchbankingsearchcountyear AND searchbankingsearchcountyear < 0.5 => model1_attrsv4_tree_170_c849,
    searchbankingsearchcountyear >= 0.5                                        => 0.0474676031814748,
    searchbankingsearchcountyear = NULL                                        => 0.015318232261707,
                                                                                  0.015318232261707);

model1_attrsv4_tree_170_c847 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 2.5 => model1_attrsv4_tree_170_c848,
    sourcecreditbureauagechange >= 2.5                                       => -0.00335507259452011,
    sourcecreditbureauagechange = NULL                                       => -0.00182355248215837,
                                                                                -0.00182355248215837);

model1_attrsv4_tree_170_c850 := map(
    NULL < beta_srch_primrangesperid_1subs AND beta_srch_primrangesperid_1subs < -1 => 0.00140314534755999,
    beta_srch_primrangesperid_1subs >= -1                                           => -0.0319095870315467,
    beta_srch_primrangesperid_1subs = NULL                                          => -0.0136073348548834,
                                                                                       -0.0136073348548834);

model1_attrsv4_tree_170 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 0.5 => model1_attrsv4_tree_170_c847,
    beta_rel_count_for_bureau_only >= 0.5                                          => model1_attrsv4_tree_170_c850,
    beta_rel_count_for_bureau_only = NULL                                          => -0.00252668855298371,
                                                                                      -0.00252668855298371);

model1_attrsv4_tree_171_c854 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => 0.0201549820105493,
    divaddrphonecount >= 7.5                             => 0.0890485332653448,
    divaddrphonecount = NULL                             => 0.0376164811765113,
                                                            0.0376164811765113);

model1_attrsv4_tree_171_c853 := map(
    NULL < componentcharrisklevel AND componentcharrisklevel < 4.5 => model1_attrsv4_tree_171_c854,
    componentcharrisklevel >= 4.5                                  => -0.0105821149391881,
    componentcharrisklevel = NULL                                  => 0.0217989852376131,
                                                                      0.0217989852376131);

model1_attrsv4_tree_171_c852 := map(
    NULL < businessactivity12month AND businessactivity12month < 0.5 => model1_attrsv4_tree_171_c853,
    businessactivity12month >= 0.5                                   => -0.000914303141119403,
    businessactivity12month = NULL                                   => 0.00340503282963749,
                                                                        0.00340503282963749);

model1_attrsv4_tree_171_c855 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 2.5 => -0.00099880118917558,
    beta_srch_perbestssn >= 2.5                                => -0.0409111579384792,
    beta_srch_perbestssn = NULL                                => -0.013545390202895,
                                                                  -0.013545390202895);

model1_attrsv4_tree_171 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 15.5 => model1_attrsv4_tree_171_c852,
    divssnaddrcount >= 15.5                           => model1_attrsv4_tree_171_c855,
    divssnaddrcount = NULL                            => 0.0000349369295372851,
                                                         0.0000349369295372851);

model1_attrsv4_tree_172_c858 := map(
    NULL < associatecount AND associatecount < 1.5 => 0.00434857581315929,
    associatecount >= 1.5                          => -0.038792412391833,
    associatecount = NULL                          => -0.00349524022411203,
                                                      -0.00349524022411203);

model1_attrsv4_tree_172_c857 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_172_c858,
    friendlyfraudindex >= 6.5                              => -0.0227037233657813,
    friendlyfraudindex = NULL                              => -0.00410902622287674,
                                                              -0.00410902622287674);

model1_attrsv4_tree_172_c860 := map(
    NULL < sbfetimenewest AND sbfetimenewest < 5.5 => 0.032702060606777,
    sbfetimenewest >= 5.5                          => -0.050773819508082,
    sbfetimenewest = NULL                          => -0.00350767546953601,
                                                      -0.00350767546953601);

model1_attrsv4_tree_172_c859 := map(
    NULL < divaddrssncountnew AND divaddrssncountnew < 0.5 => model1_attrsv4_tree_172_c860,
    divaddrssncountnew >= 0.5                              => 0.05647432507968,
    divaddrssncountnew = NULL                              => 0.0135488175776344,
                                                              0.0135488175776344);

model1_attrsv4_tree_172 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => model1_attrsv4_tree_172_c857,
    inquiry03month >= 0.5                          => model1_attrsv4_tree_172_c859,
    inquiry03month = NULL                          => -0.00235157101442963,
                                                      -0.00235157101442963);

model1_attrsv4_tree_173_c865 := map(
    NULL < busfeinpersonaddroverlap AND busfeinpersonaddroverlap < 1.5 => -0.000701687491301982,
    busfeinpersonaddroverlap >= 1.5                                    => 0.050993582287006,
    busfeinpersonaddroverlap = NULL                                    => 0.00701097214219522,
                                                                          0.00701097214219522);

model1_attrsv4_tree_173_c864 := map(
    NULL < searchbankingsearchcount AND searchbankingsearchcount < 7.5 => model1_attrsv4_tree_173_c865,
    searchbankingsearchcount >= 7.5                                    => -0.0485729582938507,
    searchbankingsearchcount = NULL                                    => 0.00377178087942405,
                                                                          0.00377178087942405);

model1_attrsv4_tree_173_c863 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => model1_attrsv4_tree_173_c864,
    suspiciousactivityindex >= 5.5                                   => 0.0300177073475726,
    suspiciousactivityindex = NULL                                   => 0.00469493670128191,
                                                                        0.00469493670128191);

model1_attrsv4_tree_173_c862 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 6.5 => -0.030286940763547,
    prevaddrageoldest >= 6.5                             => model1_attrsv4_tree_173_c863,
    prevaddrageoldest = NULL                             => 0.00262475313150339,
                                                            0.00262475313150339);

model1_attrsv4_tree_173 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 80.5 => model1_attrsv4_tree_173_c862,
    divaddrphonecount >= 80.5                             => 0.0441847317411509,
    divaddrphonecount = NULL                              => 0.00360494130625922,
                                                             0.00360494130625922);

model1_attrsv4_tree_174_c870 := map(
    NULL < divaddrsuspidentitycountnew AND divaddrsuspidentitycountnew < 0.5 => 0.0706861706045983,
    divaddrsuspidentitycountnew >= 0.5                                       => -0.0269860209242876,
    divaddrsuspidentitycountnew = NULL                                       => 0.0360389405014462,
                                                                                0.0360389405014462);

model1_attrsv4_tree_174_c869 := map(
    NULL < beta_sum_src_credentialed AND beta_sum_src_credentialed < 1.5 => model1_attrsv4_tree_174_c870,
    beta_sum_src_credentialed >= 1.5                                     => 0.00146048258956331,
    beta_sum_src_credentialed = NULL                                     => 0.0121110794073753,
                                                                            0.0121110794073753);

model1_attrsv4_tree_174_c868 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 8.5 => -0.00957653910302948,
    divaddrphonecount >= 8.5                             => model1_attrsv4_tree_174_c869,
    divaddrphonecount = NULL                             => -0.00415604459366693,
                                                            -0.00415604459366693);

model1_attrsv4_tree_174_c867 := map(
    NULL < identityageoldest AND identityageoldest < 79.5 => -0.028906662683168,
    identityageoldest >= 79.5                             => model1_attrsv4_tree_174_c868,
    identityageoldest = NULL                              => -0.00591967559279804,
                                                             -0.00591967559279804);

model1_attrsv4_tree_174 := map(
    NULL < identityageoldest AND identityageoldest < 20.5 => 0.0427655738792906,
    identityageoldest >= 20.5                             => model1_attrsv4_tree_174_c867,
    identityageoldest = NULL                              => -0.0047714385769469,
                                                             -0.0047714385769469);

model1_attrsv4_tree_175_c875 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => -0.010613538160194,
    divaddrphonecount >= 7.5                             => 0.0132779272923304,
    divaddrphonecount = NULL                             => -0.00324052586639278,
                                                            -0.00324052586639278);

model1_attrsv4_tree_175_c874 := map(
    NULL < variationphonecountnew AND variationphonecountnew < 0.5 => model1_attrsv4_tree_175_c875,
    variationphonecountnew >= 0.5                                  => 0.0482185351767436,
    variationphonecountnew = NULL                                  => -0.00131288178868677,
                                                                      -0.00131288178868677);

model1_attrsv4_tree_175_c873 := map(
    NULL < variationsearchaddrcount AND variationsearchaddrcount < 1.5 => model1_attrsv4_tree_175_c874,
    variationsearchaddrcount >= 1.5                                    => -0.0197636831235093,
    variationsearchaddrcount = NULL                                    => -0.00408050198891015,
                                                                          -0.00408050198891015);

model1_attrsv4_tree_175_c872 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => model1_attrsv4_tree_175_c873,
    suspiciousactivityindex >= 5.5                                   => -0.0296860765045638,
    suspiciousactivityindex = NULL                                   => -0.00479864672871088,
                                                                        -0.00479864672871088);

model1_attrsv4_tree_175 := map(
    NULL < searchvelocityrisklevel AND searchvelocityrisklevel < 6.5 => model1_attrsv4_tree_175_c872,
    searchvelocityrisklevel >= 6.5                                   => 0.0267669211776309,
    searchvelocityrisklevel = NULL                                   => -0.00402439694987608,
                                                                        -0.00402439694987608);

model1_attrsv4_tree_176_c880 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 164.5 => 0.0851579669547258,
    beta_m_src_credentialed_fs >= 164.5                                      => -0.00186779492102994,
    beta_m_src_credentialed_fs = NULL                                        => 0.024703095959803,
                                                                                0.024703095959803);

model1_attrsv4_tree_176_c879 := map(
    NULL < sourceaccidents AND sourceaccidents < 0.5 => -0.0170562973494447,
    sourceaccidents >= 0.5                           => model1_attrsv4_tree_176_c880,
    sourceaccidents = NULL                           => 0.000797718712113904,
                                                        0.000797718712113904);

model1_attrsv4_tree_176_c878 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => 0.0399623437563205,
    businessactivity06month >= 0.5                                   => model1_attrsv4_tree_176_c879,
    businessactivity06month = NULL                                   => 0.00774316945886975,
                                                                        0.00774316945886975);

model1_attrsv4_tree_176_c877 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 3.5 => -0.00537245810503677,
    friendlyfraudindex >= 3.5                              => model1_attrsv4_tree_176_c878,
    friendlyfraudindex = NULL                              => -0.00214600100921391,
                                                              -0.00214600100921391);

model1_attrsv4_tree_176 := map(
    NULL < beta_srch_ssnsperaddr_count03 AND beta_srch_ssnsperaddr_count03 < 1.5 => model1_attrsv4_tree_176_c877,
    beta_srch_ssnsperaddr_count03 >= 1.5                                         => -0.0463086594820351,
    beta_srch_ssnsperaddr_count03 = NULL                                         => -0.00333339324173788,
                                                                                    -0.00333339324173788);

model1_attrsv4_tree_177_c885 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 20.5 => 0.0103273173089993,
    divaddrphonemsourcecount >= 20.5                                    => 0.0503581269042074,
    divaddrphonemsourcecount = NULL                                     => 0.0117180334461625,
                                                                           0.0117180334461625);

model1_attrsv4_tree_177_c884 := map(
    NULL < beta_cpnindex AND beta_cpnindex < 3.5 => model1_attrsv4_tree_177_c885,
    beta_cpnindex >= 3.5                         => -0.0288940766831752,
    beta_cpnindex = NULL                         => 0.00850779136567535,
                                                    0.00850779136567535);

model1_attrsv4_tree_177_c883 := map(
    NULL < associatecount AND associatecount < 1.5 => model1_attrsv4_tree_177_c884,
    associatecount >= 1.5                          => -0.0310166718082126,
    associatecount = NULL                          => 0.000714375433881272,
                                                      0.000714375433881272);

model1_attrsv4_tree_177_c882 := map(
    NULL < identityrisklevel AND identityrisklevel < 3.5 => model1_attrsv4_tree_177_c883,
    identityrisklevel >= 3.5                             => 0.0349448277645104,
    identityrisklevel = NULL                             => 0.00169406303727746,
                                                            0.00169406303727746);

model1_attrsv4_tree_177 := map(
    NULL < beta_hh_members_for_bureau_only AND beta_hh_members_for_bureau_only < 2.5 => model1_attrsv4_tree_177_c882,
    beta_hh_members_for_bureau_only >= 2.5                                           => -0.022582210207772,
    beta_hh_members_for_bureau_only = NULL                                           => 0.000823781543587007,
                                                                                        0.000823781543587007);

model1_attrsv4_tree_178_c890 := map(
    NULL < sbfeavgbalance84m AND sbfeavgbalance84m < 203.5 => -0.0043790961196167,
    sbfeavgbalance84m >= 203.5                             => 0.0481280880124503,
    sbfeavgbalance84m = NULL                               => 0.00167130741145667,
                                                              0.00167130741145667);

model1_attrsv4_tree_178_c889 := map(
    NULL < sourcecreditbureau AND sourcecreditbureau < 2.5 => 0.0609825427028303,
    sourcecreditbureau >= 2.5                              => model1_attrsv4_tree_178_c890,
    sourcecreditbureau = NULL                              => 0.0053953280450716,
                                                              0.0053953280450716);

model1_attrsv4_tree_178_c888 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 69.5 => model1_attrsv4_tree_178_c889,
    businessrecordtimeoldest >= 69.5                                    => -0.0315847941800846,
    businessrecordtimeoldest = NULL                                     => -0.00902465322096861,
                                                                           -0.00902465322096861);

model1_attrsv4_tree_178_c887 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 0.5 => model1_attrsv4_tree_178_c888,
    beta_srch_perphone_count01 >= 0.5                                      => 0.0249326882810582,
    beta_srch_perphone_count01 = NULL                                      => -0.00759591967440583,
                                                                              -0.00759591967440583);

model1_attrsv4_tree_178 := map(
    NULL < searchphonesearchcountmonth AND searchphonesearchcountmonth < 0.5 => model1_attrsv4_tree_178_c887,
    searchphonesearchcountmonth >= 0.5                                       => -0.0290809803031616,
    searchphonesearchcountmonth = NULL                                       => -0.00836613882902161,
                                                                                -0.00836613882902161);

model1_attrsv4_tree_179_c895 := map(
    NULL < curraddrlenofres AND curraddrlenofres < 16.5 => -0.0183681097717689,
    curraddrlenofres >= 16.5                            => 0.0280500694625018,
    curraddrlenofres = NULL                             => 0.0185515346377112,
                                                           0.0185515346377112);

model1_attrsv4_tree_179_c894 := map(
    NULL < inputphoneproblems AND inputphoneproblems < 0.5 => model1_attrsv4_tree_179_c895,
    inputphoneproblems >= 0.5                              => -0.00458568825416801,
    inputphoneproblems = NULL                              => 0.00230570742239834,
                                                              0.00230570742239834);

model1_attrsv4_tree_179_c893 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_179_c894,
    friendlyfraudindex >= 6.5                              => -0.0188392133042549,
    friendlyfraudindex = NULL                              => 0.00147649484488253,
                                                              0.00147649484488253);

model1_attrsv4_tree_179_c892 := map(
    NULL < sbfeopencount06m AND sbfeopencount06m < 0.5 => model1_attrsv4_tree_179_c893,
    sbfeopencount06m >= 0.5                            => 0.0378481364959837,
    sbfeopencount06m = NULL                            => 0.00277747334032304,
                                                          0.00277747334032304);

model1_attrsv4_tree_179 := map(
    NULL < sbfeavgutilcard12m AND sbfeavgutilcard12m < 19.5 => model1_attrsv4_tree_179_c892,
    sbfeavgutilcard12m >= 19.5                              => -0.0364073112999194,
    sbfeavgutilcard12m = NULL                               => -0.000235319063620132,
                                                               -0.000235319063620132);

model1_attrsv4_tree_180_c898 := map(
    NULL < searchssnsearchcountmonth AND searchssnsearchcountmonth < 0.5 => -0.00896822883973028,
    searchssnsearchcountmonth >= 0.5                                     => -0.0358728551447114,
    searchssnsearchcountmonth = NULL                                     => -0.0104578487517108,
                                                                            -0.0104578487517108);

model1_attrsv4_tree_180_c900 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 62 => 0.063269882932088,
    inputaddrageoldest >= 62                              => 0.00543535368017378,
    inputaddrageoldest = NULL                             => 0.0269899199327322,
                                                             0.0269899199327322);

model1_attrsv4_tree_180_c899 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 4.5 => -0.00125093610130528,
    beta_srch_perbestssn >= 4.5                                => model1_attrsv4_tree_180_c900,
    beta_srch_perbestssn = NULL                                => 0.00254344762959415,
                                                                  0.00254344762959415);

model1_attrsv4_tree_180_c897 := map(
    NULL < inputaddrsqfootage AND inputaddrsqfootage < 1203 => model1_attrsv4_tree_180_c898,
    inputaddrsqfootage >= 1203                              => model1_attrsv4_tree_180_c899,
    inputaddrsqfootage = NULL                               => -0.0040241846690091,
                                                               -0.0040241846690091);

model1_attrsv4_tree_180 := map(
    NULL < idverdob AND idverdob < 5.5 => 0.027350829949912,
    idverdob >= 5.5                    => model1_attrsv4_tree_180_c897,
    idverdob = NULL                    => -0.00281062278280554,
                                          -0.00281062278280554);

model1_attrsv4_tree_181_c905 := map(
    NULL < divssnidentitymsourcecount AND divssnidentitymsourcecount < 1.5 => 0.00980636947590707,
    divssnidentitymsourcecount >= 1.5                                      => -0.0257404089653782,
    divssnidentitymsourcecount = NULL                                      => -0.000878792908651365,
                                                                              -0.000878792908651365);

model1_attrsv4_tree_181_c904 := map(
    NULL < curraddrlenofres AND curraddrlenofres < 3.5 => -0.0360594876531352,
    curraddrlenofres >= 3.5                            => model1_attrsv4_tree_181_c905,
    curraddrlenofres = NULL                            => -0.00266523871915847,
                                                          -0.00266523871915847);

model1_attrsv4_tree_181_c903 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_181_c904,
    friendlyfraudindex >= 6.5                              => -0.0182956456158221,
    friendlyfraudindex = NULL                              => -0.00329400186404747,
                                                              -0.00329400186404747);

model1_attrsv4_tree_181_c902 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 3.5 => model1_attrsv4_tree_181_c903,
    beta_rel_count_for_bureau_only >= 3.5                                          => 0.0201546839029671,
    beta_rel_count_for_bureau_only = NULL                                          => -0.0023203540121299,
                                                                                      -0.0023203540121299);

model1_attrsv4_tree_181 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 20.5 => model1_attrsv4_tree_181_c902,
    divaddrphonemsourcecount >= 20.5                                    => 0.0287309034731822,
    divaddrphonemsourcecount = NULL                                     => -0.000899612513981188,
                                                                           -0.000899612513981188);

model1_attrsv4_tree_182_c910 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 14.5 => 0.0205040695956231,
    divaddrphonecount >= 14.5                             => 0.0650017742210212,
    divaddrphonecount = NULL                              => 0.0266768512987845,
                                                             0.0266768512987845);

model1_attrsv4_tree_182_c909 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 66 => -0.0306567534906639,
    beta_m_src_credentialed_fs >= 66                                      => model1_attrsv4_tree_182_c910,
    beta_m_src_credentialed_fs = NULL                                     => 0.0165424107302425,
                                                                             0.0165424107302425);

model1_attrsv4_tree_182_c908 := map(
    NULL < beta_bureau_only_index AND beta_bureau_only_index < 1.5 => model1_attrsv4_tree_182_c909,
    beta_bureau_only_index >= 1.5                                  => 0.0350908862152544,
    beta_bureau_only_index = NULL                                  => 0.0185760190062296,
                                                                      0.0185760190062296);

model1_attrsv4_tree_182_c907 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 25.5 => model1_attrsv4_tree_182_c908,
    divaddrssnmsourcecount >= 25.5                                  => -0.045788079378045,
    divaddrssnmsourcecount = NULL                                   => 0.0119405449459951,
                                                                       0.0119405449459951);

model1_attrsv4_tree_182 := map(
    NULL < divphoneaddrcount AND divphoneaddrcount < 0.5 => model1_attrsv4_tree_182_c907,
    divphoneaddrcount >= 0.5                             => -0.00510685184916983,
    divphoneaddrcount = NULL                             => -0.0000368595475889255,
                                                            -0.0000368595475889255);

model1_attrsv4_tree_183_c914 := map(
    NULL < correlationrisklevel AND correlationrisklevel < 4.5 => 0.0287294070926,
    correlationrisklevel >= 4.5                                => 0.0711837255877971,
    correlationrisklevel = NULL                                => 0.0495998073612473,
                                                                  0.0495998073612473);

model1_attrsv4_tree_183_c915 := map(
    NULL < divaddrssncount AND divaddrssncount < 21.5 => -0.0326194294864731,
    divaddrssncount >= 21.5                           => 0.0474990374839009,
    divaddrssncount = NULL                            => -0.0141710982761896,
                                                         -0.0141710982761896);

model1_attrsv4_tree_183_c913 := map(
    NULL < searchfraudsearchcount AND searchfraudsearchcount < 0.5 => model1_attrsv4_tree_183_c914,
    searchfraudsearchcount >= 0.5                                  => model1_attrsv4_tree_183_c915,
    searchfraudsearchcount = NULL                                  => 0.00376918014190729,
                                                                      0.00376918014190729);

model1_attrsv4_tree_183_c912 := map(
    NULL < beta_srch_corrnamessn AND beta_srch_corrnamessn < -2.5 => model1_attrsv4_tree_183_c913,
    beta_srch_corrnamessn >= -2.5                                 => -0.0102085071044968,
    beta_srch_corrnamessn = NULL                                  => -0.00732784366711361,
                                                                     -0.00732784366711361);

model1_attrsv4_tree_183 := map(
    NULL < sbfeavgbalanceloan24m AND sbfeavgbalanceloan24m < -48.5 => model1_attrsv4_tree_183_c912,
    sbfeavgbalanceloan24m >= -48.5                                 => 0.0594113988195499,
    sbfeavgbalanceloan24m = NULL                                   => -0.00520289137095806,
                                                                      -0.00520289137095806);

model1_attrsv4_tree_184_c918 := map(
    NULL < identityrecordcount AND identityrecordcount < 18.5 => 0.0292314174567244,
    identityrecordcount >= 18.5                               => -0.00495340466466122,
    identityrecordcount = NULL                                => 0.00127099936322114,
                                                                 0.00127099936322114);

model1_attrsv4_tree_184_c917 := map(
    NULL < beta_m_src_other_fs AND beta_m_src_other_fs < 108 => model1_attrsv4_tree_184_c918,
    beta_m_src_other_fs >= 108                               => 0.0579789108640927,
    beta_m_src_other_fs = NULL                               => 0.00874192873284662,
                                                                0.00874192873284662);

model1_attrsv4_tree_184_c920 := map(
    NULL < busfeinpersonaddroverlap AND busfeinpersonaddroverlap < 1.5 => -0.0116774645915459,
    busfeinpersonaddroverlap >= 1.5                                    => 0.0325209759487062,
    busfeinpersonaddroverlap = NULL                                    => -0.00407829033508991,
                                                                          -0.00407829033508991);

model1_attrsv4_tree_184_c919 := map(
    NULL < beta_srch_corrnamephonessn AND beta_srch_corrnamephonessn < 1.5 => model1_attrsv4_tree_184_c920,
    beta_srch_corrnamephonessn >= 1.5                                      => -0.0390342544934844,
    beta_srch_corrnamephonessn = NULL                                      => -0.00626113445186447,
                                                                              -0.00626113445186447);

model1_attrsv4_tree_184 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => model1_attrsv4_tree_184_c917,
    businessactivity06month >= 0.5                                   => model1_attrsv4_tree_184_c919,
    businessactivity06month = NULL                                   => -0.00344098318813458,
                                                                        -0.00344098318813458);

model1_attrsv4_tree_185_c925 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 110.5 => -0.00576436269541108,
    beta_m_src_credentialed_fs >= 110.5                                      => 0.0290169759522765,
    beta_m_src_credentialed_fs = NULL                                        => 0.0167071548277335,
                                                                                0.0167071548277335);

model1_attrsv4_tree_185_c924 := map(
    NULL < identityrecordcount AND identityrecordcount < 146.5 => model1_attrsv4_tree_185_c925,
    identityrecordcount >= 146.5                               => -0.0326082099381711,
    identityrecordcount = NULL                                 => 0.0126801962406544,
                                                                  0.0126801962406544);

model1_attrsv4_tree_185_c923 := map(
    NULL < inputaddrlotsize AND inputaddrlotsize < 8263 => model1_attrsv4_tree_185_c924,
    inputaddrlotsize >= 8263                            => -0.0206180955479022,
    inputaddrlotsize = NULL                             => 0.000788564236517709,
                                                           0.000788564236517709);

model1_attrsv4_tree_185_c922 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 28.5 => model1_attrsv4_tree_185_c923,
    divaddrssnmsourcecount >= 28.5                                  => -0.0264957698474785,
    divaddrssnmsourcecount = NULL                                   => -0.00101062011249943,
                                                                       -0.00101062011249943);

model1_attrsv4_tree_185 := map(
    NULL < sbfedelq91revcountever AND sbfedelq91revcountever < 0.5 => model1_attrsv4_tree_185_c922,
    sbfedelq91revcountever >= 0.5                                  => 0.0540392435127635,
    sbfedelq91revcountever = NULL                                  => 0.000287725727719033,
                                                                      0.000287725727719033);

model1_attrsv4_tree_186_c930 := map(
    NULL < searchlocatesearchcount AND searchlocatesearchcount < 2.5 => 0.00483125892347055,
    searchlocatesearchcount >= 2.5                                   => -0.0325134495844802,
    searchlocatesearchcount = NULL                                   => 0.00162131516072099,
                                                                        0.00162131516072099);

model1_attrsv4_tree_186_c929 := map(
    NULL < divaddrphonecountnew AND divaddrphonecountnew < 3.5 => model1_attrsv4_tree_186_c930,
    divaddrphonecountnew >= 3.5                                => -0.0346983905134761,
    divaddrphonecountnew = NULL                                => 0.00044909689834202,
                                                                  0.00044909689834202);

model1_attrsv4_tree_186_c928 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_186_c929,
    friendlyfraudindex >= 6.5                              => 0.0225350321835995,
    friendlyfraudindex = NULL                              => 0.00118846881253273,
                                                              0.00118846881253273);

model1_attrsv4_tree_186_c927 := map(
    NULL < addrchangedistance AND addrchangedistance < 3.5 => model1_attrsv4_tree_186_c928,
    addrchangedistance >= 3.5                              => -0.0295400963467238,
    addrchangedistance = NULL                              => 0.00012756585282285,
                                                              0.00012756585282285);

model1_attrsv4_tree_186 := map(
    NULL < variationphonecountnew AND variationphonecountnew < 0.5 => model1_attrsv4_tree_186_c927,
    variationphonecountnew >= 0.5                                  => 0.0422572080755271,
    variationphonecountnew = NULL                                  => 0.00167761872705442,
                                                                      0.00167761872705442);

model1_attrsv4_tree_187_c934 := map(
    NULL < variationmsourcesssnunrelcount AND variationmsourcesssnunrelcount < 0.5 => -0.0442433640764335,
    variationmsourcesssnunrelcount >= 0.5                                          => 0.000103380582088202,
    variationmsourcesssnunrelcount = NULL                                          => -0.0011619954874284,
                                                                                      -0.0011619954874284);

model1_attrsv4_tree_187_c933 := map(
    NULL < beta_srch_idsperphone_count01 AND beta_srch_idsperphone_count01 < 0.5 => model1_attrsv4_tree_187_c934,
    beta_srch_idsperphone_count01 >= 0.5                                         => -0.0303995854051455,
    beta_srch_idsperphone_count01 = NULL                                         => -0.00213284777077533,
                                                                                    -0.00213284777077533);

model1_attrsv4_tree_187_c935 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 219345 => -0.00179182337365237,
    inputaddrassessedtotal >= 219345                                  => 0.0970970735643266,
    inputaddrassessedtotal = NULL                                     => 0.0453421368491227,
                                                                         0.0453421368491227);

model1_attrsv4_tree_187_c932 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_187_c933,
    associatebankruptcount >= 0.5                                  => model1_attrsv4_tree_187_c935,
    associatebankruptcount = NULL                                  => 0.000327710889592354,
                                                                      0.000327710889592354);

model1_attrsv4_tree_187 := map(
    NULL < searchvelocityrisklevel AND searchvelocityrisklevel < 6.5 => model1_attrsv4_tree_187_c932,
    searchvelocityrisklevel >= 6.5                                   => 0.0365914611942904,
    searchvelocityrisklevel = NULL                                   => 0.00127706850370119,
                                                                        0.00127706850370119);

model1_attrsv4_tree_188_c938 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 142736.5 => 0.0527813618221569,
    inputaddrassessedtotal >= 142736.5                                  => 0.00833702429457764,
    inputaddrassessedtotal = NULL                                       => 0.030092060381651,
                                                                           0.030092060381651);

model1_attrsv4_tree_188_c937 := map(
    NULL < beta_srch_ssnsperaddr_count03 AND beta_srch_ssnsperaddr_count03 < 0.5 => 0.00363372538062643,
    beta_srch_ssnsperaddr_count03 >= 0.5                                         => model1_attrsv4_tree_188_c938,
    beta_srch_ssnsperaddr_count03 = NULL                                         => 0.00678150157045893,
                                                                                    0.00678150157045893);

model1_attrsv4_tree_188_c940 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 2.5 => 0.0349523315748966,
    sourcecreditbureauagechange >= 2.5                                       => -0.0142913185689176,
    sourcecreditbureauagechange = NULL                                       => -0.0100028325203572,
                                                                                -0.0100028325203572);

model1_attrsv4_tree_188_c939 := map(
    NULL < searchssnsearchcountmonth AND searchssnsearchcountmonth < 0.5 => model1_attrsv4_tree_188_c940,
    searchssnsearchcountmonth >= 0.5                                     => -0.0438178953705843,
    searchssnsearchcountmonth = NULL                                     => -0.0125606686415749,
                                                                            -0.0125606686415749);

model1_attrsv4_tree_188 := map(
    NULL < searchcount AND searchcount < 7.5 => model1_attrsv4_tree_188_c937,
    searchcount >= 7.5                       => model1_attrsv4_tree_188_c939,
    searchcount = NULL                       => 0.000207900797925733,
                                                0.000207900797925733);

model1_attrsv4_tree_189_c944 := map(
    NULL < inputaddrlotsize AND inputaddrlotsize < 9648 => 0.0870764569654013,
    inputaddrlotsize >= 9648                            => -0.00687829033035705,
    inputaddrlotsize = NULL                             => 0.0483470191488292,
                                                           0.0483470191488292);

model1_attrsv4_tree_189_c943 := map(
    NULL < sbfeprincipalaccountcount AND sbfeprincipalaccountcount < 0.5 => model1_attrsv4_tree_189_c944,
    sbfeprincipalaccountcount >= 0.5                                     => -0.0409064290475354,
    sbfeprincipalaccountcount = NULL                                     => 0.0224659379645175,
                                                                            0.0224659379645175);

model1_attrsv4_tree_189_c942 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => -0.00379210952286891,
    inquiry03month >= 0.5                          => model1_attrsv4_tree_189_c943,
    inquiry03month = NULL                          => -0.00137945525921214,
                                                      -0.00137945525921214);

model1_attrsv4_tree_189_c945 := map(
    NULL < busexeclinkauthrepssnonfile AND busexeclinkauthrepssnonfile < 1 => -0.0391924263576858,
    busexeclinkauthrepssnonfile >= 1                                       => 0.00400037248477961,
    busexeclinkauthrepssnonfile = NULL                                     => -0.0170175519519558,
                                                                              -0.0170175519519558);

model1_attrsv4_tree_189 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 1.5 => model1_attrsv4_tree_189_c942,
    beta_srch_perphone_count03 >= 1.5                                      => model1_attrsv4_tree_189_c945,
    beta_srch_perphone_count03 = NULL                                      => -0.00220561885807407,
                                                                              -0.00220561885807407);

model1_attrsv4_tree_190_c950 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 228 => 0.0752230296546348,
    beta_m_src_credentialed_fs >= 228                                      => -0.0179656382497235,
    beta_m_src_credentialed_fs = NULL                                      => 0.0431645349268534,
                                                                              0.0431645349268534);

model1_attrsv4_tree_190_c949 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 1.5 => -0.00200629730163966,
    searchphonesearchcount >= 1.5                                  => model1_attrsv4_tree_190_c950,
    searchphonesearchcount = NULL                                  => 0.0143685667440108,
                                                                      0.0143685667440108);

model1_attrsv4_tree_190_c948 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 2.5 => 0.0344394976119724,
    sourcecreditbureauagechange >= 2.5                                       => model1_attrsv4_tree_190_c949,
    sourcecreditbureauagechange = NULL                                       => 0.016268689932773,
                                                                                0.016268689932773);

model1_attrsv4_tree_190_c947 := map(
    NULL < sourceaccidents AND sourceaccidents < 0.5 => -0.00356431408556935,
    sourceaccidents >= 0.5                           => model1_attrsv4_tree_190_c948,
    sourceaccidents = NULL                           => 0.00337772413980034,
                                                        0.00337772413980034);

model1_attrsv4_tree_190 := map(
    NULL < divaddridentitycount AND divaddridentitycount < 56.5 => model1_attrsv4_tree_190_c947,
    divaddridentitycount >= 56.5                                => -0.0370732748863705,
    divaddridentitycount = NULL                                 => 0.00179402936660592,
                                                                   0.00179402936660592);

model1_attrsv4_tree_191_c955 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 1.5 => 0.0042150425138736,
    suspiciousactivityindex >= 1.5                                   => 0.0571373078164417,
    suspiciousactivityindex = NULL                                   => 0.00953079005093155,
                                                                        0.00953079005093155);

model1_attrsv4_tree_191_c954 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 9.5 => model1_attrsv4_tree_191_c955,
    businessrecordtimeoldest >= 9.5                                    => -0.0092822937043148,
    businessrecordtimeoldest = NULL                                    => -0.00364288010861745,
                                                                          -0.00364288010861745);

model1_attrsv4_tree_191_c953 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 2.5 => model1_attrsv4_tree_191_c954,
    beta_synthidindex >= 2.5                             => -0.0187088964300371,
    beta_synthidindex = NULL                             => -0.00435065385657648,
                                                            -0.00435065385657648);

model1_attrsv4_tree_191_c952 := map(
    NULL < divaddrsuspidentitycountnew AND divaddrsuspidentitycountnew < 2.5 => model1_attrsv4_tree_191_c953,
    divaddrsuspidentitycountnew >= 2.5                                       => 0.0326243655813035,
    divaddrsuspidentitycountnew = NULL                                       => -0.00341712613809535,
                                                                                -0.00341712613809535);

model1_attrsv4_tree_191 := map(
    NULL < idveraddresssourcecount AND idveraddresssourcecount < 1.5 => -0.036319195869525,
    idveraddresssourcecount >= 1.5                                   => model1_attrsv4_tree_191_c952,
    idveraddresssourcecount = NULL                                   => -0.0049691105593892,
                                                                        -0.0049691105593892);

model1_attrsv4_tree_192_c960 := map(
    NULL < sbfebalancecount12m AND sbfebalancecount12m < -49 => 0.0704002220565264,
    sbfebalancecount12m >= -49                               => -0.0218544398203926,
    sbfebalancecount12m = NULL                               => 0.0251350842197204,
                                                                0.0251350842197204);

model1_attrsv4_tree_192_c959 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => -0.00772042156625121,
    associatebankruptcount >= 0.5                                  => model1_attrsv4_tree_192_c960,
    associatebankruptcount = NULL                                  => -0.00584995648559201,
                                                                      -0.00584995648559201);

model1_attrsv4_tree_192_c958 := map(
    NULL < identityrecordcount AND identityrecordcount < 10.5 => 0.0280056871338368,
    identityrecordcount >= 10.5                               => model1_attrsv4_tree_192_c959,
    identityrecordcount = NULL                                => -0.00455081436665767,
                                                                 -0.00455081436665767);

model1_attrsv4_tree_192_c957 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 3.5 => model1_attrsv4_tree_192_c958,
    searchaddrsearchcountyear >= 3.5                                     => 0.0268054207262327,
    searchaddrsearchcountyear = NULL                                     => -0.00303185361118416,
                                                                            -0.00303185361118416);

model1_attrsv4_tree_192 := map(
    NULL < beta_srch_corrdobaddr AND beta_srch_corrdobaddr < 2.5 => model1_attrsv4_tree_192_c957,
    beta_srch_corrdobaddr >= 2.5                                 => -0.03601988148758,
    beta_srch_corrdobaddr = NULL                                 => -0.0040588393846946,
                                                                    -0.0040588393846946);

model1_attrsv4_tree_193_c963 := map(
    NULL < sbfetimeoldestcycle AND sbfetimeoldestcycle < 8.5 => 0.0157789149539668,
    sbfetimeoldestcycle >= 8.5                               => -0.0180128583379625,
    sbfetimeoldestcycle = NULL                               => 0.00436800742286019,
                                                                0.00436800742286019);

model1_attrsv4_tree_193_c962 := map(
    NULL < beta_cpnindex AND beta_cpnindex < 2.5 => model1_attrsv4_tree_193_c963,
    beta_cpnindex >= 2.5                         => -0.0159634537683598,
    beta_cpnindex = NULL                         => 0.000663680813319856,
                                                    0.000663680813319856);

model1_attrsv4_tree_193_c965 := map(
    NULL < variationsearchphonecount AND variationsearchphonecount < 0.5 => -0.0218674257363789,
    variationsearchphonecount >= 0.5                                     => -0.0559204668367267,
    variationsearchphonecount = NULL                                     => -0.0344198240981859,
                                                                            -0.0344198240981859);

model1_attrsv4_tree_193_c964 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 1.5 => model1_attrsv4_tree_193_c965,
    friendlyfraudindex >= 1.5                              => 0.0148793396461768,
    friendlyfraudindex = NULL                              => -0.0190602856451684,
                                                              -0.0190602856451684);

model1_attrsv4_tree_193 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 36.5 => model1_attrsv4_tree_193_c962,
    divaddrphonecount >= 36.5                             => model1_attrsv4_tree_193_c964,
    divaddrphonecount = NULL                              => -0.00118776698160428,
                                                             -0.00118776698160428);

model1_attrsv4_tree_194_c969 := map(
    NULL < identityrecordcount AND identityrecordcount < 137.5 => -0.000445993288495467,
    identityrecordcount >= 137.5                               => 0.0763244226840725,
    identityrecordcount = NULL                                 => 0.0022453833634164,
                                                                  0.0022453833634164);

model1_attrsv4_tree_194_c968 := map(
    NULL < identityrecordcount AND identityrecordcount < 149.5 => model1_attrsv4_tree_194_c969,
    identityrecordcount >= 149.5                               => -0.0451093147631034,
    identityrecordcount = NULL                                 => -0.00135085765203359,
                                                                  -0.00135085765203359);

model1_attrsv4_tree_194_c967 := map(
    NULL < searchcomponentrisklevel AND searchcomponentrisklevel < 1.5 => model1_attrsv4_tree_194_c968,
    searchcomponentrisklevel >= 1.5                                    => -0.0285825421657636,
    searchcomponentrisklevel = NULL                                    => -0.00256668121226101,
                                                                          -0.00256668121226101);

model1_attrsv4_tree_194_c970 := map(
    NULL < businessactivity06month AND businessactivity06month < 1.5 => 0.043666233731607,
    businessactivity06month >= 1.5                                   => -0.00894326314885696,
    businessactivity06month = NULL                                   => 0.0187738207780989,
                                                                        0.0187738207780989);

model1_attrsv4_tree_194 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 3.5 => model1_attrsv4_tree_194_c967,
    searchaddrsearchcountyear >= 3.5                                     => model1_attrsv4_tree_194_c970,
    searchaddrsearchcountyear = NULL                                     => -0.00106680630822156,
                                                                            -0.00106680630822156);

model1_attrsv4_tree_195_c974 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 302.5 => -0.0210522325176633,
    beta_m_src_credentialed_fs >= 302.5                                      => 0.0363452208626609,
    beta_m_src_credentialed_fs = NULL                                        => -0.0141317395672356,
                                                                                -0.0141317395672356);

model1_attrsv4_tree_195_c975 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 25.5 => 0.0351713714012713,
    inputaddrageoldest >= 25.5                              => -0.0194091634517141,
    inputaddrageoldest = NULL                               => 0.00931743383933086,
                                                               0.00931743383933086);

model1_attrsv4_tree_195_c973 := map(
    NULL < identityrisklevel AND identityrisklevel < 1.5 => model1_attrsv4_tree_195_c974,
    identityrisklevel >= 1.5                             => model1_attrsv4_tree_195_c975,
    identityrisklevel = NULL                             => -0.0114288014799266,
                                                            -0.0114288014799266);

model1_attrsv4_tree_195_c972 := map(
    NULL < beta_srch_nonbank_recency AND beta_srch_nonbank_recency < 4.5 => model1_attrsv4_tree_195_c973,
    beta_srch_nonbank_recency >= 4.5                                     => -0.0432450265601461,
    beta_srch_nonbank_recency = NULL                                     => -0.0144297824169803,
                                                                            -0.0144297824169803);

model1_attrsv4_tree_195 := map(
    NULL < curraddractivephonelist AND curraddractivephonelist < 0.5 => model1_attrsv4_tree_195_c972,
    curraddractivephonelist >= 0.5                                   => 0.00959050806810617,
    curraddractivephonelist = NULL                                   => -0.00278220759685347,
                                                                        -0.00278220759685347);

model1_attrsv4_tree_196_c980 := map(
    NULL < inputaddrlenofres AND inputaddrlenofres < 0.5 => 0.0252010361031873,
    inputaddrlenofres >= 0.5                             => -0.00388951293100019,
    inputaddrlenofres = NULL                             => -0.00254499175715119,
                                                            -0.00254499175715119);

model1_attrsv4_tree_196_c979 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_196_c980,
    friendlyfraudindex >= 6.5                              => -0.0235504643051631,
    friendlyfraudindex = NULL                              => -0.00325559637650207,
                                                              -0.00325559637650207);

model1_attrsv4_tree_196_c978 := map(
    NULL < identityageoldest AND identityageoldest < 39.5 => 0.0300263314387883,
    identityageoldest >= 39.5                             => model1_attrsv4_tree_196_c979,
    identityageoldest = NULL                              => -0.00186597231574954,
                                                             -0.00186597231574954);

model1_attrsv4_tree_196_c977 := map(
    NULL < beta_srch_corraddrssn AND beta_srch_corraddrssn < 2.5 => model1_attrsv4_tree_196_c978,
    beta_srch_corraddrssn >= 2.5                                 => 0.0438305691674915,
    beta_srch_corraddrssn = NULL                                 => -0.000408914628485764,
                                                                    -0.000408914628485764);

model1_attrsv4_tree_196 := map(
    NULL < searchunverifieddobcountyear AND searchunverifieddobcountyear < 0.5 => model1_attrsv4_tree_196_c977,
    searchunverifieddobcountyear >= 0.5                                        => -0.0294349871253138,
    searchunverifieddobcountyear = NULL                                        => -0.0021682779850152,
                                                                                  -0.0021682779850152);

model1_attrsv4_tree_197_c984 := map(
    NULL < inputaddractivephonelist AND inputaddractivephonelist < 0.5 => 0.0251715001464493,
    inputaddractivephonelist >= 0.5                                    => 0.0967305265770602,
    inputaddractivephonelist = NULL                                    => 0.055578370802268,
                                                                          0.055578370802268);

model1_attrsv4_tree_197_c985 := map(
    NULL < divaddrssncountnew AND divaddrssncountnew < 1.5 => 0.0136170176370312,
    divaddrssncountnew >= 1.5                              => 0.0570620593277352,
    divaddrssncountnew = NULL                              => 0.0187901868791437,
                                                              0.0187901868791437);

model1_attrsv4_tree_197_c983 := map(
    NULL < sourceproperty AND sourceproperty < 0.5 => model1_attrsv4_tree_197_c984,
    sourceproperty >= 0.5                          => model1_attrsv4_tree_197_c985,
    sourceproperty = NULL                          => 0.0282284668528633,
                                                      0.0282284668528633);

model1_attrsv4_tree_197_c982 := map(
    ((string)prevaddrstatus in ['-1', 'R'])    => -0.0191152805164739,
    ((string)prevaddrstatus in ['', 'O', 'U']) => model1_attrsv4_tree_197_c983,
    prevaddrstatus = ''              => 0.0219070005847984,
                                          0.0219070005847984);

model1_attrsv4_tree_197 := map(
    NULL < searchlocatesearchcount AND searchlocatesearchcount < 0.5 => -0.00821179222645144,
    searchlocatesearchcount >= 0.5                                   => model1_attrsv4_tree_197_c982,
    searchlocatesearchcount = NULL                                   => 0.00178992010332209,
                                                                        0.00178992010332209);

model1_attrsv4_tree_198_c988 := map(
    NULL < beta_srch_corraddrphone_id AND beta_srch_corraddrphone_id < -0.5 => 0.0150953802073283,
    beta_srch_corraddrphone_id >= -0.5                                      => -0.0234643998001185,
    beta_srch_corraddrphone_id = NULL                                       => 0.00478633876574872,
                                                                               0.00478633876574872);

model1_attrsv4_tree_198_c989 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 74.5 => 0.081643693868744,
    prevaddrageoldest >= 74.5                             => 0.010131050390639,
    prevaddrageoldest = NULL                              => 0.0486885586253776,
                                                             0.0486885586253776);

model1_attrsv4_tree_198_c987 := map(
    NULL < inputaddrsqfootage AND inputaddrsqfootage < 875 => model1_attrsv4_tree_198_c988,
    inputaddrsqfootage >= 875                              => model1_attrsv4_tree_198_c989,
    inputaddrsqfootage = NULL                              => 0.0205071006626785,
                                                              0.0205071006626785);

model1_attrsv4_tree_198_c990 := map(
    NULL < componentcharrisklevel AND componentcharrisklevel < 6.5 => 0.00259345346320662,
    componentcharrisklevel >= 6.5                                  => -0.0465669893018035,
    componentcharrisklevel = NULL                                  => 0.00115949448326962,
                                                                      0.00115949448326962);

model1_attrsv4_tree_198 := map(
    NULL < correlationaddrnamecount AND correlationaddrnamecount < 2.5 => model1_attrsv4_tree_198_c987,
    correlationaddrnamecount >= 2.5                                    => model1_attrsv4_tree_198_c990,
    correlationaddrnamecount = NULL                                    => 0.00392474197023231,
                                                                          0.00392474197023231);

model1_attrsv4_tree_199_c995 := map(
    NULL < divssnidentitycount AND divssnidentitycount < 1.5 => 0.00060404710874608,
    divssnidentitycount >= 1.5                               => 0.0467208728800774,
    divssnidentitycount = NULL                               => 0.0167539082738037,
                                                                0.0167539082738037);

model1_attrsv4_tree_199_c994 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 14.5 => model1_attrsv4_tree_199_c995,
    divssnaddrcount >= 14.5                           => -0.0345739306071352,
    divssnaddrcount = NULL                            => 0.00797850356190128,
                                                         0.00797850356190128);

model1_attrsv4_tree_199_c993 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 270.5 => model1_attrsv4_tree_199_c994,
    beta_m_src_credentialed_fs >= 270.5                                      => 0.0717364914206436,
    beta_m_src_credentialed_fs = NULL                                        => 0.0169099276586183,
                                                                                0.0169099276586183);

model1_attrsv4_tree_199_c992 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => model1_attrsv4_tree_199_c993,
    businessactivity06month >= 0.5                                   => -0.00134489427829626,
    businessactivity06month = NULL                                   => 0.00184428105887733,
                                                                        0.00184428105887733);

model1_attrsv4_tree_199 := map(
    NULL < variationaddrcountyear AND variationaddrcountyear < 1.5 => model1_attrsv4_tree_199_c992,
    variationaddrcountyear >= 1.5                                  => -0.0435356670408417,
    variationaddrcountyear = NULL                                  => 0.000634862630748023,
                                                                      0.000634862630748023);

model1_attrsv4_tree_200_c1000 := map(
    NULL < identityrecordcount AND identityrecordcount < 81.5 => 0.0282623872180662,
    identityrecordcount >= 81.5                               => -0.0104427569791139,
    identityrecordcount = NULL                                => 0.00651293692377925,
                                                                 0.00651293692377925);

model1_attrsv4_tree_200_c999 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 2.5 => -0.0162416610667325,
    variationlastnamecount >= 2.5                                  => model1_attrsv4_tree_200_c1000,
    variationlastnamecount = NULL                                  => -0.00308033880106107,
                                                                      -0.00308033880106107);

model1_attrsv4_tree_200_c998 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 1.5 => model1_attrsv4_tree_200_c999,
    vulnerablevictimindex >= 1.5                                 => 0.0389971049363519,
    vulnerablevictimindex = NULL                                 => -0.00103062990623,
                                                                    -0.00103062990623);

model1_attrsv4_tree_200_c997 := map(
    NULL < inquirycredit12month AND inquirycredit12month < 0.5 => model1_attrsv4_tree_200_c998,
    inquirycredit12month >= 0.5                                => 0.0435195007802391,
    inquirycredit12month = NULL                                => 0.000884810495265532,
                                                                  0.000884810495265532);

model1_attrsv4_tree_200 := map(
    NULL < searchfraudsearchcount AND searchfraudsearchcount < 12.5 => model1_attrsv4_tree_200_c997,
    searchfraudsearchcount >= 12.5                                  => -0.0403575948645231,
    searchfraudsearchcount = NULL                                   => -0.000087887744352124,
                                                                       -0.000087887744352124);

model1_attrsv4_tree_201_c1004 := map(
    NULL < searchlocatesearchcountyear AND searchlocatesearchcountyear < 0.5 => -0.00134438461348677,
    searchlocatesearchcountyear >= 0.5                                       => 0.0577734658495946,
    searchlocatesearchcountyear = NULL                                       => 0.00251994580681577,
                                                                                0.00251994580681577);

model1_attrsv4_tree_201_c1005 := map(
    NULL < idveraddresssourcecount AND idveraddresssourcecount < 8.5 => -0.0184583709441228,
    idveraddresssourcecount >= 8.5                                   => 0.0364112706953765,
    idveraddresssourcecount = NULL                                   => -0.0134328417348431,
                                                                        -0.0134328417348431);

model1_attrsv4_tree_201_c1003 := map(
    NULL < correlationrisklevel AND correlationrisklevel < 5.5 => model1_attrsv4_tree_201_c1004,
    correlationrisklevel >= 5.5                                => model1_attrsv4_tree_201_c1005,
    correlationrisklevel = NULL                                => -0.00230607379961555,
                                                                  -0.00230607379961555);

model1_attrsv4_tree_201_c1002 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 5.5 => 0.0269901972534325,
    prevaddrageoldest >= 5.5                             => model1_attrsv4_tree_201_c1003,
    prevaddrageoldest = NULL                             => -0.00121208113662588,
                                                            -0.00121208113662588);

model1_attrsv4_tree_201 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 2.5 => -0.0366019629769556,
    curraddrageoldest >= 2.5                             => model1_attrsv4_tree_201_c1002,
    curraddrageoldest = NULL                             => -0.00218029488508773,
                                                            -0.00218029488508773);

model1_attrsv4_tree_202_c1009 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => -0.00702730297082923,
    friendlyfraudindex >= 6.5                              => -0.0192363812767319,
    friendlyfraudindex = NULL                              => -0.00747022439372407,
                                                              -0.00747022439372407);

model1_attrsv4_tree_202_c1008 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_202_c1009,
    associatejudgmentcount >= 0.5                                  => 0.0354063257284808,
    associatejudgmentcount = NULL                                  => -0.00615802930273578,
                                                                      -0.00615802930273578);

model1_attrsv4_tree_202_c1007 := map(
    NULL < beta_sum_src_credentialed AND beta_sum_src_credentialed < 6.5 => model1_attrsv4_tree_202_c1008,
    beta_sum_src_credentialed >= 6.5                                     => 0.0715514723335494,
    beta_sum_src_credentialed = NULL                                     => -0.0034596428763916,
                                                                            -0.0034596428763916);

model1_attrsv4_tree_202_c1010 := map(
    NULL < inputphoneproblems AND inputphoneproblems < 0.5 => -0.0447660575957449,
    inputphoneproblems >= 0.5                              => -0.0107611704574854,
    inputphoneproblems = NULL                              => -0.022363887853742,
                                                              -0.022363887853742);

model1_attrsv4_tree_202 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 25.5 => model1_attrsv4_tree_202_c1007,
    divaddrssnmsourcecount >= 25.5                                  => model1_attrsv4_tree_202_c1010,
    divaddrssnmsourcecount = NULL                                   => -0.0051583497953469,
                                                                       -0.0051583497953469);

model1_attrsv4_tree_203_c1012 := map(
    NULL < assoccount AND assoccount < 9.5 => -0.00615728531936789,
    assoccount >= 9.5                      => 0.0494561104940936,
    assoccount = NULL                      => 0.0166277178171446,
                                              0.0166277178171446);

model1_attrsv4_tree_203_c1015 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 2.5 => 0.0135788249627192,
    searchaddrsearchcountyear >= 2.5                                     => -0.0267015550230544,
    searchaddrsearchcountyear = NULL                                     => 0.00892613518818338,
                                                                            0.00892613518818338);

model1_attrsv4_tree_203_c1014 := map(
    NULL < identityrecordcount AND identityrecordcount < 96.5 => model1_attrsv4_tree_203_c1015,
    identityrecordcount >= 96.5                               => -0.0228643683992985,
    identityrecordcount = NULL                                => -0.00145967518727492,
                                                                 -0.00145967518727492);

model1_attrsv4_tree_203_c1013 := map(
    NULL < beta_hh_members_for_bureau_only AND beta_hh_members_for_bureau_only < 2.5 => model1_attrsv4_tree_203_c1014,
    beta_hh_members_for_bureau_only >= 2.5                                           => -0.0246238691932155,
    beta_hh_members_for_bureau_only = NULL                                           => -0.00237570560415496,
                                                                                        -0.00237570560415496);

model1_attrsv4_tree_203 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 2.5 => model1_attrsv4_tree_203_c1012,
    sourcecreditbureauagechange >= 2.5                                       => model1_attrsv4_tree_203_c1013,
    sourcecreditbureauagechange = NULL                                       => -0.00071290605479125,
                                                                                -0.00071290605479125);

model1_attrsv4_tree_204_c1020 := map(
    NULL < searchfraudsearchcountyear AND searchfraudsearchcountyear < 0.5 => 0.0573166301841693,
    searchfraudsearchcountyear >= 0.5                                      => -0.00849201959584648,
    searchfraudsearchcountyear = NULL                                      => 0.00778014107185982,
                                                                              0.00778014107185982);

model1_attrsv4_tree_204_c1019 := map(
    NULL < beta_addr_bureau_only AND beta_addr_bureau_only < 0.5 => model1_attrsv4_tree_204_c1020,
    beta_addr_bureau_only >= 0.5                                 => 0.0319256096383792,
    beta_addr_bureau_only = NULL                                 => 0.0116788589321418,
                                                                    0.0116788589321418);

model1_attrsv4_tree_204_c1018 := map(
    NULL < beta_srch_corrnamephone AND beta_srch_corrnamephone < -1.5 => -0.00334098905520139,
    beta_srch_corrnamephone >= -1.5                                   => model1_attrsv4_tree_204_c1019,
    beta_srch_corrnamephone = NULL                                    => 0.000774555013728757,
                                                                         0.000774555013728757);

model1_attrsv4_tree_204_c1017 := map(
    NULL < searchunverifiedaddrcountyear AND searchunverifiedaddrcountyear < 0.5 => model1_attrsv4_tree_204_c1018,
    searchunverifiedaddrcountyear >= 0.5                                         => -0.0413786690523434,
    searchunverifiedaddrcountyear = NULL                                         => -0.000638745501606024,
                                                                                    -0.000638745501606024);

model1_attrsv4_tree_204 := map(
    NULL < variationlastnamecountnew AND variationlastnamecountnew < 0.5 => model1_attrsv4_tree_204_c1017,
    variationlastnamecountnew >= 0.5                                     => -0.0587205034997061,
    variationlastnamecountnew = NULL                                     => -0.00233736295249386,
                                                                            -0.00233736295249386);

model1_attrsv4_tree_205_c1025 := map(
    NULL < beta_sum_src_other AND beta_sum_src_other < 0.5 => 0.0112946005966416,
    beta_sum_src_other >= 0.5                              => 0.0926819986025983,
    beta_sum_src_other = NULL                              => 0.0340783743529989,
                                                              0.0340783743529989);

model1_attrsv4_tree_205_c1024 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 169.5 => model1_attrsv4_tree_205_c1025,
    sourcecreditbureauageoldest >= 169.5                                       => -0.000603235415356828,
    sourcecreditbureauageoldest = NULL                                         => 0.018732529322753,
                                                                                  0.018732529322753);

model1_attrsv4_tree_205_c1023 := map(
    NULL < sourceproperty AND sourceproperty < 0.5 => model1_attrsv4_tree_205_c1024,
    sourceproperty >= 0.5                          => -0.00488214287558708,
    sourceproperty = NULL                          => 0.0026250278514044,
                                                      0.0026250278514044);

model1_attrsv4_tree_205_c1022 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 3.5 => model1_attrsv4_tree_205_c1023,
    beta_srch_perphone_count06 >= 3.5                                      => 0.028362377082058,
    beta_srch_perphone_count06 = NULL                                      => 0.00340378693030811,
                                                                              0.00340378693030811);

model1_attrsv4_tree_205 := map(
    NULL < divaddrssncountnew AND divaddrssncountnew < 2.5 => model1_attrsv4_tree_205_c1022,
    divaddrssncountnew >= 2.5                              => -0.0272152252435271,
    divaddrssncountnew = NULL                              => 0.0019017221821577,
                                                              0.0019017221821577);

model1_attrsv4_tree_206_c1030 := map(
    NULL < beta_srch_addrsperid_count06 AND beta_srch_addrsperid_count06 < 1.5 => 0.0101664769365682,
    beta_srch_addrsperid_count06 >= 1.5                                        => -0.0298202781012193,
    beta_srch_addrsperid_count06 = NULL                                        => 0.00868019297519228,
                                                                                  0.00868019297519228);

model1_attrsv4_tree_206_c1029 := map(
    NULL < beta_srch_corrdobaddr AND beta_srch_corrdobaddr < -2.5 => -0.0351213628910123,
    beta_srch_corrdobaddr >= -2.5                                 => model1_attrsv4_tree_206_c1030,
    beta_srch_corrdobaddr = NULL                                  => 0.00314175085036779,
                                                                     0.00314175085036779);

model1_attrsv4_tree_206_c1028 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_206_c1029,
    associatebankruptcount >= 0.5                                  => 0.0620695144742273,
    associatebankruptcount = NULL                                  => 0.00516700410726257,
                                                                      0.00516700410726257);

model1_attrsv4_tree_206_c1027 := map(
    NULL < sbfeavgbalance06m AND sbfeavgbalance06m < 10444 => model1_attrsv4_tree_206_c1028,
    sbfeavgbalance06m >= 10444                             => 0.0742480485989465,
    sbfeavgbalance06m = NULL                               => 0.00728667379505532,
                                                              0.00728667379505532);

model1_attrsv4_tree_206 := map(
    NULL < sostimeincorporation AND sostimeincorporation < 31.5 => model1_attrsv4_tree_206_c1027,
    sostimeincorporation >= 31.5                                => -0.0266302555091017,
    sostimeincorporation = NULL                                 => 0.000743266207602392,
                                                                   0.000743266207602392);

model1_attrsv4_tree_207_c1034 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 68.5 => 0.000366343243644442,
    curraddrageoldest >= 68.5                             => 0.0548747001152076,
    curraddrageoldest = NULL                              => 0.00949282453205456,
                                                             0.00949282453205456);

model1_attrsv4_tree_207_c1033 := map(
    NULL < sbfehighbalance24m AND sbfehighbalance24m < 12469.5 => model1_attrsv4_tree_207_c1034,
    sbfehighbalance24m >= 12469.5                              => 0.0750759620160453,
    sbfehighbalance24m = NULL                                  => 0.0150139545667862,
                                                                  0.0150139545667862);

model1_attrsv4_tree_207_c1032 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 85.5 => model1_attrsv4_tree_207_c1033,
    curraddrageoldest >= 85.5                             => -0.00787358777988631,
    curraddrageoldest = NULL                              => 0.00199981894450186,
                                                             0.00199981894450186);

model1_attrsv4_tree_207_c1035 := map(
    NULL < searchcount AND searchcount < 2.5 => -0.00239862011377359,
    searchcount >= 2.5                       => -0.0332525491021816,
    searchcount = NULL                       => -0.0150607520103151,
                                                -0.0150607520103151);

model1_attrsv4_tree_207 := map(
    NULL < sourcerisklevel AND sourcerisklevel < 6.5 => model1_attrsv4_tree_207_c1032,
    sourcerisklevel >= 6.5                           => model1_attrsv4_tree_207_c1035,
    sourcerisklevel = NULL                           => 0.000450686912047961,
                                                        0.000450686912047961);

model1_attrsv4_tree_208_c1039 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 17.5 => 0.00294756674781061,
    divaddrphonemsourcecount >= 17.5                                    => -0.0281306169304466,
    divaddrphonemsourcecount = NULL                                     => 0.0010556248204551,
                                                                           0.0010556248204551);

model1_attrsv4_tree_208_c1038 := map(
    NULL < idverdob AND idverdob < 4.5 => 0.0401291270077421,
    idverdob >= 4.5                    => model1_attrsv4_tree_208_c1039,
    idverdob = NULL                    => 0.00240407676976024,
                                          0.00240407676976024);

model1_attrsv4_tree_208_c1037 := map(
    NULL < prevaddragenewest AND prevaddragenewest < 1.5 => model1_attrsv4_tree_208_c1038,
    prevaddragenewest >= 1.5                             => 0.0315738879098919,
    prevaddragenewest = NULL                             => 0.00325909347944219,
                                                            0.00325909347944219);

model1_attrsv4_tree_208_c1040 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 2.5 => -0.0182428930273807,
    beta_srch_perbestssn >= 2.5                                => -0.0591032589591066,
    beta_srch_perbestssn = NULL                                => -0.0313104086236844,
                                                                  -0.0313104086236844);

model1_attrsv4_tree_208 := map(
    NULL < sbfeavgutilcard36m AND sbfeavgutilcard36m < 17.5 => model1_attrsv4_tree_208_c1037,
    sbfeavgutilcard36m >= 17.5                              => model1_attrsv4_tree_208_c1040,
    sbfeavgutilcard36m = NULL                               => -0.000157090808579049,
                                                               -0.000157090808579049);

model1_attrsv4_tree_209_c1045 := map(
    NULL < beta_srch_corrdobphone AND beta_srch_corrdobphone < -1.5 => 0.00300869641984196,
    beta_srch_corrdobphone >= -1.5                                  => 0.046918555474981,
    beta_srch_corrdobphone = NULL                                   => 0.00532500940158488,
                                                                       0.00532500940158488);

model1_attrsv4_tree_209_c1044 := map(
    NULL < searchphonesearchcountyear AND searchphonesearchcountyear < 0.5 => model1_attrsv4_tree_209_c1045,
    searchphonesearchcountyear >= 0.5                                      => -0.0195029245229829,
    searchphonesearchcountyear = NULL                                      => 0.0000575129019395392,
                                                                              0.0000575129019395392);

model1_attrsv4_tree_209_c1043 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 10.5 => model1_attrsv4_tree_209_c1044,
    beta_srch_perbestssn >= 10.5                                => 0.0283516764995714,
    beta_srch_perbestssn = NULL                                 => 0.000772119184350347,
                                                                   0.000772119184350347);

model1_attrsv4_tree_209_c1042 := map(
    NULL < searchfraudsearchcount AND searchfraudsearchcount < 11.5 => model1_attrsv4_tree_209_c1043,
    searchfraudsearchcount >= 11.5                                  => -0.0447242640238166,
    searchfraudsearchcount = NULL                                   => -0.000478146210232063,
                                                                       -0.000478146210232063);

model1_attrsv4_tree_209 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 5.5 => model1_attrsv4_tree_209_c1042,
    searchaddrsearchcountyear >= 5.5                                     => 0.0312129666269655,
    searchaddrsearchcountyear = NULL                                     => 0.000478566630136164,
                                                                            0.000478566630136164);

model1_attrsv4_tree_210_c1049 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => 0.00299677942658434,
    inquiry03month >= 0.5                          => 0.038073421978166,
    inquiry03month = NULL                          => 0.00622626064600982,
                                                      0.00622626064600982);

model1_attrsv4_tree_210_c1050 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 12.5 => -0.0011622154128682,
    divaddrssnmsourcecount >= 12.5                                  => 0.0641371617778237,
    divaddrssnmsourcecount = NULL                                   => 0.0274654100946453,
                                                                       0.0274654100946453);

model1_attrsv4_tree_210_c1048 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 29.5 => model1_attrsv4_tree_210_c1049,
    divaddrphonecount >= 29.5                             => model1_attrsv4_tree_210_c1050,
    divaddrphonecount = NULL                              => 0.00859954212286139,
                                                             0.00859954212286139);

model1_attrsv4_tree_210_c1047 := map(
    NULL < divphoneaddrcount AND divphoneaddrcount < 1.5 => model1_attrsv4_tree_210_c1048,
    divphoneaddrcount >= 1.5                             => -0.0153421700411715,
    divphoneaddrcount = NULL                             => 0.000110150064697635,
                                                            0.000110150064697635);

model1_attrsv4_tree_210 := map(
    NULL < sbfebalancecountever AND sbfebalancecountever < 4.5 => model1_attrsv4_tree_210_c1047,
    sbfebalancecountever >= 4.5                                => -0.0506847682501902,
    sbfebalancecountever = NULL                                => -0.00483756249757799,
                                                                  -0.00483756249757799);

model1_attrsv4_tree_211_c1055 := map(
    NULL < divphoneidentitymsourcecount AND divphoneidentitymsourcecount < 0.5 => 0.0652470023328411,
    divphoneidentitymsourcecount >= 0.5                                        => -0.0420230990730689,
    divphoneidentitymsourcecount = NULL                                        => 0.0228444229812903,
                                                                                  0.0228444229812903);

model1_attrsv4_tree_211_c1054 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 12.5 => -0.00421610743367561,
    divaddrssnmsourcecount >= 12.5                                  => model1_attrsv4_tree_211_c1055,
    divaddrssnmsourcecount = NULL                                   => -0.000545254231077249,
                                                                       -0.000545254231077249);

model1_attrsv4_tree_211_c1053 := map(
    NULL < divaddridentitymsourcecount AND divaddridentitymsourcecount < 18.5 => model1_attrsv4_tree_211_c1054,
    divaddridentitymsourcecount >= 18.5                                       => -0.0149837217161808,
    divaddridentitymsourcecount = NULL                                        => -0.00480122123081852,
                                                                                 -0.00480122123081852);

model1_attrsv4_tree_211_c1052 := map(
    NULL < searchunverifiedaddrcountyear AND searchunverifiedaddrcountyear < 0.5 => model1_attrsv4_tree_211_c1053,
    searchunverifiedaddrcountyear >= 0.5                                         => -0.0398988219751353,
    searchunverifiedaddrcountyear = NULL                                         => -0.00604744038768194,
                                                                                    -0.00604744038768194);

model1_attrsv4_tree_211 := map(
    NULL < sbfedelq91cardcountever AND sbfedelq91cardcountever < 0.5 => model1_attrsv4_tree_211_c1052,
    sbfedelq91cardcountever >= 0.5                                   => 0.0671061083579446,
    sbfedelq91cardcountever = NULL                                   => -0.00432212084179452,
                                                                        -0.00432212084179452);

model1_attrsv4_tree_212_c1058 := map(
    NULL < identityrisklevel AND identityrisklevel < 3.5 => -0.0128164617897445,
    identityrisklevel >= 3.5                             => 0.0357171417341792,
    identityrisklevel = NULL                             => -0.00924099850148822,
                                                            -0.00924099850148822);

model1_attrsv4_tree_212_c1057 := map(
    ((string)prevaddrstatus in ['R'])                => -0.0286806238672921,
    ((string)prevaddrstatus in ['', '-1', 'O', 'U']) => model1_attrsv4_tree_212_c1058,
    prevaddrstatus = ''                    => -0.0123771394357884,
                                                -0.0123771394357884);

model1_attrsv4_tree_212_c1060 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 323.5 => 0.0430165489492075,
    sourcecreditbureauageoldest >= 323.5                                       => -0.02209372237059,
    sourcecreditbureauageoldest = NULL                                         => 0.0217825835936662,
                                                                                  0.0217825835936662);

model1_attrsv4_tree_212_c1059 := map(
    NULL < divaddrphonecountnew AND divaddrphonecountnew < 0.5 => -0.000702651592028893,
    divaddrphonecountnew >= 0.5                                => model1_attrsv4_tree_212_c1060,
    divaddrphonecountnew = NULL                                => 0.00472015191784381,
                                                                  0.00472015191784381);

model1_attrsv4_tree_212 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 2.5 => model1_attrsv4_tree_212_c1057,
    variationlastnamecount >= 2.5                                  => model1_attrsv4_tree_212_c1059,
    variationlastnamecount = NULL                                  => -0.00232844838549324,
                                                                      -0.00232844838549324);

model1_attrsv4_tree_213_c1065 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 39.5 => 0.0859540425244264,
    businessrecordtimeoldest >= 39.5                                    => -0.016587509974419,
    businessrecordtimeoldest = NULL                                     => 0.0301402861010042,
                                                                           0.0301402861010042);

model1_attrsv4_tree_213_c1064 := map(
    NULL < sourcecreditbureau AND sourcecreditbureau < 2.5 => model1_attrsv4_tree_213_c1065,
    sourcecreditbureau >= 2.5                              => 0.0035166903356283,
    sourcecreditbureau = NULL                              => 0.00518022637475145,
                                                              0.00518022637475145);

model1_attrsv4_tree_213_c1063 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 2.5 => model1_attrsv4_tree_213_c1064,
    beta_synthidindex >= 2.5                             => -0.0303743162247138,
    beta_synthidindex = NULL                             => 0.00385369902395921,
                                                            0.00385369902395921);

model1_attrsv4_tree_213_c1062 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.0238418333216363,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_213_c1063,
    sourcedriverslicense = NULL                                => 0.0046384075394252,
                                                                  0.0046384075394252);

model1_attrsv4_tree_213 := map(
    NULL < divaddrphonecountnew AND divaddrphonecountnew < 3.5 => model1_attrsv4_tree_213_c1062,
    divaddrphonecountnew >= 3.5                                => -0.0319293254256533,
    divaddrphonecountnew = NULL                                => 0.00343960685967381,
                                                                  0.00343960685967381);

model1_attrsv4_tree_214_c1069 := map(
    NULL < divssnaddrcountnew AND divssnaddrcountnew < 0.5 => 0.0147854558725171,
    divssnaddrcountnew >= 0.5                              => 0.0721024384240225,
    divssnaddrcountnew = NULL                              => 0.0188544705456962,
                                                              0.0188544705456962);

model1_attrsv4_tree_214_c1068 := map(
    NULL < curraddractivephonelist AND curraddractivephonelist < 0.5 => -0.00806050563662232,
    curraddractivephonelist >= 0.5                                   => model1_attrsv4_tree_214_c1069,
    curraddractivephonelist = NULL                                   => 0.00470925948588304,
                                                                        0.00470925948588304);

model1_attrsv4_tree_214_c1070 := map(
    NULL < sbfelastpaymentcardamt AND sbfelastpaymentcardamt < 1034.5 => 0.081434420184019,
    sbfelastpaymentcardamt >= 1034.5                                  => -0.0331989278881688,
    sbfelastpaymentcardamt = NULL                                     => 0.035668254603868,
                                                                         0.035668254603868);

model1_attrsv4_tree_214_c1067 := map(
    NULL < sbfeavgbalancecardever AND sbfeavgbalancecardever < 1723.5 => model1_attrsv4_tree_214_c1068,
    sbfeavgbalancecardever >= 1723.5                                  => model1_attrsv4_tree_214_c1070,
    sbfeavgbalancecardever = NULL                                     => 0.00690570289457742,
                                                                         0.00690570289457742);

model1_attrsv4_tree_214 := map(
    NULL < sbfebalanceamt60m AND sbfebalanceamt60m < 2.5 => model1_attrsv4_tree_214_c1067,
    sbfebalanceamt60m >= 2.5                             => -0.049492743853522,
    sbfebalanceamt60m = NULL                             => -0.000184007510313378,
                                                            -0.000184007510313378);

model1_attrsv4_tree_215_c1074 := map(
    NULL < busfeinpersonoverlap AND busfeinpersonoverlap < 0.5 => 0.00688944560313463,
    busfeinpersonoverlap >= 0.5                                => 0.0720762029031076,
    busfeinpersonoverlap = NULL                                => 0.0368112358391878,
                                                                  0.0368112358391878);

model1_attrsv4_tree_215_c1075 := map(
    NULL < searchlocatesearchcount AND searchlocatesearchcount < 0.5 => -0.0283686302889883,
    searchlocatesearchcount >= 0.5                                   => 0.0472234262825819,
    searchlocatesearchcount = NULL                                   => -0.000479073523851402,
                                                                        -0.000479073523851402);

model1_attrsv4_tree_215_c1073 := map(
    NULL < beta_sum_src_credentialed AND beta_sum_src_credentialed < 1.5 => model1_attrsv4_tree_215_c1074,
    beta_sum_src_credentialed >= 1.5                                     => model1_attrsv4_tree_215_c1075,
    beta_sum_src_credentialed = NULL                                     => 0.0103143256274909,
                                                                            0.0103143256274909);

model1_attrsv4_tree_215_c1072 := map(
    NULL < beta_srch_corrdobaddr_id AND beta_srch_corrdobaddr_id < 0.5 => -0.0039594577989439,
    beta_srch_corrdobaddr_id >= 0.5                                    => model1_attrsv4_tree_215_c1073,
    beta_srch_corrdobaddr_id = NULL                                    => -0.00081691420310046,
                                                                          -0.00081691420310046);

model1_attrsv4_tree_215 := map(
    NULL < searchssnsearchcount AND searchssnsearchcount < 6.5 => model1_attrsv4_tree_215_c1072,
    searchssnsearchcount >= 6.5                                => -0.0237741862452096,
    searchssnsearchcount = NULL                                => -0.00304225354491812,
                                                                  -0.00304225354491812);

model1_attrsv4_tree_216_c1080 := map(
    NULL < searchssnsearchcount AND searchssnsearchcount < 1.5 => 0.0136448002842595,
    searchssnsearchcount >= 1.5                                => 0.0757881805927066,
    searchssnsearchcount = NULL                                => 0.0447164904384831,
                                                                  0.0447164904384831);

model1_attrsv4_tree_216_c1079 := map(
    NULL < inputaddrlenofres AND inputaddrlenofres < 5.5 => -0.00596767568086421,
    inputaddrlenofres >= 5.5                             => model1_attrsv4_tree_216_c1080,
    inputaddrlenofres = NULL                             => 0.0223275498491779,
                                                            0.0223275498491779);

model1_attrsv4_tree_216_c1078 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 11.5 => model1_attrsv4_tree_216_c1079,
    curraddrageoldest >= 11.5                             => -0.00302209267126495,
    curraddrageoldest = NULL                              => -0.000589318135492927,
                                                             -0.000589318135492927);

model1_attrsv4_tree_216_c1077 := map(
    NULL < searchbankingsearchcountmonth AND searchbankingsearchcountmonth < 0.5 => model1_attrsv4_tree_216_c1078,
    searchbankingsearchcountmonth >= 0.5                                         => 0.0266312476630234,
    searchbankingsearchcountmonth = NULL                                         => 0.000458935711211628,
                                                                                    0.000458935711211628);

model1_attrsv4_tree_216 := map(
    NULL < validationssnproblems AND validationssnproblems < 1.5 => model1_attrsv4_tree_216_c1077,
    validationssnproblems >= 1.5                                 => -0.0300980896164346,
    validationssnproblems = NULL                                 => -0.00127791407745883,
                                                                    -0.00127791407745883);

model1_attrsv4_tree_217_c1085 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 1.5 => -0.00367196428385394,
    beta_srch_perphone_count03 >= 1.5                                      => -0.0302298633595435,
    beta_srch_perphone_count03 = NULL                                      => -0.00454330533270384,
                                                                              -0.00454330533270384);

model1_attrsv4_tree_217_c1084 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_217_c1085,
    associatejudgmentcount >= 0.5                                  => 0.0369660611716242,
    associatejudgmentcount = NULL                                  => -0.00318252096002065,
                                                                      -0.00318252096002065);

model1_attrsv4_tree_217_c1083 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 3.5 => model1_attrsv4_tree_217_c1084,
    beta_srch_perphone_count06 >= 3.5                                      => 0.0167006613505942,
    beta_srch_perphone_count06 = NULL                                      => -0.00256117151281393,
                                                                              -0.00256117151281393);

model1_attrsv4_tree_217_c1082 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 1.5 => -0.0315145417876035,
    sourcedriverslicense >= 1.5                                => model1_attrsv4_tree_217_c1083,
    sourcedriverslicense = NULL                                => -0.00351442743832298,
                                                                  -0.00351442743832298);

model1_attrsv4_tree_217 := map(
    NULL < identityageoldest AND identityageoldest < 33.5 => 0.0244868009454971,
    identityageoldest >= 33.5                             => model1_attrsv4_tree_217_c1082,
    identityageoldest = NULL                              => -0.00239173667765094,
                                                             -0.00239173667765094);

model1_attrsv4_tree_218_c1088 := map(
    NULL < idverdobsourcecount AND idverdobsourcecount < 2.5 => 0.029584133483398,
    idverdobsourcecount >= 2.5                               => 0.00263831340013933,
    idverdobsourcecount = NULL                               => 0.0152442709695247,
                                                                0.0152442709695247);

model1_attrsv4_tree_218_c1090 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 5.5 => 0.0849271664481986,
    searchaddrsearchcount >= 5.5                                 => 0.0032754674296197,
    searchaddrsearchcount = NULL                                 => 0.0359361470370513,
                                                                    0.0359361470370513);

model1_attrsv4_tree_218_c1089 := map(
    NULL < beta_srch_corrnameaddrssn AND beta_srch_corrnameaddrssn < 1.5 => -0.00810434943606485,
    beta_srch_corrnameaddrssn >= 1.5                                     => model1_attrsv4_tree_218_c1090,
    beta_srch_corrnameaddrssn = NULL                                     => -0.00445421787183732,
                                                                            -0.00445421787183732);

model1_attrsv4_tree_218_c1087 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => model1_attrsv4_tree_218_c1088,
    inputaddroccupantowned >= -0.5                                  => model1_attrsv4_tree_218_c1089,
    inputaddroccupantowned = NULL                                   => -0.00154473133605947,
                                                                       -0.00154473133605947);

model1_attrsv4_tree_218 := map(
    NULL < divaddrphonecountnew AND divaddrphonecountnew < 1.5 => model1_attrsv4_tree_218_c1087,
    divaddrphonecountnew >= 1.5                                => -0.0235227859385694,
    divaddrphonecountnew = NULL                                => -0.00334340703112337,
                                                                  -0.00334340703112337);

model1_attrsv4_tree_219_c1095 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 3.5 => 0.00791517272969615,
    searchaddrsearchcount >= 3.5                                 => 0.046745192847539,
    searchaddrsearchcount = NULL                                 => 0.0161924183974495,
                                                                    0.0161924183974495);

model1_attrsv4_tree_219_c1094 := map(
    NULL < inputaddroccupantowned AND inputaddroccupantowned < -0.5 => model1_attrsv4_tree_219_c1095,
    inputaddroccupantowned >= -0.5                                  => -0.0102884321860779,
    inputaddroccupantowned = NULL                                   => -0.00590700514450882,
                                                                       -0.00590700514450882);

model1_attrsv4_tree_219_c1093 := map(
    NULL < beta_hh_members_for_bureau_only AND beta_hh_members_for_bureau_only < 2.5 => model1_attrsv4_tree_219_c1094,
    beta_hh_members_for_bureau_only >= 2.5                                           => -0.0230102069431257,
    beta_hh_members_for_bureau_only = NULL                                           => -0.00658431749469066,
                                                                                        -0.00658431749469066);

model1_attrsv4_tree_219_c1092 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 36.5 => model1_attrsv4_tree_219_c1093,
    divaddrssnmsourcecount >= 36.5                                  => 0.0455705449754236,
    divaddrssnmsourcecount = NULL                                   => -0.00521814598201243,
                                                                       -0.00521814598201243);

model1_attrsv4_tree_219 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 5.5 => model1_attrsv4_tree_219_c1092,
    searchaddrsearchcountyear >= 5.5                                     => 0.0281906429250906,
    searchaddrsearchcountyear = NULL                                     => -0.00429625251452869,
                                                                            -0.00429625251452869);

model1_attrsv4_tree_220_c1100 := map(
    NULL < sourceproperty AND sourceproperty < 0.5 => 0.0440120262368194,
    sourceproperty >= 0.5                          => -0.0148976895541054,
    sourceproperty = NULL                          => 0.00721929146213656,
                                                      0.00721929146213656);

model1_attrsv4_tree_220_c1099 := map(
    NULL < beta_srch_perphone_count01 AND beta_srch_perphone_count01 < 0.5 => -0.00536123942451785,
    beta_srch_perphone_count01 >= 0.5                                      => model1_attrsv4_tree_220_c1100,
    beta_srch_perphone_count01 = NULL                                      => -0.00443524476989582,
                                                                              -0.00443524476989582);

model1_attrsv4_tree_220_c1098 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 2.5 => -0.026329745006899,
    inputaddrageoldest >= 2.5                              => model1_attrsv4_tree_220_c1099,
    inputaddrageoldest = NULL                              => -0.0052360637633866,
                                                              -0.0052360637633866);

model1_attrsv4_tree_220_c1097 := map(
    NULL < prevaddragenewest AND prevaddragenewest < 3.5 => model1_attrsv4_tree_220_c1098,
    prevaddragenewest >= 3.5                             => 0.0338481385501424,
    prevaddragenewest = NULL                             => -0.0041672073109595,
                                                            -0.0041672073109595);

model1_attrsv4_tree_220 := map(
    NULL < idverdob AND idverdob < 3.5 => -0.0438498995931218,
    idverdob >= 3.5                    => model1_attrsv4_tree_220_c1097,
    idverdob = NULL                    => -0.00517799286909005,
                                          -0.00517799286909005);

model1_attrsv4_tree_221_c1104 := map(
    NULL < beta_hh_members_for_bureau_only AND beta_hh_members_for_bureau_only < 2.5 => -0.00425659198412274,
    beta_hh_members_for_bureau_only >= 2.5                                           => -0.0465082672106048,
    beta_hh_members_for_bureau_only = NULL                                           => -0.00605182877025965,
                                                                                        -0.00605182877025965);

model1_attrsv4_tree_221_c1105 := map(
    NULL < sbfehighbalance03m AND sbfehighbalance03m < 44 => 0.0256852490685957,
    sbfehighbalance03m >= 44                              => -0.036220687603829,
    sbfehighbalance03m = NULL                             => 0.0127355378258946,
                                                             0.0127355378258946);

model1_attrsv4_tree_221_c1103 := map(
    NULL < beta_srch_corrdobaddr_id AND beta_srch_corrdobaddr_id < 0.5 => model1_attrsv4_tree_221_c1104,
    beta_srch_corrdobaddr_id >= 0.5                                    => model1_attrsv4_tree_221_c1105,
    beta_srch_corrdobaddr_id = NULL                                    => -0.00141297282059194,
                                                                          -0.00141297282059194);

model1_attrsv4_tree_221_c1102 := map(
    NULL < componentcharrisklevel AND componentcharrisklevel < 6.5 => model1_attrsv4_tree_221_c1103,
    componentcharrisklevel >= 6.5                                  => -0.0345233083583333,
    componentcharrisklevel = NULL                                  => -0.00278057363628126,
                                                                      -0.00278057363628126);

model1_attrsv4_tree_221 := map(
    NULL < sbfehighbalanceloan24m AND sbfehighbalanceloan24m < 9617 => model1_attrsv4_tree_221_c1102,
    sbfehighbalanceloan24m >= 9617                                  => 0.0698786401411016,
    sbfehighbalanceloan24m = NULL                                   => -0.00106691293398449,
                                                                       -0.00106691293398449);

model1_attrsv4_tree_222_c1110 := map(
    NULL < correlationssnaddrcount AND correlationssnaddrcount < 3.5 => 0.0265552378091509,
    correlationssnaddrcount >= 3.5                                   => -0.00304207271176557,
    correlationssnaddrcount = NULL                                   => 0.00978518087101171,
                                                                        0.00978518087101171);

model1_attrsv4_tree_222_c1109 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => -0.0136569426035048,
    divaddrphonecount >= 7.5                             => model1_attrsv4_tree_222_c1110,
    divaddrphonecount = NULL                             => -0.00662929855869501,
                                                            -0.00662929855869501);

model1_attrsv4_tree_222_c1108 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 1.5 => model1_attrsv4_tree_222_c1109,
    vulnerablevictimindex >= 1.5                                 => 0.0495969446511369,
    vulnerablevictimindex = NULL                                 => -0.00385427516565091,
                                                                    -0.00385427516565091);

model1_attrsv4_tree_222_c1107 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 2.5 => model1_attrsv4_tree_222_c1108,
    beta_synthidindex >= 2.5                             => -0.0267226681612433,
    beta_synthidindex = NULL                             => -0.00487716024886769,
                                                            -0.00487716024886769);

model1_attrsv4_tree_222 := map(
    NULL < identityageoldest AND identityageoldest < 21.5 => 0.0374451132291789,
    identityageoldest >= 21.5                             => model1_attrsv4_tree_222_c1107,
    identityageoldest = NULL                              => -0.00383906674846277,
                                                             -0.00383906674846277);

model1_attrsv4_tree_223_c1115 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 3.5 => 0.0656257388332744,
    businessrecordtimeoldest >= 3.5                                    => 0.0123180150331446,
    businessrecordtimeoldest = NULL                                    => 0.0359848062030298,
                                                                          0.0359848062030298);

model1_attrsv4_tree_223_c1114 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 14.5 => model1_attrsv4_tree_223_c1115,
    inputaddrageoldest >= 14.5                              => 0.0193868925149074,
    inputaddrageoldest = NULL                               => 0.0219086449547531,
                                                               0.0219086449547531);

model1_attrsv4_tree_223_c1113 := map(
    NULL < divaddrssncount AND divaddrssncount < 14.5 => -0.00217121537293714,
    divaddrssncount >= 14.5                           => model1_attrsv4_tree_223_c1114,
    divaddrssncount = NULL                            => 0.00802566391724119,
                                                         0.00802566391724119);

model1_attrsv4_tree_223_c1112 := map(
    NULL < beta_srch_addrsperid_count03 AND beta_srch_addrsperid_count03 < 0.5 => model1_attrsv4_tree_223_c1113,
    beta_srch_addrsperid_count03 >= 0.5                                        => -0.0149419352732419,
    beta_srch_addrsperid_count03 = NULL                                        => 0.00506317648542526,
                                                                                  0.00506317648542526);

model1_attrsv4_tree_223 := map(
    NULL < sbfeavgutilever AND sbfeavgutilever < 62.5 => model1_attrsv4_tree_223_c1112,
    sbfeavgutilever >= 62.5                           => 0.0507532911391977,
    sbfeavgutilever = NULL                            => 0.00614077352914631,
                                                         0.00614077352914631);

model1_attrsv4_tree_224_c1119 := map(
    NULL < variationrisklevel AND variationrisklevel < 3.5 => -0.0000475721155483901,
    variationrisklevel >= 3.5                              => 0.0459426937579725,
    variationrisklevel = NULL                              => 0.00216740024821309,
                                                              0.00216740024821309);

model1_attrsv4_tree_224_c1118 := map(
    NULL < correlationaddrnamecount AND correlationaddrnamecount < 3.5 => -0.0156167110796913,
    correlationaddrnamecount >= 3.5                                    => model1_attrsv4_tree_224_c1119,
    correlationaddrnamecount = NULL                                    => -0.00168445796566482,
                                                                          -0.00168445796566482);

model1_attrsv4_tree_224_c1120 := map(
    NULL < sbfeprincipalaccountcount AND sbfeprincipalaccountcount < 0.5 => -0.0345007533949058,
    sbfeprincipalaccountcount >= 0.5                                     => 0.0254013248961462,
    sbfeprincipalaccountcount = NULL                                     => -0.023893093697532,
                                                                            -0.023893093697532);

model1_attrsv4_tree_224_c1117 := map(
    NULL < beta_srch_lnamesperaddr_count03 AND beta_srch_lnamesperaddr_count03 < 0.5 => model1_attrsv4_tree_224_c1118,
    beta_srch_lnamesperaddr_count03 >= 0.5                                           => model1_attrsv4_tree_224_c1120,
    beta_srch_lnamesperaddr_count03 = NULL                                           => -0.00484458004608862,
                                                                                        -0.00484458004608862);

model1_attrsv4_tree_224 := map(
    NULL < assoccount AND assoccount < 33.5 => model1_attrsv4_tree_224_c1117,
    assoccount >= 33.5                      => 0.0418908562024344,
    assoccount = NULL                       => -0.00272825840464606,
                                               -0.00272825840464606);

model1_attrsv4_tree_225_c1123 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 10.5 => 0.0209534207304269,
    prevaddrageoldest >= 10.5                             => -0.00114185196062793,
    prevaddrageoldest = NULL                              => 0.000879501282811979,
                                                             0.000879501282811979);

model1_attrsv4_tree_225_c1122 := map(
    NULL < variationphonecountnew AND variationphonecountnew < 0.5 => model1_attrsv4_tree_225_c1123,
    variationphonecountnew >= 0.5                                  => 0.0532166565512752,
    variationphonecountnew = NULL                                  => 0.00292435317820072,
                                                                      0.00292435317820072);

model1_attrsv4_tree_225_c1125 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 29.5 => 0.0247976984824271,
    sourcecreditbureauagechange >= 29.5                                       => -0.0357549765168802,
    sourcecreditbureauagechange = NULL                                        => -0.00848125100066326,
                                                                                 -0.00848125100066326);

model1_attrsv4_tree_225_c1124 := map(
    NULL < variationaddrchangeage AND variationaddrchangeage < 49.5 => -0.0446728967274365,
    variationaddrchangeage >= 49.5                                  => model1_attrsv4_tree_225_c1125,
    variationaddrchangeage = NULL                                   => -0.0252959536613323,
                                                                       -0.0252959536613323);

model1_attrsv4_tree_225 := map(
    NULL < beta_srch_phonesperid_count03 AND beta_srch_phonesperid_count03 < 0.5 => model1_attrsv4_tree_225_c1122,
    beta_srch_phonesperid_count03 >= 0.5                                         => model1_attrsv4_tree_225_c1124,
    beta_srch_phonesperid_count03 = NULL                                         => -0.0000840380226174162,
                                                                                    -0.0000840380226174162);

model1_attrsv4_tree_226_c1129 := map(
    NULL < searchvelocityrisklevel AND searchvelocityrisklevel < 2.5 => 0.101831893463326,
    searchvelocityrisklevel >= 2.5                                   => -0.000416023732908031,
    searchvelocityrisklevel = NULL                                   => 0.0596403737280772,
                                                                        0.0596403737280772);

model1_attrsv4_tree_226_c1128 := map(
    NULL < beta_sum_src_credentialed AND beta_sum_src_credentialed < 1.5 => model1_attrsv4_tree_226_c1129,
    beta_sum_src_credentialed >= 1.5                                     => 0.00933171551401615,
    beta_sum_src_credentialed = NULL                                     => 0.0327452605997989,
                                                                            0.0327452605997989);

model1_attrsv4_tree_226_c1130 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => 0.0018153178237557,
    beta_srch_ssn_id_diff01 >= 0.5                                   => 0.0274744130889374,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.0037148748175353,
                                                                        0.0037148748175353);

model1_attrsv4_tree_226_c1127 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 0.5 => model1_attrsv4_tree_226_c1128,
    searchaddrsearchcount >= 0.5                                 => model1_attrsv4_tree_226_c1130,
    searchaddrsearchcount = NULL                                 => 0.011074332265846,
                                                                    0.011074332265846);

model1_attrsv4_tree_226 := map(
    NULL < identityrecordcount AND identityrecordcount < 76.5 => model1_attrsv4_tree_226_c1127,
    identityrecordcount >= 76.5                               => -0.0074621749211763,
    identityrecordcount = NULL                                => 0.00250556950958096,
                                                                 0.00250556950958096);

model1_attrsv4_tree_227_c1132 := map(
    NULL < sbfehitindex AND sbfehitindex < 0.5 => -0.0279359462140205,
    sbfehitindex >= 0.5                        => -0.00364241864868555,
    sbfehitindex = NULL                        => -0.00919759389400105,
                                                  -0.00919759389400105);

model1_attrsv4_tree_227_c1135 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 1.5 => 0.0200463271747943,
    searchphonesearchcount >= 1.5                                  => 0.0836897832649294,
    searchphonesearchcount = NULL                                  => 0.0419982144358302,
                                                                      0.0419982144358302);

model1_attrsv4_tree_227_c1134 := map(
    NULL < assochighrisktopologycount AND assochighrisktopologycount < 0.5 => 0.00982413778320983,
    assochighrisktopologycount >= 0.5                                      => model1_attrsv4_tree_227_c1135,
    assochighrisktopologycount = NULL                                      => 0.0140731154202437,
                                                                              0.0140731154202437);

model1_attrsv4_tree_227_c1133 := map(
    NULL < identityrecordcount AND identityrecordcount < 161.5 => model1_attrsv4_tree_227_c1134,
    identityrecordcount >= 161.5                               => -0.0418740952407563,
    identityrecordcount = NULL                                 => 0.00976948383093604,
                                                                  0.00976948383093604);

model1_attrsv4_tree_227 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 110.5 => model1_attrsv4_tree_227_c1132,
    beta_m_src_credentialed_fs >= 110.5                                      => model1_attrsv4_tree_227_c1133,
    beta_m_src_credentialed_fs = NULL                                        => 0.0045266972522506,
                                                                                0.0045266972522506);

model1_attrsv4_tree_228_c1139 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 0.5 => 0.030941639757746,
    searchaddrsearchcount >= 0.5                                 => -0.00399008222221459,
    searchaddrsearchcount = NULL                                 => 0.0052765273585805,
                                                                    0.0052765273585805);

model1_attrsv4_tree_228_c1138 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_228_c1139,
    beta_srch_ssn_id_diff01 >= 0.5                                   => 0.029594985766816,
    beta_srch_ssn_id_diff01 = NULL                                   => 0.00734684084441504,
                                                                        0.00734684084441504);

model1_attrsv4_tree_228_c1137 := map(
    NULL < beta_corrnamedob AND beta_corrnamedob < 1.5 => model1_attrsv4_tree_228_c1138,
    beta_corrnamedob >= 1.5                            => -0.00978994226530463,
    beta_corrnamedob = NULL                            => -0.00304998808871823,
                                                          -0.00304998808871823);

model1_attrsv4_tree_228_c1140 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 263.5 => 0.0728702734115522,
    sourcecreditbureauageoldest >= 263.5                                       => -0.0128103117072476,
    sourcecreditbureauageoldest = NULL                                         => 0.0282299685597405,
                                                                                  0.0282299685597405);

model1_attrsv4_tree_228 := map(
    NULL < searchlocatesearchcountyear AND searchlocatesearchcountyear < 0.5 => model1_attrsv4_tree_228_c1137,
    searchlocatesearchcountyear >= 0.5                                       => model1_attrsv4_tree_228_c1140,
    searchlocatesearchcountyear = NULL                                       => -0.0012941792013755,
                                                                                -0.0012941792013755);

model1_attrsv4_tree_229_c1145 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 20.5 => -0.0259703170122994,
    sourcecreditbureauagechange >= 20.5                                       => 0.0404563345615633,
    sourcecreditbureauagechange = NULL                                        => 0.0173622089676597,
                                                                                 0.0173622089676597);

model1_attrsv4_tree_229_c1144 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 5.5 => 0.0572114082809733,
    sourcecreditbureauagechange >= 5.5                                       => model1_attrsv4_tree_229_c1145,
    sourcecreditbureauagechange = NULL                                       => 0.0245130622186684,
                                                                                0.0245130622186684);

model1_attrsv4_tree_229_c1143 := map(
    NULL < beta_srch_corrdobssn_id AND beta_srch_corrdobssn_id < 0.5 => -0.00457298982639916,
    beta_srch_corrdobssn_id >= 0.5                                   => model1_attrsv4_tree_229_c1144,
    beta_srch_corrdobssn_id = NULL                                   => 0.000947856151296341,
                                                                        0.000947856151296341);

model1_attrsv4_tree_229_c1142 := map(
    NULL < variationsearchaddrcount AND variationsearchaddrcount < 1.5 => model1_attrsv4_tree_229_c1143,
    variationsearchaddrcount >= 1.5                                    => -0.0190064306555341,
    variationsearchaddrcount = NULL                                    => -0.00224365853974478,
                                                                          -0.00224365853974478);

model1_attrsv4_tree_229 := map(
    NULL < beta_srch_corrnameaddrphnssn AND beta_srch_corrnameaddrphnssn < 1.5 => model1_attrsv4_tree_229_c1142,
    beta_srch_corrnameaddrphnssn >= 1.5                                        => 0.0358662296497435,
    beta_srch_corrnameaddrphnssn = NULL                                        => -0.000886443182053094,
                                                                                  -0.000886443182053094);

model1_attrsv4_tree_230_c1149 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 131 => -0.00785595214493079,
    beta_m_src_credentialed_fs >= 131                                      => 0.0497617164609812,
    beta_m_src_credentialed_fs = NULL                                      => 0.0210518815886196,
                                                                              0.0210518815886196);

model1_attrsv4_tree_230_c1148 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 6.5 => -0.0194842079819618,
    divaddrphonecount >= 6.5                             => model1_attrsv4_tree_230_c1149,
    divaddrphonecount = NULL                             => -0.00113894816075001,
                                                            -0.00113894816075001);

model1_attrsv4_tree_230_c1147 := map(
    NULL < searchcountyear AND searchcountyear < 2.5 => model1_attrsv4_tree_230_c1148,
    searchcountyear >= 2.5                           => 0.0337164984812474,
    searchcountyear = NULL                           => 0.00527480788377998,
                                                        0.00527480788377998);

model1_attrsv4_tree_230_c1150 := map(
    NULL < beta_srch_corrdobaddr AND beta_srch_corrdobaddr < 2.5 => -0.00378339466022452,
    beta_srch_corrdobaddr >= 2.5                                 => -0.0543848794850617,
    beta_srch_corrdobaddr = NULL                                 => -0.00532254758797884,
                                                                    -0.00532254758797884);

model1_attrsv4_tree_230 := map(
    NULL < businessactivity06month AND businessactivity06month < 0.5 => model1_attrsv4_tree_230_c1147,
    businessactivity06month >= 0.5                                   => model1_attrsv4_tree_230_c1150,
    businessactivity06month = NULL                                   => -0.00335303907105762,
                                                                        -0.00335303907105762);

model1_attrsv4_tree_231_c1154 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 6.5 => -0.0045971682755634,
    searchphonesearchcount >= 6.5                                  => 0.0565327072580109,
    searchphonesearchcount = NULL                                  => -0.00276327200955617,
                                                                      -0.00276327200955617);

model1_attrsv4_tree_231_c1153 := map(
    NULL < searchfraudsearchcount AND searchfraudsearchcount < 8.5 => model1_attrsv4_tree_231_c1154,
    searchfraudsearchcount >= 8.5                                  => -0.0433346689587627,
    searchfraudsearchcount = NULL                                  => -0.00497935671686577,
                                                                      -0.00497935671686577);

model1_attrsv4_tree_231_c1155 := map(
    NULL < sbfeavgbalancecard12m AND sbfeavgbalancecard12m < 4987 => 0.119869890537133,
    sbfeavgbalancecard12m >= 4987                                 => -0.0167396731189839,
    sbfeavgbalancecard12m = NULL                                  => 0.0352819254249861,
                                                                     0.0352819254249861);

model1_attrsv4_tree_231_c1152 := map(
    NULL < sbfehighbalance24m AND sbfehighbalance24m < 22388.5 => model1_attrsv4_tree_231_c1153,
    sbfehighbalance24m >= 22388.5                              => model1_attrsv4_tree_231_c1155,
    sbfehighbalance24m = NULL                                  => -0.00183135523252343,
                                                                  -0.00183135523252343);

model1_attrsv4_tree_231 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 25.5 => model1_attrsv4_tree_231_c1152,
    divssnaddrcount >= 25.5                           => 0.0537513155364184,
    divssnaddrcount = NULL                            => -0.000402461101906769,
                                                         -0.000402461101906769);

model1_attrsv4_tree_232_c1158 := map(
    NULL < identityrecordcount AND identityrecordcount < 113.5 => 0.00840944065185616,
    identityrecordcount >= 113.5                               => -0.0272092709390414,
    identityrecordcount = NULL                                 => 0.000455430415895568,
                                                                  0.000455430415895568);

model1_attrsv4_tree_232_c1157 := map(
    NULL < sourcedriverslicense AND sourcedriverslicense < 0.5 => 0.031782410006476,
    sourcedriverslicense >= 0.5                                => model1_attrsv4_tree_232_c1158,
    sourcedriverslicense = NULL                                => 0.00148421584031995,
                                                                  0.00148421584031995);

model1_attrsv4_tree_232_c1160 := map(
    ((string)curraddrstatus in ['R', 'U'])      => -0.0519187706191338,
    ((string)curraddrstatus in ['', '-1', 'O']) => -0.00799509149475831,
    curraddrstatus = ''               => -0.0307928488257491,
                                           -0.0307928488257491);

model1_attrsv4_tree_232_c1159 := map(
    NULL < idveraddressmatchescurrent AND idveraddressmatchescurrent < 0.5 => model1_attrsv4_tree_232_c1160,
    idveraddressmatchescurrent >= 0.5                                      => -0.00504026378845434,
    idveraddressmatchescurrent = NULL                                      => -0.0136943301556383,
                                                                              -0.0136943301556383);

model1_attrsv4_tree_232 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 3.5 => model1_attrsv4_tree_232_c1157,
    divaddrphonemsourcecount >= 3.5                                    => model1_attrsv4_tree_232_c1159,
    divaddrphonemsourcecount = NULL                                    => -0.00159445150791685,
                                                                          -0.00159445150791685);

model1_attrsv4_tree_233_c1165 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 14.5 => 0.0517535332030388,
    sourcecreditbureauagechange >= 14.5                                       => -0.0102881028901008,
    sourcecreditbureauagechange = NULL                                        => 0.0189768197953424,
                                                                                 0.0189768197953424);

model1_attrsv4_tree_233_c1164 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 4.5 => -0.00427071351879471,
    beta_srch_perbestssn >= 4.5                                => model1_attrsv4_tree_233_c1165,
    beta_srch_perbestssn = NULL                                => -0.00284299710436914,
                                                                  -0.00284299710436914);

model1_attrsv4_tree_233_c1163 := map(
    NULL < searchssnsearchcountyear AND searchssnsearchcountyear < 1.5 => model1_attrsv4_tree_233_c1164,
    searchssnsearchcountyear >= 1.5                                    => -0.0225008368144656,
    searchssnsearchcountyear = NULL                                    => -0.00545943483574812,
                                                                          -0.00545943483574812);

model1_attrsv4_tree_233_c1162 := map(
    NULL < suspiciousactivityindex AND suspiciousactivityindex < 5.5 => model1_attrsv4_tree_233_c1163,
    suspiciousactivityindex >= 5.5                                   => -0.0261194486798486,
    suspiciousactivityindex = NULL                                   => -0.00604914491619695,
                                                                        -0.00604914491619695);

model1_attrsv4_tree_233 := map(
    NULL < divssnaddrmsourcecount AND divssnaddrmsourcecount < 17.5 => model1_attrsv4_tree_233_c1162,
    divssnaddrmsourcecount >= 17.5                                  => 0.0380503310006961,
    divssnaddrmsourcecount = NULL                                   => -0.00458262932556442,
                                                                       -0.00458262932556442);

model1_attrsv4_tree_234_c1169 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 8.5 => -0.000856366772207453,
    variationlastnamecount >= 8.5                                  => 0.0660744291104301,
    variationlastnamecount = NULL                                  => 0.00111644468025536,
                                                                      0.00111644468025536);

model1_attrsv4_tree_234_c1170 := map(
    NULL < searchssnsearchcount AND searchssnsearchcount < 0.5 => 0.00650983184111907,
    searchssnsearchcount >= 0.5                                => -0.0377856416762788,
    searchssnsearchcount = NULL                                => -0.0141046000650545,
                                                                  -0.0141046000650545);

model1_attrsv4_tree_234_c1168 := map(
    NULL < correlationrisklevel AND correlationrisklevel < 8.5 => model1_attrsv4_tree_234_c1169,
    correlationrisklevel >= 8.5                                => model1_attrsv4_tree_234_c1170,
    correlationrisklevel = NULL                                => 0.000116578173489175,
                                                                  0.000116578173489175);

model1_attrsv4_tree_234_c1167 := map(
    NULL < sbfeopencount06m AND sbfeopencount06m < 0.5 => model1_attrsv4_tree_234_c1168,
    sbfeopencount06m >= 0.5                            => 0.0381946751390854,
    sbfeopencount06m = NULL                            => 0.00137251345087874,
                                                          0.00137251345087874);

model1_attrsv4_tree_234 := map(
    NULL < sbfeopencount84m AND sbfeopencount84m < 5.5 => model1_attrsv4_tree_234_c1167,
    sbfeopencount84m >= 5.5                            => -0.0512236579348915,
    sbfeopencount84m = NULL                            => -0.00045098588725999,
                                                          -0.00045098588725999);

model1_attrsv4_tree_235_c1175 := map(
    NULL < sourcepublicrecordcount AND sourcepublicrecordcount < 1.5 => -0.0174933146951247,
    sourcepublicrecordcount >= 1.5                                   => 0.054296423268821,
    sourcepublicrecordcount = NULL                                   => 0.000580214183386215,
                                                                        0.000580214183386215);

model1_attrsv4_tree_235_c1174 := map(
    NULL < inputaddrlotsize AND inputaddrlotsize < 5315 => -0.0136772279987606,
    inputaddrlotsize >= 5315                            => model1_attrsv4_tree_235_c1175,
    inputaddrlotsize = NULL                             => -0.00717303161865727,
                                                           -0.00717303161865727);

model1_attrsv4_tree_235_c1173 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 1.5 => model1_attrsv4_tree_235_c1174,
    vulnerablevictimindex >= 1.5                                 => 0.0426892280106684,
    vulnerablevictimindex = NULL                                 => -0.00494646988476292,
                                                                    -0.00494646988476292);

model1_attrsv4_tree_235_c1172 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_235_c1173,
    friendlyfraudindex >= 6.5                              => -0.023412952225739,
    friendlyfraudindex = NULL                              => -0.00557021448059963,
                                                              -0.00557021448059963);

model1_attrsv4_tree_235 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 4.5 => model1_attrsv4_tree_235_c1172,
    searchaddrsearchcountyear >= 4.5                                     => 0.0224494344889136,
    searchaddrsearchcountyear = NULL                                     => -0.00435426744984717,
                                                                            -0.00435426744984717);

model1_attrsv4_tree_236_c1179 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 21.5 => 0.00174846785923245,
    divaddrssnmsourcecount >= 21.5                                  => -0.0204391047886134,
    divaddrssnmsourcecount = NULL                                   => -0.00151458528399482,
                                                                       -0.00151458528399482);

model1_attrsv4_tree_236_c1180 := map(
    NULL < sostimeincorporation AND sostimeincorporation < 75 => 0.0837148571428317,
    sostimeincorporation >= 75                                => -0.0433014475978943,
    sostimeincorporation = NULL                               => 0.0136818945974314,
                                                                 0.0136818945974314);

model1_attrsv4_tree_236_c1178 := map(
    NULL < sbfehighbalance24m AND sbfehighbalance24m < 22802 => model1_attrsv4_tree_236_c1179,
    sbfehighbalance24m >= 22802                              => model1_attrsv4_tree_236_c1180,
    sbfehighbalance24m = NULL                                => -0.000412132582037936,
                                                                -0.000412132582037936);

model1_attrsv4_tree_236_c1177 := map(
    NULL < searchfraudsearchcount AND searchfraudsearchcount < 12.5 => model1_attrsv4_tree_236_c1178,
    searchfraudsearchcount >= 12.5                                  => -0.0442920941345914,
    searchfraudsearchcount = NULL                                   => -0.00162071330612373,
                                                                       -0.00162071330612373);

model1_attrsv4_tree_236 := map(
    NULL < prevaddrlenofres AND prevaddrlenofres < 0.5 => 0.0392481130641482,
    prevaddrlenofres >= 0.5                            => model1_attrsv4_tree_236_c1177,
    prevaddrlenofres = NULL                            => -0.00064718701758659,
                                                          -0.00064718701758659);

model1_attrsv4_tree_237_c1183 := map(
    NULL < divaddrssncount AND divaddrssncount < 15.5 => -0.0122426787631139,
    divaddrssncount >= 15.5                           => 0.0684720345347546,
    divaddrssncount = NULL                            => 0.0176692444002138,
                                                         0.0176692444002138);

model1_attrsv4_tree_237_c1185 := map(
    NULL < variationaddrstability AND variationaddrstability < 1.5 => -0.0158401142951225,
    variationaddrstability >= 1.5                                  => 0.038939646545621,
    variationaddrstability = NULL                                  => 0.018694952321868,
                                                                      0.018694952321868);

model1_attrsv4_tree_237_c1184 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 2.5 => model1_attrsv4_tree_237_c1185,
    sourcecreditbureauagechange >= 2.5                                       => -0.00839916395332449,
    sourcecreditbureauagechange = NULL                                       => -0.00632310174012262,
                                                                                -0.00632310174012262);

model1_attrsv4_tree_237_c1182 := map(
    NULL < beta_srch_corrdobphone AND beta_srch_corrdobphone < -2.5 => model1_attrsv4_tree_237_c1183,
    beta_srch_corrdobphone >= -2.5                                  => model1_attrsv4_tree_237_c1184,
    beta_srch_corrdobphone = NULL                                   => -0.00334739733069373,
                                                                       -0.00334739733069373);

model1_attrsv4_tree_237 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 22.5 => model1_attrsv4_tree_237_c1182,
    divaddrphonemsourcecount >= 22.5                                    => 0.0467983136644043,
    divaddrphonemsourcecount = NULL                                     => -0.00183356454593606,
                                                                           -0.00183356454593606);

model1_attrsv4_tree_238_c1189 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 3.5 => -0.000969440292037157,
    variationlastnamecount >= 3.5                                  => 0.032661300269201,
    variationlastnamecount = NULL                                  => 0.00814505584885885,
                                                                      0.00814505584885885);

model1_attrsv4_tree_238_c1188 := map(
    NULL < identityrecordcount AND identityrecordcount < 89.5 => model1_attrsv4_tree_238_c1189,
    identityrecordcount >= 89.5                               => -0.0155386479306111,
    identityrecordcount = NULL                                => -0.00030251812347334,
                                                                 -0.00030251812347334);

model1_attrsv4_tree_238_c1190 := map(
    NULL < identityrecordcount AND identityrecordcount < 19.5 => 0.00590665929722288,
    identityrecordcount >= 19.5                               => -0.0407475230546,
    identityrecordcount = NULL                                => -0.0160726443885248,
                                                                 -0.0160726443885248);

model1_attrsv4_tree_238_c1187 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 2.5 => model1_attrsv4_tree_238_c1188,
    beta_synthidindex >= 2.5                             => model1_attrsv4_tree_238_c1190,
    beta_synthidindex = NULL                             => -0.00116626651919792,
                                                            -0.00116626651919792);

model1_attrsv4_tree_238 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 24.5 => model1_attrsv4_tree_238_c1187,
    divssnaddrcount >= 24.5                           => 0.0549091981637094,
    divssnaddrcount = NULL                            => 0.000579479079420893,
                                                         0.000579479079420893);

model1_attrsv4_tree_239_c1195 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 3.5 => 0.0459506104451584,
    businessrecordtimeoldest >= 3.5                                    => -0.00454804441989184,
    businessrecordtimeoldest = NULL                                    => 0.00998394259163341,
                                                                          0.00998394259163341);

model1_attrsv4_tree_239_c1194 := map(
    NULL < divaddrphonecountnew AND divaddrphonecountnew < 0.5 => -0.00629960580973982,
    divaddrphonecountnew >= 0.5                                => model1_attrsv4_tree_239_c1195,
    divaddrphonecountnew = NULL                                => -0.00294142594654861,
                                                                  -0.00294142594654861);

model1_attrsv4_tree_239_c1193 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 8.5 => 0.0355039543648988,
    prevaddrageoldest >= 8.5                             => model1_attrsv4_tree_239_c1194,
    prevaddrageoldest = NULL                             => -0.000971533149058902,
                                                            -0.000971533149058902);

model1_attrsv4_tree_239_c1192 := map(
    NULL < divaddridentitycountnew AND divaddridentitycountnew < 2.5 => model1_attrsv4_tree_239_c1193,
    divaddridentitycountnew >= 2.5                                   => -0.0223494709156069,
    divaddridentitycountnew = NULL                                   => -0.00370152520176149,
                                                                        -0.00370152520176149);

model1_attrsv4_tree_239 := map(
    NULL < friendlyfraudindex AND friendlyfraudindex < 6.5 => model1_attrsv4_tree_239_c1192,
    friendlyfraudindex >= 6.5                              => 0.02069533232693,
    friendlyfraudindex = NULL                              => -0.00273485726194541,
                                                              -0.00273485726194541);

model1_attrsv4_tree_240_c1199 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 7.5 => -0.00650127236981644,
    searchphonesearchcount >= 7.5                                  => 0.0440567553565617,
    searchphonesearchcount = NULL                                  => -0.0046514107964226,
                                                                      -0.0046514107964226);

model1_attrsv4_tree_240_c1200 := map(
    NULL < sbfebalanceamt60m AND sbfebalanceamt60m < 26 => 0.100865542741072,
    sbfebalanceamt60m >= 26                             => -0.0244513948793658,
    sbfebalanceamt60m = NULL                            => 0.0226602358050095,
                                                           0.0226602358050095);

model1_attrsv4_tree_240_c1198 := map(
    NULL < sbfehighbalance24m AND sbfehighbalance24m < 22530.5 => model1_attrsv4_tree_240_c1199,
    sbfehighbalance24m >= 22530.5                              => model1_attrsv4_tree_240_c1200,
    sbfehighbalance24m = NULL                                  => -0.00270736530646249,
                                                                  -0.00270736530646249);

model1_attrsv4_tree_240_c1197 := map(
    NULL < beta_srch_addrsperssn_count03 AND beta_srch_addrsperssn_count03 < 0.5 => model1_attrsv4_tree_240_c1198,
    beta_srch_addrsperssn_count03 >= 0.5                                         => -0.0191421484964189,
    beta_srch_addrsperssn_count03 = NULL                                         => -0.00426765472532006,
                                                                                    -0.00426765472532006);

model1_attrsv4_tree_240 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 12.5 => model1_attrsv4_tree_240_c1197,
    beta_srch_perbestssn >= 12.5                                => 0.0273441330692498,
    beta_srch_perbestssn = NULL                                 => -0.00344008197881127,
                                                                   -0.00344008197881127);

model1_attrsv4_tree_241_c1204 := map(
    NULL < componentcharrisklevel AND componentcharrisklevel < 3.5 => 0.0428913822032286,
    componentcharrisklevel >= 3.5                                  => 0.0847503763395861,
    componentcharrisklevel = NULL                                  => 0.0629836993886802,
                                                                      0.0629836993886802);

model1_attrsv4_tree_241_c1203 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 50.5 => 0.000382016424328069,
    curraddrageoldest >= 50.5                             => model1_attrsv4_tree_241_c1204,
    curraddrageoldest = NULL                              => 0.0329870596349281,
                                                             0.0329870596349281);

model1_attrsv4_tree_241_c1202 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 120315 => model1_attrsv4_tree_241_c1203,
    inputaddrassessedtotal >= 120315                                  => -0.00868372963004083,
    inputaddrassessedtotal = NULL                                     => 0.0132429219685787,
                                                                         0.0132429219685787);

model1_attrsv4_tree_241_c1205 := map(
    NULL < divsearchaddrsuspidentitycount AND divsearchaddrsuspidentitycount < 0.5 => -0.0054631856630465,
    divsearchaddrsuspidentitycount >= 0.5                                          => 0.0229961726937792,
    divsearchaddrsuspidentitycount = NULL                                          => -0.00280786676400368,
                                                                                      -0.00280786676400368);

model1_attrsv4_tree_241 := map(
    NULL < searchcount AND searchcount < 1.5 => model1_attrsv4_tree_241_c1202,
    searchcount >= 1.5                       => model1_attrsv4_tree_241_c1205,
    searchcount = NULL                       => 0.000300080771243986,
                                                0.000300080771243986);

model1_attrsv4_tree_242_c1208 := map(
    NULL < assoccount AND assoccount < 37.5 => -0.00436246198758306,
    assoccount >= 37.5                      => 0.0633402551961893,
    assoccount = NULL                       => -0.00215559904083311,
                                               -0.00215559904083311);

model1_attrsv4_tree_242_c1210 := map(
    NULL < inputaddrlotsize AND inputaddrlotsize < 674 => 0.0165610236975888,
    inputaddrlotsize >= 674                            => 0.0880450849472472,
    inputaddrlotsize = NULL                            => 0.0504912463183944,
                                                          0.0504912463183944);

model1_attrsv4_tree_242_c1209 := map(
    NULL < identityageoldest AND identityageoldest < 281.5 => model1_attrsv4_tree_242_c1210,
    identityageoldest >= 281.5                             => -0.0289706341957639,
    identityageoldest = NULL                               => 0.0166463712845863,
                                                              0.0166463712845863);

model1_attrsv4_tree_242_c1207 := map(
    NULL < beta_srch_perbestssn AND beta_srch_perbestssn < 4.5 => model1_attrsv4_tree_242_c1208,
    beta_srch_perbestssn >= 4.5                                => model1_attrsv4_tree_242_c1209,
    beta_srch_perbestssn = NULL                                => -0.000336053525469943,
                                                                  -0.000336053525469943);

model1_attrsv4_tree_242 := map(
    NULL < searchfraudsearchcountyear AND searchfraudsearchcountyear < 2.5 => model1_attrsv4_tree_242_c1207,
    searchfraudsearchcountyear >= 2.5                                      => -0.0316541562734017,
    searchfraudsearchcountyear = NULL                                      => -0.00280309275136834,
                                                                              -0.00280309275136834);

model1_attrsv4_tree_243_c1212 := map(
    NULL < divaddrssncount AND divaddrssncount < 8.5 => -0.027215939038846,
    divaddrssncount >= 8.5                           => 0.0437737633726519,
    divaddrssncount = NULL                           => 0.00862020881311211,
                                                        0.00862020881311211);

model1_attrsv4_tree_243_c1215 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 16.5 => -0.000902273730353233,
    divaddrphonecount >= 16.5                             => -0.0410546215807899,
    divaddrphonecount = NULL                              => -0.0101465580202436,
                                                             -0.0101465580202436);

model1_attrsv4_tree_243_c1214 := map(
    NULL < divaddridentitycount AND divaddridentitycount < 25.5 => 0.0063460109824433,
    divaddridentitycount >= 25.5                                => model1_attrsv4_tree_243_c1215,
    divaddridentitycount = NULL                                 => 0.00203741358869744,
                                                                   0.00203741358869744);

model1_attrsv4_tree_243_c1213 := map(
    NULL < searchcomponentrisklevel AND searchcomponentrisklevel < 1.5 => model1_attrsv4_tree_243_c1214,
    searchcomponentrisklevel >= 1.5                                    => -0.0245542421856154,
    searchcomponentrisklevel = NULL                                    => 0.000665621822562253,
                                                                          0.000665621822562253);

model1_attrsv4_tree_243 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 1.5 => model1_attrsv4_tree_243_c1212,
    inputaddrageoldest >= 1.5                              => model1_attrsv4_tree_243_c1213,
    inputaddrageoldest = NULL                              => 0.00105584684474017,
                                                              0.00105584684474017);

model1_attrsv4_tree_244_c1220 := map(
    NULL < idverdobsourcecount AND idverdobsourcecount < 1.5 => 0.0589540927816002,
    idverdobsourcecount >= 1.5                               => 0.0137222004406812,
    idverdobsourcecount = NULL                               => 0.018534634410801,
                                                                0.018534634410801);

model1_attrsv4_tree_244_c1219 := map(
    NULL < divssnaddrmsourcecount AND divssnaddrmsourcecount < 7.5 => -0.00237349342126121,
    divssnaddrmsourcecount >= 7.5                                  => model1_attrsv4_tree_244_c1220,
    divssnaddrmsourcecount = NULL                                  => 0.00877832777466965,
                                                                      0.00877832777466965);

model1_attrsv4_tree_244_c1218 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 1.5 => model1_attrsv4_tree_244_c1219,
    vulnerablevictimindex >= 1.5                                 => 0.0591117537935527,
    vulnerablevictimindex = NULL                                 => 0.0108909138244763,
                                                                    0.0108909138244763);

model1_attrsv4_tree_244_c1217 := map(
    NULL < associatecountycount AND associatecountycount < 1.5 => model1_attrsv4_tree_244_c1218,
    associatecountycount >= 1.5                                => -0.0322851623460755,
    associatecountycount = NULL                                => 0.00508988530217099,
                                                                  0.00508988530217099);

model1_attrsv4_tree_244 := map(
    NULL < stolenidentityindex AND stolenidentityindex < 2.5 => model1_attrsv4_tree_244_c1217,
    stolenidentityindex >= 2.5                               => -0.0251967481722952,
    stolenidentityindex = NULL                               => 0.00409699802553165,
                                                                0.00409699802553165);

model1_attrsv4_tree_245_c1225 := map(
    NULL < correlationphonelastnamecount AND correlationphonelastnamecount < 0.5 => 0.0123443111680377,
    correlationphonelastnamecount >= 0.5                                         => -0.0141645652465828,
    correlationphonelastnamecount = NULL                                         => -0.00355368165821329,
                                                                                    -0.00355368165821329);

model1_attrsv4_tree_245_c1224 := map(
    NULL < divaddridentitycount AND divaddridentitycount < 53.5 => model1_attrsv4_tree_245_c1225,
    divaddridentitycount >= 53.5                                => -0.0378433170108075,
    divaddridentitycount = NULL                                 => -0.00513697616657846,
                                                                   -0.00513697616657846);

model1_attrsv4_tree_245_c1223 := map(
    NULL < idveraddress AND idveraddress < 0.5 => 0.0240689903855418,
    idveraddress >= 0.5                        => model1_attrsv4_tree_245_c1224,
    idveraddress = NULL                        => -0.00433506741084922,
                                                  -0.00433506741084922);

model1_attrsv4_tree_245_c1222 := map(
    NULL < searchphonesearchcount AND searchphonesearchcount < 7.5 => model1_attrsv4_tree_245_c1223,
    searchphonesearchcount >= 7.5                                  => 0.0409307228670921,
    searchphonesearchcount = NULL                                  => -0.00284118400961691,
                                                                      -0.00284118400961691);

model1_attrsv4_tree_245 := map(
    NULL < searchcount AND searchcount < 22.5 => model1_attrsv4_tree_245_c1222,
    searchcount >= 22.5                       => -0.0416501086147434,
    searchcount = NULL                        => -0.00476332414336139,
                                                 -0.00476332414336139);

model1_attrsv4_tree_246_c1229 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 14.5 => -0.00978784416313956,
    divaddrphonecount >= 14.5                             => 0.046345083783496,
    divaddrphonecount = NULL                              => -0.00560179484893733,
                                                             -0.00560179484893733);

model1_attrsv4_tree_246_c1228 := map(
    ((string)curraddrdwelltype in ['H'])                                    => -0.0269826802685608,
    ((string)curraddrdwelltype in ['', '-1', 'F', 'M', 'P', 'R', 'S', 'U']) => model1_attrsv4_tree_246_c1229,
    curraddrdwelltype = ''                                        => -0.00961148195879171,
                                                                       -0.00961148195879171);

model1_attrsv4_tree_246_c1230 := map(
    NULL < correlationssnaddrcount AND correlationssnaddrcount < 1.5 => -0.0232961978536371,
    correlationssnaddrcount >= 1.5                                   => 0.0174616041795291,
    correlationssnaddrcount = NULL                                   => 0.0136618592575408,
                                                                        0.0136618592575408);

model1_attrsv4_tree_246_c1227 := map(
    NULL < variationlastnamecount AND variationlastnamecount < 2.5 => model1_attrsv4_tree_246_c1228,
    variationlastnamecount >= 2.5                                  => model1_attrsv4_tree_246_c1230,
    variationlastnamecount = NULL                                  => 0.00388423493562462,
                                                                      0.00388423493562462);

model1_attrsv4_tree_246 := map(
    NULL < beta_srch_ssnsperaddr_count03 AND beta_srch_ssnsperaddr_count03 < 1.5 => model1_attrsv4_tree_246_c1227,
    beta_srch_ssnsperaddr_count03 >= 1.5                                         => -0.0445448642016836,
    beta_srch_ssnsperaddr_count03 = NULL                                         => 0.00257070984109857,
                                                                                    0.00257070984109857);

model1_attrsv4_tree_247_c1233 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 1.5 => -0.00297597287429001,
    divaddrphonemsourcecount >= 1.5                                    => 0.0494667866253469,
    divaddrphonemsourcecount = NULL                                    => 0.0247339568176579,
                                                                          0.0247339568176579);

model1_attrsv4_tree_247_c1235 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => 0.0156102018274053,
    inquiry03month >= 0.5                          => 0.064624156183213,
    inquiry03month = NULL                          => 0.01982612983202,
                                                      0.01982612983202);

model1_attrsv4_tree_247_c1234 := map(
    NULL < sbfebalancecount03m AND sbfebalancecount03m < -49 => model1_attrsv4_tree_247_c1235,
    sbfebalancecount03m >= -49                               => -0.0259046249180949,
    sbfebalancecount03m = NULL                               => 0.00482339989528788,
                                                                0.00482339989528788);

model1_attrsv4_tree_247_c1232 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 10.5 => model1_attrsv4_tree_247_c1233,
    inputaddrageoldest >= 10.5                              => model1_attrsv4_tree_247_c1234,
    inputaddrageoldest = NULL                               => 0.00655442401648102,
                                                               0.00655442401648102);

model1_attrsv4_tree_247 := map(
    NULL < sourcephonedirectoryassistance AND sourcephonedirectoryassistance < 0.5 => -0.00886096149078519,
    sourcephonedirectoryassistance >= 0.5                                          => model1_attrsv4_tree_247_c1232,
    sourcephonedirectoryassistance = NULL                                          => 0.000715483185191032,
                                                                                      0.000715483185191032);

model1_attrsv4_tree_248_c1240 := map(
    NULL < identityageoldest AND identityageoldest < 234.5 => 0.0790114005622788,
    identityageoldest >= 234.5                             => -0.0162851280090213,
    identityageoldest = NULL                               => 0.0227312043408226,
                                                              0.0227312043408226);

model1_attrsv4_tree_248_c1239 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 6.5 => 0.0611940636609969,
    businessrecordtimeoldest >= 6.5                                    => model1_attrsv4_tree_248_c1240,
    businessrecordtimeoldest = NULL                                    => 0.0355521574475474,
                                                                          0.0355521574475474);

model1_attrsv4_tree_248_c1238 := map(
    NULL < assoccount AND assoccount < 9.5 => 0.00831097436313937,
    assoccount >= 9.5                      => model1_attrsv4_tree_248_c1239,
    assoccount = NULL                      => 0.0178523024485412,
                                              0.0178523024485412);

model1_attrsv4_tree_248_c1237 := map(
    NULL < assoccount AND assoccount < 23.5 => model1_attrsv4_tree_248_c1238,
    assoccount >= 23.5                      => -0.0369288586268583,
    assoccount = NULL                       => 0.0118664182315608,
                                               0.0118664182315608);

model1_attrsv4_tree_248 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => -0.0069652792045755,
    divaddrphonecount >= 7.5                             => model1_attrsv4_tree_248_c1237,
    divaddrphonecount = NULL                             => -0.00107149087963378,
                                                            -0.00107149087963378);

model1_attrsv4_tree_249_c1244 := map(
    NULL < searchssnsearchcount AND searchssnsearchcount < 1.5 => -0.00604869666632021,
    searchssnsearchcount >= 1.5                                => 0.0629379190620991,
    searchssnsearchcount = NULL                                => 0.0235169957887166,
                                                                  0.0235169957887166);

model1_attrsv4_tree_249_c1243 := map(
    NULL < variationaddrstability AND variationaddrstability < 1.5 => model1_attrsv4_tree_249_c1244,
    variationaddrstability >= 1.5                                  => -0.000929100063638079,
    variationaddrstability = NULL                                  => 0.000946355749679419,
                                                                      0.000946355749679419);

model1_attrsv4_tree_249_c1245 := map(
    NULL < busfeinpersonaddroverlap AND busfeinpersonaddroverlap < 1.5 => -0.024608740173404,
    busfeinpersonaddroverlap >= 1.5                                    => 0.02948464105567,
    busfeinpersonaddroverlap = NULL                                    => -0.0171646968849993,
                                                                          -0.0171646968849993);

model1_attrsv4_tree_249_c1242 := map(
    NULL < beta_srch_idsperssn_count06 AND beta_srch_idsperssn_count06 < 0.5 => model1_attrsv4_tree_249_c1243,
    beta_srch_idsperssn_count06 >= 0.5                                       => model1_attrsv4_tree_249_c1245,
    beta_srch_idsperssn_count06 = NULL                                       => -0.00239230894233795,
                                                                                -0.00239230894233795);

model1_attrsv4_tree_249 := map(
    NULL < variationrisklevel AND variationrisklevel < 5.5 => model1_attrsv4_tree_249_c1242,
    variationrisklevel >= 5.5                              => 0.0269512036721386,
    variationrisklevel = NULL                              => -0.00169332432581386,
                                                              -0.00169332432581386);

model1_attrsv4_tree_250_c1249 := map(
    NULL < prevaddrlenofres AND prevaddrlenofres < 25.5 => -0.00339408151148433,
    prevaddrlenofres >= 25.5                            => 0.0527688153898811,
    prevaddrlenofres = NULL                             => 0.0227039189073658,
                                                           0.0227039189073658);

model1_attrsv4_tree_250_c1248 := map(
    NULL < beta_source_type AND beta_source_type < 6 => model1_attrsv4_tree_250_c1249,
    beta_source_type >= 6                            => -0.0319080315821914,
    beta_source_type = NULL                          => 0.0030696224218345,
                                                        0.0030696224218345);

model1_attrsv4_tree_250_c1250 := map(
    NULL < identityrecordcount AND identityrecordcount < 84.5 => 0.0987248882019769,
    identityrecordcount >= 84.5                               => -0.000208916027958476,
    identityrecordcount = NULL                                => 0.0449115218844388,
                                                                 0.0449115218844388);

model1_attrsv4_tree_250_c1247 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 182.5 => model1_attrsv4_tree_250_c1248,
    beta_m_src_credentialed_fs >= 182.5                                      => model1_attrsv4_tree_250_c1250,
    beta_m_src_credentialed_fs = NULL                                        => 0.0182444539416561,
                                                                                0.0182444539416561);

model1_attrsv4_tree_250 := map(
    NULL < sbfehitindex AND sbfehitindex < 0.5 => model1_attrsv4_tree_250_c1247,
    sbfehitindex >= 0.5                        => -0.00317515263833253,
    sbfehitindex = NULL                        => 0.000153979610774193,
                                                  0.000153979610774193);

model1_attrsv4_tree_251_c1254 := map(
    NULL < beta_srch_corrdobssn_id AND beta_srch_corrdobssn_id < 0.5 => 0.00763745553801249,
    beta_srch_corrdobssn_id >= 0.5                                   => 0.0472826064666118,
    beta_srch_corrdobssn_id = NULL                                   => 0.0177289485016559,
                                                                        0.0177289485016559);

model1_attrsv4_tree_251_c1253 := map(
    NULL < businessactivity12month AND businessactivity12month < 0.5 => model1_attrsv4_tree_251_c1254,
    businessactivity12month >= 0.5                                   => -0.00133281324589263,
    businessactivity12month = NULL                                   => 0.00233034851551607,
                                                                        0.00233034851551607);

model1_attrsv4_tree_251_c1252 := map(
    NULL < assocrisklevel AND assocrisklevel < 2.5 => model1_attrsv4_tree_251_c1253,
    assocrisklevel >= 2.5                          => -0.0188730724590011,
    assocrisklevel = NULL                          => -0.00375870363482473,
                                                      -0.00375870363482473);

model1_attrsv4_tree_251_c1255 := map(
    NULL < businessactivity12month AND businessactivity12month < 1.5 => -0.0428525283677339,
    businessactivity12month >= 1.5                                   => 0.000897890793703865,
    businessactivity12month = NULL                                   => -0.0197134177890179,
                                                                        -0.0197134177890179);

model1_attrsv4_tree_251 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 2.5 => model1_attrsv4_tree_251_c1252,
    beta_srch_perphone_count06 >= 2.5                                      => model1_attrsv4_tree_251_c1255,
    beta_srch_perphone_count06 = NULL                                      => -0.00460535709819583,
                                                                              -0.00460535709819583);

model1_attrsv4_tree_252_c1259 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 3.5 => -0.000230523122683609,
    vulnerablevictimindex >= 3.5                                 => 0.0510862726985565,
    vulnerablevictimindex = NULL                                 => 0.00204300580610551,
                                                                    0.00204300580610551);

model1_attrsv4_tree_252_c1258 := map(
    NULL < sbfehighbalance12m AND sbfehighbalance12m < 17440.5 => model1_attrsv4_tree_252_c1259,
    sbfehighbalance12m >= 17440.5                              => 0.052165798640758,
    sbfehighbalance12m = NULL                                  => 0.00549529393136519,
                                                                  0.00549529393136519);

model1_attrsv4_tree_252_c1260 := map(
    NULL < divaddrssncount AND divaddrssncount < 33.5 => -0.0281942380937596,
    divaddrssncount >= 33.5                           => 0.0340985306844929,
    divaddrssncount = NULL                            => -0.0228395588291534,
                                                         -0.0228395588291534);

model1_attrsv4_tree_252_c1257 := map(
    NULL < divphoneaddrcount AND divphoneaddrcount < 1.5 => model1_attrsv4_tree_252_c1258,
    divphoneaddrcount >= 1.5                             => model1_attrsv4_tree_252_c1260,
    divphoneaddrcount = NULL                             => -0.00412656314810061,
                                                            -0.00412656314810061);

model1_attrsv4_tree_252 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_252_c1257,
    associatejudgmentcount >= 0.5                                  => 0.0440087349232121,
    associatejudgmentcount = NULL                                  => -0.0026620694096102,
                                                                      -0.0026620694096102);

model1_attrsv4_tree_253_c1264 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 1.5 => -0.00342573301632391,
    divaddrphonemsourcecount >= 1.5                                    => 0.0648843591953933,
    divaddrphonemsourcecount = NULL                                    => 0.0307293130895347,
                                                                          0.0307293130895347);

model1_attrsv4_tree_253_c1263 := map(
    NULL < divssnaddrmsourcecount AND divssnaddrmsourcecount < 7.5 => -0.000581983119974134,
    divssnaddrmsourcecount >= 7.5                                  => model1_attrsv4_tree_253_c1264,
    divssnaddrmsourcecount = NULL                                  => 0.00746531263480617,
                                                                      0.00746531263480617);

model1_attrsv4_tree_253_c1262 := map(
    NULL < idverdobsourcecount AND idverdobsourcecount < 1.5 => model1_attrsv4_tree_253_c1263,
    idverdobsourcecount >= 1.5                               => -0.0104912847308418,
    idverdobsourcecount = NULL                               => -0.00666197547698168,
                                                                -0.00666197547698168);

model1_attrsv4_tree_253_c1265 := map(
    NULL < beta_srch_corrnamephone_id AND beta_srch_corrnamephone_id < 1.5 => -0.00101871024362698,
    beta_srch_corrnamephone_id >= 1.5                                      => -0.045325905679642,
    beta_srch_corrnamephone_id = NULL                                      => -0.023760456573617,
                                                                              -0.023760456573617);

model1_attrsv4_tree_253 := map(
    NULL < beta_srch_perphone_count06 AND beta_srch_perphone_count06 < 2.5 => model1_attrsv4_tree_253_c1262,
    beta_srch_perphone_count06 >= 2.5                                      => model1_attrsv4_tree_253_c1265,
    beta_srch_perphone_count06 = NULL                                      => -0.00757335678071743,
                                                                              -0.00757335678071743);

model1_attrsv4_tree_254_c1268 := map(
    NULL < beta_srch_corrnamephonessn AND beta_srch_corrnamephonessn < -2.5 => 0.0162794383806345,
    beta_srch_corrnamephonessn >= -2.5                                      => -0.0313137964832893,
    beta_srch_corrnamephonessn = NULL                                       => -0.0171986926072967,
                                                                               -0.0171986926072967);

model1_attrsv4_tree_254_c1269 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 4.5 => 0.0280522979266155,
    inputaddrageoldest >= 4.5                              => -0.001739315508773,
    inputaddrageoldest = NULL                              => -0.000481849315778863,
                                                              -0.000481849315778863);

model1_attrsv4_tree_254_c1267 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 14.5 => model1_attrsv4_tree_254_c1268,
    curraddrageoldest >= 14.5                             => model1_attrsv4_tree_254_c1269,
    curraddrageoldest = NULL                              => -0.00268838873142213,
                                                             -0.00268838873142213);

model1_attrsv4_tree_254_c1270 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 286.5 => 0.0696199059372835,
    sourcecreditbureauageoldest >= 286.5                                       => -0.0189982791678675,
    sourcecreditbureauageoldest = NULL                                         => 0.0161014725796629,
                                                                                  0.0161014725796629);

model1_attrsv4_tree_254 := map(
    NULL < sbfehighbalance03m AND sbfehighbalance03m < 13364.5 => model1_attrsv4_tree_254_c1267,
    sbfehighbalance03m >= 13364.5                              => model1_attrsv4_tree_254_c1270,
    sbfehighbalance03m = NULL                                  => -0.00155833811011866,
                                                                  -0.00155833811011866);

model1_attrsv4_tree_255_c1274 := map(
    NULL < sourcepublicrecordcount AND sourcepublicrecordcount < 2.5 => 0.00187229974841438,
    sourcepublicrecordcount >= 2.5                                   => -0.0250118258112109,
    sourcepublicrecordcount = NULL                                   => -0.00242975578133739,
                                                                        -0.00242975578133739);

model1_attrsv4_tree_255_c1273 := map(
    NULL < associatejudgmentcount AND associatejudgmentcount < 0.5 => model1_attrsv4_tree_255_c1274,
    associatejudgmentcount >= 0.5                                  => 0.0332604761937084,
    associatejudgmentcount = NULL                                  => -0.00126365821814629,
                                                                      -0.00126365821814629);

model1_attrsv4_tree_255_c1272 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 11.5 => model1_attrsv4_tree_255_c1273,
    searchaddrsearchcount >= 11.5                                 => -0.0365120672809914,
    searchaddrsearchcount = NULL                                  => -0.00366515950942573,
                                                                     -0.00366515950942573);

model1_attrsv4_tree_255_c1275 := map(
    NULL < beta_srch_corrnamessn_id AND beta_srch_corrnamessn_id < 0.5 => -0.0181357273770314,
    beta_srch_corrnamessn_id >= 0.5                                    => 0.0539355366396885,
    beta_srch_corrnamessn_id = NULL                                    => 0.0149613766993163,
                                                                          0.0149613766993163);

model1_attrsv4_tree_255 := map(
    NULL < searchlocatesearchcountyear AND searchlocatesearchcountyear < 0.5 => model1_attrsv4_tree_255_c1272,
    searchlocatesearchcountyear >= 0.5                                       => model1_attrsv4_tree_255_c1275,
    searchlocatesearchcountyear = NULL                                       => -0.00264157862814344,
                                                                                -0.00264157862814344);

model1_attrsv4_tree_256_c1280 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 25.5 => 0.00439789841337342,
    divaddrphonecount >= 25.5                             => 0.0341563629832369,
    divaddrphonecount = NULL                              => 0.00653457388286138,
                                                             0.00653457388286138);

model1_attrsv4_tree_256_c1279 := map(
    NULL < divssnidentitymsourcecount AND divssnidentitymsourcecount < 1.5 => model1_attrsv4_tree_256_c1280,
    divssnidentitymsourcecount >= 1.5                                      => -0.0144084213074643,
    divssnidentitymsourcecount = NULL                                      => 0.000244043833502761,
                                                                              0.000244043833502761);

model1_attrsv4_tree_256_c1278 := map(
    NULL < idveraddresssourcecount AND idveraddresssourcecount < 1.5 => -0.03565873661419,
    idveraddresssourcecount >= 1.5                                   => model1_attrsv4_tree_256_c1279,
    idveraddresssourcecount = NULL                                   => -0.00133714356118289,
                                                                        -0.00133714356118289);

model1_attrsv4_tree_256_c1277 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 3.5 => model1_attrsv4_tree_256_c1278,
    beta_synthidindex >= 3.5                             => -0.0218099656673128,
    beta_synthidindex = NULL                             => -0.00183417735836982,
                                                            -0.00183417735836982);

model1_attrsv4_tree_256 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 23.5 => model1_attrsv4_tree_256_c1277,
    divaddrphonemsourcecount >= 23.5                                    => -0.0347602338957768,
    divaddrphonemsourcecount = NULL                                     => -0.00277381246238544,
                                                                           -0.00277381246238544);

model1_attrsv4_tree_257_c1285 := map(
    NULL < searchbankingsearchcount AND searchbankingsearchcount < 1.5 => -0.00612655479311945,
    searchbankingsearchcount >= 1.5                                    => 0.0278969160406541,
    searchbankingsearchcount = NULL                                    => 0.00331608248673842,
                                                                          0.00331608248673842);

model1_attrsv4_tree_257_c1284 := map(
    NULL < assoccount AND assoccount < 12.5 => model1_attrsv4_tree_257_c1285,
    assoccount >= 12.5                      => 0.0490262349042229,
    assoccount = NULL                       => 0.0154462847463945,
                                               0.0154462847463945);

model1_attrsv4_tree_257_c1283 := map(
    NULL < sourcerisklevel AND sourcerisklevel < 5.5 => 0.00254504469512044,
    sourcerisklevel >= 5.5                           => model1_attrsv4_tree_257_c1284,
    sourcerisklevel = NULL                           => 0.00465095234215884,
                                                        0.00465095234215884);

model1_attrsv4_tree_257_c1282 := map(
    NULL < validationssnproblems AND validationssnproblems < 1.5 => model1_attrsv4_tree_257_c1283,
    validationssnproblems >= 1.5                                 => -0.0381975880086285,
    validationssnproblems = NULL                                 => 0.00214674767107328,
                                                                    0.00214674767107328);

model1_attrsv4_tree_257 := map(
    NULL < sbfeavgutilcard24m AND sbfeavgutilcard24m < 35.5 => model1_attrsv4_tree_257_c1282,
    sbfeavgutilcard24m >= 35.5                              => -0.0455437724127574,
    sbfeavgutilcard24m = NULL                               => -0.00031651268231326,
                                                               -0.00031651268231326);

model1_attrsv4_tree_258_c1290 := map(
    NULL < inputaddrassessedtotal AND inputaddrassessedtotal < 162262 => 0.0619099926472697,
    inputaddrassessedtotal >= 162262                                  => 0.0103593434305656,
    inputaddrassessedtotal = NULL                                     => 0.0338984526619374,
                                                                         0.0338984526619374);

model1_attrsv4_tree_258_c1289 := map(
    NULL < divrisklevel AND divrisklevel < 1.5 => 0.00685015515327821,
    divrisklevel >= 1.5                        => model1_attrsv4_tree_258_c1290,
    divrisklevel = NULL                        => 0.0126977140421196,
                                                  0.0126977140421196);

model1_attrsv4_tree_258_c1288 := map(
    NULL < divaddridentitymsourcecount AND divaddridentitymsourcecount < 30.5 => model1_attrsv4_tree_258_c1289,
    divaddridentitymsourcecount >= 30.5                                       => -0.0288779213552206,
    divaddridentitymsourcecount = NULL                                        => 0.00642477659742453,
                                                                                 0.00642477659742453);

model1_attrsv4_tree_258_c1287 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 7.5 => model1_attrsv4_tree_258_c1288,
    divaddrphonemsourcecount >= 7.5                                    => 0.0398364807894769,
    divaddrphonemsourcecount = NULL                                    => 0.00915121281325021,
                                                                          0.00915121281325021);

model1_attrsv4_tree_258 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 4.5 => -0.00907861745957448,
    searchaddrsearchcount >= 4.5                                 => model1_attrsv4_tree_258_c1287,
    searchaddrsearchcount = NULL                                 => -0.00349358219438598,
                                                                    -0.00349358219438598);

model1_attrsv4_tree_259_c1294 := map(
    NULL < assoccreditbureauonlycount AND assoccreditbureauonlycount < 0.5 => -0.0181898797246891,
    assoccreditbureauonlycount >= 0.5                                      => 0.0500041904634377,
    assoccreditbureauonlycount = NULL                                      => 0.000904459927986415,
                                                                              0.000904459927986415);

model1_attrsv4_tree_259_c1293 := map(
    NULL < idveraddresssourcecount AND idveraddresssourcecount < 4.5 => -0.0289810949258139,
    idveraddresssourcecount >= 4.5                                   => model1_attrsv4_tree_259_c1294,
    idveraddresssourcecount = NULL                                   => -0.0115787920218153,
                                                                        -0.0115787920218153);

model1_attrsv4_tree_259_c1295 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 7.5 => -0.000170765351762812,
    divaddrphonecount >= 7.5                             => 0.0237253465056064,
    divaddrphonecount = NULL                             => 0.00496387831894174,
                                                            0.00496387831894174);

model1_attrsv4_tree_259_c1292 := map(
    ((string)curraddrdwelltype in ['-1', 'F', 'H', 'M', 'P', 'R']) => model1_attrsv4_tree_259_c1293,
    ((string)curraddrdwelltype in ['', 'S', 'U'])                  => model1_attrsv4_tree_259_c1295,
    curraddrdwelltype = ''                               => 0.00233078892214305,
                                                              0.00233078892214305);

model1_attrsv4_tree_259 := map(
    NULL < prevaddrlenofres AND prevaddrlenofres < 3.5 => -0.0226273247350865,
    prevaddrlenofres >= 3.5                            => model1_attrsv4_tree_259_c1292,
    prevaddrlenofres = NULL                            => 0.00118883749537358,
                                                          0.00118883749537358);

model1_attrsv4_tree_260_c1298 := map(
    NULL < sourcecreditbureauagechange AND sourcecreditbureauagechange < 25.5 => -0.0169580157034145,
    sourcecreditbureauagechange >= 25.5                                       => 0.00973399756547423,
    sourcecreditbureauagechange = NULL                                        => -0.00340534718954515,
                                                                                 -0.00340534718954515);

model1_attrsv4_tree_260_c1297 := map(
    NULL < correlationrisklevel AND correlationrisklevel < 8.5 => model1_attrsv4_tree_260_c1298,
    correlationrisklevel >= 8.5                                => -0.0380426586700031,
    correlationrisklevel = NULL                                => -0.00535036544960163,
                                                                  -0.00535036544960163);

model1_attrsv4_tree_260_c1300 := map(
    NULL < identitysourcecount AND identitysourcecount < 9.5 => 0.0439819767696062,
    identitysourcecount >= 9.5                               => 0.00483115595563861,
    identitysourcecount = NULL                               => 0.0259627705372362,
                                                                0.0259627705372362);

model1_attrsv4_tree_260_c1299 := map(
    NULL < sbfetimeoldestcycle AND sbfetimeoldestcycle < 10 => model1_attrsv4_tree_260_c1300,
    sbfetimeoldestcycle >= 10                               => -0.0270486582961321,
    sbfetimeoldestcycle = NULL                              => 0.0102152578543827,
                                                               0.0102152578543827);

model1_attrsv4_tree_260 := map(
    NULL < beta_srch_ssn_id_diff01 AND beta_srch_ssn_id_diff01 < 0.5 => model1_attrsv4_tree_260_c1297,
    beta_srch_ssn_id_diff01 >= 0.5                                   => model1_attrsv4_tree_260_c1299,
    beta_srch_ssn_id_diff01 = NULL                                   => -0.00410217867522553,
                                                                        -0.00410217867522553);

model1_attrsv4_tree_261_c1303 := map(
    NULL < variationdobcount AND variationdobcount < 1.5 => -0.016335929214071,
    variationdobcount >= 1.5                             => 0.0879255280554279,
    variationdobcount = NULL                             => 0.0209511978731985,
                                                            0.0209511978731985);

model1_attrsv4_tree_261_c1302 := map(
    NULL < divaddrphonecount AND divaddrphonecount < 15.5 => model1_attrsv4_tree_261_c1303,
    divaddrphonecount >= 15.5                             => 0.0552689395453439,
    divaddrphonecount = NULL                              => 0.0275240250074584,
                                                             0.0275240250074584);

model1_attrsv4_tree_261_c1305 := map(
    NULL < sbfeavgutil12m AND sbfeavgutil12m < 47.5 => -0.0088633774027831,
    sbfeavgutil12m >= 47.5                          => 0.0545851740374202,
    sbfeavgutil12m = NULL                           => -0.00706596801354221,
                                                       -0.00706596801354221);

model1_attrsv4_tree_261_c1304 := map(
    NULL < divaddrssncountnew AND divaddrssncountnew < 2.5 => model1_attrsv4_tree_261_c1305,
    divaddrssncountnew >= 2.5                              => 0.0258022351079084,
    divaddrssncountnew = NULL                              => -0.00558125340134793,
                                                              -0.00558125340134793);

model1_attrsv4_tree_261 := map(
    NULL < beta_srch_corrdobphone AND beta_srch_corrdobphone < -2.5 => model1_attrsv4_tree_261_c1302,
    beta_srch_corrdobphone >= -2.5                                  => model1_attrsv4_tree_261_c1304,
    beta_srch_corrdobphone = NULL                                   => -0.00134159156738995,
                                                                       -0.00134159156738995);

model1_attrsv4_tree_262_c1309 := map(
    ((string)curraddrstatus in ['O', 'R'])      => 0.00339305355085368,
    ((string)curraddrstatus in ['', '-1', 'U']) => 0.0519254709208445,
    curraddrstatus = ''               => 0.0239606951128572,
                                           0.0239606951128572);

model1_attrsv4_tree_262_c1310 := map(
    NULL < identitysourcecount AND identitysourcecount < 4.5 => -0.0235039014005602,
    identitysourcecount >= 4.5                               => 0.00678671973330178,
    identitysourcecount = NULL                               => 0.0047995996931454,
                                                                0.0047995996931454);

model1_attrsv4_tree_262_c1308 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 10.5 => model1_attrsv4_tree_262_c1309,
    curraddrageoldest >= 10.5                             => model1_attrsv4_tree_262_c1310,
    curraddrageoldest = NULL                              => 0.00616498636013944,
                                                             0.00616498636013944);

model1_attrsv4_tree_262_c1307 := map(
    NULL < beta_cpnindex AND beta_cpnindex < 3.5 => model1_attrsv4_tree_262_c1308,
    beta_cpnindex >= 3.5                         => -0.0216468382991788,
    beta_cpnindex = NULL                         => 0.00378669805957273,
                                                    0.00378669805957273);

model1_attrsv4_tree_262 := map(
    NULL < identityageoldest AND identityageoldest < 24.5 => 0.034280926059161,
    identityageoldest >= 24.5                             => model1_attrsv4_tree_262_c1307,
    identityageoldest = NULL                              => 0.00459220596899582,
                                                             0.00459220596899582);

model1_attrsv4_tree_263_c1315 := map(
    NULL < sourcepublicrecordcount AND sourcepublicrecordcount < 7.5 => -0.00157264270390799,
    sourcepublicrecordcount >= 7.5                                   => -0.0446494965053332,
    sourcepublicrecordcount = NULL                                   => -0.00340811096162259,
                                                                        -0.00340811096162259);

model1_attrsv4_tree_263_c1314 := map(
    NULL < sbfepaymentduecardamt AND sbfepaymentduecardamt < 147.5 => model1_attrsv4_tree_263_c1315,
    sbfepaymentduecardamt >= 147.5                                 => 0.0697003605624673,
    sbfepaymentduecardamt = NULL                                   => -0.00153449559708927,
                                                                      -0.00153449559708927);

model1_attrsv4_tree_263_c1313 := map(
    NULL < sbfeavgutilcard36m AND sbfeavgutilcard36m < 35.5 => model1_attrsv4_tree_263_c1314,
    sbfeavgutilcard36m >= 35.5                              => -0.0539925980964013,
    sbfeavgutilcard36m = NULL                               => -0.00328872988923867,
                                                               -0.00328872988923867);

model1_attrsv4_tree_263_c1312 := map(
    NULL < divaddridentitycount AND divaddridentitycount < 1.5 => 0.0387918133478459,
    divaddridentitycount >= 1.5                                => model1_attrsv4_tree_263_c1313,
    divaddridentitycount = NULL                                => -0.00227155456322744,
                                                                  -0.00227155456322744);

model1_attrsv4_tree_263 := map(
    NULL < sbfeavgutil84m AND sbfeavgutil84m < 62.5 => model1_attrsv4_tree_263_c1312,
    sbfeavgutil84m >= 62.5                          => 0.0436209858126444,
    sbfeavgutil84m = NULL                           => -0.00115671219088905,
                                                       -0.00115671219088905);

model1_attrsv4_tree_264_c1320 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 5.5 => -0.0245799809575866,
    businessrecordtimeoldest >= 5.5                                    => -0.00437521243051031,
    businessrecordtimeoldest = NULL                                    => -0.00967301158554757,
                                                                          -0.00967301158554757);

model1_attrsv4_tree_264_c1319 := map(
    NULL < beta_rel_count_for_bureau_only AND beta_rel_count_for_bureau_only < 1.5 => model1_attrsv4_tree_264_c1320,
    beta_rel_count_for_bureau_only >= 1.5                                          => 0.0210961691104852,
    beta_rel_count_for_bureau_only = NULL                                          => -0.0084183942055317,
                                                                                      -0.0084183942055317);

model1_attrsv4_tree_264_c1318 := map(
    NULL < variationsearchssncount AND variationsearchssncount < 0.5 => 0.016602977184146,
    variationsearchssncount >= 0.5                                   => model1_attrsv4_tree_264_c1319,
    variationsearchssncount = NULL                                   => 0.00102671758820943,
                                                                        0.00102671758820943);

model1_attrsv4_tree_264_c1317 := map(
    NULL < componentcharrisklevel AND componentcharrisklevel < 6.5 => model1_attrsv4_tree_264_c1318,
    componentcharrisklevel >= 6.5                                  => -0.0277312929195063,
    componentcharrisklevel = NULL                                  => -0.0000649186907343228,
                                                                      -0.0000649186907343228);

model1_attrsv4_tree_264 := map(
    NULL < prevaddragenewest AND prevaddragenewest < 6.5 => model1_attrsv4_tree_264_c1317,
    prevaddragenewest >= 6.5                             => -0.0447677067353381,
    prevaddragenewest = NULL                             => -0.00116140217107366,
                                                            -0.00116140217107366);

model1_attrsv4_tree_265_c1323 := map(
    NULL < idverrisklevel AND idverrisklevel < 2.5 => -0.00759004440440913,
    idverrisklevel >= 2.5                          => -0.0501677660869863,
    idverrisklevel = NULL                          => -0.01924823010321,
                                                      -0.01924823010321);

model1_attrsv4_tree_265_c1324 := map(
    NULL < verificationbusinputname AND verificationbusinputname < -0.5 => 0.0136429549844906,
    verificationbusinputname >= -0.5                                    => -0.00704705731455455,
    verificationbusinputname = NULL                                     => -0.00371519164275415,
                                                                           -0.00371519164275415);

model1_attrsv4_tree_265_c1322 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 79.5 => model1_attrsv4_tree_265_c1323,
    sourcecreditbureauageoldest >= 79.5                                       => model1_attrsv4_tree_265_c1324,
    sourcecreditbureauageoldest = NULL                                        => -0.00546141116989319,
                                                                                 -0.00546141116989319);

model1_attrsv4_tree_265_c1325 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 12.5 => 0.0441529327594089,
    businessrecordtimeoldest >= 12.5                                    => -0.00104582697063109,
    businessrecordtimeoldest = NULL                                     => 0.014110106351545,
                                                                           0.014110106351545);

model1_attrsv4_tree_265 := map(
    NULL < assochighrisktopologycount AND assochighrisktopologycount < 0.5 => model1_attrsv4_tree_265_c1322,
    assochighrisktopologycount >= 0.5                                      => model1_attrsv4_tree_265_c1325,
    assochighrisktopologycount = NULL                                      => -0.00313498550225054,
                                                                              -0.00313498550225054);

model1_attrsv4_tree_266_c1328 := map(
    NULL < businessrecordtimenewest AND businessrecordtimenewest < 2.5 => -0.0195540650369609,
    businessrecordtimenewest >= 2.5                                    => 0.0275599137235405,
    businessrecordtimenewest = NULL                                    => -0.0111021027865922,
                                                                          -0.0111021027865922);

model1_attrsv4_tree_266_c1330 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 2.5 => 0.00495906797859811,
    divaddrphonemsourcecount >= 2.5                                    => 0.0456932120235813,
    divaddrphonemsourcecount = NULL                                    => 0.0249000506282342,
                                                                          0.0249000506282342);

model1_attrsv4_tree_266_c1329 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < -1 => model1_attrsv4_tree_266_c1330,
    beta_m_src_credentialed_fs >= -1                                      => 0.00282944971627222,
    beta_m_src_credentialed_fs = NULL                                     => 0.00443129411893208,
                                                                             0.00443129411893208);

model1_attrsv4_tree_266_c1327 := map(
    NULL < correlationaddrnamecount AND correlationaddrnamecount < 3.5 => model1_attrsv4_tree_266_c1328,
    correlationaddrnamecount >= 3.5                                    => model1_attrsv4_tree_266_c1329,
    correlationaddrnamecount = NULL                                    => 0.00131933383552811,
                                                                          0.00131933383552811);

model1_attrsv4_tree_266 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 2.5 => 0.0246205935945565,
    prevaddrageoldest >= 2.5                             => model1_attrsv4_tree_266_c1327,
    prevaddrageoldest = NULL                             => 0.00198979461161336,
                                                            0.00198979461161336);

model1_attrsv4_tree_267_c1332 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 165 => -0.0440743745954844,
    sourcecreditbureauageoldest >= 165                                       => -0.00775434111513645,
    sourcecreditbureauageoldest = NULL                                       => -0.022578844576503,
                                                                                -0.022578844576503);

model1_attrsv4_tree_267_c1335 := map(
    NULL < sourceproperty AND sourceproperty < 0.5 => 0.0162010205411489,
    sourceproperty >= 0.5                          => -0.0124002561661077,
    sourceproperty = NULL                          => -0.00440102136345799,
                                                      -0.00440102136345799);

model1_attrsv4_tree_267_c1334 := map(
    NULL < divaddrphonemsourcecount AND divaddrphonemsourcecount < 5.5 => model1_attrsv4_tree_267_c1335,
    divaddrphonemsourcecount >= 5.5                                    => -0.0184287991744294,
    divaddrphonemsourcecount = NULL                                    => -0.00618387634175365,
                                                                          -0.00618387634175365);

model1_attrsv4_tree_267_c1333 := map(
    NULL < searchcountmonth AND searchcountmonth < 1.5 => model1_attrsv4_tree_267_c1334,
    searchcountmonth >= 1.5                            => -0.0340015255070032,
    searchcountmonth = NULL                            => -0.00699159781939294,
                                                          -0.00699159781939294);

model1_attrsv4_tree_267 := map(
    NULL < inputaddrlenofres AND inputaddrlenofres < 1.5 => model1_attrsv4_tree_267_c1332,
    inputaddrlenofres >= 1.5                             => model1_attrsv4_tree_267_c1333,
    inputaddrlenofres = NULL                             => -0.00789227599285802,
                                                            -0.00789227599285802);

model1_attrsv4_tree_268_c1339 := map(
    NULL < searchbankingsearchcount AND searchbankingsearchcount < 0.5 => 0.0641439407013312,
    searchbankingsearchcount >= 0.5                                    => 0.00701258827056071,
    searchbankingsearchcount = NULL                                    => 0.0254861992361991,
                                                                          0.0254861992361991);

model1_attrsv4_tree_268_c1338 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 0.5 => 0.00060712064597608,
    beta_srch_perphone_count03 >= 0.5                                      => model1_attrsv4_tree_268_c1339,
    beta_srch_perphone_count03 = NULL                                      => 0.00346069628098105,
                                                                              0.00346069628098105);

model1_attrsv4_tree_268_c1340 := map(
    NULL < correlationaddrnamecount AND correlationaddrnamecount < 5.5 => -0.0283489237584727,
    correlationaddrnamecount >= 5.5                                    => -0.000962997625035224,
    correlationaddrnamecount = NULL                                    => -0.0102403146213789,
                                                                          -0.0102403146213789);

model1_attrsv4_tree_268_c1337 := map(
    NULL < searchcount AND searchcount < 8.5 => model1_attrsv4_tree_268_c1338,
    searchcount >= 8.5                       => model1_attrsv4_tree_268_c1340,
    searchcount = NULL                       => -0.000603275068801071,
                                                -0.000603275068801071);

model1_attrsv4_tree_268 := map(
    NULL < divaddrsuspidentitycountnew AND divaddrsuspidentitycountnew < 2.5 => model1_attrsv4_tree_268_c1337,
    divaddrsuspidentitycountnew >= 2.5                                       => 0.0406360483927129,
    divaddrsuspidentitycountnew = NULL                                       => 0.000369350484536523,
                                                                                0.000369350484536523);

model1_attrsv4_tree_269_c1345 := map(
    NULL < beta_srch_perphone_count03 AND beta_srch_perphone_count03 < 1.5 => -0.0040457174669129,
    beta_srch_perphone_count03 >= 1.5                                      => 0.0206888824238776,
    beta_srch_perphone_count03 = NULL                                      => -0.00278652824948951,
                                                                              -0.00278652824948951);

model1_attrsv4_tree_269_c1344 := map(
    NULL < identityrecordcount AND identityrecordcount < 146.5 => model1_attrsv4_tree_269_c1345,
    identityrecordcount >= 146.5                               => -0.0467419926080323,
    identityrecordcount = NULL                                 => -0.00650039959076731,
                                                                  -0.00650039959076731);

model1_attrsv4_tree_269_c1343 := map(
    NULL < beta_srch_dobsperid_count01 AND beta_srch_dobsperid_count01 < 0.5 => model1_attrsv4_tree_269_c1344,
    beta_srch_dobsperid_count01 >= 0.5                                       => 0.0216918406404624,
    beta_srch_dobsperid_count01 = NULL                                       => -0.00534353034970535,
                                                                                -0.00534353034970535);

model1_attrsv4_tree_269_c1342 := map(
    NULL < beta_sum_src_credentialed AND beta_sum_src_credentialed < 6.5 => model1_attrsv4_tree_269_c1343,
    beta_sum_src_credentialed >= 6.5                                     => 0.0747926326542182,
    beta_sum_src_credentialed = NULL                                     => -0.00232028476354123,
                                                                            -0.00232028476354123);

model1_attrsv4_tree_269 := map(
    NULL < beta_input_lname_isbestmatch AND beta_input_lname_isbestmatch < 0.5 => -0.035402203316695,
    beta_input_lname_isbestmatch >= 0.5                                        => model1_attrsv4_tree_269_c1342,
    beta_input_lname_isbestmatch = NULL                                        => -0.00438010233383194,
                                                                                  -0.00438010233383194);

model1_attrsv4_tree_270_c1349 := map(
    NULL < sourcecreditbureauageoldest AND sourcecreditbureauageoldest < 21.5 => 0.0351291404455123,
    sourcecreditbureauageoldest >= 21.5                                       => 0.00404809071021148,
    sourcecreditbureauageoldest = NULL                                        => 0.00527003933740704,
                                                                                 0.00527003933740704);

model1_attrsv4_tree_270_c1350 := map(
    NULL < divaddrssncount AND divaddrssncount < 45.5 => 0.0776284765322649,
    divaddrssncount >= 45.5                           => -0.00440259352275857,
    divaddrssncount = NULL                            => 0.0360660677043863,
                                                         0.0360660677043863);

model1_attrsv4_tree_270_c1348 := map(
    NULL < divaddrssncount AND divaddrssncount < 36.5 => model1_attrsv4_tree_270_c1349,
    divaddrssncount >= 36.5                           => model1_attrsv4_tree_270_c1350,
    divaddrssncount = NULL                            => 0.00775003446359542,
                                                         0.00775003446359542);

model1_attrsv4_tree_270_c1347 := map(
    NULL < curraddrageoldest AND curraddrageoldest < 145.5 => model1_attrsv4_tree_270_c1348,
    curraddrageoldest >= 145.5                             => -0.0230028232871677,
    curraddrageoldest = NULL                               => -0.00221320689335397,
                                                              -0.00221320689335397);

model1_attrsv4_tree_270 := map(
    NULL < searchvelocityrisklevel AND searchvelocityrisklevel < 6.5 => model1_attrsv4_tree_270_c1347,
    searchvelocityrisklevel >= 6.5                                   => 0.0417940642797682,
    searchvelocityrisklevel = NULL                                   => -0.00110264604063603,
                                                                        -0.00110264604063603);

model1_attrsv4_tree_271_c1354 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 9.5 => -0.0160874592347957,
    businessrecordtimeoldest >= 9.5                                    => 0.000796219786257395,
    businessrecordtimeoldest = NULL                                    => -0.00442154336599789,
                                                                          -0.00442154336599789);

model1_attrsv4_tree_271_c1355 := map(
    NULL < divphoneaddrcount AND divphoneaddrcount < 0.5 => 0.0302116733734327,
    divphoneaddrcount >= 0.5                             => -0.0112278267322346,
    divphoneaddrcount = NULL                             => 0.00971961288161922,
                                                            0.00971961288161922);

model1_attrsv4_tree_271_c1353 := map(
    NULL < beta_bureau_only_index AND beta_bureau_only_index < 2.5 => model1_attrsv4_tree_271_c1354,
    beta_bureau_only_index >= 2.5                                  => model1_attrsv4_tree_271_c1355,
    beta_bureau_only_index = NULL                                  => -0.00345107185880848,
                                                                      -0.00345107185880848);

model1_attrsv4_tree_271_c1352 := map(
    NULL < beta_sum_src_credentialed AND beta_sum_src_credentialed < 6.5 => model1_attrsv4_tree_271_c1353,
    beta_sum_src_credentialed >= 6.5                                     => 0.0763521818359594,
    beta_sum_src_credentialed = NULL                                     => -0.000737993782735751,
                                                                            -0.000737993782735751);

model1_attrsv4_tree_271 := map(
    NULL < beta_srch_corrnamephonessn_id AND beta_srch_corrnamephonessn_id < 2.5 => model1_attrsv4_tree_271_c1352,
    beta_srch_corrnamephonessn_id >= 2.5                                         => 0.0402878618455631,
    beta_srch_corrnamephonessn_id = NULL                                         => 0.000442467157512471,
                                                                                    0.000442467157512471);

model1_attrsv4_tree_272_c1359 := map(
    NULL < divaddridentitycountnew AND divaddridentitycountnew < 0.5 => 0.045620284192692,
    divaddridentitycountnew >= 0.5                                   => 0.0031430355884817,
    divaddridentitycountnew = NULL                                   => 0.0249884777277898,
                                                                        0.0249884777277898);

model1_attrsv4_tree_272_c1358 := map(
    NULL < beta_m_src_credentialed_fs AND beta_m_src_credentialed_fs < 10.5 => model1_attrsv4_tree_272_c1359,
    beta_m_src_credentialed_fs >= 10.5                                      => 0.00295493069981632,
    beta_m_src_credentialed_fs = NULL                                       => 0.00510529429961855,
                                                                               0.00510529429961855);

model1_attrsv4_tree_272_c1360 := map(
    NULL < beta_source_type AND beta_source_type < 6 => -0.0294052411653022,
    beta_source_type >= 6                            => 0.0043781409985596,
    beta_source_type = NULL                          => -0.00936705860732534,
                                                        -0.00936705860732534);

model1_attrsv4_tree_272_c1357 := map(
    NULL < divaddridentitymsourcecount AND divaddridentitymsourcecount < 18.5 => model1_attrsv4_tree_272_c1358,
    divaddridentitymsourcecount >= 18.5                                       => model1_attrsv4_tree_272_c1360,
    divaddridentitymsourcecount = NULL                                        => 0.000777378355787785,
                                                                                 0.000777378355787785);

model1_attrsv4_tree_272 := map(
    NULL < searchlocatesearchcount AND searchlocatesearchcount < 4.5 => model1_attrsv4_tree_272_c1357,
    searchlocatesearchcount >= 4.5                                   => -0.0380308677476099,
    searchlocatesearchcount = NULL                                   => -0.000568096214306429,
                                                                        -0.000568096214306429);

model1_attrsv4_tree_273_c1364 := map(
    NULL < assoccount AND assoccount < 14.5 => 0.00467144242657314,
    assoccount >= 14.5                      => -0.0235955901295784,
    assoccount = NULL                       => -0.00399547060808722,
                                               -0.00399547060808722);

model1_attrsv4_tree_273_c1363 := map(
    NULL < associatebankruptcount AND associatebankruptcount < 0.5 => model1_attrsv4_tree_273_c1364,
    associatebankruptcount >= 0.5                                  => 0.0489464472871537,
    associatebankruptcount = NULL                                  => -0.00113919449187301,
                                                                      -0.00113919449187301);

model1_attrsv4_tree_273_c1365 := map(
    NULL < searchaddrsearchcount AND searchaddrsearchcount < 4.5 => -0.00426301117815944,
    searchaddrsearchcount >= 4.5                                 => 0.0496571983163672,
    searchaddrsearchcount = NULL                                 => 0.0213711867782549,
                                                                    0.0213711867782549);

model1_attrsv4_tree_273_c1362 := map(
    NULL < divaddridentitymsourcecount AND divaddridentitymsourcecount < 29.5 => model1_attrsv4_tree_273_c1363,
    divaddridentitymsourcecount >= 29.5                                       => model1_attrsv4_tree_273_c1365,
    divaddridentitymsourcecount = NULL                                        => 0.00120337006452926,
                                                                                 0.00120337006452926);

model1_attrsv4_tree_273 := map(
    NULL < divssnaddrcount AND divssnaddrcount < 4.5 => -0.0286514030494032,
    divssnaddrcount >= 4.5                           => model1_attrsv4_tree_273_c1362,
    divssnaddrcount = NULL                           => -0.00388743204900214,
                                                        -0.00388743204900214);

model1_attrsv4_tree_274_c1368 := map(
    NULL < beta_srch_corrdobaddr_id AND beta_srch_corrdobaddr_id < 0.5 => -0.00745965294992053,
    beta_srch_corrdobaddr_id >= 0.5                                    => 0.0524932746514189,
    beta_srch_corrdobaddr_id = NULL                                    => 0.00238214091076447,
                                                                          0.00238214091076447);

model1_attrsv4_tree_274_c1367 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 20.5 => model1_attrsv4_tree_274_c1368,
    divaddrssnmsourcecount >= 20.5                                  => 0.0550813639125999,
    divaddrssnmsourcecount = NULL                                   => 0.0112552751590826,
                                                                       0.0112552751590826);

model1_attrsv4_tree_274_c1370 := map(
    NULL < beta_srch_corrdobssn AND beta_srch_corrdobssn < -0.5 => -0.00946215211011987,
    beta_srch_corrdobssn >= -0.5                                => -0.0477364463854741,
    beta_srch_corrdobssn = NULL                                 => -0.0228954698780715,
                                                                   -0.0228954698780715);

model1_attrsv4_tree_274_c1369 := map(
    NULL < prevaddrlenofres AND prevaddrlenofres < 14.5 => model1_attrsv4_tree_274_c1370,
    prevaddrlenofres >= 14.5                            => 0.00321467923212716,
    prevaddrlenofres = NULL                             => 0.000425764167991095,
                                                           0.000425764167991095);

model1_attrsv4_tree_274 := map(
    NULL < idveraddressnotcurrent AND idveraddressnotcurrent < 1.5 => model1_attrsv4_tree_274_c1367,
    idveraddressnotcurrent >= 1.5                                  => model1_attrsv4_tree_274_c1369,
    idveraddressnotcurrent = NULL                                  => 0.002670844394682,
                                                                      0.002670844394682);

model1_attrsv4_tree_275_c1375 := map(
    NULL < divaddrssnmsourcecount AND divaddrssnmsourcecount < 33.5 => 0.0101357794005416,
    divaddrssnmsourcecount >= 33.5                                  => 0.0507517884194384,
    divaddrssnmsourcecount = NULL                                   => 0.0119612180081325,
                                                                       0.0119612180081325);

model1_attrsv4_tree_275_c1374 := map(
    NULL < idveraddresssourcecount AND idveraddresssourcecount < 1.5 => -0.038573935672825,
    idveraddresssourcecount >= 1.5                                   => model1_attrsv4_tree_275_c1375,
    idveraddresssourcecount = NULL                                   => 0.00937126548245817,
                                                                        0.00937126548245817);

model1_attrsv4_tree_275_c1373 := map(
    NULL < sbfetimenewestcycle AND sbfetimenewestcycle < 2.5 => model1_attrsv4_tree_275_c1374,
    sbfetimenewestcycle >= 2.5                               => 0.0617938929706475,
    sbfetimenewestcycle = NULL                               => 0.0116531916201794,
                                                                0.0116531916201794);

model1_attrsv4_tree_275_c1372 := map(
    NULL < businessrecordtimeoldest AND businessrecordtimeoldest < 70.5 => model1_attrsv4_tree_275_c1373,
    businessrecordtimeoldest >= 70.5                                    => -0.0173749385717313,
    businessrecordtimeoldest = NULL                                     => 0.000569723728722541,
                                                                           0.000569723728722541);

model1_attrsv4_tree_275 := map(
    NULL < beta_synthidindex AND beta_synthidindex < 3.5 => model1_attrsv4_tree_275_c1372,
    beta_synthidindex >= 3.5                             => -0.0192564564036878,
    beta_synthidindex = NULL                             => 0.0000319853524897122,
                                                            0.0000319853524897122);

model1_attrsv4_tree_276_c1380 := map(
    NULL < assoccount AND assoccount < 11.5 => -0.00805730266178456,
    assoccount >= 11.5                      => 0.0712353936961058,
    assoccount = NULL                       => 0.0267485030069406,
                                               0.0267485030069406);

model1_attrsv4_tree_276_c1379 := map(
    NULL < inquiry03month AND inquiry03month < 0.5 => -0.00886155299664394,
    inquiry03month >= 0.5                          => model1_attrsv4_tree_276_c1380,
    inquiry03month = NULL                          => -0.00518622768454281,
                                                      -0.00518622768454281);

model1_attrsv4_tree_276_c1378 := map(
    NULL < identityrecordcount AND identityrecordcount < 10.5 => 0.0378646505336504,
    identityrecordcount >= 10.5                               => model1_attrsv4_tree_276_c1379,
    identityrecordcount = NULL                                => -0.00379869937960104,
                                                                 -0.00379869937960104);

model1_attrsv4_tree_276_c1377 := map(
    NULL < divrisklevel AND divrisklevel < 1.5 => model1_attrsv4_tree_276_c1378,
    divrisklevel >= 1.5                        => -0.024369895553582,
    divrisklevel = NULL                        => -0.00717814606967265,
                                                  -0.00717814606967265);

model1_attrsv4_tree_276 := map(
    NULL < searchaddrsearchcountyear AND searchaddrsearchcountyear < 5.5 => model1_attrsv4_tree_276_c1377,
    searchaddrsearchcountyear >= 5.5                                     => 0.0351192962551407,
    searchaddrsearchcountyear = NULL                                     => -0.00599102445725454,
                                                                            -0.00599102445725454);

model1_attrsv4_tree_277_c1385 := map(
    NULL < divssnaddrmsourcecount AND divssnaddrmsourcecount < 7.5 => 0.00576017989614657,
    divssnaddrmsourcecount >= 7.5                                  => 0.0787040959481931,
    divssnaddrmsourcecount = NULL                                  => 0.0367015541231417,
                                                                      0.0367015541231417);

model1_attrsv4_tree_277_c1384 := map(
    NULL < sourceproperty AND sourceproperty < 0.5 => model1_attrsv4_tree_277_c1385,
    sourceproperty >= 0.5                          => 0.00941742642589484,
    sourceproperty = NULL                          => 0.0161761342006443,
                                                      0.0161761342006443);

model1_attrsv4_tree_277_c1383 := map(
    NULL < curraddractivephonelist AND curraddractivephonelist < 0.5 => -0.00541651912256854,
    curraddractivephonelist >= 0.5                                   => model1_attrsv4_tree_277_c1384,
    curraddractivephonelist = NULL                                   => 0.00556374082754229,
                                                                        0.00556374082754229);

model1_attrsv4_tree_277_c1382 := map(
    NULL < inputaddrageoldest AND inputaddrageoldest < 1.5 => 0.020387008487294,
    inputaddrageoldest >= 1.5                              => model1_attrsv4_tree_277_c1383,
    inputaddrageoldest = NULL                              => 0.00621141260630705,
                                                              0.00621141260630705);

model1_attrsv4_tree_277 := map(
    NULL < validationphoneproblems AND validationphoneproblems < 4.5 => model1_attrsv4_tree_277_c1382,
    validationphoneproblems >= 4.5                                   => -0.0521294283001414,
    validationphoneproblems = NULL                                   => 0.00361084210363753,
                                                                        0.00361084210363753);

model1_attrsv4_tree_278_c1387 := map(
    NULL < correlationrisklevel AND correlationrisklevel < 7.5 => -0.0270368441587854,
    correlationrisklevel >= 7.5                                => 0.0446059378427846,
    correlationrisklevel = NULL                                => 0.00770836771322063,
                                                                  0.00770836771322063);

model1_attrsv4_tree_278_c1390 := map(
    NULL < beta_srch_corrdobphone AND beta_srch_corrdobphone < -2.5 => 0.0933198988119732,
    beta_srch_corrdobphone >= -2.5                                  => 0.0147264784563024,
    beta_srch_corrdobphone = NULL                                   => 0.0251559370816994,
                                                                       0.0251559370816994);

model1_attrsv4_tree_278_c1389 := map(
    NULL < sourceproperty AND sourceproperty < 0.5 => model1_attrsv4_tree_278_c1390,
    sourceproperty >= 0.5                          => -0.00602204428376426,
    sourceproperty = NULL                          => 0.00203250615163561,
                                                      0.00203250615163561);

model1_attrsv4_tree_278_c1388 := map(
    NULL < correlationrisklevel AND correlationrisklevel < 6.5 => model1_attrsv4_tree_278_c1389,
    correlationrisklevel >= 6.5                                => -0.0175905169220545,
    correlationrisklevel = NULL                                => -0.00159141126152404,
                                                                  -0.00159141126152404);

model1_attrsv4_tree_278 := map(
    NULL < prevaddrageoldest AND prevaddrageoldest < 5.5 => model1_attrsv4_tree_278_c1387,
    prevaddrageoldest >= 5.5                             => model1_attrsv4_tree_278_c1388,
    prevaddrageoldest = NULL                             => -0.00108036208673264,
                                                            -0.00108036208673264);

model1_attrsv4_tree_279_c1395 := map(
    NULL < searchbankingsearchcount AND searchbankingsearchcount < 1.5 => -0.0507312133040988,
    searchbankingsearchcount >= 1.5                                    => 0.00065122176398095,
    searchbankingsearchcount = NULL                                    => -0.0285163651393515,
                                                                          -0.0285163651393515);

model1_attrsv4_tree_279_c1394 := map(
    NULL < inputphonemobile AND inputphonemobile < 0.5 => model1_attrsv4_tree_279_c1395,
    inputphonemobile >= 0.5                            => -0.0095007393321449,
    inputphonemobile = NULL                            => -0.017382729235816,
                                                          -0.017382729235816);

model1_attrsv4_tree_279_c1393 := map(
    NULL < identityageoldest AND identityageoldest < 81.5 => 0.022019403699445,
    identityageoldest >= 81.5                             => model1_attrsv4_tree_279_c1394,
    identityageoldest = NULL                              => -0.00998388427352812,
                                                             -0.00998388427352812);

model1_attrsv4_tree_279_c1392 := map(
    NULL < correlationaddrnamecount AND correlationaddrnamecount < 3.5 => model1_attrsv4_tree_279_c1393,
    correlationaddrnamecount >= 3.5                                    => 0.00978427932188245,
    correlationaddrnamecount = NULL                                    => 0.00546284448198215,
                                                                          0.00546284448198215);

model1_attrsv4_tree_279 := map(
    NULL < beta_srch_ssnsperaddr_count03 AND beta_srch_ssnsperaddr_count03 < 1.5 => model1_attrsv4_tree_279_c1392,
    beta_srch_ssnsperaddr_count03 >= 1.5                                         => -0.0383068566068219,
    beta_srch_ssnsperaddr_count03 = NULL                                         => 0.00419311022869845,
                                                                                    0.00419311022869845);

model1_attrsv4_tree_280_c1400 := map(
    NULL < beta_source_type AND beta_source_type < 6 => -0.0142886767006366,
    beta_source_type >= 6                            => 0.00569391202153571,
    beta_source_type = NULL                          => 0.000175225111455155,
                                                        0.000175225111455155);

model1_attrsv4_tree_280_c1399 := map(
    NULL < sbfeavgutilever AND sbfeavgutilever < 55.5 => model1_attrsv4_tree_280_c1400,
    sbfeavgutilever >= 55.5                           => 0.0513763170583815,
    sbfeavgutilever = NULL                            => 0.00179654760791184,
                                                         0.00179654760791184);

model1_attrsv4_tree_280_c1398 := map(
    NULL < vulnerablevictimindex AND vulnerablevictimindex < 3.5 => model1_attrsv4_tree_280_c1399,
    vulnerablevictimindex >= 3.5                                 => 0.0427330143136956,
    vulnerablevictimindex = NULL                                 => 0.00339799977001486,
                                                                    0.00339799977001486);

model1_attrsv4_tree_280_c1397 := map(
    NULL < beta_srch_corrdobssn AND beta_srch_corrdobssn < 2.5 => model1_attrsv4_tree_280_c1398,
    beta_srch_corrdobssn >= 2.5                                => -0.0290515793026,
    beta_srch_corrdobssn = NULL                                => 0.00182684010202207,
                                                                  0.00182684010202207);

model1_attrsv4_tree_280 := map(
    NULL < identityageoldest AND identityageoldest < 28.5 => 0.0329460052288674,
    identityageoldest >= 28.5                             => model1_attrsv4_tree_280_c1397,
    identityageoldest = NULL                              => 0.00278096544789233,
                                                             0.00278096544789233);

model1_attrsv4_gbm_logit := model1_attrsv4_tree_0 +
    model1_attrsv4_tree_1 +
    model1_attrsv4_tree_2 +
    model1_attrsv4_tree_3 +
    model1_attrsv4_tree_4 +
    model1_attrsv4_tree_5 +
    model1_attrsv4_tree_6 +
    model1_attrsv4_tree_7 +
    model1_attrsv4_tree_8 +
    model1_attrsv4_tree_9 +
    model1_attrsv4_tree_10 +
    model1_attrsv4_tree_11 +
    model1_attrsv4_tree_12 +
    model1_attrsv4_tree_13 +
    model1_attrsv4_tree_14 +
    model1_attrsv4_tree_15 +
    model1_attrsv4_tree_16 +
    model1_attrsv4_tree_17 +
    model1_attrsv4_tree_18 +
    model1_attrsv4_tree_19 +
    model1_attrsv4_tree_20 +
    model1_attrsv4_tree_21 +
    model1_attrsv4_tree_22 +
    model1_attrsv4_tree_23 +
    model1_attrsv4_tree_24 +
    model1_attrsv4_tree_25 +
    model1_attrsv4_tree_26 +
    model1_attrsv4_tree_27 +
    model1_attrsv4_tree_28 +
    model1_attrsv4_tree_29 +
    model1_attrsv4_tree_30 +
    model1_attrsv4_tree_31 +
    model1_attrsv4_tree_32 +
    model1_attrsv4_tree_33 +
    model1_attrsv4_tree_34 +
    model1_attrsv4_tree_35 +
    model1_attrsv4_tree_36 +
    model1_attrsv4_tree_37 +
    model1_attrsv4_tree_38 +
    model1_attrsv4_tree_39 +
    model1_attrsv4_tree_40 +
    model1_attrsv4_tree_41 +
    model1_attrsv4_tree_42 +
    model1_attrsv4_tree_43 +
    model1_attrsv4_tree_44 +
    model1_attrsv4_tree_45 +
    model1_attrsv4_tree_46 +
    model1_attrsv4_tree_47 +
    model1_attrsv4_tree_48 +
    model1_attrsv4_tree_49 +
    model1_attrsv4_tree_50 +
    model1_attrsv4_tree_51 +
    model1_attrsv4_tree_52 +
    model1_attrsv4_tree_53 +
    model1_attrsv4_tree_54 +
    model1_attrsv4_tree_55 +
    model1_attrsv4_tree_56 +
    model1_attrsv4_tree_57 +
    model1_attrsv4_tree_58 +
    model1_attrsv4_tree_59 +
    model1_attrsv4_tree_60 +
    model1_attrsv4_tree_61 +
    model1_attrsv4_tree_62 +
    model1_attrsv4_tree_63 +
    model1_attrsv4_tree_64 +
    model1_attrsv4_tree_65 +
    model1_attrsv4_tree_66 +
    model1_attrsv4_tree_67 +
    model1_attrsv4_tree_68 +
    model1_attrsv4_tree_69 +
    model1_attrsv4_tree_70 +
    model1_attrsv4_tree_71 +
    model1_attrsv4_tree_72 +
    model1_attrsv4_tree_73 +
    model1_attrsv4_tree_74 +
    model1_attrsv4_tree_75 +
    model1_attrsv4_tree_76 +
    model1_attrsv4_tree_77 +
    model1_attrsv4_tree_78 +
    model1_attrsv4_tree_79 +
    model1_attrsv4_tree_80 +
    model1_attrsv4_tree_81 +
    model1_attrsv4_tree_82 +
    model1_attrsv4_tree_83 +
    model1_attrsv4_tree_84 +
    model1_attrsv4_tree_85 +
    model1_attrsv4_tree_86 +
    model1_attrsv4_tree_87 +
    model1_attrsv4_tree_88 +
    model1_attrsv4_tree_89 +
    model1_attrsv4_tree_90 +
    model1_attrsv4_tree_91 +
    model1_attrsv4_tree_92 +
    model1_attrsv4_tree_93 +
    model1_attrsv4_tree_94 +
    model1_attrsv4_tree_95 +
    model1_attrsv4_tree_96 +
    model1_attrsv4_tree_97 +
    model1_attrsv4_tree_98 +
    model1_attrsv4_tree_99 +
    model1_attrsv4_tree_100 +
    model1_attrsv4_tree_101 +
    model1_attrsv4_tree_102 +
    model1_attrsv4_tree_103 +
    model1_attrsv4_tree_104 +
    model1_attrsv4_tree_105 +
    model1_attrsv4_tree_106 +
    model1_attrsv4_tree_107 +
    model1_attrsv4_tree_108 +
    model1_attrsv4_tree_109 +
    model1_attrsv4_tree_110 +
    model1_attrsv4_tree_111 +
    model1_attrsv4_tree_112 +
    model1_attrsv4_tree_113 +
    model1_attrsv4_tree_114 +
    model1_attrsv4_tree_115 +
    model1_attrsv4_tree_116 +
    model1_attrsv4_tree_117 +
    model1_attrsv4_tree_118 +
    model1_attrsv4_tree_119 +
    model1_attrsv4_tree_120 +
    model1_attrsv4_tree_121 +
    model1_attrsv4_tree_122 +
    model1_attrsv4_tree_123 +
    model1_attrsv4_tree_124 +
    model1_attrsv4_tree_125 +
    model1_attrsv4_tree_126 +
    model1_attrsv4_tree_127 +
    model1_attrsv4_tree_128 +
    model1_attrsv4_tree_129 +
    model1_attrsv4_tree_130 +
    model1_attrsv4_tree_131 +
    model1_attrsv4_tree_132 +
    model1_attrsv4_tree_133 +
    model1_attrsv4_tree_134 +
    model1_attrsv4_tree_135 +
    model1_attrsv4_tree_136 +
    model1_attrsv4_tree_137 +
    model1_attrsv4_tree_138 +
    model1_attrsv4_tree_139 +
    model1_attrsv4_tree_140 +
    model1_attrsv4_tree_141 +
    model1_attrsv4_tree_142 +
    model1_attrsv4_tree_143 +
    model1_attrsv4_tree_144 +
    model1_attrsv4_tree_145 +
    model1_attrsv4_tree_146 +
    model1_attrsv4_tree_147 +
    model1_attrsv4_tree_148 +
    model1_attrsv4_tree_149 +
    model1_attrsv4_tree_150 +
    model1_attrsv4_tree_151 +
    model1_attrsv4_tree_152 +
    model1_attrsv4_tree_153 +
    model1_attrsv4_tree_154 +
    model1_attrsv4_tree_155 +
    model1_attrsv4_tree_156 +
    model1_attrsv4_tree_157 +
    model1_attrsv4_tree_158 +
    model1_attrsv4_tree_159 +
    model1_attrsv4_tree_160 +
    model1_attrsv4_tree_161 +
    model1_attrsv4_tree_162 +
    model1_attrsv4_tree_163 +
    model1_attrsv4_tree_164 +
    model1_attrsv4_tree_165 +
    model1_attrsv4_tree_166 +
    model1_attrsv4_tree_167 +
    model1_attrsv4_tree_168 +
    model1_attrsv4_tree_169 +
    model1_attrsv4_tree_170 +
    model1_attrsv4_tree_171 +
    model1_attrsv4_tree_172 +
    model1_attrsv4_tree_173 +
    model1_attrsv4_tree_174 +
    model1_attrsv4_tree_175 +
    model1_attrsv4_tree_176 +
    model1_attrsv4_tree_177 +
    model1_attrsv4_tree_178 +
    model1_attrsv4_tree_179 +
    model1_attrsv4_tree_180 +
    model1_attrsv4_tree_181 +
    model1_attrsv4_tree_182 +
    model1_attrsv4_tree_183 +
    model1_attrsv4_tree_184 +
    model1_attrsv4_tree_185 +
    model1_attrsv4_tree_186 +
    model1_attrsv4_tree_187 +
    model1_attrsv4_tree_188 +
    model1_attrsv4_tree_189 +
    model1_attrsv4_tree_190 +
    model1_attrsv4_tree_191 +
    model1_attrsv4_tree_192 +
    model1_attrsv4_tree_193 +
    model1_attrsv4_tree_194 +
    model1_attrsv4_tree_195 +
    model1_attrsv4_tree_196 +
    model1_attrsv4_tree_197 +
    model1_attrsv4_tree_198 +
    model1_attrsv4_tree_199 +
    model1_attrsv4_tree_200 +
    model1_attrsv4_tree_201 +
    model1_attrsv4_tree_202 +
    model1_attrsv4_tree_203 +
    model1_attrsv4_tree_204 +
    model1_attrsv4_tree_205 +
    model1_attrsv4_tree_206 +
    model1_attrsv4_tree_207 +
    model1_attrsv4_tree_208 +
    model1_attrsv4_tree_209 +
    model1_attrsv4_tree_210 +
    model1_attrsv4_tree_211 +
    model1_attrsv4_tree_212 +
    model1_attrsv4_tree_213 +
    model1_attrsv4_tree_214 +
    model1_attrsv4_tree_215 +
    model1_attrsv4_tree_216 +
    model1_attrsv4_tree_217 +
    model1_attrsv4_tree_218 +
    model1_attrsv4_tree_219 +
    model1_attrsv4_tree_220 +
    model1_attrsv4_tree_221 +
    model1_attrsv4_tree_222 +
    model1_attrsv4_tree_223 +
    model1_attrsv4_tree_224 +
    model1_attrsv4_tree_225 +
    model1_attrsv4_tree_226 +
    model1_attrsv4_tree_227 +
    model1_attrsv4_tree_228 +
    model1_attrsv4_tree_229 +
    model1_attrsv4_tree_230 +
    model1_attrsv4_tree_231 +
    model1_attrsv4_tree_232 +
    model1_attrsv4_tree_233 +
    model1_attrsv4_tree_234 +
    model1_attrsv4_tree_235 +
    model1_attrsv4_tree_236 +
    model1_attrsv4_tree_237 +
    model1_attrsv4_tree_238 +
    model1_attrsv4_tree_239 +
    model1_attrsv4_tree_240 +
    model1_attrsv4_tree_241 +
    model1_attrsv4_tree_242 +
    model1_attrsv4_tree_243 +
    model1_attrsv4_tree_244 +
    model1_attrsv4_tree_245 +
    model1_attrsv4_tree_246 +
    model1_attrsv4_tree_247 +
    model1_attrsv4_tree_248 +
    model1_attrsv4_tree_249 +
    model1_attrsv4_tree_250 +
    model1_attrsv4_tree_251 +
    model1_attrsv4_tree_252 +
    model1_attrsv4_tree_253 +
    model1_attrsv4_tree_254 +
    model1_attrsv4_tree_255 +
    model1_attrsv4_tree_256 +
    model1_attrsv4_tree_257 +
    model1_attrsv4_tree_258 +
    model1_attrsv4_tree_259 +
    model1_attrsv4_tree_260 +
    model1_attrsv4_tree_261 +
    model1_attrsv4_tree_262 +
    model1_attrsv4_tree_263 +
    model1_attrsv4_tree_264 +
    model1_attrsv4_tree_265 +
    model1_attrsv4_tree_266 +
    model1_attrsv4_tree_267 +
    model1_attrsv4_tree_268 +
    model1_attrsv4_tree_269 +
    model1_attrsv4_tree_270 +
    model1_attrsv4_tree_271 +
    model1_attrsv4_tree_272 +
    model1_attrsv4_tree_273 +
    model1_attrsv4_tree_274 +
    model1_attrsv4_tree_275 +
    model1_attrsv4_tree_276 +
    model1_attrsv4_tree_277 +
    model1_attrsv4_tree_278 +
    model1_attrsv4_tree_279 +
    model1_attrsv4_tree_280;

pbr := 0.01636919;

sbr := 0.05;

offset := ln(((1 - pbr) * sbr) / (pbr * (1 - sbr)));

base := 700;

pts := -50;

lgt := ln(pbr / (1 - pbr));

bbfm1811_1_0 := min(if(max(round(base + pts * (model1_attrsv4_gbm_logit - offset - lgt) / ln(2)), 300) = NULL, -NULL, max(round(base + pts * (model1_attrsv4_gbm_logit - offset - lgt) / ln(2)), 300)), 999);



 //*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//
 #if(MODEL_DEBUG) 
      self.seq := le.input.seq;  
      self.beta_synthidindex                :=beta_synthidindex              ;
			self.friendlyfraudindex               :=friendlyfraudindex             ;
			self.inputaddrlenofres                :=inputaddrlenofres              ;
			self.beta_srch_ssn_id_diff01          :=beta_srch_ssn_id_diff01        ;
			self.beta_srch_perbestssn             :=beta_srch_perbestssn           ;
			self.beta_srch_perphone_count01       :=beta_srch_perphone_count01     ;
			self.beta_m_src_credentialed_fs       :=beta_m_src_credentialed_fs     ;
			self.divaddrphonecount                :=divaddrphonecount              ;
			self.suspiciousactivityindex          :=suspiciousactivityindex        ;
			self.identityrisklevel                :=identityrisklevel              ;
			self.inputaddrassessedtotal           :=inputaddrassessedtotal         ;
			self.beta_srch_perphone_count03       :=beta_srch_perphone_count03     ;
			self.divssnaddrcount                  :=divssnaddrcount                ;
			self.beta_srch_perphone_count06       :=beta_srch_perphone_count06     ;
			self.searchbankingsearchcount         :=searchbankingsearchcount       ;
			self.beta_srch_phnsperid_1subs        :=beta_srch_phnsperid_1subs      ;
			self.beta_addr_bureau_only            :=beta_addr_bureau_only          ;
			self.beta_srch_corraddrssn_id         :=beta_srch_corraddrssn_id       ;
			self.sourcecreditbureauagechange      :=sourcecreditbureauagechange    ;
			self.correlationrisklevel             :=correlationrisklevel           ;
			self.beta_srch_ssnsperid_count03      :=beta_srch_ssnsperid_count03    ;
			self.sourcerisklevel                  :=sourcerisklevel                ;
			self.businessactivity06month          :=businessactivity06month        ;
			self.idverdob                         :=idverdob                       ;
			self.busexeclinkbusaddrauthrepowned   :=busexeclinkbusaddrauthrepowned ;
			self.divaddridentitycountnew          :=divaddridentitycountnew        ;
			self.beta_srch_dobsperssn_count01     :=beta_srch_dobsperssn_count01   ;
			self.sourcedriverslicense             :=sourcedriverslicense           ;
			self.inputaddrageoldest               :=inputaddrageoldest             ;
			self.divaddridentitycount             :=divaddridentitycount           ;
			self.beta_rel_count_for_bureau_only   :=beta_rel_count_for_bureau_only ;
			self.inputaddroccupantowned           :=inputaddroccupantowned         ;
			self.beta_srch_ssnsperaddr_count06    :=beta_srch_ssnsperaddr_count06  ;
			self.searchssnsearchcountyear         :=searchssnsearchcountyear       ;
			self.prevaddragenewest                :=prevaddragenewest              ;
			self.searchcount                      :=searchcount                    ;
			self.prevaddrstatus                   :=prevaddrstatus                 ;
			self.prevaddrageoldest                :=prevaddrageoldest              ;
			self.busaddrpersonnameoverlap         :=busaddrpersonnameoverlap       ;
			self.inputphoneproblems               :=inputphoneproblems             ;
			self.divaddridentitymsourcecount      :=divaddridentitymsourcecount    ;
			self.beta_srch_corrnameaddrssn        :=beta_srch_corrnameaddrssn      ;
			self.beta_srch_corrdobaddr            :=beta_srch_corrdobaddr          ;
			self.divssnlnamecount                 :=divssnlnamecount               ;
			self.businessrecordtimeoldest         :=businessrecordtimeoldest       ;
			self.beta_srch_addrsperssn_count01    :=beta_srch_addrsperssn_count01  ;
			self.vulnerablevictimindex            :=vulnerablevictimindex          ;
			self.beta_srch_addrsperid_count06     :=beta_srch_addrsperid_count06   ;
			self.searchlocatesearchcount          :=searchlocatesearchcount        ;
			self.searchbankingsearchcountyear     :=searchbankingsearchcountyear   ;
			self.divaddrphonemsourcecount         :=divaddrphonemsourcecount       ;
			self.associatejudgmentcount           :=associatejudgmentcount         ;
			self.inputaddrsqfootage               :=inputaddrsqfootage             ;
			self.sbfeavgutilever                  :=sbfeavgutilever                ;
			self.variationdobcountnew             :=variationdobcountnew           ;
			self.beta_srch_phonesperid_count01    :=beta_srch_phonesperid_count01  ;
			self.idverrisklevel                   :=idverrisklevel                 ;
			self.idverphone                       :=idverphone                     ;
			self.divsearchssnidentitycount        :=divsearchssnidentitycount      ;
			self.beta_srch_ssnsperaddr_count03    :=beta_srch_ssnsperaddr_count03  ;
			self.beta_m_src_other_fs              :=beta_m_src_other_fs            ;
			self.correlationphonelastnamecount    :=correlationphonelastnamecount  ;
			self.identityrecordcount              :=identityrecordcount            ;
			self.syntheticidentityindex           :=syntheticidentityindex         ;
			self.beta_srch_corraddrssn            :=beta_srch_corraddrssn          ;
			self.curraddrlenofres                 :=curraddrlenofres               ;
			self.sourceaccidents                  :=sourceaccidents                ;
			self.beta_corraddrdob                 :=beta_corraddrdob               ;
			self.divphoneidentitycount            :=divphoneidentitycount          ;
			self.sourcecreditbureauageoldest      :=sourcecreditbureauageoldest    ;
			self.associatebankruptcount           :=associatebankruptcount         ;
			self.assocsuspicousidentitiescount    :=assocsuspicousidentitiescount  ;
			self.beta_srch_idsperphone            :=beta_srch_idsperphone          ;
			self.validationssnproblems            :=validationssnproblems          ;
			self.divaddrssncountnew               :=divaddrssncountnew             ;
			self.businessactivity12month          :=businessactivity12month        ;
			self.idveraddressassoccount           :=idveraddressassoccount         ;
			self.beta_srch_addrsperid_count01     :=beta_srch_addrsperid_count01   ;
			self.divaddrssnmsourcecount           :=divaddrssnmsourcecount         ;
			self.verificationbusinputphone        :=verificationbusinputphone      ;
			self.correlationaddrnamecount         :=correlationaddrnamecount       ;
			self.divaddrssncount                  :=divaddrssncount                ;
			self.correlationssnaddrcount          :=correlationssnaddrcount        ;
			self.sourceproperty                   :=sourceproperty                 ;
			self.sbfeavgbalance03m                :=sbfeavgbalance03m              ;
			self.divaddrsuspidentitycountnew      :=divaddrsuspidentitycountnew    ;
			self.beta_srch_corrdobssn_id          :=beta_srch_corrdobssn_id        ;
			self.searchphonesearchcountyear       :=searchphonesearchcountyear     ;
			self.beta_sum_src_credentialed        :=beta_sum_src_credentialed      ;
			self.searchaddrsearchcountyear        :=searchaddrsearchcountyear      ;
			self.variationrisklevel               :=variationrisklevel             ;
			self.sbfeverbusaddr                   :=sbfeverbusaddr                 ;
			self.sourcephonedirectoryassistance   :=sourcephonedirectoryassistance ;
			self.idveraddress                     :=idveraddress                   ;
			self.beta_srch_ssnsperaddr_count01    :=beta_srch_ssnsperaddr_count01  ;
			self.assochighrisktopologycount       :=assochighrisktopologycount     ;
			self.beta_srch_lnamesperid_count03    :=beta_srch_lnamesperid_count03  ;
			self.inquiry03month                   :=inquiry03month                 ;
			self.searchaddrsearchcount            :=searchaddrsearchcount          ;
			self.sourcepublicrecord               :=sourcepublicrecord             ;
			self.sbfeopencount06m                 :=sbfeopencount06m               ;
			self.divssnaddrmsourcecount           :=divssnaddrmsourcecount         ;
			self.beta_cpnindex                    :=beta_cpnindex                  ;
			self.idverssnsourcecount              :=idverssnsourcecount            ;
			self.searchssnsearchcountmonth        :=searchssnsearchcountmonth      ;
			self.identityageoldest                :=identityageoldest              ;
			self.variationlastnamecount           :=variationlastnamecount         ;
			self.beta_srch_corrnamephone          :=beta_srch_corrnamephone        ;
			self.searchfraudsearchcountyear       :=searchfraudsearchcountyear     ;
			self.variationphonecountnew           :=variationphonecountnew         ;
			self.searchcountyear                  :=searchcountyear                ;
			self.businessactivity03month          :=businessactivity03month        ;
			self.busfeinpersonaddroverlap         :=busfeinpersonaddroverlap       ;
			self.inquirycredit12month             :=inquirycredit12month           ;
			self.beta_sum_src_other               :=beta_sum_src_other             ;
			self.searchphonesearchcount           :=searchphonesearchcount         ;
			self.idveraddresssourcecount          :=idveraddresssourcecount        ;
			self.variationaddrchangeage           :=variationaddrchangeage         ;
			self.searchcomponentrisklevel         :=searchcomponentrisklevel       ;
			self.sbferecentbalancecardamt         :=sbferecentbalancecardamt       ;
			self.beta_fla_fld_bureau_no_ssn_flag  :=beta_fla_fld_bureau_no_ssn_flag;
			self.sbfehighbalancecard60m           :=sbfehighbalancecard60m         ;
			self.beta_srch_addrsperid_count03     :=beta_srch_addrsperid_count03   ;
			self.divphoneidentitymsourcecount     :=divphoneidentitymsourcecount   ;
			self.searchcountmonth                 :=searchcountmonth               ;
			self.sbfetimeoldest                   :=sbfetimeoldest                 ;
			self.sbfeclosedvoluntarycount         :=sbfeclosedvoluntarycount       ;
			self.sbfeavgbalanceever               :=sbfeavgbalanceever             ;
			self.inputaddractivephonelist         :=inputaddractivephonelist       ;
			self.variationphonecount              :=variationphonecount            ;
			self.searchphonesearchcountmonth      :=searchphonesearchcountmonth    ;
			self.assoccount                       :=assoccount                     ;
			self.sbfehighbalance24m               :=sbfehighbalance24m             ;
			self.validationphoneproblems          :=validationphoneproblems        ;
			self.beta_srch_corrnamessn_id         :=beta_srch_corrnamessn_id       ;
			self.curraddrageoldest                :=curraddrageoldest              ;
			self.variationsearchphonecount        :=variationsearchphonecount      ;
			self.divsearchaddridentitycount       :=divsearchaddridentitycount     ;
			self.divaddrphonecountnew             :=divaddrphonecountnew           ;
			self.beta_corrnamedob                 :=beta_corrnamedob               ;
			self.divsearchaddrsuspidentitycount   :=divsearchaddrsuspidentitycount ;
			self.searchfraudsearchcount           :=searchfraudsearchcount         ;
			self.associatecountycount             :=associatecountycount           ;
			self.sourcevehicleregistration        :=sourcevehicleregistration      ;
			self.idverdobsourcecount              :=idverdobsourcecount            ;
			self.idverssncreditbureaucount        :=idverssncreditbureaucount      ;
			self.variationsearchaddrcount         :=variationsearchaddrcount       ;
			self.beta_srch_nonbank_recency        :=beta_srch_nonbank_recency      ;
			self.beta_srch_corraddrphone          :=beta_srch_corraddrphone        ;
			self.searchfraudsearchcountmonth      :=searchfraudsearchcountmonth    ;
			self.beta_dob_bureau_only             :=beta_dob_bureau_only           ;
			self.inquiryconsumerphone             :=inquiryconsumerphone           ;
			self.beta_srch_corrnamephone_id       :=beta_srch_corrnamephone_id     ;
			self.sbfelastpaymentamt               :=sbfelastpaymentamt             ;
			self.beta_hh_members_for_bureau_only  :=beta_hh_members_for_bureau_only;
			self.divrisklevel                     :=divrisklevel                   ;
			self.sbfeopencount36m                 :=sbfeopencount36m               ;
			self.sbfehighutilrevolvingamt         :=sbfehighutilrevolvingamt       ;
			self.sbfelimitcardamt06m              :=sbfelimitcardamt06m            ;
			self.searchlocatesearchcountyear      :=searchlocatesearchcountyear    ;
			self.componentcharrisklevel           :=componentcharrisklevel         ;
			self.busexeclinkauthrepnameonfile     :=busexeclinkauthrepnameonfile   ;
			self.searchhighrisksearchcount        :=searchhighrisksearchcount      ;
			self.identitysourcecount              :=identitysourcecount            ;
			self.correlationssnnamecount          :=correlationssnnamecount        ;
			self.beta_srch_corrdobaddr_id         :=beta_srch_corrdobaddr_id       ;
			self.sourcecreditbureau               :=sourcecreditbureau             ;
			self.sbfebalanceamt12m                :=sbfebalanceamt12m              ;
			self.searchbankingsearchcountmonth    :=searchbankingsearchcountmonth  ;
			self.beta_srch_dobsperid_count01      :=beta_srch_dobsperid_count01    ;
			self.beta_srch_corrnamessn            :=beta_srch_corrnamessn          ;
			self.assocrisklevel                   :=assocrisklevel                 ;
			self.sbfetimeoldestcard               :=sbfetimeoldestcard             ;
			self.sbfehighutilcardamt              :=sbfehighutilcardamt            ;
			self.divphoneaddrcount                :=divphoneaddrcount              ;
			self.searchunverifiedaddrcountyear    :=searchunverifiedaddrcountyear  ;
			self.beta_srch_idsperphone_count01    :=beta_srch_idsperphone_count01  ;
			self.curraddractivephonelist          :=curraddractivephonelist        ;
			self.sbfedelqavgamt84m                :=sbfedelqavgamt84m              ;
			self.variationmsourcesssncount        :=variationmsourcesssncount      ;
			self.sbfeavgutilcardever              :=sbfeavgutilcardever            ;
			self.sbfeopencount84m                 :=sbfeopencount84m               ;
			self.variationsearchssncount          :=variationsearchssncount        ;
			self.searchssnsearchcount             :=searchssnsearchcount           ;
			self.sbfehighbalanceloan24m           :=sbfehighbalanceloan24m         ;
			self.beta_srch_idsperssn_count03      :=beta_srch_idsperssn_count03    ;
			self.variationaddrstability           :=variationaddrstability         ;
			self.sourcefirstreportingidentity     :=sourcefirstreportingidentity   ;
			self.sbfehighbalance84m               :=sbfehighbalance84m             ;
			self.businessrecordupdated12month     :=businessrecordupdated12month   ;
			self.prevaddrlenofres                 :=prevaddrlenofres               ;
			self.curraddrstatus                   :=curraddrstatus                 ;
			self.searchvelocityrisklevel          :=searchvelocityrisklevel        ;
			self.addrchangedistance               :=addrchangedistance             ;
			self.sourcepublicrecordcount          :=sourcepublicrecordcount        ;
			self.beta_srch_corrdobphone           :=beta_srch_corrdobphone         ;
			self.beta_srch_phonesperid_count03    :=beta_srch_phonesperid_count03  ;
			self.variationaddrcountyear           :=variationaddrcountyear         ;
			self.sbfedelq01amt12m                 :=sbfedelq01amt12m               ;
			self.inputaddrlotsize                 :=inputaddrlotsize               ;
			self.sbfelegalstructure               :=sbfelegalstructure             ;
			self.beta_srch_corrphonessn           :=beta_srch_corrphonessn         ;
			self.beta_srch_idsperssn_count01      :=beta_srch_idsperssn_count01    ;
			self.beta_srch_addrsperssn_count03    :=beta_srch_addrsperssn_count03  ;
			self.idverssn                         :=idverssn                       ;
			self.beta_ssn_bureau_only             :=beta_ssn_bureau_only           ;
			self.beta_corrssndob                  :=beta_corrssndob                ;
			self.divssnidentitymsourceurelcount   :=divssnidentitymsourceurelcount ;
			self.verificationbusinputaddr         :=verificationbusinputaddr       ;
			self.beta_srch_primrangesperid_1subs  :=beta_srch_primrangesperid_1subs;
			self.associatecount                   :=associatecount                 ;
			self.sbfetimenewest                   :=sbfetimenewest                 ;
			self.sbfeavgbalance84m                :=sbfeavgbalance84m              ;
			self.sbfeavgutilcard12m               :=sbfeavgutilcard12m             ;
			self.divssnidentitymsourcecount       :=divssnidentitymsourcecount     ;
			self.beta_bureau_only_index           :=beta_bureau_only_index         ;
			self.sbfeavgbalanceloan24m            :=sbfeavgbalanceloan24m          ;
			self.beta_srch_corrnamephonessn       :=beta_srch_corrnamephonessn     ;
			self.sbfedelq91revcountever           :=sbfedelq91revcountever         ;
			self.variationmsourcesssnunrelcount   :=variationmsourcesssnunrelcount ;
			self.sbfeprincipalaccountcount        :=sbfeprincipalaccountcount      ;
			self.busexeclinkauthrepssnonfile      :=busexeclinkauthrepssnonfile    ;
			self.sbfebalancecount12m              :=sbfebalancecount12m            ;
			self.sbfetimeoldestcycle              :=sbfetimeoldestcycle            ;
			self.searchunverifieddobcountyear     :=searchunverifieddobcountyear   ;
			self.beta_srch_corraddrphone_id       :=beta_srch_corraddrphone_id     ;
			self.divssnidentitycount              :=divssnidentitycount            ;
			self.variationlastnamecountnew        :=variationlastnamecountnew      ;
			self.sostimeincorporation             :=sostimeincorporation           ;
			self.sbfeavgbalance06m                :=sbfeavgbalance06m              ;
			self.sbfeavgutilcard36m               :=sbfeavgutilcard36m             ;
			self.sbfebalancecountever             :=sbfebalancecountever           ;
			self.sbfedelq91cardcountever          :=sbfedelq91cardcountever        ;
			self.sbfebalanceamt60m                :=sbfebalanceamt60m              ;
			self.sbfeavgbalancecardever           :=sbfeavgbalancecardever         ;
			self.divssnaddrcountnew               :=divssnaddrcountnew             ;
			self.sbfelastpaymentcardamt           :=sbfelastpaymentcardamt         ;
			self.busfeinpersonoverlap             :=busfeinpersonoverlap           ;
			self.sbfehighbalance03m               :=sbfehighbalance03m             ;
			self.beta_srch_lnamesperaddr_count03  :=beta_srch_lnamesperaddr_count03;
			self.sbfehitindex                     :=sbfehitindex                   ;
			self.beta_srch_corrnameaddrphnssn     :=beta_srch_corrnameaddrphnssn   ;
			self.sbfeavgbalancecard12m            :=sbfeavgbalancecard12m          ;
			self.idveraddressmatchescurrent       :=idveraddressmatchescurrent     ;
			self.stolenidentityindex              :=stolenidentityindex            ;
			self.curraddrdwelltype                :=curraddrdwelltype              ;
			self.sbfebalancecount03m              :=sbfebalancecount03m            ;
			self.beta_srch_idsperssn_count06      :=beta_srch_idsperssn_count06    ;
			self.beta_source_type                 :=beta_source_type               ;
			self.sbfehighbalance12m               :=sbfehighbalance12m             ;
			self.sbfeavgutilcard24m               :=sbfeavgutilcard24m             ;
			self.assoccreditbureauonlycount       :=assoccreditbureauonlycount     ;
			self.variationdobcount                :=variationdobcount              ;
			self.sbfeavgutil12m                   :=sbfeavgutil12m                 ;
			self.sbfeavgutil84m                   :=sbfeavgutil84m                 ;
			self.sbfepaymentduecardamt            :=sbfepaymentduecardamt          ;
			self.verificationbusinputname         :=verificationbusinputname       ;
			self.businessrecordtimenewest         :=businessrecordtimenewest       ;
			self.beta_input_lname_isbestmatch     :=beta_input_lname_isbestmatch   ;
			self.beta_srch_corrnamephonessn_id    :=beta_srch_corrnamephonessn_id  ;
			self.idveraddressnotcurrent           :=idveraddressnotcurrent         ;
			self.beta_srch_corrdobssn             :=beta_srch_corrdobssn           ;
			self.sbfetimenewestcycle              :=sbfetimenewestcycle            ;
			self.inputphonemobile                 :=inputphonemobile               ;
                   
  		              self.model1_attrsv4_tree_0            := model1_attrsv4_tree_0;
                    self.model1_attrsv4_tree_1            := model1_attrsv4_tree_1;
                    self.model1_attrsv4_tree_2            := model1_attrsv4_tree_2;
                    self.model1_attrsv4_tree_3            := model1_attrsv4_tree_3;
                    self.model1_attrsv4_tree_4            := model1_attrsv4_tree_4;
                    self.model1_attrsv4_tree_5            := model1_attrsv4_tree_5;
                    self.model1_attrsv4_tree_6            := model1_attrsv4_tree_6;
                    self.model1_attrsv4_tree_7            := model1_attrsv4_tree_7;
                    self.model1_attrsv4_tree_8            := model1_attrsv4_tree_8;
                    self.model1_attrsv4_tree_9            := model1_attrsv4_tree_9;
                    self.model1_attrsv4_tree_10           := model1_attrsv4_tree_10;
                    self.model1_attrsv4_tree_11           := model1_attrsv4_tree_11;
                    self.model1_attrsv4_tree_12           := model1_attrsv4_tree_12;
                    self.model1_attrsv4_tree_13           := model1_attrsv4_tree_13;
                    self.model1_attrsv4_tree_14           := model1_attrsv4_tree_14;
                    self.model1_attrsv4_tree_15           := model1_attrsv4_tree_15;
                    self.model1_attrsv4_tree_16           := model1_attrsv4_tree_16;
                    self.model1_attrsv4_tree_17           := model1_attrsv4_tree_17;
                    self.model1_attrsv4_tree_18           := model1_attrsv4_tree_18;
                    self.model1_attrsv4_tree_19           := model1_attrsv4_tree_19;
                    self.model1_attrsv4_tree_20           := model1_attrsv4_tree_20;
                    self.model1_attrsv4_tree_21           := model1_attrsv4_tree_21;
                    self.model1_attrsv4_tree_22           := model1_attrsv4_tree_22;
                    self.model1_attrsv4_tree_23           := model1_attrsv4_tree_23;
                    self.model1_attrsv4_tree_24           := model1_attrsv4_tree_24;
                    self.model1_attrsv4_tree_25           := model1_attrsv4_tree_25;
                    self.model1_attrsv4_tree_26           := model1_attrsv4_tree_26;
                    self.model1_attrsv4_tree_27           := model1_attrsv4_tree_27;
                    self.model1_attrsv4_tree_28           := model1_attrsv4_tree_28;
                    self.model1_attrsv4_tree_29           := model1_attrsv4_tree_29;
                    self.model1_attrsv4_tree_30           := model1_attrsv4_tree_30;
                    self.model1_attrsv4_tree_31           := model1_attrsv4_tree_31;
                    self.model1_attrsv4_tree_32           := model1_attrsv4_tree_32;
                    self.model1_attrsv4_tree_33           := model1_attrsv4_tree_33;
                    self.model1_attrsv4_tree_34           := model1_attrsv4_tree_34;
                    self.model1_attrsv4_tree_35           := model1_attrsv4_tree_35;
                    self.model1_attrsv4_tree_36           := model1_attrsv4_tree_36;
                    self.model1_attrsv4_tree_37           := model1_attrsv4_tree_37;
                    self.model1_attrsv4_tree_38           := model1_attrsv4_tree_38;
                    self.model1_attrsv4_tree_39           := model1_attrsv4_tree_39;
                    self.model1_attrsv4_tree_40           := model1_attrsv4_tree_40;
                    self.model1_attrsv4_tree_41           := model1_attrsv4_tree_41;
                    self.model1_attrsv4_tree_42           := model1_attrsv4_tree_42;
                    self.model1_attrsv4_tree_43           := model1_attrsv4_tree_43;
                    self.model1_attrsv4_tree_44           := model1_attrsv4_tree_44;
                    self.model1_attrsv4_tree_45           := model1_attrsv4_tree_45;
                    self.model1_attrsv4_tree_46           := model1_attrsv4_tree_46;
                    self.model1_attrsv4_tree_47           := model1_attrsv4_tree_47;
                    self.model1_attrsv4_tree_48           := model1_attrsv4_tree_48;
                    self.model1_attrsv4_tree_49           := model1_attrsv4_tree_49;
                    self.model1_attrsv4_tree_50           := model1_attrsv4_tree_50;
                    self.model1_attrsv4_tree_51           := model1_attrsv4_tree_51;
                    self.model1_attrsv4_tree_52           := model1_attrsv4_tree_52;
                    self.model1_attrsv4_tree_53           := model1_attrsv4_tree_53;
                    self.model1_attrsv4_tree_54           := model1_attrsv4_tree_54;
                    self.model1_attrsv4_tree_55           := model1_attrsv4_tree_55;
                    self.model1_attrsv4_tree_56           := model1_attrsv4_tree_56;
                    self.model1_attrsv4_tree_57           := model1_attrsv4_tree_57;
                    self.model1_attrsv4_tree_58           := model1_attrsv4_tree_58;
                    self.model1_attrsv4_tree_59           := model1_attrsv4_tree_59;
                    self.model1_attrsv4_tree_60           := model1_attrsv4_tree_60;
                    self.model1_attrsv4_tree_61           := model1_attrsv4_tree_61;
                    self.model1_attrsv4_tree_62           := model1_attrsv4_tree_62;
                    self.model1_attrsv4_tree_63           := model1_attrsv4_tree_63;
                    self.model1_attrsv4_tree_64           := model1_attrsv4_tree_64;
                    self.model1_attrsv4_tree_65           := model1_attrsv4_tree_65;
                    self.model1_attrsv4_tree_66           := model1_attrsv4_tree_66;
                    self.model1_attrsv4_tree_67           := model1_attrsv4_tree_67;
                    self.model1_attrsv4_tree_68           := model1_attrsv4_tree_68;
                    self.model1_attrsv4_tree_69           := model1_attrsv4_tree_69;
                    self.model1_attrsv4_tree_70           := model1_attrsv4_tree_70;
                    self.model1_attrsv4_tree_71           := model1_attrsv4_tree_71;
                    self.model1_attrsv4_tree_72           := model1_attrsv4_tree_72;
                    self.model1_attrsv4_tree_73           := model1_attrsv4_tree_73;
                    self.model1_attrsv4_tree_74           := model1_attrsv4_tree_74;
                    self.model1_attrsv4_tree_75           := model1_attrsv4_tree_75;
                    self.model1_attrsv4_tree_76           := model1_attrsv4_tree_76;
                    self.model1_attrsv4_tree_77           := model1_attrsv4_tree_77;
                    self.model1_attrsv4_tree_78           := model1_attrsv4_tree_78;
                    self.model1_attrsv4_tree_79           := model1_attrsv4_tree_79;
                    self.model1_attrsv4_tree_80           := model1_attrsv4_tree_80;
                    self.model1_attrsv4_tree_81           := model1_attrsv4_tree_81;
                    self.model1_attrsv4_tree_82           := model1_attrsv4_tree_82;
                    self.model1_attrsv4_tree_83           := model1_attrsv4_tree_83;
                    self.model1_attrsv4_tree_84           := model1_attrsv4_tree_84;
                    self.model1_attrsv4_tree_85           := model1_attrsv4_tree_85;
                    self.model1_attrsv4_tree_86           := model1_attrsv4_tree_86;
                    self.model1_attrsv4_tree_87           := model1_attrsv4_tree_87;
                    self.model1_attrsv4_tree_88           := model1_attrsv4_tree_88;
                    self.model1_attrsv4_tree_89           := model1_attrsv4_tree_89;
                    self.model1_attrsv4_tree_90           := model1_attrsv4_tree_90;
                    self.model1_attrsv4_tree_91           := model1_attrsv4_tree_91;
                    self.model1_attrsv4_tree_92           := model1_attrsv4_tree_92;
                    self.model1_attrsv4_tree_93           := model1_attrsv4_tree_93;
                    self.model1_attrsv4_tree_94           := model1_attrsv4_tree_94;
                    self.model1_attrsv4_tree_95           := model1_attrsv4_tree_95;
                    self.model1_attrsv4_tree_96           := model1_attrsv4_tree_96;
                    self.model1_attrsv4_tree_97           := model1_attrsv4_tree_97;
                    self.model1_attrsv4_tree_98           := model1_attrsv4_tree_98;
                    self.model1_attrsv4_tree_99           := model1_attrsv4_tree_99;
                    self.model1_attrsv4_tree_100          := model1_attrsv4_tree_100;
                    self.model1_attrsv4_tree_101          := model1_attrsv4_tree_101;
                    self.model1_attrsv4_tree_102          := model1_attrsv4_tree_102;
                    self.model1_attrsv4_tree_103          := model1_attrsv4_tree_103;
                    self.model1_attrsv4_tree_104          := model1_attrsv4_tree_104;
                    self.model1_attrsv4_tree_105          := model1_attrsv4_tree_105;
                    self.model1_attrsv4_tree_106          := model1_attrsv4_tree_106;
                    self.model1_attrsv4_tree_107          := model1_attrsv4_tree_107;
                    self.model1_attrsv4_tree_108          := model1_attrsv4_tree_108;
                    self.model1_attrsv4_tree_109          := model1_attrsv4_tree_109;
                    self.model1_attrsv4_tree_110          := model1_attrsv4_tree_110;
                    self.model1_attrsv4_tree_111          := model1_attrsv4_tree_111;
                    self.model1_attrsv4_tree_112          := model1_attrsv4_tree_112;
                    self.model1_attrsv4_tree_113          := model1_attrsv4_tree_113;
                    self.model1_attrsv4_tree_114          := model1_attrsv4_tree_114;
                    self.model1_attrsv4_tree_115          := model1_attrsv4_tree_115;
                    self.model1_attrsv4_tree_116          := model1_attrsv4_tree_116;
                    self.model1_attrsv4_tree_117          := model1_attrsv4_tree_117;
                    self.model1_attrsv4_tree_118          := model1_attrsv4_tree_118;
                    self.model1_attrsv4_tree_119          := model1_attrsv4_tree_119;
                    self.model1_attrsv4_tree_120          := model1_attrsv4_tree_120;
                    self.model1_attrsv4_tree_121          := model1_attrsv4_tree_121;
                    self.model1_attrsv4_tree_122          := model1_attrsv4_tree_122;
                    self.model1_attrsv4_tree_123          := model1_attrsv4_tree_123;
                    self.model1_attrsv4_tree_124          := model1_attrsv4_tree_124;
                    self.model1_attrsv4_tree_125          := model1_attrsv4_tree_125;
                    self.model1_attrsv4_tree_126          := model1_attrsv4_tree_126;
                    self.model1_attrsv4_tree_127          := model1_attrsv4_tree_127;
                    self.model1_attrsv4_tree_128          := model1_attrsv4_tree_128;
                    self.model1_attrsv4_tree_129          := model1_attrsv4_tree_129;
                    self.model1_attrsv4_tree_130          := model1_attrsv4_tree_130;
                    self.model1_attrsv4_tree_131          := model1_attrsv4_tree_131;
                    self.model1_attrsv4_tree_132          := model1_attrsv4_tree_132;
                    self.model1_attrsv4_tree_133          := model1_attrsv4_tree_133;
                    self.model1_attrsv4_tree_134          := model1_attrsv4_tree_134;
                    self.model1_attrsv4_tree_135          := model1_attrsv4_tree_135;
                    self.model1_attrsv4_tree_136          := model1_attrsv4_tree_136;
                    self.model1_attrsv4_tree_137          := model1_attrsv4_tree_137;
                    self.model1_attrsv4_tree_138          := model1_attrsv4_tree_138;
                    self.model1_attrsv4_tree_139          := model1_attrsv4_tree_139;
                    self.model1_attrsv4_tree_140          := model1_attrsv4_tree_140;
                    self.model1_attrsv4_tree_141          := model1_attrsv4_tree_141;
                    self.model1_attrsv4_tree_142          := model1_attrsv4_tree_142;
                    self.model1_attrsv4_tree_143          := model1_attrsv4_tree_143;
                    self.model1_attrsv4_tree_144          := model1_attrsv4_tree_144;
                    self.model1_attrsv4_tree_145          := model1_attrsv4_tree_145;
                    self.model1_attrsv4_tree_146          := model1_attrsv4_tree_146;
                    self.model1_attrsv4_tree_147          := model1_attrsv4_tree_147;
                    self.model1_attrsv4_tree_148          := model1_attrsv4_tree_148;
                    self.model1_attrsv4_tree_149          := model1_attrsv4_tree_149;
                    self.model1_attrsv4_tree_150          := model1_attrsv4_tree_150;
                    self.model1_attrsv4_tree_151          := model1_attrsv4_tree_151;
                    self.model1_attrsv4_tree_152          := model1_attrsv4_tree_152;
                    self.model1_attrsv4_tree_153          := model1_attrsv4_tree_153;
                    self.model1_attrsv4_tree_154          := model1_attrsv4_tree_154;
                    self.model1_attrsv4_tree_155          := model1_attrsv4_tree_155;
                    self.model1_attrsv4_tree_156          := model1_attrsv4_tree_156;
                    self.model1_attrsv4_tree_157          := model1_attrsv4_tree_157;
                    self.model1_attrsv4_tree_158          := model1_attrsv4_tree_158;
                    self.model1_attrsv4_tree_159          := model1_attrsv4_tree_159;
                    self.model1_attrsv4_tree_160          := model1_attrsv4_tree_160;
                    self.model1_attrsv4_tree_161          := model1_attrsv4_tree_161;
                    self.model1_attrsv4_tree_162          := model1_attrsv4_tree_162;
                    self.model1_attrsv4_tree_163          := model1_attrsv4_tree_163;
                    self.model1_attrsv4_tree_164          := model1_attrsv4_tree_164;
                    self.model1_attrsv4_tree_165          := model1_attrsv4_tree_165;
                    self.model1_attrsv4_tree_166          := model1_attrsv4_tree_166;
                    self.model1_attrsv4_tree_167          := model1_attrsv4_tree_167;
                    self.model1_attrsv4_tree_168          := model1_attrsv4_tree_168;
                    self.model1_attrsv4_tree_169          := model1_attrsv4_tree_169;
                    self.model1_attrsv4_tree_170          := model1_attrsv4_tree_170;
                    self.model1_attrsv4_tree_171          := model1_attrsv4_tree_171;
                    self.model1_attrsv4_tree_172          := model1_attrsv4_tree_172;
                    self.model1_attrsv4_tree_173          := model1_attrsv4_tree_173;
                    self.model1_attrsv4_tree_174          := model1_attrsv4_tree_174;
                    self.model1_attrsv4_tree_175          := model1_attrsv4_tree_175;
                    self.model1_attrsv4_tree_176          := model1_attrsv4_tree_176;
                    self.model1_attrsv4_tree_177          := model1_attrsv4_tree_177;
                    self.model1_attrsv4_tree_178          := model1_attrsv4_tree_178;
                    self.model1_attrsv4_tree_179          := model1_attrsv4_tree_179;
                    self.model1_attrsv4_tree_180          := model1_attrsv4_tree_180;
                    self.model1_attrsv4_tree_181          := model1_attrsv4_tree_181;
                    self.model1_attrsv4_tree_182          := model1_attrsv4_tree_182;
                    self.model1_attrsv4_tree_183          := model1_attrsv4_tree_183;
                    self.model1_attrsv4_tree_184          := model1_attrsv4_tree_184;
                    self.model1_attrsv4_tree_185          := model1_attrsv4_tree_185;
                    self.model1_attrsv4_tree_186          := model1_attrsv4_tree_186;
                    self.model1_attrsv4_tree_187          := model1_attrsv4_tree_187;
                    self.model1_attrsv4_tree_188          := model1_attrsv4_tree_188;
                    self.model1_attrsv4_tree_189          := model1_attrsv4_tree_189;
                    self.model1_attrsv4_tree_190          := model1_attrsv4_tree_190;
                    self.model1_attrsv4_tree_191          := model1_attrsv4_tree_191;
                    self.model1_attrsv4_tree_192          := model1_attrsv4_tree_192;
                    self.model1_attrsv4_tree_193          := model1_attrsv4_tree_193;
                    self.model1_attrsv4_tree_194          := model1_attrsv4_tree_194;
                    self.model1_attrsv4_tree_195          := model1_attrsv4_tree_195;
                    self.model1_attrsv4_tree_196          := model1_attrsv4_tree_196;
                    self.model1_attrsv4_tree_197          := model1_attrsv4_tree_197;
                    self.model1_attrsv4_tree_198          := model1_attrsv4_tree_198;
                    self.model1_attrsv4_tree_199          := model1_attrsv4_tree_199;
                    self.model1_attrsv4_tree_200          := model1_attrsv4_tree_200;
                    self.model1_attrsv4_tree_201          := model1_attrsv4_tree_201;
                    self.model1_attrsv4_tree_202          := model1_attrsv4_tree_202;
                    self.model1_attrsv4_tree_203          := model1_attrsv4_tree_203;
                    self.model1_attrsv4_tree_204          := model1_attrsv4_tree_204;
                    self.model1_attrsv4_tree_205          := model1_attrsv4_tree_205;
                    self.model1_attrsv4_tree_206          := model1_attrsv4_tree_206;
                    self.model1_attrsv4_tree_207          := model1_attrsv4_tree_207;
                    self.model1_attrsv4_tree_208          := model1_attrsv4_tree_208;
                    self.model1_attrsv4_tree_209          := model1_attrsv4_tree_209;
                    self.model1_attrsv4_tree_210          := model1_attrsv4_tree_210;
                    self.model1_attrsv4_tree_211          := model1_attrsv4_tree_211;
                    self.model1_attrsv4_tree_212          := model1_attrsv4_tree_212;
                    self.model1_attrsv4_tree_213          := model1_attrsv4_tree_213;
                    self.model1_attrsv4_tree_214          := model1_attrsv4_tree_214;
                    self.model1_attrsv4_tree_215          := model1_attrsv4_tree_215;
                    self.model1_attrsv4_tree_216          := model1_attrsv4_tree_216;
                    self.model1_attrsv4_tree_217          := model1_attrsv4_tree_217;
                    self.model1_attrsv4_tree_218          := model1_attrsv4_tree_218;
                    self.model1_attrsv4_tree_219          := model1_attrsv4_tree_219;
                    self.model1_attrsv4_tree_220          := model1_attrsv4_tree_220;
                    self.model1_attrsv4_tree_221          := model1_attrsv4_tree_221;
                    self.model1_attrsv4_tree_222          := model1_attrsv4_tree_222;
                    self.model1_attrsv4_tree_223          := model1_attrsv4_tree_223;
                    self.model1_attrsv4_tree_224          := model1_attrsv4_tree_224;
                    self.model1_attrsv4_tree_225          := model1_attrsv4_tree_225;
                    self.model1_attrsv4_tree_226          := model1_attrsv4_tree_226;
                    self.model1_attrsv4_tree_227          := model1_attrsv4_tree_227;
                    self.model1_attrsv4_tree_228          := model1_attrsv4_tree_228;
                    self.model1_attrsv4_tree_229          := model1_attrsv4_tree_229;
                    self.model1_attrsv4_tree_230          := model1_attrsv4_tree_230;
                    self.model1_attrsv4_tree_231          := model1_attrsv4_tree_231;
                    self.model1_attrsv4_tree_232          := model1_attrsv4_tree_232;
                    self.model1_attrsv4_tree_233          := model1_attrsv4_tree_233;
                    self.model1_attrsv4_tree_234          := model1_attrsv4_tree_234;
                    self.model1_attrsv4_tree_235          := model1_attrsv4_tree_235;
                    self.model1_attrsv4_tree_236          := model1_attrsv4_tree_236;
                    self.model1_attrsv4_tree_237          := model1_attrsv4_tree_237;
                    self.model1_attrsv4_tree_238          := model1_attrsv4_tree_238;
                    self.model1_attrsv4_tree_239          := model1_attrsv4_tree_239;
                    self.model1_attrsv4_tree_240          := model1_attrsv4_tree_240;
                    self.model1_attrsv4_tree_241          := model1_attrsv4_tree_241;
                    self.model1_attrsv4_tree_242          := model1_attrsv4_tree_242;
                    self.model1_attrsv4_tree_243          := model1_attrsv4_tree_243;
                    self.model1_attrsv4_tree_244          := model1_attrsv4_tree_244;
                    self.model1_attrsv4_tree_245          := model1_attrsv4_tree_245;
                    self.model1_attrsv4_tree_246          := model1_attrsv4_tree_246;
                    self.model1_attrsv4_tree_247          := model1_attrsv4_tree_247;
                    self.model1_attrsv4_tree_248          := model1_attrsv4_tree_248;
                    self.model1_attrsv4_tree_249          := model1_attrsv4_tree_249;
                    self.model1_attrsv4_tree_250          := model1_attrsv4_tree_250;
                    self.model1_attrsv4_tree_251          := model1_attrsv4_tree_251;
                    self.model1_attrsv4_tree_252          := model1_attrsv4_tree_252;
                    self.model1_attrsv4_tree_253          := model1_attrsv4_tree_253;
                    self.model1_attrsv4_tree_254          := model1_attrsv4_tree_254;
                    self.model1_attrsv4_tree_255          := model1_attrsv4_tree_255;
                    self.model1_attrsv4_tree_256          := model1_attrsv4_tree_256;
                    self.model1_attrsv4_tree_257          := model1_attrsv4_tree_257;
                    self.model1_attrsv4_tree_258          := model1_attrsv4_tree_258;
                    self.model1_attrsv4_tree_259          := model1_attrsv4_tree_259;
                    self.model1_attrsv4_tree_260          := model1_attrsv4_tree_260;
                    self.model1_attrsv4_tree_261          := model1_attrsv4_tree_261;
                    self.model1_attrsv4_tree_262          := model1_attrsv4_tree_262;
                    self.model1_attrsv4_tree_263          := model1_attrsv4_tree_263;
                    self.model1_attrsv4_tree_264          := model1_attrsv4_tree_264;
                    self.model1_attrsv4_tree_265          := model1_attrsv4_tree_265;
                    self.model1_attrsv4_tree_266          := model1_attrsv4_tree_266;
                    self.model1_attrsv4_tree_267          := model1_attrsv4_tree_267;
                    self.model1_attrsv4_tree_268          := model1_attrsv4_tree_268;
                    self.model1_attrsv4_tree_269          := model1_attrsv4_tree_269;
                    self.model1_attrsv4_tree_270          := model1_attrsv4_tree_270;
                    self.model1_attrsv4_tree_271          := model1_attrsv4_tree_271;
                    self.model1_attrsv4_tree_272          := model1_attrsv4_tree_272;
                    self.model1_attrsv4_tree_273          := model1_attrsv4_tree_273;
                    self.model1_attrsv4_tree_274          := model1_attrsv4_tree_274;
                    self.model1_attrsv4_tree_275          := model1_attrsv4_tree_275;
                    self.model1_attrsv4_tree_276          := model1_attrsv4_tree_276;
                    self.model1_attrsv4_tree_277          := model1_attrsv4_tree_277;
                    self.model1_attrsv4_tree_278          := model1_attrsv4_tree_278;
                    self.model1_attrsv4_tree_279          := model1_attrsv4_tree_279;
                    self.model1_attrsv4_tree_280          := model1_attrsv4_tree_280;
                    self.model1_attrsv4_gbm_logit         := model1_attrsv4_gbm_logit;
                    self.pbr                              := pbr;
                    self.sbr                              := sbr;
                    self.offset                           := offset;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.bbfm1811_1_0                     := bbfm1811_1_0;
                    SELF.clam                             := le.clam;  
                    self.busshell                         := le.busshell;
                    reasonCodes := Models.BB_WarningCodes(le.clam, le.Busshell , num_reasons)[1].hris;
                    self.bbfm_wc1                         := reasonCodes[1].hri;//bbfm_wc
                    self.bbfm_wc2                         := reasonCodes[2].hri;
                    self.bbfm_wc3                         := reasonCodes[3].hri;
                    self.bbfm_wc4                         := reasonCodes[4].hri;
  
  #else
     
     reasonCodes := Models.BB_WarningCodes(le.clam, le.Busshell , num_reasons)[1].hris;
  
  
  	 SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
                                          
     

                                          


		SELF.score := (STRING3)BBFM1811_1_0;
		SELF.seq := le.input.seq;
 
  #end   
  

      END;

 //  model :=   project(clam, doModel(left) );
	//model := JOIN(BusShell, Clam, LEFT.Input_Echo.seq = RIGHT.seq, doModel(LEFT, RIGHT), LEFT OUTER, KEEP(1));
	
 
model :=   join(SBFA_atributes, FDA_attr_clam_busshell,
		LEFT.seq = RIGHT.input.seq,
		doModel(left, right), left outer,
		//atmost(RiskWise.max_atmost)
		keep(1)); 
 
  
	return model;
END;
