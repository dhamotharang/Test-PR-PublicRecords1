export MAC_get_Rawdata(key_type, pUseProd = false) := functionmacro
    import ConsumerFinancialProtectionBureau, std;
    data_source := ConsumerFinancialProtectionBureau.filenames(pUseProd, isfcra).#expand('Base'+key_type+'_in');
    originalLayout := ConsumerFinancialProtectionBureau.layouts.#expand('original_'+key_type);
    RawData := if( pUseProd,
                    dataset(data_source, originalLayout, CSV(Heading(1))),
                    choosen(dataset(data_source, originalLayout, CSV(Heading(1))),200) //debug faster
    );
    return RawData;
ENDMACRO;