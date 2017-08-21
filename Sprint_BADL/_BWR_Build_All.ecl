pversion 	:= '20090826'																		;		// modify to current date
directory := '/prod_data_build_13/eval_data/sprint_badl/'	;
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
/////////////////////////////////////////////////////////////

#workunit('name', Sprint_BADL._Dataset().Name + ' Build ' + pversion);
Sprint_BADL.Build_All(pversion, directory).all;