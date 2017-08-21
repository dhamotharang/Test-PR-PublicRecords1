EXPORT DS_Version_IterNumber := MODULE
	Export VersionIterNumber_rec:=RECORD
		string20 version;
    string6 iternumber;
	end;

  Export VersionIterNumLGID3_rec:=record
			string20 version;
	    string20 iterNumber;
	end;
	
	EXPORT file_prefix := '~thor_data400::BIPV2_FindLinks::PROXID::V_I::';
	EXPORT file_prefix_lgid3 := '~thor_data400::BIPV2_FindLinks::LGID3::V_I::';
	shared wuid := thorlib.wuid();
	EXPORT logicalFilename      := file_prefix + wuid;
	EXPORT logicalFilename_LGID3      := file_prefix_lgid3 + wuid;
	
	Export superfile := file_prefix  + 'qa';
	Export superfile_lgid3 := file_prefix_lgid3  + 'qa';
	SHARED superfile_father := file_prefix + 'father';
	SHARED superfile_father_lgid3 := file_prefix_lgid3 + 'father';
	SHARED superfile_grandfather := file_prefix + 'grandfather';
	SHARED superfile_grandfather_lgid3 := file_prefix_lgid3 + 'grandfather';
	
	EXPORT updateProxSuperFile(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([superfile, 
																									 superfile_father,
																									 superfile_grandfather], inFile, true)
							);
		return action;
	END;
	
	EXPORT updateLgid3SuperFile(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([superfile_lgid3, 
																									 superfile_father_lgid3,
																									 superfile_grandfather_lgid3], inFile, true)
							);
		return action;
	END;
	
		
	EXPORT createProxVersionIterNumberFile() := FUNCTION	
		ds1:=table(BIPV2_FindLinks.Get_Key.PayloadProxChangeKey,{version,iternumber},merge);
    ds2:=sort(ds1,-version,iternumber,skew(1.0));
		ds3:=dedup(ds2,version,iternumber);
		ds4:=choosen(ds3,70);
		a := output(ds4, ,logicalFilename, overwrite);
		RETURN a;
	END;	
	
	EXPORT createLgid3VersionIterNumberFile() := FUNCTION	
		ds1:=table(BIPV2_FindLinks.Get_Key.PayloadRcidLgid3Key,{version,iternumber},merge);
    ds2:=sort(ds1,-version,iternumber,skew(1.0));
		ds3:=dedup(ds2,version,iternumber);
		ds4:=choosen(ds3,100);
		a := output(ds4, ,logicalFilename_LGID3, overwrite);
		RETURN a;
	END;	
	
	EXPORT UpdateProxVersionIterNumber() := FUNCTION
	
		a := createProxVersionIterNumberFile();
		b := updateProxSuperFile(logicalFilename);
		c := sequential(a,b);
		return c;
	END;
	
	EXPORT UpdateLgid3VersionIterNumber() := FUNCTION
	
		a := createLgid3VersionIterNumberFile();
		b := updateLgid3SuperFile(logicalFilename_LGID3);
		c := sequential(a,b);
		return c;
	END;
end;





