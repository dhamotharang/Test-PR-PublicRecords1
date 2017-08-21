import ut, roxiekeybuild, _control;

// Set the file date you require below, 
// otherwise it will try dca.version, if that is empty, it will use thorlib.wuid()[2..9] 

export proc_build_dca_keys(string filedate) := function

// Email notification 

jobComplete := FileServices.sendemail('roxiebuilds@seisint.com,'+_control.MyInfo.EmailAddressNotify, ' DCA Roxie Key Build Succeeded - ' + filedate,
               'Keys: 1) thor_data400::key::dca_bdid_qa(thor_data400::key::dca::'+filedate+'::bdid),\n' + 
					     '      2) thor_data400::key::dca_root_sub_qa(thor_data400::key::dca::'+filedate+'::root_sub),\n' + 
					     '      3) thor_data400::key::dca_hierarchy_bdid_qa(thor_data400::key::dca::'+filedate+'::hierarchy_bdid),\n' + 
					     '      4) thor_data400::key::dca_hierarchy_root_sub_qa(thor_data400::key::dca::'+filedate+'::hierarchy_root_sub),\n' + 
					     '      5) thor_data400::key::dca_hierarchy_parent_to_child_root_sub_qa(thor_data400::key::dca::'+filedate+'::hierarchy_parent_to_child_root_sub),\n' + 
					     '      6) thor_data400::key::dca::autokey(thor_data400::key::dca::'+filedate+'::autokey),\n' + 
if(Constants().BUILD_BID_KEY_FLAG,
               'BID Keys: 1) thor_data400::key::dca_bid_qa(thor_data400::key::dca::'+filedate+'::bid),\n' + 
					     '      2) thor_data400::key::dca_root_sub_bid_qa(thor_data400::key::dca::'+filedate+'::root_sub_bid),\n' + 
					     '      3) thor_data400::key::dca_hierarchy_bid_qa(thor_data400::key::dca::'+filedate+'::hierarchy_bid),\n' + 
					     '      4) thor_data400::key::dca_hierarchy_root_sub_bid_qa(thor_data400::key::dca::'+filedate+'::hierarchy_root_sub_bid),\n' + 
					     '      5) thor_data400::key::dca::autokey::bid(thor_data400::key::dca::'+filedate+'::autokey::bid),\n','') +
		           '         have been built and moved to QA.');
							 
jobFailed := FileServices.sendemail(_control.MyInfo.EmailAddressNotify, ' DCA Roxie Key Build Failed - ' + filedate, failmessage);

//Update Roxie Page
UpdateRoxiePage := RoxieKeybuild.updateversion('DCAKeys', filedate, _control.MyInfo.EmailAddressNotify,,'N');

// return value (action)

retval :=
	sequential(
		parallel(
			proc_build_dca_keys_bdid(filedate),
			if(Constants().BUILD_BID_KEY_FLAG,proc_build_dca_keys_bid(filedate))),
		UpdateRoxiePage) :  success(jobComplete), failure(jobFailed);

return retval;																																										 
end;
