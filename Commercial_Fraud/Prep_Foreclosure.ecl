import property,address,aid;
// should be only recent foreclosure, up till 6 months ago
export Prep_Foreclosure(

	 dataset(property.Layout_Fares_Foreclosure_v2) pForeclosure			= Property.File_Foreclosure_Base_v2
	,boolean																		pShouldRecaculatePersist	= _Dataset().ShouldRecaculatePersist
) := 
function

	// (trim(deed_category)='U') file_foreclosure_building -- active foreclosures
	// use recording_date for date of foreclosure
	// all records in this building file are current foreclosures
		dForeclosure_filt := Filters.fForeclosure(pForeclosure);	// active records

	//need ace_aid, phone, phone type(both types), listed name
	temp_lay :=
	record
		string address1;
		string address2;
		Layouts.Temporary.PrepForeclosure;
		unsigned8 Raw_AID;
		unsigned8 unique_id;
	end;
	
	temp_lay tPreProcessForeclosure(property.Layout_Fares_Foreclosure_v2 l, unsigned8 cnt) :=
	transform

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
		address1 :=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(l.situs1_prim_range	)
																					,stringlib.stringtouppercase(l.situs1_predir			)
																					,stringlib.stringtouppercase(l.situs1_prim_name		)
																					,stringlib.stringtouppercase(l.situs1_addr_suffix	)
																					,stringlib.stringtouppercase(l.situs1_postdir			)
																					,stringlib.stringtouppercase(l.situs1_unit_desig	)
																					,stringlib.stringtouppercase(l.situs1_sec_range		)
																				); 
		address2 :=	Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(l.situs1_v_city_name 	)	
																						,stringlib.stringtouppercase(l.situs1_st						)	
																						,stringlib.stringtouppercase(l.situs1_zip   				)
																				);

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////
																																											 
		self.address1														:= address1									;
		self.address2														:= address2									;
		self.ace_aid														:= 0												;		
		self.unique_id													:= cnt											;
		self.Raw_AID														:= 0												;
		self.date_of_foreclosure								:= (unsigned8)l.recording_date;
	end;
	
	dPreProcess := project(pForeclosure, tPreProcessForeclosure(left,counter));

	HasAddress		:= 		trim(dPreProcess.address1, left,right) != ''
									and trim(dPreProcess.address2, left,right) != '';
									
	dWith_address			:= dPreProcess(HasAddress);
	dWithout_address	:= dPreProcess(not(HasAddress));

	unsigned4	lFlags := AID.Common.eReturnValues.ACEAIDs;

	AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, Raw_AID, dwithAID, lFlags);
	
	dAID := project(
		dwithAID
		,transform(
			Layouts.Temporary.PrepForeclosure
			,self.ace_aid	:= left.aidwork_aceaid;
			 self					:= left;
		)
	)
	;
	
	daid_dedup := dedup(daid, ace_aid, all)
		: persist(persistnames().PrepForeclosure);
	
	return if(pShouldRecaculatePersist,daid_dedup,persists().PrepForeclosure);

end;