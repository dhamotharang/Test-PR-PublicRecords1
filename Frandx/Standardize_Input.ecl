import Address, Ut, lib_stringlib, _Control, _Validate;

export Standardize_Input :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Layouts.Input.Sprayed) pRawFileInput, string pversion) :=
	function
	
		Layouts.base tPreProcessIndividuals(Layouts.Input.Sprayed l) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			addr1 :=	stringlib.stringcleanspaces(
										ut.CleanSpacesAndUpper(l.Address1)
						+ ' ' + ut.CleanSpacesAndUpper(l.Address2)
						);        
			addr2 :=	stringlib.stringcleanspaces(	
										ut.CleanSpacesAndUpper(l.City		)
					+ if (trim(l.City) <> '',', ','')	+ ut.CleanSpacesAndUpper(l.State		)
					+ ' '		+ ut.CleanSpacesAndUpper(l.Zip_Code)
					);                

			Cln_Phone						:= 	ut.CleanPhone(l.Phone							);			
			Cln_SecondaryPhone	:= 	ut.CleanPhone(l.Secondary_Phone		);			
																							
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////																																												 
			self.prep_addr_line1										:= addr1;
			self.prep_addr_line_last								:= addr2;
			
			CleanDate																:= ut.date_slashed_MMDDYYYY_to_YYYYMMDD(l.frn_start_date);
                                          
			self.dt_first_seen											:= if(_validate.date.fIsValid(CleanDate),(unsigned4)CleanDate, 0);
			self.dt_last_seen												:= if(_validate.date.fIsValid(CleanDate),(unsigned4)CleanDate, 0);
			self.dt_vendor_first_reported						:= (unsigned4)pversion;
			self.dt_vendor_last_reported						:= (unsigned4)pversion;
						
			self.Franchisee_Id											:= trim(l.Franchisee_Id,left,right);
			self.Fruns															:= trim(l.Fruns,left,right);
			self.Brand_Name													:= ut.CleanSpacesAndUpper(l.Brand_Name);
			self.Company_Name												:= ut.CleanSpacesAndUpper(l.Company_Name);
			self.Exec_Full_Name											:= ut.CleanSpacesAndUpper(l.Exec_Full_Name);
			self.Address1														:= ut.CleanSpacesAndUpper(l.Address1);
			self.Address2														:= ut.CleanSpacesAndUpper(l.Address2);
			self.City																:= ut.CleanSpacesAndUpper(l.City);
			self.State															:= ut.CleanSpacesAndUpper(l.State);
			self.Zip_Code														:= trim(l.Zip_Code,left,right);
			self.Zip_Code4													:= trim(l.Zip_Code4,left,right);
			self.Clean_Phone												:= Cln_Phone;
			self.Clean_secondary_phone							:= Cln_SecondaryPhone;
			self.Unit_Flag													:= ut.CleanSpacesAndUpper(l.Unit_Flag);
			self.Unit_Flag_Exp											:= map(ut.CleanSpacesAndUpper(l.Unit_Flag) = 'U' => 'SERVICE LOCATION',
																										 ut.CleanSpacesAndUpper(l.Unit_Flag) = 'H' => 'HEADQUARTER',
																										 '');
			self.Relationship_Code									:= ut.CleanSpacesAndUpper(l.Relationship_Code);
			self.Relationship_Code_Exp							:= map(ut.CleanSpacesAndUpper(l.Relationship_Code) = 'AD' => 'AREA DEVELOPER',
																										 ut.CleanSpacesAndUpper(l.Relationship_Code) = 'AR' => 'AREA REPRESENTATIVE',
																										 ut.CleanSpacesAndUpper(l.Relationship_Code) = 'ST' => 'STANDALONE',
																										 '');
			self.F_Units														:= ut.CleanSpacesAndUpper(l.F_Units);
			self.Website_Url												:= stringlib.stringcleanspaces(l.Website_Url);
			self.Email															:= stringlib.stringcleanspaces(l.Email);
			self.Industry														:= ut.CleanSpacesAndUpper(l.Industry);
			self.Sector															:= ut.CleanSpacesAndUpper(l.Sector);
			self.Industry_type											:= ut.CleanSpacesAndUpper(l.Industry_type);
			self 																		:= l;
			self 																		:= [];
			
		end;
		
		dPreProcess := project(pRawFileInput, tPreProcessIndividuals(left));
	
		return dPreProcess;

	end;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	export fAll( dataset(Layouts.Input.Sprayed	)	pRawFileInput
							,string														pversion
							,string														pPersistname = persistnames().StandardizeInput
	) :=
	function
	
		dPreprocess					:= fPreProcess(pRawFileInput,pversion	) : persist(pPersistname);

		return dPreprocess;
	
	end;

end;