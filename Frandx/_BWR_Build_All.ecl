pversion 	:= '20180502'											;		// modify to current date
directory := '/data_build_1/frandx/in/'+pversion[1..8];
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Frandx._Flags
/////////////////////////////////////////////////////////////

#workunit('name', Frandx._Dataset().Name + ' Build ' + pversion);
Frandx.Build_All(pversion, directory);