import tools;

export filenames(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

     shared lfileprefix    := BIPV2_Crosswalk._Constants(pUseOtherEnvironment).prefix;

     export crossWalkFile  := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2::@version@::Crosswalk', pversion);
     export b2cFile        := tools.mod_FilenamesBuild(lfileprefix + 'key::BIPV2::Crosswalk::@version@::biz2Consumer', pversion);
     export c2bFile        := tools.mod_FilenamesBuild(lfileprefix + 'key::BIPV2::Crosswalk::@version@::consumer2Biz', pversion);
  
     export dall_filenames := crossWalkFile.dall_filenames;
	
     export dall_keynames  := b2cFile.dall_filenames
					   + c2bFile.dall_filenames;
end;