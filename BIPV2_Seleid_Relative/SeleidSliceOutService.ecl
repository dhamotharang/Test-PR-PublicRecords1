/*--SOAP--
<message name="SeleidSliceOutService">
<part name="BaseSeleid" type="xsd:string"/>
<part name="Basercid" type="xsd:string"/>
<part name="PreferredSeleid" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Basercid should be plucked out of BaseSeleid. If a preferred Seleid is provided it will be compared to the RID too.*/
export SeleidSliceOutService := MACRO
  IMPORT SALT31,BIPV2_Seleid_Relative;
string20 rcidstr := ''  : stored('Basercid');
string20 Seleidstr := ''  : stored('BaseSeleid');
string20 Pref_Seleidstr := ''  : stored('PreferredSeleid');
BFile := BIPV2_Seleid_Relative.In_Base;
BIPV2_Seleid_Relative.match_candidates(BFile).layout_candidates into(BIPV2_Seleid_Relative.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(BIPV2_Seleid_Relative.Keys(BFile).Candidates(Seleid=(unsigned)Seleidstr),10000),into(left));
odr := project(choosen(BIPV2_Seleid_Relative.Keys(BFile).Candidates(Seleid=(unsigned)Pref_Seleidstr),10000),into(left));
k := BIPV2_Seleid_Relative.Keys(BFile).Specificities_Key;
BIPV2_Seleid_Relative.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odl_noprop := BIPV2_Seleid_Relative.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := BIPV2_Seleid_Relative.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := BIPV2_Seleid_Relative.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(unsigned)rcidstr);
mtchrnp := BIPV2_Seleid_Relative.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtchnp,-Conf),3),named('RecordMatches'));
output( choosen(sort(mtchrnp,-Conf),3),named('PreferredRecordMatches'));
mtch := BIPV2_Seleid_Relative.Debug(BFile,s).AnnotateClusterMatches(odl,(unsigned)rcidstr);
mtchr := BIPV2_Seleid_Relative.Debug(BFile,s).AnnotateClusterMatches(odr+odl(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtch,-Conf),3),named('RecordMatches_WithProps'));
output( choosen(sort(mtchr,-Conf),3),named('PreferredRecordMatches_WithProps'));
output( odl,named('SeleidValues'));
output( odr,named('PreferredSeleidValues'));
output( odl_noprop,named('SeleidValues_NoProp'));
output( odr_noprop,named('PreferredSeleidValues_NoProp'));
endmacro;
