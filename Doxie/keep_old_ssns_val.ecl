boolean keep_old_ssns := false : STORED('KeepOldSsns');
boolean using_keep_ssns := false : STORED('UsingKeepSSNs');

export keep_old_ssns_val := ~using_keep_ssns OR keep_old_ssns;