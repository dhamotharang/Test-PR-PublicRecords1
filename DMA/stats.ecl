import dx_dma, dma, std, data_services, doxie;
#OPTION ('multiplePersistInstances', false);
export stats(string filedate) := function
    kfield:= RECORD
        string10 Phonenumber;
    END;
    pfield := RECORD
        string10 phonenumber;
        unsigned4 dt_effective_first;
    unsigned4 dt_effective_last;
    unsigned1 delta_ind;
    END;
    key_DNC_Phone	:=	index(																	{kfield},
                                                                        {pfield},
                                                                        Data_Services.foreign_prod+'thor_data400::key::DNC::'+ Doxie.Version_SuperKey +'::phone'
                                                                    ):persist('~thor400::tps::key::prod::persist');

    dev_base := dma.File_SuppressionTPS_Delta.Base;

    key := dx_dma.key_DNC_Phone;
    prod_Base :=	dataset(data_services.foreign_prod + 'thor_data400::base::suppression::tps',DMA.layout_suppressionTPS.Base,flat);

    base_dev_dedup := dedup(distribute(sort(dev_base, phonenumber),hash32(PhoneNumber)),phonenumber,local);
    base_prod_dedup := dedup(distribute(sort(prod_Base, phonenumber),hash32(PhoneNumber)),phonenumber,local);

    extra_in_dev_base := join(base_prod_dedup, base_dev_dedup, left.phonenumber	=	right.phonenumber, right only);
    missing_from_dev_base := join(base_prod_dedup, base_dev_dedup, left.phonenumber	=	right.phonenumber, left only);

    key_dev_dedup := dedup(distribute(sort(key, phonenumber),hash32(PhoneNumber)),phonenumber,local);
    key_prod_dedup := dedup(distribute(sort(key_DNC_Phone, phonenumber),hash32(PhoneNumber)),phonenumber,local);

    extra_in_dev_key := join(key_prod_dedup, key_dev_dedup, left.phonenumber	=	right.phonenumber, right only);
    missing_from_dev_key := join(key_prod_dedup, key_dev_dedup, left.phonenumber	=	right.phonenumber, left only);

    new_key :=	index(  {dx_dma.layouts.delta_keyfield},
                                    {dx_dma.layouts.delta_payload},
                                    dx_dma.names.key_dnc_new(filedate)
                                    );
    adds := new_key(delta_ind = 1);
    deletes := new_key(delta_ind = 3);

    return sequential(  
                        output(count(base_dev_dedup), named('dev_base_record_count')),
                        output(count(base_prod_dedup), named('prod_base_record_count')),
                        output(extra_in_dev_base,, '~thor400::tps::base::extra_in_dev_base', overwrite),
                        output(missing_from_dev_base,, '~thor400::tps::base::missing_from_dev_base', overwrite),
                        output(count(key_dev_dedup), named('dev_key_record_count')),
                        output(count(key_prod_dedup), named('prod_key_record_count')),
                        output(extra_in_dev_key,, '~thor400::tps::key::extra_in_dev_key', overwrite),
                        output(missing_from_dev_key,, '~thor400::tps::key::missing_from_dev_key', overwrite),
                        output(count(adds),named('new_delta_adds')),
                        output(count(deletes),named('new_delta_deletes')),
                        output(adds,named('adds_sample')),
                        output(deletes,named('deletes_sample')),
    );
end;