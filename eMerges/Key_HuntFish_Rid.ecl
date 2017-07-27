import  ut,doxie, Data_services;

export Key_HuntFish_Rid(boolean  IsFCRA = false) := function

		KeyName 			:= 'thor_data400::key::hunting_fishing::';
		KeyName_fcra  := 'thor_data400::key::hunting_fishing::fcra::';
		
		dBase    := huntfish_searchfile;
		
		key_name := Data_services.Data_location.Prefix('Emerges') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::rid';
									
		return_file		:= INDEX(dbase,{rid, persistent_record_id},{dbase},key_name);
													
		return(return_file); 
end;		