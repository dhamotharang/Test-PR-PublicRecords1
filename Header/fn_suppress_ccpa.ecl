
// uses the HEADER 'src' field to identfiy and assign the CCPA global_sid value and then supresses records currently listed for supression
EXPORT fn_suppress_ccpa(hdr_in) := FUNCTIONMACRO

    IMPORT mdr,doxie,data_services,Suppress;

    // Extract all source code from the header file
    #UNIQUENAME(just_src);
    %just_src%:=table(hdr_in,{ hdr_in.src,hdr_in.global_sid},src,global_sid,few,merge);
    
    // Append global_sid
    #UNIQUENAME(src_with_global_sid);
    %src_with_global_sid%:=mdr.macGetGlobalSID(%just_src%, 'PersonHeader', 'src', 'global_sid');

    // Run a lookup join to update the global_sid in the file
    #UNIQUENAME(hdr_after);
    %hdr_after%:=join(hdr_in,%src_with_global_sid%,LEFT.src=RIGHT.src,
                TRANSFORM(RECORDOF(LEFT),SELF.global_sid:=RIGHT.global_sid,SELF:=LEFT),LOOKUP);

    // send the file through the supression routine
    #UNIQUENAME(mod_access);
    %mod_access% := MODULE(doxie.IDataAccess) END;
    #UNIQUENAME(hdr_out);
    %hdr_out%:=Suppress.MAC_SuppressSource(%hdr_after%,%mod_access%,,,TRUE, data_services.data_env.iNonFCRA);

    // return processed file
    return %hdr_out%;

ENDMACRO;