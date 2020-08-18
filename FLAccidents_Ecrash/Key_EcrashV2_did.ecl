allrecs := FLAccidents_Ecrash.File_KeybuildV2.prout;
dDIDBase := DISTRIBUTE(allrecs(did <> '', did <> '000000000000'), HASH32(did, orig_accnbr));
sDIDBase := SORT(dDIDBase, did, orig_accnbr, vin, LOCAL);
uDIDBase := DEDUP(sDIDBase, did, orig_accnbr, vin, LOCAL);  

Layout_Keys_PR.DID xformDID(uDIDBase l) :=  TRANSFORM
 SELF.l_did := (INTEGER)l.did;
 SELF := l;
END;
DIDBase := PROJECT(uDIDBase, xformDID(LEFT));

EXPORT key_EcrashV2_did := INDEX(DIDBase
                                ,{l_did}
								                ,{DIDBase}
							                  ,Files_PR.FILE_KEY_DID_SF);
