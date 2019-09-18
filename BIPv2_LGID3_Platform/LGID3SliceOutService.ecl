/*--SOAP--
<message name="LGID3SliceOutService">
<part name="BaseLGID3" type="xsd:string"/>
<part name="Basercid" type="xsd:string"/>
<part name="PreferredLGID3" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Basercid should be plucked out of BaseLGID3. If a preferred LGID3 is provided it will be compared to the RID too.*/
export LGID3SliceOutService := MACRO
  IMPORT SALT30,BIPV2_LGID3_PlatForm;
string20 rcidstr := ''  : stored('Basercid');
string20 LGID3str := ''  : stored('BaseLGID3');
string20 Pref_LGID3str := ''  : stored('PreferredLGID3');
BFile := BIPV2_LGID3_PlatForm.In_LGID3;
BIPV2_LGID3_PlatForm.match_candidates(BFile).layout_candidates into(BIPV2_LGID3_PlatForm.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(BIPV2_LGID3_PlatForm.Keys(BFile).Candidates(LGID3=(unsigned)LGID3str),10000),into(left));
odr := project(choosen(BIPV2_LGID3_PlatForm.Keys(BFile).Candidates(LGID3=(unsigned)Pref_LGID3str),10000),into(left));
k := BIPV2_LGID3_PlatForm.Keys(BFile).Specificities_Key;
BIPV2_LGID3_PlatForm.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odl_noprop := BIPV2_LGID3_PlatForm.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := BIPV2_LGID3_PlatForm.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := BIPV2_LGID3_PlatForm.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(unsigned)rcidstr);
mtchrnp := BIPV2_LGID3_PlatForm.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtchnp,-Conf),3),named('RecordMatches'));
output( choosen(sort(mtchrnp,-Conf),3),named('PreferredRecordMatches'));
mtch := BIPV2_LGID3_PlatForm.Debug(BFile,s).AnnotateClusterMatches(odl,(unsigned)rcidstr);
mtchr := BIPV2_LGID3_PlatForm.Debug(BFile,s).AnnotateClusterMatches(odr+odl(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtch,-Conf),3),named('RecordMatches_WithProps'));
output( choosen(sort(mtchr,-Conf),3),named('PreferredRecordMatches_WithProps'));
output( odl,named('LGID3Values'));
output( odr,named('PreferredLGID3Values'));
output( odl_noprop,named('LGID3Values_NoProp'));
output( odr_noprop,named('PreferredLGID3Values_NoProp'));
endmacro;
 
