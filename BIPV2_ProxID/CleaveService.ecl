/*--SOAP--
<message name="CleaveService">
<part name="Proxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Cleave logic as applied to a particular Proxid.*/
EXPORT CleaveService := MACRO
  IMPORT SALT311,BIPV2_ProxID;
  STRING20 Proxidstr := ''  : STORED('Proxid', FORMAT(SEQUENCE(1)));
  SALT311.UIDType uid := (SALT311.UIDType)Proxidstr;
TheData := PROJECT(LIMIT(BIPV2_ProxID.Keys(BIPV2_ProxID.In_DOT_Base).InData(Proxid=uid),BIPV2_ProxID.Config.JoinLimit),BIPV2_ProxID.Layout_DOT_Base);
s := GLOBAL(PROJECT(BIPV2_ProxID.Keys(TheData).Specificities_Key,BIPV2_ProxID.Layout_Specificities.R)[1]);
CM := BIPV2_ProxID.Cleave(TheData, s, TRUE);
// Output the intermediates for the _active_domestic_corp_key basis
OUTPUT(CM.Tallied_active_domestic_corp_key,NAMED('Tallied_active_domestic_corp_key'));
OUTPUT(CM.FullTallied_active_domestic_corp_key,NAMED('FullTallied_active_domestic_corp_key'));
OUTPUT(CM.Possibles_active_domestic_corp_key_ni,NAMED('Possibles_active_domestic_corp_key'));
OUTPUT(CM.Candidates_active_domestic_corp_key_ni,NAMED('Candidates_active_domestic_corp_key'));
// Output the intermediates for the _cnp_number basis
OUTPUT(CM.Tallied_cnp_number,NAMED('Tallied_cnp_number'));
OUTPUT(CM.FullTallied_cnp_number,NAMED('FullTallied_cnp_number'));
OUTPUT(CM.Possibles_cnp_number_ni,NAMED('Possibles_cnp_number'));
OUTPUT(CM.Candidates_cnp_number_ni,NAMED('Candidates_cnp_number'));
// Now produce the 'final' patched result
SALT311.MAC_Reassign_UID(TheData,CM.patch_file_np,Proxid,rcid,TD1);
OUTPUT(TD1,NAMED('PatchedResult'));
ENDMACRO;
