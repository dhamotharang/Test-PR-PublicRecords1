import doxie,data_services;

rExceptionKey := RECORD
  string2 	sourceprogramstate;
  string1 	sourceprogramcode;
  string20 	sourceclientid;
  string4 	sourcegroupid;
  string2 	matchedstate;
  string1 	matchedprogramcode;
  string20 	matchedclientid;
  string4 	matchedgroupid;
  string3 	reasoncode;
  string50 	comments;
 END;


d1 := PROJECT(Files2.dsExceptionRecords(replaced=0),rExceptionKey);
																							
d2 := NORMALIZE(d1(SourceProgramState=MatchedState and SourceProgramCode=MatchedProgramCode), 2, TRANSFORM({d1},
										self.MatchedClientId := CHOOSE(COUNTER, left.MatchedClientId, left.SourceClientId);
										self.SourceClientId := CHOOSE(COUNTER, left.SourceClientId, left.MatchedClientId);
										self.MatchedGroupId := CHOOSE(COUNTER, left.MatchedGroupId, left.SourceGroupId);
										self.SourceGroupId := CHOOSE(COUNTER, left.SourceGroupId, left.MatchedGroupId);
										self := left;));
										
d3 := d2 + d1(SourceProgramState<>MatchedState or SourceProgramCode<>MatchedProgramCode);

d4 := NORMALIZE(d3(SourceProgramCode='S',MatchedProgramCode='S'), 4, TRANSFORM({d1},
										self.SourceProgramCode := CHOOSE(COUNTER, 'S', 'S', 'D', 'D');
										self.MatchedProgramCode := CHOOSE(COUNTER, 'S', 'D', 'S', 'D');
										self := left;));

d5 := d4 + d3(SourceProgramCode<>'S' OR MatchedProgramCode<>'S');		

d := DEDUP(d5, RECORD, ALL);						

export key_Exception := INDEX(d, {SourceProgramState
														,SourceProgramCode
														,SourceClientId
														,SourceGroupId
														,MatchedState
														,MatchedProgramCode
														,MatchedClientId
														,MatchedGroupId
															}, {d}, 
						data_services.Data_Location.Prefix('DEFAULT')+'thor::NAC2::key::exception_' + doxie.version_superkey);
