Import AID, AID_Support;

pversion 	:= 'YYYYMMDD'								 ;		// modify to current tapeload folder date

/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Infutor_NARB._Flags
/////////////////////////////////////////////////////////////

#workunit('name', Infutor_NARB._Dataset().Name + ' Build ' + pversion);
Infutor_NARB.Build_All(pversion);

