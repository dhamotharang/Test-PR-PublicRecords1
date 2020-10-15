import $, tools;

export Keynames(
  string  pversion              = '',
  boolean pUseOtherEnvironment  = false
) :=
module
  shared lkeyTemplate       := $.Constants(pUseOtherEnvironment).keyTemplate;

  export LinkIds            := tools.mod_FilenamesBuild(lkeyTemplate    + 'linkIds'         ,pversion);
  export Hdr_Link_Id        := tools.mod_FilenamesBuild(lkeyTemplate    + 'hdr_linkid'      ,pversion);	
  export Attr_Link_Id       := tools.mod_FilenamesBuild(lkeyTemplate    + 'attr_linkid'     ,pversion);	
  export Executive_Link_Id  := tools.mod_FilenamesBuild(lkeyTemplate    + 'executive_linkid',pversion);

  export dAll_filenames      := LinkIds.dAll_filenames
                             + Hdr_Link_Id.dAll_filenames
                             + Attr_Link_Id.dAll_filenames
                             + Executive_Link_Id.dAll_filenames	
                             ;

end;
