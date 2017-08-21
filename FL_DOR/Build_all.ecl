import ut;

export Build_all(string8 pVersion='default',boolean isFirstBuild=false) := function

filename:='~thor_data400::DOR::fl_addr_'+pVersion+'.csv';

new:=if(isFirstBuild,fl_dor.Mod_proc.built,fl_dor.Mod_proc.new);

s1:=output(new,, filename,CSV(heading(0),separator(['|']),terminator(['\r']),Quote(['\"'])), compressed);

statsOut := fl_dor.Mod_proc.stats;

all_ := sequential(
					s1
					,statsOut
					,FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile('~thor_data400::dor::fl_addr_history','~thor_data400::dor::fl_addr',,true)
					,FileServices.ClearSuperFile('~thor_data400::dor::fl_addr')
					,FileServices.AddSuperFile('~thor_data400::dor::fl_addr',filename)
					,FileServices.FinishSuperFileTransaction()
					);

return all_;

end;