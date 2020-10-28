import tools;

export Keynames(
  string  pversion             = ''
 ,boolean pUseOtherEnvironment = false

) :=
module

 shared lkeyTemplate      := $._Constants(pUseOtherEnvironment).keyTemplate;

 export LinkIds           := tools.mod_FilenamesBuild(lkeyTemplate  + 'linkIds'     ,pversion);
 export Delta_Rid         := tools.mod_FilenamesBuild(lkeyTemplate  + 'delta_rid'   ,pversion);
 export dAll_filenames    := LinkIds.dAll_filenames + Delta_Rid.dAll_filenames;

end;
