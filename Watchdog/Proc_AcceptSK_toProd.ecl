import ut;
ut.MAC_SK_Move('~thor_data400::key::watchdog_best.ssn','P',one);
ut.MAC_SK_Move('~thor_data400::key::watchdog_best.did','P',two);
ut.MAC_SK_Move('~thor_data400::key::watchdog_nonglb.did','P',three);

export Proc_AcceptSK_toProd := sequential(one,two,three);