import tools;
EXPORT filenames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
  
) :=
module
	shared lfileprefix		  := _Constants(pUseOtherEnvironment).prefix	;
	export base             := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID::base::@version@::data'	            ,pversion);
	export out              := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID::out::@version@::data'	            ,pversion);
	export salt_iter        := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID::salt_iter::@version@'	            ,pversion);
	export possiblematches  := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID::possiblematches::@version@'	      ,pversion);
	export linkinghistory   := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID::linkinghistory::@version@'	        ,pversion);
	export deletehistory    := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID::deletehistory::@version@'	        ,pversion);
	export stats            := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID::stats::@version@'	                ,pversion);
	export wkhistory        := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID::wkhistory::@version@::data'        ,pversion);
	export precision        := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_ProxID::precision::@version@::data'        ,pversion);
	export changes          := tools.mod_FilenamesBuild('~'         + 'temp::proxid::BIPV2_ProxID::changes_it@version@' ,pversion);
     
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
    + changes         .dall_filenames
    ;
    
end;
