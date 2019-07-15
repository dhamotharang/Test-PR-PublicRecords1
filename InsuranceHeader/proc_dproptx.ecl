import InsuranceHeader_Property_Transactions_Deeds;

export proc_dproptx (string pversion = workunit[2..7], string iter = '1') := module

prepit    := InsuranceHeader_Property_Transactions_Deeds.proc_preprocess(pversion);
iterit    := InsuranceHeader_Property_Transactions_Deeds.proc_iterprocess(pversion,iter);
postit    := InsuranceHeader_Property_Transactions_Deeds.proc_postprocess(pversion,iter);
//buildkeys := InsuranceHeader_Property_Transactions_Deeds.Build_keys_new(pversion).run;

export run := sequential(prepit,iterit,postit);

end;