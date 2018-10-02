import _Control, Property, Orbit3;

#option('skipfileformatcrccheck',1);
export Proc_Build_Forceclosure_all(string filedate) := function

doSpray := Property.spray_Foreclosure_Raw(filedate
																					,filedate
																					,'thor400_44'
																					,'/data/thor_back5/fares/foreclosure/weekly_files/REOOut.txt');

doKeyBuild := Property.Foreclosure_Keys(filedate);

doOrbitStat := Property.scrubs_foreclosure_raw(filedate);
orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('Foreclosures',(filedate),'N'); 


retval := sequential(doSpray
										,doOrbitStat
										,doKeyBuild
										,orbit_update
										); 

return retval;
end;