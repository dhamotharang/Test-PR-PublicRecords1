/*--SOAP--
<message name="CleaveService">
<part name="LNPID" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Cleave logic as applied to a particular LNPID.*/
EXPORT CleaveService := MACRO
  IMPORT SALT30,HealthCareFacilityHeader;
STRING20 LNPIDstr := ''  : STORED('LNPID');
SALT30.UIDType uid := (SALT30.UIDType)LNPIDstr;
TheData := PROJECT(HealthCareFacilityHeader.Keys(HealthCareFacilityHeader.In_HealthFacility).InData(LNPID=uid),HealthCareFacilityHeader.Layout_HealthFacility);
s := GLOBAL(PROJECT(HealthCareFacilityHeader.Keys(TheData).Specificities_Key,HealthCareFacilityHeader.Layout_Specificities.R)[1]);
CM := HealthCareFacilityHeader.Cleave(TheData,s,TRUE);
// Output the intermediates for the _TAXONOMY_CODE basis
OUTPUT(CM.Tallied_TAXONOMY_CODE,NAMED('Tallied_TAXONOMY_CODE'));
OUTPUT(CM.FullTallied_TAXONOMY_CODE,NAMED('FullTallied_TAXONOMY_CODE'));
OUTPUT(CM.Possibles_TAXONOMY_CODE_ni,NAMED('Possibles_TAXONOMY_CODE'));
OUTPUT(CM.Candidates_TAXONOMY_CODE_ni,NAMED('Candidates_TAXONOMY_CODE'));
// Now produce the 'final' patched result
SALT30.MAC_Reassign_UID(TheData,CM.patch_file_np,LNPID,RID,TD1);
OUTPUT(TD1,NAMED('PatchedResult'));
ENDMACRO;
