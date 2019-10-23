import tools;
EXPORT _filenames(
   string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false
  
) :=
module
	shared lfileprefix		  := _Constants(pUseOtherEnvironment).prefix	;
  
	export base             := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_LGID3::base::@version@::data'	    ,pversion);
	export salt_iter        := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_LGID3::salt_iter::@version@'	      ,pversion);
	export possiblematches  := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_LGID3::possiblematches::@version@'	,pversion);
	export linkinghistory   := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_LGID3::linkinghistory::@version@'	,pversion);
	export deletehistory    := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_LGID3::deletehistory::@version@'	  ,pversion);
	export stats            := tools.mod_FilenamesBuild(lfileprefix + 'BIPV2_LGID3::stats::@version@'	          ,pversion);
  
	export dall_filenames := 
      base            .dall_filenames
    + salt_iter       .dall_filenames
    + possiblematches .dall_filenames
    + linkinghistory  .dall_filenames
    + deletehistory   .dall_filenames
    + stats           .dall_filenames
    ;
    
end;
