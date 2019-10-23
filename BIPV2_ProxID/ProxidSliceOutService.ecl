/*--SOAP--
<message name="ProxidSliceOutService">
<part name="BaseProxid" type="xsd:string"/>
<part name="Basercid" type="xsd:string"/>
<part name="PreferredProxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Basercid should be plucked out of BaseProxid. If a preferred Proxid is provided it will be compared to the rcid too.*/
EXPORT ProxidSliceOutService := MACRO
  IMPORT SALT311,BIPV2_ProxID;
STRING20 rcidstr := ''  : STORED('Basercid');
STRING20 Proxidstr := ''  : STORED('BaseProxid');
STRING20 Pref_Proxidstr := ''  : STORED('PreferredProxid');
BFile := BIPV2_ProxID.In_DOT_Base;
BIPV2_ProxID.match_candidates(BFile).layout_candidates into(BIPV2_ProxID.Keys(BFile).CandidatesForSlice le) := TRANSFORM
  SELF := le;
END;
odl := PROJECT(CHOOSEN(BIPV2_ProxID.Keys(BFile).CandidatesForSlice(Proxid=(UNSIGNED)Proxidstr),10000),into(LEFT));
odr := PROJECT(CHOOSEN(BIPV2_ProxID.Keys(BFile).CandidatesForSlice(Proxid=(UNSIGNED)Pref_Proxidstr),10000),into(LEFT));
k := BIPV2_ProxID.Keys(BFile).Specificities_Key;
BIPV2_ProxID.Layout_Specificities.R s_into(k le) := TRANSFORM
  SELF := le;
END;
s := GLOBAL(PROJECT(k,s_into(LEFT))[1]);
odl_noprop := BIPV2_ProxID.Debug(BFile, s).RemoveProps(odl); // Remove propogated values
odr_noprop := BIPV2_ProxID.Debug(BFile, s).RemoveProps(odr); // Remove propogated values
mtchnp := BIPV2_ProxID.Debug(BFile, s).AnnotateClusterMatches(odl_noprop,(UNSIGNED)rcidstr);
mtchrnp := BIPV2_ProxID.Debug(BFile, s).AnnotateClusterMatches(odr_noprop+odl_noprop(rcid=(UNSIGNED)rcidstr),(UNSIGNED)rcidstr);
odl_noprop_roll_rcidonly := BIPV2_ProxID.Debug(BFile, s).RolledEntities(odl_noprop(rcid = (UNSIGNED)rcidstr));
OUTPUT(odl_noprop_roll_rcidonly, NAMED('TargetSlicedrcid'));
odr_noprop_roll := BIPV2_ProxID.Debug(BFile, s).RolledEntities(odr_noprop);
OUTPUT(odr_noprop_roll, NAMED('PrefProxidRollup'));
odl_noprop_roll := BIPV2_ProxID.Debug(BFile, s).RolledEntities(odl_noprop(rcid <> (UNSIGNED)rcidstr));
OUTPUT(odl_noprop_roll, NAMED('CurrentProxidRollupMinusToSlicercid'));
mtch := BIPV2_ProxID.Debug(BFile, s).AnnotateClusterMatches(odl,(UNSIGNED)rcidstr);
mtchr := BIPV2_ProxID.Debug(BFile, s).AnnotateClusterMatches(odr+odl(rcid=(UNSIGNED)rcidstr),(UNSIGNED)rcidstr);
OUTPUT( CHOOSEN(SORT(mtch,-(conf-conf_prop)),3),NAMED('RecordMatches_WithProps'));
OUTPUT( CHOOSEN(SORT(mtchr,-(conf-conf_prop)),3),NAMED('PreferredRecordMatches_WithProps'));
OUTPUT( odl,NAMED('ProxidValues'));
OUTPUT( odr,NAMED('PreferredProxidValues'));
OUTPUT( odl_noprop,NAMED('ProxidValues_NoProp'));
OUTPUT( odr_noprop,NAMED('PreferredProxidValues_NoProp'));
ENDMACRO;
 
