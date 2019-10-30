/*--SOAP--
<message name="DOTidSliceOutService">
<part name="BaseDOTid" type="xsd:string"/>
<part name="Basercid" type="xsd:string"/>
<part name="PreferredDOTid" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Basercid should be plucked out of BaseDOTid. If a preferred DOTid is provided it will be compared to the RID too.*/
export DOTidSliceOutService := MACRO
  IMPORT SALT32,BIPV2_DOTID_PLATFORM;
string20 rcidstr := ''  : stored('Basercid');
string20 DOTidstr := ''  : stored('BaseDOTid');
string20 Pref_DOTidstr := ''  : stored('PreferredDOTid');
BFile := BIPV2_DOTID_PLATFORM.In_DOT;
BIPV2_DOTID_PLATFORM.match_candidates(BFile).layout_candidates into(BIPV2_DOTID_PLATFORM.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(BIPV2_DOTID_PLATFORM.Keys(BFile).Candidates(DOTid=(unsigned)DOTidstr),10000),into(left));
odr := project(choosen(BIPV2_DOTID_PLATFORM.Keys(BFile).Candidates(DOTid=(unsigned)Pref_DOTidstr),10000),into(left));
k := BIPV2_DOTID_PLATFORM.Keys(BFile).Specificities_Key;
BIPV2_DOTID_PLATFORM.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odl_noprop := BIPV2_DOTID_PLATFORM.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := BIPV2_DOTID_PLATFORM.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := BIPV2_DOTID_PLATFORM.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(unsigned)rcidstr);
mtchrnp := BIPV2_DOTID_PLATFORM.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtchnp,-Conf),3),named('RecordMatches'));
output( choosen(sort(mtchrnp,-Conf),3),named('PreferredRecordMatches'));
mtch := BIPV2_DOTID_PLATFORM.Debug(BFile,s).AnnotateClusterMatches(odl,(unsigned)rcidstr);
mtchr := BIPV2_DOTID_PLATFORM.Debug(BFile,s).AnnotateClusterMatches(odr+odl(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtch,-Conf),3),named('RecordMatches_WithProps'));
output( choosen(sort(mtchr,-Conf),3),named('PreferredRecordMatches_WithProps'));
output( odl,named('DOTidValues'));
output( odr,named('PreferredDOTidValues'));
output( odl_noprop,named('DOTidValues_NoProp'));
output( odr_noprop,named('PreferredDOTidValues_NoProp'));
endmacro;
 
