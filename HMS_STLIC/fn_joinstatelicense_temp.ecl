IMPORT Ut, hms_STLIC;

EXPORT fn_joinstatelicense_temp (string pVersion, boolean pUseProd):= function
			
			license := RECORD
					hms_STLIC.layouts.license_layout;
					string75 filename;
			END;
			
			entity := RECORD
				hms_STLIC.layouts.entity_layout;
				string75 filename;
			END;
			
			address := RECORD
				hms_STLIC.layouts.address_layout;
				string75 filename;
			END;
			
			specialty := RECORD
				hms_STLIC.layouts.specialty_layout;
				string75 filename;
			END;
			
			phone := RECORD
				hms_STLIC.layouts.phone_layout;
				string75 filename;
			END;
			
			language := RECORD
				hms_STLIC.layouts.language_layout;
				string75 filename;
			END;
			
			education := RECORD
				hms_STLIC.layouts.education_layout;
				string75 filename;
			END;
			
			disciplinaryact := RECORD
				hms_STLIC.layouts.disciplinaryact_layout;
				string75 filename;
			END;
			
			npi := RECORD
				hms_STLIC.layouts.npi_layout;
				string75 filename;
			END;
			
			csr := RECORD
				hms_STLIC.layouts.csr_layout;
				string75 filename;
			END;
			
			dea := RECORD
				hms_STLIC.layouts.dea_layout;
				string75 filename;
			END;
			
			stliclookup := RECORD
				hms_STLIC.layouts.stliclookup_layout;
				string75 filename;
			END;
			
			
			export AddlicFile	:= distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_license::' + pVersion,license,thor), HASH(ln_key,entityid,hms_src,id));
			export AddEntFile	:= distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_entity::' + pVersion,entity,thor), HASH(ln_key,entityid,hms_src,id));
			export AddAddrFile	:= distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_address::' + pVersion,address,thor), HASH(ln_key,entityid,hms_src,id));
			export AddSpecFile	:= distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_specialty::' + pVersion,specialty,thor), HASH(ln_key,entityid,hms_src,id));
			export AddPhoFile	:= distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_phone::' + pVersion,phone,thor), HASH(ln_key,entityid,hms_src,id));
			export AddLangFile	:= distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_language::' + pVersion,language,thor), HASH(ln_key,entityid,hms_src,id));
			export AddEduFile	:= distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_education::' + pVersion,education,thor), HASH(ln_key,entityid,hms_src,id));
			export AddDiscFile	:= distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_disciplinaryact::' + pVersion,disciplinaryact,thor), HASH(ln_key,entityid,hms_src,id));
			export AddNpiFile	:= distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_npi::' + pVersion,npi,thor), HASH(ln_key,entityid,hms_src,id));
			export AddCsrFile := distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_csr::' + pVersion,csr,thor), HASH(ln_key,entityid,hms_src,id));
			export AddDeaFile := distribute(dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_dea::' + pVersion,dea,thor), HASH(ln_key,entityid,hms_src,id));
			export AddQualFile := dataset(ut.foreign_prod + 'thor400_data::in::hms_stl::hms_stliclookup::' + pVersion,stliclookup,thor); //Mapped Class
			export SrcLookup := hms_STLIC.LookupTables.StLicSrcLookup;
			export TaxonomyLookup := hms_STLIC.LookupTables.TaxonomyLookup;
			
			t1_layout := RECORD
				license-[filename]; //hms_STLIC.layouts.license_layout;
				entity-[filename]; //hms_STLIC.layouts.entity_layout;
				string license_class_type := '';
				string license_number := '';
				string2 license_state := '';
			END;
			
			t1_layout Join1(AddlicFile L,AddEntFile R) := TRANSFORM
				SELF.license_state	:= L.state;
				SELF.license_number := L.number;
				SELF.license_class_type := L.class_type;
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
			
   		base_1	:= JOIN(AddlicFile(trim(number,all)<>''), AddEntFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
												// And LEFT.filename=RIGHT.filename
   										,Join1(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   
 	  
			
   		t2_layout := RECORD
				t1_layout;
				address-[filename]; //hms_STLIC.layouts.address_layout;
				string25 address_type := '';
				string2 address_state := '';
				string orig_county := '';
			END;
			
			t2_layout Join2(base_1 L,AddAddrFile R) := TRANSFORM
				SELF.address_type	:= R.TYPE;
				SELF.address_state := R.State;
				SELF.orig_county := R.county;
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
			
			base_2	:= JOIN(base_1, AddAddrFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
												// And LEFT.filename=RIGHT.filename
											,Join2(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
			
			t3_layout := RECORD
				t2_layout;
				specialty-[filename]; //hms_STLIC.layouts.specialty_layout;
				string specialty_class_type := '';
			END;
			
			t3_layout Join3(base_2 L,AddSpecFile R) := TRANSFORM
				SELF.specialty_class_type	:= R.class_type;
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
			
   		base_3	:= JOIN(base_2, AddSpecFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
												// And LEFT.filename=RIGHT.filename
   										,Join3(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   										
   	
			
			t4_layout := RECORD
				t3_layout;
				phone-[filename]; //hms_STLIC.layouts.phone_layout;
				string15 phone_number := '';
				string15 phone_type := '';
			END;
			
			t4_layout Join4(base_3 L,AddPhoFile R) := TRANSFORM
				SELF.phone_type	:= R.type;
				SELF.phone_number	:= R.number;
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
			
   		base_4	:= JOIN(base_3, AddPhoFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
												// And LEFT.filename=RIGHT.filename
 											,Join4(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   		
   					
			t5_layout := RECORD
				t4_layout;
				language-[filename];//hms_STLIC.layouts.language_layout;
			END;
			
			t5_layout Join5(base_4 L,AddLangFile R) := TRANSFORM
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
			
   		base_5	:= JOIN(base_4, AddLangFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
												// And LEFT.filename=RIGHT.filename
   										,Join5(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   		
   		
			t6_layout := RECORD
				t5_layout;
				education-[filename]; //hms_STLIC.layouts.education_layout;
			END;
			
			t6_layout Join6(base_5 L,AddEduFile R) := TRANSFORM
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
			
   		base_6	:= JOIN(base_5, AddEduFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
												// And LEFT.filename=RIGHT.filename
   										,Join6(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   										
   					
			t7_layout := RECORD
				t6_layout;
				disciplinaryact-[filename]; //hms_STLIC.layouts.disciplinaryact_layout;
			END;
			
			t7_layout Join7(base_6 L,AddDiscFile R) := TRANSFORM
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
			
   		base_7	:= JOIN(base_6, AddDiscFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
												// And LEFT.filename=RIGHT.filename
   										,Join7(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   	
   			
			
			t8_layout := RECORD
				t7_layout;
				npi-[filename]; //hms_STLIC.layouts.npi_layout;
			END;
			
			t8_layout Join8(base_7 L,AddNpiFile R) := TRANSFORM
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
					
   		base_8	:= JOIN(base_7, AddNpiFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
												// And LEFT.filename=RIGHT.filename
   										,Join8(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
											
			t9_layout := RECORD
				t8_layout;
				csr-[filename]; //hms_STLIC.layouts.csr_layout;
			END;
			
			t9_layout Join9(base_8 L,AddCsrFile R) := TRANSFORM
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
			
   		base_9	:= JOIN(base_8, AddCsrFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
												// And LEFT.filename=RIGHT.filename
   										,Join9(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
   		
   		
			t10_layout := RECORD
				t9_layout;
				dea-[filename]; //hms_STLIC.layouts.dea_layout;
			END;
			
			t10_layout Join10(base_9 L,AddDeaFile R) := TRANSFORM
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
			
   		base_10	:= JOIN(base_9, AddDeaFile
   										,LEFT.ln_key = RIGHT.ln_key And LEFT.entityid = RIGHT.entityid And LEFT.hms_src = RIGHT.hms_src And LEFT.id = RIGHT.id
												// And LEFT.filename=RIGHT.filename
   										,Join10(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOCAL
   										);
			
						
			t11_layout := RECORD
				t10_layout;
				stliclookup-[filename]; //hms_STLIC.layouts.stliclookup_layout;
			END;
			
			t11_layout Join11(base_10 L,AddQualFile R) := TRANSFORM
				// SELF.filename := L.filename[(integer)length(L.filename)-7..(integer)length(L.filename)];
				SELF := L;
				SELF := R;
			END;
			
		 base_11 := JOIN(base_10, AddQualFile
   										,Stringlib.StringToUpperCase(LEFT.license_state) = Stringlib.StringToUpperCase(RIGHT.State) 
													And Stringlib.StringToUpperCase(LEFT.license_class_type) = Stringlib.StringToUpperCase(RIGHT.stlicclass) 
													And Stringlib.StringToUpperCase(LEFT.Status) = Stringlib.StringToUpperCase(RIGHT.Status) 
													And Stringlib.StringToUpperCase(LEFT.Qualifier1) = Stringlib.StringToUpperCase(RIGHT.Qualifier1)
													And Stringlib.StringToUpperCase(LEFT.Qualifier2) = Stringlib.StringToUpperCase(RIGHT.Qualifier2)
													// And LEFT.filename=RIGHT.filename
   										,Join11(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOOKUP
   										);
		 
		
		t12_layout := RECORD
				t11_layout;
				string15 taxonomy_code := '';
		END;
			
		t12_layout Join12(base_11 L,TaxonomyLookup R) := TRANSFORM
				SELF.taxonomy_code := R.taxonomy_code;
				SELF := L;
		END;
		
		base_12 := JOIN(base_11, TaxonomyLookup
   										,LEFT.mapped_class = RIGHT.hms_stlic_type_code
   										,Join12(LEFT,RIGHT)
   										,LEFT OUTER
   										,LOOKUP
   										);
		
 		t12_layout Join13(base_12 L,SrcLookup R) := TRANSFORM
   				SELF := L;
   		END;
   			
		base_13 := JOIN(base_12, SrcLookup
												,LEFT.hms_src = RIGHT.vsid 
											,Join13(LEFT,RIGHT)
												,INNER //LEFT OUTER
												,LOOKUP
												);


		// ASSERT(COUNT(base_12)=COUNT(base_13), 'Records were lost in Source Lookup', FAIL);
				
			
		base_d := distribute(base_13,hash(ln_key,entityid,hms_src,id));
		
		base_final := project(base_d,hms_STLIC.Layouts.statelicense_layout);
		
	
		return base_final; 
	
END;