pversion 	:= '';		// modify to current date
directory := '/prod_data_build_10/production_data/business_headers/martindale_hubbell/';
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				martindale_hubbell._Flags
/////////////////////////////////////////////////////////////

#workunit('name', Martindale_Hubbell._Dataset().name + ' Build ' + pversion);
martindale_hubbell.Build_All(pversion, directory).all;