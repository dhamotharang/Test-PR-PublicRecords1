import ut,roxiekeybuild;
filedate:=workunit;

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_AID_Base,'~thor_data400::key::aid::RawAID_to_ACECahe','~thor_data400::key::aid::'+filedate[2..9]+'::RawAID_to_ACECahe',rawaid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::aid::RawAID_to_ACECahe','~thor_data400::key::aid::'+filedate[2..9]+'::RawAID_to_ACECahe',mv_rawaid);

built := sequential( rawaid
					,mv_rawaid);

export Proc_Build_Base_AID := built;