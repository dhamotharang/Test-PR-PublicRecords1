EXPORT MAC_Suppressions(inDS, record_type) := FUNCTIONMACRO
  
  import AutoStandardI, header;
  
  appType := (string)AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));  

  #uniquename(dinDS)
  %dinDS% := distribute(inDS, hash(did));

//CCPA suppression
  #uniquename(cleaned_ccpa)
  #if(record_type in [0])   
   %cleaned_ccpa% := header.fn_suppress_ccpa(%dinDS%, true);
  #else
   %cleaned_ccpa% := %dinDS%;
  #end

//DID suppression
  #uniquename(cleaned_did)		
  Suppress.MAC_Suppress(%cleaned_ccpa%,%cleaned_did%,appType,Suppress.Constants.LinkTypes.DID,did);

//SSN suppression
  SetOfNoSSN := [10,11,5,20,9,12,16,17,18,21,15,23];

  #uniquename(cleaned_ssn)	
  #if(record_type not in SetOfNoSSN) //[1,2,3,4,6,7,13,14,19,22,23]
    Suppress.MAC_Suppress(%cleaned_did%,%cleaned_ssn%,appType,Suppress.Constants.LinkTypes.SSN,ssn);    
  #else  //[10,11,5,20,9,12,16,17,18,21,15]
    %cleaned_ssn% := %cleaned_did%;   
  #end

  #uniquename(outDS)
  %outDS% := %cleaned_ssn%;

  return %outDS%;

ENDMACRO;