/*--SOAP--
<message name="DPROPTXIDSliceOutService">
<part name="BaseDPROPTXID" type="xsd:string"/>
<part name="Baserid" type="xsd:string"/>
<part name="PreferredDPROPTXID" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Baserid should be plucked out of BaseDPROPTXID. If a preferred DPROPTXID is provided it will be compared to the RID too.*/
export DPROPTXIDSliceOutService := MACRO
  IMPORT SALT34,InsuranceHeader_Property_Transactions_DeedsMortgages;
string20 ridstr := ''  : stored('Baserid');
string20 DPROPTXIDstr := ''  : stored('BaseDPROPTXID');
string20 Pref_DPROPTXIDstr := ''  : stored('PreferredDPROPTXID');
BFile := InsuranceHeader_Property_Transactions_DeedsMortgages.In_PROPERTY_TRANSACTION;
InsuranceHeader_Property_Transactions_DeedsMortgages.match_candidates(BFile).layout_candidates into(InsuranceHeader_Property_Transactions_DeedsMortgages.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(InsuranceHeader_Property_Transactions_DeedsMortgages.Keys(BFile).Candidates(DPROPTXID=(unsigned)DPROPTXIDstr),10000),into(left));
odr := project(choosen(InsuranceHeader_Property_Transactions_DeedsMortgages.Keys(BFile).Candidates(DPROPTXID=(unsigned)Pref_DPROPTXIDstr),10000),into(left));
k := InsuranceHeader_Property_Transactions_DeedsMortgages.Keys(BFile).Specificities_Key;
InsuranceHeader_Property_Transactions_DeedsMortgages.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odl_noprop := InsuranceHeader_Property_Transactions_DeedsMortgages.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := InsuranceHeader_Property_Transactions_DeedsMortgages.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := InsuranceHeader_Property_Transactions_DeedsMortgages.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(unsigned)ridstr);
mtchrnp := InsuranceHeader_Property_Transactions_DeedsMortgages.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(rid=(unsigned)ridstr),(unsigned)ridstr);
output( choosen(sort(mtchnp,-Conf),3),named('RecordMatches'));
output( choosen(sort(mtchrnp,-Conf),3),named('PreferredRecordMatches'));
mtch := InsuranceHeader_Property_Transactions_DeedsMortgages.Debug(BFile,s).AnnotateClusterMatches(odl,(unsigned)ridstr);
mtchr := InsuranceHeader_Property_Transactions_DeedsMortgages.Debug(BFile,s).AnnotateClusterMatches(odr+odl(rid=(unsigned)ridstr),(unsigned)ridstr);
output( choosen(sort(mtch,-Conf),3),named('RecordMatches_WithProps'));
output( choosen(sort(mtchr,-Conf),3),named('PreferredRecordMatches_WithProps'));
output( odl,named('DPROPTXIDValues'));
output( odr,named('PreferredDPROPTXIDValues'));
output( odl_noprop,named('DPROPTXIDValues_NoProp'));
output( odr_noprop,named('PreferredDPROPTXIDValues_NoProp'));
endmacro;
