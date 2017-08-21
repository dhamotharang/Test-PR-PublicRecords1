import tools;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lkeyTemplate					:= _Constants(pUseOtherEnvironment).keyTemplate								;
	shared lautokeytemplate 		:= _Constants(pUseOtherEnvironment).autokeytemplate						;
	
	export Bdid							:= tools.mod_FilenamesBuild(lkeyTemplate				+ 'bdid'							,pversion);
	export OTS							:= tools.mod_FilenamesBuild(lkeyTemplate				+ 'OTS'								,pversion);
	export Cert							:= tools.mod_FilenamesBuild(lkeyTemplate				+ 'Cert'							,pversion);
	export LinkIDS					:= tools.mod_FilenamesBuild(lkeyTemplate				+ 'LinkIDS'						,pversion);
	export autokeyroot			:= tools.mod_FilenamesBuild(lautokeytemplate													,pversion);
	export addressb2				:= tools.mod_FilenamesBuild(lautokeytemplate		+ 'addressb2'					,pversion);
	export citystnameb2			:= tools.mod_FilenamesBuild(lautokeytemplate		+ 'citystnameb2'			,pversion);
	export nameb2						:= tools.mod_FilenamesBuild(lautokeytemplate		+ 'nameb2'						,pversion);
	export namewords2				:= tools.mod_FilenamesBuild(lautokeytemplate		+ 'namewords2'				,pversion);
	export payload					:= tools.mod_FilenamesBuild(lautokeytemplate		+ 'payload'						,pversion);
	export stnameb2					:= tools.mod_FilenamesBuild(lautokeytemplate		+ 'stnameb2'					,pversion);
	export zipb2	 					:= tools.mod_FilenamesBuild(lautokeytemplate		+ 'zipb2' 						,pversion);
                                                                                      			
	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ OTS.dAll_filenames
		+ Cert.dAll_filenames
		+ LinkIDS.dall_filenames
		+ addressb2.dAll_filenames
		+ citystnameb2.dAll_filenames
		+ nameb2.dAll_filenames
		+ namewords2.dAll_filenames
		+ payload.dAll_filenames
		+ stnameb2.dAll_filenames
		+ zipb2.dAll_filenames

		;

end;
	