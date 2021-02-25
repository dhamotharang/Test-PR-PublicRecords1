import $, tools;

export Keynames(
  string  pversion              = '',
  boolean pUseOtherEnvironment  = false
) :=
module
  shared lkeyTemplate        := $.Constants(pUseOtherEnvironment).keyTemplate;

  export LinkIds             := tools.mod_FilenamesBuild(lkeyTemplate   + 'linkIds'        			,pversion);
  export Hdr_Link_Id         := tools.mod_FilenamesBuild(lkeyTemplate   + 'hdr_linkid'     		 	,pversion);
	export Hdr_Delta_Rid       := tools.mod_FilenamesBuild(lkeyTemplate  	+ 'hdr_delta_rid'  			,pversion);
  export Attr_Link_Id        := tools.mod_FilenamesBuild(lkeyTemplate   + 'attr_linkid'     		,pversion);
	export Attr_Delta_Rid      := tools.mod_FilenamesBuild(lkeyTemplate  	+ 'attr_delta_rid'  		,pversion);
  export Executive_Link_Id   := tools.mod_FilenamesBuild(lkeyTemplate   + 'executive_linkid'		,pversion);
	export Executive_Delta_Rid := tools.mod_FilenamesBuild(lkeyTemplate  	+ 'executive_delta_rid' ,pversion);
	export Bld_Version         := tools.mod_FilenamesBuild(lkeyTemplate  	+ 'build_version'       ,pversion);

  export dAll_filenames      := LinkIds.dAll_filenames
                             + Hdr_Link_Id.dAll_filenames
														 + Hdr_Delta_Rid.dAll_filenames
                             + Attr_Link_Id.dAll_filenames
														 + Attr_Delta_Rid.dAll_filenames
                             + Executive_Link_Id.dAll_filenames
														 + Executive_Delta_Rid.dAll_filenames
														 + Bld_Version.dAll_filenames
                             ;

end;
