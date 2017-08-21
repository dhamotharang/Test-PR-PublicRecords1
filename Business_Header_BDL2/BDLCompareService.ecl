//Import:Business_Header_BDL2.BDLCompareService
/*--SOAP--
<message name="BDLCompareService">
<part name="BDLOne" type="xsd:string"/>
<part name="BDLTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
export BDLCompareService := MACRO
string50 BDLonestr := ''  : stored('BDLOne');
string20 BDLtwostr := '*'  : stored('BDLtwo');
unsigned8 BDLone0 := (unsigned8)ut.Word(BDLonestr,1); // Allow for two token on a line input
unsigned8 BDLtwo0 := (unsigned8)(IF(BDLtwostr='*',ut.Word(BDLonestr,2),BDLtwostr));
unsigned8 BDLone := IF( BDLone0>BDLtwo0, BDLone0, BDLtwo0 );
unsigned8 BDLtwo := IF( BDLone0>BDLtwo0, BDLtwo0, BDLone0 );
Business_Header_BDL2.match_candidates(Business_Header.BH_BDL2()).layout_candidates into(Business_Header_BDL2.Keys.Candidates le) := transform
  self := le;
end;
odl := project(choosen(Business_Header_BDL2.Keys.Candidates(BDL=BDLone),1000),into(left));
odr := project(choosen(Business_Header_BDL2.Keys.Candidates(BDL=BDLTwo),1000),into(left));
k := Business_Header_BDL2.Keys.Specificities_Key;
Business_Header_BDL2.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odlv := Business_Header_BDL2.Debug(Business_Header.BH_BDL2(),s).RolledEntities(odl);
odrv := Business_Header_BDL2.Debug(Business_Header.BH_BDL2(),s).RolledEntities(odr);
mtch := Business_Header_BDL2.Debug(Business_Header.BH_BDL2(),s).AnnotateMatchesFromData(odl+odr,dataset([{0,0,0,0,BDLone,BDLtwo,0,0}],Business_Header_BDL2.match_candidates(Business_Header.BH_BDL2()).layout_matches));
output( odlv,named('BDLOneFieldValues'));
output( odrv,named('BDLTwoFieldValues'));
output( sort(mtch,-Conf),named('RecordMatches'));
output( odl,named('BDLOneRecords'));
output( odr,named('BDLTwoRecords'));
endmacro;