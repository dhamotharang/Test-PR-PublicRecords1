import civil_court;

export Raw := module

		export civil_court.Layout_roxie_party  byCaseIDParty(string60 in_casekey) := function
		
				caseKeyDS1 := dataset([{(string60) in_casekey}],civilCourt_services.layouts.caseIDLayout);
				
				partySet := join(caseKeyDS1, civil_court.key_caseID,
											keyed(left.case_key = right.case_key),
											transform(civil_court.Layout_Roxie_Party,														 
											self := right), 
											limit(civilCourt_services.constants.max_recs_on_civilCourt_join, skip));
				
				return PartySet;			 
		end;
			 
		export  civil_court.Layout_Roxie_case_activity  byCaseIDActivity(string60 in_casekey) := function	
					
					caseKeyDS2 := dataset([{(string60) in_casekey}],civilCourt_services.layouts.caseIDLayout);
					
					ActivitySet := join(caseKeyDS2, civil_court.key_caseID_activity,
				               keyed(left.case_key = right.case_key),
											 transform(civil_court.Layout_Roxie_Case_Activity,
											 self := right),
											 limit(civilcourt_services.constants.max_recs_on_civilCourt_join, skip));
							 
				return ActivitySet;	
		end;
		
			 
		export  civil_court.Layout_Roxie_Matter    byCaseIDMatter(string60 in_casekey) := function
		
				caseKeyDS3 := dataset([{(string60) in_casekey}],civilCourt_services.layouts.caseIDLayout);
					
	      MatterSet := join(caseKeyDS3, civil_court.key_caseID_matter,
					             keyed(left.case_key = right.case_key),
											 transform(civil_court.Layout_Roxie_Matter,
											 self := right),
											 limit(civilcourt_services.constants.max_recs_on_civilCourt_join, skip));
     
			  return MatterSet;
		end;	                    													        											
		
end;