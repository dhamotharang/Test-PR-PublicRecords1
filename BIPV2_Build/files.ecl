import tools,wk_ut; 

export Files(

	 string   pversion              = ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

  shared fnames   := filenames(pversion,pUseOtherEnvironment);
  
	export Space_Usage  := tools.macf_FilesBase	(fnames.Space_Usage	  ,tools.Layout_Space_Used.big   );
	export Dashboard    := tools.macf_FilesBase	(fnames.Dashboard	    ,BIPV2_Build.Layouts.Dashboard );

	export Best_Flat    := tools.macf_FilesBase	(fnames.Best_Flat     ,BIPV2_Build.Layouts.Best_Flat  );
	export BIP_Owners   := tools.macf_FilesBase	(fnames.BIP_Owners    ,BIPV2_Build.Layouts.BIP_Owners );
  
	export workunit_history   := tools.macf_FilesBase	(fnames.workunit_history ,wk_ut.Layouts.wks_slim );
	
end;