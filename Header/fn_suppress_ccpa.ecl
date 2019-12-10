
// uses the HEADER 'src' field to identfiy and assign the CCPA global_sid value and then supresses records currently listed for supression
EXPORT fn_suppress_ccpa(hdr_in, suppressIt /* pass TRUE to suppress, or FALSE to only assign global_sid */) := FUNCTIONMACRO

    IMPORT mdr,doxie,data_services,Suppress;

    
    #UNIQUENAME(hdr_with_global_sid);
    %hdr_with_global_sid%:=mdr.macGetGlobalSID(hdr_in, 'PersonHeader', 'src', 'global_sid');
    #UNIQUENAME(mod_access);
    %mod_access% := MODULE(doxie.IDataAccess) END;
    #UNIQUENAME(hdr_out);
    %hdr_out%:=IF(suppressIt,Suppress.MAC_SuppressSource(%hdr_with_global_sid%,%mod_access%,,,TRUE, data_services.data_env.iNonFCRA)
                          ,%hdr_with_global_sid%);
    
    // return processed file
    return %hdr_out%;

ENDMACRO;