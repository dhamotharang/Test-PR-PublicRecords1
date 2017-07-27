import versioncontrol;

export Keynames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	export lFileTemplate	    := _Dataset(pUseOtherEnvironment).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::@version@::'				;
	export lFCRAFileTemplate	:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::fcra::@version@::'	;

	export addr_search1  			:= versioncontrol.mBuildFilenameVersions(lFileTemplate			+ 'addr_search1'	,pversion	);
	export addr_search2  			:= versioncontrol.mBuildFilenameVersions(lFileTemplate 			+ 'addr_search2'	,pversion	);
	export addr_fcra_search1  := versioncontrol.mBuildFilenameVersions(lFCRAFileTemplate	+ 'addr_search1'	,pversion	);
	export addr_search1_history		:= versioncontrol.mBuildFilenameVersions(lFileTemplate			+ 'addr_search1_history'	,pversion	);  
	export addr_fcra_search1_history  := versioncontrol.mBuildFilenameVersions(lFCRAFileTemplate	+ 'addr_search1_history'	,pversion	);
		
	export geolink  					:= versioncontrol.mBuildFilenameVersions(lFileTemplate 			+ 'geolink'				,pversion	);
   export city_search  					:= versioncontrol.mBuildFilenameVersions(lFileTemplate 			+ 'city'				,pversion	);
   export zip_search  					:= versioncontrol.mBuildFilenameVersions(lFileTemplate 			+ 'zip'				,pversion	);


	export dAll_reg_filenames :=
		  addr_search1.dAll_filenames
		+ addr_search1_history.dAll_filenames	
		+	addr_search2.dAll_filenames
		+	geolink.dAll_filenames
		+  city_search.dAll_filenames
		+   zip_search.dAll_filenames
	; 

	export dAll_fcra_filenames :=
		 	addr_fcra_search1.dAll_filenames
			+ addr_fcra_search1_history.dAll_filenames
	; 
                                                                        
	export dAll_filenames :=
		  addr_search1.dAll_filenames
		+ 
		addr_search1_history.dAll_filenames			
		+	addr_search2.dAll_filenames
		+	addr_fcra_search1.dAll_filenames
	  + addr_fcra_search1_history.dAll_filenames	
		+ geolink.dAll_filenames
		+  city_search.dAll_filenames
		+   zip_search.dAll_filenames
		
	; 

end;