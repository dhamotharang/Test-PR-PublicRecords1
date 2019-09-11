

IMPORT NAC_V2, mdr, PromoteSupers, Header, STD;

 


STD.File.CreateSuperFile('~NAC::internal_email_distribution');
STD.File.CreateSuperFile('~NAC::internal_email_distribution_father');
STD.File.CreateSuperFile('~NAC::internal_email_distribution_grandfather');
 




 outhead := DATASET
 ([
 
 // {'PPA','Dev_list1a','Jose.Bello@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1a','Charles.Pettola@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1a','Tony.Kirk@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1a','Charles.Salvo@lexisnexis.com', 'N'},
 
 // {'PPA','Dev_list1','Jose.Bello@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1','Charles.Pettola@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1','Tony.Kirk@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1','Charles.Salvo@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1','ris-glonoc@risk.lexisnexis.com', 'N'},
 
 // {'PPA','Dev_list1a','Jose.Bello@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1a','Charles.Pettola@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1a','Tony.Kirk@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1a','Charles.Salvo@lexisnexis.com', 'N'},
 // {'PPA','Dev_list1a','LNDataQA@lexisnexis.com', 'N'},
 
 // {'PPA','Dev_list','Jose.Bello@lexisnexis.com', 'N'},
 // {'PPA','Dev_list','Charles.Pettola@lexisnexis.com', 'N'},
 // {'PPA','Dev_list','Tony.Kirk@lexisnexis.com', 'N'},
 // {'PPA','Dev_list','Charles.Salvo@lexisnexis.com', 'N'},
 // {'PPA','Dev_list','Cesar.Gonzalez@lexisnexis.com', 'N'},
 // {'PPA','Dev_list','nacprojectsupport@lnssi.com', 'N'},
 // {'PPA','Dev_list','seth.hall@lnssi.com', 'N'},
 // {'PPA','Dev_list','Jennifer.paganacci@lexisnexis.com', 'N'},
 
 // {'PPA','DOPS_list','Jose.Bello@lexisnexis.com', 'N'},
 // {'PPA','DOPS_list','Charles.Pettola@lexisnexis.com', 'N'},
 // {'PPA','DOPS_list','Tony.Kirk@lexisnexis.com', 'N'},
 // {'PPA','DOPS_list','Charles.Salvo@lexisnexis.com', 'N'},
 // {'PPA','DOPS_list','LNDataQA@lexisnexis.com', 'N'}


 // {'PPA','Dev_list2','Jose.Bello@lexisnexis.com', 'N'},
 // {'PPA','Dev_list2','Charles.Pettola@lexisnexis.com', 'N'},
 // {'PPA','Dev_list2','Tony.Kirk@lexisnexis.com', 'N'},
 // {'PPA','Dev_list2','Charles.Salvo@lexisnexis.com', 'N'},
 // {'PPA','Dev_list2','LNDataQA@lexisnexis.com', 'N'}





{'Contributory File Processing', 'AL01', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'AL01', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'AL01', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'AL01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'AL01', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'AL01', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{'Contributory File Processing', 'AL01', 'seth.hall@lnssi.com', 'N' , '20190826'},
{'Contributory File Processing', 'AL01', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},

{'File Processing Completed', 'AL01', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{'File Processing Completed', 'AL01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{'File Processing Completed', 'AL01', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},



{'Contributory File Processing', 'FL99', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'FL99', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'FL99', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'FL99', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'FL99', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'FL99', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{'Contributory File Processing', 'FL99', 'seth.hall@lnssi.com', 'N' , '20190826'},
{'Contributory File Processing', 'FL99', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},


{'File Processing Completed', 'FL99', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{'File Processing Completed', 'FL99', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{'File Processing Completed', 'FL99', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},




{'Contributory File Processing', 'GA01', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'GA01', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'GA01', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'GA01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'GA01', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'GA01', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{'Contributory File Processing', 'GA01', 'seth.hall@lnssi.com', 'N' , '20190826'},
{'Contributory File Processing', 'GA01', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},



{'File Processing Completed', 'GA01', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{'File Processing Completed', 'GA01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{'File Processing Completed', 'GA01', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},




{'Contributory File Processing', 'LA01', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'LA01', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'LA01', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'LA01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'LA01', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'LA01', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{'Contributory File Processing', 'LA01', 'seth.hall@lnssi.com', 'N' , '20190826'},
{'Contributory File Processing', 'LA01', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},


{'File Processing Completed', 'LA01', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{'File Processing Completed', 'LA01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{'File Processing Completed', 'LA01', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},



{'Contributory File Processing', 'MS01', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'MS01', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'MS01', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'MS01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'MS01', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{'Contributory File Processing', 'MS01', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{'Contributory File Processing', 'MS01', 'seth.hall@lnssi.com', 'N' , '20190826'},
{'Contributory File Processing', 'MS01', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},



{'File Processing Completed', 'MS01', 'tony.kirk@lexisnexis.com', 'N' , '20190910'},
{'File Processing Completed', 'MS01', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190910'},
{'File Processing Completed', 'MS01', 'charles.pettola@lexisnexis.com', 'N' , '20190910'},



{'Failure', '', 'charles.pettola@lexisnexisrisk.com', 'N' , '20190826'},
{'Failure', '', 'gabriel.marcan@lexisnexisrisk.com', 'N' , '20190826'},
{'Failure', '', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{'Failure', '', 'radames.ortega@lexisnexisrisk.com', 'N' , '20190826'},
{'Failure', '', 'supercomputerops@lexisnexisrisk.com', 'N' , '20190826'},
{'Failure', '', 'tony.kirk@lexisnexisrisk.com', 'N' , '20190826'},

{'Success', '', 'charles.salvo@lexisnexisrisk.com', 'N' , '20190826'},
{'Success', '', 'lnusdataqa@risk.lexisnexis.com', 'N' , '20190826'},
{'Success', '', 'Manila-DVQA-All@lexisnexisrisk.com', 'N' , '20190826'},
{'Success', '', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{'Success', '', 'tony.kirk@lexisnexisrisk.com', 'N' , '20190826'},

{'Validation', '', 'cesar.gonzalez@lexisnexis.com', 'N' , '20190826'},
{'Validation', '', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{'Validation', '', 'charles.salvo@lexisnexis.com', 'N' , '20190826'},
{'Validation', '', 'jennifer.paganacci@lexisnexis.com', 'N' , '20190826'},
{'Validation', '', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{'Validation', '', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{'Validation', '', 'seth.hall@lnssi.com', 'N' , '20190826'},
{'Validation', '', 'tony.kirk@lexisnexis.com', 'N' , '20190826'},


 
//  aka NAC Dev1
{'Devs&NOC', '', 'jose.bello@lexisnexis.com', 'N' , '20190827'},
{'Devs&NOC', '', 'charles.pettola@lexisnexis.com', 'N' , '20190827'},
{'Devs&NOC', '', 'tony.kirk@lexisnexis.com', 'N' , '20190827'},  
{'Devs&NOC', '', 'charles.salvo@lexisnexisrisk.com', 'N' , '20190827'},
{'Devs&NOC', '', 'ris-glonoc@risk.lexisnexis.com', 'N' , '20190827'},


//  aka NAC Dev2
{'Alert', '', 'charles.pettola@lexisnexis.com', 'N' , '20190826'},
{'Alert', '', 'charles.salvo@lexisnexisrisk.com', 'N' , '20190826'},
{'Alert', '', 'jose.bello@lexisnexis.com', 'N' , '20190826'},
{'Alert', '', 'lnusdataqa@risk.lexisnexis.com', 'N' , '20190826'},
{'Alert', '', 'Manila-DVQA-All@lexisnexisrisk.com', 'N' , '20190826'},
{'Alert', '', 'nacprojectsupport@lnssi.com', 'N' , '20190826'},
{'Alert', '', 'tony.kirk@lexisnexisrisk.com', 'N' , '20190826'},




{'Preprocess Error', '', 'jose.bello@lexisnexis.com', 'N' , '20190828'},
{'Preprocess Error', '', 'radames.ortega@lexisnexisrisk.com', 'N' , '20190828'},
{'Preprocess Error', '', 'tony.kirk@lexisnexis.com', 'N' , '20190828'}

 ] 
 , Layouts.rlInternalEmailFile);  
 
 


PromoteSupers.MAC_SF_BuildProcess(outhead,'~NAC::internal_email_distribution',tntset,,,true, pVersion := Header.version_build);

EXPORT Recipients_Superfile_Internal := tntset;  

 
								
				
 
 