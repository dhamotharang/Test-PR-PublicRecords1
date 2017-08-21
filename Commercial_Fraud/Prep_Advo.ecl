import advo, address,aid;

export Prep_Advo(

	dataset(Advo.Layouts.Layout_Common_Out	) pAdvo	= Advo.Files().File_Cleaned_Base

) :=
function

	dAdvo_active := pAdvo(Active_flag = 'Y');
	
//	dAdvo_Residential	:= pAdvo(Residential_or_Business_Ind in ['A','B','C','D','E','F','G','H']	,Active_flag = 'Y');
//	dAdvo_Seasonal		:= pAdvo(Seasonal_Delivery_Indicator	= 'Y'				,Active_flag = 'Y');
//	dAdvo_Vacant			:= pAdvo(Address_Vacancy_Indicator		= 'Y'				,Active_flag = 'Y');
//	College_Indicator = 'Y'
//     string1		Record_Type_Code				;

/*
"A = Residential       C = Primary Residential with Business 
B = Business           D = Primary Business with Residential "
*/
	//need ace_aid, phone, phone type(both types), listed name
	temp_lay :=
	record
		Layouts.Temporary.PrepAdvo;
		unsigned8 Raw_AID;
		unsigned8 unique_id;
	end;
	
	temp_lay tPreProcessAdvo(Advo.Layouts.Layout_Common_Out l, unsigned8 cnt) :=
	transform

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
		address1 :=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(l.prim_range		)
																					,stringlib.stringtouppercase(l.predir				)
																					,stringlib.stringtouppercase(l.prim_name		)
																					,stringlib.stringtouppercase(l.addr_suffix	)
																					,stringlib.stringtouppercase(l.postdir			)
																					,stringlib.stringtouppercase(l.unit_desig		)
																					,stringlib.stringtouppercase(l.sec_range		)
																				); 
		address2 :=	Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(l.v_city_name 	)	
																						,stringlib.stringtouppercase(l.st						)	
																						,stringlib.stringtouppercase(l.zip   				)
																				);

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		//////////////////////////////////////////////////////////////////////////////////////
																																											 
		self.address1														:= address1									;
		self.address2														:= address2									;
		self.ace_aid														:= 0												;		
		self.business_residential								:= map(	 l.Residential_or_Business_Ind	in ['A','C'] => 'R'
																										,l.Residential_or_Business_Ind	in ['B','D'] => 'B'
																										,''
																									);
		self.vacant_property										:= if(l.Address_Vacancy_Indicator		= 'Y','Y','N');										;		
		self.Seasonal_Delivery_Indicator 				:= if(l.Seasonal_Delivery_Indicator	= 'Y','Y','N');					
		self.college                     				:= if(l.College_Indicator						= 'Y','Y','N');			
		self.cmra                     					:= if(l.Drop_Indicator							= 'C','Y','N');	
		self.Record_Type_Code										:= l.Record_Type_Code;

		self.unique_id													:= cnt											;
		self.Raw_AID														:= 0												;
	end;
	
	dPreProcess := project(dAdvo_active, tPreProcessAdvo(left,counter));

	HasAddress		:= 		trim(dPreProcess.address1, left,right) != ''
									and trim(dPreProcess.address2, left,right) != '';
									
	dWith_address			:= dPreProcess(HasAddress);
	dWithout_address	:= dPreProcess(not(HasAddress));

	unsigned4	lFlags := AID.Common.eReturnValues.ACEAIDs;

	AID.MacAppendFromRaw_2Line(dWith_address, Address1, Address2, Raw_AID, dwithAID, lFlags);
	
	dAID := project(
		dwithAID
		,transform(
			Layouts.Temporary.PrepAdvo
			,self.ace_aid	:= left.aidwork_aceaid;
			 self					:= left;
		)
	)
	;	
	
	ddedup_aid := dedup(dAID	,ace_aid,all)
		: persist(persistnames().PrepAdvo);
	
	return ddedup_aid;

end;