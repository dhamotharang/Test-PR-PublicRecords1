import tools;

EXPORT _filenames(

   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
  
) :=
module

	shared lfileprefix		  := _Constants(pUseOtherEnvironment).prefix	;
  
	export base             := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_mj6::base::@version@::data'	      ,pversion);
	export out              := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_mj6::out::@version@::data'	      ,pversion);
	export salt_iter        := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_mj6::salt_iter::@version@'	      ,pversion);
	export possiblematches  := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_mj6::possiblematches::@version@'	,pversion);
	export linkinghistory   := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_mj6::linkinghistory::@version@'	  ,pversion);
	export deletehistory    := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_mj6::deletehistory::@version@'	  ,pversion);
	export stats            := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_mj6::stats::@version@'	          ,pversion);
	export wkhistory        := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_mj6::wkhistory::@version@::data'  ,pversion);
	export precision        := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID_mj6::precision::@version@::data'  ,pversion);
	export summary_report   := tools.mod_FilenamesBuild(lfileprefix + 'bipv2_build::@version@::summary_report::proc_proxid_mj6.iterations'  ,pversion);
  
  export dall_filenames := 
      base            .dall_filenames
    + out             .dall_filenames
    + salt_iter       .dall_filenames
    + possiblematches .dall_filenames
    + linkinghistory  .dall_filenames
    + deletehistory   .dall_filenames
    + stats           .dall_filenames
    + wkhistory       .dall_filenames
    + precision       .dall_filenames
    ;
    
end;
