IMPORT  BIPV2, iesp, UCCV2, STD, dx_Cortera_Tradeline, DueDiligence, topbusiness_services;

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
         dataset(bipv2.idlayouts.l_xlink_ids) biplinkids;
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
         INTEGER2  Risk10_LessPeopleToBusCount;
         UNSIGNED3   Risk11_HighSourceDocCount;
         INTEGER2  Risk12_HighPeopleToBusCount;
         UNSIGNED4  Risk13_EstablishedDate;
         Iesp.share.t_Date    Risk14_MostRecentDate;
         BOOLEAN       Risk15_XYearsBackFromCurrentYear;
      END;


      EXPORT LayoutInBusinessRisk  := RECORD
         DATASET (bipv2.idlayouts.l_xlink_ids) biplinkids;
         DATASET (bipv2.idlayouts.l_xlink_ids)  Risk7_isGovtDebarred;
         BOOLEAN  Risk8_ForeclosureNODRecordCount;
         BOOLEAN  Risk9_bankrupctyExists;
         BOOLEAN  Risk10_LiensWithinTwoYearsBack;
         BOOLEAN  RIsk11_ExecHasDerog;
         DATASET ({STRING8 SicCode;}) Risk12_BusinessInHighRiskIndustrySic;
         DATASET ({STRING8 NaicsCode;}) Risk12_BusinessInHighRiskIndustryNaics;
         BOOLEAN  Risk14_HighBusinessTurnoverAtAddress;
         REAL     Risk14_HighBusinessTurnoverAtAddressReal;
         BOOLEAN  Risk15_LiensBipLinkidsHighCount;
         BOOLEAN  Risk16_BusinessHasB2BDelinquency;
         BOOLEAN  Risk17_NonExecHasDerog;
         BOOLEAN  Risk18_BusinessHasNoRevenue;
         BOOLEAN  Risk19_BusinessHasNoRealProperty;
         BOOLEAN  Risk20_BusinessHasNoPersonalAssets;
         BOOLEAN  Risk21_UccActivityWithinLastYear;
         DATASET ( DueDiligence.layoutsInternal.GeographicLayout) Risk22_BusinessInHighCrimeLocation;
         STRING5    Risk23_zip5; // business is PO box
         STRING28  Risk23_StreetName; // business is PO box
         STRING10  Risk23_StreetNumber; // business is PO box
         STRING5    Risk24_zip5;  // buiness is residential
         STRING28  Risk24_StreetName;  // buiness is residential
         STRING10  Risk24_StreetNumber;  // buiness is residential
         BOOLEAN  Risk25_BusinessHasNewLocation; // busienss is new location
         BOOLEAN  Risk26_BusinessHasNoDerog;
         BOOLEAN  Risk27_BusinessHasCurrentProperty;
         BOOLEAN  Risk28_BusinessHasCurrentAssets;
         BOOLEAN  Risk29_BusinessHasRevenueAndIsProfit;
         STRING5  Risk30_zip5; // business is business address
         STRING28  Risk30_StreetName;  // business is business address
         STRING10  Risk30_StreetNumber;  // business is business address
         BOOLEAN  Risk31_BusinessHasHighRevenue;
      END;

   EXPORT RemoveCrimOffenderBoolean( dataset(TopBusiness_Services.ContactSection_Layouts.rec_final) ContactSectionIn) := FUNCTION

                   TmpContactSection := PROJECT(ContactSectionIn,
                                  TRANSFORM(TopBusiness_Services.ContactSection_Layouts.rec_final,
                                       SELF.PriorExecutives :=   PROJECT(LEFT.PriorExecutives, TRANSFORM(
                                                                        iesp.TopbusinessReport.t_TopBusinessIndividual,
                                                                                 SELF.IsSexualOffender  := FALSE;
                                                                                 SELF.HasCriminalConviction := FALSE;
                                                                                 SELF := LEFT));
                                       SELF.PriorIndividuals := PROJECT(LEFT.PriorIndividuals, TRANSFORM(
                                                                        iesp.TopbusinessReport.t_TopBusinessIndividual,
                                                                                 SELF.IsSexualOffender  := FALSE;
                                                                                 SELF.HasCriminalConviction := FALSE;
                                                                                 SELF := LEFT));
                                       SELF.CurrentExecutives := PROJECT(LEFT.CurrentExecutives, TRANSFORM(
                                                                        iesp.TopbusinessReport.t_TopBusinessIndividual,
                                                                                 SELF.IsSexualOffender  := FALSE;
                                                                                 SELF.HasCriminalConviction := FALSE;
                                                                                 SELF := LEFT));
                                       SELF.CurrentIndividuals  := PROJECT(LEFT.CurrentIndividuals, TRANSFORM(
                                                                        iesp.TopbusinessReport.t_TopBusinessIndividual,
                                                                                 SELF.IsSexualOffender  := FALSE;
                                                                                 SELF.HasCriminalConviction := FALSE;
                                                                                 SELF := LEFT));
                                      SELF := LEFT;
                                   ));

                  RETURN(TmpContactSection);
   END;


 SHARED UccActivityWithinXYears(  DATASET (BIPV2.IDlayouts.l_xlink_ids) inbipLinkids
                                                                        ,INTEGER NumYrs
                                                                        ,STRING1 FETCH_LEVEL
                                                                        ) :=  FUNCTION
             ds_linkids_keyrecs := Topbusiness_services.uccSection.GetUCCBipLinkids(InBiplinkids, FETCH_LEVEL,
                         Topbusiness_services.constants.BusinessInsight.UCCBusinessInsightKfetchMaxLimit);

             ds_linkids_keyrecs_slimmed := PROJECT (ds_linkids_keyrecs,
		           TRANSFORM(TopBusiness_Services.UCCSection_Layouts.rec_ids_with_linkidsdata_slimmed,
			       SELF := LEFT;
                       SELF := [];
			));
        tmpLayout := RECORD
            BIPV2.IDlayouts.l_header_ids;
            UCCV2.Layout_UCC_Common.Layout_party_With_AID.tmsid;
        	 UCCV2.Layout_UCC_Common.Layout_ucc_new.filing_date;
            UNSIGNED4 Filing_date_unsigned;
        END;

                  ds_linkids_keyrecs_deduped := DEDUP(SORT(ds_linkids_keyrecs_slimmed,
                                                                                    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),tmsid),
																#expand(BIPV2.IDmacros.mac_ListTop3Linkids()), tmsid);
                 ds_uccmain_keyrecs := JOIN(ds_linkids_keyrecs_deduped,UCCV2.Key_Rmsid_Main(),
                               KEYED(LEFT.tmsid = RIGHT.tmsid), //get all recs for the tmsids
                        TRANSFORM(tmpLayout,
                        SELF.filing_date_unsigned := (UNSIGNED4) RIGHT.filing_date;
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
           UNSIGNED4 XYearBack := ((UNSIGNED4) (curdate[1..4])) - NumYrs;
           UNSIGNED4 XYearBackFinal := (UNSIGNED4)( (STRING4) (XYearBack) +  curDate[5..6] + curDate[7..8] );
          res := EXISTS(ds_uccmain_keyrecs(filing_date_unsigned > XYearBackFinal));
          RETURN(res);
      END; // function


                EXPORT  outLayout := RECORD
                     BIPV2.IDlayouts.l_key_ids_bare - [proxid, powid, empid, dotid];
                    iesp.topbusinessReport.t_TopBusinessBusinessInsightSection;
                END;

       EXPORT FromBipReportBusinessEvidence (DATASET(BIPV2.IDlayouts.l_xlink_ids) biplinkids
	,TopBusiness_Services.Layouts.rec_input_options  in_options
      ,TopBusiness_Services.BestSection_Layouts.Final bestSectionIn
      , Boolean NoIndustrySectionRecs
      ,INTEGER2 ContactCount
      ,UNSIGNED3 SourceCount
      ,STRING2  SourceIdentifier
      , Boolean NoRevenue
      ) := FUNCTION

          LayoutInBusinessEvidence  BusinessEvidenceXform() := TRANSFORM

          SELF.biplinkids  :=  biplinkids;  // used for input use in risk4 and Risk7 and risk 15 below
          SELF.Risk1_isDefunct := bestSectionIn.isDefunct;
          SELF.Risk2_isInActive  := NOT(bestSectionIn.isActive);
          SELF.Risk3_SourceCount :=   SourceCount;
          SELF.Risk3_SourceIdentifier :=  SourceIdentifier;
          SELF.RIsk4_NoCorpRecs :=   NOT(EXISTS(Topbusiness_services.incorporationSection.GetCorpBipLinkids( biplinkids,
          in_options.BusinessReportFetchLevel,topBusiness_services.constants.SmallestKeepLimit)));
          SELF.Risk5_zip5 :=  bestSectionIn.address.zip5;
          SELF.Risk5_StreetName  :=  bestSectionIn.address.StreetName;
          SELF.Risk5_StreetNumber :=   bestSectionIn.address.StreetNumber;
          SELF.Risk6_MostRecentDate :=  BestSectionIn.AddressToDate;

          SELF.Risk7_AnnualSalesIsZeroOrNotExistSicCodes :=    NoIndustrySectionRecs AND NoRevenue;
          SELF.Risk8_yearStarted  :=  bestSectionIn.yearStarted;
          SELF.Risk9_Phone10Value  :=  bestSectionIn.PhoneInfo.Phone10;
          SELF.Risk10_LessPeopleToBusCount  :=  ContactCount;

          SELF.Risk11_HighSourceDocCount     :=  SourceCount;
          SELF.Risk12_HighPeopleToBusCount  :=  ContactCount;

          SELF.Risk13_EstablishedDate               := (unsigned4) bestSectionIn.yearStarted;
          SELF.Risk14_MostRecentDate               := bestSectionIn.addressToDate;
          SELF.Risk15_XYearsBackFromCurrentYear  := UccActivityWithinXYears(biplinkids, 5, in_options.BusinessReportFetchLevel);
          END;  // transform

          BusinessEvidenceInputREC  := dataset([BusinessEvidenceXform()]);

       res := BusinessEvidenceInputRec;
    RETURN(RES);
    END;  // FromBipReport function

      EXPORT FromBipReportBusinessRisk (
           DATASET(BIPV2.IDlayouts.l_xlink_ids) biplinkids
	     ,TopBusiness_Services.Layouts.rec_input_options  in_options
          ,TopBusiness_Services.BestSection_Layouts.Final bestSectionIn
          ,BOOLEAN ContactExecHasDerog
          ,BOOLEAN ContactNonExecHasDerog
          ,STRING15 AnnualSales
          ,BOOLEAN NoRevenue
          ,DATASET({STRING8 SicCode;}) SicCode
          ,DATASET({STRING8 NaicsCode;}) NaicsCode
          ,INTEGER TotalMVRCount
          ,INTEGER CurrentMVRCount
          ,INTEGER TotalWatercraftCount
          ,INTEGER CurrentWatercraftcount
          ,INTEGER TotalAircraftCount
          ,INTEGER CurrentAircraftCount
          ,INTEGER PriorPropertyRecordsCount
          ,INTEGER CurrentPropertyRecordsCount
          ,INTEGER ForeclosureNODRecordCount
          ,BOOLEAN HasCurrentPropertyAndNoForeNod
          ,BOOLEAN  UccSectionDoesExist
          ,BOOLEAN LienSectionDoesExist
          ,BOOLEAN LienCountOver5
          ,BOOLEAN BankruptcySectionDoesExist
           ,iesp.share.t_date LienOrigFilingDate
           ,BOOLEAN IncludeBizToBizDelinquencyRiskIndicator
           ) := FUNCTION
        STRING8 CurDate := (STRING8) STD.Date.today();
       // Topbusiness_services.BusinessInsightSection
          LayoutInBusinessRisk  BusinessRiskXform() := TRANSFORM

              SELF.biplinkids  :=  biplinkids;  // used for input use in risk4 and Risk7 and risk 15 below
              SELF.Risk7_isGovtDebarred :=  biplinkids;
              SELF.Risk8_ForeclosureNODRecordCount:=  ForeclosureNODRecordCount  > 0;
             SELF.Risk9_bankrupctyExists := BankruptcySectionDoesExist;

                       TempDatestring :=  IESP.ecl2esp.DateToString(LienOrigFilingDate);
                       OrigFilingDateNumeric := if (LENGTH(TRIM(TempDatestring,LEFT, RIGHT)) = 8, (UNSIGNED4) (TempDatestring), 0);
                        YearString :=  (STRING4) (((UNSIGNED4) (CurDate[1..4])) - 2);
                        TwoYrsBackDate :=  (UNSIGNED4) (YearString + curDate[5..8]);
                     // output(TwoYrsBackDate, named('TwoYrsBackDate'));
                      // output(LiensRecsTwoYrsBack, named('LiensRecsTwoYrsBack'));

              SELF.Risk10_LiensWithinTwoYearsBack := OrigFilingDateNumeric >= TwoYrsBackDate;

              SELF.RIsk11_ExecHasDerog := ContactExecHasDerog;
              SELF.Risk12_BusinessInHighRiskIndustrySic := SicCode;
              SELF.Risk12_BusinessInHighRiskIndustryNAICS :=  NaicsCode;

              TopBusiness_Services.Layouts.busRiskDefunctAddressLayout CreateAddress() := TRANSFORM
                                        SELF.UniqueId := 1;
                                        SELF.company_prim_range := BestSectionIn.Address.StreetNumber;
                                        SELF.company_predir := BestSectionIn.address.StreetPreDirection;
                                        SELF.company_prim_name  := BestSectionIn.address.StreetName;
                                        SELF.company_addr_suffix := BestSectionIn.address.StreetSuffix;
                                        SELF.company_postdir := BestSectionIn.address.StreetPostDirection;
                                        SELF.company_unit_desig := BestSectionIn.address.UnitDesignation;
                                        SELF.company_sec_range := BestSectionIn.address.UnitNumber;
                                        SELF.company_p_city_name := BestSectionIn.address.City;
                                        SELF.company_st := BestSectionIn.address.State;
                                        SELF.company_zip5 := BestSectionIn.address.zip5;
                                        SELF.company_zip4 := BestSectionIn.address.zip4;
                                        END;
              AddressinRisk14 := dataset([CreateAddress()]);

              resultDS := TopBusiness_Services.Fn_defunct_address.defunctsAtAddress(AddressinRisk14).result;   /// main function call to return results..
              NumTotal := project(resultDS, transform({unsigned4 Numtotal;}, self.Numtotal := left.total))[1].NumTotal;
              NumDefunct :=  project(resultDS, transform({unsigned4 NumDefunct;}, self.NumDefunct:= left.Defunct))[1].NumDefunct;

              SELF.Risk14_HighBusinessTurnoverAtAddressReal := NumDefunct/NumTotal;
              SELF.Risk14_HighBusinessTurnoverAtAddress := ((NumDefunct/NumTotal) * 100) > 80;

              // fill in later here
              SELF.Risk15_LiensBipLinkidsHighCount := LienCountOver5;
              SELF.Risk16_BusinessHasB2BDelinquency :=  IncludeBizToBizDelinquencyRiskIndicator AND
                                                                                                        EXISTS(dx_Cortera_Tradeline.Key_LinkIds.kfetch2(
                                                                                                                          PROJECT(biplinkids, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
                                                                                                                            self  := LEFT; SELF := [];))
                                                                                                                         ,in_options.BusinessReportFetchLevel
                                                                                                                         , // take default
                                                                                                                         ,TopBusiness_Services.Constants.SmallestKeepLimit// only need to find existence so use 1 for keep constant
                                                                                                                             // take default on last param jointype
                                                                                                                         )(total_ar <> current_ar));

              SELF.Risk17_NonExecHasDerog :=  ContactNonExecHasDerog;

                ds_corpLinkidsRecs :=   topBusiness_services.IncorporationSection.GetCorpBipLinkids(biplinkids,
                                                              in_options.BusinessReportFetchLevel ,topBusiness_services.constants.SmallestKeepLimit);
                       ds_corprecsSlim := DEDUP(SORT(ds_corpLinkidsRecs,
														        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), if (record_type = 'C', 0, 1)),
                                                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()));

		             isProfitCompany  := 	EXISTS(ds_corprecsSlim(record_type = 'C' AND corp_for_profit_ind = 'Y')) OR
                                                                 // per recommendation of data team not all states show this indicator so have to account for this here
                                                                 EXISTS(ds_corprecsSlim(record_type = 'C' and corp_for_profit_ind = ''));

              SELF.Risk18_BusinessHasNoRevenue :=  IsProfitcompany AND   NoRevenue;
              SELF.Risk19_BusinessHasNoRealProperty := CurrentPropertyRecordsCount   + PriorPropertyRecordsCount = 0;
              SELF.Risk20_BusinessHasNoPersonalAssets :=  TotalMVRCount + TotalWatercraftcount  +  TotalAircraftCount = 0;
              SELF.Risk21_UccActivityWithinLastYear := UccActivityWithinXYears(biplinkids, 1, in_options.BusinessReportFetchLevel);

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
                                   inDDds := DATASET([ DDGeoRiskLayout() ]);
              SELF.Risk22_BusinessInHighCrimeLocation := inDDds; // dataset
              SELF.Risk23_zip5 :=  bestSectionIn.address.zip5; // po box
              SELF.Risk23_StreetName  :=  bestSectionIn.address.StreetName;
              SELF.Risk23_StreetNumber :=   bestSectionIn.address.StreetNumber;
              SELF.Risk24_zip5 :=  bestSectionIn.address.zip5; // residential address.
              SELF.Risk24_StreetName  :=  bestSectionIn.address.StreetName;
              SELF.Risk24_StreetNumber :=   bestSectionIn.address.StreetNumber;
                                FromdateFinal := IF (BestSectionIn.phoneFromDate.year=0, BestSectionIn.AddressFromDate,
                                                         BestSectionIn.PhoneFromDate);
                                UFromDate := (UNSIGNED4) (iesp.ecl2esp.DateToString(FromdateFinal));
                                XYearBack := ((UNSIGNED4) (CurDate[1..4])) - 1;
                                UNSIGNED4 XYearBackFinal :=  (UNSIGNED4)( (STRING4) (XYearBack) +  curDate[5..6] + curDate[7..8] );
              SELF.Risk25_BusinessHasNewLocation :=  UFromDate > XYearBackFinal;
              SELF.Risk26_BusinessHasNoDerog :=
                                                                (NOT (ContactNonExecHasDerog OR ContactExecHasDerog))
                                                                 AND ( NOT (BankruptcySectionDoesExist OR UccSectionDoesExist OR lienSectionDoesExist));

              SELF.Risk27_BusinessHasCurrentProperty :=  HasCurrentPropertyAndNoForeNod;
              SELF.Risk28_BusinessHasCurrentAssets := CurrentMVRCount + CurrentWatercraftcount  +  CurrentAircraftCount > 0;
              SELF.Risk29_BusinessHasRevenueAndIsProfit :=    isProfitCompany AND (((INTEGER5) (AnnualSales))  > 0);

              SELF.Risk30_zip5 :=  bestSectionIn.address.zip5; // Business has a Business Address.
              SELF.Risk30_StreetName  :=  bestSectionIn.address.StreetName;
              SELF.Risk30_StreetNumber :=   bestSectionIn.address.StreetNumber;
              SELF.Risk31_BusinessHasHighRevenue :=    ((INTEGER5) (AnnualSales)) > 1000000;
             END;
               tDate := iesp.ecl2esp.DateToString(LienOrigFilingDate);
               // output(biplinkids[1].seleid, named('seleid'));
               // output(tdate, named('LienOrigFilingDate'));
               RETURN( dataset([BusinessRiskXform()]));
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
          SELF.BusinessEvidences := CHOOSEN(BusinessEvidencesAll(Riskflag),
                                           iesp.constants.TOPBUSINESS.MAX_COUNT_BUSINESS_EVIDENCE_RISKCODE);

          SELF.ultid := BusEvidenceIn.biplinkids[1].ultid;
          SELF.orgid := BusEvidenceIn.biplinkids[1].orgid;
          SELF.seleid := BusEvidenceIn.biplinkids[1].seleid;
          SELF := [];
       END;

      results := DATASET([ BusinessEvidence() ]);
     // output(sectionReport, named('SectionReport'));

       RETURN(results);
  END; // fn_FullView function


  EXPORT fn_FullViewRisk(
     outLayout BusinessInsightIn
     ,LayoutInBusinessRisk   BusRiskIn
	     ) := FUNCTION

     outLayout   BusinessInsightRisk() := TRANSFORM

          // val7 := false;
          val7 := topbusiness_services.BusinessInsightFunctions.Govdebarred(BusRiskIn.Risk7_isGovtDebarred);

          BusinessRisk7 := DATASET([{val7, 'H', 'Business is Government debarred'}],
                iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
          // val8 := false;
          val8 :=   topbusiness_services.BusinessInsightFunctions.BusinessHasNodORForeclosure(BusRiskIn.Risk8_ForeclosureNODRecordCount); // TODO check is this enough to
                         // check for existence in linkids // may have to inspect properyresults
          BusinessRisk8 :=   DATASET([{val8, 'H', 'Business has foreclosure or notice of default record on file'}],
                iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);
         // val9 := false;
         val9 :=     topbusiness_services.BusinessInsightFunctions.BankruptcyDebtorBipLiplinkidsExists( BusRiskIn.Risk9_bankrupctyExists);

         BusinessRisk9 :=   DATASET([{val9, 'H', 'Business has a bankruptcy record on file'}],
                iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

        // val10 := false;
        val10 := topbusiness_services.BusinessInsightFunctions.LiensBipLinkidsWithinTwoYrs( BusRiskIn.Risk10_LiensWithinTwoYearsBack);
        BusinessRisk10 := DATASET([{val10,'H', 'Business has judgment or lien record on file in last 24 months'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

        //val11 := false; // hit contact key here or use contacts passed in.
        val11 :=  topbusiness_services.BusinessInsightFunctions.ExecHasDerog( BusRiskIn.RIsk11_ExecHasDerog);
         BusinessRisk11 := DATASET([{val11,'H', 'Executive has derogatory record on file'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

        //val12 := false;    // Business has a value of 6-9 in the Due Diligence Business Attribute: Business Industry
         val12 := topbusiness_services.BusinessInsightFunctions.BusinessInHighRiskIndustry(
                                             BusRiskIn.Risk12_BusinessInHighRiskIndustrySic,
                                            BusRiskIn.Risk12_BusinessInHighRiskIndustryNAICS);
        BusinessRisk12 := DATASET([{val12,'M', 'Business is in a high risk industry'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

        //val14 := false;
        val14 := Topbusiness_Services.BusinessInsightFunctions.HighBusTurnoverAtAddress(BusRiskIn.Risk14_HighBusinessTurnoverAtAddress);
        BusinessRisk14 := DATASET([{val14,'M','High business turnover at address'}],
                iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

        // val15 := false;
        val15 :=  topbusiness_services.BusinessInsightFunctions.LiensBipLinkidsHighCount( BusRiskIn.Risk15_LiensBipLinkidsHighCount);
        BusinessRisk15 := DATASET([{val15,'M', 'High judgment or lien count '}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

        //val16 := false; // Business has 1 or more B2B delinquencies on file
        val16 := topbusiness_services.BusinessInsightFunctions.BusinessHasB2BDelinquency(BusRiskIn.Risk16_BusinessHasB2BDelinquency);
        BusinessRisk16 := DATASET([{val16,'M', 'Business to business delinquency'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

        //val17 := false; // Non-executive has derogatory record on file
        val17 :=  topbusiness_services.BusinessInsightFunctions.NonExecHasDerog(BusRiskIn.Risk17_NonExecHasDerog);

        BusinessRisk17 :=   DATASET([{val17, 'M', 'Non-executive has derogatory record on file'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

         // val18 := false; // Business has no revenue on file
         val18 := topBusiness_services.BusinessInsightFunctions.BusinessHasNoRevenue(BusRiskIn.Risk18_BusinessHasNoRevenue);
         BusinessRisk18 :=  DATASET([{val18, 'M', 'Business has no revenue on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

         // val19 := false;   // Business has no real property on file
         val19 :=  topbusiness_services.BusinessInsightFunctions.BusinessHasNoRealProperty(BusRiskIn.Risk19_BusinessHasNoRealProperty);
         BusinessRisk19 :=   DATASET([{val19, 'M', 'Business has no real property on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

         //val20 := false;
         val20 := topbusiness_services.BusinessInsightFunctions.BusinessHasNoPersonalAssets(BusRiskIn.Risk20_BusinessHasNoPersonalAssets);
         BusinessRisk20 :=  DATASET([{val20, 'M', 'Business has no assets on file'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

          // val21 := false;
          val21 := topbusiness_services.BusinessInsightFunctions.UccActivity(  BusRISKIn.Risk21_UccActivityWithinLastYear);
           BusinessRisk21 :=  DATASET([{val21, 'M', 'Recent UCC activity on file'}],
                   iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

           // val22 := false;
           val22 := topbusiness_services.BusinessInsightFunctions.BusinessInHighCrimeLocation(
                                           BusRiskIn.Risk22_BusinessInHighCrimeLocation);
           BusinessRisk22 :=  DATASET([{val22, 'M', 'Business located in high crime location'}],
                    iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

           //val23 := false;
           val23 := topbusiness_services.BusinessInsightFunctions.IsBusinessORPOBoxOrResidentAddress(BusRiskIn.Risk23_zip5,
                                                                                                                      BusRiskIn.Risk23_StreetName, BusRiskIn.Risk23_StreetNumber,'P');
         BusinessRisk23 :=  DATASET([{val23, 'M', 'Address tied to PO Box'}],
                 iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

          //val24 := false;
          val24 := topbusiness_services.BusinessInsightFunctions.IsBusinessORPOBoxOrResidentAddress(
                                                                                            BusRiskIn.Risk24_ZIp5
                                                                                           ,BusRiskIn.Risk24_StreetName
                                                                                             ,BusRiskIn.Risk24_StreetNumber, 'R');
          BusinessRisk24 :=  DATASET([{val24, 'M', 'Address tied to residential address'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

          // val25 := false;
          val25 := topbusiness_services.BusinessInsightFunctions.BusinessHasNewLocation(BusRiskIn.Risk25_BusinessHasNewLocation);
          BusinessRisk25 :=  DATASET([{val25, 'M', 'Business has new location'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

          // val26 := false;
          val26 := topbusiness_services.BusinessInsightFunctions.BusinessHasNoDerog(BusRiskIn.Risk26_BusinessHasNoDerog  );
          BusinessRisk26 :=  DATASET([{val26, 'P', 'Business has no evidence of derogatory records on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

          // val27 := false;
          val27 := topbusiness_services.BusinessInsightFunctions.BusinessHasCurrentProperty(BusRiskIn.Risk27_BusinessHasCurrentProperty);
          BusinessRisk27 :=  DATASET([{val27, 'P', 'Business has current real property on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

          //val28 := false;
          val28 := topbusiness_services.BusinessInsightFunctions.BusinessHasCurrentAssets(BusRiskIn.Risk28_BusinessHasCurrentAssets);
          BusinessRisk28 :=  DATASET([{val28, 'P', 'Business has current assets on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

          //val29 := false;
          val29 := topBusiness_services.BusinessInsightFunctions.BusinessHasRevenueAndIsProfit(BusRiskIn.Risk29_BusinessHasRevenueAndIsProfit);
          BusinessRisk29 :=  DATASET([{val29, 'P', 'Business has evidence of revenue on file'}],
                  iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

           // val30 := false;
           val30 := topbusiness_services.BusinessInsightFunctions.IsBusinessOrPOBoxOrResidentAddress(BusRiskIn.Risk30_zip5, BusRiskIn.Risk30_StreetName,
                                                                                          BusRiskIn.Risk30_StreetNumber, 'B');
           BusinessRisk30 :=  DATASET([{val30, 'P', 'Address tied to business address'}],
                   iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

           // val31 := false;
           val31 := topbusiness_services.BusinessInsightFunctions.BusinessHasHighRevenue(BusRiskIn.Risk31_BusinessHasHighRevenue);
           // output(val31, named('val31'));
           BusinessRisk31 :=  DATASET([{val31, 'P', 'Business has evidence of high revenue on file'}],
                   iesp.topbusinessReport.T_topBusinessBusinessRiskIndicator);

           BusinessRisksNegativeIndicators  := BusinessRisk7 + BusinessRisk8
                  + BusinessRisk9 + BusinessRisk10  + BusinessRisk11
                  + BusinessRisk12 + BusinessRisk14 + BusinessRisk15
                  + BusinessRisk16 + BusinessRisk17 + BusinessRisk18 + BusinessRisk19
                  + BusinessRisk20 + BusinessRisk21 + BusinessRisk22 + BusinessRisk23
                  + BusinessRisk24 + BusinessRisk25;

            BusinessRisksAll :=   BusinessRisk7 + BusinessRisk8
                   + BusinessRisk9 + BusinessRisk10  + BusinessRisk11
                   + BusinessRisk12 + BusinessRisk14 + BusinessRisk15
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
      SELF.BusinessRisks := CHOOSEN(BusinessRisksAll(Riskflag),
                       iesp.constants.TOPBUSINESS.MAX_COUNT_BUSINESS_RISK_RISKCODE);
      SELF.ultid :=    BusRiskIn.biplinkids[1].ultid;
      SELF.orgid :=   BusRiskIn.biplinkids[1].orgid;
      SELF.seleid := BusRiskIn.biplinkids[1].seleid;
      SELF := [];
   END;

     SectionReport := DATASET([ BusinessInsightRisk() ]);
     // output(sectionReport, named('SectionReport'));

       RETURN(SectionReport);
  END; // fn_FullViewRisk function


 END; //Module Business Insight module;
