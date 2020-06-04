

IMPORT ut, NAC_V2, mdr, PromoteSupers, Header, STD;

 


STD.File.CreateSuperFile('~NAC::internal_email_distribution');
STD.File.CreateSuperFile('~NAC::internal_email_distribution_father');
STD.File.CreateSuperFile('~NAC::internal_email_distribution_grandfather');
 




 dsStaging01 := DATASET
 ([
 
 // {0, 'PPA','Dev_list1a','Jose.Bello@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1a','Charles.Pettola@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1a','Tony.Kirk@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1a','Charles.Salvo@lexisnexis.com', 'N'},
 
 // {0, 'PPA','Dev_list1','Jose.Bello@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1','Charles.Pettola@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1','Tony.Kirk@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1','Charles.Salvo@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1','ris-glonoc@risk.lexisnexis.com', 'N'},
 
 // {0, 'PPA','Dev_list1a','Jose.Bello@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1a','Charles.Pettola@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1a','Tony.Kirk@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1a','Charles.Salvo@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list1a','LNDataQA@lexisnexis.com', 'N'},
 
 // {0, 'PPA','Dev_list','Jose.Bello@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list','Charles.Pettola@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list','Tony.Kirk@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list','Charles.Salvo@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list','Cesar.Gonzalez@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list','nacprojectsupport@lnssi.com', 'N'},
 // {0, 'PPA','Dev_list','seth.hall@lnssi.com', 'N'},
 // {0, 'PPA','Dev_list','Jennifer.paganacci@lexisnexis.com', 'N'},
 
 // {0, 'PPA','DOPS_list','Jose.Bello@lexisnexis.com', 'N'},
 // {0, 'PPA','DOPS_list','Charles.Pettola@lexisnexis.com', 'N'},
 // {0, 'PPA','DOPS_list','Tony.Kirk@lexisnexis.com', 'N'},
 // {0, 'PPA','DOPS_list','Charles.Salvo@lexisnexis.com', 'N'},
 // {0, 'PPA','DOPS_list','LNDataQA@lexisnexis.com', 'N'}


 // {0, 'PPA','Dev_list2','Jose.Bello@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list2','Charles.Pettola@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list2','Tony.Kirk@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list2','Charles.Salvo@lexisnexis.com', 'N'},
 // {0, 'PPA','Dev_list2','LNDataQA@lexisnexis.com', 'N'}





{0, 'Contributory File Processing', 'AL01', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'AL01', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'AL01', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'AL01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'AL01', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'AL01', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'AL01', 'seth.hall@lnssi.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'AL01', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},

{0, 'File Input Notifications', 'AL01', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'AL01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'AL01', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'AL01', 'radames.ortega@lexisnexisrisk.com', 'N' , '20190910'},




{0, 'Contributory File Processing', 'FL99', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'FL99', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'FL99', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'FL99', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'FL99', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'FL99', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'FL99', 'seth.hall@lnssi.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'FL99', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},


{0, 'File Input Notifications', 'FL99', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'FL99', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'FL99', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'FL99', 'radames.ortega@lexisnexisrisk.com', 'N' , '20190910'},




{0, 'Contributory File Processing', 'GA01', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'GA01', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'GA01', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'GA01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'GA01', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'GA01', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'GA01', 'seth.hall@lnssi.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'GA01', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},



{0, 'File Input Notifications', 'GA01', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'GA01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'GA01', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'GA01', 'radames.ortega@lexisnexisrisk.com', 'N' , '20190910'},




{0, 'Contributory File Processing', 'LA01', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'LA01', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'LA01', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'LA01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'LA01', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'LA01', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'LA01', 'seth.hall@lnssi.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'LA01', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},


{0, 'File Input Notifications', 'LA01', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'LA01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'LA01', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'LA01', 'radames.ortega@lexisnexisrisk.com', 'N' , '20190910'},




{0, 'Contributory File Processing', 'MS01', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'MS01', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'MS01', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'MS01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'MS01', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'MS01', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'MS01', 'seth.hall@lnssi.com', 'N' , '20190826'},
{0, 'Contributory File Processing', 'MS01', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},



{0, 'File Input Notifications', 'MS01', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'MS01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'MS01', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', 'MS01', 'radames.ortega@lexisnexisrisk.com', 'N' , '20190910'},



{0, 'Failure', '', 'charles.pettola@lexisnexisrisk.com', 'N' , '20190826'},
{0, 'Failure', '', 'gabriel.marcan@lexisnexisrisk.com', 'N' , '20190826'},
{0, 'Failure', '', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{0, 'Failure', '', 'radames.ortega@lexisnexisrisk.com', 'N' , '20190826'},
{0, 'Failure', '', 'supercomputerops@lexisnexisrisk.com', 'N' , '20190826'},
{0, 'Failure', '', 'tony.kirk@lexisnexisrisk.com', 'N' , '20190826'},

{0, 'Success', '', 'charles.salvo@lexisnexisrisk.com', 'N' , '20190826'},
{0, 'Success', '', 'lnusdataqa@risk.lexisnexis.com', 'N' , '20190826'},
{0, 'Success', '', 'Manila-DVQA-All@lexisnexisrisk.com', 'N' , '20190826'},
{0, 'Success', '', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{0, 'Success', '', 'tony.kirk@lexisnexisrisk.com', 'N' , '20190826'},

{0, 'Validation', '', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{0, 'Validation', '', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{0, 'Validation', '', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{0, 'Validation', '', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{0, 'Validation', '', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{0, 'Validation', '', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{0, 'Validation', '', 'seth.hall@lnssi.com', 'N' , '20190826'},
{0, 'Validation', '', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},


 
//  aka NAC Dev1
{0, 'Devs&NOC', '', 'jose.bello@lexisnexis.com', 'N' , '20190827'},
{0, 'Devs&NOC', '', 'charles.pettola@lexisnexis.com', 'N' , '20190827'},
{0, 'Devs&NOC', '', 'tony.kirk@lexisnexis.com', 'N' , '20190827'},  
{0, 'Devs&NOC', '', 'charles.salvo@lexisnexisrisk.com', 'N' , '20190827'},
{0, 'Devs&NOC', '', 'ris-glonoc@risk.lexisnexis.com', 'N' , '20190827'},


//  aka NAC Dev2
{0, 'Alert', '', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{0, 'Alert', '', 'charles.salvo@lexisnexisrisk.com', 'N' , '20190826'},
{0, 'Alert', '', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{0, 'Alert', '', 'lnusdataqa@risk.lexisnexis.com', 'N' , '20190826'},
{0, 'Alert', '', 'Manila-DVQA-All@lexisnexisrisk.com', 'N' , '20190826'},
{0, 'Alert', '', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{0, 'Alert', '', 'tony.kirk@lexisnexisrisk.com', 'N' , '20190826'},



{0, 'Preprocess Error', '', 'jose.bello@lexisnexis.com', 'N' , '20190828'},
{0, 'Preprocess Error', '', 'radames.ortega@lexisnexisrisk.com', 'N' , '20190828'},
{0, 'Preprocess Error', '', 'tony.kirk@lexisnexis.com', 'N' , '20190828'},


{0, 'File Input Notifications', '', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', '', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', '', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},
{0, 'File Input Notifications', '', 'radames.ortega@lexisnexisrisk.com', 'N' , '20190910'}




 
 ] 
 , Layouts.rlInternalEmailFile);  

 
 
 
  
 ut.MAC_Sequence_Records(dsStaging01,RecordID,dsStaging02);
 
 


PromoteSupers.MAC_SF_BuildProcess(dsStaging02,'~NAC::internal_email_distribution',dsReturned ,,,true, pVersion := ((STRING8)Std.Date.Today())[1..8]);


EXPORT Recipients_Superfile_Internal := dsReturned;  




 