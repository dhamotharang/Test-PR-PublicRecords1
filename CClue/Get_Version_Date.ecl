import _Control, ut, tools, STD;
// Gets Date from Remote File to use a version
EXPORT Get_Version_Date(	string	pInSuperFile						= '~foreign::' + _control.IPAddress.aprod_thor_dali + '::'+'thor::base::cclue::qa::search::output' // ~foreign::10.194.12.1::
												,	string	pCluster								= _Constants().groupname							 // 'thor400_sta01'
												, string	pRemoteIp								= _control.IPAddress.aprod_thor_dali   // insurance prod 
												//, string	pRemoteIp								= _control.IPAddress.adataland_dali   // insurance dataland 
												, boolean	pCompressed							= true
												, string	pEmailNotificationList	= _control.MyInfo.EmailAddressNotify
												, boolean pIsTesting							= false
											 )
 := function
 
		subfile_cnt 		:= STD.File.GetSuperFileSubCount(pInSuperFile);
		LogicalFileName := if (subfile_cnt > 0, STD.File.GetSuperFileSubName(pInSuperFile, subfile_cnt), 'Super file empty');
		
		rundate  := if (stringlib.stringfind(LogicalFileName, 'foreign',1) > 0,
										stringlib.stringfilter(LogicalFileName[stringlib.stringfind(LogicalFileName, 'thor',1)..],'0123456789')[1..8],
										stringlib.stringfilter(LogicalFileName,'0123456789')[1..8]);
		return rundate;
		
end;