import dx_Cortera;
EXPORT proc_build_empty_keys(string filedate) := FUNCTION

attr_delta_rid_build :=    DATASET([ ],{unsigned8 record_sid, unsigned4 dt_effective_first, unsigned4 dt_effective_last});
attr_delta_rid_Key := INDEX(attr_delta_rid_build,{record_sid},{attr_delta_rid_build},'~prte::key::cortera::' + filedate + '::attr_delta_rid'); 

exec_delta_rid_build :=    DATASET([ ],{unsigned8 record_sid, unsigned4 dt_effective_first, unsigned4 dt_effective_last});
exec_delta_rid_Key := INDEX(exec_delta_rid_build,{record_sid},{exec_delta_rid_build},'~prte::key::cortera::' + filedate + '::executive_delta_rid'); 

hdr_delta_rid_build :=    DATASET([ ],{unsigned8 record_sid, unsigned4 dt_effective_first, unsigned4 dt_effective_last});
hdr_delta_rid_Key := INDEX(hdr_delta_rid_build,{record_sid},{hdr_delta_rid_build},'~prte::key::cortera::' + filedate + '::hdr_delta_rid'); 

filedate2:=filedate[1..8];
build_version_build          := dataset([{filedate2}], dx_Cortera.Layouts.Layout_Version);
build_version_key:=  INDEX(build_version_build,{last_build_version},{build_version_build},'~prte::key::cortera::' + filedate + '::build_version'); 

return sequential(BUILDIndex(attr_delta_rid_Key),BUILDIndex(exec_delta_rid_Key),BUILDIndex(hdr_delta_rid_Key),BUILDIndex(build_version_Key));
end;

