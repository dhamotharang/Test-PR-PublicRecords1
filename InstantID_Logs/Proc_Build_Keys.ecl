import RoxieKeyBuild, ut;

export Proc_Build_Keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(instantid_logs.Key_InstantID_Logs_Payload,'','~thor_data400::key::instantid_logs::'+filedate+'::adl',buildpay);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::instantid_logs','~thor_data400::key::instantid_logs::'+filedate+'::adl',builtpay);

ut.MAC_SK_Move_v2('~thor_data400::key::instantid_logs', 'Q', movepay);

return sequential(buildpay, builtpay, movepay);
end;