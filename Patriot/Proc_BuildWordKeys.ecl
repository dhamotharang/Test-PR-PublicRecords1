import Text_Test, Text, ut,RoxieKeyBuild;

export Proc_BuildWordKeys(string filedate) := 
function

f := patriot.File_Patriot;
do1 := output(f,,'~thor_data400::maltemp::base::patriot_'+version_file, overwrite);
newf := DATASET('~thor_data400::maltemp::base::patriot_'+version_file, {Patriot.Layout_Patriot, 
											UNSIGNED INTEGER8 __filepos {virtual(fileposition)}}, flat);
RoxieKeyBuild.MAC_SK_BuildProcess_Local(key_prep_wordkey,'~thor_data400::maltemp::key::patriot::'+filedate+'::patriot','~thor_data400::maltemp::key::patriot',do2,2);
RoxieKeyBuild.MAC_SK_Move_to_built('~thor_data400::maltemp::key::patriot::'+filedate+'::patriot','~thor_data400::maltemp::key::patriot',do3,2);

return sequential(do1, do2, do3);

end;