IMPORT HMS_CSR;

pVersion := '20150925';
pUseProd := false; 
   
#workunit('name', 'HMS State CSR Credential Build ' + pversion);

HMS_CSR.Build_All(pVersion,pUseProd);

