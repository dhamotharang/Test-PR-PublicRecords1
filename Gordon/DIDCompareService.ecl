/*--SOAP--
<message name="DIDCompareService">
<part name="DIDOne" type="xsd:string"/>
<part name="DIDTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
export DIDCompareService := MACRO
string50 DIDonestr := ''  : stored('DIDOne');
string20 DIDtwostr := '*'  : stored('DIDtwo');
unsigned8 DIDone0 := (unsigned8)ut.Word(DIDonestr,1); // Allow for two token on a line input
unsigned8 DIDtwo0 := (unsigned8)(IF(DIDtwostr='*',ut.Word(DIDonestr,2),DIDtwostr));
unsigned8 DIDone := IF( DIDone0>DIDtwo0, DIDone0, DIDtwo0 );
unsigned8 DIDtwo := IF( DIDone0>DIDtwo0, DIDtwo0, DIDone0 );
Gordon.match_candidates(Gordon.In_HEADER).layout_candidates into(Gordon.Keys.Candidates le) := transform
  self := le;
end;
odl := project(choosen(Gordon.Keys.Candidates(DID=DIDone),1000),into(left));
odr := project(choosen(Gordon.Keys.Candidates(DID=DIDTwo),1000),into(left));
k := Gordon.Keys.Specificities_Key;
Gordon.Layout_Specificities s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odlv := Gordon.Debug(Gordon.in_HEADER,s).RolledEntities(odl);
odrv := Gordon.Debug(Gordon.in_HEADER,s).RolledEntities(odr);
mtch := Gordon.Debug(Gordon.in_HEADER,s).AnnotateMatchesFromData(odl+odr,dataset([{0,0,0,0,DIDone,DIDtwo,0,0}],Gordon.match_candidates(Gordon.In_HEADER).layout_matches));
output( odlv,named('DIDOneFieldValues'));
output( odrv,named('DIDTwoFieldValues'));
output( sort(mtch,-Conf),named('RecordMatches'));
output( odl,named('DIDOneRecords'));
output( odr,named('DIDTwoRecords'));
endmacro;
