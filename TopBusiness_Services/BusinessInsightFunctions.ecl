Import  BIPv2, MDR, TopBusiness_Services , doxie, iesp, Advo, STD, ut, SAM, property, Corp2,
              Cortera_Tradeline, DueDiligence, Liensv2;
//////////////////////////////////////////////////////////////////////
//  start of smart linx story #70 risk indicator code (business Evidence)
///////////////////////////////////////////////////////////////////////
EXPORT BusinessInsightFunctions := MODULE

    EXPORT IsBusinessDefunct(boolean isDefunct) := FUNCTION
       RETURN(isDefunct);
    END;

    EXPORT  BusinessIsInactive(boolean IsInActive) := FUNCTION
       RETURN(isInActive);
    END;

    EXPORT TooFewSourcesSeen(UNSIGNED3 srcCount,STRING2 twoLetterIdentifier) := FUNCTION
         res :=  srcCount = 1 AND (NOT(mdr.sourcetools.SourceIsCorpV2(twoLetterIdentifier)))
                    AND twoLetterIdentifier <> mdr.sourcetools.src_Business_Registration;
         RETURN (res);
    END;
    
     EXPORT NoCorpBiplinkidsExists(BOOLEAN NoCorpRecsExist) := FUNCTION                                                                                                        
          res := NoCorpRecsExist;
          RETURN(res);
     END; // function
                             
     EXPORT IsVacantAddress(STRING5 inZip5, STRING28 InStreetName, STRING10 InStreetNumber) := FUNCTION                                                                                       
           res := PROJECT(Advo.Key_Addr1(zip = InZip5 and prim_range = InStreetNumber AND prim_name = InStreetName), 
           TRANSFORM({STRING1 address_vacancy_indicator;}, SELF := LEFT));                                                                          
          RETURN (res[1].address_vacancy_indicator = 'Y');                            
     END; // function
                        
                        // last activity on business > 12 months ago - could possibly use the addressToDate in the bestsection here.
     EXPORT NoRecentBusinessActivity(iesp.share.t_date ToDate) := FUNCTION
         STRING8 CurDate := (STRING8) STD.Date.today();
                   UNSIGNED4 InDate := (UNSIGNED4) iesp.ecl2esp.t_DateToString8(ToDate); 
                   UNSIGNED4 OneYearBack := (UNSIGNED4)  ( (STRING4)   ( (UNSIGNED2) (curdate[1..4]) - 1)     +  curDate[5..6] + curDate[7..8]);                     
                    RETURN(Indate < OneYearBack);
      END; // function
   
       EXPORT NoFirmagraphicsData (  BOOLEAN  AnnualSalesIsZeroOrNotExistSiccodes   ) := FUNCTION        
           res := AnnualSalesIsZeroOrNotExistSiccodes;
           RETURN (res);
       END; // function
    
   // Business established less than one year ago
       EXPORT BusinessisLessThanOneYearBack(INTEGER2 YearStarted) := FUNCTION
          STRING8 CurDate := (STRING8) STD.Date.today();
          UNSIGNED4 OneYearBack := (UNSIGNED4) (curdate[1..4]) - 1;   // +  curDate[5..6] + curDate[7..8]);
           RETURN (UNSIGNED4) (yearStarted) >= oneYearback;
       END; // function        
     
       EXPORT NoPhone(STRING10 phone) := FUNCTION
              res := Phone =  '';
              RETURN( res);
       END; // function
        
       EXPORT NoPeopleConnectionsToBusiness(UNSIGNED4  countBusinessContacts) :=  FUNCTION
             res :=  countBusinessContacts = 0;
             RETURN(res);
       END;
     
       EXPORT HighSourceCountSeen(UNSIGNED3 srcCount) := FUNCTION
            res := srcCount > 10;
            RETURN (res);
       END;
    
       EXPORT StrongPeopleToBusiness(UNSIGNED4 countBusinessContacts) := FUNCTION
            res :=  countBusinessContacts > 5;
            RETURN (res);
        END;
     
        EXPORT IsLongEstablishedBusiness(UNSIGNED4 InYearStarted) := FUNCTION
            STRING8 CurDate := (STRING8) STD.Date.today();
            UNSIGNED4 FiveYearBack := (UNSIGNED4) (curdate[1..4]) - 5;   // +  curDate[5..6] + curDate[7..8]);       
            res := InYearStarted < FiveYearBack;
            RETURN(res);
        END; // function
   
        EXPORT BusinessActivityIsLessThan3MonthsBack(iesp.share.t_date LastActivityDate) := FUNCTION
            STRING8 CurDate := (string8) STD.Date.today();           
            UNSIGNED4 ThreeMonthsBackDate := (UNSIGNED4) ut.date_math(CurDate, -90);
            UNSIGNED4 lastActivityDateUnsigned :=  (UNSIGNED4) (iesp.ecl2esp.t_DateToString8(LastActivityDate));
            res := lastActivityDateUnsigned >= ThreeMonthsBackDate;
             RETURN (res);       
        END; // function
             
           EXPORT UccActivity( BOOLEAN BooleanIn) :=  FUNCTION     
                 Res := BooleanIn;
                 RETURN(res);
            END;                 
                                                                                                 
 //   end of story #70 risk indicator code (business Evidence)
 
 // ****************************************************
 // start of story #153 risk indicator codes (business Risk).
 // *****************************************************        
    EXPORT Govdebarred(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                            ,STRING1 FETCH_LEVEL) := FUNCTION
           SamLinkids :=    SAM.key_linkID.kfetch(biplinkids,FETCH_LEVEL);
                    
            STRING8 CurDate := (string8) STD.Date.today();
              
            GovDebarredLayoutSlim := RECORD
                  BIPV2.IDlayouts.l_header_ids;
                  Boolean GovDebarred;                  
              END;
              
            recs := PROJECT(samLInkids, TRANSFORM(GovDebarredLayoutSlim,
            SELF.GovDebarred := Std.Str.ToUpperCase(LEFT.terminationDate) = 'INDEFINITE'
                              OR
                              ((UNSIGNED4) (Std.Str.ToUpperCase(LEFT.terminationdate))) >
                                            (UNSIGNED4)(CURdate);
             SELF := LEFT));
             res := EXISTS (recs);            
                              
         RETURN (res);
    END;
         
    EXPORT  BusinessHasNodORForeclosure(INTEGER NodForeclosureCount) := FUNCTION
        res :=  NodForeclosureCount >= 1;    
        RETURN(res);
    END;
                                
    EXPORT BankruptcyDebtorBipLiplinkidsExists(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                                           ,STRING1 FETCH_LEVEL) := FUNCTION
          recs := Topbusiness_services.bankruptcySection.GetBankruptcyBipLinkids( biplinkids, FETCH_LEVEL);
          res := exists (recs(name_type[1] = 'D'));                                                                                                                                                                                       
          RETURN(res);
       END;
       
       EXPORT  LiensBipLinkidsWithinTwoYrs(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                                                               ,STRING1 FETCH_LEVEL) := FUNCTION        
           STRING8 CurDate := (STRING8) STD.Date.today();         
           smallLayout := RECORD
               	BIPV2.IDlayouts.l_header_ids;
                Liensv2.layout_liens_main_module.layout_liens_main.tmsid; 
		     Liensv2.layout_liens_main_module.layout_liens_main.rmsid;
                Liensv2.layout_liens_main_module.layout_liens_main.orig_filing_date;	
                unsigned4 OrigFilingDateNumeric;
           END;
            
           ds_linkids_keyrecs := Topbusiness_services.LienSection.GetLienBipLinkids(biplinkids, FETCH_LEVEL);
           ds_linkids_keyrecs_slimmed := (ds_linkids_keyrecs(name_type[1] = 'C' OR
	                                                          name_type[1] = 'D'));
           ds_linkids_keyrecs_deduped := DEDUP(SORT(ds_linkids_keyrecs_slimmed,
				                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),tmsid,rmsid),
				                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),tmsid,rmsid);                                                            
            ds_main_keyrecs := JOIN(ds_linkids_keyrecs_deduped,
	                                          LiensV2.Key_liens_main_ID(),
									KEYED(LEFT.tmsid = RIGHT.tmsid) AND
							           KEYED(LEFT.rmsid  = RIGHT.rmsid),														              
                  TRANSFORM(smallLayout; //TopBusiness_Services.LienSection_Layouts.rec_ids_with_maindata_slimmed,		              									
                       SELF.OrigFilingDateNumeric := if (LENGTH(TRIM(RIGHT.orig_filing_date,LEFT, RIGHT)) = 8, (UNSIGNED4) (RIGHT.orig_filing_date), 0);
			       SELF := RIGHT, // to pull off the Liens main key fields we want			           
			       SELF := LEFT,  				
                    ),		
		            LIMIT(10000) 
	            ) ;               
              // output(choosen(ds_main_keyrecs, 2500), named('ds_main_keyrecs'));
             YearString :=  (STRING4) (((UNSIGNED4) (CurDate[1..4])) - 2);
             TwoYrsBackDate :=  (UNSIGNED4) (YearString + curDate[5..8]);
             // output(TwoYrsBackDate, named('TwoYrsBackDate'));
             LiensRecsTwoYrsBack := ds_main_keyrecs(orig_filing_date <> '' AND OrigFilingDateNumeric >= TwoYrsBackDate);
             // recsSlim( ds_linkids_keyrecs_slimmed (fliter by just within last 2 yrs) // TODO 
             // output(LiensRecsTwoYrsBack, named('LiensRecsTwoYrsBack'));
             res := EXISTS(LiensRecsTwoYrsBack); 
             RETURN (res);
            END;
     
        EXPORT  ExecHasDerog (TopBusiness_Services.ContactSection_Layouts.rec_final   ContactSectionIn) := FUNCTION
              res := EXISTS(ContactSectionIn.CurrentExecutives(hasDerog)) OR EXISTS((ContactSectionIn.PriorExecutives(hasDerog)));      
              RETURN(res);
         END;
         
         EXPORT BusinessInHighRiskIndustry(TopBusiness_Services.IndustrySection_Layouts.rec_final   IndustrySectionIn) := FUNCTION
                       DsSics  := PROJECT(IndustrySectionIn.IndustryRecords.Sics, TRANSFORM(iesp.topbusinessReport.t_TopBusinessIndustrySIC,
                                       SELF := LEFT));                       
                       DsNaics := PROJECT(IndustrySectionIn.IndustryRecords.NAICSs, TRANSFORM(iesp.topbusinessReport.t_TopBusinessIndustryNAICS,
                                       SELF := LEFT));
 
              TempLayoutSIC := RECORD                   
                    STRING5 Sicindustry;
                    STRING5 SICRiskLevel;                       
               END;
                    
                TempLayoutNAICS := RECORD                      
                     STRING5 NaicsIndustry;
                     STRING5 NaicsRiskLevel;
                 END;         
                    
           BoolRiskLayout := RECORD
              BOOLEAN  cibRetailExists;
              BOOLEAN  cibNonRetailExists;
              BOOLEAN  msbExists;
              BOOLEAN  nbfiExists;
              BOOLEAN  cagExists;
              BOOLEAN  autoExists;
              BOOLEAN  legAcctTeleFlightTravExists;
              BOOLEAN  otherHighRiskIndustExists;
              BOOLEAN  moderateRiskIndustExists;
              BOOLEAN  lowRiskIndustExists;
              STRING6   sicCodes;
              STRING6   naicCodes;              
              END;
                                       
                    // ***
                    tempSic := PROJECT(DsSICS, TRANSFORM(TempLayoutSIC,
                    siccode := TRIM(LEFT.SicCode, LEFT,RIGHT);    
                    lengthOfSic := LENGTH(SicCode);                
                    SELF.SICIndustry := MAP(sicCode = DueDiligence.Constants.EMPTY => siccode,
				siccode IN DueDiligence.Constants.CIB_SIC_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL,
				siccode IN DueDiligence.Constants.CIB_SIC_NON_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL,
				siccode IN DueDiligence.Constants.MSB_SIC => DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS,
				siccode IN DueDiligence.Constants.NBFI_SIC => DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS,
				siccode IN DueDiligence.Constants.CASGAM_SIC => DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING,
				siccode IN DueDiligence.Constants.LEGTRAV_SIC => DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL,
				siccode IN DueDiligence.Constants.AUTO_SIC => DueDiligence.Constants.INDUSTRY_AUTOMOTIVE,
				DueDiligence.Constants.INDUSTRY_OTHER);
																																																	
                    SELF.SICRiskLevel := MAP(siccode = DueDiligence.Constants.EMPTY => siccode,
				lengthOfSic = 2 AND siccode IN DueDiligence.Constants.SIC_LENGTH_2_RISK_HIGH => DueDiligence.Constants.RISK_LEVEL_HIGH,
				lengthOfSic = 4 AND (siccode IN DueDiligence.Constants.SIC_LENGTH_4_RISK_HIGH OR siccode[1..2] IN DueDiligence.Constants.SIC_FIRST_2_STAR_RISK_HIGH) => DueDiligence.Constants.RISK_LEVEL_HIGH,
				lengthOfSic = 6 AND (siccode IN DueDiligence.Constants.SIC_LENGTH_6_RISK_HIGH OR siccode[1..2] IN DueDiligence.Constants.SIC_FIRST_2_STAR_RISK_HIGH OR
															siccode[1..4] IN DueDiligence.Constants.SIC_FIRST_4_STAR_RISK_HIGH) => DueDiligence.Constants.RISK_LEVEL_HIGH,
				lengthOfSic = 8 AND (siccode IN DueDiligence.Constants.SIC_LENGTH_8_RISK_HIGH OR siccode[1..2] IN DueDiligence.Constants.SIC_FIRST_2_STAR_RISK_HIGH OR
															siccode[1..4] IN DueDiligence.Constants.SIC_FIRST_4_STAR_RISK_HIGH OR
															siccode[1..6] IN DueDiligence.Constants.SIC_FIRST_6_STAR_RISK_HIGH) => DueDiligence.Constants.RISK_LEVEL_HIGH,
				DueDiligence.Constants.RISK_LEVEL_LOW);
              ));
                            
				tempNaics := PROJECT(DsNaics, TRANSFORM(TempLayoutNAICS,									
                          naic := TRIM(LEFT.NAICS, ALL);
                          naic2 := naic[1..2];	            
                          SELF.NAICSIndustry := MAP(naic = DueDiligence.Constants.EMPTY => naic,
					naic IN DueDiligence.Constants.CIB_NAICS_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL,
					naic IN DueDiligence.Constants.CIB_NAICS_NON_RETAIL => DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL,
					naic IN DueDiligence.Constants.MSB_NAICS => DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS,
					naic IN DueDiligence.Constants.NBFI_NAICS => DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS,
					naic IN DueDiligence.Constants.CASGAM_NAISC => DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING,
					naic IN DueDiligence.Constants.LEGTRAV_NAISC => DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL,
					naic IN DueDiligence.Constants.AUTO_NAISC => DueDiligence.Constants.INDUSTRY_AUTOMOTIVE,
					DueDiligence.Constants.INDUSTRY_OTHER);
													
                          SELF.NAICSRiskLevel := MAP(naic = DueDiligence.Constants.EMPTY => naic,
					naic2 IN DueDiligence.Constants.NAICS_RISK_HIGH OR
					naic IN DueDiligence.Constants.NAICS_RISK_HIGH_EXCEP => DueDiligence.Constants.RISK_LEVEL_HIGH,
					naic2 IN DueDiligence.Constants.NAICS_RISK_MED => DueDiligence.Constants.RISK_LEVEL_MEDIUM,
					naic2 IN DueDiligence.Constants.NAICS_RISK_LOW => DueDiligence.Constants.RISK_LEVEL_LOW,
					DueDiligence.Constants.RISK_LEVEL_LOW);          
          ));
         
                  BoolRiskLayout  RiskCodeBooleans() := TRANSFORM                       
                              // indust Flag 9                          
                            SELF.cibNonRetailExists := EXISTS(TempSic (SICIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL)) OR 
														 EXISTS(TempNaics(NAICsIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL));
                                   // industry Flag 8                             
                            SELF.cibRetailExists :=  EXISTS(tempSic(SicIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL)) OR 
													 EXISTS(tempNaics(NAICSIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL));
                            
                                    // industry Flag 7
                            SELF.msbExists :=  EXISTS(TempSic(SICIndustry = DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS)) OR 
										         EXISTS(TempNaics(NAICsIndustry = DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS));
                                    // industry Flag 6
                            SELF.nbfiExists := EXISTS(TempSic(SICIndustry = DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS)) OR 
										       EXISTS(TempNaics(NAICsIndustry = DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS));
                                  // industry Flag 5
                            SELF.cagExists := EXISTS(TempSic(SICIndustry = DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING))  OR 
										     EXISTS(TempNAICS(NAICsIndustry = DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING));
                                 // industry Flag 4
                            SELF.legAcctTeleFlightTravExists :=  EXISTS(TempSic(SICIndustry = DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL)) OR 
																	EXISTS(TempNaics(NAICsIndustry = DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL));
                                // industry Flag 3
                            SELF.autoExists := EXISTS(TempSic(SICIndustry = DueDiligence.Constants.INDUSTRY_AUTOMOTIVE)) OR 
										       EXISTS(tempNAICS(NAICsIndustry = DueDiligence.Constants.INDUSTRY_AUTOMOTIVE));
                          
                                     // industry Flag 2
                            SELF.otherHighRiskIndustExists := EXISTS(tempSic(SICRiskLevel = DueDiligence.Constants.RISK_LEVEL_HIGH AND SICIndustry = DueDiligence.Constants.INDUSTRY_OTHER)) OR
																    EXISTS(TempNAICS(NAICSRiskLevel = DueDiligence.Constants.RISK_LEVEL_HIGH AND NAICSIndustry = DueDiligence.Constants.INDUSTRY_OTHER));								
                                           // industry Flag 1
                           // SELF.moderateRiskIndustExists := EXISTS(TempNAICS(NAICSRiskLevel = DueDiligence.Constants.RISK_LEVEL_MEDIUM));
                                             // industry Flag 
                           // SELF.lowRiskIndustExists := EXISTS(TempSic(SICRiskLevel = DueDiligence.Constants.RISK_LEVEL_LOW)) OR 
															// EXISTS(tempNaics(NAICSRiskLevel = DueDiligence.Constants.RISK_LEVEL_LOW));
                                                  // SELF.sicCodes := RIGHT.sicCode;
                                                  // SELF.naicCodes := RIGHT.naicCode;                                    
                                      SELF := []
                       END;
             resultsDS := DATASET([ RiskCodeBooleans() ]);	
             res := EXISTS(resultsDS(cibNonRetailExists OR cibRetailExists OR msbExists  OR nbfiExists OR cagExists OR legAcctTeleFlightTravExists
                                                               OR autoExists OR otherHighRiskIndustExists));
                       // output(tempSic, named('tempSic'));
          // output(tempNaics, named('tempNaics'));
              // output(resultsDs, named('resultsDs'));                                                                                          
                             
         // Business has a value of 2-9 in the Due Diligence Business Attribute: Business Industry    
