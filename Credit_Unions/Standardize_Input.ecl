import Address, Ut, lib_stringlib, _Control, business_header,_Validate,aid,idl_header;

export Standardize_Input :=
module


  export fAssignSeq(dataset(Layouts.Input.Sprayed) pRawFileInput) := function
	
    // Add a unique_id to the input records to use for normalizing address fields	
		Credit_Unions.layouts.Temporary.TempRec tAssignSeq(Credit_Unions.Layouts.Input.Sprayed l, unsigned8 cnt) := transform
			self.unique_id	:= cnt;
			self						:= L;
		end;
				 		
		dAssignSeq := project(pRawFileInput, tAssignSeq(left,counter));

		// Normalize the raw input records
		Credit_Unions.layouts.NormRec	tNormalizeRec(Credit_Unions.layouts.Temporary.TempRec l, unsigned8 cnt) := transform
			self.unique_id	:= l.unique_id;
			self.charter    := l.cu_number;
			self.cu_name    := l.cu_name;
			self.addrtype   := choose(cnt,'PHYSICAL','MAILING');
			self.Address1   := choose(cnt,l.PhysicalAddressLine1,     l.MailingAddressLine1);
			self.Address2   := choose(cnt,l.PhysicalAddressLine2,     l.MailingAddressLine2);
			self.City       := choose(cnt,l.PhysicalAddressCity,      l.MailingAddressCity);
			self.State      := choose(cnt,l.PhysicalAddressStateCode, l.MailingAddressStateCode);
			self.StateName  := choose(cnt,'',                         l.MailingAddressStateName);
			self.Zip_Code   := choose(cnt,l.PhysicalAddressPostalCode,l.MailingAddressPostalCode);
			self.CountyName := choose(cnt,l.PhysicalAddressCountyName,'');
			self.Country    := choose(cnt,l.PhysicalAddressCountry,   '');
			self.phone      := l.phonenumber;
			self        		:= L;	
			self            := [];
		END;

		dNormalize	:=	normalize(dAssignSeq,	if(trim(left.MailingAddressLine1 + left.MailingAddressLine2,left,right) <> '',2,1),	tNormalizeRec(left, counter));
		
		RETURN dNormalize;
	END;	
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcess(dataset(Credit_Unions.layouts.NormRec) dNormalize, string pversion) :=
	function
	
		Credit_Unions.Layouts.Temporary.StandardizeInput tPreProcess(Credit_Unions.layouts.NormRec l, unsigned1 cnt) :=
		transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			
			cycle_dte                      := REGEXREPLACE('[ ]?\\d{1,2}[:]\\d{1,2}[:]\\d{1,2}',l.cycle_date,'');
						                                          
			self.unique_id								 := cnt;
			self.record_type							 := 'C';
     
			self.dt_vendor_first_reported	 := (unsigned4)pversion;
			self.dt_vendor_last_reported	 := (unsigned4)pversion;

			self.Charter                   := stringlib.stringfilter(trim(l.Charter,left,right),'0123456789');
			self.cycle_date                := IF(_validate.date.fIsValid(ut.date_slashed_MMDDYYYY_to_YYYYMMDD(cycle_dte)),
			                                               ut.date_slashed_MMDDYYYY_to_YYYYMMDD(cycle_dte),'');
			self.join_number               := stringlib.stringfilter(trim(l.join_number,left,right),'0123456789');
			self.SiteId                    := stringlib.stringfilter(trim(l.SiteId,left,right),'0123456789');
			self.CU_Name                   := ut.CleanSpacesAndUpper(l.CU_Name);
			self.SiteName                  := ut.CleanSpacesAndUpper(l.SiteName);
			self.SiteTypeName              := ut.CleanSpacesAndUpper(l.SiteTypeName);
			self.MainOffice                := ut.CleanSpacesAndUpper(l.MainOffice);
			self.Address1                  := ut.CleanSpacesAndUpper(l.Address1);
			self.Address2                  := ut.CleanSpacesAndUpper(l.Address2);
			self.City                      := ut.CleanSpacesAndUpper(l.City);
			self.State                     := ut.CleanSpacesAndUpper(l.State);
			self.Zip_Code                  := ut.CleanSpacesAndUpper(l.Zip_Code);  //Foreign Postal Codes are alphanumeric
			self.StateName                 := ut.CleanSpacesAndUpper(l.StateName);  
			self.CountyName                := ut.CleanSpacesAndUpper(l.CountyName);
			self.Country                   := ut.CleanSpacesAndUpper(l.Country);
			self.Phone                     := stringlib.stringfilter(trim(l.Phone,left,right),'0123456789');
			self.prep_addr_line1           := ut.CleanSpacesAndUpper(trim(l.Address1,left,right) + ' ' + trim(l.Address2,left,right));
			self.prep_addr_line_last       := ut.CleanSpacesAndUpper(trim(l.City,left,right) + 
			                                                              if(trim(l.City,left,right) <> '', 
																																			 ', ' + trim(l.State,left,right), trim(l.State,left,right)) + ' ' +
																																	  if(length(trim(l.Zip_Code)) >= 5 and ut.isNumeric(l.Zip_Code[1..5]),l.Zip_Code[1..5],''));
			self                           := L;
			self													 := [];
			
		end;
		
	  dPreProcess := project(dNormalize, tPreProcess(left,counter));
	
		return dPreProcess;

	end;


	export fAll( 
		 dataset(Layouts.Input.Sprayed	)	pRawFileInput
		,string														pversion
		,string														pPersistname = persistnames().StandardizeInput
	) :=
	function
	
	  dNormalize   := fAssignSeq  (pRawFileInput);
		dPreprocess	 := fPreProcess	(dNormalize,pversion	);

		dback2base   :=  project(dPreprocess, transform(credit_unions.layouts.base, self := left)) : persist(pPersistname);
		
		return dback2base;
		
	end;


end;
