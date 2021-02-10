IMPORT $, BatchServices, CourtLink;

layout_batch_common_acct := BatchServices.Layouts.layout_batch_common_acct;
layout_batch_common_name := BatchServices.Layouts.layout_batch_common_name;

EXPORT Layouts := MODULE

  EXPORT results_raw := RECORD, MAXLENGTH($.Constants.REC_MAXLENGTH)
    UNSIGNED2 penalt;
    layout_batch_common_acct;
    UNSIGNED2 LitigiousDebtor_Flag;
    CourtLink.Layouts.keybuild2;
    STRING1 CaseTypeSearch_FDCPA;
    STRING1 CaseTypeSearch_FCRA;
    STRING1 CaseTypeSearch_TCPA;
    STRING DAttorneyName;
    STRING PAttorneyName;
    STRING Defendant;
    STRING Plaintiff;
    UNSIGNED8 tmpAsOfDate;
    UNSIGNED2 match;
    STRING AdditionalAttorneyName;
  END;

  EXPORT results_raw_count := RECORD, MAXLENGTH($.Constants.REC_MAXLENGTH)
    layout_batch_common_acct;
    INTEGER CaseCount;
    UNSIGNED2 LitigiousDebtor_Flag;
    CourtLink.Layouts.keybuild2;
    STRING1 CaseTypeSearch_FDCPA;
    STRING1 CaseTypeSearch_FCRA;
    STRING1 CaseTypeSearch_TCPA;
    STRING DAttorneyName;
    STRING PAttorneyName;
    STRING Defendant;
    STRING Plaintiff;
    UNSIGNED8 tmpAsOfDate;
    STRING AdditionalAttorneyName;
  END;

  EXPORT results_autokey_plus := RECORD
    layout_batch_common_acct;
    CourtLink.Layouts.keybuild;
  END;

  EXPORT results_autokey_plusExtra := RECORD
    UNSIGNED2 penalt;
    layout_batch_common_acct;
    CourtLink.Layouts.keybuild;
    UNSIGNED2 LitigiousDebtor_Flag;
    STRING1 CaseTypeSearch_FDCPA;
    STRING1 CaseTypeSearch_FCRA;
    STRING1 CaseTypeSearch_TCPA;
  END;

  EXPORT batch_input := RECORD
    UNSIGNED8 seq := 0;
    layout_batch_common_acct;
    layout_batch_common_name -name_suffix;
    STRING4 max_results := '';
    STRING120 comp_name := '';
    STRING2 CourtJurisdiction := '';
    STRING1 CaseTypeSearch_FDCPA := '';
    STRING1 CaseTypeSearch_FCRA := '';
    STRING1 CaseTypeSearch_TCPA := '';
  END;

  EXPORT Sample_layout_input_raw := RECORD
    layout_batch_common_acct;
    STRING20 name_last := '';
    STRING100 addr := '';
    STRING10 zip := '';
    STRING20 city := '';
    STRING2 state := '';
    STRING120 comp_name := '';
    STRING20 name_first := '';
    STRING14 filing_number := '';
    STRING72 sic_code := '';
    STRING9 fein := '';
    STRING9 ssn := '';
    UNSIGNED8 DOB :=  0;
    STRING20 name_middle := '';
    STRING2 CourtJurisdiction := '';
    STRING1 CaseTypeSearch_FDCPA := '';
    STRING1 CaseTypeSearch_FCRA := '';
    STRING1 CaseTypeSearch_TCPA := '';
  END;


  EXPORT batch_out := RECORD
    STRING30 acctno;
    UNSIGNED2 LitigiousDebtor_FLAG;

    STRING1 LD_CaseTypeMatch_FDCPA;
    STRING1 LD_CaseTypeMatch_FCRA;
    STRING1 LD_CaseTypeMatch_TCPA;

    STRING100000 LD_Additional_party_attorneys_1;
    STRING100 LD_Cause_1;
    STRING100000 LD_Defendants_Attorney_1;
    STRING500 LD_Defendants_1;
    STRING30 LD_Demand_1;
    STRING30 LD_Docket_Case_Number_1;
    STRING15 LD_Filing_date_1;
    STRING50 LD_Filing_type_1;
    STRING100 LD_Judge_1;
    STRING30 LD_Jurisdiction_1;
    STRING25 LD_Jury_Demand_1;
    STRING30 LD_Lead_Docket_Case_Number_1;
    STRING150 LD_Nature_of_Suit_1;
    STRING250 LD_Other_Docket_Case_Number_1;
    STRING100000 LD_Plaintiffs_Attorneys_1;
    STRING250 LD_Plaintiffs_1;
    STRING150 LD_Court_Referred_To_1;
    STRING30 LD_Status_1;
    STRING50 LD_Date_Court_Update_RECORD_1;
    STRING150 LD_Court_Of_Filing_1;
    STRING150 LD_Case_Title_1;

    STRING100000 LD_Additional_party_attorneys_2;
    STRING100 LD_Cause_2;
    STRING100000 LD_Defendants_Attorney_2;
    STRING500 LD_Defendants_2;
    STRING30 LD_Demand_2;
    STRING30 LD_Docket_Case_Number_2;
    STRING15 LD_Filing_date_2;
    STRING50 LD_Filing_type_2;
    STRING100 LD_Judge_2;
    STRING30 LD_Jurisdiction_2;
    STRING25 LD_Jury_Demand_2;
    STRING30 LD_Lead_Docket_Case_Number_2;
    STRING150 LD_Nature_of_Suit_2;
    STRING250 LD_Other_Docket_Case_Number_2;
    STRING100000 LD_Plaintiffs_Attorneys_2;
    STRING250 LD_Plaintiffs_2;
    STRING150 LD_Court_Referred_To_2;
    STRING30 LD_Status_2;
    STRING50 LD_Date_Court_Update_RECORD_2;
    STRING150 LD_Court_Of_Filing_2;
    STRING150 LD_Case_Title_2;

    STRING100000 LD_Additional_party_attorneys_3;
    STRING100 LD_Cause_3;
    STRING100000 LD_Defendants_Attorney_3;
    STRING500 LD_Defendants_3;
    STRING30 LD_Demand_3;
    STRING30 LD_Docket_Case_Number_3;
    STRING15 LD_Filing_date_3;
    STRING50 LD_Filing_type_3;
    STRING100 LD_Judge_3;
    STRING30 LD_Jurisdiction_3;
    STRING25 LD_Jury_Demand_3;
    STRING30 LD_Lead_Docket_Case_Number_3;
    STRING150 LD_Nature_of_Suit_3;
    STRING250 LD_Other_Docket_Case_Number_3;
    STRING100000 LD_Plaintiffs_Attorneys_3;
    STRING250 LD_Plaintiffs_3;
    STRING150 LD_Court_Referred_To_3;
    STRING30 LD_Status_3;
    STRING50 LD_Date_Court_Update_RECORD_3;
    STRING150 LD_Court_Of_Filing_3;
    STRING150 LD_Case_Title_3;

    STRING100000 LD_Additional_party_attorneys_4;
    STRING100 LD_Cause_4;
    STRING100000 LD_Defendants_Attorney_4;
    STRING500 LD_Defendants_4;
    STRING30 LD_Demand_4;
    STRING30 LD_Docket_Case_Number_4;
    STRING15 LD_Filing_date_4;
    STRING50 LD_Filing_type_4;
    STRING100 LD_Judge_4;
    STRING30 LD_Jurisdiction_4;
    STRING25 LD_Jury_Demand_4;
    STRING30 LD_Lead_Docket_Case_Number_4;
    STRING150 LD_Nature_of_Suit_4;
    STRING250 LD_Other_Docket_Case_Number_4;
    STRING100000 LD_Plaintiffs_Attorneys_4;
    STRING250 LD_Plaintiffs_4;
    STRING150 LD_Court_Referred_To_4;
    STRING30 LD_Status_4;
    STRING50 LD_Date_Court_Update_RECORD_4;
    STRING150 LD_Court_Of_Filing_4;
    STRING150 LD_Case_Title_4;

    STRING100000 LD_Additional_party_attorneys_5;
    STRING100 LD_Cause_5;
    STRING100000 LD_Defendants_Attorney_5;
    STRING500 LD_Defendants_5;
    STRING30 LD_Demand_5;
    STRING30 LD_Docket_Case_Number_5;
    STRING15 LD_Filing_date_5;
    STRING50 LD_Filing_type_5;
    STRING100 LD_Judge_5;
    STRING30 LD_Jurisdiction_5;
    STRING25 LD_Jury_Demand_5;
    STRING30 LD_Lead_Docket_Case_Number_5;
    STRING150 LD_Nature_of_Suit_5;
    STRING250 LD_Other_Docket_Case_Number_5;
    STRING100000 LD_Plaintiffs_Attorneys_5;
    STRING250 LD_Plaintiffs_5;
    STRING150 LD_Court_Referred_To_5;
    STRING30 LD_Status_5;
    STRING50 LD_Date_Court_Update_RECORD_5;
    STRING150 LD_Court_Of_Filing_5;
    STRING150 LD_Case_Title_5;

    STRING100000 LD_Additional_party_attorneys_6;
    STRING100 LD_Cause_6;
    STRING100000 LD_Defendants_Attorney_6;
    STRING500 LD_Defendants_6;
    STRING30 LD_Demand_6;
    STRING30 LD_Docket_Case_Number_6;
    STRING15 LD_Filing_date_6;
    STRING50 LD_Filing_type_6;
    STRING100 LD_Judge_6;
    STRING30 LD_Jurisdiction_6;
    STRING25 LD_Jury_Demand_6;
    STRING30 LD_Lead_Docket_Case_Number_6;
    STRING150 LD_Nature_of_Suit_6;
    STRING250 LD_Other_Docket_Case_Number_6;
    STRING100000 LD_Plaintiffs_Attorneys_6;
    STRING250 LD_Plaintiffs_6;
    STRING150 LD_Court_Referred_To_6;
    STRING30 LD_Status_6;
    STRING50 LD_Date_Court_Update_RECORD_6;
    STRING150 LD_Court_Of_Filing_6;
    STRING150 LD_Case_Title_6;
  END;

END;
