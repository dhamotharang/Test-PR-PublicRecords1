import tools;

export Keynames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export Input_Template	:= _Dataset(pUseProd).thor_cluster_files + 'key::'	+ _dataset().Name + '::@version@::';
	
	shared lBdid				:= Input_Template + 'bdid';
	shared lDid					:= Input_Template + 'did'	;
	shared lZoomId			:= Input_Template + 'zoomid';
	shared lXMLZoomId		:= Input_Template + 'XMLzoomid';
	shared lXLinkIds		:= Input_Template + 'linkIds';

	export Bdid				:= tools.mod_FilenamesBuild(lBdid				,pversion);
	export Did				:= tools.mod_FilenamesBuild(ldid				,pversion);
	export ZoomId			:= tools.mod_FilenamesBuild(lZoomId			,pversion);
	export XMLZoomId	:= tools.mod_FilenamesBuild(lXMLZoomId	,pversion);
	export XlinkIds		:= tools.mod_FilenamesBuild(lXLinkIds		,pversion);


	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ Did.dAll_filenames
		+ ZoomId.dAll_filenames
		+ XMLZoomId.dAll_filenames
		+ Xlinkids.dAll_filenames
		;

end;