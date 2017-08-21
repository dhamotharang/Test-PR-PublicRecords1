/*--SOAP--
<message name="CleaveService">
<part name="LNPID" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Cleave logic as applied to a particular LNPID.*/
EXPORT CleaveService := MACRO
  IMPORT SALT29,HealthCareProviderHeader;
STRING20 LNPIDstr := ''  : STORED('LNPID');
SALT29.UIDType uid := (SALT29.UIDType)LNPIDstr;
TheData := PROJECT(HealthCareProviderHeader.Keys(HealthCareProviderHeader.In_HealthProvider).InData(LNPID=uid),HealthCareProviderHeader.Layout_HealthProvider);
s := GLOBAL(PROJECT(HealthCareProviderHeader.Keys(TheData).Specificities_Key,HealthCareProviderHeader.Layout_Specificities.R)[1]);
CM := HealthCareProviderHeader.Cleave(TheData,s,TRUE);
// Output the intermediates for the _NPI_NUMBER basis
OUTPUT(CM.Tallied_NPI_NUMBER,NAMED('Tallied_NPI_NUMBER'));
OUTPUT(CM.FullTallied_NPI_NUMBER,NAMED('FullTallied_NPI_NUMBER'));
OUTPUT(CM.Possibles_NPI_NUMBER_ni,NAMED('Possibles_NPI_NUMBER'));
OUTPUT(CM.Candidates_NPI_NUMBER_ni,NAMED('Candidates_NPI_NUMBER'));
// Output the intermediates for the _UPIN basis
OUTPUT(CM.Tallied_UPIN,NAMED('Tallied_UPIN'));
OUTPUT(CM.FullTallied_UPIN,NAMED('FullTallied_UPIN'));
OUTPUT(CM.Possibles_UPIN_ni,NAMED('Possibles_UPIN'));
OUTPUT(CM.Candidates_UPIN_ni,NAMED('Candidates_UPIN'));
// Now produce the 'final' patched result
SALT29.MAC_Reassign_UID(TheData,CM.patch_file,LNPID,RID,TD1);
OUTPUT(TD1,NAMED('PatchedResult'));
ENDMACRO;
