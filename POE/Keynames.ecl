import tools;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lkeyTemplate			:= _Constants(pUseOtherEnvironment).keyTemplate			;
	shared lautokeytemplate := _Constants(pUseOtherEnvironment).autokeytemplate	;

	export Bdid							:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'bdid'							,pversion);
	export Did							:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'did'								,pversion);
	export Source_Hierarchy	:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'Source_Hierarchy'	,pversion);
	export autokeyroot			:= tools.mod_FilenamesBuild(lautokeytemplate												,pversion);
	export address					:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'address'						,pversion);
	export addressb2				:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'addressb2'					,pversion);
	export citystname				:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'citystname'				,pversion);
	export citystnameb2			:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'citystnameb2'			,pversion);
	export fein2						:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'fein2'							,pversion);
	export name							:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'name'							,pversion);
	export nameb2						:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'nameb2'						,pversion);
	export namewords2				:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'namewords2'				,pversion);
	export payload					:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'payload'						,pversion);
	export phone2						:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'phone2'						,pversion);
	export phoneb2					:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'phoneb2'						,pversion);
	export ssn2							:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'ssn2'							,pversion);
	export stname						:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'stname'						,pversion);
	export stnameb2					:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'stnameb2'					,pversion);
	export zip							:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'zip'								,pversion);
	export zipb2	 					:= tools.mod_FilenamesBuild(lautokeytemplate	+ 'zipb2' 						,pversion);
                                                                                        			
	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ Did.dAll_filenames
		+ Source_Hierarchy.dAll_filenames
		+ address.dAll_filenames
		+ addressb2.dAll_filenames
		+ citystname.dAll_filenames
		+ citystnameb2.dAll_filenames
		+ fein2.dAll_filenames
		+ name.dAll_filenames
		+ nameb2.dAll_filenames
		+ namewords2.dAll_filenames
		+ payload.dAll_filenames
		+ phone2.dAll_filenames
		+ phoneb2.dAll_filenames
		+ ssn2.dAll_filenames
		+ stname.dAll_filenames
		+ stnameb2.dAll_filenames
		+ zip.dAll_filenames
		+ zipb2.dAll_filenames
		;

end;