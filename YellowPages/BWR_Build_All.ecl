pversion 	:= '20111121'								;		// modify to current date
directory := '/hds_180/targus/pure_business_iyp_cp/' + pversion + '/'	;
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// -- 	2. Make sure the directory attribute above is correct.
// --		3. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
/////////////////////////////////////////////////////////////

#workunit('name', YellowPages.Constants().Name + ' Build ' + pversion);
YellowPages.Proc_Build_All(pversion, directory).all;