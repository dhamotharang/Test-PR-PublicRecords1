/*--SOAP--
<message name="DIDSliceOutService">
<part name="BaseDID" type="xsd:string"/>
<part name="BaseRID" type="xsd:string"/>
<part name="PreferredDID" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if BaseRID should be plucked out of BaseDID. If a preferred DID is provided it will be compared to the RID too.*/
EXPORT DIDSliceOutService := MACRO
  IMPORT SALT37,InsuranceHeader_RemoteLinking;
STRING20 RIDstr := ''  : STORED('BaseRID');
STRING20 DIDstr := ''  : STORED('BaseDID');
STRING20 Pref_DIDstr := ''  : STORED('PreferredDID');
BFile := InsuranceHeader_RemoteLinking.In_HEADER;
InsuranceHeader_RemoteLinking.match_candidates(BFile).layout_candidates into(InsuranceHeader_RemoteLinking.Keys(BFile).Candidates le) := TRANSFORM
  SELF := le;
END;
odl := PROJECT(CHOOSEN(InsuranceHeader_RemoteLinking.Keys(BFile).Candidates(DID=(UNSIGNED)DIDstr),10000),into(LEFT));
odr := PROJECT(CHOOSEN(InsuranceHeader_RemoteLinking.Keys(BFile).Candidates(DID=(UNSIGNED)Pref_DIDstr),10000),into(LEFT));
k := InsuranceHeader_RemoteLinking.Keys(BFile).Specificities_Key;
InsuranceHeader_RemoteLinking.Layout_Specificities.R s_into(k le) := TRANSFORM
  SELF := le;
END;
s := GLOBAL(PROJECT(k,s_into(LEFT))[1]);
odl_noprop := InsuranceHeader_RemoteLinking.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := InsuranceHeader_RemoteLinking.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := InsuranceHeader_RemoteLinking.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(UNSIGNED)RIDstr);
mtchrnp := InsuranceHeader_RemoteLinking.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(RID=(UNSIGNED)RIDstr),(UNSIGNED)RIDstr);
odl_noprop_roll_RIDonly := InsuranceHeader_RemoteLinking.Debug(BFile,s).RolledEntities(odl_noprop(RID = (UNSIGNED)RIDstr));
OUTPUT(odl_noprop_roll_RIDonly, NAMED('TargetSlicedRID'));
odr_noprop_roll := InsuranceHeader_RemoteLinking.Debug(BFile,s).RolledEntities(odr_noprop);
OUTPUT(odr_noprop_roll, NAMED('PrefDIDRollup'));
odl_noprop_roll := InsuranceHeader_RemoteLinking.Debug(BFile,s).RolledEntities(odl_noprop(RID <> (UNSIGNED)RIDstr));
OUTPUT(odl_noprop_roll, NAMED('CurrentDIDRollupMinusToSliceRID'));
mtch := InsuranceHeader_RemoteLinking.Debug(BFile,s).AnnotateClusterMatches(odl,(UNSIGNED)RIDstr);
mtchr := InsuranceHeader_RemoteLinking.Debug(BFile,s).AnnotateClusterMatches(odr+odl(RID=(UNSIGNED)RIDstr),(UNSIGNED)RIDstr);
OUTPUT( CHOOSEN(SORT(mtch,-(conf-conf_prop)),3),NAMED('RecordMatches_WithProps'));
OUTPUT( CHOOSEN(SORT(mtchr,-(conf-conf_prop)),3),NAMED('PreferredRecordMatches_WithProps'));
OUTPUT( odl,NAMED('DIDValues'));
OUTPUT( odr,NAMED('PreferredDIDValues'));
OUTPUT( odl_noprop,NAMED('DIDValues_NoProp'));
OUTPUT( odr_noprop,NAMED('PreferredDIDValues_NoProp'));
ENDMACRO;
 
