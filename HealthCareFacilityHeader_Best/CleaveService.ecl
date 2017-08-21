/*--SOAP--
<message name="CleaveService">
<part name="LNPID" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Cleave logic as applied to a particular LNPID.*/
EXPORT CleaveService := MACRO
  IMPORT SALT30,HealthCareFacilityHeader_Best;
STRING20 LNPIDstr := ''  : STORED('LNPID');
SALT30.UIDType uid := (SALT30.UIDType)LNPIDstr;
TheData := PROJECT(HealthCareFacilityHeader_Best.Keys(HealthCareFacilityHeader_Best.In_HealthFacility).InData(LNPID=uid),HealthCareFacilityHeader_Best.Layout_HealthFacility);
s := GLOBAL(PROJECT(HealthCareFacilityHeader_Best.Keys(TheData).Specificities_Key,HealthCareFacilityHeader_Best.Layout_Specificities.R)[1]);
CM := HealthCareFacilityHeader_Best.Cleave(TheData,s,TRUE);
// Output the intermediates for the _NPI_NUMBER basis
OUTPUT(CM.Tallied_NPI_NUMBER,NAMED('Tallied_NPI_NUMBER'));
OUTPUT(CM.FullTallied_NPI_NUMBER,NAMED('FullTallied_NPI_NUMBER'));
OUTPUT(CM.Possibles_NPI_NUMBER_ni,NAMED('Possibles_NPI_NUMBER'));
OUTPUT(CM.Candidates_NPI_NUMBER_ni,NAMED('Candidates_NPI_NUMBER'));
// Now produce the 'final' patched result
SALT30.MAC_Reassign_UID(TheData,CM.patch_file_np,LNPID,RID,TD1);
OUTPUT(TD1,NAMED('PatchedResult'));
ENDMACRO;
