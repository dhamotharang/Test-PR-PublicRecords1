export MAC_SF_BuildProcess_V2(thedataset, prefix, suffix, filedate, seq_name, numgenerations = '3', csvout = 'false', pCompress = 'false', isoutput = 'true') := macro
/*
thedataset is the dataset to be written to disk
basename is 'base::xxxx'
numgenerations is currently to be just 2 or 3
*/

// Filenames

#uniquename(basefilename)
#uniquename(fatherfilename)
#uniquename(gfatherfilename)
#uniquename(deletefilename)
#uniquename(logicalfilename)
%basefilename% := prefix + '::qa::' + suffix;
%fatherfilename% := prefix + '::father::' + suffix;
%gfatherfilename% := prefix + '::grandfather::' + suffix;
%deletefilename% := prefix + '::delete::' + suffix;
%logicalfilename% := prefix + '::' + filedate + '::' + suffix;


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
			#if (isoutput = true)
				#if(csvout != true)
					#if(pCompress != true)
						output(thedataset,,%logicalfilename%,overwrite),
					#else
						output(thedataset,,%logicalfilename%,overwrite,__compressed__),
					#end
				#else
					output(thedataset,,%logicalfilename%,overwrite,csv(quote('"'))),
				#end
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
				FileServices.RemoveOwnedSubFiles(%deletefilename%,true)
		))));
endmacro;