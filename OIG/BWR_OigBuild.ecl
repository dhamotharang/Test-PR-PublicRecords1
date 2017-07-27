pversion    := '20130207;     	// modify to current date
folderDate  := '20130207'; 		//Raw file folder date
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// --    1. Put the Build Date in the "pversion" attribute above
// --    2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --          _control.MyInfo.EmailAddressNotify
// --        You will receive build emails to this address
// --    3. put the raw file folder date in the "folderDate" attribute 
/////////////////////////////////////////////////////////////
#workunit('name', 'OIG Build ' + pversion);
OIG.Build_all(pversion, folderDate);