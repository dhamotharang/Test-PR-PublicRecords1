/*--SOAP--
<message name="BDIDCompareService">
<part name="BDIDOne" type="xsd:string"/>
<part name="BDIDTwo" type="xsd:string"/>
</message>
*/
/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/
export BDIDCompareService := MACRO
string50 BDIDonestr := ''  : stored('BDIDOne');
string20 BDIDtwostr := '*'  : stored('BDIDtwo');
unsigned8 BDIDone0 := (unsigned8)ut.Word(BDIDonestr,1); // Allow for two token on a line input
unsigned8 BDIDtwo0 := (unsigned8)(IF(BDIDtwostr='*',ut.Word(BDIDonestr,2),BDIDtwostr));
unsigned8 BDIDone := IF( BDIDone0>BDIDtwo0, BDIDone0, BDIDtwo0 );
unsigned8 BDIDtwo := IF( BDIDone0>BDIDtwo0, BDIDtwo0, BDIDone0 );
Business_Header_Bdid_lift.match_candidates(Business_Header_Bdid_lift.In_file_business_header).layout_candidates into(Business_Header_Bdid_lift.Keys.Candidates le) := transform
  self := le;
end;
odl := project(choosen(Business_Header_Bdid_lift.Keys.Candidates(BDID=BDIDone),1000),into(left));
odr := project(choosen(Business_Header_Bdid_lift.Keys.Candidates(BDID=BDIDTwo),1000),into(left));
k := Business_Header_Bdid_lift.Keys.Specificities_Key;
Business_Header_Bdid_lift.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odlv := Business_Header_Bdid_lift.Debug(Business_Header_Bdid_lift.in_file_business_header,s).RolledEntities(odl);
odrv := Business_Header_Bdid_lift.Debug(Business_Header_Bdid_lift.in_file_business_header,s).RolledEntities(odr);
mtch := Business_Header_Bdid_lift.Debug(Business_Header_Bdid_lift.in_file_business_header,s).AnnotateMatchesFromData(odl+odr,dataset([{0,0,0,0,BDIDone,BDIDtwo,0,0}],Business_Header_Bdid_lift.match_candidates(Business_Header_Bdid_lift.In_file_business_header).layout_matches));
output( odlv,named('BDIDOneFieldValues'));
output( odrv,named('BDIDTwoFieldValues'));
output( sort(mtch,-Conf),named('RecordMatches'));
output( odl,named('BDIDOneRecords'));
output( odr,named('BDIDTwoRecords'));
endmacro;
