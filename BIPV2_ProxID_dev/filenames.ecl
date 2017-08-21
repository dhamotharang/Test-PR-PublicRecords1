import tools;
EXPORT filenames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
  
) :=
module
	shared lfileprefix		  := _Constants(pUseOtherEnvironment).prefix	;
	export base             := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_dev::base::@version@::data'	      ,pversion);
	export salt_iter        := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_dev::salt_iter::@version@'	      ,pversion);
	export possiblematches  := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_dev::possiblematches::@version@'	,pversion);
	export linkinghistory   := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_dev::linkinghistory::@version@'	  ,pversion);
	export deletehistory    := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_dev::deletehistory::@version@'	  ,pversion);
	export stats            := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_dev::stats::@version@'	          ,pversion);
	export wkhistory        := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_dev::wkhistory::@version@::data'  ,pversion);
	export precision        := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_dev::precision::@version@::data'  ,pversion);
	export dall_filenames := 
      base            .dall_filenames
    + salt_iter       .dall_filenames
    + possiblematches .dall_filenames
    + linkinghistory  .dall_filenames
    + deletehistory   .dall_filenames
    + stats           .dall_filenames
    + wkhistory       .dall_filenames
    + precision       .dall_filenames
    ;
    
end;
