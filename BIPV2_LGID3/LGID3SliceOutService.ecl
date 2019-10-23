/*--SOAP--
<message name="LGID3SliceOutService">
<part name="BaseLGID3" type="xsd:string"/>
<part name="Basercid" type="xsd:string"/>
<part name="PreferredLGID3" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Basercid should be plucked out of BaseLGID3. If a preferred LGID3 is provided it will be compared to the rcid too.*/
EXPORT LGID3SliceOutService := MACRO
  IMPORT SALT311,BIPV2_LGID3;
STRING20 rcidstr := ''  : STORED('Basercid');
STRING20 LGID3str := ''  : STORED('BaseLGID3');
STRING20 Pref_LGID3str := ''  : STORED('PreferredLGID3');
BFile := BIPV2_LGID3.In_LGID3;
BIPV2_LGID3.match_candidates(BFile).layout_candidates into(BIPV2_LGID3.Keys(BFile).CandidatesForSlice le) := TRANSFORM
  SELF := le;
END;
odl := PROJECT(CHOOSEN(BIPV2_LGID3.Keys(BFile).CandidatesForSlice(LGID3=(UNSIGNED)LGID3str),10000),into(LEFT));
odr := PROJECT(CHOOSEN(BIPV2_LGID3.Keys(BFile).CandidatesForSlice(LGID3=(UNSIGNED)Pref_LGID3str),10000),into(LEFT));
k := BIPV2_LGID3.Keys(BFile).Specificities_Key;
BIPV2_LGID3.Layout_Specificities.R s_into(k le) := TRANSFORM
  SELF := le;
END;
s := GLOBAL(PROJECT(k,s_into(LEFT))[1]);
odl_noprop := BIPV2_LGID3.Debug(BFile, s).RemoveProps(odl); // Remove propogated values
odr_noprop := BIPV2_LGID3.Debug(BFile, s).RemoveProps(odr); // Remove propogated values
mtchnp := BIPV2_LGID3.Debug(BFile, s).AnnotateClusterMatches(odl_noprop,(UNSIGNED)rcidstr);
mtchrnp := BIPV2_LGID3.Debug(BFile, s).AnnotateClusterMatches(odr_noprop+odl_noprop(rcid=(UNSIGNED)rcidstr),(UNSIGNED)rcidstr);
odl_noprop_roll_rcidonly := BIPV2_LGID3.Debug(BFile, s).RolledEntities(odl_noprop(rcid = (UNSIGNED)rcidstr));
OUTPUT(odl_noprop_roll_rcidonly, NAMED('TargetSlicedrcid'));
odr_noprop_roll := BIPV2_LGID3.Debug(BFile, s).RolledEntities(odr_noprop);
OUTPUT(odr_noprop_roll, NAMED('PrefLGID3Rollup'));
odl_noprop_roll := BIPV2_LGID3.Debug(BFile, s).RolledEntities(odl_noprop(rcid <> (UNSIGNED)rcidstr));
OUTPUT(odl_noprop_roll, NAMED('CurrentLGID3RollupMinusToSlicercid'));
mtch := BIPV2_LGID3.Debug(BFile, s).AnnotateClusterMatches(odl,(UNSIGNED)rcidstr);
mtchr := BIPV2_LGID3.Debug(BFile, s).AnnotateClusterMatches(odr+odl(rcid=(UNSIGNED)rcidstr),(UNSIGNED)rcidstr);
OUTPUT( CHOOSEN(SORT(mtch,-(conf-conf_prop)),3),NAMED('RecordMatches_WithProps'));
OUTPUT( CHOOSEN(SORT(mtchr,-(conf-conf_prop)),3),NAMED('PreferredRecordMatches_WithProps'));
OUTPUT( odl,NAMED('LGID3Values'));
OUTPUT( odr,NAMED('PreferredLGID3Values'));
OUTPUT( odl_noprop,NAMED('LGID3Values_NoProp'));
OUTPUT( odr_noprop,NAMED('PreferredLGID3Values_NoProp'));
ENDMACRO;
 
