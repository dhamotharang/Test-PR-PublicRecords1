IMPORT HMS_KOP_TRGT_HARV;

pVersion := '20170324';
pUseProd := false; 
   
#workunit('name', 'HMS KOP TRGT HARV AUDIT Build ' + pVersion); //To Schedule Weekly on FRiday Mornings

HMS_KOP_TRGT_HARV.Build_All(pVersion,pUseProd);

