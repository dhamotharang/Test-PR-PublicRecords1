allrecs := FLAccidents_Ecrash.File_KeybuildV2.prout;
dDIDBase := DISTRIBUTE(allrecs(DID <> '', DID <> '000000000000'), HASH32(DID, Orig_Accnbr));
sDIDBase := SORT(dDIDBase, DID, Orig_Accnbr, Vin, LOCAL);
uDIDBase := DEDUP(sDIDBase, DID, Orig_Accnbr, Vin, LOCAL);  

Layout_Keys_PR.DID xformDID(uDIDBase l) :=  TRANSFORM
 SELF.l_DID := (INTEGER)l.DID;
 SELF.Accident_Nbr := l.Accident_Nbr;
 SELF.Vin := l.Vin;
 SELF.Orig_Accnbr := l.Orig_Accnbr;
 SELF.report_code := l.report_code;
 SELF.jurisdiction := l.jurisdiction;
 SELF.jurisdiction_state := l.jurisdiction_state;
 SELF.jurisdiction_nbr := l.jurisdiction_nbr;
 SELF.vehicle_incident_st := l.vehicle_incident_st;
 SELF := l;
 SELF := []; 
END;
DIDBase := PROJECT(uDIDBase, xformDID(LEFT));

EXPORT key_EcrashV2_did := INDEX(DIDBase,
                                {l_DID},
								                {DIDBase},
							                  Files_PR.FILE_KEY_DID_SF);
