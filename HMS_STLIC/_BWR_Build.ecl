IMPORT HMS_STLIC;

pVersion := '20170328';
pUseProd := true; 
   
#workunit('name', 'HMS State License Build ' + pversion);

HMS_STLIC.Build_All(pVersion,pUseProd);

