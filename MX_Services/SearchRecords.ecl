 import doxie, iesp;
export SearchRecords := module

	shared mac_apply_penalty(in_recs, out_recs, in_mod, name_variants) := macro
		#uniquename(calculate_penalty)
		in_recs %calculate_penalty%(in_recs l) := transform		
		
			_pen_pat_name 	:= Functions.calculateNamePenalty(in_mod.uPaternalName, l.lastname, in_mod.penalty_threshold);
			_pen_fname 			:= Functions.calculateNamePenalty(in_mod.uFirstName, l.firstname, in_mod.penalty_threshold);
			_pen_mat_name 	:= Functions.calculateNamePenalty(in_mod.uMaternalName, l.matronymic, in_mod.penalty_threshold);
			
			// overriding penalty value in case of name variant match.
			pen_pat_name 	:= if(_pen_pat_name>0 and exists(name_variants(name=in_mod.sPaternalName, uvariant = l.lastname)), 1, _pen_pat_name); 
			pen_fname 		:= if(_pen_fname>0 and exists(name_variants(name=in_mod.sFirstName, uvariant = l.firstname)), 1, _pen_fname); 
			pen_mat_name 	:= if(_pen_mat_name>0 and exists(name_variants(name=in_mod.sMaternalName, uvariant = l.matronymic)), 1, _pen_mat_name); 
			pen_mid_name 	:= Functions.calculateNamePenalty(in_mod.uMiddleName, l.middlename, in_mod.penalty_threshold);			
			
			self.penalty := pen_pat_name+pen_mid_name+pen_fname+pen_mat_name,
			self := l
		end;		
		out_recs := project(in_recs, %calculate_penalty%(left));	
	endmacro;

	export Docket := module	
	
		export records(MX_Services.IParam.DocketSearchParams in_mod) := function
				
				name_variants := MX_Services.NameVariants(in_mod.sFirstName, in_mod.sPaternalName, in_mod.sMaternalName);	
				ids := MX_Services.DocketKeyIds(in_mod, false, name_variants);
				input_entity_id := dataset([{in_mod.UniqueId}], Layouts.MXEntityIds);
				entity_ids := if(in_mod.UniqueId=0, ids, input_entity_id);

				recs_raw	:= Raw.getDocketsByIds(entity_ids);			
				mac_apply_penalty(recs_raw, recs_pen, in_mod, name_variants);
				recs_filtered := if(in_mod.strictmatch, recs_pen(penalty=0), recs_pen(penalty<=in_mod.penalty_threshold));	
				recs_group := group(sort(recs_filtered, entity_id), entity_id);

				MX_Services.Layouts.MXDocketRecord doRollup(MX_Services.Layouts.MXDocketsPrepOut l, 
																										dataset(MX_Services.Layouts.MXDocketsPrepOut) allrows) := transform					
					_akas0 := project(allrows, transform(MX_Services.Layouts.AKAName,
													 self.entity_id := left.entity_id,
													 self.cnt := 1,
													 // not using left.fullname because full name in this case is the original title, 
													 // which may contain more than one party.
													 self.Full := UnicodeLib.UnicodeCleanSpaces(left.prefix+u' '+left.firstname+u' '+
																				left.middlename+u' '+left.lastname+u' '+left.matronymic+u' '+left.suffix),
													 self.First := left.firstname,
													 self.Middle := left.middlename,
													 self.PaternalLast := left.lastname,
													 self.MaternalLast := left.matronymic,																						
													 self.Suffix := left.suffix,
													 self.Prefix := left.prefix,
													 self.MarriedLast := ''));
					_akas := sort(rollup(sort(_akas0, full), left.full = right.full, 
											  transform(MX_Services.Layouts.AKAName, self.cnt 	:= left.cnt + 1, self := left)), -cnt);				
					_dockets := sort(project(allrows,
																transform(MX_Services.Layouts.MXCourtDocket,
																	self.date_pub := left.date_pub,
																	self.StateProvinceCode := left.state,
																	self.StateProvince := left.geography,
																	self.CourtName := left.court,
																	self.LocalCourtName := left.court_local,
																	self._Type := MX_Services.Constants.NatureTypeDesc(type=left.nature_type)[1].desc, 
																	self.Description := left.nature,
																	self.Number := left.docket,
																	self.Title := left.caption
																)), StateProvince, Number, -date_pub);
					self.Entity_id 	:= l.entity_id,
					// only the minimum penalty for this entity will be used in the final sort
					self._penalty		:= min(allrows, penalty),
					self.Gender 		:= if(l.gender='M' or l.gender='F', l.gender, ''),
					self.Akas				:= choosen(_akas, Constants.Limits.MAX_AKAS_PER_ENTITY),
					// using most common name as full name
					self.FullName 	:= _akas[1].full,				
					// if search by id, return all licenses for this entity
					self.Dockets		:= if(in_mod.UniqueId=0, choosen(_dockets,Constants.Limits.MAX_DOCKETS_PER_ENTITY), _dockets);
				end;
				
				recs_groll := rollup(recs_group, group,	doRollup(left, rows(left)));
				return sort(ungroup(recs_groll), _penalty, -max(dockets,date_pub), -count(dockets), fullname, entity_id);
				
		end;
	end; // Docket module
	
	export Profession := module
	
		export records(MX_Services.IParam.ProfessionSearchParams in_mod) := function
				
				name_variants := MX_Services.NameVariants(in_mod.sFirstName, in_mod.sPaternalName, in_mod.sMaternalName);	
				ids := MX_Services.ProfessionKeyIds(in_mod, false, name_variants);
				input_entity_id := dataset([{in_mod.UniqueId}], Layouts.MXEntityIds);
				entity_ids := if(in_mod.UniqueId=0, ids, input_entity_id);

				recs_raw := Raw.getProfessionByIds(entity_ids);			
				mac_apply_penalty(recs_raw, recs_pen, in_mod, name_variants);
				recs_filtered := if(in_mod.strictmatch, recs_pen(penalty=0), recs_pen(penalty<=in_mod.penalty_threshold));	
				recs_group := group(sort(recs_filtered, entity_id), entity_id);
					
				MX_Services.Layouts.MXProfessionRecord doRollup(MX_Services.Layouts.MXProfessionPrepOut l, 
																										dataset(MX_Services.Layouts.MXProfessionPrepOut) allrows) := transform					
					_akas0 := project(allrows, transform(MX_Services.Layouts.AKAName,
													 self.entity_id := left.entity_id,
													 self.cnt := 1,
													 self.Full := left.fullname, 
													 self.First := left.firstname,
													 self.Middle := left.middlename,
													 self.PaternalLast := left.lastname,
													 self.MaternalLast := left.matronymic,																						
													 self.Suffix := left.suffix,
													 self.Prefix := left.prefix,
													 self.MarriedLast := ''));
					_akas := sort(rollup(sort(_akas0, full), left.full = right.full, 
											  transform(MX_Services.Layouts.AKAName, self.cnt 	:= left.cnt + 1, self := left)), -cnt);													
					_certifications := sort(project(allrows,
																transform(MX_Services.Layouts.MXProfessionalCertification,
																		self.Category := MX_Services.Constants.CategoryTypeDesc(type=left.prof_cat)[1].desc,
																		self.ProfessionNumber := (integer) left.profno,
																		self.Profession := left.profession,
																		self.EducationLevel := left.education_level
																)), category, profession);
					self.Entity_id 	:= l.entity_id,
					// only the minimum penalty for this entity will be used in the final sort
					self._penalty		:= min(allrows, penalty),
					self.Gender 		:= if(l.gender='M' or l.gender='F', l.gender, ''),
					self.Akas				:= choosen(_akas, Constants.Limits.MAX_AKAS_PER_ENTITY),
					// using most common name as full name
					self.FullName 	:= _akas[1].full,				
					// if search by id, return all credentials for this entity
					self.Certifications	:= if(in_mod.UniqueId=0, choosen(_certifications,Constants.Limits.MAX_CERT_PER_ENTITY), _certifications)
				end;
				
				recs_groll := rollup(recs_group, group,	doRollup(left, rows(left)));
				return sort(ungroup(recs_groll), _penalty, -count(Certifications), fullname, entity_id);
				
		end;	
		
	end; // Profession module	
end;