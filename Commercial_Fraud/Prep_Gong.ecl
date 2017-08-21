import Phonesplus,address,aid,yellowpages,gong,gong_v2,cellphone,risk_indicators;

export Prep_Gong(

	dataset(Gong_v2.layout_gongMaster	) pEda	= gong_v2.file_gongmaster
	,boolean														pShouldRecaculatePersist	= _Dataset().ShouldRecaculatePersist

) :=
function

	dEda_filt := Filters.fEda(pEda);	// active records

	//need ace_aid, phone, phone type(both types), listed name
	temp_lay := record
	
		Layouts.Temporary.PrepPhonesPlus;
		unsigned8 Raw_AID;
		string		string_phone;
	end;
	
	temp_lay tPreProcessPhonesPlus(Gong_v2.layout_gongMaster l, unsigned8 cnt) :=
	transform

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
		address1 :=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(l.prim_range	)
																					,stringlib.stringtouppercase(l.predir			)
																					,stringlib.stringtouppercase(l.prim_name	)
																					,stringlib.stringtouppercase(l.suffix			)
																					,stringlib.stringtouppercase(l.postdir		)
																					,stringlib.stringtouppercase(l.unit_desig	)
																					,stringlib.stringtouppercase(l.sec_range	)
																				); 
		address2 :=	Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(l.v_city_name 	)	
																						,stringlib.stringtouppercase(l.st						)	
																						,stringlib.stringtouppercase(l.z5    				)
																				);

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////
																																											 
		self.address1														:= address1									;
		self.address2														:= address2									;
		self.listed_name												:= l.company_name						;
		self.listing_type												:= map(
																								  l.listing_type_res != '' => 'R' 
																								 ,l.listing_type_bus != '' => 'B' 
																								 ,l.listing_type_gov != '' => 'G' 
																								,''
																							);
		self.phone_type													:= ''												;	//not necessarily right
		self.phone															:= (unsigned8)l.phone10			;
		self.ace_aid														:= 0												;		
		self.unique_id													:= cnt											;
		self.Raw_AID														:= 0												;
		self.string_phone												:= l.phone10								;
	end;
	
	dPreProcess := project(dEda_filt, tPreProcessPhonesPlus(left,counter));

	HasAddress		:= 		trim(dPreProcess.address1, left,right) != ''
									and trim(dPreProcess.address2, left,right) != '';
									
	dWith_address			:= dPreProcess(HasAddress);
	dWithout_address	:= dPreProcess(not(HasAddress));

	unsigned4	lFlags := AID.Common.eReturnValues.ACEAIDs;

	AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, Raw_AID, dwithAID, lFlags);
	
	dAID := project(
		dwithAID
		,transform(
			temp_lay
			,self.ace_aid	:= left.aidwork_aceaid;
			 self					:= left;
		)
	)
	;
	
	// Add phone type
	yellowpages.NPA_PhoneType(dAID,string_phone,phone_type2,dPhoneType);
	
	dphone_type_proj := project(dPhoneType, transform(Layouts.Temporary.PrepPhonesPlus, self.phone_type := left.phone_type2, self := left))
		:persist(persistnames().PrepGong);
	
	return if(pShouldRecaculatePersist,dphone_type_proj,persists().PrepGong);
	
end;