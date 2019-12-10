export MAC_build_Base_Data(key_type, pUseProd = false, isfcra = false) := functionmacro
    import ConsumerFinancialProtectionBureau, std;
    Rawdata := ConsumerFinancialProtectionBureau.MAC_get_Rawdata(key_type, pUseProd);
    return PROJECT(RawData, ConsumerFinancialProtectionBureau.mappings.#expand('convert_'+key_type)(left, counter, std.Date.CurrentDate()));
ENDMACRO;
