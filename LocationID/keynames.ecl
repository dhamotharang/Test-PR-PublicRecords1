import tools;

export keynames(
                 string  pversion               = ''
                ,boolean pUseOtherEnvironment  = false
																,string  pCluster              = ''
               ) :=
module

  shared lprefix           := _Constants(pUseOtherEnvironment).prefix;
  shared lcluster          := lprefix + if(pCluster = '', 'thor_data400',pCluster) + '::';				
  export locidRawAidMap    := tools.mod_FilenamesBuild(lcluster + 'key::location_id::@version@::locid_rawaid_map' ,pversion);			
  export dall_filenames    := locidRawAidMap.dall_filenames;
end;
