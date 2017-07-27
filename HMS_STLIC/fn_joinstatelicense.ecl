IMPORT Ut, HMS_STLIC;

EXPORT fn_joinstatelicense (string pVersion, boolean pUseProd):= function
			
			AddlicFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).license_input, HASH(ln_key,entityid,hms_src,id));
			AddEntFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).entity_input, HASH(ln_key,entityid,hms_src,id));
			AddAddrFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).address_input, HASH(ln_key,entityid,hms_src,id));
			AddSpecFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).specialty_input, HASH(ln_key,entityid,hms_src,id));
			AddPhoFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).phone_input, HASH(ln_key,entityid,hms_src,id));
			AddLangFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).language_input, HASH(ln_key,entityid,hms_src,id));
			AddEduFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).education_input, HASH(ln_key,entityid,hms_src,id));
			AddDiscFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).disciplinaryact_input, HASH(ln_key,entityid,hms_src,id));
			AddNpiFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).npi_input, HASH(ln_key,entityid,hms_src,id));
			AddCsrFile := distribute(HMS_STLIC.Files(pversion,pUseProd).csr_input, HASH(ln_key,entityid,hms_src,id));
			AddDeaFile := distribute(HMS_STLIC.Files(pversion,pUseProd).dea_input, HASH(ln_key,entityid,hms_src,id));
			AddQualFile := HMS_STLIC.Files(pversion,pUseProd).stliclookup_input; //Mapped Class
			SrcLookup := HMS_STLIC.LookupTables.StLicSrcLookup;
			TaxonomyLookup := HMS_STLIC.LookupTables.TaxonomyLookup;
			
			// AddlicFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).license_input, HASH(ln_key,entityid,hms_src,id));
			// AddEntFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).entity_input, HASH(ln_key,entityid,hms_src,id));
			
			t1_layout := RECORD
				HMS_STLIC.layouts.license_layout;
				HMS_STLIC.layouts.entity_layout;
				string license_class_type := '';
				string license_number := '';
				string2 license_state := '';
			END;
			
			t1_layout Join1(AddlicFile L,AddEntFile R) := TRANSFORM
				SELF.license_state	:= L.state;
				SELF.license_number := L.number;
				SELF.license_class_type := L.class_type;
				SELF := L;
				SELF := R;
			END;
			
   		base_1	:= JOIN(AddlicFile, AddEntFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
   										,Join1(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   
 	  
			
   		// AddAddrFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).address_input, HASH(ln_key,entityid,hms_src,id));
   		
			t2_layout := RECORD
				t1_layout;
				HMS_STLIC.layouts.address_layout;
				string25 address_type := '';
				string2 address_state := '';
				string orig_county := '';
			END;
			
			t2_layout Join2(base_1 L,AddAddrFile R) := TRANSFORM
				SELF.address_type	:= R.TYPE;
				SELF.address_state := R.State;
				SELF.orig_county := R.county;
				SELF := L;
				SELF := R;
			END;
			
			base_2	:= JOIN(base_1, AddAddrFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
											,Join2(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
			
			// AddSpecFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).specialty_input, HASH(ln_key,entityid,hms_src,id));
			
			t3_layout := RECORD
				t2_layout;
				HMS_STLIC.layouts.specialty_layout;
				string specialty_class_type := '';
			END;
			
			t3_layout Join3(base_2 L,AddSpecFile R) := TRANSFORM
				SELF.specialty_class_type	:= R.class_type;
				SELF := L;
				SELF := R;
			END;
			
   		base_3	:= JOIN(base_2, AddSpecFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
   										,Join3(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   										
   		// AddPhoFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).phone_input, HASH(ln_key,entityid,hms_src,id));
			
			t4_layout := RECORD
				t3_layout;
				HMS_STLIC.layouts.phone_layout;
				string15 phone_number := '';
				string15 phone_type := '';
			END;
			
			t4_layout Join4(base_3 L,AddPhoFile R) := TRANSFORM
				SELF.phone_type	:= R.type;
				SELF.phone_number	:= R.number;
				SELF := L;
				SELF := R;
			END;
			
   		base_4	:= JOIN(base_3, AddPhoFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
 											,Join4(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   		
   		// AddLangFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).language_input, HASH(ln_key,entityid,hms_src,id));
			
			t5_layout := RECORD
				t4_layout;
				HMS_STLIC.layouts.language_layout;
			END;
			
			t5_layout Join5(base_4 L,AddLangFile R) := TRANSFORM
				SELF := L;
				SELF := R;
			END;
			
   		base_5	:= JOIN(base_4, AddLangFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
   										,Join5(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   		
   		// AddEduFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).education_input, HASH(ln_key,entityid,hms_src,id));
			
			t6_layout := RECORD
				t5_layout;
				HMS_STLIC.layouts.education_layout;
			END;
			
			t6_layout Join6(base_5 L,AddEduFile R) := TRANSFORM
				SELF := L;
				SELF := R;
			END;
			
   		base_6	:= JOIN(base_5, AddEduFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
   										,Join6(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   										
   		// AddDiscFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).disciplinaryact_input, HASH(ln_key,entityid,hms_src,id));
			
			t7_layout := RECORD
				t6_layout;
				HMS_STLIC.layouts.disciplinaryact_layout;
			END;
			
			t7_layout Join7(base_6 L,AddDiscFile R) := TRANSFORM
				SELF := L;
				SELF := R;
			END;
			
   		base_7	:= JOIN(base_6, AddDiscFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
   										,Join7(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   	
   			
			// AddNpiFile	:= distribute(HMS_STLIC.Files(pversion,pUseProd).npi_input, HASH(ln_key,entityid,hms_src,id));

			t8_layout := RECORD
				t7_layout;
				HMS_STLIC.layouts.npi_layout;
			END;
			
			t8_layout Join8(base_7 L,AddNpiFile R) := TRANSFORM
				SELF := L;
				SELF := R;
			END;
					
   		base_8	:= JOIN(base_7, AddNpiFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
   										,Join8(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
											
			// AddCsrFile := distribute(HMS_STLIC.Files(pversion,pUseProd).csr_input, HASH(ln_key,entityid,hms_src,id));
			
			t9_layout := RECORD
				t8_layout;
				HMS_STLIC.layouts.csr_layout;
			END;
			
			t9_layout Join9(base_8 L,AddCsrFile R) := TRANSFORM
				SELF := L;
				SELF := R;
			END;
			
   		base_9	:= JOIN(base_8, AddCsrFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
   										,Join9(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   		
   		// AddDeaFile := distribute(HMS_STLIC.Files(pversion,pUseProd).dea_input, HASH(ln_key,entityid,hms_src,id));
			
			t10_layout := RECORD
				t9_layout;
				HMS_STLIC.layouts.dea_layout;
			END;
			
			t10_layout Join10(base_9 L,AddDeaFile R) := TRANSFORM
				SELF := L;
				SELF := R;
			END;
			
   		base_10	:= JOIN(base_9, AddDeaFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
   										,Join10(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
			
			// AddQualFile := HMS_STLIC.Files(pversion,pUseProd).stliclookup_input;
			
			t11_layout := RECORD
				t10_layout;
				HMS_STLIC.layouts.stliclookup_layout;
			END;
			
			t11_layout Join11(base_10 L,AddQualFile R) := TRANSFORM
				SELF := L;
				SELF := R;
			END;
			
		 base_11 := JOIN(base_10, AddQualFile
   										,Stringlib.StringToUpperCase(LEFT.license_state) = Stringlib.StringToUpperCase(RIGHT.State) 
													And Stringlib.StringToUpperCase(LEFT.license_class_type) = Stringlib.StringToUpperCase(RIGHT.stlicclass) 
													And Stringlib.StringToUpperCase(LEFT.Status) = Stringlib.StringToUpperCase(RIGHT.Status) 
													And Stringlib.StringToUpperCase(LEFT.Qualifier1) = Stringlib.StringToUpperCase(RIGHT.Qualifier1)
													And Stringlib.StringToUpperCase(LEFT.Qualifier2) = Stringlib.StringToUpperCase(RIGHT.Qualifier2)
   										,Join11(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOOKUP
   										);
		 
		// SrcLookup := HMS_STLIC.LookupTables.StLicSrcLookup;
		
		t11_layout Join12(base_11 L,SrcLookup R) := TRANSFORM
				SELF := L;
		END;
			
		base_12 := JOIN(base_11, SrcLookup
   										,LEFT.hms_src = RIGHT.vsid 
											,Join12(LEFT,RIGHT)
   										,INNER
   										,LOOKUP
   										);

		// TaxonomyLookup := HMS_STLIC.LookupTables.TaxonomyLookup;
		
		t12_layout := RECORD
				t11_layout;
				string15 taxonomy_code := '';
		END;
			
		t12_layout Join13(base_12 L,TaxonomyLookup R) := TRANSFORM
				SELF.taxonomy_code := R.taxonomy_code;
				SELF := L;
		END;
		
		base_13 := JOIN(base_12, TaxonomyLookup
   										,LEFT.mapped_class = RIGHT.hms_stlic_type_code
   										,Join13(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOOKUP
   										);
		
		base_d := distribute(base_13,hash(ln_key,entityid,hms_src,id));
		
		base_final := project(base_d,HMS_STLIC.Layouts.statelicense_layout);
		
	
		return base_final; 
	
END;