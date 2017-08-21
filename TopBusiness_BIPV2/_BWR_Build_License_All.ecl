pversion 	:= '20130502'											;		// modify to current date
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				TopBusiness_BIPV2._Flags
/////////////////////////////////////////////////////////////

#workunit('name', TopBusiness_BIPV2._Dataset(,'License').Name + ' Build ' + pversion);

TopBusiness_BIPV2.Build_License_All(pversion);
