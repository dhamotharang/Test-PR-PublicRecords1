﻿Import AID, AID_Support, _control;

pversion 	:= '20150601'								 ;		// modify to current date
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

Equifax_Business_Data.Build_All(pversion, 
                                '/data/temp/boneill/training/20180726/', 
																_control.IPAddress.bctlpedata12, 
																'LN_archive_Q*.txt');