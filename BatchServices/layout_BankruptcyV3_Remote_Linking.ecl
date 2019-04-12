IMPORT $;

  bk_out_layout := $.layout_BankruptcyV3_Batch_out;
  bk_in_layout := $.layout_BankruptcyV3_Batch_in;

//Contains all needed PII fields to generate RL request as well as relevant RL result fields.
EXPORT layout_BankruptcyV3_Remote_Linking := RECORD

  //Input fields
  bk_in_layout.did;
  bk_in_layout.ssn;
  bk_in_layout.name_suffix;
  bk_in_layout.name_first;
  bk_in_layout.name_middle;
  bk_in_layout.name_last;
  bk_in_layout.prim_name;
  bk_in_layout.prim_range;
  bk_in_layout.sec_range;
  bk_in_layout.p_city_name;
  bk_in_layout.st;
  bk_in_layout.z5;

  //Output fields
  bk_out_layout.debtor_1_fname;
  bk_out_layout.debtor_1_mname;
  bk_out_layout.debtor_1_lname;
  bk_out_layout.debtor_1_name_suffix;
  bk_out_layout.debtor_did;
  bk_out_layout.debtor_prim_name;
  bk_out_layout.debtor_prim_range;
  bk_out_layout.debtor_sec_range;
  bk_out_layout.debtor_p_city_name;
  bk_out_layout.debtor_st;
  bk_out_layout.debtor_zip;

  //SSN here should be debtor_ssnmatch if present, otherwise debtor_ssn.
  STRING9 best_ssn;

  //Hash PII for deduping RL request.
  INTEGER hash_val;

  //Sequence to keep track of which RL result to use.
  bk_out_layout.sequenceNumber;

  //Fields for RL data.
  INTEGER reference_id;
  INTEGER conf_score;
  UNSIGNED6 best_lexid;
END;