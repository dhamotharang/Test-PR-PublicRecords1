import _control, versioncontrol;
export SprayDataset(

	 string		pSourceIP		= 'edata10'
	,string		pSourceDir	= '/data_build_4/corporate_filings/out'
	,string		pCorpState	= ''
	,string		pversion		= ''
	,string		pGroupName	= versioncontrol.Groupname('92')
) :=
function

	lVersion				:= if(pversion != '', pversion, regexfind('[[:digit:]]{8}'		,pSourceDir	,0));
	
// so if there is no filedate in the directory, assume it is in the out dir, grab from filename
// if there is, use it in the filename
	files := filenames(,pGroupName).dAll_filenames;
	//convert to spray dataset
	VersionControl.Layout_Sprays.Info tConvert2SprayLayout(versioncontrol.layout_versions.inputs l) :=
	transform
		self.SourceIP := pSourceIP;
		self.SourceDirectory := pSourceDir;
		self.directory_filter := stringlib.stringtolowercase(if(pversion = ''	,l.directory_filter
																							,trim(regexreplace('[*]', l.directory_filter, pversion))
														));
		self.date_regex				:= '[0-9]{8}[[:alpha:]]?';
		self := l;
		
	
	end;
	//colorado trademarks
	//tx llp, lp
	//split out emails into skipped files, sprayed files
	

	dspray_files := project(files, tConvert2SprayLayout(left)); 

	lCorpState := if(regexfind('il_llc',pCorpState,nocase)	, regexreplace('il_llc',pCorpState,'llc::il',nocase)
								,pCorpState);
								
	lCorpState2 := if(regexfind('il_lp',lCorpState,nocase)	, regexreplace('il_lp',lCorpState,'lp::il',nocase)
								,lCorpState);

	lCorpState3 := if(regexfind('cotm',lCorpState2,nocase)	, regexreplace('cotm',lCorpState2,'ctm',nocase)
								,lCorpState2);

	lCorpState4 := if(regexfind('co',lCorpState3,nocase)	, regexreplace('co',lCorpState3,'corp[[:alpha:]]*::co',nocase)
								,lCorpState3);

	lCorpState5 := if(regexfind('il_daily'	,lCorpState4,nocase)	, regexreplace('il_daily',lCorpState4,'daily_[[:alpha:]]*::il',nocase)
								,lCorpState4);

	lCorpState6 := if(regexfind('il_monthly',lCorpState5,nocase)	, regexreplace('il_monthly',lCorpState5,'monthly_[[:alpha:]]*::il',nocase)
								,lCorpState5);
	
	lCorpState7 := if(regexfind('ctm',lCorpState6,nocase)	, regexreplace('ctm',lCorpState6,'tm[[:alpha:]]*::co',nocase)
								,lCorpState6);

	lCorpState8 := if(regexfind('fl_daily',lCorpState7,nocase)	, regexreplace('fl_daily',lCorpState7,'corpFile::fl',nocase)
								,lCorpState7);

	lCorpState9 := if(regexfind('fl_quarterly',lCorpState8,nocase)	, regexreplace('fl_quarterly',lCorpState8,'fl',nocase)
								,lCorpState8);

	filterexpression := map(
		 regexfind('^[]\\[[:alpha:]_:@*]{2,}$'													,lCorpState9	)	=> '^.*?'	 + lCorpState9 + '$'
		,regexfind('^[]\\[[:alpha:]_:@*]{2,}(\\|[]\\[[:alpha:]_:@*]{2,})*$'	,lCorpState9	)	=> '^.*?(' + lCorpState9 + ')$'
		,lCorpState9 = ''																												=> ''
		,lCorpState9
	);
	
	filter	:= if(pCorpState = ''	,true
																,regexfind(filterexpression, dspray_files.Thor_filename_template, nocase)
						);

	return dspray_files(filter);

end;
