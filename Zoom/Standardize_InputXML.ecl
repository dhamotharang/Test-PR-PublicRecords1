import _control, MDR, Ut, address, lib_stringlib, _Control, idl_header,STD;

export Standardize_InputXML := module

	export Preprocess(dataset(Layouts.Input.rawXML) pInputFile) :=
	function
  appendtags      := project(pInputFile
										 ,transform(Layouts.Input.rawXML
										 ,self.line:='<personData>' + regexreplace('<personData>|</personData>|<personDataList>|</personDataList>|<[?]xml version="1.0" encoding="WINDOWS-1252" standalone="yes" [?]>|<[?]xml version="1.0" encoding="utf-8" [?]>', left.line, '')  + '</personData>';
										 ,self:=left;));
								 
	dPreProcess     := project(appendtags
	                   ,transform({appendtags}
										//eliminate bad XML records (records with mismatched tags).
                     ,self.line:=if(STD.Str.FindCount(left.line,'<') = STD.Str.FindCount(left.line,'>')
										             and STD.Str.FindCount(left.line,'>') = STD.Str.FindCount(left.line,'</')*2
										 ,left.line,SKIP)
							   	   ,self:=left;));															


		dparsed			  := parse(dPreProcess, line, Layouts.input.SprayedXML, xml('personData'));
		
		return dparsed;

	end;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- fStandardizeFields
	//////////////////////////////////////////////////////////////////////////////////////
	export fStandardizeFields(dataset(Layouts.Input.SprayedXML) pRawFileInput, string pversion) :=
	function
			Layouts.BaseXML tStandardizeFields(Layouts.Input.SprayedXML l) :=	transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Clean and Standardizes Names.
			//////////////////////////////////////////////////////////////////////////////////////
			assembled_name 					                := trim(l.Name_Last		)
			                                           + ' '  + trim(l.Name_suffix	)
																                 + ', '	+	trim(l.Name_First 	)
																                 + ' '	+	trim(l.Name_Middle 	)
																                 ;                

			clean_contact_name			                := Address.CleanPersonLFM73_fields(assembled_name).CleanNameRecord;
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Cleaning Phone.
			//////////////////////////////////////////////////////////////////////////////////////
			Phone																		:= 	ut.CleanPhone(l.Phone					);																							
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			vdate := if(length(trim(l.validdate,left,right)) >= 10, StringLib.StringFilter(l.validdate[1..10],'0123456789'), '');
			
			self.dt_first_seen											:= (unsigned4)vdate					;	
			self.dt_last_seen												:= (unsigned4)vdate					;
			self.dt_vendor_first_reported						:= (unsigned4)pversion			;
			self.dt_vendor_last_reported						:= (unsigned4)pversion			;
			self.record_type												:= 'C'											;
			
			// Mapping cleaned name fields
			self.clean_contact_name									:= clean_contact_name	      ;
			self.cleaned_phone    									:= Phone										;
			
			self.rawfields.zoomID                   := if(trim(l.zoomID)[1] = '-', trim(l.zoomID)[2..], trim(l.zoomID))               ;
			self.rawfields.diversity                := trim(l.diversity,left,right);
			self.rawfields.reference_bio            := trim(l.reference_bio,left,right);
			self.clean_ref_last_date                := if(length(trim(l.reference_lastdate,left,right)) >= 10, StringLib.StringFilter(l.reference_lastdate[1..10],'0123456789'), '');
			self.clean_ref_valid_date               := if(length(trim(l.reference_validdate,left,right)) >= 10, StringLib.StringFilter(l.reference_validdate[1..10],'0123456789'), '');
			self.clean_valid_date                   := vdate;
			self.rawfields													:= l					              ;
		end;
		
		dStandardizeFields := project(pRawFileInput, tStandardizeFields(left));
		
		addGlobalSID := MDR.macGetGlobalSid(dStandardizeFields, 'Zoom', '', 'global_sid'); //DF-25333: Populate Global_SIDs
		
		//** Flipping the names that are wrongly cleaned by name cleaner.
		ut.mac_flipnames(addGlobalSID, clean_contact_name.fname, clean_contact_name.mname, clean_contact_name.lname, dStandardizeFields_flipnames)
	    
	  return dStandardizeFields_flipnames;
	end;
	

	export fAll( dataset(Layouts.Input.rawXML			)	pRawFileInput
							,string														  pversion
	) :=
	function
	
		dpreprocess		:= Preprocess					(pRawFileInput);
		dBase					:= fStandardizeFields	(dpreprocess,pversion	);
		
		#if(_flags.UseStandardizePersists)
			dAppendRecord	:= dBase : persist(Persistnames.standardizeInput + 'XML');
		#else
			dAppendRecord	:= dBase ;
		#end
		
		return dAppendRecord;
	
	end;
	
end;