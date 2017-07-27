accuracy_layout := RECORD
  string5 fips_code;
  string1 land_use;
  integer8 record_count;
  integer8 pi_valuations_ct;
  integer8 ta_valuations_ct;
  integer8 hedonic_valuations_ct;
  real8 pi_accuracy;
  real8 ta_accuracy;
  real8 hedonic_accuracy;
END;

export File_Model_Accuracy_Table := dataset('~thor_data400::in::avm::model_accuracy', accuracy_layout, csv);