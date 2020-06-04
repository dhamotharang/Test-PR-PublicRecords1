/*--SOAP--
<message name="CleaveService">
<part name="Proxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Cleave logic as applied to a particular Proxid.*/
EXPORT CleaveService := MACRO
  IMPORT SALT30,BIPV2_ProxID_Platform;
STRING20 Proxidstr := ''  : STORED('Proxid');
SALT30.UIDType uid := (SALT30.UIDType)Proxidstr;
TheData := PROJECT(BIPV2_ProxID_Platform.Keys(BIPV2_ProxID_Platform.In_DOT_Base).InData(Proxid=uid),BIPV2_ProxID_Platform.Layout_DOT_Base);
s := GLOBAL(PROJECT(BIPV2_ProxID_Platform.Keys(TheData).Specificities_Key,BIPV2_ProxID_Platform.Layout_Specificities.R)[1]);
CM := BIPV2_ProxID_Platform.Cleave(TheData,s,TRUE);
// Output the intermediates for the _cnp_number basis
OUTPUT(CM.Tallied_cnp_number,NAMED('Tallied_cnp_number'));
OUTPUT(CM.FullTallied_cnp_number,NAMED('FullTallied_cnp_number'));
OUTPUT(CM.Possibles_cnp_number_ni,NAMED('Possibles_cnp_number'));
OUTPUT(CM.Candidates_cnp_number_ni,NAMED('Candidates_cnp_number'));
// Now produce the 'final' patched result
SALT30.MAC_Reassign_UID(TheData,CM.patch_file_np,Proxid,rcid,TD1);
OUTPUT(TD1,NAMED('PatchedResult'));
ENDMACRO;