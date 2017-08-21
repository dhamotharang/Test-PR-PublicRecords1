//Produces names of the files defined in the Files attribute
import tools;

export Filenames(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	export ftemplate(string pFiletype, string pSubtype = '')	:= 
		_Dataset(pUseOtherEnvironment).thor_cluster_files + pFiletype + '::' + _Dataset().name + '::@version@' + if(pSubtype != '', '::' + pSubtype,'::data');

	export input :=
	module
		
		export Live		        := tools.mod_FilenamesInput(ftemplate('in'	,'Live'		        ) ,pFileDate := pversion);
		export Dead		        := tools.mod_FilenamesInput(ftemplate('in'	,'Dead'		        ) ,pFileDate := pversion);
		export DeletedRemove	:= tools.mod_FilenamesInput(ftemplate('in'	,'deleted-remove'	) ,pFileDate := pversion);
		                                                                   
		export dAll_filenames := 
				Live.dAll_filenames
			+ Dead.dAll_filenames 
			+	DeletedRemove.dAll_filenames
			;

	end;


	export Base := tools.mod_FilenamesBuild(ftemplate('base'),pversion);
	
	export dAll_filenames := 
		base.dAll_filenames;

end;