//DueDiligence.Common.calcFinalFlagField
             RETURN(res);
         END;
         
         EXPORT  LiensBipLinkidsHighCount(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                                                       ,STRING1 FETCH_LEVEL) := FUNCTION                                                                          
             ds_linkids_keyrecs := Topbusiness_services.LienSection.GetLienBipLinkids(biplinkids, FETCH_LEVEL);                                         
             ds_linkids_keyrecs_slimmed :=ds_linkids_keyrecs(name_type[1] = 'C' OR 
	                                                          name_type[1] = 'D'); 
             RETURN (COUNT(ds_linkids_keyrecs_slimmed) > 5); // to do make constant.                                                                      
          END;
        
          EXPORT BusinessHasB2BDelinquency(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                                                               ,STRING1 FETCH_LEVEL) := FUNCTION
              dsBipLinkids := PROJECT(biplinkids, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
                                                  SELF := LEFT; SELF := []));
              corteraTradeLineLinkids := Cortera_Tradeline.Key_LinkIds.kfetch2(dsBipLinkids
                                                                                           , FETCH_LEVEL
                                                                                           ,  // take default
                                                                                           ,1 // only need to find existence so use 1 for keep constant
                                                                                           // take default on last param jointype
                                                                                           );                                                                                                                                          
              res := EXISTS(corteraTradeLineLinkids);
              RETURN(res);
          END;
        
        EXPORT NonExecHasDerog(DATASET(iesp.topbusinessReport.t_TopBusinessIndividual)   PriorIndividuals
                                                         ,DATASET(iesp.topbusinessReport.t_TopBusinessIndividual)  CurrentIndividuals
                                                ) := FUNCTION             
             res := EXISTS(PriorIndividuals) OR 
                       EXISTS(CurrentIndividuals);                       
            RETURN(res);
        END;
        
        EXPORT BusinessHasNoRevenue(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                                                    ,STRING1 FETCH_LEVEL
                                                                     ,TopBusiness_Services.FinanceSection_Layouts.rec_final   FinanceSectionIn
                                                                    ) := FUNCTION
               NoRevenue :=  EXISTS(FinanceSectionIn.Finances(AnnualSales = '0')) OR  (NOT(EXISTS(FinanceSectionIn.Finances)));
               ds_corpLinkidsRecs := topBusiness_services.IncorporationSection.GetCorpBipLinkids(biplinkids, FETCH_LEVEL);
               ds_corprecsSlim := DEDUP(SORT(ds_corpLinkidsRecs,#expand(BIPV2.IDmacros.mac_ListTop3Linkids())),
                                                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()));
               
                 ds_corprecs := JOIN(ds_corprecsSlim,
	                    Corp2.keys().Corp.corpkey.qa, //???
			                KEYED(LEFT.corp_key = RIGHT.corp_key),
                                 TRANSFORM(right));											     
		      isProfitCompany  := 	EXISTS(ds_corprecs(record_type = 'C' AND corp_for_profit_ind = 'Y'));
                 res := IsProfitCompany AND NoRevenue;
                 // output(ds_corprecs, named('ds_corprecs'));                 
               RETURN(res);  //Business has no revenue on file
          END;
          
          EXPORT BusinessHasNoRealProperty(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                                                               ,STRING1 FETCH_LEVEL) := FUNCTION
               tmpRes := EXISTS(TopBusiness_Services.Key_Fetches(biplinkids,                        
									FETCH_LEVEL,
									TopBusiness_Services.Constants.PropertyKfetchMaxLimit
									).ds_prop_linkidskey_recs);
                 Res := NOT(tmpRes);                  
                 RETURN(res);
           END;
           
           EXPORT BusinessHasNoPersonalAssets(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                                                                   ,STRING1 FETCH_LEVEL) := FUNCTION
                    resMVR             :=  EXISTS(TopBusiness_Services.Key_Fetches(biplinkids
									                ,FETCH_LEVEL
                                                                 , TopBusiness_Services.Constants.SlimKeepLimit									
									                 ).ds_prop_linkidskey_recs);
                    resWaterCraft  :=  EXISTS(TopBusiness_Services.Key_Fetches(biplinkids                        
                                                                    ,FETCH_LEVEL									
                                                                   ).ds_wc_linkidskey_recs);
                    resAircraft       :=  EXISTS(TopBusiness_Services.Key_Fetches(biplinkids
                                                                 ,FETCH_LEVEL
                                                                    ).ds_airc_linkidskey_recs);
                    res := NOT (resMVR OR ResWatercraft OR resAircraft);
                    RETURN(res);
             END;
             
             
               EXPORT RecentUCCActivity(BOOLEAN  InBoolean
                                                              ) := FUNCTION                                                              
                   a := 0;                                                                                                                                                               
                   RETURN(InBoolean);      
                END;
                
              EXPORT BusinessInHighCrimeLocation(TopBusiness_Services.BestSection_Layouts.final   BestSectionIn) := FUNCTION
                // code call to Due Diligence  below and all logic used from that product to determine this risk Indicator
                
        // BOOLEAN     validFIPSCode;                          //populated in DueDiligence.Common.getGeographicRisk
        // STRING50    CountyName;                             //populated in DueDiligence.Common.getGeographicRisk 
        // BOOLEAN     CountyHasHighCrimeIndex;                //populated in DueDiligence.Common.getGeographicRisk
        // BOOLEAN     CountyBordersForgeinJur;                //populated in DueDiligence.Common.getGeographicRisk
        // BOOLEAN     CountyBorderOceanForgJur;               //populated in DueDiligence.Common.getGeographicRisk
        // BOOLEAN     CityBorderStation;                      //populated in DueDiligence.Common.getGeographicRisk
        // BOOLEAN     CityFerryCrossing;                      //populated in DueDiligence.Common.getGeographicRisk
        // BOOLEAN     CityRailStation;                        //populated in DueDiligence.Common.getGeographicRisk
        // BOOLEAN     HIDTA;                                  //populated in DueDiligence.Common.getGeographicRisk   High Intensity Drug Trafficking Area
        // BOOLEAN     HIFCA;                                  //populated in DueDiligence.Common.getGeographicRisk  High Intensity Financial Crime Area
    // BOOLEAN     censusRecordExists;                     //populated in DueDiligence.Common.getGeographicRis    
    
     DueDiligence.layoutsInternal.GeographicLayout  DDGeoRiskLayout() := TRANSFORM                            
                        SELF.seq := 1;
                         SELF.prim_range := BestSectionIn.Address.StreetNumber;
	                  SELF.predir := BestSectionIn.address.StreetPreDirection;
	                  SELF.prim_name  := BestSectionIn.address.StreetName;
	                   SELF.addr_suffix := BestSectionIn.address.StreetSuffix;
	                    SELF.postdir := BestSectionIn.address.StreetPostDirection;
	                    SELF.unit_desig := BestSectionIn.address.UnitDesignation;
	                     SELF.sec_range := BestSectionIn.address.UnitNumber;
	                     SELF.city := BestSectionIn.address.City;
	                     SELF.state := BestSectionIn.address.State;
	                     SELF.zip5 := BestSectionIn.address.zip5;
	                     SELF.zip4 := BestSectionIn.address.zip4;                           
                           SELF := [];
                           END;
                           
                             inDS := DATASET([ DDGeoRiskLayout() ]);		
                                         
                     GeoGraphicRisk := DueDiligence.Common.getGeographicRisk(inDS, True); 
                                                                                                                                           //  ^^^^ have to set this to true
                                                                                                                                           // to clean input address data so that other
                                                                                                                                           // fields such as geo_blk, county (in digits) can be filled in

 // IF(le.CountyHasHighCrimeIndex AND le.CountyBordersForgeinJur AND (le.HIDTA OR le.HIFCA), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);										                                                                                                                                           
                                                                                                                                           
     // BusGeoRisk_Flag5 := IF(le.CountyHasHighCrimeIndex AND (le.HIDTA OR le.HIFCA), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                             												
    // BusGeoRisk_Flag4 := IF(le.CountyHasHighCrimeIndex, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                    		                                                                                                                                                                                                    
                     
                    // output(GeoGraphicRisk, named('GeographicRisk'));
                       
                       res :=  EXISTS(GeographicRisk(CountyHasHighCrimeIndex)) // BusGeoRisk_Flag4
                                          OR  EXISTS(GeographicRisk(CountyHasHighCrimeIndex AND (  HIDTA OR HIFCA))) // BusGeoRisk_Flag5
                                          OR EXISTS(GeographicRisk(CountyHasHighCrimeIndex AND CountyBordersForgeinJur AND (HIDTA OR HIFCA))); // BusGeoRisk_Flag9                                                                                  
                                               // HIDTA -  High Intensity Drug Trafficking Area
                                               // HIFCA -  High Intensity Financial Crime Area

                       RETURN (res);                       
                       END;                       
                
                EXPORT  IsPOBoxAddress(STRING5 inZip5
                                                              ,STRING28 InStreetName
                                                              ,STRING10 InStreetNumber) := FUNCTION
                               TmpResult := PROJECT(Advo.Key_Addr1(zip = InZip5 and prim_range = InStreetNumber AND prim_name = InStreetName), // could do more indexed fields here??
                                           TRANSFORM({STRING1 RECORD_TYPE_CODE;}, SELF := LEFT));
                                res  := exists (TmpResult(RECORD_TYPE_CODE = 'P')); // P  => PO box                                         
                    RETURN(res);
                END;                                                                                                                                         
                
                EXPORT  ResidentialOrBusinessAddressType(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                                              ,STRING1 FETCH_LEVEL
                                                              // ,UNSIGNED4 FETCH_LIMIT 
                                                              ,STRING1 ResidentialOrBusiness // R OR B
                                                                         ) := FUNCTION
                     ds_busHeaderRecsRaw := 
                                           BIPV2.Key_BH_Linking_Ids.kfetch( biplinkids
                                               , FETCH_LEVEL
                                                 ,
                                                ,
                                                , 7500
                                                 , TRUE
                                                 , TRUE // only do this since no contacts being pulled here
                                                   ,
                                                  ,
                                                  ,
                                                 )                                                                                                                                
                                                  (source <> MDR.sourceTools.src_Dunn_Bradstreet);
                      ds_bipheaderRecsSlim := SORT(ds_busHeaderRecsRaw(dt_first_seen <> 0), dt_first_seen);                                      
                      res :=   ds_bipheaderRecsSlim[1].Address_type_derived =  ResidentialOrBusiness;  // address_type_derived set by bip linking team.                                                   																			                                                        
                 RETURN(res);                   
                 END;              
                 
                 EXPORT  BusinessHasNewLocation (TopBusiness_Services.BestSection_Layouts.final   BestSectionIn)  := FUNCTION           
                     FromdateFinal := IF (BestSectionIn.phoneFromDate.year=0, BestSectionIn.AddressFromDate,
                          BestSectionIn.PhoneFromDate);
                      STRING8 CurDate := (STRING8) STD.Date.today();
                     UFromDate := (UNSIGNED4) (iesp.ecl2esp.DateToString(FromdateFinal));                   
                     XYearBack := ((UNSIGNED4) (CurDate[1..4])) - 1;   
                     UNSIGNED4 XYearBackFinal := (UNSIGNED4)( (STRING4) (XYearBack) +  curDate[5..6] + curDate[7..8] );
                     res :=     UFromDate > XYearBackFinal;         
                     RETURN (res);
                 END;
                 
                  EXPORT BusinessHasNoDerog(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                                               ,STRING1 FETCH_LEVEL
                                                               ,TopBusiness_Services.ContactSection_Layouts.rec_final   ContactSectionIn  )  := FUNCTION                 
                     res1  :=      NOT ( EXISTS(ContactSectionIn.PriorIndividuals(hasDerog)) OR 
                                                 EXISTS(ContactSectionIn.CurrentIndividuals(hasDerog)) OR
                                                 EXISTS(ContactSectionIn.CurrentExecutives(hasDerog)) OR
                                                 EXISTS(ContactSectionIn.PriorExecutives(hasDerog))
                                               );
                    bkRecs :=   EXISTS( TopBusiness_services.BankruptcySection.GetBankruptcyBipLinkids(
                                                                                biplinkids
                                                                               ,FETCH_LEVEL
                                                                               )(name_type[1] = 'D')
                                             ); // filter out BK recs who have BIP linkids as Debtor
                    JandLRecs := EXISTS( Topbusiness_services.LienSection.GetLienBipLinkids(
                                                                       biplinkids
                                                                      ,FETCH_LEVEL
                                                                   )(name_type[1] = 'C' OR
	                                                          name_type[1] = 'D')
                                                       );
                    UccRecs := EXISTS(Topbusiness_services.UccSection.GetUCCBipLinkids(
                                                        biplinkids
                                                      ,FETCH_LEVEL
                                                      ,10000 // todo make constant here
                                                                   )(party_type != 'A')
                                                      );
                                            res := res1 and (NOT(BkRecs OR JandLRecs OR uccRecs));
                       RETURN(res);
                   END;
                 
                   EXPORT BusinessHasCurrentProperty(INTEGER CurrentPropertyRecordsCount ) := FUNCTION
                       res := CurrentPropertyRecordsCount > 0;
                       RETURN(res);
                   END;
                   
                   EXPORT BusinessHasCurrentAssets(INTEGER CurrentMVRCount
                                                                                   ,INTEGER CurrentWatercraftCount
                                                                                   ,INTEGER CurrentAircraftCount) := FUNCTION                                                                                   
                       res := CurrentMVRCount > 0 OR CurrentWatercraftCount > 0 OR CurrentAircraftCount > 0;
                       RETURN(res);
                   END;                                                                                   
                                                                                                   
                   EXPORT BusinessHasRevenueAndIsProfit(DATASET (BIPV2.IDlayouts.l_xlink_ids) biplinkids
                                           ,STRING1 FETCH_LEVEL
                                             ,TopBusiness_Services.FinanceSection_Layouts.rec_final   FinanceSectionIn
                                             ) := FUNCTION                      
                       HasRevenue :=  EXISTS(FinanceSectionIn.Finances( ((UNSIGNED4) (AnnualSales))  > 0)); 
                       ds_corpLinkidsRecs :=
                               topBusiness_services.IncorporationSection.GetCorpBipLinkids(biplinkids, FETCH_LEVEL);
                       ds_corprecsSlim := DEDUP(SORT(ds_corpLinkidsRecs,
														        #expand(BIPV2.IDmacros.mac_ListTop3Linkids())),
                                                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()));
               
                       ds_corprecsInfo := JOIN(ds_corprecsSlim,
	                                     Corp2.keys().Corp.corpkey.qa, //???
			                           KEYED(LEFT.corp_key = RIGHT.corp_key),
                                           TRANSFORM(RIGHT));
											      // and right.record_type='C" // no since deduping below??? 
		             isProfitCompany  := 	EXISTS(ds_corprecsInfo(record_type = 'C' AND corp_for_profit_ind = 'Y'));
                        res := IsProfitCompany AND HasRevenue;
                        // output(ds_corprecsInfo, named('ds_corprecsInfo'));                 
                     RETURN(res);  //Business has no revenue on file              
                 END;                                                                               
                                                
            // place holder for function  ResidentialOrBusinessAddressType (overloaded to reuse code above by passing 'B')

                EXPORT BusinessHasHighRevenue(
                                  TopBusiness_Services.FinanceSection_Layouts.rec_final   FinanceSectionIn
                                 ) := FUNCTION
                       res :=    EXISTS(FinanceSectionIn.Finances( ((UNSIGNED4) (AnnualSales))  > 1000000));               
                      RETURN(res);
                 END;
 // ****************************************************
 // END of story #153 risk indicator codes (business Risk).
 // *****************************************************                                                                                   
              		
    END; // businessInsightfunction module 