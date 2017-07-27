export Mac_SF_Clear(basename, seq_name, numgenerations = '3') := macro
/*
basename is 'base::xxxx'
numgenerations is currently to be just 2 or 3
*/
#uniquename(ng)
%ng% := (integer)numgenerations;
if(%ng% not in [2,3], fail('ut.MAC_SF_Clear failure, numgenerations not in [2,3]'));

#uniquename(todelete)
%todelete% := if(%ng% = 3, basename + '_grandfather', basename + '_father');

seq_name := sequential(
			FileServices.StartSuperFileTransaction(),
			FileServices.AddSuperFile(basename + '_delete', %todelete%,, true),
			#if(%ng% = 3)
				FileServices.ClearSuperFile(basename + '_grandfather'),
				FileServices.AddSuperFile(basename + '_grandfather', basename + '_father',, true),
			#end
			FileServices.ClearSuperFile(basename + '_father'),
			FileServices.AddSuperFile(basename + '_father', basename,, true),
			FileServices.ClearSuperFile(basename),
			FileServices.FinishSuperFileTransaction(),
			FileServices.RemoveOwnedSubFiles(basename + '_delete',true));
endmacro;