Import  BIPv2, MDR, TopBusiness_Services , iesp, Advo, STD, ut, SAM, property, DueDiligence;
             
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
                                            ) := FUNCTION
           SamLinkids :=    SAM.key_linkID.kfetch(biplinkids, bipv2.idconstants.Fetch_Level_SELEID);
                    
            STRING8 CurDate := (STRING8) STD.Date.today();
              
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
             res := EXISTS (recs(GovDeBarred));                                          
         RETURN (res);
    END;
         
    EXPORT  BusinessHasNodORForeclosure(BOOLEAN BusHasNodORForeclosure) := FUNCTION
        res :=  BusHasNodORForeclosure;
        RETURN(res);
    END;

    EXPORT BankruptcyDebtorBipLiplinkidsExists(Boolean bkDeptorExists) := FUNCTION
        res :=  bkDeptorExists;
        RETURN(res);
     END;
     
     EXPORT LiensBipLinkidsWithinTwoYrs(Boolean LiensWithintwoYrs) := FUNCTION
          res := LiensWithintwoYrs;
          RETURN(res);
      END;
     
     EXPORT ExecHasDerog(Boolean ExecHasDerog) := FUNCTION
         res := ExecHasDerog;
         RETURN(res);
     END;                                  
                  
     // this code is from Due Diligence.
     // just pass in a dataset of SIC and NAICS codes and it does the calculation.
    EXPORT BusinessInHighRiskIndustry( DATASET({STRING8 SicCode;})   BestSicDS
                                                                        ,DATASET({STRING8 NaicsCode;}) BestNaicsDS) := FUNCTION        
              TempLayoutSIC := RECORD                   
                    STRING5 Sicindustry;
                    STRING5 SICRiskLevel;                       
               END;
                    
                TempLayoutNAICS := RECORD                      
                     STRING5 NaicsIndustry;
                     STRING5 NaicsRiskLevel;
                 END;                                   
              
              BoolriskLayout := RECORD
                boolean NineExists;
                Boolean EightExists;
                boolean sevenExists;
                boolean sixExists;              
                END;
                                                    
               tempSicBest := PROJECT(BestSicDS, TRANSFORM(TempLayoutSIC,
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
                                         
                 tempNaicsBest := PROJECT(BestNaicsDS, TRANSFORM(TempLayoutNAICS,
                          naic := TRIM(LEFT.NAICSCode, ALL);
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
                            
                              // indust Flag 9                // just primary                                     
                            SELF.NineExists :=  
                                                              EXISTS(TempSicBest(SICIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL)) OR 
                                                              EXISTS(TempNaicsBest(NAICsIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_NON_RETAIL)) OR 
                                                              EXISTS(TempSicBest(SicIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL)) OR 
                                                              EXISTS(TempNaicsBest(NAICSIndustry = DueDiligence.Constants.INDUSTRY_CASH_INTENSIVE_BUSINESS_RETAIL));   
                                   // industry Flag 8       // just primary                                                 
                            SELF.EightExists :=  EXISTS(TempSicBest(SICIndustry = DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS)) OR     // 7
										         EXISTS(TempNaicsBest(NAICsIndustry = DueDiligence.Constants.INDUSTRY_MONEY_SERVICE_BUSINESS)) OR                
                                                              EXISTS(TempSicBest(SICIndustry = DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS)) OR   // 6
										         EXISTS(TempNaicsBest(NAICsIndustry = DueDiligence.Constants.INDUSTRY_NON_BANK_FINANCIAL_INSTITUTIONS)) OR                           
                                                              EXISTS(TempSicBest(SICIndustry = DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING))  OR   // 5
	                                                         EXISTS(TempNAICSBest(NAICsIndustry = DueDiligence.Constants.INDUSTRY_CASINO_AND_GAMING));
                                                            
                                    // industry Flag 7 // just primary                        
                            SELF.SevenExists :=   EXISTS(TempSicBest(SICIndustry = DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL)) OR  // 4
												 EXISTS(TempNaicsBest(NAICsIndustry = DueDiligence.Constants.INDUSTRY_LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL)) OR
                                                                 EXISTS(TempSicBest(SICIndustry = DueDiligence.Constants.INDUSTRY_AUTOMOTIVE)) OR  // 3
                                                                 EXISTS(TempNAICSBest(NAICsIndustry = DueDiligence.Constants.INDUSTRY_AUTOMOTIVE));      
                            
                                    // industry Flag 6                      
                            SELF.SixExists := EXISTS(TempSicBest(SICRiskLevel = DueDiligence.Constants.RISK_LEVEL_HIGH AND SICIndustry = DueDiligence.Constants.INDUSTRY_OTHER)) OR // 2
                                                          EXISTS(TempNAICSBest(NAICSRiskLevel = DueDiligence.Constants.RISK_LEVEL_HIGH AND NAICSIndustry = DueDiligence.Constants.INDUSTRY_OTHER));								                          
                                SELF := [];
                       END;
                        resultsDS := DATASET([ RiskCodeBooleans() ]);	
                        
                                 // any of industry flags 6-9
                 res := EXISTS( resultsDS( NineExists OR  EightExists OR SevenExists  OR SixExists));                       
              // output(tempSic, named('tempSic'));
              // output(tempNaics, named('tempNaics'));
                   // output(tempSicBest, named('tempSicBest'));
             // output(tempNaicsBest,named('tempNaicsBest'));        
             // output(resultsDS, named('resultsDS'));                                    
             RETURN(res);
         END;         
          EXPORT  LiensBipLinkidsHighCount(Boolean HighLiensCount) := FUNCTION
                res :=  HighLiensCount;
               RETURN(res);
          END;
          
          EXPORT  BusinessHasB2BDelinquency(boolean BusB2BDeliquency)  := FUNCTION
               res := BusB2Bdeliquency;
               RETURN(res);
          END;
          
          EXPORT NonExecHasDerog(boolean NonExecDerog) := FUNCTION
               res := NonExecDerog;
               RETURN(res);
           END;
                
            EXPORT BusinessHasNoRevenue(BOOLEAN busNoRevenue) := FUNCTION
               res := BusNoRevenue;
               RETURN(res);
            END;
                              
          EXPORT BusinessHasNoRealProperty( BOOLEAN BusNoRealProperty) := FUNCTION
             Res := BusNoRealProperty;
             RETURN(Res);
          END;
               
           EXPORT BusinessHasNoPersonalAssets(BOOLEAN BusHasNoPersonalAssets) := FUNCTION
                 res := BusHasNoPersonalAssets;
                 RETURN(res);
            END;
            
           // place holder for RecentUCCActivity  see above function UccActivity

              EXPORT BusinessInHighCrimeLocation( dataset(DueDiligence.layoutsInternal.GeographicLayout)   InDueDiligenceAddress    
              ) := FUNCTION
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
                     
       GeoGraphicRisk := DueDiligence.CommonAddress.getAddressRisk(InDueDiligenceAddress, True); 
                                                                                                                                                                          //  ^^^^ have to set this to true
                                                                                                                                                                          //  so that other necessary
                                                                                                                                                                          // fields  can be filled in

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
                
                EXPORT  IsBusinessOrPOBoxOrResidentAddress(STRING5 inZip5
                                                              ,STRING28 InStreetName
                                                              ,STRING10 InStreetNumber
                                                               ,STRING1  BusinessOrPoBoxOrResidence) := FUNCTION
                    TmpResult := PROJECT(Advo.Key_Addr1(zip = InZip5 and prim_range = InStreetNumber AND prim_name = InStreetName), 
                                           TRANSFORM({STRING1 RECORD_TYPE_CODE; STRING1 RESIDENTIAL_OR_BUSINESS_IND;}, SELF := LEFT));                                   
                              resPOBox  := EXISTS(TmpResult(RECORD_TYPE_CODE = BusinessOrPoBoxOrResidence));                              
                              res :=  MAP(BusinessOrPoBoxOrResidence = 'P' AND resPOBOX => TRUE,
                                                      // below codes from Advo.Delivery_Type_Description_lookup
                                  BusinessOrPOBoxOrResidence = 'B' AND  (tmpResult[1].RESIDENTIAL_OR_BUSINESS_IND = 'B' OR
                                             tmpResult[1].RESIDENTIAL_OR_BUSINESS_IND = 'D' )  => TRUE,
                                  BusinessOrPOBoxOrResidence = 'R' AND  (tmpResult[1].RESIDENTIAL_OR_BUSINESS_IND = 'A' OR
                                               tmpResult[1].RESIDENTIAL_OR_BUSINESS_IND = 'C' ) => TRUE,
                                   FALSE);                                                          
                    RETURN(res);
                END;                                                                                                                                         
                            
                 EXPORT  BusinessHasNewLocation(Boolean BusHasNewLocation) := FUNCTION
                       Res := BusHasNewLocation;
                       RETURN(Res);
                  END;
                  
                  EXPORT BusinessHasNoDerog (Boolean BusHasNoDerog) := FUNCTION
                       Res := BusHasNoDerog;
                       RETURN(Res);
                  END;
                    
                   EXPORT BusinessHasCurrentProperty(BOOLEAN BusHasCurrentProperty ) := FUNCTION
                       res := BusHasCurrentProperty;
                       RETURN(res); 
                   END;
                   
                   EXPORT BusinessHasCurrentAssets(BOOLEAN BusHasCurrentAssets) := FUNCTION                                                                                   
                       res := BusHasCurrentAssets;
                       RETURN(res);
                   END;                                     
                   
                   EXPORT BusinessHasRevenueAndIsProfit (BOOLEAN BusHasRevenueAndIsProfit) := FUNCTION
                        res := BusHasRevenueAndIsProfit;
                        RETURN(res);
                   END;
                   
                // place holder for AddressIsBusinessAddress see function above
                // IsBusinessOrPOBoxOrResidentAddress

                EXPORT BusinessHasHighRevenue(BOOLEAN BusHasHighRevenue) := FUNCTION                                           
                       res :=  BusHasHighRevenue;    
                      RETURN(res);
                END;
 // ****************************************************
 // END of story #153 risk indicator codes (business Risk).
 // *****************************************************                                                                                   
              		
    END; // businessInsightfunction module 