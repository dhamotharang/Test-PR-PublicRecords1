k := fileservices.dkc(MOXIE_KEY_THOR + 'key::moxie.corp_event.bdid.key', MOXIE_DESPRAY_SERVER, MOXIE_CORP_MOUNT + 'corp2_events.bdid.key');
k1 := fileservices.dkc(MOXIE_KEY_THOR + 'key::moxie.corp_event.corp_key.event_filing_date.key', MOXIE_DESPRAY_SERVER, MOXIE_CORP_MOUNT + 'corp2_events.corp_key.event_filing_date.key');
k2 := fileservices.dkc(MOXIE_KEY_THOR + 'key::moxie.corp_event.corp_key.key', MOXIE_DESPRAY_SERVER, MOXIE_CORP_MOUNT + 'corp2_events.corp_key.key');
k3 := fileservices.dkc(MOXIE_KEY_THOR + 'key::moxie.corp_event.sos_charter_nbr.key', MOXIE_DESPRAY_SERVER, MOXIE_CORP_MOUNT + 'corp2_events.sos_charter_nbr.key');
k4 := fileservices.dkc(MOXIE_KEY_THOR + 'key::moxie.corp_event.st_orig.sos_charter_nbr.key', MOXIE_DESPRAY_SERVER, MOXIE_CORP_MOUNT + 'corp2_events.st_orig.sos_charter_nbr.key');

export DKC_Corp_Event_Keys := sequential(k,k1,k2,k3,k4);