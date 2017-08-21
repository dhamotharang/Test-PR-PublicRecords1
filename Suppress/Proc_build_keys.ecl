import ut,RoxieKeyBuild;
export Proc_build_keys(string filedate) :=
function

a := ut.SF_MaintBuilding('~thor_data400::in::blackphonelist');

//ut.MAC_SK_BuildProcess(key_pullPhone,'~thor_data400::key::blackphonelist',
							  //'~thor_data400::key::blackphonelist',b,3,true)
RoxieKeyBuild.MAC_SK_BuildProcess_Local(key_pullPhone,'~thor_data400::key::blackphonelist::'+filedate+'::blackphonelist',
							  '~thor_data400::key::blackphonelist',b,3,true);
RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::blackphonelist::'+filedate+'::blackphonelist',
							  '~thor_data400::key::blackphonelist',b1,3,true);
							  
c := ut.SF_MaintBuilt('~thor_data400::in::blackphonelist');

return if (fileservices.getsuperfilesubname('~thor_data400::in::blackphonelist',1) = 
    fileservices.getsuperfilesubname('~thor_data400::in::blackphonelist_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(a,b,b1,c));

end;