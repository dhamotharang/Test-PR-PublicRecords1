pversion 	:= '20101215'						;		// modify to current date
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
/////////////////////////////////////////////////////////////

#workunit('name', POEsFromEmails._Dataset().Name + ' Build ' + pversion);
POEsFromEmails.Build_All(pversion).all;