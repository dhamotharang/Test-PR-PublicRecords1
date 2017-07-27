	import iesp,GSA_Services,lib_stringlib,Autokey_batch, AutoStandardI;

	
	export Transforms := MODULE

//Layouts																									
		
		export layout_slim := Layouts.gsa_slim;
		export layout_output := Layouts.primary_record;
		export layout_w_penalty := Layouts.plus_penalty_primary_record;
		export layout_output_batch := Layouts.batch_out_rec;

//Denormalize to create child datasets for addresses, references and actions with Primary/Parent 												

		export layout_output denormalizeRecs(dataset(gsa_services.Layouts.basic_plus_penality) ds_parent,
																			dataset(gsa_services.Layouts.address_plus_penality) ds_caddresses,
																			dataset(Layouts.action) ds_cactions,
																			dataset(Layouts.reference) ds_creferences) := FUNCTION 
		
		//Transform primary with addresses
		layout_w_penalty setAddresses(layout_w_penalty l, Layouts.address_plus_penality r) := TRANSFORM
					self.Addresses := choosen(l.addresses + dataset([{
																										r.prim_range,
																										r.predir,
																										r.prim_name,
																										r.postdir,
																										r.addr_suffix,
																										r.unit_desig,
																										r.sec_range,
																										stringlib.StringCleanSpaces(r.prim_range + ' ' + r.predir  + ' ' + r.prim_name + ' ' + r.addr_suffix + ' ' + r.postdir  + ' ' + r.unit_desig + ' ' + r.sec_range),
																										'',//streetaddr2
																										if(r.p_city_name<>'',r.p_city_name,r.v_city_name),
																										r.st,
																										r.zip5,
																										r.zip4,
																										'',//county
																										'',//postalcode
																										'',//statecityzip
																										r.DUNS}],
																										iesp.gsaverification.t_GSAVerificationAddress),
														iesp.Constants.MAX_GSA_VERIFICATION_RESPONSE_ADDRS);
					
					self.addr_penalty := min(r.penalt);
					self := L;
		END;
		
		//Transform primary with references
		layout_w_penalty setReferences(layout_w_penalty L, Layouts.reference R) := TRANSFORM
					self.References := choosen(l.references + dataset([{r.name}],iesp.share.t_StringArrayItem),
					                           iesp.Constants.MAX_GSA_VERIFICATION_RESPONSE_REFERENCES);
					self := L;
		END;
		
		//Transform primary with actions
		layout_w_penalty setActions(layout_w_penalty L, Layouts.action R) := TRANSFORM
					termDateFlag := map(	r.termdateindefinite<>'' => GSA_Services.Constants.termdate_indefinite,
																r.termdatepermanent<>'' => GSA_Services.Constants.termdate_permanent,
																'');
																
					theActionDate := iesp.ECL2ESP.toDatestring8(R.ActionDate);					
					theTermDate := if(termDateFlag<>'',termDateFlag,R.TermDate);
					
					self.Actions := choosen(l.Actions + dataset([{
												                       theActionDate.year,theActionDate.month,theActionDate.day,
												                       theTermDate,
												                       R.CTCode,
												                       R.AgencyComponent}],
	                                             iesp.gsaverification.t_GSAVerificationAction),
											            iesp.Constants.MAX_GSA_VERIFICATION_RESPONSE_ACTIONS);
					self := L;								    
		end;
		
		//Transform primary 
		layout_w_penalty setPrimaryRecord(Layouts.basic_plus_penality L) := TRANSFORM
					//parent record
					self.gsa_id := l.gsa_id;
					self.acctno := l.acctno;
					self.search_status := l.search_status,
					self.matchCode := l.matchCode;
					self.Name := iesp.ECL2ESP.SetName(l.FName, l.MName, l.LName, l.name_suffix, '', l.FName+''+l.MName+''+l.LName+''+l.name_suffix);
					self.CompanyName := l.CompanyName;
					self.Classification := l.Classification;
					self.ExclusionType := l.CTType;
					self.name_penalty := l.penalt;
					self := [];
		END;
		
		layout_output applyPenalty(layout_w_penalty l) := TRANSFORM
				SELF.SearchId := l.acctno;
				SELF._Penalty := min(l.addr_penalty) + min(l.name_penalty);
			 SELF := l;															 																	 
		END;
		
		ds_tmp := project(ds_parent,setPrimaryRecord(left));
		ds_out1 := DENORMALIZE(ds_tmp, ds_caddresses,LEFT.gsa_id=RIGHT.gsa_id and LEFT.acctNo=Right.AcctNo,setAddresses(LEFT,RIGHT));
		ds_out2 := DENORMALIZE(ds_out1, ds_cactions,LEFT.gsa_id=RIGHT.gsa_id and LEFT.acctNo=Right.AcctNo,setActions(LEFT,RIGHT));
		ds_out3 := DENORMALIZE(ds_out2, ds_creferences,LEFT.gsa_id=RIGHT.gsa_id and LEFT.acctNo=Right.AcctNo,setReferences(LEFT,RIGHT));
		ds_plus_penality := sort(project(ds_out3,applyPenalty(left)),acctno);
																	
		//return parent record with child datasets populated.
		ds_outputRecs := ds_plus_penality;
		return ds_outputRecs;
	end;

