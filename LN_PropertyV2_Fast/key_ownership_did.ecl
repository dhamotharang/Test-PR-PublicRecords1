// NOTE: At runtime, please access this key exclusively from
// LN_PropertyV2_Services.Ownership -- we're trying to encapsulate
// ownership logic, so if there's logic you need that hasn't been
// defined yet that's the place to put it.

// indexed by did+onlyFares+current
// rolled by did+fips_code+unformatted_apn
// multiple rows may exist for a given fid when owned by >1 did



Import Data_Services, LN_PropertyV2_Fast, doxie;

export key_ownership_did(boolean IsFCRA = false,boolean isFast) := function

d := distribute(LN_PropertyV2_Fast.file_ownership_did(isFast)(did<>0), hash32(did));

keyPrefix := LN_PropertyV2_Fast.FileNames.fullKeyBuildPrefix;

KeyName 			:= 'thor_data400::key::'+keyPrefix+'::';
KeyName_fcra  := 'thor_data400::key::'+keyPrefix+'::fcra::';

f := Constants.keyServerPointer+ if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::ownership.did';

return_file := index(d, {did, current}, {d}, f);

return(return_file);

end;

