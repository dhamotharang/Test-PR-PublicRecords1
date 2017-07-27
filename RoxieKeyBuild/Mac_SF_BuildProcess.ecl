export MAC_SF_BuildProcess(thedataset, basename, keyname, seq_name, numgenerations = '3', csvout = 'false', pCompress = 'false') := macro
/*
thedataset is the dataset to be written to disk
basename is 'base::xxxx'
numgenerations is currently to be just 2 or 3
*/
#uniquename(ng)
%ng% := (integer)numgenerations;

#uniquename(todelete)
%todelete% := if(%ng% = 3, basename + '_Grandfather', basename + '_father');

#uniquename(workalreadydone)
%workalreadydone%(string sub) :=															//only works on resubmit
	sub[(length(sub) - 14)..length(sub)] = thorlib.wuid()[2..16];   //output file was added to basename

seq_name := 
	if(%ng% not in [2,3], fail('ut.MAC_SF_BuildProcess failure, numgenerations not in [2,3]'),
  	 if(%workalreadydone%(FileServices.GetSuperFileSubName(basename,1)),
		output(basename + ' work done in previous submission of this WU.'),
		sequential(
			#if(csvout != true)
				#if(pCompress != true)
					output(thedataset,,keyname,overwrite),
				#else
					output(thedataset,,keyname,overwrite,__compressed__),
				#end
			#else
				output(thedataset,,keyname,overwrite,csv(quote('"'))),
			#end
				FileServices.StartSuperFileTransaction(),
					FileServices.AddSuperFile(basename + '_Delete', %todelete%,, true),
					#if(%ng% = 3)
						FileServices.ClearSuperFile(basename + '_Grandfather'),
						FileServices.AddSuperFile(basename + '_Grandfather', basename + '_father',, true),
					#end
					FileServices.ClearSuperFile(basename + '_father'),
					FileServices.AddSuperFile(basename + '_father', basename,, true),
					FileServices.ClearSuperFile(basename),
					FileServices.AddSuperFile(basename, keyname), 
				FileServices.FinishSuperFileTransaction(),
					Fileservices.RemoveOwnedSubFiles(basename + '_Delete',true)
		)));
endmacro;