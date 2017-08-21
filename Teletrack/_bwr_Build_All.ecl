pversion 	:= '20100721'						;		// modify to current date
directory := '/data_build_1/teletrack'	;
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
/////////////////////////////////////////////////////////////

#workunit('name', Teletrack._Dataset().Name + ' Build ' + pversion);
Teletrack.Build_All(pversion, directory).all;