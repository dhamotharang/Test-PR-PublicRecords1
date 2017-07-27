IMPORT iesp, LN_PropertyV2_Services;

EXPORT layouts := MODULE

  export question_matrix := RECORD
    unsigned1 qid;
    string12 qname;
    Constants.t_prompt prompt;
    boolean multiple_correct;
    unsigned1 answers_num;
    unsigned1 answers_valid;
  end;

  // almost same as t_QuestionResp: no Id and default blank values are defines for datasets
  export question_ext := record
    Constants.t_prompt prompt;
    boolean MultipleCorrect;
    dataset (iesp.eAuth.t_Answer) answers {MAXCOUNT (iesp.Constants.EAUTHORIZE.MaxAnswers+1)};
    dataset (iesp.eAuth.t_SubQuestion) SubQuestions {xpath('SubQuestions/'), MAXCOUNT(iesp.Constants.EAUTHORIZE.MaxAnswers+1)}
       := dataset ([], iesp.eAuth.t_SubQuestion);
    dataset (iesp.share.t_StringArrayItem) InvalidAnswers {xpath('InvalidAnswers/'), MAXCOUNT(iesp.Constants.EAUTHORIZE.MaxInvalidAnswers+1)}
       := dataset ([], iesp.share.t_StringArrayItem);
  end;

  export slim_party := record (iesp.share.t_NameAndCompany)
    unsigned6 did;
  end;

  export slim_deeds := record
    LN_PropertyV2_Services.layouts.combined.widest.ln_fares_id;
    //iesp.propdeed.t_DeedRecord.SaleDate;
    iesp.share.t_Date SaleDate;
    iesp.propdeed.t_DeedRecord.SalePrice;
    iesp.propdeed.t_DeedRecord.DocumentType;
    iesp.share.t_Address PropertyAddress;
    //iesp.propdeed.t_DeedRecord.PropertyAddress;

    // need only persons' or company's names
    dataset (slim_party) Sellers {MAXCOUNT(iesp.Constants.PROP.MaxSellers)};
    //dataset(share.t_StringArrayItem) Owners {xpath('Owners/Name'), MAXCOUNT(iesp.Constants.PROP.MaxOwners)};
    unsigned4 srt_date; // need for sorting only
  end;

  export slim_assessments := record
    LN_PropertyV2_Services.layouts.combined.widest.ln_fares_id;
    iesp.propassess.t_AssessReportRecord.LivingSize;
    iesp.propassess.t_AssessRecord.LandUsage;
    iesp.propassess.t_AssessReportRecord.YearBuilt;
    iesp.propassess.t_AssessRecord.TaxYear;
    iesp.share.t_Address PropertyAddress;
    boolean IsSubjectOwned; // not used yet
    unsigned4 srt_date; // need for sorting only
  end;

END;

// export t_QuestionResp := record
	// string12 Id {xpath('Id')};
	// string128 Prompt {xpath('Prompt'), maxlength(128)};
	// boolean MultipleCorrect {xpath('MultipleCorrect')};
	// dataset(t_Answer) Answers {xpath('Answers/Answer'), MAXCOUNT(iesp.Constants.EAUTHORIZE.MaxAnswers)};
	// dataset(t_SubQuestion) SubQuestions {xpath('SubQuestions/'), MAXCOUNT(iesp.Constants.EAUTHORIZE.MaxAnswers)};
	// dataset(share.t_StringArrayItem) InvalidAnswers {xpath('InvalidAnswers/'), MAXCOUNT(iesp.Constants.EAUTHORIZE.MaxAnswers)};
// end;

