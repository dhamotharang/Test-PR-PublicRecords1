EXPORT Mac_optout(inFile, outFile) := macro
IMPORT FCRA_OPT_OUT, Suppress,AutoStandardI;

//Suppressing DID(s)/SSN

appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

Suppress.MAC_Suppress(inFile,pulled_did,appType,Suppress.Constants.LinkTypes.DID,did);
Suppress.MAC_Suppress(pulled_did,pulled_ssn,appType,Suppress.Constants.LinkTypes.SSN,ssn);

//FCRA optout

FCRA_no_DIDoptout := join(pulled_ssn, fcra_opt_out.key_did, 
										 keyed(left.did = right.l_DID),transform(recordof(inFile),self := left), LEFT ONLY);

FCRA_no_SSNoptout	:=	join(FCRA_no_DIDoptout, fcra_opt_out.key_ssn,
										 keyed((unsigned6)left.ssn = right.l_SSN), transform(recordof(inFile),self := left),LEFT ONLY);
										 
outFile := FCRA_no_SSNoptout;
										 							 
endmacro;








	