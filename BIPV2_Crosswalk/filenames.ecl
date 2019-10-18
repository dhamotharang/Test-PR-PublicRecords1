import tools;

export filenames(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

     shared lfileprefix    := BIPV2_Crosswalk._Constants(pUseOtherEnvironment).prefix;

     export crossWalkFile  := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2::Crosswalk::@version@', pversion);
     export b2cFile        := tools.mod_FilenamesBuild(lfileprefix + 'key::BIPV2::Crosswalk::biz2Consumer::@version@', pversion);
     export c2bFile        := tools.mod_FilenamesBuild(lfileprefix + 'key::BIPV2::Crosswalk::consumer2Biz::@version@', pversion);
  
     export dall_filenames := crossWalkFile.dall_filenames 
	                       + b2cFile.dall_filenames
					   + c2bFile.dall_filenames;
end;