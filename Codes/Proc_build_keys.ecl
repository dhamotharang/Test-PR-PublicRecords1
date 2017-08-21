import ut,RoxieKeyBuild;
export Proc_Build_Keys(string filedate) := 
function

a := ut.SF_MaintBuilding('~thor_data400::base::codes_v3');

RoxieKeybuild.MAC_SK_BuildProcess_Local(key_codes_v3,'~thor_data400::key::codes::'+filedate+'::codes_v3','~thor_data400::key::codes_v3',b,3,true);
RoxieKeybuild.MAC_SK_Move_to_built('~thor_data400::key::codes::'+filedate+'::codes_v3','~thor_data400::key::codes_v3',b1,3,true);

ut.MAC_SK_Move_v2('~thor_data400::key::codes_v3','Q',qm);

c := ut.SF_MaintBuilt('~thor_data400::base::codes_v3');
		
succ := if (fileservices.getsuperfilesubname('~thor_data400::base::codes_v3',1) = fileservices.getsuperfilesubname('~thor_data400::base::codes_v3_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(a,b,b1,qm,c));

return succ;

		
end;