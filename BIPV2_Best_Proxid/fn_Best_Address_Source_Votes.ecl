import mdr;
export fn_Best_Address_Source_Votes(STRING source,INTEGER Dups) :=
MAP(
        MDR.sourceTools.SourceIsGong_Business         (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsGong_Government       (trim(source[..2], all)) => 3.0 * dups
  ,     MDR.sourceTools.SourceIsYellow_Pages          (trim(source[..2], all)) => 2.9 * dups
  ,     MDR.sourceTools.SourceIsCorpV2                (trim(source[..2], all)) => 2.8 * dups
  ,     MDR.sourceTools.SourceIsDunn_Bradstreet       (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsVickers               (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsLiens_and_Judgments   (trim(source[..2], all)) => 2.7 * dups
  ,     MDR.sourceTools.SourceIsEdgar                 (trim(source[..2], all)) => 2.6 * dups
  ,     MDR.sourceTools.SourceIsIRS_5500              (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsState_Sales_Tax       (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsSEC_Broker_Dealer     (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsFDIC                  (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsFL_Non_Profit         (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsWorkmans_Comp         (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsIRS_Non_Profit        (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsProfessional_License  (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsFL_FBN                (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsDea                   (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsSKA                   (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsCredit_Unions         (trim(source[..2], all)) => 2.5 * dups
  ,     MDR.sourceTools.SourceIsBusiness_Registration (trim(source[..2], all)) => 2.4 * dups
  ,     MDR.sourceTools.SourceIsFBNV2                 (trim(source[..2], all)) => 2.3 * dups
  ,     MDR.sourceTools.SourceIsEmployee_Directories  (trim(source[..2], all))
    or  MDR.sourceTools.SourceIsAccurint_Trade_Show   (trim(source[..2], all)) => 2.2 * dups
  ,     MDR.sourceTools.SourceIsUCCS                  (trim(source[..2], all)) => 2.1 * dups
  ,     MDR.sourceTools.SourceIsBankruptcy            (trim(source[..2], all)) => 2.0 * dups
  ,     MDR.sourceTools.SourceIsWhois_domains         (trim(source[..2], all)) => 1.9 * dups
  ,                                                               dups
);