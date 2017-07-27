k := fileservices.dkc('~thor_data400::key::moxie.corp_event.bdid.key', '10.150.13.201', '/corp_data2_14/corp2_events.bdid.key');
k1 := fileservices.dkc('~thor_data400::key::moxie.corp_event.corp_key.event_filing_date.key', '10.150.13.201', '/corp_data2_14/corp2_events.corp_key.event_filing_date.key');
k2 := fileservices.dkc('~thor_data400::key::moxie.corp_event.corp_key.key', '10.150.13.201', '/corp_data2_14/corp2_events.corp_key.key');
k3 := fileservices.dkc('~thor_data400::key::moxie.corp_event.sos_charter_nbr.key', '10.150.13.201', '/corp_data2_14/corp2_events.sos_charter_nbr.key');
k4 := fileservices.dkc('~thor_data400::key::moxie.corp_event.st_orig.sos_charter_nbr.key', '10.150.13.201', '/corp_data2_14/corp2_events.st_orig.sos_charter_nbr.key');

export DKC_Corp_Event_Keys := sequential(k,k1,k2,k3,k4);