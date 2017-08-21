import Address, Ut, lib_stringlib, _Control, business_header,_Validate;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Dell_Standardize_Input :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Dell) pRawFileInput) :=
	function
	
		Layouts.Temporary.StandardizeInput tPreProcessIndividuals(Layouts.Input.Dell l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
		address1 :=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(l.ADDR_LINE1	)
																					,stringlib.stringtouppercase(l.ADDR_LINE2	)
																					,''
																					,''
																					,''
																					,''
																					,''
																				); 
		address2 :=	Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(l.CITY				 	)	
																						,stringlib.stringtouppercase(l.STATE				)	
																						,stringlib.stringtouppercase(l.POSTAL_CODE	)
																				);
			Phone					:= 	ut.CleanPhone(l.AREA_CD + l.PHONE_NUM	);			
																							
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.address1														:= address1									;
			self.address2														:= address2									;
                                          
			self.unique_id													:= cnt											;
			
			self.clean_contact_name									:= []												;		
			self.Clean_address											:= []												;
			self.clean_phones.Phone									:= Phone										;
			
			self.rawfields													:= l												;
			self.summary_address										:= []												;
			self.summary_business										:= []												;
			self.summary_contact										:= []												;
			self.ace_aid														:= 0												;
			self.ace_aid_from_bdid									:= 0												;
			self.appended_fields										:= []												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessIndividuals(left,counter));
	
		return dPreProcess;

	end;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeName(dataset(Layouts.Temporary.StandardizeInput) pPreProcessInput) :=
	function

		Layouts.Temporary.StandardizeInput tStandardizeName(Layouts.Temporary.StandardizeInput l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean Name, determine if it is a person
			//////////////////////////////////////////////////////////////////////////////////////
			assembled_name 					:=					trim(l.rawfields.CONTACT_LAST_NAME		)
																+ ', '	+	trim(l.rawfields.CONTACT_FIRST_NAME 	)
																+ ' '		+	trim(l.rawfields.CONTACT_MIDDLE_NAME 	)
																;                

			clean_contact_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;

			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_contact_name										:= clean_contact_name	;

			self																			:= l									;
		end;
		
		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		return dStandardizedName;

	end;


	export fAll( dataset(Layouts.Input.Dell	)	pRawFileInput
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput);
		dStandardizeName		:= fStandardizeName			(dPreprocess	) : persist(Persistnames().DellfStandardizeName);
		
		return dStandardizeName;
	
	end;


end;
