import tools;

export Keynames(


	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module
	export lTemplate(string tag)	:=	_Dataset(pUseOtherEnvironment).KeyTemplate +'kel::' +tag;

	export Main := module
		export EntityProfile								:= tools.mod_FilenamesBuild(lTemplate('EntityProfile'),pversion);
		export ConfigAttributes							:= tools.mod_FilenamesBuild(lTemplate('ConfigAttributes'),pversion);
		export ConfigRules									:= tools.mod_FilenamesBuild(lTemplate('ConfigRules'),pversion);
		export DisposableEmailDomains						:= tools.mod_FilenamesBuild(lTemplate('DisposableEmailDomains'),pversion);
		
		export dAll_filenames :=
				EntityProfile.dAll_filenames +
				ConfigAttributes.dAll_filenames +
				ConfigRules.dAll_filenames +
				DisposableEmailDomains.dAll_filenames ;
		end;
	
export dAll_filenames :=
		  Main.dAll_filenames ;


end;