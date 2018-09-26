import  doxie, Data_Services;

export Key_HuntFish_DID(boolean  IsFCRA = false) := function

	KeyName 			:= 'thor_data400::key::hunting_fishing::';
	KeyName_fcra  := 'thor_data400::key::hunting_fishing::fcra::';	
	
	// sf := huntfish_searchfile;

	// Filter to remove empty dids
	// dbase := sf(did_out!='');
	dbase := emerges.fBuild_Key_Huntfish_DID(IsFCRA);
	
	key_name := Data_services.Data_location.Prefix('Emerges') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::did';
										
	return_file		:= INDEX(dbase,{unsigned6 did := (unsigned6)dbase.did_out},{rid},key_name);
														
	return(return_file); 
end;		
