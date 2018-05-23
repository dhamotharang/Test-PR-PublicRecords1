Import AID, AID_Support;

pversion 	:= 'YYYYMMDD'								 ;		// modify to current date
directory := '/hds_180/infutor_narb/data/' + pversion[1..8];
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				QA_Data._Flags
/////////////////////////////////////////////////////////////

// !!!!!!!!!!!!!! For Testing/Development !!!!!!!!!!!!!!!!! 
// This uses the alternate AID cache (non-header version)
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

#workunit('name', Infutor_NARB._Dataset().Name + ' Build ' + pversion);
Infutor_NARB.Build_All(pversion, directory);

