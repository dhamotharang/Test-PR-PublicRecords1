import _control;
export Mac_Email_Local(string filedate) := function

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	

//email_success := fileservices.sendemail(_control.MyInfo.EmailAddressNotify +';RoxieBuilds@seisint.com',										'Dnb_Fein Build Succeeded - ' + filedate,
email_success := fileservices.sendemail(_control.MyInfo.EmailAddressNotify ,										'Dnb_Fein Build Succeeded - ' + filedate,
										'keys: 1)thor_data400::key::dnbfein::bdid_qa(thor_data400::key::dnbfein::'+filedate+'::BDID) , \n' +
										       '2)thor_data400::key::dnbfein::tmsid_qa(thor_data400::key::dnbfein::'+filedate+'::tmsid),\n' +    
													 '3)thor_data400::key::dnbfein::linkids_qa(thor_data400::key::dnbfein::'+filedate+'::linkids),\n' + 
   'have been built and ready to be deployed to QA.');
   
   return email_success;
   
   end;
													

											

