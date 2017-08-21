/*--SOAP--
<message name="LNPIDSliceOutService">
<part name="BaseLNPID" type="xsd:string"/>
<part name="BaseRID" type="xsd:string"/>
<part name="PreferredLNPID" type="xsd:string"/>
</message>
*/
/*--INFO-- Look to see if BaseRID should be plucked out of BaseLNPID. If a preferred LNPID is provided it will be compared to the RID too.*/
export LNPIDSliceOutService := MACRO
  IMPORT SALT29,HealthCareProviderHeader;
string20 RIDstr := ''  : stored('BaseRID');
string20 LNPIDstr := ''  : stored('BaseLNPID');
string20 Pref_LNPIDstr := ''  : stored('PreferredLNPID');
BFile := HealthCareProviderHeader.In_HealthProvider;
HealthCareProviderHeader.match_candidates(BFile).layout_candidates into(HealthCareProviderHeader.Keys(BFile).Candidates le) := transform
  self := le;
end;
odl := project(choosen(HealthCareProviderHeader.Keys(BFile).Candidates(LNPID=(unsigned)LNPIDstr),10000),into(left));
odr := project(choosen(HealthCareProviderHeader.Keys(BFile).Candidates(LNPID=(unsigned)Pref_LNPIDstr),10000),into(left));
k := HealthCareProviderHeader.Keys(BFile).Specificities_Key;
HealthCareProviderHeader.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
s := global(project(k,s_into(left))[1]);
odl_noprop := HealthCareProviderHeader.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
odr_noprop := HealthCareProviderHeader.Debug(BFile,s).RemoveProps(odr); // Remove propogated values
mtchnp := HealthCareProviderHeader.Debug(BFile,s).AnnotateClusterMatches(odl_noprop,(unsigned)RIDstr);
mtchrnp := HealthCareProviderHeader.Debug(BFile,s).AnnotateClusterMatches(odr_noprop+odl_noprop(RID=(unsigned)RIDstr),(unsigned)RIDstr);
output( choosen(sort(mtchnp,-Conf),3),named('RecordMatches'));
output( choosen(sort(mtchrnp,-Conf),3),named('PreferredRecordMatches'));
mtch := HealthCareProviderHeader.Debug(BFile,s).AnnotateClusterMatches(odl,(unsigned)RIDstr);
mtchr := HealthCareProviderHeader.Debug(BFile,s).AnnotateClusterMatches(odr+odl(RID=(unsigned)RIDstr),(unsigned)RIDstr);
output( choosen(sort(mtch,-Conf),3),named('RecordMatches_WithProps'));
output( choosen(sort(mtchr,-Conf),3),named('PreferredRecordMatches_WithProps'));
output( odl,named('LNPIDValues'));
output( odr,named('PreferredLNPIDValues'));
output( odl_noprop,named('LNPIDValues_NoProp'));
output( odr_noprop,named('PreferredLNPIDValues_NoProp'));
endmacro;
