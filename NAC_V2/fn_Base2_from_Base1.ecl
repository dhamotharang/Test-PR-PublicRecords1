#stored('did_add_force', 'thor');
import Nac, dops, ut;
export fn_Base2_from_Base1(string version) := FUNCTION
b1 := nac.Files().Base;

b2 := nac_v2.fn_Base1ToBase2(b1) : INDEPENDENT;
lfn_base := Nac_V2.Superfile_List().sfBase2 + '::' + workunit;

collisions := NAC_V2.Mod_Collisions2(b2).AllCollisions;
lfn_collisions := Nac_V2.Superfile_List().sfCollisions + '::' + workunit;

c1 := DATASET('~nac::out::collisions2::father', nac_v2.Layout_Collisions2.Layout_Collisions, thor);
c2 := DATASET(lfn_collisions, nac_v2.Layout_Collisions2.Layout_Collisions, thor);
alertList := NAC_v2.Mailing_List('').Dev2;

version1 := NAC_V2.fn_Base1_Version;

doit := SEQUENTIAL(
	OUTPUT(IF(version=version1, 'Versions Match', 'Outdated Base1: ' + version1)),
	OUTPUT(b2,,lfn_base, COMPRESSED),
	nac_V2.Promote_Superfiles(Nac_V2.Superfile_List().sfBase2, lfn_base),
	nac_v2.Build_keys(version),
	OUTPUT(collisions,,lfn_collisions,COMPRESSED,OVERWRITE),
	nac_V2.Promote_Superfiles(Nac_V2.Superfile_List().sfCollisions, lfn_collisions),
	OUTPUT(Nac_V2.NewCollisions(c2, c1),,'~nac::v2::newcollisions::' + version, COMPRESSED, OVERWRITE),
	OUTPUT(NAC_V2.GetSampleRecords(version), named('v2_samples')),
	//RoxieKeybuild.updateversion('Nac2Keys',version,alertList,,'N'),
	if (ut.Weekday((integer)version[1..8]) = 'SATURDAY'
										,dops.updateversion( 'Nac2Keys', version[1..8], alertList,'Y','N',l_isprodready:='Y')
										,dops.updateversion( 'Nac2Keys', version[1..8], alertList,'N','N')
			),
	if (ut.Weekday((integer)version[1..8]) <> 'SATURDAY',
							Nac_v2.CreateOrbitEntry(version)),
	Nac.fn_Strata(version)
);

return doit;
END;