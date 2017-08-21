pversion 		:= '20070912'									;	// modify to current date
directory 	:= '/load01/spoke/'						;
pUpdateFile	:= Spoke.Files().Input.Using	;
pBaseFile		:= Spoke.Files().Base.qa			;	// use qa base in new layout
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Spoke._Flags
/////////////////////////////////////////////////////////////

#workunit('name', 'Spoke Build ' + pversion);
Spoke.Build_All(
	 pversion
	,directory
	,pUpdateFile		:= pUpdateFile
	,pBaseFile			:= pBaseFile
).all;