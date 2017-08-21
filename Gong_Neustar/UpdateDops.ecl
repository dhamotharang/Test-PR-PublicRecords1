import RoxieKeybuild;

EXPORT UpdateDops(string version) := FUNCTION
non_FCRA_update := RoxieKeybuild.updateversion('GongKeys',version,SuccessEmail,,'N');
FCRA_update := RoxieKeybuild.updateversion('FCRA_GongKeys',version,SuccessEmail,,'F');
//BIP_dops_update := RoxieKeyBuild.updateversion('GongKeys',version,'christopher.brodeur@lexisnexis.com',,'BN');

return SEQUENTIAL(non_FCRA_update, FCRA_update
);
END;