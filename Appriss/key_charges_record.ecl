import ut,doxie;

df:=DATASET('~thor_data400::temp::Appriss::charges_payloadformat',layout_payload_charges,FLAT);

// USING ATF keys as a key build template
//export key_atf_records := index(df,{atf_id},{df},ut.foreign_prod + 'thor_data400::key::atf::firearms::records_' + doxie.Version_SuperKey);

export key_charges_record := index(df,{booking_sid,charge_seq},{df},
               '~thor_200::key::appriss::'+ doxie.Version_SuperKey+'::charges_id');








