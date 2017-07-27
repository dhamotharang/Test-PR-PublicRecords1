import LiensV2, did_add, watchdog, ut;

file_party := LiensV2.file_liens_party;

rec_temp := record

liensV2.Layout_liens_party_SSN;
integer8  temp_DID;

end;

rec_temp tappendSSN(liensV2.Layout_liens_party L) := transform

self := L;
self.temp_did := (unsigned6)L.did;

end;

file_party_SSN_temp := project(file_party,tappendSSN(left)); 

//Append SSN 

did_add.MAC_Add_SSN_By_DID(file_party_SSN_temp, temp_did, app_ssn, file_party_ssn, false)

liensV2.Layout_liens_party_ssn tremovetempDID(rec_temp L) := transform

self := L;

end;

export file_liens_party_SSN := project(file_party_ssn,tremovetempDID(left)): persist('~thor_data400::persist::Liens::party_SSN'); 


