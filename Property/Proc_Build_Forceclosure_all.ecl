import _Control, Property;

#option('skipfileformatcrccheck',1);
export Proc_Build_Forceclosure_all(string filedate) := function

doSpray := Property.spray_Foreclosure_Raw(filedate
																					,filedate
																					,'thor400_44'
																					,'/data/thor_back5/fares/foreclosure/weekly_files/REOOut.txt');

doKeyBuild := Property.Foreclosure_Keys(filedate);

doOrbitStat := Property.scrubs_foreclosure_raw(filedate);

retval := sequential(doSpray
										,doKeyBuild
										,doOrbitStat
										); 

return retval;
end;