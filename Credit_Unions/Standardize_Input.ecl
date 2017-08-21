import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid,idl_header;

// -- add unique id
// -- standardize name
// -- normalize and slim record for address cleaning, keep unique id
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates

export Standardize_Input :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Sprayed) pRawFileInput, string pversion) :=
	function
	
		Layouts.Temporary.StandardizeInput tPreProcess(Layouts.Input.Sprayed l, unsigned8 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	
						stringlib.stringtouppercase(trim(l.Address1				))
					;        
			address2 :=	if(trim(l.City) <> '',
										stringlib.stringtouppercase(
																trim(l.City		 )
											+ ', '	+ trim(l.State	 )
											+ ' '		+ trim(l.Zip_Code)[1..5]
											),
										stringlib.stringtouppercase(
															trim(l.State	 )
										+ ' '		+ trim(l.Zip_Code)[1..5]
										)
									);                


			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
																																												 
			self.Prep_Addr_Line1										:= address1									;
			self.Prep_Addr_Line_Last								:= address2									;
                                          
			self.unique_id													:= cnt											;
			self.record_type												:= 'C'											;
			
			self.dt_vendor_first_reported						:= (unsigned4)pversion			;
			self.dt_vendor_last_reported						:= (unsigned4)pversion			;

			self.clean_contact_name									:= []												;		
			self.Clean_address											:= []												;
			self.rawfields													:= l												;
			self																		:= []												;
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcess(left,counter));
	
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
			assembled_name 					:= trim(l.rawfields.Contact_Name		);                

			clean_contact_name			:= Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;

			                                                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.clean_contact_name									:= clean_contact_name	;

			self																		:= l									;
		end;

		dStandardizedName := project(pPreProcessInput, tStandardizeName(left));
		
		ut.mac_flipnames(dStandardizedName, clean_contact_name.fname, clean_contact_name.mname, clean_contact_name.lname, dStandardizedName_flipnames)

		return dStandardizedName_flipnames;

	end;

	export fAll( 
		 dataset(Layouts.Input.Sprayed	)	pRawFileInput
		,string														pversion
		,string														pPersistname = persistnames().StandardizeInput
	) :=
	function
	
		dPreprocess					:= fPreProcess					(pRawFileInput,pversion	);
		dStandardizeName		:= fStandardizeName			(dPreprocess						);

		dback2base :=  project(dStandardizeName, transform(layouts.base, self := left))
			 : persist(pPersistname);
		
		return dback2base;
	
	end;


end;
