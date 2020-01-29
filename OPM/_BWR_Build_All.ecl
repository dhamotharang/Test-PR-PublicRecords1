Import AID, AID_Support;

pversion 	:= '20190807'								 ;		// modify to current tapeload folder date

/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				OPM._Flags
/////////////////////////////////////////////////////////////

#workunit('name', OPM._Dataset().Name + ' Build ' + pversion);
OPM.Build_All(pversion);