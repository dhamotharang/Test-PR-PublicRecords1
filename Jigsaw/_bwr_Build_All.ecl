import _control;

pversion		:= '20100329'									;		// modify to current date
directory 	:= '/load01/jigsaw/'					;
pServerIP		:= _control.IPAddress.edata14a;
pFilename		:= '*live*xml'								;
pFilename2	:= '*dead*xml'								;
pFilename3	:= '*locked*xml'							;
pGroupName	:= Jigsaw._dataset().groupname;
pIsTesting	:= false											;
pOverwrite	:= false											;


/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
/////////////////////////////////////////////////////////////

#workunit('name', Jigsaw._Dataset().name + ' Build ' + pversion);
Jigsaw.Build_All(pversion,directory,pserverip,pfilename,pfilename2,pfilename3,pgroupname,pistesting,poverwrite).all;