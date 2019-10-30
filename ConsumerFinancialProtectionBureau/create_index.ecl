import $;
EXPORT create_index(key_type, filedate = '', pUseProd = false, isfcra = false) := functionmacro

    base_rec := $.#expand('Build_'+ key_type +'(pUseProd, isfcra);');
    
    keyed_fields := #expand('$.layouts.'+ key_type +'_keyed_fields;');
    #uniquename(keys);
    %keys% :=  $.Fn_Record2String(keyed_fields);

    payload_fields := #expand('$.layouts.'+ key_type +'_payload;');
    #uniquename(payload_str);
    %payload_str% := $.Fn_Record2String(payload_fields);
    
    dist_id := distribute(base_rec, 
        hash(#expand(%keys%))
        ); 
    sort_id := sort(dist_id, #expand(%keys%), local);
    return index(
                sort_id,
                #expand('{'+%keys%+'}'),
                #expand('{'+%payload_str%+'}'),
                $.Filenames(filedate, pUseProd, isfcra).#expand('key'+key_type)
                ); 

endmacro;
