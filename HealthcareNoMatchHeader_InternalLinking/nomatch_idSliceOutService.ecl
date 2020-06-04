/*--SOAP--
<message name="nomatch_idSliceOutService">
<part name="Basenomatch_id" type="xsd:string"/>
<part name="BaseRID" type="xsd:string"/>
<part name="Preferrednomatch_id" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if BaseRID should be plucked out of Basenomatch_id. If a preferred nomatch_id is provided it will be compared to the RID too.*/
EXPORT nomatch_idSliceOutService := MACRO
  IMPORT SALT311,HealthcareNoMatchHeader_InternalLinking;
STRING20 RIDstr := ''  : STORED('BaseRID');
STRING20 nomatch_idstr := ''  : STORED('Basenomatch_id');
STRING20 Pref_nomatch_idstr := ''  : STORED('Preferrednomatch_id');
BFile := HealthcareNoMatchHeader_InternalLinking.In_HEADER;
HealthcareNoMatchHeader_InternalLinking.match_candidates(BFile).layout_candidates into(HealthcareNoMatchHeader_InternalLinking.Keys(BFile).CandidatesForSlice le) := TRANSFORM
  SELF := le;
END;
odl := PROJECT(CHOOSEN(HealthcareNoMatchHeader_InternalLinking.Keys(BFile).CandidatesForSlice(nomatch_id=(UNSIGNED)nomatch_idstr),10000),into(LEFT));
odr := PROJECT(CHOOSEN(HealthcareNoMatchHeader_InternalLinking.Keys(BFile).CandidatesForSlice(nomatch_id=(UNSIGNED)Pref_nomatch_idstr),10000),into(LEFT));
k := HealthcareNoMatchHeader_InternalLinking.Keys(BFile).Specificities_Key;
HealthcareNoMatchHeader_InternalLinking.Layout_Specificities.R s_into(k le) := TRANSFORM
  SELF := le;
END;
s := GLOBAL(PROJECT(k,s_into(LEFT))[1]);
odl_noprop := HealthcareNoMatchHeader_InternalLinking.Debug(BFile, s).RemoveProps(odl); // Remove propogated values
odr_noprop := HealthcareNoMatchHeader_InternalLinking.Debug(BFile, s).RemoveProps(odr); // Remove propogated values
mtchnp := HealthcareNoMatchHeader_InternalLinking.Debug(BFile, s).AnnotateClusterMatches(odl_noprop,(UNSIGNED)RIDstr);
mtchrnp := HealthcareNoMatchHeader_InternalLinking.Debug(BFile, s).AnnotateClusterMatches(odr_noprop+odl_noprop(RID=(UNSIGNED)RIDstr),(UNSIGNED)RIDstr);
odl_noprop_roll_RIDonly := HealthcareNoMatchHeader_InternalLinking.Debug(BFile, s).RolledEntities(odl_noprop(RID = (UNSIGNED)RIDstr));
OUTPUT(odl_noprop_roll_RIDonly, NAMED('TargetSlicedRID'));
odr_noprop_roll := HealthcareNoMatchHeader_InternalLinking.Debug(BFile, s).RolledEntities(odr_noprop);
OUTPUT(odr_noprop_roll, NAMED('Prefnomatch_idRollup'));
odl_noprop_roll := HealthcareNoMatchHeader_InternalLinking.Debug(BFile, s).RolledEntities(odl_noprop(RID <> (UNSIGNED)RIDstr));
OUTPUT(odl_noprop_roll, NAMED('Currentnomatch_idRollupMinusToSliceRID'));
mtch := HealthcareNoMatchHeader_InternalLinking.Debug(BFile, s).AnnotateClusterMatches(odl,(UNSIGNED)RIDstr);
mtchr := HealthcareNoMatchHeader_InternalLinking.Debug(BFile, s).AnnotateClusterMatches(odr+odl(RID=(UNSIGNED)RIDstr),(UNSIGNED)RIDstr);
OUTPUT( CHOOSEN(SORT(mtch,-(conf-conf_prop)),3),NAMED('RecordMatches_WithProps'));
OUTPUT( CHOOSEN(SORT(mtchr,-(conf-conf_prop)),3),NAMED('PreferredRecordMatches_WithProps'));
OUTPUT( odl,NAMED('nomatch_idValues'));
OUTPUT( odr,NAMED('Preferrednomatch_idValues'));
OUTPUT( odl_noprop,NAMED('nomatch_idValues_NoProp'));
OUTPUT( odr_noprop,NAMED('Preferrednomatch_idValues_NoProp'));
ENDMACRO;
 
