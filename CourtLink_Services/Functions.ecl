IMPORT $, Autokey_batch, AutoStandardI, BatchServices;

EXPORT Functions := MODULE

  EXPORT ApplyPenalty(Autokey_batch.Layouts.rec_inBatchMaster L, $.Layouts.results_raw R) := FUNCTION

    persons_1 := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))
      EXPORT lastname       := l.name_last; // the 'input' last name
      EXPORT middlename     := l.name_middle; // the 'input' middle name
      EXPORT firstname      := l.name_first; // the 'input' first name
      // matching record
      EXPORT allow_wildcard := FALSE;
      EXPORT lname_field    := r.debtor_lname; // matching record.
      EXPORT mname_field    := r.debtor_mname;
      EXPORT fname_field    := r.debtor_fname;
      EXPORT useGlobalScope := FALSE;
    END;

    person_penalt := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(persons_1);

    RETURN person_penalt;

  END;

  EXPORT $.Layouts.batch_out FlattenBatch($.Layouts.results_raw_count le, DATASET($.Layouts.results_raw_count) allRows) := TRANSFORM

    SELF.acctno                          := le.acctno;

    SELF.LitigiousDebtor_FLAG            := allRows[1].LitigiousDebtor_Flag;
    SELF.LD_CaseTypeMatch_FDCPA          := IF(COUNT(CHOOSEN(allRows, 6)(causecode='1')) >=1, 'Y', 'N');
    SELF.LD_CaseTypeMatch_FCRA           := IF(COUNT(CHOOSEN(allRows, 6)(causecode='2')) >=1, 'Y', 'N');
    SELF.LD_CaseTypeMatch_TCPA           := IF(COUNT(CHOOSEN(allRows, 6)(causecode='3')) >=1, 'Y', 'N');

    SELF.LD_Additional_party_attorneys_1 := TRIM(allRows[1].AdditionalAttorneyName, LEFT, RIGHT);
    SELF.LD_Cause_1                      := TRIM(allRows[1].Cause, LEFT, RIGHT);
    SELF.LD_Defendants_Attorney_1        := TRIM(allRows[1].DAttorneyname, LEFT, RIGHT);

    SELF.LD_Defendants_1                 := TRIM(allRows[1].Defendant, LEFT, RIGHT);

    tmp_LD_Demand_1                      := if (allRows[1].DemandAmount <> '',
                                                batchservices.functions.convert_to_currency(allRows[1].DemandAmount),
                                                allRows[1].DemandAmount);
    SELF.LD_demand_1                     := TRIM(tmp_LD_demand_1, LEFT, RIGHT);
    SELF.LD_Docket_Case_Number_1         := TRIM(allRows[1].DocketNumber, LEFT, RIGHT);
    SELF.LD_Filing_date_1                := TRIM(allRows[1].DateFiled, LEFT, RIGHT);
    SELF.LD_Filing_type_1                := TRIM(allRows[1].ClassCode, LEFT, RIGHT);

    SELF.LD_Judge_1                      := TRIM(allRows[1].JudgeName, LEFT, RIGHT);
    SELF.LD_Jurisdiction_1               := TRIM(allRows[1].Jurisdiction, LEFT, RIGHT);
    SELF.LD_Jury_Demand_1                := TRIM(allRows[1].JuryDemand, LEFT, RIGHT);
    SELF.LD_Lead_Docket_Case_Number_1    := TRIM(allRows[1].LeadDocketNumber, LEFT, RIGHT);
    SELF.LD_Nature_of_Suit_1             := allRows[1].SuitNatureCode + ' ' + allrows[1].suitNatureDesc;
    SELF.LD_Other_Docket_Case_Number_1   := TRIM(allRows[1].OtherDocketNumber, LEFT, RIGHT);

    SELF.LD_Plaintiffs_Attorneys_1       := TRIM(allRows[1].PAttorneyname, LEFT, RIGHT);

    SELF.LD_Plaintiffs_1                 := TRIM(allRows[1].plaintiff, LEFT, RIGHT);

    SELF.LD_Court_Referred_To_1          := allRows[1].referredTojudgeTitle + ' ' + allRows[1].referredToJudge;
    SELF.LD_Status_1                     := IF (allRows[1].caseclosed ='Y', $.Constants.CASE_CLOSED, '');
    SELF.LD_Date_Court_Update_Record_1   := allRows[1].asOfDate;  // just a guess ???
    SELF.LD_Court_Of_Filing_1            := IF (allRows[1].CourtName <> '', allRows[1].CourtName + '; (' + allRows[1].officeName + ')', '');
    SELF.LD_Case_Title_1                 := TRIM(allRows[1].CaseCaption, LEFT, RIGHT);

    // 2
    SELF.LD_Additional_party_attorneys_2 := TRIM(allRows[2].AdditionalAttorneyName, LEFT, RIGHT);
    SELF.LD_Cause_2                      := TRIM(allRows[2].Cause, LEFT, RIGHT);
    SELF.LD_Defendants_Attorney_2        := TRIM(allRows[2].DAttorneyname, LEFT, RIGHT);

    SELF.LD_Defendants_2                 := TRIM(allRows[2].Defendant, LEFT, RIGHT);


    tmp_LD_Demand_2										   := IF (allRows[2].DemandAmount <> '',
                                                batchservices.functions.convert_to_currency(allRows[2].DemandAmount),
                                                allRows[2].DemandAmount);
    SELF.LD_Demand_2 										 := TRIM(tmp_LD_Demand_2, LEFT, RIGHT);
    SELF.LD_Docket_Case_Number_2         := TRIM(allRows[2].DocketNumber, LEFT, RIGHT);
    SELF.LD_Filing_date_2                := TRIM(allRows[2].DateFiled, LEFT, RIGHT);
    SELF.LD_Filing_type_2                := TRIM(allRows[2].ClassCode, LEFT, RIGHT);

    SELF.LD_Judge_2                      := TRIM(allRows[2].JudgeName, LEFT, RIGHT);
    SELF.LD_Jurisdiction_2               := TRIM(allRows[2].Jurisdiction, LEFT, RIGHT);
    SELF.LD_Jury_Demand_2                := TRIM(allRows[2].JuryDemand, LEFT, RIGHT);
    SELF.LD_Lead_Docket_Case_Number_2    := TRIM(allRows[2].LeadDocketNumber, LEFT, RIGHT);
    SELF.LD_Nature_of_Suit_2             := allRows[2].SuitNatureCode + ' ' + allrows[2].suitNatureDesc;
    SELF.LD_Other_Docket_Case_Number_2   := TRIM(allRows[2].OtherDocketNumber, LEFT, RIGHT);

    SELF.LD_Plaintiffs_Attorneys_2       := TRIM(allRows[2].PAttorneyname, LEFT, RIGHT);

    SELF.LD_Plaintiffs_2                 := TRIM(allRows[2].Plaintiff, LEFT, RIGHT);

    SELF.LD_Court_Referred_To_2          := allRows[2].referredTojudgeTitle + ' ' + allRows[2].referredToJudge;
    SELF.LD_Status_2                     := IF (allRows[2].caseclosed ='Y', $.Constants.CASE_CLOSED, '');
    SELF.LD_Date_Court_Update_Record_2   := TRIM(allRows[2].asOfDate, LEFT, RIGHT);  // just a guess ???
    SELF.LD_Court_Of_Filing_2            := IF (allRows[2].CourtName <> '', allRows[2].Courtname + '; (' + allRows[2].officeName + ')', '');
    SELF.LD_Case_Title_2                 := TRIM(allRows[2].CaseCaption, LEFT, RIGHT);

    // 3
    SELF.LD_Additional_party_attorneys_3 := TRIM(allRows[3].AdditionalAttorneyName, LEFT, RIGHT);
    SELF.LD_Cause_3                      := TRIM(allRows[3].Cause, LEFT, RIGHT);
    SELF.LD_Defendants_Attorney_3        := TRIM(allRows[3].DAttorneyname, LEFT, RIGHT);

    SELF.LD_Defendants_3                 := TRIM(allRows[3].Defendant, LEFT, RIGHT);


    tmp_LD_Demand_3 										 :=IF (allRows[3].DemandAmount <> '',
                                               batchservices.functions.convert_to_currency(allRows[3].DemandAmount),
                                               allRows[3].DemandAmount);
    SELF.LD_Demand_3               			 := TRIM(tmp_LD_Demand_3, LEFT, RIGHT);
    SELF.LD_Docket_Case_Number_3         := TRIM(allRows[3].DocketNumber, LEFT, RIGHT);
    SELF.LD_Filing_date_3                := TRIM(allRows[3].DateFiled, LEFT, RIGHT);
    SELF.LD_Filing_type_3                := TRIM(allRows[3].ClassCode, LEFT, RIGHT);

    SELF.LD_Judge_3                      := TRIM(allRows[3].JudgeName, LEFT, RIGHT);
    SELF.LD_Jurisdiction_3               := TRIM(allRows[3].Jurisdiction, LEFT, RIGHT);
    SELF.LD_Jury_Demand_3                := TRIM(allRows[3].JuryDemand, LEFT, RIGHT);
    SELF.LD_Lead_Docket_Case_Number_3    := TRIM(allRows[3].LeadDocketNumber, LEFT, RIGHT);
    SELF.LD_Nature_of_Suit_3             := allRows[3].SuitNatureCode + ' ' + allrows[3].suitNatureDesc;
    SELF.LD_Other_Docket_Case_Number_3   := TRIM(allRows[3].OtherDocketNumber, LEFT, RIGHT);

    SELF.LD_Plaintiffs_Attorneys_3       := TRIM(allRows[3].PAttorneyname, LEFT, RIGHT);

    SELF.LD_Plaintiffs_3                 := TRIM(allRows[3].Plaintiff, LEFT, RIGHT);

    SELF.LD_Court_Referred_To_3          := allRows[3].referredTojudgeTitle + ' ' + allRows[3].referredToJudge;
    SELF.LD_Status_3                     := IF (allRows[3].caseclosed ='Y', $.Constants.CASE_CLOSED, '');
    SELF.LD_Date_Court_Update_Record_3   := TRIM(allRows[3].asOfDate, LEFT, RIGHT);  // just a guess ???
    SELF.LD_Court_Of_Filing_3            := IF (allRows[3].CourtName <> '', allRows[3].Courtname + '; (' + allRows[3].officeName + ')', '');
    SELF.LD_Case_Title_3                 := TRIM(allRows[3].CaseCaption, LEFT, RIGHT);

    // 4
    SELF.LD_Additional_party_attorneys_4 := TRIM(allRows[4].AdditionalAttorneyName, LEFT, RIGHT);
    SELF.LD_Cause_4                      := TRIM(allRows[4].Cause, LEFT, RIGHT);
    SELF.LD_Defendants_Attorney_4        := TRIM(allRows[4].DAttorneyname, LEFT, RIGHT);

    SELF.LD_Defendants_4                 := TRIM(allRows[4].defendant, LEFT, RIGHT);


    tmp_LD_Demand_4 										 := IF (allRows[4].DemandAmount <> '',
                                                batchservices.functions.convert_to_currency(allRows[4].DemandAmount),
                                                allRows[4].DemandAmount);
    SELF.LD_Demand_4                     := TRIM(tmp_LD_Demand_4, LEFT, RIGHT);
    SELF.LD_Docket_Case_Number_4         := TRIM(allRows[4].DocketNumber, LEFT, RIGHT);
    SELF.LD_Filing_date_4                := TRIM(allRows[4].DateFiled, LEFT, RIGHT);
    SELF.LD_Filing_type_4                := TRIM(allRows[4].ClassCode, LEFT, RIGHT);

    SELF.LD_Judge_4                      := TRIM(allRows[4].JudgeName, LEFT, RIGHT);
    SELF.LD_Jurisdiction_4               := TRIM(allRows[4].Jurisdiction, LEFT, RIGHT);
    SELF.LD_Jury_Demand_4                := TRIM(allRows[4].JuryDemand, LEFT, RIGHT);
    SELF.LD_Lead_Docket_Case_Number_4    := TRIM(allRows[4].LeadDocketNumber, LEFT, RIGHT);
    SELF.LD_Nature_of_Suit_4             := allRows[4].SuitNatureCode + ' ' + allrows[4].suitNatureDesc;
    SELF.LD_Other_Docket_Case_Number_4   := TRIM(allRows[4].OtherDocketNumber, LEFT, RIGHT);

    SELF.LD_Plaintiffs_Attorneys_4       := TRIM(allRows[4].PAttorneyname, LEFT, RIGHT);

    SELF.LD_Plaintiffs_4                 := TRIM(allRows[4].Plaintiff, LEFT, RIGHT);

    SELF.LD_Court_Referred_To_4          := allRows[4].referredTojudgeTitle + ' ' + allRows[4].referredToJudge;
    SELF.LD_Status_4                     := IF (allRows[4].caseclosed ='Y', $.Constants.CASE_CLOSED, '');
    SELF.LD_Date_Court_Update_Record_4   := TRIM(allRows[4].asOfDate, LEFT, RIGHT);  // just a guess ???
    SELF.LD_Court_Of_Filing_4            := IF (allRows[4].CourtName <> '', allRows[4].Courtname + '; (' + allRows[4].officeName + ')', '');
    SELF.LD_Case_Title_4                 := TRIM(allRows[4].CaseCaption, LEFT, RIGHT);

    //5
    SELF.LD_Additional_party_attorneys_5 := TRIM(allRows[5].AdditionalAttorneyName, LEFT, RIGHT);
    SELF.LD_Cause_5                      := TRIM(allRows[5].Cause, LEFT, RIGHT);
    SELF.LD_Defendants_Attorney_5        := TRIM(allRows[5].DAttorneyname, LEFT, RIGHT);

    SELF.LD_Defendants_5                 := TRIM(allRows[5].defendant, LEFT, RIGHT);


    tmp_LD_Demand_5                      := IF (allRows[5].DemandAmount <> '',
                                                batchservices.functions.convert_to_currency(allRows[5].DemandAmount),
                                                allRows[5].DemandAmount);
    SELF.LD_Demand_5                     := TRIM(tmp_LD_Demand_5, LEFT, RIGHT);
    SELF.LD_Docket_Case_Number_5         := TRIM(allRows[5].DocketNumber, LEFT, RIGHT);
    SELF.LD_Filing_date_5                := TRIM(allRows[5].DateFiled, LEFT, RIGHT);
    SELF.LD_Filing_type_5                := TRIM(allRows[5].ClassCode, LEFT, RIGHT);

    SELF.LD_Judge_5                      := TRIM(allRows[5].JudgeName, LEFT, RIGHT);
    SELF.LD_Jurisdiction_5               := TRIM(allRows[5].Jurisdiction, LEFT, RIGHT);
    SELF.LD_Jury_Demand_5                := TRIM(allRows[5].JuryDemand, LEFT, RIGHT);
    SELF.LD_Lead_Docket_Case_Number_5    := TRIM(allRows[5].LeadDocketNumber, LEFT, RIGHT);
    SELF.LD_Nature_of_Suit_5             := allRows[5].SuitNatureCode + ' ' + allrows[5].suitNatureDesc;
    SELF.LD_Other_Docket_Case_Number_5   := TRIM(allRows[5].OtherDocketNumber, LEFT, RIGHT);

    SELF.LD_Plaintiffs_Attorneys_5       := TRIM(allRows[5].PAttorneyname, LEFT, RIGHT);

    SELF.LD_Plaintiffs_5                 := TRIM(allRows[5].Plaintiff, LEFT, RIGHT);

    SELF.LD_Court_Referred_To_5          := allRows[5].referredTojudgeTitle + ' ' + allRows[5].referredToJudge;
    SELF.LD_Status_5                     := IF (allRows[5].caseclosed ='Y', $.Constants.CASE_CLOSED, '');
    SELF.LD_Date_Court_Update_Record_5   := TRIM(allRows[5].asOfDate, LEFT, RIGHT);  // just a guess ???
    SELF.LD_Court_Of_Filing_5            := IF (allRows[5].CourtName <> '', allRows[5].Courtname + '; (' + allRows[5].officeName + ')', '');

    SELF.LD_Case_Title_5                 := TRIM(allRows[5].CaseCaption, LEFT, RIGHT);

    //6
    SELF.LD_Additional_party_attorneys_6 := TRIM(allRows[6].AdditionalAttorneyName, LEFT, RIGHT);
    SELF.LD_Cause_6                      := TRIM(allRows[6].Cause, LEFT, RIGHT);
    SELF.LD_Defendants_Attorney_6        := TRIM(allRows[6].DAttorneyname, LEFT, RIGHT);

    SELF.LD_Defendants_6                 := TRIM(allRows[6].Defendant, LEFT, RIGHT);


    tmp_LD_Demand_6                      := IF (allRows[6].DemandAmount <> '',
                                                batchservices.functions.convert_to_currency(allRows[6].DemandAmount),
                                                allRows[6].DemandAmount);
    SELF.LD_Demand_6                     := TRIM(tmp_LD_Demand_6, LEFT, RIGHT);
    SELF.LD_Docket_Case_Number_6         := TRIM(allRows[6].DocketNumber, LEFT, RIGHT);
    SELF.LD_Filing_date_6                := TRIM(allRows[6].DateFiled, LEFT, RIGHT);
    SELF.LD_Filing_type_6                := TRIM(allRows[6].ClassCode, LEFT, RIGHT);

    SELF.LD_Judge_6                      := TRIM(allRows[6].JudgeName, LEFT, RIGHT);
    SELF.LD_Jurisdiction_6               := TRIM(allRows[6].Jurisdiction, LEFT, RIGHT);
    SELF.LD_Jury_Demand_6                := TRIM(allRows[6].JuryDemand, LEFT, RIGHT);
    SELF.LD_Lead_Docket_Case_Number_6    := TRIM(allRows[6].LeadDocketNumber, LEFT, RIGHT);
    SELF.LD_Nature_of_Suit_6             := allRows[6].SuitNatureCode + ' ' + allrows[6].suitNatureDesc;
    SELF.LD_Other_Docket_Case_Number_6   := TRIM(allRows[6].OtherDocketNumber, LEFT, RIGHT);

    SELF.LD_Plaintiffs_Attorneys_6       := TRIM(allRows[6].PAttorneyname, LEFT, RIGHT);

    SELF.LD_Plaintiffs_6                 := TRIM(allRows[6].plaintiff, LEFT, RIGHT);

    SELF.LD_Court_Referred_To_6          := allRows[6].referredTojudgeTitle + ' ' + allRows[6].referredToJudge;
    SELF.LD_Status_6                     := IF (allRows[6].caseclosed ='Y', $.Constants.CASE_CLOSED, '');
    SELF.LD_Date_Court_Update_Record_6   := TRIM(allRows[6].asOfDate, LEFT, RIGHT);  // just a guess ???
    SELF.LD_Court_Of_Filing_6            := IF (allRows[6].CourtName <> '', allRows[6].Courtname + '; (' + allRows[6].officeName + ')', '');
    SELF.LD_Case_Title_6                 := TRIM(allRows[6].CaseCaption, LEFT, RIGHT);

    SELF                                 := le;
  END;

END;
