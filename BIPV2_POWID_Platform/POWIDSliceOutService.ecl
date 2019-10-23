/*--SOAP--
<message name="POWIDSliceOutService">
<part name="BasePOWID" type="xsd:string"/>
<part name="Basercid" type="xsd:string"/>
<part name="PreferredPOWID" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Basercid should be plucked out of BasePOWID. If a preferred POWID is provided it will be compared to the RID too.*/
export POWIDSliceOutService := MACRO
  IMPORT SALT32,BIPV2_POWID_Platform;
string20 rcidstr := ''  : stored('Basercid');
string20 POWIDstr := ''  : stored('BasePOWID');
string20 Pref_POWIDstr := ''  : stored('PreferredPOWID');
BFile := BIPV2_POWID_Platform.In_POWID;
BIPV2_POWID_Platform.match_candidates(BFile).layout_candidates into(BIPV2_POWID_Platform.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(BIPV2_POWID_Platform.Keys(BFile).Candidates(POWID=(unsigned)POWIDstr),10000),into(left));
odr := project(choosen(BIPV2_POWID_Platform.Keys(BFile).Candidates(POWID=(unsigned)Pref_POWIDstr),10000),into(left));
k := BIPV2_POWID_Platform.Keys(BFile).Specificities_Key;
BIPV2_POWID_Platform.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odl_noprop := BIPV2_POWID_Platform.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := BIPV2_POWID_Platform.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := BIPV2_POWID_Platform.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(unsigned)rcidstr);
mtchrnp := BIPV2_POWID_Platform.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtchnp,-Conf),3),named('RecordMatches'));
output( choosen(sort(mtchrnp,-Conf),3),named('PreferredRecordMatches'));
mtch := BIPV2_POWID_Platform.Debug(BFile,s).AnnotateClusterMatches(odl,(unsigned)rcidstr);
mtchr := BIPV2_POWID_Platform.Debug(BFile,s).AnnotateClusterMatches(odr+odl(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtch,-Conf),3),named('RecordMatches_WithProps'));
output( choosen(sort(mtchr,-Conf),3),named('PreferredRecordMatches_WithProps'));
output( odl,named('POWIDValues'));
output( odr,named('PreferredPOWIDValues'));
output( odl_noprop,named('POWIDValues_NoProp'));
output( odr_noprop,named('PreferredPOWIDValues_NoProp'));
endmacro;
 
