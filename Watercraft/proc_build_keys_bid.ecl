import watercraft,roxiekeybuild,doxie;

export proc_build_keys_bid(string file_date) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_bid   ,'~thor_data400::key::watercraft_bid'   ,'~thor_data400::key::watercraft::'+file_date+'::bid'   ,bid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_sid_bid()    ,'~thor_data400::key::watercraft_sid_bid'    ,'~thor_data400::key::watercraft::'+file_date+'::sid_bid'    ,sid_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_bid'   ,'~thor_data400::key::watercraft::'+file_date+'::bid'   ,mv_bid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft_sid_bid'    ,'~thor_data400::key::watercraft::'+file_date+'::sid_bid'    ,mv_sid_key);

// FCRA 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(watercraft.key_watercraft_sid_bid(true)   ,'~thor_data400::key::watercraft::fcra::sid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::sid_bid'    ,fcra_sid_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::watercraft::fcra::sid'    ,'~thor_data400::key::watercraft::fcra::'+file_date+'::sid'    ,mv_fcra_sid_key);

bk := sequential(parallel(bid_key,sid_key,fcra_sid_key),
					parallel(mv_bid_key,mv_sid_key,mv_fcra_sid_key));
					
return bk;

end;

