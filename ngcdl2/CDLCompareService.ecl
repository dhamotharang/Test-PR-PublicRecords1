/*--SOAP--
<message name="CDLCompareService">
<part name="CDLOne" type="xsd:string"/>
<part name="CDLTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
export CDLCompareService := MACRO
string50 CDLonestr := ''  : stored('CDLOne');
string20 CDLtwostr := '*'  : stored('CDLtwo');
unsigned8 CDLone := (unsigned8)ut.Word(CDLonestr,1); // Allow for two token on a line input
unsigned8 CDLtwo := (unsigned8)(IF(CDLtwostr='*',ut.Word(CDLonestr,2),CDLtwostr));
NGCDL2.match_candidates(NGCDL2.In_HEADER).layout_candidates into(NGCDL2.Keys.Candidates le) := transform
  self := le;
end;
odl := project(choosen(NGCDL2.Keys.Candidates(CDL=CDLone),1000),into(left));
odr := project(choosen(NGCDL2.Keys.Candidates(CDL=CDLTwo),1000),into(left));
k := NGCDL2.Keys.Specificities_Key;
NGCDL2.Layout_Specificities s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odlv := NGCDL2.Debug(NGCDL2.in_HEADER,s).RolledEntities(odl);
odrv := NGCDL2.Debug(NGCDL2.in_HEADER,s).RolledEntities(odr);
mtch := NGCDL2.Debug(NGCDL2.in_HEADER,s).AnnotateMatchesFromData(odl+odr,dataset([{0,0,0,CDLone,CDLtwo,0,0}],NGCDL2.match_candidates(NGCDL2.In_HEADER).layout_matches));
output( odlv,named('CDLOneFieldValues'));
output( odrv,named('CDLTwoFieldValues'));
output( sort(mtch,-Conf),named('RecordMatches'));
output( odl,named('CDLOneRecords'));
output( odr,named('CDLTwoRecords'));
endmacro;
