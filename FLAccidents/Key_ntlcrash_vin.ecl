import doxie;

ntlcrash_vin_base := FLAccidents.ntlc_ss_Keybuild(vin<>'' and vin<>'0' );

dst_vin_base := distribute(ntlcrash_vin_base, hash(vin, accident_nbr));
srt_vin_base := sort(dst_vin_base, vin, accident_nbr, local);
dep_vin_base := dedup(srt_vin_base, vin, accident_nbr, local);

export key_ntlcrash_vin := index(dep_vin_base
                               ,{l_vin := vin}
							   ,{accident_nbr}
							   ,'~thor_data400::key::ntlcrash_vin_' + doxie.Version_SuperKey);
