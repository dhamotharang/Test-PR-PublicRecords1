
import roxiekeybuild,seed_files;

export proc_build_ConsumerProfileKeys(string filedate) := 
function

#workunit('name','Risk View Key Build')

roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.ConsumerProfile_keys.Report,'~thor_data400::key::consumerprofile::report','~thor_data400::key::consumerprofile::'+filedate+'::report',a,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.ConsumerProfile_keys.AddressHistory,'~thor_data400::key::consumerprofile::addresshistory','~thor_data400::key::consumerprofile::'+filedate+'::addresshistory',b,2);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.ConsumerProfile_keys.AKAs,'~thor_data400::key::consumerprofile::akas','~thor_data400::key::consumerprofile::'+filedate+'::akas',c,2);


roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::consumerprofile::report','~thor_data400::key::consumerprofile::'+filedate+'::report',a1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::consumerprofile::addresshistory','~thor_data400::key::consumerprofile::'+filedate+'::addresshistory',b1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::consumerprofile::akas','~thor_data400::key::consumerprofile::'+filedate+'::akas',c1);


roxiekeybuild.Mac_SK_Move('~thor_data400::key::consumerprofile::report','Q',a2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::consumerprofile::addresshistory','Q',b2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::consumerprofile::akas','Q',c2);




buildkey := parallel(a,b,c);
movekey := sequential(a1,b1,c1);
movetoqa := sequential(a2,b2,c2);
dops_update := Roxiekeybuild.updateversion('ProfileSeedKeys',filedate,'skasavajjala@seisint.com',,'F');

return sequential(buildkey, movekey, movetoqa,dops_update);

end;