import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export lTemplate	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + 'bipv2' + '::@version@::';

  export Industry_linkids	    := tools.mod_FilenamesBuild(lTemplate + 'industry_linkids'  ,pversion);
  export License_linkids	    := tools.mod_FilenamesBuild(lTemplate	+ 'license_linkids'		,pversion);

	export dAll_filenames := 
    Industry_linkids.dAll_filenames 
  + License_linkids	.dAll_filenames 
	;

end;