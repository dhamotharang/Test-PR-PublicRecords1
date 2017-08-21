export Split_Input :=
module
	
	/////////////////////////////////////////////////////////////////////////
	// -- Split the input file into a companies file, and a contacts file
	// -- Companies file -> same as input file minus the contact fields
	// -- Contacts  file -> Normalize out the contact records, keeping the bin to link back
	/////////////////////////////////////////////////////////////////////////

	export Companies(dataset(layouts.Input.Sprayed) pInputFile) :=
	function
		
		layouts.input.companies t2CompaniesLayout(layouts.Input.Sprayed l) :=
		transform
		
			self := l;
		
		end;
		
		dCompanies := project(pInputFile, t2CompaniesLayout(left));
				
		return dCompanies;
	
	end;

	export Contacts(dataset(layouts.Input.Sprayed) pInputFile) :=
	function

		layouts.input.contacts t2ContactsLayoutNorm(layouts.Input.Sprayed l, layouts.Input.raw_contacts r) :=
		transform
		
			self.BIN                 := l.BIN;
			self.CON_NAME_HONORIFIC  := r.CON_NAME_HONORIFIC ;
			self.CON_NAME_FIRST_NAME := r.CON_NAME_FIRST_NAME;
			self.CON_NAME_MID_NAME   := r.CON_NAME_MID_NAME  ;
			self.CON_NAME_LAST_NAME  := r.CON_NAME_LAST_NAME ;
			self.CON_NAME_GEN_CD     := r.CON_NAME_GEN_CD    ;
			self.CON_NAME_TITLE      := r.CON_NAME_TITLE     ;
			self.CON_NAME_TITLE_CD   := r.CON_NAME_TITLE_CD  ;
			self.BUSINESS_NAME       := l.BUSINESS_NAME   ;            
			self.BUSINESS_ADDRESS    := l.BUSINESS_ADDRESS;
			self.CITY                := l.CITY            ;
			self.STATE               := l.STATE           ;
			self.ZIP                 := l.ZIP             ;
			self.PLUS4_ZIP           := l.PLUS4_ZIP       ;
			self.PHONE               := l.PHONE           ;
		                             
		end;
		
		dNormContacts := normalize(pInputFile, left.contacts, t2ContactsLayoutNorm(left,right));

		return dNormContacts(CON_NAME_LAST_NAME != '');
		
	end;
	
end;