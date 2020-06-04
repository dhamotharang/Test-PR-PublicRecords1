EXPORT fn_suppress_ccpa(ds_in, isheader=FALSE, sdata_set, sFieldName='', sGlobalSid='global_sid', suppressIt=FALSE) := FUNCTIONMACRO
/* Parameters to this macro
  ds_in = dataset to pass to macro
  isheader = true if dataset is header
  sdata_set = dataset name to lookup global_sid table
  sFieldName = source field name if needed
  sGlobalSid = global_sid field name if different than global_sid
  suppressIt = TRUE to suppress, or FALSE to only assign global_sid 
*/

  IMPORT mdr,doxie,dx_header,data_services,Suppress;

  #UNIQUENAME(ds_in_wglobal_sid);
  #IF(isheader)
    %ds_in_wglobal_sid% := PROJECT(ds_in,TRANSFORM(dx_header.layout_header, SELF:=LEFT));
  #ELSE
    %ds_in_wglobal_sid% := ds_in;
  #END
  #UNIQUENAME(append_global_sid);
  %append_global_sid% := mdr.macGetGlobalSID(%ds_in_wglobal_sid%, sdata_set, sFieldName, sGlobalSid);
  #UNIQUENAME(mod_access);
  %mod_access% := MODULE(doxie.IDataAccess) END;
  #UNIQUENAME(suppress_global_sid);
  %suppress_global_sid% := IF(suppressIt,Suppress.MAC_SuppressSource(%append_global_sid%,%mod_access%,,,TRUE, data_services.data_env.iNonFCRA)
    ,%append_global_sid%);
  #UNIQUENAME(ds_out);
  #IF(isheader)
    %ds_out%:= PROJECT(%suppress_global_sid%,TRANSFORM(RECORDOF(ds_in), SELF:=LEFT));
  #ELSE
    %ds_out%:= %suppress_global_sid%;
  #END
  RETURN %ds_out%;

ENDMACRO;