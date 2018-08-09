Import AID, AID_Support;

pversion 	:= 'YYYYMMDD'								 ;		// modify to current date
directory := '/hds_180/qa_data/data/' + pversion[1..8];
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				QA_Data._Flags
/////////////////////////////////////////////////////////////

// !!!!!!!!!!!!!! THIS IS VERY IMPORTANT !!!!!!!!!!!!!!!!! 
// This uses the alternate AID cache (non-header version)
// The QADI Vendor does not send good/reliable addresses, 
// so we must use the alternate (non-header) cache
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

#workunit('name', QA_Data._Dataset().Name + ' Build ' + pversion);
QA_Data.Build_All(pversion, directory);