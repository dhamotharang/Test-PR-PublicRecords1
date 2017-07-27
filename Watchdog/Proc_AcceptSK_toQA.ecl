import ut;
ut.MAC_SK_Move('~thor_data400::key::watchdog_best.ssn','Q',one);
ut.MAC_SK_Move('~thor_data400::key::watchdog_best.did','Q',two);
ut.MAC_SK_Move('~thor_data400::key::watchdog_nonglb.did','Q',three);

export Proc_AcceptSK_toQA := sequential(one,two,three);