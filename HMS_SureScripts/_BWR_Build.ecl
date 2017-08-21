IMPORT HMS_SureScripts;
pversion := '20151126';
pProd := false;     
#workunit('name', 'HMS SureScript Build ' + pversion);
HMS_SureScripts.Build_All(pversion, pProd);