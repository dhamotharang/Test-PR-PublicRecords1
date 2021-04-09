import dx_dma, dma, std, data_services, doxie;

export stats(string filedate, boolean build_full = false) := function
    kfield:= RECORD
        string10 Phonenumber;
    END;
    pfield := RECORD
        string10 phonenumber;
        unsigned4 dt_effective_first;
        unsigned4 dt_effective_last;
        unsigned1 delta_ind;
    END;
    key_old	:= if(build_full,
                        index({kfield}, {pfield}, '~thor_data400::key::DNC::father::phone'),
                        join(dx_dma.key_DNC_Phone, index({kfield}, {pfield}, dx_dma.names.key_dnc_new(filedate)), 
                        left.phonenumber	=	right.phonenumber and left.delta_ind != 3, 
                        left only)
                        );

    new_base := dma.File_SuppressionTPS_Delta.Base;

    key := dx_dma.key_DNC_Phone;
    last_Base :=	if(build_full,
                        dma.File_SuppressionTPS_Delta.father,
                        dma.File_SuppressionTPS_Delta.base - dma.File_SuppressionTPS_Delta.base_new(filedate)
                        );

    base_new_dedup := dedup(distribute(sort(new_base, phonenumber),hash32(PhoneNumber)),phonenumber,local);
    base_last_dedup := dedup(distribute(sort(last_Base, phonenumber),hash32(PhoneNumber)),phonenumber,local);

    extra_in_new_base := join(base_last_dedup, base_new_dedup, left.phonenumber	=	right.phonenumber, right only);
    missing_from_new_base := join(base_last_dedup, base_new_dedup, left.phonenumber	=	right.phonenumber and right.delta_ind != 3, left only);

    key_new_dedup := dedup(distribute(sort(key, phonenumber),hash32(PhoneNumber)),phonenumber,local);
    key_last_dedup := dedup(distribute(sort(key_old, phonenumber),hash32(PhoneNumber)),phonenumber,local);

    new_key :=	index(  {dx_dma.layouts.delta_keyfield},
                                    {dx_dma.layouts.delta_payload},
                                    dx_dma.names.key_dnc_new(filedate)
                                    );
    adds := new_key(delta_ind = 1);
    deletes := new_key(delta_ind = 3);

    extra_in_new_key := join(key_last_dedup, key_new_dedup, left.phonenumber	=	right.phonenumber, right only);
    missing_from_new_key := if(build_full,
                                join(key_last_dedup, key_new_dedup, left.phonenumber	=	right.phonenumber, left only),
                                deletes
                                );


    return sequential(  
                        output(count(base_new_dedup), named('new_base_record_count_'+filedate)),
                        output(count(base_last_dedup), named('last_base_record_count_'+filedate)),
                        //output(extra_in_new_base,, '~thor400::tps::base::extra_in_new_base', overwrite),
                        //output(missing_from_new_base,, '~thor400::tps::base::missing_from_new_base', overwrite),
                        output(count(key_new_dedup), named('new_key_record_count_'+filedate)),
                        output(count(key_last_dedup), named('last_key_record_count_'+filedate)),
                        output(extra_in_new_key,, '~thor400::tps::key::extra_in_new_key', overwrite),
                        output(missing_from_new_key,, '~thor400::tps::key::missing_from_new_key', overwrite),
                        output(count(missing_from_new_key),named('deleted_'+filedate)),
                        output(count(adds),named('new_delta_adds_'+filedate)),
                        output(count(deletes),named('new_delta_deletes_'+filedate)),
                        output(adds,named('adds_sample_'+filedate)),
                        output(deletes,named('deletes_sample_'+filedate)), 
    );
end;