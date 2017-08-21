
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Modifiy "pversion" & "fileDate" dates accordingly ! 
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --			 _control.MyInfo.EmailAddressNotify,You will receive build emails to this address!
// --		3. Check the following attribute to make sure it is correct:	Experian_CRDB._Flags
/////////////////////////////////////////////////////////////

pversion 	 := '20131120';		// modify to current date,this date will be used to populate dt_first & dt_last seen dates
fileDate   := '20131017';  //Raw file folder date, this date will be used to spray the raw files on thor

#workunit('name', Experian_CRDB._Dataset().Name + ' Build ' + pversion);
Experian_CRDB.Build_All(fileDate,pversion);