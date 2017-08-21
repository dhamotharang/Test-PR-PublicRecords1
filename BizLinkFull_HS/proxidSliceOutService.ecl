/*--SOAP--
<message name="proxidSliceOutService">
<part name="Baseproxid" type="xsd:string"/>
<part name="Basercid" type="xsd:string"/>
<part name="Preferredproxid" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Basercid should be plucked out of Baseproxid. If a preferred proxid is provided it will be compared to the RID too.*/
export proxidSliceOutService := MACRO
  IMPORT SALT33,BizLinkFull_HS;
string20 rcidstr := ''  : stored('Basercid');
string20 proxidstr := ''  : stored('Baseproxid');
string20 Pref_proxidstr := ''  : stored('Preferredproxid');
BFile := BizLinkFull_HS.In_BizHead;
BizLinkFull_HS.match_candidates(BFile).layout_candidates into(BizLinkFull_HS.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(BizLinkFull_HS.Keys(BFile).Candidates(proxid=(unsigned)proxidstr),10000),into(left));
odr := project(choosen(BizLinkFull_HS.Keys(BFile).Candidates(proxid=(unsigned)Pref_proxidstr),10000),into(left));
k := BizLinkFull_HS.Keys(BFile).Specificities_Key;
BizLinkFull_HS.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odl_noprop := BizLinkFull_HS.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := BizLinkFull_HS.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := BizLinkFull_HS.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(unsigned)rcidstr);
mtchrnp := BizLinkFull_HS.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtchnp,-Conf),3),named('RecordMatches'));
output( choosen(sort(mtchrnp,-Conf),3),named('PreferredRecordMatches'));
mtch := BizLinkFull_HS.Debug(BFile,s).AnnotateClusterMatches(odl,(unsigned)rcidstr);
mtchr := BizLinkFull_HS.Debug(BFile,s).AnnotateClusterMatches(odr+odl(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtch,-Conf),3),named('RecordMatches_WithProps'));
output( choosen(sort(mtchr,-Conf),3),named('PreferredRecordMatches_WithProps'));
output( odl,named('proxidValues'));
output( odr,named('PreferredproxidValues'));
output( odl_noprop,named('proxidValues_NoProp'));
output( odr_noprop,named('PreferredproxidValues_NoProp'));
endmacro;
 
