/*--SOAP--
<message name="EmpIDSliceOutService">
<part name="BaseEmpID" type="xsd:string"/>
<part name="Basercid" type="xsd:string"/>
<part name="PreferredEmpID" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if Basercid should be plucked out of BaseEmpID. If a preferred EmpID is provided it will be compared to the RID too.*/
export EmpIDSliceOutService := MACRO
  IMPORT SALT28,BIPV2_EMPID_DOWN_Platform;
string20 rcidstr := ''  : stored('Basercid');
string20 EmpIDstr := ''  : stored('BaseEmpID');
string20 Pref_EmpIDstr := ''  : stored('PreferredEmpID');
BFile := BIPV2_EMPID_DOWN_Platform.In_EmpID;
BIPV2_EMPID_DOWN_Platform.match_candidates(BFile).layout_candidates into(BIPV2_EMPID_DOWN_Platform.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(BIPV2_EMPID_DOWN_Platform.Keys(BFile).Candidates(EmpID=(unsigned)EmpIDstr),10000),into(left));
odr := project(choosen(BIPV2_EMPID_DOWN_Platform.Keys(BFile).Candidates(EmpID=(unsigned)Pref_EmpIDstr),10000),into(left));
k := BIPV2_EMPID_DOWN_Platform.Keys(BFile).Specificities_Key;
BIPV2_EMPID_DOWN_Platform.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odl_noprop := BIPV2_EMPID_DOWN_Platform.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := BIPV2_EMPID_DOWN_Platform.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := BIPV2_EMPID_DOWN_Platform.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(unsigned)rcidstr);
mtchrnp := BIPV2_EMPID_DOWN_Platform.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtchnp,-Conf),3),named('RecordMatches'));
output( choosen(sort(mtchrnp,-Conf),3),named('PreferredRecordMatches'));
mtch := BIPV2_EMPID_DOWN_Platform.Debug(BFile,s).AnnotateClusterMatches(odl,(unsigned)rcidstr);
mtchr := BIPV2_EMPID_DOWN_Platform.Debug(BFile,s).AnnotateClusterMatches(odr+odl(rcid=(unsigned)rcidstr),(unsigned)rcidstr);
output( choosen(sort(mtch,-Conf),3),named('RecordMatches_WithProps'));
output( choosen(sort(mtchr,-Conf),3),named('PreferredRecordMatches_WithProps'));
output( odl,named('EmpIDValues'));
output( odr,named('PreferredEmpIDValues'));
output( odl_noprop,named('EmpIDValues_NoProp'));
output( odr_noprop,named('PreferredEmpIDValues_NoProp'));
endmacro;
 
