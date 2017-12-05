IMPORT bair,ut, mdr, tools, _validate, Address, Ut, lib_stringlib, _Control, business_header, Enclarity,
Header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, NID, AID,STD,Vehicle_Wildcard;

EXPORT Standardize_input (string pversion='', boolean pUseProd = true, boolean pUseDelta = false) := MODULE

	//Wildcard input

	export compfile	:= if(pUseDelta, bair_composite.Files(pUseProd,pUseDelta).composite_building, bair_composite.Files(pUseProd,pUseDelta).composite_base);
	shared base_wd_file	:= Compfile(prepped_rec_type in [8,14]);

	EXPORT VEH_WD_HOLE	:= FUNCTION
	
			base_crash_per	:= compfile(prepped_rec_type =13);
			
			Make_key				:= If(pUseDelta,key_vehicle_MAKE(,true),key_vehicle_MAKE());
			Body_key				:= If(pUseDelta,key_vehicle_BODY(,true),key_vehicle_BODY());
			Model_key				:= If(pUseDelta,key_vehicle_model(,true),key_vehicle_model());

			wild_base := join(base_wd_file(prepped_rec_type=14),base_crash_per,
												left.eid=right.eid and
												left.vehicleid =right.vehicleid,
												transform(bair.layouts.rCompositeBase,
												self.clean_gender := right.clean_gender,
												self.age:=right.age,
												self:=left)
												,left outer)
											+ base_wd_file(prepped_rec_type=8)
											;
			temp_make :={wild_base, unsigned2 wd_MAKE_CODE:=0 , unsigned2 wd_body_code := 0 ,unsigned3 wd_MODEL_description :=0}; 

			temp_make lookMake(wild_base l,Make_key  R) := TRANSFORM
			self.wd_MAKE_CODE := r.i;
			self := l;
			end;

			add_make := join(wild_base, Make_key,
				  keyed(left.wd_make=right.wd_make),
				  lookMake(left,right),left outer);
						
			temp_make getbody(add_make l,Body_key  R) := TRANSFORM
			self.wd_body_code := r.i;
			self := l;
			end;

			AddBodyCode := join(add_make, Body_key,
				  keyed(left.wd_bodystyle=right.wd_bodystyle)
					,getbody(left,right),left outer);			
							
			temp_make getmodel(AddBodyCode l,Model_key  R) := TRANSFORM
			self.wd_model_description := r.i;
			self := l;
			end;	
		
			AddModelCode := Join(AddBodyCode,Model_key,
										keyed(left.wd_model=right.wd_model)
										,getmodel(left,right),left outer);
										
			layouts.veh_wd_hole tMapping(AddModelCode L) := TRANSFORM
						self.wd_MAKE_CODE:=L.wd_make_code;
						self.wd_MODEL_description:=L.wd_model_description;
						self.wd_COLOR_CODE:=Vehicle_Wildcard.Color2Code(STD.Str.ToUpperCase(L.color));
						self.wd_state_code:=ut.St2Code(STD.Str.ToUpperCase(fn_st2abbrev(L.plate_st)));
						self.wd_zip:=(Integer)L.zip;
						self.wd_body_code:=L.wd_body_code;
						self.eid:=L.eid;
						self.wd_veh_id :=L.veh_id;
						self.wd_YEAR_MAKE:=(Integer)(If(L.year<>'',L.year,'0'));								
						self.wd_PLATE_NUMBER:=L.Plate;
						self.wd_VIN:=L.vin;
						self.wd_gender:=L.clean_gender;
						self.wd_years_since_1900:=If(L.clean_report_date >19000101,L.clean_report_date div 10000 - 1900,0)-L.age;		
						self.wd_orig_state:=ut.St2Code(STD.Str.ToUpperCase(L.st));
						self.wd_person_source:=0;
						self:=L;
					END;
			dStd := PROJECT(AddModelCode, tMapping(LEFT));
			
		return dStd;
	END;
 
 EXPORT MO_PHONE	:= FUNCTION
 
			mo	:= if(pUseDelta
							,bair_composite.Files(pUseProd,pUseDelta).composite_mo_building
							,bair.Files(pversion, pUseProd,pUseDelta).mo_Base.built
							);
			
			per	:= if(pUseDelta
							,bair_composite.Files(pUseProd,pUseDelta).composite_per_building
							,bair.Files(pversion, pUseProd,pUseDelta).persons_Base.built
							);
			
			veh	:= if(pUseDelta
							,bair_composite.Files(pUseProd,pUseDelta).composite_veh_building
							,bair.Files(pversion, pUseProd,pUseDelta).vehicle_Base.built
							);
			
			mo_p := project(mo, transform({mo.eid, string notes}, self.notes := left.synopsis_of_crime; self.eid:=left.eid;));
			per_p := project(per, transform({per.eid, string notes}, self.notes := left.persons_notes; self.eid:=left.eid;));
			veh_p := project(veh, transform({veh.eid, string notes}, self.notes := left.description; self.eid:=left.eid;));

			events := mo_p + per_p + veh_p;
			
			str := '[()| |-]';
			PATTERN phone := PATTERN ('[0-9]{3}[-][0-9]{3}[-][0-9]{4}') | PATTERN ('[(][0-9]{3}[)][0-9]{3}[-][0-9]{4}');
			
			base := PARSE(events,notes,phone,TRANSFORM(bair_composite.layouts.Phone_Parse
						,self.eid:=left.eid
						,self.Phone:=Regexreplace(str,If(not matched(phone),'',matchtext(phone)),'')
						,self.IsCurrent:=true
						,SELF := left	)
							);
			dStd :=dedup(sort(base,eid,phone,local),eid,phone,local);
			
			Bair_Composite.NPA_PhoneType(dstd,phone,ptype,phvalid_out);
			
			phone_new := project(phvalid_out,transform(
																bair_composite.layouts.Phone_Parse,
																self.phone:=if(regexfind('invalid',left.ptype,nocase),'',left.phone),
																self:=left));
			clean_phone:= phone_new(phone<>'');

			Phone_Input:= If(pUseDelta
									,Functions.PHONEPARSE(clean_phone)
									,clean_phone);

	Return Phone_Input;
		
 END;
 
 EXPORT VEH_WD_BODY	:= FUNCTION
	
		base_body := join(base_wd_file,functions.BODYCONST,left.wd_bodystyle=right.BODY_STYLE
								,Transform(layouts.Body_Index
								,self.wd_bodystyle:=left.wd_bodystyle
								,self.i:=0
								,self.body_style_desc := right.Body_Style_Description
								,self.category	:= right.Category
								,self:=left)
								,lookup
								,left outer);
					
			dStd := dedup(base_body(wd_bodystyle<>''),all);
			ut.MAC_Sequence_Records(dStd, i, basebodyIndex);
		return basebodyIndex;
 END;
 
  EXPORT VEH_WD_MAKE	:= FUNCTION
	
	layouts.make_Index tMapping(base_wd_file L) := TRANSFORM
						self.wd_make:=L.wd_make;
   					self.i:=0;
						self:=L;
					END;
			dStd := dedup(PROJECT(base_wd_file(wd_make<>''), tMapping(LEFT)),all);
			ut.MAC_Sequence_Records(dStd, i, basemakeIndex);
		return basemakeIndex;
 END;
 
 EXPORT VEH_WD_MODEL	:= FUNCTION
	
	layouts.Model_index tMapping(base_wd_file L) := TRANSFORM
						self.wd_model:=L.wd_model;
   					self.i:=0;
						self:=L;
					END;
			dStd := dedup(PROJECT(base_wd_file(wd_model<>''), tMapping(LEFT)),all);
			ut.MAC_Sequence_Records(dStd, i, basemodelIndex);
		return basemodelIndex;
 END;

END;
