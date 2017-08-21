export MAC_SF_Rollback(basename, seq_name, numgenerations = '3', addbuilt = 'N') := macro
/*
basename is 'base::xxxx' or 'key::xxxx'
numgenerations is currently to be just 2 or 3
seqname is the name you call to run the macro
addbuilt is usually used for keys where the basename has '_built' added instead of just the basename
*/
#uniquename(ng)
%ng% := (integer)numgenerations;

#uniquename(realbasename)
%realbasename% := if(addbuilt = 'N', basename, basename + '_built');

seq_name := 
	if(%ng% not in [2,3], fail('ut.MAC_SF_Rollback failure, numgenerations not in [2,3]'),
  	 	sequential(
					FileServices.StartSuperFileTransaction(),
					FileServices.ClearSuperFile(%realbasename%),
					FileServices.AddSuperFile(%realbasename%, basename + '_father',, true),

					FileServices.ClearSuperFile(basename + '_father'),
					#if(%ng% = 3)
					FileServices.AddSuperFile(basename + '_father', basename + '_Grandfather',, true),
					FileServices.ClearSuperFile(basename + '_Grandfather'),
					FileServices.AddSuperFile(basename + '_Grandfather', basename + '_Delete',, true),
					#else
					FileServices.AddSuperFile(basename + '_father', basename + '_Delete',, true),
					#end
					FileServices.ClearSuperFile(basename + '_Delete'),
					FileServices.FinishSuperFileTransaction()
		));
endmacro;