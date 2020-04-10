IMPORT BIPV2, iesp, topbusiness_services;

EXPORT BusinessInsightSection := MODULE
    SHARED  outLayout := RECORD
         BIPV2.IDlayouts.l_key_ids_bare - [proxid, powid, empid, dotid];
          iesp.topbusinessReport.t_TopBusinessBusinessInsightSection;       
    END;
 EXPORT fn_FullView(
 	DATASET(BIPV2.IDlayouts.l_xlink_ids) biplinkids
	,Layouts.rec_input_options  in_options
      ,TopBusiness_Services.BestSection_Layouts.Final bestSectionIn  
      ,TopBusiness_Services.ContactSection_Layouts.rec_final ContactSectionIn    
      ,UNSIGNED3 SourceCount
      ,STRING2  SourceIdentifier
      ,TopBusiness_Services.FinanceSection_Layouts.rec_final FinanceSectionIn
	     ) := FUNCTION
                   
      FETCH_LEVEL := in_options.BusinessReportFetchLevel;
       
     outLayout   BusinessEvidence() := TRANSFORM           
          // val1 := false;
          val1 :=  topbusiness_services.BusinessInsightFunctions.IsBusinessDefunct(bestSectionIn.isDefunct); // this includes the override using phone gong EDA current field to deal with recycled land lines
          BusinessEvidences1 := DATASET([{val1, 'H', 'Business is Defunct'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
             //  this includes the override using phone gong EDA current field to deal with recycled land lines
          // val2 := false
          val2 :=   topbusiness_services.BusinessInsightFunctions.BusinessIsInactive(bestSectionIn.isActive);
          BusinessEvidences2 :=   DATASET([{val2, 'H', 'Business is Inactive'}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
         //val3 := false;                                        
         val3 :=     topbusiness_services.BusinessInsightFunctions.TooFewSourcesSeen(sourceCount, SourceIdentifier);        
         BusinessEvidences3 :=   DATASET([{val3, 'H', 'Too few sources'}],
              iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);          
                                                           
        //val4 := false;
        val4 := topbusiness_services.BusinessInsightFunctions.CorpBiplinkidsExists(biplinkids, FETCH_LEVEL);        
        BusinessEvidences4 := DATASET([{val4,'M', 'No Secretary of State record'}],
              iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                   
         //val5 := false; // best address is reported as vacant // hitting advo key here.
         val5 :=  topbusiness_services.BusinessInsightFunctions.IsVacantAddress(bestSectionIn.address.zip5, bestSectionIn.address.StreetName, bestSectionIn.address.StreetNumber);
         BusinessEvidences5 := DATASET([{val5,'M', 'Best address reported as vacant'}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                   
         //val6 := false;                                                   
         val6 := topbusiness_services.BusinessInsightFunctions.NoRecentBusinessActivity(BestSectionIn.AddressToDate); // last activity on business > 12 months ago - could possibly use the addressToDate in the bestsection here.
         BusinessEvidences6 := DATASET([{val6,'M', 'No activity on business in last year'}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
         // val7 := false;
         val7 :=  topbusiness_services.BusinessInsightFunctions.NoFirmagraphicsData(biplinkids, FETCH_LEVEL,
          TopBusiness_Services.Constants.defaultJoinLimit, FinanceSectionIn);
         // false; // no firmographics data for business including SIC/NAICS, employee count, sales,
                                // would have to hit several keys in the best section
         BusinessEvidences7 := DATASET([{val7,'M', 'No Firmographic information for business '}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                   
         // val8 := false; // Business established less than one year ago
         val8 := topbusiness_services.BusinessInsightFunctions.BusinessIsLessThanOneYearBack(bestSectionIn.yearStarted);
         BusinessEvidences8 := DATASET([{val8,'M', 'Business established less than one year ago'}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                                       
         //val9 := false;                                                                       
         val9 := TopBusiness_services.BusinessInsightFunctions.NoPhone(bestSectionIn.PhoneInfo.Phone10);    // true if no phone in best.
         BusinessEvidences9 :=   DATASET([{val9, 'M', 'No phone on file'}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);  
          //val10 := false;
          val10 := topBusiness_services.BusinessInsightFunctions.NoPeopleConnectionsToBusiness(
                         ContactSectionIn.TotalPriorContactCount  +
                         ContactSectionIn.TotalCurrentContactCount +
                         ContactSectionIn.TotalCurrentExecutiveCount +
                         ContactSectionIn.TotalPriorExecutiveCount );                                                               
          //   No evidence of people connected to business     
         BusinessEvidences10 :=  DATASET([{val10, 'M', 'No evidence of people connected to business'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);           
                                                      
          //val11 := false;                                                      
          val11 :=  topbusiness_services.BusinessInsightFunctions.HighSourceCountSeen(SourceCount); 
         BusinessEvidences11 :=   DATASET([{val11, 'P', 'High source document count'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);           
                                                                                  
            //val12 := false;                                                             
           val12 := topbusiness_services.BusinessInsightFunctions.StrongPeopleToBusiness(
                        ContactSectionIn.TotalPriorContactCount  
                        +  ContactSectionIn.TotalCurrentContactCount
                        +  ContactSectionIn.TotalPriorExecutiveCount  
                        + ContactSectionIn.TotalCurrentExecutiveCount);           
          BusinessEvidences12 :=  DATASET([{val12, 'P', 'Strong evidence of people connected to business'}],
                   iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);  

      //val13 := false;
      val13 := topbusiness_services.BusinessInsightFunctions.IsLongEstablishedBusiness(bestSectionIn.yearStarted);
          BusinessEvidences13 :=  DATASET([{val13, 'P', 'Established business'}],
                iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);  
         
        //val14 := false;
       val14 := topbusiness_services.BusinessInsightFunctions.BusinessActivityIsLessThan3MonthsBack(bestSectionIn.addressToDate);
          BusinessEvidences14 :=  DATASET([{val14, 'P', 'Recent business activity'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);                                                      
 
        //val15 := false;    
        val15 := topbusiness_services.BusinessInsightFunctions.UccActivityWithinXYears(biplinkids,
                           FETCH_LEVEL, Topbusiness_services.constants.BusinessInsight.UCCBusinessInsightKfetchMaxLimit,5);        
         BusinessEvidences15 :=  DATASET([{val15, 'P', 'Evidence of UCC activity'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);     
                                                                                                           
       BusinessEvidencesNegativeIndicators := BusinessEvidences1 + BusinessEvidences2 + BusinessEvidences3 + BusinessEvidences4 + 
               BusinessEvidences5 + BusinessEvidences6 + BusinessEvidences7 + BusinessEvidences8 +
               BusinessEvidences9 + BusinessEvidences10;  

        BusinessEvidencesAll  := BusinessEvidences1 + BusinessEvidences2 + BusinessEvidences3 + BusinessEvidences4 + 
              BusinessEvidences5 + BusinessEvidences6 + BusinessEvidences7 + BusinessEvidences8 +
              BusinessEvidences9 + BusinessEvidences10  + BusinessEvidences11
              + BusinessEvidences12 + BusinessEvidences13 + BusinessEvidences14 + BusinessEvidences15;                                                
                                                
       self.BusinessEvidenceStatus :=  MAP (  (BusinessEvidences1[1].RiskFlag OR  BusinessEvidences2[1].RiskFlag OR 
                                                                        BusinessEvidences3[1].RiskFlag)
                                                                        OR
                                                                      ((  NOT( EXISTS(BusinessEvidencesNegativeIndicators( Riskflag AND RiskIndicatorFlag = 'H'))) )
                                                                      AND   (COUNT(BusinessEvidencesNegativeIndicators(Riskflag AND RiskIndicatorFlag = 'M')) >= 5))
                                                                        => 'H',
                                                                        (NOT( EXISTS(BusinessEvidencesNegativeIndicators(Riskflag  AND RiskIndicatorFlag = 'H'))))
                                                                         AND
                                                                         (COUNT(BusinessEvidencesNegativeIndicators(Riskflag  AND RiskIndicatorFlag = 'M')) >=2 AND
                                                                           COUNT(BusinessEvidencesNegativeIndicators(Riskflag AND RiskIndicatorFlag = 'M')) <=4)
                                                                        => 'M',
                                                                        
                                                                     (NOT( EXISTS(BusinessEvidencesNegativeIndicators(RiskFlag AND RiskIndicatorFlag = 'H'))))
                                                                        AND 
                                                                        (COUNT(BusinessEvidencesNegativeIndicators(RiskFLAG AND RiskIndicatorFlag = 'M')) <= 1)
                                                                         => 'P',
                                                                         'P'
                                                                  );
       //output all the error codes.                                                                  
          SELF.BusinessEvidences := CHOOSEN(BusinessEvidencesAll(Riskflag), 
                                                    TopBusiness_Services.Constants.BusinessInsight.MaxIndicatorCodesReturned); 
          SELF.ultid := biplinkids[1].ultid;
          SELF.orgid := biplinkids[1].orgid;
          SELF.seleid := biplinkids[1].seleid;
          SELF := [];
       END;
       
      results := DATASET([ BusinessEvidence() ]);	   
     // output(sectionReport, named('SectionReport'));
      // risk_indice1 := BusinessRiskIndice[1];
      // risk_indice2 := BusinessRiskIndice[2];
      // risk_indice3 := BusinessRiskIndice[3];
      // risk_indice4 := BusinessRiskIndice[4];
      // risk_indice5 := BusinessRiskIndice[5];
     
      // results := project(ut.ds_oneRecord, transform(iesp.topbusinessReport.t_businessInsightSection,
          // self := BusinessInsightSection
          
          // ));
          
                  
       //results := '';                  
       RETURN(results);
  END; // fn_FullView function
  
  
  EXPORT fn_FullViewRisk(
 	DATASET(BIPV2.IDlayouts.l_xlink_ids) biplinkids
	,Layouts.rec_input_options  in_options	
     ,outLayout BusinessInsightIn 
   ,TopBusiness_Services.BestSection_Layouts.Final bestSectionIn  
  ,TopBusiness_Services.ContactSection_Layouts.rec_final ContactSectionIn
   ,TopBusiness_Services.FinanceSection_Layouts.rec_final FinanceSectionIn
   ,TopBusiness_Services.industrySection_layouts.rec_final IndustrySectionIn
   ,INTEGER CurrentMVRCount
   ,INTEGER CurrentWatercraftcount
   ,INTEGER CurrentAircraftCount
   ,INTEGER CurrentPropertyRecordsCount   
   ,INTEGER ForeclosureNODRecordCount
	     ) := FUNCTION
                   
      FETCH_LEVEL := in_options.BusinessReportFetchLevel;
    
      // FETCH_LEVEL := 'S';
      // outLayout := record
               //iesp.topbusinessReport.t_TopBusinessBusinessInsightSection
              // BIPV2.IDlayouts.l_key_ids_bare - [proxid, powid, empid, dotid];
              // iesp.topbusinessReport.t_TopBusinessBusinessInsightSection;
              //STRING10 BusinessEvidencesStatus;
      // end;
     outLayout   BusinessInsightRisk() := TRANSFORM
      //BusinessEvidences :=dataset(iesp.topbusinessReport.T_topBusinessBusinessRiskIndice) {maxcount (20)};  // make this a constant.
           
          // val7 := false;
          val7 := topbusiness_services.BusinessInsightFunctions.Govdebarred(biplinkids,FETCH_LEVEL);
      
          BusinessRisk7 := DATASET([{val7, 'H', 'Business is Government debarred'}],
                iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);             
          // val8 := false;
          val8 :=   topbusiness_services.BusinessInsightFunctions.BusinessHasNodORForeclosure(ForeclosureNODRecordCount); // TODO check is this enough to
                         // check for existence in linkids // may have to inspect properyresults
          BusinessRisk8 :=   DATASET([{val8, 'H', 'Business has foreclosure or notice of default record on file'}],
                iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
         // val9 := false;                                        
         val9 :=     topbusiness_services.BusinessInsightFunctions.BankruptcyDebtorBipLiplinkidsExists(biplinkids, FETCH_LEVEL);
        
         BusinessRisk9 :=   DATASET([{val9, 'H', 'Business has a bankruptcy record on file'}],
                iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);                                                                
                                         
        // val10 := false;
        val10 := topbusiness_services.BusinessInsightFunctions.LiensBipLinkidsWithinTwoYrs(biplinkids, FETCH_LEVEL);        
        BusinessRisk10 := DATASET([{val10,'H', 'Business has judgment or lien record on file in last 24 months'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                             
        //val11 := false; // hit contact key here or use contacts passed in.             
        val11 :=  topbusiness_services.BusinessInsightFunctions.ExecHasDerog(ContactSectionIn);
         BusinessRisk11 := DATASET([{val11,'H', 'Executive has derogatory record on file'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                     
        //val12 := false;    // TODO   // Business has a value of 2-9 in the Due Diligence Business Attribute: Business Industry               
         val12 := topbusiness_services.BusinessInsightFunctions.BusinessInHighRiskIndustry(IndustrySectionIn);  
        BusinessRisk12 := DATASET([{val12,'M', 'Business is in a high risk industry'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                   
        // val15 := false;  
        val15 :=  topbusiness_services.BusinessInsightFunctions.LiensBipLinkidsHighCount(biplinkids, FETCH_LEVEL);                                      
        BusinessRisk15 := DATASET([{val15,'M', 'High judgment or lien count '}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                     
        //val16 := false; // Business has 1 or more B2B delinquencies on file
        val16 := topbusiness_services.BusinessInsightFunctions.BusinessHasB2BDelinquency(biplinkids, FETCH_LEVEL);
        BusinessRisk16 := DATASET([{val16,'M', 'Business to business delinquency'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                                          
        //val17 := false; // Non-executive has derogatory record on file
        val17 :=  topbusiness_services.BusinessInsightFunctions.NonExecHasDerog(
                                               ContactSectionIn.PriorIndividuals(hasDerog)
                                              ,ContactSectionIn.CurrentIndividuals(hasDerog));
        BusinessRisk17 :=   DATASET([{val17, 'M', 'Non-executive has derogatory record on file'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);  
                                                    
         // val18 := false; // Business has no revenue on file
         val18 := topBusiness_services.BusinessInsightFunctions.BusinessHasNoRevenue(biplinkids, FETCH_LEVEL,FinanceSectionIn); 
         BusinessRisk18 :=  DATASET([{val18, 'M', 'Business has no revenue on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);                                                                 
                                                      
         // val19 := false;   // Business has no real property on file                                                   
         val19 :=  topbusiness_services.BusinessInsightFunctions.BusinessHasNoRealProperty(biplinkids, FETCH_LEVEL); 
         BusinessRisk19 :=   DATASET([{val19, 'M', 'Business has no real property on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);           
                                                                                    
         //val20 := false;                                                             
         val20 := topbusiness_services.BusinessInsightFunctions.BusinessHasNoPersonalAssets(biplinkids, FETCH_LEVEL);          
         BusinessRisk20 :=  DATASET([{val20, 'M', 'Business has no assets on file'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);  
                                          
          // val21 := false;
          val21 := topbusiness_services.BusinessInsightFunctions.RecentUCCActivity(
                                biplinkids
                                 , FETCH_LEVEL
                                  ,Topbusiness_services.constants.BusinessInsight.UCCBusinessInsightKfetchMaxLimit
                                  ,1);
           BusinessRisk21 :=  DATASET([{val21, 'M', 'Recent UCC activity on file'}],
                   iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);  
                                         
           // val22 := false; 
           val22 := topbusiness_services.BusinessInsightFunctions.BusinessInHighCrimeLocation(bestSectionIn);
           BusinessRisk22 :=  DATASET([{val22, 'M', 'Business located in high crime location'}],
                    iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);                                                      
   
           //val23 := false;    
           val23 := topbusiness_services.BusinessInsightFunctions.IsPOBoxAddress(
                           bestSectionIn.address.zip5
                           ,bestSectionIn.address.StreetName
                           ,bestSectionIn.address.StreetNumber);        
         BusinessRisk23 :=  DATASET([{val23, 'M', 'Address tied to PO Box'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);     
                                         
          //val24 := false;  
          val24 := topbusiness_services.BusinessInsightFunctions.ResidentialOrBusinessAddressType(biplinkids, FETCH_LEVEL,'R');                                            
          BusinessRisk24 :=  DATASET([{val24, 'M', 'Address tied to residential address'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);     

          // val25 := false;  
          val25 := topbusiness_services.BusinessInsightFunctions.BusinessHasNewLocation(bestSectionIn );                                            
          BusinessRisk25 :=  DATASET([{val25, 'M', 'Business has new location'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);     

          // val26 := false;   
          val26 := topbusiness_services.BusinessInsightFunctions.BusinessHasNoDerog(biplinkids, FETCH_LEVEL,ContactSectionIn  );                                            
          BusinessRisk26 :=  DATASET([{val26, 'P', 'Business has no evidence of derogatory records on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);                    
                                         
          // val27 := false;  
          val27 := topbusiness_services.BusinessInsightFunctions.BusinessHasCurrentProperty(CurrentPropertyRecordsCount);                                            
          BusinessRisk27 :=  DATASET([{val27, 'P', 'Business has current real property on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);                                                        
                                         
          //val28 := false; 
          val28 := topbusiness_services.BusinessInsightFunctions.BusinessHasCurrentAssets(CurrentMVRCount
                                                                                                                                   ,CurrentWatercraftcount
                                                                                                                                   ,CurrentAircraftCount);                                                                                                                                     
          BusinessRisk28 :=  DATASET([{val28, 'P', 'Business has current assets on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);       

          //val29 := false;  
          val29 := topBusiness_services.BusinessInsightFunctions.BusinessHasRevenueAndIsProfit(biplinkids, FETCH_LEVEL,FinanceSectionIn);                                          
          BusinessRisk29 :=  DATASET([{val29, 'P', 'Business has evidence of revenue on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);     

           // val30 := false;  
           val30 := topbusiness_services.BusinessInsightFunctions.ResidentialOrBusinessAddressType(biplinkids, FETCH_LEVEL,'B');                                          
           BusinessRisk30 :=  DATASET([{val30, 'P', 'Address tied to business address'}],
                   iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);                                              
   
           // val31 := false; 
           val31 := topbusiness_services.BusinessInsightFunctions.BusinessHasHighRevenue(FinanceSectionIn);                                            
           BusinessRisk31 :=  DATASET([{val31, 'P', 'Business has evidence of high revenue on file'}],
                   iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);               
                                                                                                                                                 
           BusinessRisksNegativeIndicators  := BusinessRisk7 + BusinessRisk8 
                  + BusinessRisk9 + BusinessRisk10  + BusinessRisk11
                  + BusinessRisk12 + BusinessRisk15
                  + BusinessRisk16 + BusinessRisk17 + BusinessRisk18 + BusinessRisk19
                  + BusinessRisk20 + BusinessRisk21 + BusinessRisk22 + BusinessRisk23
                  + BusinessRisk24 + BusinessRisk25;
                                        
            BusinessRisksAll :=   BusinessRisk7 + BusinessRisk8 
                   + BusinessRisk9 + BusinessRisk10  + BusinessRisk11
                   + BusinessRisk12+ BusinessRisk15
                   + BusinessRisk16 + BusinessRisk17 + BusinessRisk18 + BusinessRisk19
                   + BusinessRisk20 + BusinessRisk21 + BusinessRisk22 + BusinessRisk23
                   + BusinessRisk24 + BusinessRisk25+ BusinessRisk26 + BusinessRisk27
                   + BusinessRisk28 + BusinessRisk29 + BusinessRisk30 + BusinessRisk31;                                        
                                        
           self.BusinessRiskStatus  :=  MAP (  ( BusinessRisk7[1].RiskFlag OR  BusinessRisk8[1].RiskFlag OR 
                                                                        BusinessRisk9[1].RiskFlag OR BusinessRisk10[1].RiskFlag OR
                                                                        BusinessRisk11[1].RiskFlag )
                                                                        OR
                                                                      ((  NOT( EXISTS(BusinessRisksNegativeIndicators (Riskflag  AND RiskIndicatorFlag = 'H'))) )
                                                                      AND   (COUNT(BusinessRisksNegativeIndicators (Riskflag  AND RiskIndicatorFlag = 'M')) >= 6))
                                                                        => 'H',
                                                                        (  NOT( EXISTS(BusinessRisksNegativeIndicators(Riskflag AND RiskIndicatorFlag = 'H'))) )
                                                                          AND 
                                                                          (COUNT(BusinessRisksNegativeIndicators(Riskflag  AND RiskIndicatorFlag = 'M')) >=4 AND
                                                                          COUNT(BusinessRisksNegativeIndicators(Riskflag AND RiskIndicatorFlag = 'M')) <=5)
                                                                        => 'M',
                                                                        
                                                                     (  NOT( EXISTS(BusinessRisksNegativeIndicators(Riskflag AND RiskIndicatorFlag = 'H'))) )
                                                                        AND ( COUNT(BusinessRisksNegativeIndicators(Riskflag AND RiskIndicatorFlag = 'M')) <= 3)
                                                                         => 'P',
                                                                         'P'
                                                                  );
     // set the other two fields based on input                      
      SELF.BusinessEvidences := BusinessInsightIn.BusinessEvidences;   
      SELF.BusinessEvidenceStatus := BusinessInsightIn.BusinessEvidenceStatus;
       //output all the error codes.      
      SELF.BusinessRisks := CHOOSEN(BusinessRisksAll(Riskflag),
                                 TopBusiness_Services.Constants.BusinessInsight.MaxIndicatorCodesReturned); 
      SELF.ultid := biplinkids[1].ultid;
      SELF.orgid := biplinkids[1].orgid;
      SELF.seleid := biplinkids[1].seleid;
      SELF := [];
   END;
       
     SectionReport := DATASET([ BusinessInsightRisk() ]);	   
     // output(sectionReport, named('SectionReport'));
      
       RETURN(SectionReport);
  END; // fn_FullViewRisk function
  
 END; //Module Business Insight module;