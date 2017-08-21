pversion 	:= '20091015'						;		// modify to current date
directory := '/hds_2/cp_utility'	;
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Zoom._Flags
/////////////////////////////////////////////////////////////

#workunit('name', Utility_Business._Dataset().Name + ' Build ' + pversion);
Utility_Business.Build_All(pversion, directory).all;