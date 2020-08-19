allrecs := FLAccidents_Ecrash.File_KeybuildV2.prout(vin <> '' AND vin <> '0' );
dVinBase := DISTRIBUTE(allrecs, HASH32(vin, orig_accnbr));
sVinBase := SORT(dVinBase, vin, orig_accnbr, LOCAL);
uVinBase := DEDUP(sVinBase, vin, orig_accnbr, LOCAL);  

Layout_Keys_PR.VIN xformVIN(uVinBase l) :=  TRANSFORM
 SELF.l_vin := l.vin;
 SELF := l;
END;
VINBase := PROJECT(uVinBase, xformVIN(LEFT));

EXPORT key_ecrashV2_vin := INDEX(VINBase
                                ,{l_vin}
							                  ,{VINBase}
							                  ,Files_PR.FILE_KEY_VIN_SF);
