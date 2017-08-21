export Mac_Email_Local(string filedate) := function

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	


email_success := fileservices.sendemail('cguyton@seisint.com;akayttala@seisint.com;RoxieBuilds@seisint.com',
										'BankruptcyV2 Build Succeeded - ' + filedate,
										'keys: 1)thor_data400::key::bankruptcyv2::main::TMSID_qa(thor_data400::key::bankruptcyv2::'+filedate+'::main::TMSID), \n' +                
  '2)thor_data400::key::bankruptcyv2::search::TMSID_qa(thor_data400::key::bankruptcyv2::'+filedate+'::search::TMSID) , \n' +                       
  '3)thor_data400::key::bankruptcyv2::did_qa(thor_data400::key::bankruptcyv2::'+filedate+'::DID), \n' +                         
  '4)thor_data400::key::bankruptcyv2::bdid_qa(thor_data400::key::bankruptcyv2::'+filedate+'::BDID) , \n' +                 
  '5)thor_data400::key::bankruptcyv2::ssn_qa(thor_data400::key::bankruptcyv2::'+filedate+'::ssn) , \n' +                
  '6)thor_data400::key::bankruptcyv2::taxid_qa(thor_data400::key::bankruptcyv2::'+filedate+'::taxID) , \n' +                     
  '7)thor_data400::key::bankruptcyv2::case_number_qa(thor_data400::key::bankruptcyv2::'+filedate+'::case_number) , \n' + 
	'8)thor_data400::key::bankruptcyv2::main::TMSID_V3_qa(thor_data400::key::bankruptcyv2::'+filedate+'::main::TMSID_v3) , \n' + 
	'9)thor_data400::key::bankruptcyv2::search::TMSID_v3_qa(thor_data400::key::bankruptcyv2::'+filedate+'::search::TMSID_v3) , \n' + 
  
 /* '8)thor_data400::key::BankruptcyV2::fcra::case_number_qa(thor_data400::key::bankruptcyv2::fcra::'+filedate+'::case_number) , \n' +  
  '9)thor_data400::key::bankruptcyv2::fcra::DID_qa(thor_data400::key::bankruptcyv2::fcra::'+filedate+'::DID) , \n' +  
  '10)thor_Data400::key::BankruptcyV2::fcra::didslim_qa(thor_data400::key::bankruptcyv2::fcra::'+filedate+'::didslim) , \n' +  
  '11)thor_data400::key::bankruptcyv2::fcra::main_qa(thor_data400::key::bankruptcyv2::fcra::'+filedate+'::main) , \n' +  
  '12)thor_data400::key::bankruptcyv2::fcra::bocashell_did_qa(thor_data400::key::bankruptcyv2::fcra::'+filedate+'::bocashell_did) , \n' +  

  */
  'have been built and ready to be deployed to QA.');
   
   return email_success;
   
   end;
   
   
   


				

											

