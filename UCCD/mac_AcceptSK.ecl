export mac_AcceptSK(movetype, movename) := macro

#uniquename(champs)
%champs% := 'bucs';

#uniquename(d)
#uniquename(e)
#uniquename(f)
ut.MAC_SK_Move('~thor_data400::key::ucc_did',movetype,%d%)
ut.MAC_SK_Move_v2('~thor_data400::key::ucc_bdid',movetype,%e%,2);
ut.MAC_SK_Move_v2('~thor_data400::key::ucc_key',movetype,%f%,2);
 
movename := sequential(%d%,%e%,%f%);

endmacro;