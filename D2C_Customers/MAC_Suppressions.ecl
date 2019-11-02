
EXPORT MAC_Suppressions(inDS, record_type) := FUNCTIONMACRO
  
  import Suppress;
  appType := (string)AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
// TBD - pass thorugh ccpa supprerssion
// MDR.macGetGlobalSid(hdrIn,'PersonHeaderKeys','src','global_sid');
// mod_access                 := MODULE(doxie.IDataAccess) END; // default mod_access
// suppress_global_sid        := Suppress.MAC_SuppressSource (cleaned_best_infutor, mod_access, , , TRUE);

#uniquename(pulled_ssn)	
#if(record_type not in [10,11,5,20,9,12,16,17,18,21,15])
    Suppress.MAC_Suppress(inDS,%pulled_ssn%,appType,Suppress.Constants.LinkTypes.SSN,ssn);
#else
    %pulled_ssn% := inDS;
#end    
#uniquename(cleaned_best)		
    Suppress.MAC_Suppress(%pulled_ssn%,%cleaned_best%,appType,Suppress.Constants.LinkTypes.DID,did);

#uniquename(outDS)
%outDS% := %cleaned_best%;

return %outDS%;

ENDMACRO;