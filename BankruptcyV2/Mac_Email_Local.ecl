export Mac_Email_Local(string filedate) := function

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	

//RoxieBuilds@seisint.com;
email_success := fileservices.sendemail('akayttala@seisint.com',
										'BankruptcyV2 Build Succeeded - ' + filedate,
										'keys: 1)thor_data400::key::bankruptcyv2::main::TMSID_qa(thor_data400::key::bankruptcyv2::'+filedate+'::main::TMSID), \n' +                
  '2)thor_data400::key::bankruptcyv2::search::TMSID_qa(thor_data400::key::bankruptcyv2::'+filedate+'::search::TMSID) , \n' +                       
  '3)thor_data400::key::bankruptcyv2::did_qa(thor_data400::key::bankruptcyv2::'+filedate+'::DID), \n' +                         
  '4)thor_data400::key::bankruptcyv2::bdid_qa(thor_data400::key::bankruptcyv2::'+filedate+'::BDID) , \n' +                 
  '5)thor_data400::key::bankruptcyv2::ssn_qa(thor_data400::key::bankruptcyv2::'+filedate+'::ssn) , \n' +                
  '6)thor_data400::key::bankruptcyv2::taxid_qa(thor_data400::key::bankruptcyv2::'+filedate+'::taxID) , \n' +                     
  '7)thor_data400::key::bankruptcyv2::case_number_qa(thor_data400::key::bankruptcyv2::'+filedate+'::case_number) , \n' +          
  'have been built and ready to be deployed to QA.');
   
   return email_success;
   
   end;
   
   
   


				

											

