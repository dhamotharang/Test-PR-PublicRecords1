/*--SOAP--
<message name="ProxidSliceOutService">
<part name="BaseProxid" type="xsd:string"/>
<part name="Basercid" type="xsd:string"/>
<part name="PreferredProxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Basercid should be plucked out of BaseProxid. If a preferred Proxid is provided it will be compared to the RID too.*/
export ProxidSliceOutService := MACRO
  IMPORT SALT30,BIPV2_ProxID_Platform;
string20 rcidstr := ''  : stored('Basercid');
string20 Proxidstr := ''  : stored('BaseProxid');
string20 Pref_Proxidstr := ''  : stored('PreferredProxid');
BFile := BIPV2_ProxID_Platform.In_DOT_Base;
BIPV2_ProxID_Platform.match_candidates(BFile).layout_candidates into(BIPV2_ProxID_Platform.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(BIPV2_ProxID_Platform.Keys(BFile).Candidates(Proxid=(unsigned)Proxidstr),10000),into(left));
odr := project(choosen(BIPV2_ProxID_Platform.Keys(BFile).Candidates(Proxid=(unsigned)Pref_Proxidstr),10000),into(left));
k := BIPV2_ProxID_Platform.Keys(BFile).Specificities_Key;
BIPV2_ProxID_Platform.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odl_noprop := BIPV2_ProxID_Platform.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := BIPV2_ProxID_Platform.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := BIPV2_ProxID_Platform.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(unsigned)rcidstr);
mtchrnp := BIPV2_ProxID_Platform.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtchnp,-Conf),3),named('RecordMatches'));
output( choosen(sort(mtchrnp,-Conf),3),named('PreferredRecordMatches'));
mtch := BIPV2_ProxID_Platform.Debug(BFile,s).AnnotateClusterMatches(odl,(unsigned)rcidstr);
mtchr := BIPV2_ProxID_Platform.Debug(BFile,s).AnnotateClusterMatches(odr+odl(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtch,-Conf),3),named('RecordMatches_WithProps'));
output( choosen(sort(mtchr,-Conf),3),named('PreferredRecordMatches_WithProps'));
output( odl,named('ProxidValues'));
output( odr,named('PreferredProxidValues'));
output( odl_noprop,named('ProxidValues_NoProp'));
output( odr_noprop,named('PreferredProxidValues_NoProp'));
endmacro;
 
