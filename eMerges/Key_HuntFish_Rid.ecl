import Data_services, doxie;

export Key_HuntFish_Rid(boolean  IsFCRA = false) := function

		KeyName 			:= 'thor_data400::key::hunting_fishing::';
		KeyName_fcra  := 'thor_data400::key::hunting_fishing::fcra::';
			
		key_name := Data_services.Data_location.Prefix('Emerges') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::rid';
    
    dBase := eMerges.fBuild_Key_Huntfish_Rid(IsFCRA);
									
		return_file		:= INDEX(dBase,{rid, persistent_record_id},{dbase},key_name);
													
		return(return_file); 

end;