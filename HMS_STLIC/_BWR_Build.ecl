IMPORT HMS_STLIC;

pVersion := '20150909';
pUseProd := false; 
   
#workunit('name', 'HMS State License Build ' + pversion);

HMS_STLIC.Build_All(pVersion,pUseProd);

