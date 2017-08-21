pversion 	:= '20071017'								;		// modify to current date
directory := '/load01/zoom/20070927'	;
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Zoom._Flags
/////////////////////////////////////////////////////////////

#workunit('name', Zoom._Dataset().Name + ' Build ' + pversion);
Zoom.Build_All(pversion, directory).all;