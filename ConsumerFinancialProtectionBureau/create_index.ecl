import ConsumerFinancialProtectionBureau;
EXPORT create_index(key_type, base_rec, filedate = '', pUseProd = false, isfcra = false) := functionmacro

    //base_rec := ConsumerFinancialProtectionBureau.#expand('Build_'+ key_type +'(pUseProd, isfcra);');
   // save_base_workaround := build_base(base_rec, ConsumerFinancialProtectionBureau.Filenames(filedate, pUseProd, isfcra).#expand('Base'+ key_type));
    keyed_fields := #expand('ConsumerFinancialProtectionBureau.layouts.'+ key_type +'_keyed_fields;');
    keys:=  ConsumerFinancialProtectionBureau.Fn_Record2String(keyed_fields);

    payload_fields := #expand('ConsumerFinancialProtectionBureau.layouts.'+ key_type +'_payload;');
    payload_str := ConsumerFinancialProtectionBureau.Fn_Record2String(payload_fields);
    
    dist_id := distribute(base_rec, 
        hash(#expand(keys))
        ); 
    sort_id := sort(dist_id, #expand(keys), local);
    return index(
                sort_id,
                #expand('{'+keys+'}'),
                #expand('{'+payload_str+'}'),
                ConsumerFinancialProtectionBureau.Filenames(filedate, pUseProd, isfcra).#expand('key'+key_type)
                ); 

endmacro;
