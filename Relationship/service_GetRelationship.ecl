/*--SOAP--
  <message name="service_GetRelationship">
	<part name="DID"                    type="unsignedInt"/>
  <part name="Total_Candidates"       type="unsignedInt"/>
  <part name="Count_Wanted"           type="unsignedInt"/>
  <part name="Relatives_Only"         type="xsd:boolean"    cols="1"  rows="1" />
  <part name="Associates_Only"        type="xsd:boolean"    cols="1"  rows="1" />
  <part name="All"                    type="xsd:boolean"    cols="1"  rows="1" />
  <part name="Transactional_Only"     type="xsd:boolean"    cols="1"  rows="1" />
  <part name="Skip_On_Count_Exceeded" type="xsd:boolean"    cols="1"  rows="1" />
  <part name="Atmost_On_Count_Exceeded" type="xsd:boolean"    cols="1"  rows="1" />
  <part name="Fail_On_Count_Exceeded" type="xsd:boolean"    cols="1"  rows="1" />
  <part name="Same_Lname_Only"        type="xsd:boolean"    cols="1"  rows="1" />
  <part name="Minimum_Score"          type="unsignedInt"/>
  <part name="Recent_Relative_Date"   type="unsignedInt"/>
  <part name="Did2"                   type="unsignedInt"/>
  <part name="Exclude_Inactives"      type="xsd:boolean"    cols="1"  rows="1" />
  <part name="Exclude_TransClosure2"  type="xsd:boolean"    cols="1"  rows="1" />
  <part name="TransactionalFlags"     type="tns:Xmlrow"     cols="70" rows="5" />
  <part name="Append_Names"           type="xsd:boolean"    cols="1"  rows="1" />
  <part name="Legacy_Format"          type="xsd:boolean"    cols="1"  rows="1" />
  <part name="High_Confidence_Relatives"  type="xsd:boolean"    cols="1"  rows="1" />
  <part name="High_Confidence_Associates" type="xsd:boolean"    cols="1"  rows="1" />
  <part name="Relationship_Lookback_Months"    type="xsd:unsignedInt"/>
  </message>
*/
								
import Relationship, doxie, Header, watchdog;

EXPORT service_GetRelationship() := FUNCTION
  unsigned6 input_DID   := 0           : stored('DID');
	boolean   Add_Names   := FALSE       : stored('Append_Names');
	boolean   Show_Legacy := FALSE       : stored('Legacy_Format');
	boolean   Rel_Flag    := FALSE       : stored('Relatives_Only');
	boolean   Assoc_Flag  := FALSE       : stored('Associates_Only');
	boolean   All_Flag    := FALSE       : stored('All');
	boolean   Tx_Flag     := FALSE       : stored('Transactional_Only');
	unsigned2 MaxCount    := 100         : stored('Total_Candidates');
	unsigned2 TopNCount   := 100         : stored('Count_Wanted');
	boolean   doSkip      := FALSE       : stored('Skip_On_Count_Exceeded');
	boolean   doAtMost    := FALSE       : stored('Atmost_On_Count_Exceeded');
	boolean   doFail      := FALSE       : stored('Fail_On_Count_Exceeded');
	boolean   sameLname   := FALSE       : stored('Same_Lname_Only');
	unsigned2 minScore    := 0           : stored('Minimum_Score');
	unsigned4 recentRel   := 0           : stored('Recent_Relative_Date');
	unsigned8 person2     := 0           : stored('Did2');
  boolean   excludeTC2  := FALSE       : stored('Exclude_TransClosure2');
	boolean   excludeInactives := FALSE  : stored('Exclude_Inactives');  
  boolean   HighConfidenceRelatives  := FALSE  : stored('High_Confidence_Relatives');  
	boolean   HighConfidenceAssociates := FALSE  : stored('High_Confidence_Associates');  
	unsigned2 RelLookbackMonths := 0       : stored('Relationship_Lookback_Months');  
	addlFlags  := DATASET([],Layout_GetRelationship.TransactionalFlags_layout)	: stored('TransactionalFlags');
  didRec     := DATASET([{input_DID}],Layout_GetRelationship.DIDs_layout); 
	
	RecCount   := IF(MaxCount=0,100,MaxCount);
	NCount     := IF(TopNCount=0,100,TopNCount);

  result        := Relationship.Proc_GetRelationship(didrec,Rel_Flag,Assoc_Flag,All_Flag,Tx_Flag,RecCount,NCount,doSkip,doFail,doAtmost,
	                                      sameLname,minScore,recentRel,person2,excludeTC2,excludeInactives,,
																				HighConfidenceRelatives,HighConfidenceAssociates,RelLookbackMonths,
																				addlFlags[1]).Result;
  result_legacy := Relationship.Proc_GetRelationship(didrec,Rel_Flag,Assoc_Flag,All_Flag,Tx_Flag,RecCount,NCount,doSkip,doFail,doAtmost,
	                                      sameLname,minScore,recentRel,person2,excludeTC2,excludeInactives,,
																				HighConfidenceRelatives,HighConfidenceAssociates,RelLookbackMonths,
																				addlFlags[1]).Legacy;

nrec := record
  string20 title_str;
  string28 fname;
  string28 mname;
	string28 lname;
	result;
end;
nrec2 := record
  string20 title_str;
  string28 fname;
  string28 mname;
	string28 lname;
	result_legacy;
end;
segkey     := watchdog.Key_Watchdog_glb;
NamesAdded := join(result,segkey,
                   keyed(left.did2 = right.did),
									 transform(nrec,
									           self.fname := right.fname,
														 self.mname := right.mname,
														 self.lname := right.lname,
														 self.title_str := Header.relative_titles.fn_get_str_title(left.title);
														 self := left));
NamesAdded2 := join(result_legacy,segkey,
                   keyed(left.person2 = right.did),
									 transform(nrec2,
									           self.fname := right.fname,
														 self.mname := right.mname,
														 self.lname := right.lname,
														 self.title_str := Header.relative_titles.fn_get_str_title(left.rel_title[1].title);
														 self := left));

IF(Add_Names AND not Show_Legacy,output(NamesAdded,named('Names_and_Title_String_added_for_display_purposes_only')));
IF(NOT Add_Names AND not Show_Legacy,output(result,named('Interface_results')));			
IF(Add_Names AND Show_Legacy,output(NamesAdded2,named('Names_and_Title_String_added_for_display_purposes_only_Legacy')));
IF(NOT Add_Names AND Show_Legacy,output(result_legacy,named('Interface_Legacy_results')));			

RETURN true;
END;