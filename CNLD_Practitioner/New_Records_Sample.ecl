IMPORT CNLD_Practitioner;

base_qa := CNLD_Practitioner.Files().Base.QA;

CNLD_Practitioner_date_max := MAX(base_qa, Dt_Last_Seen);

ds1 := OUTPUT(CHOOSEN(base_qa(Dt_Last_Seen = CNLD_Practitioner_date_max), 100), named('CNLD_Practitioner_main_sample_QA'));

EXPORT New_records_sample := ds1;