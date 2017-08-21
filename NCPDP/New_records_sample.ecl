IMPORT NCPDP;

base_qa := NCPDP.Files().keybuild_Base.QA;

NCPDP_date_max := MAX(base_qa, Dt_Last_Seen);

ds1 := OUTPUT(CHOOSEN(base_qa(Dt_Last_Seen = NCPDP_date_max), 100), named('NCPDP_main_sample_QA'));

EXPORT New_records_sample := ds1;