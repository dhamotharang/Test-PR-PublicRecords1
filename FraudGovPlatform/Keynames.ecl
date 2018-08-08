import tools;

export Keynames(


	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module
	export lTemplate(string tag)	:=	_Dataset(pUseOtherEnvironment).KeyTemplate +'kel::' +tag;

	export Main := module
		export ClusterDetails								:= tools.mod_FilenamesBuild(lTemplate('ClusterDetails'),pversion);
		export ElementPivot									:= tools.mod_FilenamesBuild(lTemplate('ElementPivot'),pversion);
		export ScoreBreakdown								:= tools.mod_FilenamesBuild(lTemplate('ScoreBreakdown'),pversion);
			
		export dAll_filenames :=
		    ClusterDetails.dAll_filenames +
			 	ElementPivot.dAll_filenames +
				ScoreBreakdown.dAll_filenames ;
	end;
	
export dAll_filenames :=
		  Main.dAll_filenames ;


end;