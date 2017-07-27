export Mac_Email_Local(string filedate) := function

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	


email_success := fileservices.sendemail('RoxieBuilds@seisint.com;wma@seisint.com',
										'LiensV2 Build Succeeded - ' + filedate,
										'keys:   1)thor_data400::key::liensv2::main::tmsid.rmsid_qa(thor_data400::key::liensv2::'+filedate+'::main::TMSID.RMSID), \n' +                
  '2)thor_data400::key::liensv2::party::tmsid.rmsid_qa(thor_data400::key::liensv2::'+filedate+'::party::TMSID.RMSID) , \n' +                       
  '3)thor_data400::key::liensv2::did_qa(thor_data400::key::liensv2::'+filedate+'::DID), \n' +                         
  '4)thor_data400::key::liensv2::bdid_qa(thor_data400::key::liensv2::'+filedate+'::BDID) , \n' +                 
  '5)thor_data400::key::liensv2::ssn_qa(thor_data400::key::liensv2::'+filedate+'::ssn) , \n' +                
  '6)thor_data400::key::liensv2::taxid_qa(thor_data400::key::liensv2::'+filedate+'::taxID) , \n' +                     
  '7)thor_data400::key::liensv2::case_number_qa(thor_data400::key::liensv2::'+filedate+'::case_number) , \n' +          
  '8)thor_data400::key::liensv2::main::rmsid_qa(thor_data400::key::liensv2::'+filedate+'::main::RMSID) , \n' +          
   'have been built and ready to be deployed to QA.');
   
   return email_success;
   
   end;
													

											

