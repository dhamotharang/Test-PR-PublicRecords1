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
unsigned8 DIDone := (unsigned8)ut.Word(DIDonestr,1); // Allow for two token on a line input
unsigned8 DIDtwo := (unsigned8)(IF(DIDtwostr='*',ut.Word(DIDonestr,2),DIDtwostr));
NGADL.match_candidates(NGADL.In_HEADER).layout_candidates into(NGADL.Keys(NGADL.In_HEADER).Candidates le) := transform
	self.name_suffix := '';
  self := le;
end;
odl := project(choosen(NGADL.Keys(NGADL.In_HEADER).Candidates(DID=DIDone),1000),into(left));
odr := project(choosen(NGADL.Keys(NGADL.In_HEADER).Candidates(DID=DIDTwo),1000),into(left));
k := NGADL.Keys(NGADL.In_HEADER).Specificities_Key;
NGADL.Layout_Specificities(NGADL.In_HEADER) s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odlv := NGADL.Debug(NGADL.in_HEADER).RolledEntities(odl,s);
odrv := NGADL.Debug(NGADL.in_HEADER).RolledEntities(odr,s);
mtch := NGADL.Debug(NGADL.in_HEADER).AnnotateMatchesFromData(odl+odr,dataset([{0,0,0,DIDone,DIDtwo,0,0}],NGADL.match_candidates(NGADL.In_HEADER).layout_matches),s);
output( odl,named('DIDOneFieldValues_unrolled'));
output( odr,named('DIDTwoFieldValues_unrolled'));
output( odlv,named('DIDOneFieldValues'));
output( odrv,named('DIDTwoFieldValues'));
output( sort(mtch,-Conf),named('RecordMatches'));
output( odl,named('DIDOneRecords'));
output( odr,named('DIDTwoRecords'));
endmacro;
