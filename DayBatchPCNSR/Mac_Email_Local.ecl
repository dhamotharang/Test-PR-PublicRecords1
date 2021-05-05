export Mac_Email_Local(string file_date) := function;

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	


email_success := fileservices.sendemail('RoxieBuilds@seisint.com, kgummadi@seisint.com, Christopher.Brodeur@lexisnexisrisk.com, harry.gist@lexisnexisrisk.com, Abednego.Escobal@lexisnexisrisk.com',
										'PCNSR Build Succeeded - ' + file_date,
										'keys:   1)thor_data400::key::daybatch_pcnsr::pcnsr.did_qa(thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.did), \n' +                
  '2)thor_data400::key::daybatch_pcnsr::pcnsr.lz3_qa(thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3) , \n' +                       
  /*'3)thor_data400::key::daybatch_pcnsr::pcnsr.zz4317_deduped_qa(thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.zz4317_deduped), \n' +                         
  '4)thor_data400::key::daybatch_pcnsr::pcnsr.phone.area_code.st_qa(thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.phone.area_code.st) , \n' +                 
  '5)thor_data400::key::daybatch_pcnsr::pcnsr.lz3_deduped_qa(thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3_deduped) , \n' +   */           
  '3)thor_data400::key::daybatch_pcnsr::pcnsr.z137lf_qa(thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.z137lf) , \n' +             
  '4)thor_data400::key::daybatch_pcnsr::pcnsr.hhid_qa(thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.hhid) , \n' + 
  '5)thor_data400::key::daybatch_pcnsr::pcnsr.address_qa(thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.address) , \n' + 
   'have been built and ready to be deployed to QA.');
   
   return email_success;
   
   end;
													
