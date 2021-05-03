IMPORT Equifax_Business_Data, _control;

pversion 	:= '20200820'								 ;		// modify to current date
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Equifax_Business_Data._Flags
/////////////////////////////////////////////////////////////

#workunit('name', Equifax_Business_Data._Dataset().Name + ' Build ' + pversion);

Equifax_Business_Data.Build_All(
pversion,
'/data/Builds/builds/equifax_business_data/data/processing/' +pversion[1..8],
_control.IPAddress.bctlpedata11,
'*Extract*txt',
'*Contact*txt'
);



                                