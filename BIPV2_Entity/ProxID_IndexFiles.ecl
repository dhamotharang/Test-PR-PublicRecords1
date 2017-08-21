import BIPV2;

EXPORT ProxID_IndexFiles := module

	shared buildDate := BIPV2.KeySuffix; 
	shared file_key_proxid 				:= '~thor_data400::key::ProxID_Test::' + buildDate + '::QA';
	shared file_key_dotid 				:= '~thor_data400::key::DOTID_Test::' + buildDate + '::QA';
	shared sfile_key_proxid			  := '~thor_data400::key::bipv2_ProxId::' + 'QA';
	

	shared slimds := ProxID_SlimFile.result;
	export key_proxid 		:= INDEX(slimds, {proxid}, {slimds},	sfile_key_proxid);
	export key_dotid 			:= INDEX(slimds, {dotid}, {slimds},	file_key_dotid);
	
  export build_keys	:= SEQUENTIAL(											
											Buildindex(key_proxid, file_key_proxid, overwrite),
											Buildindex(key_dotid, file_key_dotid, overwrite)
									 );		

end;