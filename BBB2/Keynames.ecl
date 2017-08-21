import versioncontrol;
export Keynames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	shared cluster := _Dataset(pUseProd).thor_cluster_files;
	shared keyroot := cluster + 'key::' + _Dataset().name;
	
	export Member		:= 
	module

		export lNewBdidKeyTemplate	:= keyroot + '::@version@::Member::Bdid';
		export lOldBdidKeyTemplate	:= keyroot + '_bdid'										;
		
		export lNewLinkIdsKeyTemplate	:= keyroot + '::@version@::Member::linkids';
		export lOldLinkIdsKeyTemplate	:= keyroot + '_linkids'										 ;
		
		export BDID := versioncontrol.mBuildFilenameVersionsOld(lOldBdidKeyTemplate,	pversion, lNewBdidKeyTemplate);
		export LINKIDS 	:= versioncontrol.mBuildFilenameVersionsOld(lOldLinkIdsKeyTemplate,		pversion, lNewLinkIdsKeyTemplate);
		

		export dAll_filenames := 
				Bdid.dAll_filenames
			+ LinkIds.dAll_filenames
			;
		
	end;
	
	export NonMember :=
	module

		export lNewBdidKeyTemplate	:= keyroot + '::@version@::NonMember::Bdid'	;
		export lOldBdidKeyTemplate	:= keyroot + '_non_member_bdid'							;
		
		export lNewLinkIdsKeyTemplate	:= keyroot + '::@version@::NonMember::linkids'	;
		export lOldLinkIdsKeyTemplate	:= keyroot + '_non_member_linkids'							;
	
		export BDID	:= versioncontrol.mBuildFilenameVersionsOld(lOldBdidKeyTemplate,	pversion, lNewBdidKeyTemplate);
		export LINKIDS		:= versioncontrol.mBuildFilenameVersionsOld(lOldLinkIdsKeyTemplate,	pversion, lNewLinkIdsKeyTemplate);
	
		export dAll_filenames := 
				Bdid.dAll_filenames
			+	LinkIds.dAll_filenames
			;

	end;
	
	export dAll_filenames := 
			Member.dAll_filenames
		+	NonMember.dAll_filenames
		;

end;