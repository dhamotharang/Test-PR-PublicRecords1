import lib_stringlib, lib_system;

export MAC_SK_BuildProcess_v2_NN(theindexprep, superkeyname, seq_name, one_node = 'false', diffing = 'false', version = '\'\'') := macro
/*
theindexprep is the index to be written to disk
SuperKeyname is 'key::xxxx' (superfile name)
seq_name is the sequential output name
numgenerations is currently to be just 2, 3 or 4
*/

#uniquename(Get_Versioned_Filename)
string	%Get_Versioned_Filename%(string pFilenameTemplate, string pVersionString)
 :=	RegExReplace('@version@', StringLib.stringtolowercase(pFilenameTemplate), pVersionString);

#uniquename(Actual_Version)
string	%Actual_Version%	:=	if(version<>'',version,thorlib.wuid());

#uniquename(todelete)
%todelete% := %Get_Versioned_Filename%(superkeyname,'built');

#uniquename(difftodelete)
%difftodelete% := %Get_Versioned_Filename%(superkeyname + '_diff','built');

#uniquename(workalreadydone)
boolean	%workalreadydone%(string pFilename)	:=	StringLib.stringfind(pFilename,%Actual_Version%,1) <> 0;

#uniquename(superdiffname)
%superdiffname% := superkeyname+'_diff';

seq_name := 
   if(stringlib.stringfind(stringlib.stringtolowercase(superkeyname),'@version@',1) = 0,fail('ut.MAC_SK_BuildProcess_V2_NN failure: Filename requires a "@version@" token to replace'),
	  if((FileServices.SuperFileExists(%todelete%)) and %workalreadydone%(FileServices.GetSuperFileSubName(%todelete%,1)),
		output(%Get_Versioned_Filename%(superkeyname,%Actual_Version%) + ' work done in previous run.'),
		sequential(
			#if (one_node)
				buildindex(theindexprep,%Get_Versioned_Filename%(superkeyname,%Actual_Version%),overwrite,few),
			#else 
				#if(~diffing)
					buildindex(theindexprep,%Get_Versioned_Filename%(superkeyname,%Actual_Version%),overwrite),
				#else
					buildindex(theindexprep,%Get_Versioned_Filename%(superkeyname,%Actual_Version%),DISTRIBUTE(index(theindexprep,%Get_Versioned_Filename%(superkeyname,'prod')),overwrite)),
					keydiff(index(theindexprep,%Get_Versioned_Filename%(superkeyname,'prod')),index(theindexprep,%Get_Versioned_Filename%(superkeyname,%Actual_Version%)),%Get_Versioned_Filename%(%superdiffname%,%Actual_Version%)),
				#end
			#end
			FileServices.StartSuperFileTransaction(),
				if(FileServices.SuperFileExists(%todelete%),
					FileServices.AddSuperFile(%Get_Versioned_Filename%(superkeyname,'delete'), %todelete%,, true),
					FileServices.CreateSuperFile(%todelete%)
				  ),
				#if(diffing)
				  if(FileServices.SuperFileExists(%difftodelete%),
					FileServices.AddSuperFile(%Get_Versioned_Filename%(%superdiffname%,'delete'), %difftodelete%,, true),
					FileServices.CreateSuperFile(%difftodelete%)
				  ),
				#end
				FileServices.ClearSuperfile(%todelete%),
				FileServices.AddSuperFile(%Get_Versioned_Filename%(superkeyname,'built'), %Get_Versioned_Filename%(superkeyname,%Actual_Version%)), 
				#if(diffing)
					FileServices.ClearSuperfile(%difftodelete%),
					FileServices.AddSuperFile(%Get_Versioned_Filename%(%superdiffname%,'built'), %Get_Versioned_Filename%(%superdiffname%,%Actual_Version%)),
				#end
			FileServices.FinishSuperFileTransaction(),
			if(FileServices.SuperFileExists(%Get_Versioned_Filename%(superkeyname,'delete')),
				FileServices.ClearSuperFile(%Get_Versioned_Filename%(superkeyname,'delete'),true),
				FileServices.CreateSuperFile(%Get_Versioned_Filename%(superkeyname,'delete'))
			  )
			#if(diffing)
				,if(FileServices.SuperFileExists(%Get_Versioned_Filename%(%superdiffname%,'delete')),
					FileServices.ClearSuperFile(%Get_Versioned_Filename%(%superdiffname%,'delete'),true),
					FileServices.CreateSuperFile(%Get_Versioned_Filename%(%superdiffname%,'delete'))
				   )	
			#end
	)	));
endmacro;
