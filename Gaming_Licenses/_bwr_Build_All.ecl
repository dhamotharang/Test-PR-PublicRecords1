pversion := '';		// modify to current date
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Liquor_Licenses._Flags
/////////////////////////////////////////////////////////////

#workunit('name', Gaming_Licenses._Dataset.name + ' Build ' + pversion);
Gaming_Licenses.Build_All(pversion).all;