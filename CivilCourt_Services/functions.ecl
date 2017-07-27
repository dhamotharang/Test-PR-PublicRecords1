import iesp, civil_court, ut, Census_Data;

export functions :=  module

export params := interface
  end;
    //
    // do the first project of the input dataset after the county name is added.
		// because of the nested structure of 3 datasets witin a larger dataset.
		// Parties DS
		// Activity DS
		// Matter DS
		// there are 3 projects done to setup the internal datasets.  The results of each
		// of these 3 projects are then placed into the final layout outer structure which
		// is the iesp.civilcourt.t_CivilCourtReportRecord 
		//	
	
export fnCivilCourtReportVal(dataset(civil_court.Layout_Roxie_Party) in_partyDS,
														 dataset(civil_court.Layout_Roxie_Case_Activity) in_activityDS,
														 dataset(civil_court.Layout_Roxie_Matter) in_matterDS,
														 params in_mod) := function
														 
   // add in the county name into the layout so that it can be put into final layout.
   temp_in_partyDS := project(in_partyDS, transform(civilcourt_services.layouts.PartyLayoutPlus,
	                            self.countyname := '',
	                            self := left));
															
   civilcourt_services.layouts.PartyLayoutPlus xform(civilcourt_services.layouts.PartyLayoutPlus l,
	                                                   Census_Data.Key_Fips2County r) := transform														 
														   self.countyname := r.county_name,
															 self := l
															end;
    
	 // apply county name conversion to in_partyDS dataset here.
	 // to populate county name may need to add a county name field here.
	 final_in_partyDS := join (temp_in_partyDS, Census_Data.Key_Fips2County,
	                            (LEFT.st1<>'') AND (LEFT.ace_fips_county1<>'') AND
                           (TRIM(left.st1) = right.state_code) and
                           (TRIM(left.ace_fips_county1) = right.county_fips), xform(LEFT, RIGHT),
														LEFT OUTER, Keep(1),
														limit(civilcourt_services.Constants.max_recs_on_civilCourt_join,skip));
														
    // sort 1st by Plaintiff, Attorney For Plaintiff, Defendant, Attorney For Defendant using numeric value in 
		// entity_type_code_1_master, and then
		// then reverse sort by entity_type_description_1_orig 
		final_in_partyDS_sorted := sort(final_in_partyDS, entity_type_code_1_master, -entity_type_description_1_orig, record);										 											 														 
		iesp.civilCourt.t_CivilCourtReportParty xform1(civilcourt_services.layouts.PartyLayoutPlus l) := transform 
			 
			 self.Ruling     := l.ruled_for_against,
			 self.PartyType  := l.entity_type_description_1_orig,
	     self.PartyName  := l.entity_1,
	     self.Address    := iesp.ECL2ESP.setAddress(l.prim_name1,l.prim_range1,l.predir1, l.postdir1,l.addr_suffix1,
			                              l.unit_desig1, l.sec_range1, l.v_city_name1, 
																		l.st1, l.zip1,l.zip41,l.countyname),
	     self.PartyType2 := '' , 
	     self.PartyName2 := '', 
	     self.Address2   := iesp.ECL2ESP.setAddress(l.prim_name2,l.prim_range2,l.predir2, l.postdir2,'',
			                              l.unit_desig2, l.sec_range2, l.v_city_name2, l.st2, l.zip2,l.zip42,''),
     end;

		Parties_final := project(final_in_partyDS_sorted, xform1(left));
		iesp.civilcourt.t_CivilCourtReportEvent xform2(civil_court.Layout_Roxie_Case_Activity l
																						) := transform              
			 self.Date.Year  := (integer2) l.event_date[1..4],
			 self.Date.Month := (integer2) l.event_date[5..6],
			 self.Date.Day   := (integer2) l.event_date[7..8],
			 self.EventType  := l.event_type_description_1,		   			 
     end;         
		 // set up the internal data set based on activity Data set.
		 // sort DS before populating final structure with data.
		in_activityDS_sorted := sort(in_activityDS, event_date);
    events_final := project(in_activityDS_sorted, xform2(left));

    iesp.civilcourt.t_CivilCourtReportFiling xform3(civil_court.Layout_Roxie_Matter l
		                                        ) := transform 
		   self.FilingDate.Year       := (integer2) l.filing_date[1..4],
			 self.FilingDate.Month      := (integer2)  l.filing_date[5..6],
			 Self.FilingDate.Day        := (integer2) l.filing_date[7..8],
			 self.FilingManner          := l.manner_of_filing,
			 self.JudgmentDate.Year     := (integer2) l.judgmt_date[1..4],
			 self.JudgmentDate.Month    := (integer2) l.judgmt_date[5..6],
			 self.JudgmentDate.Day      := (integer2) l.judgmt_date[7..8],
			 self.JudgmentManner        := l.manner_of_judgmt,
			 self.JudgmentType          := l.judgmt_type,
			 self.JudgmentDisposition   := l.judgmt_disposition,
			 self.DispositionDate.Year  := (integer2) l.disposition_date[1..4],
			 self.DispositionDate.Month := (integer2) l.disposition_date[5..6],
			 self.DispositionDate.Day   := (integer2) l.disposition_date[7..8],
			 self.Disposition           := l.disposition_description,
			 self.SuitAmount            := l.suit_amount,
			 self.AwardAmount           := l.award_amount,
			 self.Cause                 := l.case_cause, 
			 self.Ruling                := l.ruled_for_against 		 			 		  
		end;
		
		 // set up the internal data set named filings.
		 Filings_final := project(in_matterDS, xform3(left));		 
		 
		 iesp.civilcourt.t_CivilCourtReportRecord xform4(civilcourt_services.layouts.PartyLayoutPlus l,
		                          dataset (iesp.civilcourt.t_CivilCourtReportParty) param_Parties_final,
															dataset (iesp.civilcourt.t_CivilCourtReportEvent) param_Events_final,
															dataset (iesp.civilcourt.t_CivilCourtReportFiling) param_Filings_final
															) := transform 		 
				self.CaseTitle   := l.case_title,
				self.CaseType    := l.case_Type,
				self.CaseNumber  := l.Case_Number,
				self.State    := ut.St2Name(l.state_origin),
				self.Court    := l.Court,
				self.Parties  := param_parties_final,
				self.Events   := param_events_final,
				self.Filings  := param_Filings_final							  
			end;
	    
			// wait till now to dedup otherwise miss populating the parties in the final structure.
			//
			final_in_partyDS_deduped := dedup(sort(final_in_partyDS, case_key), case_key);
	    report_final := project(final_in_partyDS_deduped, xform4(left, Parties_final, Events_final, Filings_final));			
			// output(parties_final,named('parties_final'));
			// output(report_final,named('report_final'));
			// output(final_in_partyDS_deduped,named('final_in_partyDS_deduped'));
			//output(final_in_partyDS_sorted,named('final_in_partyDS_sorted'));
			return report_final;
   end; // function
	 
	 // function used for the civil court search
	 
    export fnCivilCourtSearchVal(dataset(CivilCourt_services.Layouts.partylayoutPlus) in_recs, params in_mod) := function
    
		iesp.civilcourt.t_CivilCourtSearchRecord  xform(CivilCourt_services.Layouts.partylayoutPlus l)
																	:= TRANSFORM																															
			self.CaseTitle             := l.case_title,
			self.CaseId                := l.case_key,
			self.CaseType              := l.case_type,
			self.PartyType             := l.entity_type_description_1_orig,
			self.PartyName             := if (l.entity_1 <> '', 
			                              l.entity_1,
															       l.v1_fname1 + '' + l.v1_mname1 + '' + l.v1_lname1 + ' ' + l.v1_suffix1),
			self.City                  := l.v_city_name1,
			self.State                 := l.st1,
			self.StateOfOrigin         :=  ut.St2Name(l.state_origin),
			self.Jurisdiction          := l.court,
			self.PrimaryEntity         := l.primary_entity_2,
			self.EntityTypeDescription := l.entity_type_description_1_orig,
			self.EntityAddresses       := dataset([{l.entity_1_address_1},
																			{l.entity_1_address_2},
																		  {l.entity_1_address_3},
																			{l.entity_1_address_4},
																				{l.entity_2_address_1},
																				{l.entity_2_address_2},
																				{l.entity_2_address_3},
																				{l.entity_2_address_4}
																				],  iesp.share.t_StringArrayItem), 																					   	
	      self._penalty  := 0,
	      self.AlsoFound := false,
			 END;
			 
       temp_final := project(in_recs, xform(left));			
			 
			 // this sorts case titles with blank to the end and then does alphbetical sort by casetitle
			 // since boolean false sorts above boolean true.
			 final_result := sort(temp_final, if (caseTitle = '',1,0), caseTitle, partyType, partyName,
			                                                                     stateOforigin, record);			                      
			 return final_result;
	end; // function
 end; // module