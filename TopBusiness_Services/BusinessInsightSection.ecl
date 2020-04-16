IMPORT BIPV2, iesp, topbusiness_services, MDR, UCCV2, STD;
  // throughout this code there are some indicators calculated.
  // this is all documented heavily in RR-18637 initial release
  // for the smart linx bus report (aka bip report)
  // For clarify indicators are in 3 different categories
  // H = high risk indicator, M = medium risk indicator, P = positive risk indicator      
  // the way it works is that this layout below 'layoutInBusinessEvidence' is populated.
  // and then the top 5 risk indicators (negative or positive ) are returned
  // as well as an overall field:   BusinessEvidenceStatus
  ///////////////////////////////////////////////////////////////
EXPORT BusinessInsightSection := MODULE

EXPORT LayoutInBusinessEvidence  := RECORD
         dataset(bipv2.idlayouts.l_xlink_ids) biplinkids,
         Boolean Risk1_isDefunct;
         Boolean Risk2_isInActive;
         Unsigned4  Risk3_SourceCount;
         STRING2   Risk3_SourceIdentifier;
         BOOLEAN RIsk4_NoCorpRecs;
         STRING5    Risk5_zip5;
         STRING28  Risk5_StreetName;
         STRING10  Risk5_StreetNumber;
         Iesp.share.t_Date    Risk6_MostRecentDate;
         BOOLEAN   Risk7_AnnualSalesIsZeroOrNotExistSicCodes;
         INTEGER2    Risk8_yearStarted;
         STRING10  Risk9_Phone10Value,
         UNSIGNED4  Risk10_LessPeopleToBusCount;
         UNSIGNED3   Risk11_HighSourceDocCount;
         UNSIGNED4  Risk12_HighPeopleToBusCount;
         UNSIGNED4  Risk13_EstablishedDate;
         Iesp.share.t_Date    Risk14_MostRecentDate;
         BOOLEAN         Risk15_XYearsBackFromCurrentYear;
      END;

