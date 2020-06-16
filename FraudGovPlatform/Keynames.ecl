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
		export WeightingChart								:= tools.mod_FilenamesBuild(lTemplate('WeightingChart'),pversion);
		export EntityProfile								:= tools.mod_FilenamesBuild(lTemplate('EntityProfile'),pversion);
		export ConfigAttributes							:= tools.mod_FilenamesBuild(lTemplate('ConfigAttributes'),pversion);
		export ConfigRules									:= tools.mod_FilenamesBuild(lTemplate('ConfigRules'),pversion);
		
		export ClusterDetails_Demo					:= tools.mod_FilenamesBuild(lTemplate('ClusterDetails_Demo'),pversion);
		export ElementPivot_Demo						:= tools.mod_FilenamesBuild(lTemplate('ElementPivot_Demo'),pversion);
		export ScoreBreakdown_Demo					:= tools.mod_FilenamesBuild(lTemplate('ScoreBreakdown_Demo'),pversion);
		
		export ClusterDetails_Delta					:= tools.mod_FilenamesBuild(lTemplate('ClusterDetails_Delta'),pversion);
		export ElementPivot_Delta						:= tools.mod_FilenamesBuild(lTemplate('ElementPivot_Delta'),pversion);
		export ScoreBreakdown_Delta					:= tools.mod_FilenamesBuild(lTemplate('ScoreBreakdown_Delta'),pversion);
		
		export dAll_filenames :=
		    ClusterDetails.dAll_filenames +
			 	ElementPivot.dAll_filenames +
				ScoreBreakdown.dAll_filenames +
				WeightingChart.dAll_filenames +
				EntityProfile.dAll_filenames +
				ConfigAttributes.dAll_filenames +
				ConfigRules.dAll_filenames +
				ClusterDetails_Demo.dAll_filenames +
			 	ElementPivot_Demo.dAll_filenames +
				ScoreBreakdown_Demo.dAll_filenames +
				ClusterDetails_Delta.dAll_filenames +
			 	ElementPivot_Delta.dAll_filenames +
				ScoreBreakdown_Delta.dAll_filenames ;
	end;
	
export dAll_filenames :=
		  Main.dAll_filenames ;


end;