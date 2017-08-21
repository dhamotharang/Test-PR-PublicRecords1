import Lib_StringLib, Lib_FileServices;

export MAC_SF_BuildProcess_NN(thedataset, basename, seq_name, numgenerations = '3', csvout = 'false', pCompress = 'false', version = '\'\'') := macro
/*
thedataset is the dataset to be written to disk
basename is 'base::xxxx'
numgenerations is currently to be just 2 or 3
*/
#uniquename(Get_Versioned_Filename)
string	%Get_Versioned_Filename%(string pFilenameTemplate, string pVersionString)
 :=	RegExReplace('@version@', stringlib.stringtolowercase(pFilenameTemplate), pVersionString);

#uniquename(Actual_Version)
string	%Actual_Version%	:=	if(version<>'',version,thorlib.wuid());

#uniquename(ng)
%ng% := (integer)numgenerations;

#uniquename(todelete)
%todelete% := if(%ng% = 3, %Get_Versioned_Filename%(basename,'grandfather'), %Get_Versioned_Filename%(basename,'father'));

#uniquename(workalreadydone)
boolean	%workalreadydone%(string pFilename)	:=	StringLib.stringfind(pFilename,%Actual_Version%,1) <> 0;

seq_name := 
   if(stringlib.stringfind(stringlib.stringtolowercase(basename),'@version@',1) = 0,fail('ut.MAC_SF_BuildProcess_NN failure: Filename requires a "@version@" token to replace'),
	if(%ng% not in [2,3], fail('ut.MAC_SF_BuildProcess_NN failure, numgenerations not in [2,3]'),
  	 if(%workalreadydone%(FileServices.GetSuperFileSubName(%Get_Versioned_Filename%(basename,'built'),1)),
		output(basename + ' work done in previous submission of this WU.'),
		sequential(
			#if(csvout != true)
				#if(pCompress != true)
					output(thedataset,,%Get_Versioned_Filename%(basename,%Actual_Version%),overwrite),
				#else
					output(thedataset,,%Get_Versioned_Filename%(basename,%Actual_Version%),overwrite,__compressed__),
				#end
			#else
				output(thedataset,,%Get_Versioned_Filename%(basename,%Actual_Version%),overwrite,csv(quote('"'))),
			#end
				FileServices.StartSuperFileTransaction(),
					FileServices.AddSuperFile(%Get_Versioned_Filename%(basename,'delete'), %todelete%,, true),
					#if(%ng% = 3)
						FileServices.ClearSuperFile(%Get_Versioned_Filename%(basename,'grandfather')),
						FileServices.AddSuperFile(%Get_Versioned_Filename%(basename,'grandfather'), %Get_Versioned_Filename%(basename,'father'),, true),
					#end
					FileServices.ClearSuperFile(%Get_Versioned_Filename%(basename,'father')),
					FileServices.AddSuperFile(%Get_Versioned_Filename%(basename,'grandfather'), %Get_Versioned_Filename%(basename,'prod'),, true),
					FileServices.ClearSuperFile(%Get_Versioned_Filename%(basename,'prod')),
					FileServices.AddSuperFile(%Get_Versioned_Filename%(basename,'built'), %Get_Versioned_Filename%(basename,%Actual_Version%)), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(%Get_Versioned_Filename%(basename,'delete'),true)
	)	)));
endmacro;