import BIPV2, Business_Header, mdr;

EXPORT Filters :=
module
	export Input :=
	module
	
		export Business_headers(
		
			 dataset(BIPV2.Layout_Business_Linking_Full) 	pInput
			,boolean															pFilterOut = true
		
		) := 
		function
		
			STRING name_chars := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
			
			bad_cnames := ['*****FILE DOES NOT EXIST*****','NONE'];

			boolean lStandardFilter 	:= 	pInput.company_name 	= ''	//Discard records with blank company names
																			or	StringLib.StringFilter(pInput.company_name, name_chars) = ''	//company name must be alphanumeric
																			or	regexfind('^null$', trim(pInput.company_name), nocase)	//company name must be alphanumeric
																			or pInput.company_name in bad_cnames
																		;
			boolean lAdditionalFilter	:=	
					// -- Bug# 124784, DATA: Cross-pollination of Industry & Phone Info?
					(mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(pInput.source) and pInput.company_phone = '9543548338' and trim(pInput.company_name) = 'DKFLA, LLC')
					// -- Bug:146862 - These corp keys need to be filtered out of all base files
					or (MDR.sourceTools.SourceIsCA_Corporations(pInput.source) and trim(pInput.vl_id,left,right) in ['06-03155932', '06-200820510058', '06-200620910099'])
					// -- Bug: 157298 - Remove Contact Angela Farole from BDID 53982819 Avante Abstract Inc.
					or (trim(pInput.company_name) in ['AVANTE', 'AVANTE ABSTRACT', 'AVANTE\' ABSTRACT',	'AVANTE ABSTRACT INC',
																						'AVANTE\' ABSTRACT, INC', 'AVANTE\' ABSTRACT, INC.'] and trim(pInput.contact_name.fname) = 'ANGELA' and trim(pInput.contact_name.lname) = 'FAROLE' and trim(pInput.contact_name.mname) in ['','M'])
					; 		

			boolean lFullFilter 		:= if(pFilterOut
																		,not(lStandardFilter or lAdditionalFilter)	//negate it 
																		,(lStandardFilter or lAdditionalFilter)
																	);

			///////////////////////////////////////////////////////////////////
			// -- 
			///////////////////////////////////////////////////////////////////
			Layout_Business_Linking_Full tblankoutphone(Layout_Business_Linking_Full l) :=
			transform
						// -- Bug: 121569  - DATA: Search results show None as address
						strAlphaNumChars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890';
						strAlphaChars 	 := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
						strGarbageWords	 := ['NONE','UNKNOWN','BLANK'];
						
						self.company_address.prim_name 		:= if(trim(l.company_address.prim_name) 	<> '' and 
																										(StringLib.StringFilter(l.company_address.prim_name,strAlphaNumChars) = '' or trim(l.company_address.prim_name) in strGarbageWords) ,'',l.company_address.prim_name);
						self.company_address.p_city_name	:= if(trim(l.company_address.p_city_name) <> '' and StringLib.StringFilter(l.company_address.p_city_name,strAlphaChars) = '' ,'',l.company_address.p_city_name);
						self.company_address.v_city_name	:= if(trim(l.company_address.v_city_name) <> '' and StringLib.StringFilter(l.company_address.v_city_name,strAlphaChars) = '' ,'',l.company_address.v_city_name);
						self.company_address.st						:= if(trim(l.company_address.st)					<> '' and StringLib.StringFilter(l.company_address.st,strAlphaChars) = '' ,'',l.company_address.st);
						self															:= l;                              
			end;
			
			return project(pInput(lFullFilter), tblankoutphone(left));
			
		end;
	end;
end;