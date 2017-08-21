pversion 	:= '20130724'		;		// modify to current date

/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Experian_FEIN._Flags
/////////////////////////////////////////////////////////////

#workunit('name', Experian_FEIN._Dataset().Name + ' Build ' + pversion);
Experian_FEIN.Build_All(pversion);