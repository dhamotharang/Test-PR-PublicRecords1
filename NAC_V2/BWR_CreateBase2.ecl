
nacin := DATASET('~nac::uber::input::test::base::extended', nac_v2.Layouts2.rNac2, THOR);

ds1 := NAC_V2.ToBaseFile(nacin);
ds := NAC_V2.Build_base2(ds1);

payload := Nac_V2.To_Payload(ds);

OUTPUT(COUNT(ds1), named('n_base'));
OUTPUT(COUNT(ds), named('n_base2'));
//OUTPUT(COUNT(payload), named('n_payload'));
OUTPUT(ds1, named('base_in'));
OUTPUT(ds);


OUTPUT(ds1,,'~nac::uber::test::prebase',COMPRESSED,OVERWRITE);
OUTPUT(ds,,'~nac::uber::test::base2',COMPRESSED,OVERWRITE);
OUTPUT(payload,,'~nac::uber::test::payload',COMPRESSED,OVERWRITE);

