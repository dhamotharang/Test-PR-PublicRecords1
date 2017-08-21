pversion    := '20120222';     	// modify to current date,this date will be used to populate dates(dt_first & dt_last)
folderDate  := '20120127'; 		//Raw files folder date, this date will be used to spray the raw files on thor
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// --    1. Put the Build Date in the "pversion" attribute above
// --    2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --          _control.MyInfo.EmailAddressNotify
// --        You will receive build emails to this address
// --    3. put the raw file folder date in the "folderDate" attribute 
/////////////////////////////////////////////////////////////
#workunit('name', 'ECRulings Build ' + pversion);
ECRulings.Build_all(pversion, folderDate);