//	Apply batch output transform.										
	export layout_output_batch xfm_GSA_make_flat(layout_output l) := TRANSFORM
		//Primary or Parent record.
		SELF.acctno := l.acctno;
		self._penalty := l._penalty;
		SELF.Name := if(stringlib.StringToUpperCase(l.Classification) <> GSA_Services.Constants.RECORD_TYPE_INDIVIDUAL,'',stringlib.StringCleanSpaces(l.name.last + ' , ' + l.name.first + ' ' + l.name.middle + ' ' +  l.name.suffix));
		self.CompanyName := l.CompanyName;
		SELF.lname := l.name.last;
		SELF.fname := l.name.first;
		SELF.mname := l.name.middle;
		SELF.Classification := l.Classification; 
		SELF.ExclusionType := l.ExclusionType; 
		
		//ADDRESSES
		SELF.Street1_1:= l.addresses[1].StreetAddress1;
		SELF.City_1:= l.addresses[1].city;						
		SELF.State_1:= l.addresses[1].state;	
		SELF.ZIP_1:= l.addresses[1].ZIP5;
		SELF.DUNS_1:= l.addresses[1].DunsNumber;
		
		SELF.Street1_2:= l.addresses[2].StreetAddress1;
		SELF.City_2:= l.addresses[2].city;						
		SELF.State_2:= l.addresses[2].state;	
		SELF.ZIP_2:= l.addresses[2].ZIP5;
		SELF.DUNS_2:= l.addresses[2].DunsNumber;
		
		SELF.Street1_3:= l.addresses[3].StreetAddress1;
		SELF.City_3:= l.addresses[3].city;						
		SELF.State_3:= l.addresses[3].state;	
		SELF.ZIP_3:= l.addresses[3].ZIP5;
		SELF.DUNS_3:= l.addresses[3].DunsNumber;
		
		SELF.Street1_4:= l.addresses[4].StreetAddress1;
		SELF.City_4:= l.addresses[4].city;						
		SELF.State_4:= l.addresses[4].state;	
		SELF.ZIP_4:= l.addresses[4].ZIP5;
		SELF.DUNS_4:= l.addresses[4].DunsNumber;
		
		SELF.Street1_5:= l.addresses[5].StreetAddress1;
		SELF.City_5:= l.addresses[5].city;						
		SELF.State_5:= l.addresses[5].state;	
		SELF.ZIP_5:= l.addresses[5].ZIP5;
		SELF.DUNS_5:= l.addresses[5].DunsNumber;
		
		//ACTIONS
		SELF.ActionDate_1:= iesp.ECL2ESP.t_DateToString8(l.actions[1].ActionDate);
		SELF.TerminationDate_1:= l.actions[1].TerminationDate;
		SELF.CauseTreatmentCode_1:= l.actions[1].CauseTreatmentCode;
		SELF.ImposingAgency_1:= l.actions[1].ImposingAgency;
		
		SELF.ActionDate_2:= iesp.ECL2ESP.t_DateToString8(l.actions[2].ActionDate);
		SELF.TerminationDate_2:= l.actions[2].TerminationDate;
		SELF.CauseTreatmentCode_2:= l.actions[2].CauseTreatmentCode;
		SELF.ImposingAgency_2:= l.actions[2].ImposingAgency;
		
		SELF.ActionDate_3:= iesp.ECL2ESP.t_DateToString8(l.actions[3].ActionDate);
		SELF.TerminationDate_3 := l.actions[3].TerminationDate;
		SELF.CauseTreatmentCode_3:= l.actions[3].CauseTreatmentCode;
		SELF.ImposingAgency_3:= l.actions[3].ImposingAgency;
		
		SELF.ActionDate_4:= iesp.ECL2ESP.t_DateToString8(l.actions[4].ActionDate);
		SELF.TerminationDate_4:= l.actions[4].TerminationDate;
		SELF.CauseTreatmentCode_4:= l.actions[4].CauseTreatmentCode;
		SELF.ImposingAgency_4:= l.actions[4].ImposingAgency;
		
		SELF.ActionDate_5:= iesp.ECL2ESP.t_DateToString8(l.actions[5].ActionDate);
		SELF.TerminationDate_5:= l.actions[5].TerminationDate;
		SELF.CauseTreatmentCode_5:= l.actions[5].CauseTreatmentCode;
		SELF.ImposingAgency_5:= l.actions[5].ImposingAgency;
		
		SELF.ActionDate_6:= iesp.ECL2ESP.t_DateToString8(l.actions[6].ActionDate);
		SELF.TerminationDate_6:= l.actions[6].TerminationDate;
		SELF.CauseTreatmentCode_6:= l.actions[6].CauseTreatmentCode;
		SELF.ImposingAgency_6:= l.actions[6].ImposingAgency;
		
		SELF.ActionDate_7:= iesp.ECL2ESP.t_DateToString8(l.actions[7].ActionDate);
		SELF.TerminationDate_7:= l.actions[7].TerminationDate;
		SELF.CauseTreatmentCode_7:= l.actions[7].CauseTreatmentCode;
		SELF.ImposingAgency_7:= l.actions[7].ImposingAgency;
		
		SELF.ActionDate_8:= iesp.ECL2ESP.t_DateToString8(l.actions[8].ActionDate);
		SELF.TerminationDate_8:= l.actions[8].TerminationDate;
		SELF.CauseTreatmentCode_8:= l.actions[8].CauseTreatmentCode;
		SELF.ImposingAgency_8:= l.actions[8].ImposingAgency;
		
		SELF.ActionDate_9:= iesp.ECL2ESP.t_DateToString8(l.actions[9].ActionDate);
		SELF.TerminationDate_9:= l.actions[9].TerminationDate;
		SELF.CauseTreatmentCode_9:= l.actions[9].CauseTreatmentCode;
		SELF.ImposingAgency_9:= l.actions[9].ImposingAgency;
		
		SELF.ActionDate_10:= iesp.ECL2ESP.t_DateToString8(l.actions[10].ActionDate);
		SELF.TerminationDate_10:= l.actions[10].TerminationDate;
		SELF.CauseTreatmentCode_10:= l.actions[10].CauseTreatmentCode;
		SELF.ImposingAgency_10:= l.actions[10].ImposingAgency;
		
		//REFERENCES
		SELF.reference_1:= l.references[1].value;
		SELF.reference_2:= l.references[2].value;
		SELF.reference_3:= l.references[3].value;
		SELF.reference_4:= l.references[4].value;
		SELF.reference_5:= l.references[5].value;
		SELF.reference_6:= l.references[6].value;
		SELF.reference_7:= l.references[7].value;
		SELF.reference_8:= l.references[8].value;
		SELF.reference_9:= l.references[9].value;
		SELF.reference_10:= l.references[10].value;
		SELF.reference_11:= l.references[11].value;
		SELF.reference_12:= l.references[12].value;
		SELF.reference_13:= l.references[13].value;
		SELF.reference_14:= l.references[14].value;
		SELF.reference_15:= l.references[15].value;
		SELF.reference_16:= l.references[16].value;
		SELF.reference_17:= l.references[17].value;
		SELF.reference_18:= l.references[18].value;
		SELF.reference_19:= l.references[19].value;
		SELF.reference_20:= l.references[20].value;
				
	end;

END;