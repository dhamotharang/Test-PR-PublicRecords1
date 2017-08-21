import Phonesplus,address,aid,yellowpages,gong,cellphone,risk_indicators;

export Prep_PhonesPlus(

	dataset(Phonesplus.layoutCommonOut	)	pPhonesPlus	= Phonesplus.file_phonesplus_base
	,boolean																	pShouldRecaculatePersist	= _Dataset().ShouldRecaculatePersist

) :=
function
	
	dPhonesPlus_filt := Filters.fPhonesPlus(pPhonesPlus);	// active records

	//need ace_aid, phone, phone type(both types), listed name
	temp_lay := record
	
		Layouts.Temporary.PrepPhonesPlus;
		unsigned8 Raw_AID;
		string		string_phone;
	end;
	
	temp_lay tPreProcessPhonesPlus(Phonesplus.layoutCommonOut l, unsigned8 cnt) :=
	transform

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
		address1 :=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(l.Address1	)
																					,stringlib.stringtouppercase(l.Address2	)
																					,stringlib.stringtouppercase(l.Address3	)
																					,''	 
																					,''	 	
																					,''
																					,''	 	
																				); 
		address2 :=	Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(l.OrigCity 	)	
																						,stringlib.stringtouppercase(l.OrigState	)	
																						,stringlib.stringtouppercase(trim(l.OrigZip)[1..5]    )
																				);

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////
																																											 
		self.address1														:= address1									;
		self.address2														:= address2									;
		self.listed_name												:= l.OrigName								;
		self.listing_type												:= map(
																								 trim(l.ListingType, left, right) in ['R','BR','RS'	] => 'R' 
																								,trim(l.ListingType, left, right) in ['B','BG','BR'	] => 'B'
																								,trim(l.ListingType, left, right) in ['G','BG'			]	=> 'G'
																								,''
																							);
		self.phone_type													:= l.phonemodel							;	//not necessarily right
		self.phone															:= (unsigned8)l.cellphone		;
		self.ace_aid														:= 0												;		
		self.unique_id													:= cnt											;
		self.Raw_AID														:= 0												;
		self.string_phone												:= l.cellphone							;
	end;
	
	dPreProcess := project(dPhonesPlus_filt, tPreProcessPhonesPlus(left,counter));

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
		:persist(persistnames().PrepPhonesPlus);

	return if(pShouldRecaculatePersist,dphone_type_proj,persists().PrepPhonesPlus);
	
end;