export MAC_SF_BuildProcess(thedataset, basename, version ,seq_name, numgenerations = '3', csvout = 'false', pCompress = 'false',dosuper = 'false') := macro
/*
thedataset is the dataset to be written to disk
basename is 'base::xxxx'
numgenerations is currently to be just 2 or 3
*/
#uniquename(ng)
%ng% := (integer)numgenerations;

#uniquename(todelete)
%todelete% := if(%ng% = 3, basename + '_Grandfather', basename + '_father');

#uniquename(sub)
%sub% := FileServices.GetSuperFileSubName(basename,1);															//only works on resubmit
	   //output file was added to basename

seq_name := 
	if(%ng% not in [2,3], fail('ut.MAC_SF_BuildProcess failure, numgenerations not in [2,3]'),
		
		sequential(
           		if(%sub%[(length(%sub%)+1 - length(version))..length(%sub%)] = version
					,sequential(
						output(basename + ' base file was rebuilt with same version. rolling back logical files.')
								,FileServices.StartSuperFileTransaction()
								#if(%ng% = 3)
								,FileServices.SwapSuperFile(basename, basename + '_father')
								,FileServices.SwapSuperFile(basename + '_father',basename + '_Grandfather')
								,FileServices.ClearSuperFile(basename + '_Grandfather')
								#else
								,FileServices.SwapSuperFile(basename, basename + '_father')
								,FileServices.ClearSuperFile(basename + '_father')
								#end
								,FileServices.FinishSuperFileTransaction())
						,output(basename + ' base file built with different version.')),
			#if(csvout != true)
				#if(pCompress != true)
					#if(dosuper != true)
						output(thedataset,,basename + '_'+version,overwrite),
					#end
				#else
					#if(dosuper != true)
						output(thedataset,,basename + '_'+version,overwrite,__compressed__),
					#end
				#end
			#else
				#if(dosuper != true)
					output(thedataset,,basename+ '_'+version,overwrite,csv(quote('"'))),
				#end
			#end
				#if(dosuper != false)
				FileServices.StartSuperFileTransaction(),
					FileServices.AddSuperFile(basename + '_Delete', %todelete%,, true),
					#if(%ng% = 3)
						FileServices.ClearSuperFile(basename + '_Grandfather'),
						FileServices.AddSuperFile(basename + '_Grandfather', basename + '_father',, true),
					#end
					FileServices.ClearSuperFile(basename + '_father'),
					FileServices.AddSuperFile(basename + '_father', basename,, true),
					FileServices.ClearSuperFile(basename),
					FileServices.AddSuperFile(basename, basename + '_'+version), 
				FileServices.FinishSuperFileTransaction()
				//FileServices.ClearSuperFile(basename + '_Delete',true)
				#else
					output(basename+ '_'+version + ' built')
				#end
		));
endmacro;