pversion 	:= '';		// modify to current date
directory := '/load01/sheila_greco/';
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Sheila_Greco
/////////////////////////////////////////////////////////////

#workunit('name', Sheila_Greco._Dataset.name + ' Build ' + pversion);
Sheila_Greco.Build_All(pversion, directory).all;