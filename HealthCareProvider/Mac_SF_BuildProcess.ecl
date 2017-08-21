export Mac_SF_BuildProcess(thedataset, prefix, suffix, fileVersion, seq_name, numgenerations = '3', csvout = 'false', pCompress = 'false',pdelete = 'true') := macro
//import _Control;
/*
thedataset is the dataset to be written to disk
prefix - base name for example in the base superfile name '~thor_data400::base::dataset::qa::id'
					'~thor_data400::base::dataset' is the prefix.
suffix - 'id' is the suffix
seq_name - is the action
csvout - optional should you need a csv output
pcompress - optional should you need the file to be compressed.
pdelete - optional in test environment if you need to retain more than 3 generations
				- the file will be added to delete superfile but will not be removed from the 
				- disk if this option is set to false.
numgenerations is currently to be just 2 or 3
*/

// Filenames


//#uniquename(getenvironment)
//%getenvironment% := _Control.ThisEnvironment.Name;

#uniquename(basefilename)
#uniquename(fatherfilename)
#uniquename(gfatherfilename)
#uniquename(deletefilename)
#uniquename(logicalfilename)
%basefilename% := prefix + '::qa::' + suffix;
%fatherfilename% := prefix + '::father::' + suffix;
%gfatherfilename% := prefix + '::grandfather::' + suffix;
%deletefilename% := prefix + '::delete::' + suffix;
%logicalfilename% := prefix + '::' + suffix + '::' + fileVersion;


#uniquename(ng)
%ng% := (integer)numgenerations;

#uniquename(todelete)
%todelete% := if(%ng% = 3, %gfatherfilename%, %fatherfilename%);

#uniquename(createsuperfiles)
%createsuperfiles% := sequential(
					if( not fileservices.superfileexists(%basefilename%),
						fileservices.createsuperfile(%basefilename%)),
					if( not fileservices.superfileexists(%fatherfilename%),
						fileservices.createsuperfile(%fatherfilename%)),
					#if (%ng% = 3)
					if( not fileservices.superfileexists(%gfatherfilename%),
						fileservices.createsuperfile(%gfatherfilename%)),
					#end
					if( not fileservices.superfileexists(%deletefilename%),
						fileservices.createsuperfile(%deletefilename%))
					);

#uniquename(workalreadydone)
%workalreadydone%(string sub, string infile) :=		//only works on resubmit
	sub = infile[2..length(infile)];   //output file was added to basename


seq_name := 
	if(%ng% not in [2,3], fail('ut.MAC_SF_BuildProcess failure, numgenerations not in [2,3]'),
	 sequential(
	 %createsuperfiles%,
  	 if(%workalreadydone%(FileServices.GetSuperFileSubName(%basefilename%,1),%logicalfilename%),
		output(%basefilename% + ' work done in previous submission of this WU.'),
		sequential(
			#if(csvout != true)
				#if(pCompress != true)
					output(thedataset,,%logicalfilename%,overwrite),
				#else
					output(thedataset,,%logicalfilename%,overwrite,__compressed__),
				#end
			#else
				output(thedataset,,%logicalfilename%,overwrite,csv(quote('"'))),
			#end
				FileServices.StartSuperFileTransaction(),
					FileServices.AddSuperFile(%deletefilename%, %todelete%,, true),
					#if(%ng% = 3)
						FileServices.ClearSuperFile(%gfatherfilename%),
						FileServices.AddSuperFile(%gfatherfilename%, %fatherfilename%,, true),
					#end
					FileServices.ClearSuperFile(%fatherfilename%),
					FileServices.AddSuperFile(%fatherfilename%, %basefilename%,, true),
					FileServices.ClearSuperFile(%basefilename%),
					FileServices.AddSuperFile(%basefilename%, %logicalfilename%), 
				FileServices.FinishSuperFileTransaction(),
				#if(pdelete != true)
			//		#if(%getenvironment% = 'Dataland')
						output('Logical file in superfile not deleted from disk')
				//	#else
				//		FileServices.ClearSuperFile(%deletefilename%,true)
				//	#end
				#else
					FileServices.ClearSuperFile(%deletefilename%,true)
				#end
		))));
endmacro;