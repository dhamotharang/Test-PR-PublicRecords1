/*--SOAP--
<message name="CleaveService">
<part name="DOTid" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Cleave logic as applied to a particular DOTid.*/
EXPORT CleaveService := MACRO
  IMPORT SALT32,BIPV2_DOTID_PLATFORM;
STRING20 DOTidstr := ''  : STORED('DOTid');
SALT32.UIDType uid := (SALT32.UIDType)DOTidstr;
TheData := PROJECT(BIPV2_DOTID_PLATFORM.Keys(BIPV2_DOTID_PLATFORM.In_DOT).InData(DOTid=uid),BIPV2_DOTID_PLATFORM.Layout_DOT);
s := GLOBAL(PROJECT(BIPV2_DOTID_PLATFORM.Keys(TheData).Specificities_Key,BIPV2_DOTID_PLATFORM.Layout_Specificities.R)[1]);
CM := BIPV2_DOTID_PLATFORM.Cleave(TheData,s,TRUE);
// Output the intermediates for the _cnp_number basis
OUTPUT(CM.Tallied_cnp_number,NAMED('Tallied_cnp_number'));
OUTPUT(CM.FullTallied_cnp_number,NAMED('FullTallied_cnp_number'));
OUTPUT(CM.Possibles_cnp_number_ni,NAMED('Possibles_cnp_number'));
OUTPUT(CM.Candidates_cnp_number_ni,NAMED('Candidates_cnp_number'));
// Output the intermediates for the _active_enterprise_number basis
OUTPUT(CM.Tallied_active_enterprise_number,NAMED('Tallied_active_enterprise_number'));
OUTPUT(CM.FullTallied_active_enterprise_number,NAMED('FullTallied_active_enterprise_number'));
OUTPUT(CM.Possibles_active_enterprise_number_ni,NAMED('Possibles_active_enterprise_number'));
OUTPUT(CM.Candidates_active_enterprise_number_ni,NAMED('Candidates_active_enterprise_number'));
// Output the intermediates for the _active_domestic_corp_key basis
OUTPUT(CM.Tallied_active_domestic_corp_key,NAMED('Tallied_active_domestic_corp_key'));
OUTPUT(CM.FullTallied_active_domestic_corp_key,NAMED('FullTallied_active_domestic_corp_key'));
OUTPUT(CM.Possibles_active_domestic_corp_key_ni,NAMED('Possibles_active_domestic_corp_key'));
OUTPUT(CM.Candidates_active_domestic_corp_key_ni,NAMED('Candidates_active_domestic_corp_key'));
// Now produce the 'final' patched result
SALT32.MAC_Reassign_UID(TheData,CM.patch_file_np,DOTid,rcid,TD1);
OUTPUT(TD1,NAMED('PatchedResult'));
ENDMACRO;
