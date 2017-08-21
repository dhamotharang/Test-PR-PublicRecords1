/*--SOAP--
<message name="SliceOutService">
<part name="Base" type="xsd:string"/>
<part name="Base" type="xsd:string"/>
<part name="Preferred" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Base should be plucked out of Base. If a preferred  is provided it will be compared to the RID too.*/
export SliceOutService := MACRO
string20 str := ''  : stored('Base');
string20 str := ''  : stored('Base');
string20 Pref_str := ''  : stored('Preferred');
BFile := NPPES.In_FileIN;
NPPES.match_candidates(BFile).layout_candidates into(NPPES.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(NPPES.Keys(BFile).Candidates(=(unsigned)str),10000),into(left));
odr := project(choosen(NPPES.Keys(BFile).Candidates(=(unsigned)Pref_str),10000),into(left));
k := NPPES.Keys(BFile).Specificities_Key;
NPPES.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odl_noprop := NPPES.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := NPPES.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := NPPES.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(unsigned)str);
mtchrnp := NPPES.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(=(unsigned)str),(unsigned)str);
output( choosen(sort(mtchnp,-Conf),3),named('RecordMatches'));
output( choosen(sort(mtchrnp,-Conf),3),named('PreferredRecordMatches'));
mtch := NPPES.Debug(BFile,s).AnnotateClusterMatches(odl,(unsigned)str);
mtchr := NPPES.Debug(BFile,s).AnnotateClusterMatches(odr+odl(=(unsigned)str),(unsigned)str);
output( choosen(sort(mtch,-Conf),3),named('RecordMatches_WithProps'));
output( choosen(sort(mtchr,-Conf),3),named('PreferredRecordMatches_WithProps'));
output( odl,named('Values'));
output( odr,named('PreferredValues'));
output( odl_noprop,named('Values_NoProp'));
output( odr_noprop,named('PreferredValues_NoProp'));
endmacro;
