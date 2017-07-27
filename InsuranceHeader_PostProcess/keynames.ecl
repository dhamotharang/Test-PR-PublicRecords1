import tools;
export Keynames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	shared lTemplate(string tag)	:= _Dataset(pUseOtherEnvironment).KeyTemplate + tag;
	export  DID                   := tools.mod_FilenamesBuild(lTemplate('DID'),pversion);
	export  Dln                   := tools.mod_FilenamesBuild(lTemplate('DLn'),pversion);
  export  dAll_filenames        :=  DID.dAll_filenames + dln.dAll_filenames ; 
end;