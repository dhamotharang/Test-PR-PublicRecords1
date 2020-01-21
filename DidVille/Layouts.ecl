IMPORT Didville, Doxie, Doxie_raw;

Export Layouts := MODULE

Export in_seq_rec := record
    STRING20 acctno;
    UNSIGNED6 did;
    DidVille.Layout_Did_InBatch;
    STRING14 driver_license;
    String10 phoneno_1;
    String10 phoneno_2;
    String10 phoneno_3;
    String10 phoneno_4;
    String10 phoneno_5;
    String10 phoneno_6;
    String10 phoneno_7;
    String10 phoneno_8;
    String10 phoneno_9;
    String10 phoneno_10;
    String10 phoneno_11;
end;

Export nbr_with_rank_rec := record
    doxie.layout_nbr_records;
    unsigned nbr_rank;
    string8 dod;
end;

Export rel_with_rank_rec := record
    doxie_Raw.Layout_RelativeRawBatchInput;
    unsigned4 rel_rank;
    string40 relationship;
end;

Export best_with_rank_rec := record
    doxie.layout_best;
    unsigned1 depth;
    unsigned4 rel_rank;
    string40 relationship;
    string15 relationship_type;
    string10 relationship_confidence;
    unsigned4 seqTarget;
end;

Export out_with_seq_rec := record
    unsigned4 seq;
    didville.Layout_RAN_BestInfo_BatchIn;
    didville.Layout_RAN_BestInfo_BatchOut;
    boolean input_addr_matched_rel;
    boolean input_addr_name_matched_rel;
end;

Export email_profile_rec := RECORD
    String email;
    string donotmail;
    string ProspectAge;
    string ProspectGender;
    string ProspectMaritalStatus;
    string ProspectEstimatedIncomeRange;
    string ProspectCollegeAttended;
    string CrtRecCnt;
    string CrtRecLienJudgCnt;
    string CrtRecBkrptCnt;
    string OccProfLicense;
    string OccProfLicenseCategory;
    string OccBusinessAssociation;
    string OccBusinessTitleLeadership;
    string HHEstimatedIncomeRange;
    string RaAMmbrCnt;
    string RaAMedIncomeRange;
    string RaACollegeAttendedMmbrCnt;
    string RaACrtRecMmbrCnt;
    string RaAOccBusinessAssocMmbrCnt;
end;

Export best_with_email_profile_rec := record
    best_with_rank_rec;
    email_profile_rec;
end;

Export nbr_with_email_profile_rec := record
    nbr_with_rank_rec;
    email_profile_rec;
end;

END;