EXPORT UccActivityWithinXYears(  DATASET (BIPV2.IDlayouts.l_xlink_ids) inbipLinkids
                                                                        ,INTEGER NumYrs
                                                                        ,STRING1 FETCH_LEVEL                                                                      
                                                                        ) :=  FUNCTION     
             ds_linkids_keyrecs := Topbusiness_services.uccSection.GetUCCBipLinkids(InBiplinkids, FETCH_LEVEL,
                         Topbusiness_services.constants.BusinessInsight.UCCBusinessInsightKfetchMaxLimit); 
                  
             ds_linkids_keyrecs_slimmed := PROJECT (ds_linkids_keyrecs(party_type != 'A'),
		           TRANSFORM(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_linkidsdata_slimmed, //TODO can slim this down probably to just TMSID			
			       SELF := LEFT;
                       SELF := [];
			));
                  
                  ds_linkids_keyrecs_deduped := DEDUP(SORT(ds_linkids_keyrecs_slimmed,  
                                                                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),tmsid),
																#expand(BIPV2.IDmacros.mac_ListTop3Linkids()), tmsid);
                 set_terminated_types := ['LAPSED','L','RELEASE','EXPUNGED','DELETED',
	                         'TERMINATED','TERMINATION','UCC3 TERMINATION', 'UCC-3 TERMINATION'];

                 ds_uccmain_keyrecs := JOIN(ds_linkids_keyrecs_deduped,UCCV2.Key_Rmsid_Main(),
                               KEYED(LEFT.tmsid = RIGHT.tmsid), //get all recs for the tmsids
	                  TRANSFORM({TopBusiness_Services.UCCSection_Layouts.rec_ids_with_maindata_slimmed; UNSIGNED4 Filing_date_unsigned;},
		                                       // Added this additional field here.
			        temp_status_type           := std.str.ToUpperCase(RIGHT.status_type);
			        temp_filing_type           :=  std.str.ToUpperCase(RIGHT.filing_type);						
			        SELF.orig_filing_number    := IF(RIGHT.orig_filing_number != '', RIGHT.orig_filing_number,RIGHT.filing_number),
			
                        SELF.filing_date_unsigned := (UNSIGNED4) RIGHT.filing_date;
	                   // Fill in derived UCC overall status(status_code), A=active or T=terminated
			        SELF.status_code           := IF (temp_status_type IN set_terminated_types OR  temp_filing_type IN set_terminated_types,
											topbusiness_services.Constants.TERMINATED,topbusiness_services.Constants.ACTIVE);                                                                
			        SELF := RIGHT, // to pull off the ucc main key fields we want                       ???
			               // (which have the same name on the temp layout as on the main key)
			        SELF := LEFT, // to preserve ids & other(?) kept linkids key fields ???
                        SELF := [];
                   ),
		           LEFT OUTER, 		
		           LIMIT(10000,SKIP) 
	            );                                      
            //output(ds_uccmain_keyrecs, named('ds_uccmain_keyrecs'));               
            STRING8 CurDate := (STRING8) STD.Date.today();
           UNSIGNED4 XYearBack := ((UNSIGNED4) (curdate[1..4])) - NumYrs;   // +  curDate[5..6] + curDate[7..8]);
           UNSIGNED4 XYearBackFinal := (UNSIGNED4)( (STRING4) (XYearBack) +  curDate[5..6] + curDate[7..8] );
          res := EXISTS(ds_uccmain_keyrecs(filing_date_unsigned > XYearBackFinal)); 
          RETURN(res);
      END; // function


                      
       EXPORT FromBipReportBusinessEvidence (DATASET(BIPV2.IDlayouts.l_xlink_ids) biplinkids
	,Layouts.rec_input_options  in_options
      ,TopBusiness_Services.BestSection_Layouts.Final bestSectionIn  
      ,TopBusiness_Services.ContactSection_Layouts.rec_final ContactSectionIn    
      ,UNSIGNED3 SourceCount
      ,STRING2  SourceIdentifier
      ,TopBusiness_Services.FinanceSection_Layouts.rec_final FinanceSectionIn
      ) := FUNCTION
      
          LayoutInBusinessEvidence  BusinessEvidenceXform() := TRANSFORM
          
          SELF.biplinkids  :=  biplinkids;  // used for input use in risk4 and Risk7 and risk 15 below
          SELF.Risk1_isDefunct := bestSectionIn.isDefunct;
          SELF.Risk2_isInActive  := NOT(bestSectionIn.isActive);
          SELF.Risk3_SourceCount :=   SourceCount;
          SELF.Risk3_SourceIdentifier :=  SourceIdentifier;
          SELF.RIsk4_NoCorpRecs :=   NOT(exists(Topbusiness_services.incorporationSection.GetCorpBipLinkids( biplinkids, in_options.BusinessReportFetchLevel)));    
          SELF.Risk5_zip5 :=  bestSectionIn.address.zip5;
          SELF.Risk5_StreetName  :=  bestSectionIn.address.StreetName;
          SELF.Risk5_StreetNumber :=   bestSectionIn.address.StreetNumber;
          SELF.Risk6_MostRecentDate :=  BestSectionIn.AddressToDate;
                                                                          noSales :=   (NOT(EXISTS(FinanceSectionIn.Finances))) OR EXISTS(FinanceSectionIn.Finances(AnnualSales = '0'));
                                                                          ds_industry_keyrecs := Topbusiness_services.IndustrySection.GetIndustryBipLinkids(
                                                                                              biplinkids
                                                                                                , in_options.BusinessReportFetchLevel
                                                                                                 , TopBusiness_Services.Constants.defaultJoinLimit);
                                                                                    ds_industry_keyrecs_filtered := ds_industry_keyrecs((SicCode !='' or NAICS !='' OR
                                                                                    industry_description !=''   OR
                                                                                  business_description !='')
									                                        	AND
									                         	               ((source=MDR.sourceTools.src_EBR AND
									                       	             record_type='C') OR
										                                   source !=MDR.sourceTools.src_EBR)
										                   	                  );
          SELF.Risk7_AnnualSalesIsZeroOrNotExistSicCodes :=    NOT(EXISTS(ds_industry_keyrecs_filtered)) AND NoSales;       
          SELF.Risk8_yearStarted  :=  bestSectionIn.yearStarted;
          SELF.Risk9_Phone10Value  :=  bestSectionIn.PhoneInfo.Phone10;
          SELF.Risk10_LessPeopleToBusCount  :=  ContactSectionIn.TotalPriorContactCount  +
                         ContactSectionIn.TotalCurrentContactCount +
                         ContactSectionIn.TotalCurrentExecutiveCount +
                         ContactSectionIn.TotalPriorExecutiveCount;
          SELF.Risk11_HighSourceDocCount     :=  SourceCount;
          SELF.Risk12_HighPeopleToBusCount  :=  ContactSectionIn.TotalPriorContactCount  
                        +  ContactSectionIn.TotalCurrentContactCount
                        +  ContactSectionIn.TotalPriorExecutiveCount  
                        + ContactSectionIn.TotalCurrentExecutiveCount;
          SELF.Risk13_EstablishedDate               := (unsigned4) bestSectionIn.yearStarted;
          SELF.Risk14_MostRecentDate               := bestSectionIn.addressToDate;
          SELF.Risk15_XYearsBackFromCurrentYear  := UccActivityWithinXYears(biplinkids, 5, in_options.BusinessReportFetchLevel);
          END;  // transform
         
          BusinessEvidenceInputREC  := dataset([BusinessEvidenceXform()]);

       res := BusinessEvidenceInputRec;
    RETURN(RES);
    END;  // FromBipReport function
      
    EXPORT  outLayout := RECORD
         BIPV2.IDlayouts.l_key_ids_bare - [proxid, powid, empid, dotid];
          iesp.topbusinessReport.t_TopBusinessBusinessInsightSection;       
    END;

     EXPORT fn_FullViewBusinessEvidence(
             LayoutInBusinessEvidence   BusEvidenceIn
	) := FUNCTION
                  
     outLayout   BusinessEvidence() := TRANSFORM           
          // val1 := false;
          val1 :=  topbusiness_services.BusinessInsightFunctions.IsBusinessDefunct(BusEvidenceIn.Risk1_isDefunct); // this includes the override using phone gong EDA current field to deal with recycled land lines
          BusinessEvidences1 := DATASET([{val1, 'H', 'Business is Defunct'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
             //  this includes the override using phone gong EDA current field to deal with recycled land lines
          // val2 := false
          val2 :=   topbusiness_services.BusinessInsightFunctions.BusinessIsInactive(BusEvidenceIn.Risk2_isInActive);
          BusinessEvidences2 :=   DATASET([{val2, 'H', 'Business is Inactive'}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
         //val3 := false;                                        
         val3 :=     topbusiness_services.BusinessInsightFunctions.TooFewSourcesSeen(BusEvidenceIn.Risk3_SourceCount,
                        BusEvidenceIn.Risk3_SourceIdentifier);        
         BusinessEvidences3 :=   DATASET([{val3, 'H', 'Too few sources'}],
              iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);          
                                                           
        //val4 := false;
        FETCH_LEVEL := 'S';
        val4 := topbusiness_services.BusinessInsightFunctions.NoCorpBiplinkidsExists(BusEvidenceIn.RIsk4_NoCorpRecs);        
        BusinessEvidences4 := DATASET([{val4,'M', 'No Secretary of State record'}],
              iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                   
         //val5 := false; // best address is reported as vacant // hitting advo key here.
         val5 :=  topbusiness_services.BusinessInsightFunctions.IsVacantAddress(BusEvidenceIn.Risk5_zip5, BusEvidenceIn.Risk5_StreetName, 
                          BusEvidenceIn.Risk5_StreetNumber);
         BusinessEvidences5 := DATASET([{val5,'M', 'Best address reported as vacant'}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                   
         //val6 := false;            // last activity on business > 12 months ago                                          
         val6 := topbusiness_services.BusinessInsightFunctions.NoRecentBusinessActivity(BusEvidenceIn.Risk6_MostRecentDate);
         BusinessEvidences6 := DATASET([{val6,'M', 'No activity on business in last year'}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
         // val7 := false;
         val7 :=  topbusiness_services.BusinessInsightFunctions.NoFirmagraphicsData(BusEvidenceIn.Risk7_AnnualSalesIsZeroOrNotExistSicCodes);
         // false; // no firmographics data for business including SIC/NAICS, employee count, sales,
                                // would have to hit several keys in the best section
         BusinessEvidences7 := DATASET([{val7,'M', 'No Firmographic information for business '}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                   
         // val8 := false; // Business established less than one year ago
         val8 := topbusiness_services.BusinessInsightFunctions.BusinessIsLessThanOneYearBack(BusEvidenceIn.Risk8_yearStarted);
         BusinessEvidences8 := DATASET([{val8,'M', 'Business established less than one year ago'}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
                                                                       
         //val9 := false;        // true if no phone in best.                                                                 
         val9 := TopBusiness_services.BusinessInsightFunctions.NoPhone(BusEvidenceIn.Risk9_Phone10Value);    
         BusinessEvidences9 :=   DATASET([{val9, 'M', 'No phone on file'}],
               iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);  
          //val10 := false;
          val10 := topBusiness_services.BusinessInsightFunctions.NoPeopleConnectionsToBusiness(BusEvidenceIn.Risk10_LessPeopleToBusCount);                                                               
          //   No evidence of people connected to business     
         BusinessEvidences10 :=  DATASET([{val10, 'M', 'No evidence of people connected to business'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);           
                                                      
          //val11 := false;                                                      
          val11 :=  topbusiness_services.BusinessInsightFunctions.HighSourceCountSeen(BusEvidenceIn.Risk11_HighSourceDocCount); 
         BusinessEvidences11 :=   DATASET([{val11, 'P', 'High source document count'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);           
                                                                                  
            //val12 := false;                                                             
           val12 := topbusiness_services.BusinessInsightFunctions.StrongPeopleToBusiness(BusEvidenceIn.Risk12_HighPeopleToBusCount);           
          BusinessEvidences12 :=  DATASET([{val12, 'P', 'Strong evidence of people connected to business'}],
                   iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);  

      //val13 := false;
      val13 := topbusiness_services.BusinessInsightFunctions.IsLongEstablishedBusiness(BusEvidenceIn.Risk13_EstablishedDate);
          BusinessEvidences13 :=  DATASET([{val13, 'P', 'Established business'}],
                iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);  
         
        //val14 := false;
       val14 := topbusiness_services.BusinessInsightFunctions.BusinessActivityIsLessThan3MonthsBack( BusEvidenceIn.Risk14_MostRecentDate);
          BusinessEvidences14 :=  DATASET([{val14, 'P', 'Recent business activity'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);                                                      
 
        //val15 := false;    
        val15 := topbusiness_services.BusinessInsightFunctions.UccActivity(  BusEvidenceIn.Risk15_XYearsBackFromCurrentYear );        
         BusinessEvidences15 :=  DATASET([{val15, 'P', 'Evidence of UCC activity'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);     
                                                                                                           
       BusinessEvidencesNegativeIndicators := BusinessEvidences1 + BusinessEvidences2 + BusinessEvidences3 + BusinessEvidences4 + 
               BusinessEvidences5 + BusinessEvidences6 + BusinessEvidences7 + BusinessEvidences8 +
               BusinessEvidences9 + BusinessEvidences10;  

        BusinessEvidencesAll  := BusinessEvidences1 + BusinessEvidences2 + BusinessEvidences3 + BusinessEvidences4 + 
              BusinessEvidences5 + BusinessEvidences6 + BusinessEvidences7 + BusinessEvidences8 +
              BusinessEvidences9 + BusinessEvidences10  + BusinessEvidences11
              + BusinessEvidences12 + BusinessEvidences13 + BusinessEvidences14 + BusinessEvidences15;       
              
          // Business Evidence Rules:
          //If any High Risk Indicators are present then overall Status = H
          //If no High Risk Indicators are present but 5 or more Risk Indicators are present then overall Status = H
          //If no High Risk Indicators are present but 2-4 Risk Indicators are present then overall Status = M				
          //If no High Risk Indicators are present and 0-1 Risk Indicators are present then overall Status = P              
          
          // simpler version BusinessEvidences1-BusinessEvidences3 are H (HIGH risk indicators)                
          NoBusEvidenceHighRiskIndicators := NOT( EXISTS(BusinessEvidencesNegativeIndicators (Riskflag  AND RiskIndicatorFlag = 'H')));
           CountBusEvidenceMediumRiskIndicators :=   COUNT(BusinessEvidencesNegativeIndicators(Riskflag AND RiskIndicatorFlag = 'M'));   
                                               
       self.BusinessEvidenceStatus :=  MAP (  (BusinessEvidences1[1].RiskFlag OR  BusinessEvidences2[1].RiskFlag OR 
                                                                        BusinessEvidences3[1].RiskFlag)
                                                                        OR
                                                                      ((  NoBusEvidenceHighRiskIndicators )
                                                                      AND   (  CountBusEvidenceMediumRiskIndicators >= 5))
                                                                        => 'H',
                                                                        ( NoBusEvidenceHighRiskIndicators   )
                                                                         AND
                                                                         ( CountBusEvidenceMediumRiskIndicators >=2 AND
                                                                            CountBusEvidenceMediumRiskIndicators <=4)
                                                                        => 'M',
                                                                        
                                                                     ( NoBusEvidenceHighRiskIndicators )
                                                                        AND 
                                                                        ( CountBusEvidenceMediumRiskIndicators <= 1 )
                                                                         => 'P',
                                                                         'P'
                                                                  );
       //output all the error codes.                                                                  
          SELF.BusinessEvidences := CHOOSEN(BusinessEvidencesAll(Riskflag),//20);
                                                    TopBusiness_Services.Constants.BusinessInsight.MaxIndicatorCodesReturned); 
          SELF.ultid := BusEvidenceIn.biplinkids[1].ultid;
          SELF.orgid := BusEvidenceIn.biplinkids[1].orgid;
          SELF.seleid := BusEvidenceIn.biplinkids[1].seleid;
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
          val21 := UccActivityWithinXYears(biplinkids
                                                                         ,1
                                                                         ,FETCH_LEVEL);
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
                   

          // Business Risk Business Rules
          // If any High Risk Indicators are present then overall Status = H
          // If no High Risk Indicators are present but 6 or more Risk Indicators are present then overall Status = H
          // If no High Risk Indicators are present but 4-5 Risk Indicators are present then overall Status = M
          // If no High Risk Indicators are present and 0-3 Risk Indicators are present then overall Status = P			


          // simpler version note  BusinessRisk7- BusinessRisk11 are H (highrisk) indicators    
          NoHighRiskIndicators := NOT( EXISTS(BusinessRisksNegativeIndicators (Riskflag  AND RiskIndicatorFlag = 'H')));
           CountMediumRiskIndicators :=   COUNT(BusinessRisksNegativeIndicators(Riskflag AND RiskIndicatorFlag = 'M'));                                       
           self.BusinessRiskStatus  :=  MAP (  ( BusinessRisk7[1].RiskFlag OR  BusinessRisk8[1].RiskFlag OR 
                                                                        BusinessRisk9[1].RiskFlag OR BusinessRisk10[1].RiskFlag OR
                                                                        BusinessRisk11[1].RiskFlag )
                                                                        OR
                                                                      ((  NoHighRiskIndicators )
                                                                      AND   (CountMediumRiskIndicators >= 6))
                                                                        => 'H',
                                                                        (  NoHighRiskIndicators )
                                                                          AND 
                                                                          (( CountMediumRiskIndicators  >=4) AND
                                                                            (CountMediumRiskIndicators <=5))
                                                                        => 'M',
                                                                        
                                                                     (  NoHighRiskIndicators ) AND ( CountMediumRiskIndicators <= 3)
                                                                         => 'P',
                                                                         'P'
                                                                  );
     // set the other two fields based on input                      
      SELF.BusinessEvidences := BusinessInsightIn.BusinessEvidences;   
      SELF.BusinessEvidenceStatus := BusinessInsightIn.BusinessEvidenceStatus;
       //output all the error codes.      
      SELF.BusinessRisks := CHOOSEN(BusinessRisksAll(Riskflag), //20);
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