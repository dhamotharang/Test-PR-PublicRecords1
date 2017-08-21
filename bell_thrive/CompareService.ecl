/*--SOAP--
<message name="CompareService">
<part name="One" type="xsd:string"/>
<part name="Two" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
export CompareService := MACRO
string50 onestr := ''  : stored('One');
string20 twostr := '*'  : stored('two');
unsigned8 one0 := (unsigned8)ut.Word(onestr,1); // Allow for two token on a line input
unsigned8 two0 := (unsigned8)(IF(twostr='*',ut.Word(onestr,2),twostr));
unsigned8 one := IF( one0>two0, one0, two0 );
unsigned8 two := IF( one0>two0, two0, one0 );
BFile := bell_thrive.In_files().input.used;
bell_thrive.match_candidates(BFile).layout_candidates into(bell_thrive.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(bell_thrive.Keys(BFile).Candidates(=one),100000),into(left));
odr := project(choosen(bell_thrive.Keys(BFile).Candidates(=Two),100000),into(left));
k := bell_thrive.Keys(BFile).Specificities_Key;
bell_thrive.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odlv := bell_thrive.Debug(BFile,s).RolledEntities(odl);
odrv := bell_thrive.Debug(BFile,s).RolledEntities(odr);
mtch := bell_thrive.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,dataset([{0,0,0,0,one,two,0,0}],bell_thrive.match_candidates(BFile).layout_matches));
output( odlv,named('OneFieldValues'));
output( odrv,named('TwoFieldValues'));
output( sort(mtch,-Conf),named('RecordMatches'));
output( odl,named('OneRecords'));
output( odr,named('TwoRecords'));
endmacro;
