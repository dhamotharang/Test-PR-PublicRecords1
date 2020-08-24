allrecs := FLAccidents_Ecrash.File_KeybuildV2.prout(Vin <> '' AND Vin <> '0' );
dVinBase := DISTRIBUTE(allrecs, HASH32(Vin, Orig_Accnbr));
sVinBase := SORT(dVinBase, Vin, Orig_Accnbr, LOCAL);
uVinBase := DEDUP(sVinBase, Vin, Orig_Accnbr, LOCAL);  

Layout_Keys_PR.VIN xformVin(uVinBase l) :=  TRANSFORM
 SELF.l_Vin := l.Vin;
 SELF.Accident_Nbr := l.Accident_Nbr;
 SELF.Orig_Accnbr := l.Orig_Accnbr;
 SELF.report_code := l.report_code;
 SELF.jurisdiction := l.jurisdiction;
 SELF.jurisdiction_state := l.jurisdiction_state;
 SELF.jurisdiction_nbr := l.jurisdiction_nbr;
 SELF.vehicle_incident_st := l.vehicle_incident_st;
 SELF := l;
 SELF := [];
END;
VinBase := PROJECT(uVinBase, xformVin(LEFT));

EXPORT Key_EcrashV2_Vin := INDEX(VinBase,
                                {l_Vin},
							                  {VINBase},
							                  Files_PR.FILE_KEY_VIN_SF);
