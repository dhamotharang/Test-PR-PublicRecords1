export Mac_SK_Clear(basename, seq_name, numgenerations = '3', clearflag = 'false') := macro
/*
basename is 'base::xxxx'
numgenerations is currently to be just 2, 3 or 4
*/
#uniquename(ng)
%ng% := (integer)numgenerations;
if(%ng% not in [2,3,4], fail('ut.MAC_SF_Clear failure, numgenerations not in [2,3,4]'));

#uniquename(todelete)
%todelete% := map(%ng% = 4 => basename + '_Great_Grandfather',
                  %ng% = 3 => basename + '_Grandfather', 
                  basename + '_father');

seq_name := sequential(
			FileServices.StartSuperFileTransaction(),
			FileServices.AddSuperFile(basename + '_delete', %todelete%,, true),
			#if(%ng% in [3,4])
				   #if(%ng% = 4)
				  	FileServices.ClearSuperFile(basename + '_Great_Grandfather'),
					FileServices.AddSuperFile(basename + '_Great_Grandfather', basename + '_Grandfather',, true),
				   #end
					FileServices.ClearSuperFile(basename + '_Grandfather'),
					FileServices.AddSuperFile(basename + '_Grandfather', basename + '_father',, true),
			#end
			FileServices.ClearSuperFile(basename + '_father'),
			FileServices.AddSuperFile(basename + '_father', basename + '_built',, true),
			FileServices.ClearSuperFile(basename + '_built'),
               FileServices.ClearSuperFile(basename + '_prod'),  
               FileServices.ClearSuperFile(basename + '_qa'),
			FileServices.FinishSuperFileTransaction(),
               IF(clearflag,FileServices.ClearSuperFile(basename + '_delete',true),
                            output('Keys have been kept in ' + basename + '_delete.')));
endmacro;