/*--SOAP--
<message name="ADDRESS_GROUP_IDSliceOutService">
<part name="BaseADDRESS_GROUP_ID" type="xsd:string"/>
<part name="BaseRID" type="xsd:string"/>
<part name="PreferredADDRESS_GROUP_ID" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if BaseRID should be plucked out of BaseADDRESS_GROUP_ID. If a preferred ADDRESS_GROUP_ID is provided it will be compared to the RID too.*/
EXPORT ADDRESS_GROUP_IDSliceOutService := MACRO
  IMPORT SALT311,InsuranceHeader_Address;
STRING20 RIDstr := ''  : STORED('BaseRID');
STRING20 ADDRESS_GROUP_IDstr := ''  : STORED('BaseADDRESS_GROUP_ID');
STRING20 Pref_ADDRESS_GROUP_IDstr := ''  : STORED('PreferredADDRESS_GROUP_ID');
BFile := InsuranceHeader_Address.In_Address_Link;
InsuranceHeader_Address.match_candidates(BFile).layout_candidates into(InsuranceHeader_Address.Keys(BFile).CandidatesForSlice le) := TRANSFORM
  SELF := le;
END;
odl := PROJECT(CHOOSEN(InsuranceHeader_Address.Keys(BFile).CandidatesForSlice(ADDRESS_GROUP_ID=(UNSIGNED)ADDRESS_GROUP_IDstr),10000),into(LEFT));
odr := PROJECT(CHOOSEN(InsuranceHeader_Address.Keys(BFile).CandidatesForSlice(ADDRESS_GROUP_ID=(UNSIGNED)Pref_ADDRESS_GROUP_IDstr),10000),into(LEFT));
k := InsuranceHeader_Address.Keys(BFile).Specificities_Key;
InsuranceHeader_Address.Layout_Specificities.R s_into(k le) := TRANSFORM
  SELF := le;
END;
s := GLOBAL(PROJECT(k,s_into(LEFT))[1]);
odl_noprop := InsuranceHeader_Address.Debug(BFile, s).RemoveProps(odl); // Remove propogated values
odr_noprop := InsuranceHeader_Address.Debug(BFile, s).RemoveProps(odr); // Remove propogated values
mtchnp := InsuranceHeader_Address.Debug(BFile, s).AnnotateClusterMatches(odl_noprop,(UNSIGNED)RIDstr);
mtchrnp := InsuranceHeader_Address.Debug(BFile, s).AnnotateClusterMatches(odr_noprop+odl_noprop(RID=(UNSIGNED)RIDstr),(UNSIGNED)RIDstr);
odl_noprop_roll_RIDonly := InsuranceHeader_Address.Debug(BFile, s).RolledEntities(odl_noprop(RID = (UNSIGNED)RIDstr));
OUTPUT(odl_noprop_roll_RIDonly, NAMED('TargetSlicedRID'));
odr_noprop_roll := InsuranceHeader_Address.Debug(BFile, s).RolledEntities(odr_noprop);
OUTPUT(odr_noprop_roll, NAMED('PrefADDRESS_GROUP_IDRollup'));
odl_noprop_roll := InsuranceHeader_Address.Debug(BFile, s).RolledEntities(odl_noprop(RID <> (UNSIGNED)RIDstr));
OUTPUT(odl_noprop_roll, NAMED('CurrentADDRESS_GROUP_IDRollupMinusToSliceRID'));
mtch := InsuranceHeader_Address.Debug(BFile, s).AnnotateClusterMatches(odl,(UNSIGNED)RIDstr);
mtchr := InsuranceHeader_Address.Debug(BFile, s).AnnotateClusterMatches(odr+odl(RID=(UNSIGNED)RIDstr),(UNSIGNED)RIDstr);
OUTPUT( CHOOSEN(SORT(mtch,-(conf-conf_prop)),3),NAMED('RecordMatches_WithProps'));
OUTPUT( CHOOSEN(SORT(mtchr,-(conf-conf_prop)),3),NAMED('PreferredRecordMatches_WithProps'));
OUTPUT( odl,NAMED('ADDRESS_GROUP_IDValues'));
OUTPUT( odr,NAMED('PreferredADDRESS_GROUP_IDValues'));
OUTPUT( odl_noprop,NAMED('ADDRESS_GROUP_IDValues_NoProp'));
OUTPUT( odr_noprop,NAMED('PreferredADDRESS_GROUP_IDValues_NoProp'));
ENDMACRO;
 
