import BIPV2_PROX_SALT_RELATIONSHIP1;
EXPORT Key_Full_Build := module

	inFile := BIPV2_PROX_SALT_RELATIONSHIP1.In_DOT_Base;
	shared relatives := BIPV2_PROX_SALT_RELATIONSHIP1.keys(inFile).ASSOC; 
			
	export key_relationship_full  := INDEX(relatives, {Proxid1,Proxid2}, {relatives},	'~thor_data400::key::bipv2_relative_fullfile::qa');

	shared slimds := ProxID_SlimFile.result;
	export key_proxid_full 		:= INDEX(slimds, {proxid}, {slimds},	'~thor_data400::key::bipv2_proxid_fullfile::qa');
		
		// thor_data400::key::bipv2_relative_fullfile::qa
		// thor_data400::key::bipv2_proxid_fullfile::qa
		// thor_data400::bipv2_hrchy_full::key::proxid_qa
		// thor_data400::bipv2_hrchy_full::key::lgid_qa



	
end;