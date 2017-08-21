pversion 	:= '20131028';		// modify to folder date
directory := '/hds_180/CrashCarrier/data/'+pversion[1..8];

/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				CrashCarrier._Flags
/////////////////////////////////////////////////////////////

#workunit('name', CrashCarrier._Dataset().Name + ' Build ' + pversion);
CrashCarrier.Build_All(pversion, directory);