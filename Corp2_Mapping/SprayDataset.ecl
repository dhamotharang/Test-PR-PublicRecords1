import _control, corp2, versioncontrol;

export SprayDataset( string		pSourceIP		= _Control.IPAddress.bctlpedata12
										,string		pSourceDir	= '/data/data_build_4/corporate_filings/out'
										,string		pCorpState	= ''
										,string		pversion		= ''
										,string		pGroupName	= versioncontrol.Groupname('44')
										,string   pSuffix			= ''
									) :=	function

	pattern1					:= '^[]\\\\[[:alpha:]_:@*]{2,}$';
	pattern2					:= '^[]\\\\[[:alpha:]_:@*]{2,}(\\\\|[]\\\\[[:alpha:]_:@*]{2,})*$';		

	//---------------------------------------------------------------------------------------------	
	// so if there is no filedate in the directory, assume it is in the out dir, grab from filename
	// if there is, use it in the filename
	//---------------------------------------------------------------------------------------------		
	Files := Corp2_Mapping.Filenames(,pGroupName).dAll_filenames;
	
	//---------------------------------------------------------------------------------------------		
	//convert to spray dataset
	//---------------------------------------------------------------------------------------------			
	VersionControl.Layout_Sprays.Info tConvert2SprayLayout(versioncontrol.layout_versions.inputs l) := transform
		self.SourceIP 					:= pSourceIP;
		self.SourceDirectory 		:= pSourceDir;
		self.directory_filter 	:= if(pversion = '',corp2.t2l(l.directory_filter),corp2.t2l(regexreplace('[*]', l.directory_filter, pversion)));		
		self.date_regex					:= '[0-9]{8}[[:alpha:]]?';
		self 										:= l;
	end;

	dspray_files 			:= project(Files, tConvert2SprayLayout(left)); 

	corpstate					:= map(regexfind('il_llc'					,pCorpState,nocase) => regexreplace('il_llc'					,pCorpState,'llc::il',nocase),
													 regexfind('il_lp'					,pCorpState,nocase) => regexreplace('il_lp'						,pCorpState,'lp::il',nocase),
													 regexfind('il'							,pCorpState,nocase)	=> regexreplace('il'							,pCorpState,pSuffix+'_[[:alpha:]]*::il',nocase),													 
													 regexfind('cotm'						,pCorpState,nocase) => regexreplace('cotm'						,pCorpState,'tm[[:alpha:]]*::co',nocase),
													 regexfind('co'							,pCorpState,nocase) => regexreplace('co'							,pCorpState,'corp[[:alnum:]]*::co',nocase),
													 regexfind('fl_daily'				,pCorpState,nocase) => regexreplace('fl_daily'				,pCorpState,'corpFile::fl',nocase),
													 regexfind('fl_quarterly'		,pCorpState,nocase) => regexreplace('fl_quarterly'		,pCorpState,'fl',nocase),
													 regexfind(pattern1,pCorpState) 								=> '^.*?'  + pCorpState +  '$',
													 regexfind(pattern2,pCorpState)      						=> '^.*?(' + pCorpState + ')$',
													 pCorpState
													);
												
	filter						:= if(corpstate = '',true,regexfind(corpstate,dspray_files.thor_filename_template,nocase));

	return dspray_files(filter);
	
end;
