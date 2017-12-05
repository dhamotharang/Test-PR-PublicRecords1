IMPORT bair,ut, mdr, tools, _validate, Address, Ut, lib_stringlib, _Control, business_header, Enclarity,
Header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, NID, AID,STD,Vehicle_Wildcard, Bair_composite, SALT32;

EXPORT PrepDID_Payload (string version='', boolean pUseProd = true) := MODULE
	
	shared r := {bair.layouts.rCompositeBase, boolean has_fn, string20 fn, string20 mn, string20 ln};
	
	shared linkflags := 'left.eid = right.eid,left only, local';
		
	EXPORT CFS_Delta := FUNCTION			
	
			base_n 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_CFS(FALSE);
			base_p 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_CFS(TRUE);
			
			prev_deltas := DISTRIBUTED(bair.Files('', pUseProd, true).cfs_base.built, hash(eid));
			prev 				:= join( prev_deltas
											 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^CFS', eid))
											 ,left.eid = right.eid
											 ,left only
											 ,lookup);
			
			bair.MAC_Join(curr,base_n,base_p,linkflags);			
			bair.MAC_Join(prev_w_curr,prev,curr,linkflags);
			
			res := if(Bair.BuildInfo.DeltaToBeFlushed
								,prev_w_curr
								,curr
								);
									
			r tMapping(res L,  integer C) := TRANSFORM
				self.data_provider_id		:=L.ori;
				self.data_provider_ori	:=L.data_provider_ori;
				self.incident						:=L.event_number;
				self.orig_name					:=trim(L.complainant,left,right);
				self.Prepped_rec_type		:=choose(C
																	,Bair._Constant.CFS_caller_addr
																	,Bair._Constant.CFS_complainant_addr
																	,Bair._Constant.CFS_Incident_addr
																	);
				self.orig_officer				:=L.officer_name;
				self.orig_address				:=choose(C
																	,L.caller_address
																	,if(L.complainant_address='',L.caller_address,L.complainant_address)
																	,if(L.address=''            ,L.caller_address,L.address)
																	);
				self.orig_City					:=L.city;
				self.latitude						:=(string)choose(C
																	,L.complainant_y_coordinate
																	,L.complainant_y_coordinate
																	,L.y_coordinate
																	);
				self.longitude					:=(string)choose(C
																	,L.complainant_x_coordinate
																	,L.complainant_x_coordinate
																	,L.x_coordinate
																	);						
				self.crime							:=StringLib.StringCleanSpaces(STD.Str.ToUpperCase(L.initial_type));
				self.phone							:=L.clean_current_phone;
				self.dt_first_seen			:=ut.min2(L.clean_date_occurred,L.clean_date_time_received);
				self.dt_last_seen				:=ut.min2(L.clean_date_occurred,L.clean_date_time_received);
				self.class_code					:=Bair.MapClassCodeNum(2,(string)L.initial_ucr_group);
				self.Sequence 					:=1;
				self.has_fn							:= false;
				self.fn									:= '';
				self.mn									:= '';
				self.ln									:= '';
				SELF := L;
				SELF := [];
			END;
			
			dStd := dedup(NORMALIZE(res(quarantined = '0'), 3, tMapping(LEFT,counter)), all);

			return dStd;
		
	END;
		
	EXPORT CFS_Full := FUNCTION
			
			int_deltas := DISTRIBUTED(Bair.Files_Intermediary(pUseProd).cfs_d, hash(eid))(complainant <> '', (caller_address <> '' or complainant_address <> '' or address <> ''));
			full_cfs   := DISTRIBUTED(Bair.files().cfs_Base.Built, hash(eid))(complainant <> '', (caller_address <> '' or complainant_address <> '' or address <> ''));
			
			new_base
					:= join(full_cfs,		
									Bair.files().AgencyDeletes_base.Built(regexfind('^CFS', eid)),
									left.eid = right.eid,
									transform(left),
									left only,
									lookup);
							
			bair.MAC_Join(res,new_base,int_deltas,linkflags);
			
			r tMapping(res L,  integer C) := TRANSFORM
				self.data_provider_id		:=L.ori;
				self.data_provider_ori	:=L.data_provider_ori;
				self.incident						:=L.event_number;
				self.orig_name					:=trim(L.complainant,left,right);
				self.Prepped_rec_type		:=choose(C
																	,Bair._Constant.CFS_caller_addr
																	,Bair._Constant.CFS_complainant_addr
																	,Bair._Constant.CFS_Incident_addr);
				self.orig_officer				:=L.officer_name;
				self.orig_address				:=choose(C
																	,L.caller_address
																	,if(L.complainant_address='',L.caller_address,L.complainant_address)
																	,if(L.address=''            ,L.caller_address,L.address)
																	);
				self.orig_City					:=L.city;
				self.latitude						:=(string)choose(C,L.complainant_y_coordinate,L.complainant_y_coordinate,L.y_coordinate);
				self.longitude					:=(string)choose(C,L.complainant_x_coordinate,L.complainant_x_coordinate,L.x_coordinate);						
				self.crime							:=trim(StringLib.StringCleanSpaces(STD.Str.ToUpperCase(L.initial_type)),left,right);
				self.phone							:=L.clean_current_phone;
				self.dt_first_seen			:=ut.min2(L.clean_date_occurred,L.clean_date_time_received);
				self.dt_last_seen				:=ut.min2(L.clean_date_occurred,L.clean_date_time_received);
				self.class_code					:=Bair.MapClassCodeNum(2,(string)L.initial_ucr_group);
				self.Sequence 					:=0;
				self.has_fn							:= false;
				self.fn									:= '';
				self.mn									:= '';
				self.ln									:= '';
				SELF := L;
				SELF := [];
			END;
			
			dStd := dedup(NORMALIZE(res(quarantined = '0'), 3, tMapping(LEFT,counter)), all);
			return dStd;
		
	END;
	
	EXPORT MO_Delta := FUNCTION	
					
			base_n 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_MO(FALSE);
			base_p 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_MO(TRUE);
			
			prev_deltas := DISTRIBUTED(bair.Files('', pUseProd, true).mo_base.built, hash(eid));
			prev 				:= join( prev_deltas
											 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^EVE', eid))
											 ,left.eid = right.eid
											 ,left only
											 ,lookup);
			
			bair.MAC_Join(curr,base_n,base_p,linkflags);			
			bair.MAC_Join(prev_w_curr,prev,curr,linkflags);
			
			res := if(Bair.BuildInfo.DeltaToBeFlushed
								,prev_w_curr
								,curr
								);
								
			r tMapping(res L) := TRANSFORM
				self.data_provider_id		:=L.ori;
				self.incident						:=L.ir_number;
				self.data_provider_ori	:=L.data_provider_ori;
				self.recordid_raids			:=L.recordid_raids;
				self.Prepped_rec_type		:=Bair._Constant.Events_Mo_address_of_crime;
				self.orig_address				:=L.address_of_crime;

				temp_adddr 	:= trim(regexreplace('USA$', L.address_of_crime, ' ' ), left, right);
				goodAddr 		:= if(count(STD.STr.SplitWords(temp_adddr,',')) = 3, true, false);
				
				self.orig_City					:=trim(if(goodAddr, STD.STr.SplitWords(temp_adddr,',')[2], ''), left, right);
				self.orig_st						:=trim(if(goodAddr, regexfind('[a-z]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				self.orig_zip						:=trim(if(goodAddr, regexfind('[0-9]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				
				self.dt_first_seen			:=L.clean_First_Date_Time;
				self.dt_last_seen				:=L.clean_Last_Date_Time;
				self.class_code					:=Bair.MapClassCodeNum(1, (string)L.ucr_group);
				self.crime							:=trim(StringLib.StringCleanSpaces(STD.Str.ToUpperCase(L.crime)));
				self.latitude						:=(string)L.Y_Coordinate;
				self.longitude					:=(string)L.X_Coordinate;
				self.Sequence 					:=1;
				self.has_fn							:= false;
				self.fn									:= '';
				self.mn									:= '';
				self.ln									:= '';
				SELF := L;
				SELF := [];
			END;				

			dStd := PROJECT(res(quarantined = '0'), tMapping(LEFT));
			return dStd;
	END;
	
	EXPORT MO_Full := FUNCTION	
					
			int_deltas	:= DISTRIBUTED(Bair.Files_Intermediary(pUseProd).mo_d, hash(eid));					
			full_base		:= DISTRIBUTED(Bair.files().mo_Base.Built, hash(eid));
				
			new_base
					:= join(full_base,
									Bair.files().AgencyDeletes_base.Built(regexfind('^EVE', eid)),
									left.eid = right.eid,
									transform(left),
									left only,
									lookup);
									
			bair.MAC_Join(res,new_base,int_deltas,linkflags);

			r tMapping(res L) := TRANSFORM				
				self.data_provider_id		:=L.ori;
				self.incident						:=L.ir_number;
				self.data_provider_ori	:=L.data_provider_ori;
				self.recordid_raids			:=L.recordid_raids;
				self.Prepped_rec_type		:=Bair._Constant.Events_Mo_address_of_crime;
				self.orig_address				:=L.address_of_crime;
				
				temp_adddr 	:= trim(regexreplace('USA$', L.address_of_crime, ' ' ), left, right);
				goodAddr 		:= if(count(STD.STr.SplitWords(temp_adddr,',')) = 3, true, false);
				
				self.orig_City					:=trim(if(goodAddr, STD.STr.SplitWords(temp_adddr,',')[2], ''), left, right);
				self.orig_st						:=trim(if(goodAddr, regexfind('[a-z]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				self.orig_zip						:=trim(if(goodAddr, regexfind('[0-9]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				
				self.dt_first_seen			:=L.clean_First_Date_Time;
				self.dt_last_seen				:=L.clean_Last_Date_Time;
				self.class_code					:=Bair.MapClassCodeNum(1, (string)L.ucr_group);
				self.crime							:=StringLib.StringCleanSpaces(STD.Str.ToUpperCase(L.crime));
				self.latitude						:=(string)L.Y_Coordinate;
				self.longitude					:=(string)L.X_Coordinate;
				self.Sequence 					:=0;
				self.has_fn							:= false;
				self.fn									:= '';
				self.mn									:= '';
				self.ln									:= '';
				SELF := L;
				SELF := [];
			END;				

			dStd := PROJECT(res(quarantined = '0'), tMapping(LEFT));
			return dStd;
	END;

	EXPORT PER_Delta := FUNCTION	
					
			base_n 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_PERSONS(FALSE);
			base_p 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_PERSONS(TRUE);
			
			prev_deltas := DISTRIBUTED(bair.Files('', pUseProd, true).persons_base.built, hash(eid));
			prev 				:= join( prev_deltas
											 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^EVE', eid))
											 ,left.eid = right.eid
											 ,left only
											 ,lookup);
			
			bair.MAC_Join(curr,base_n,base_p,linkflags);			
			bair.MAC_Join(prev_w_curr,prev,curr,linkflags);
			
			res := if(Bair.BuildInfo.DeltaToBeFlushed
								,prev_w_curr
								,curr
								);

			r tMapping(res L) := TRANSFORM
				self.data_provider_id		:=L.ori;
				self.data_provider_ori	:=L.data_provider_ori;
				self.recordid_raids			:=L.recordid_raids;
				self.incident						:=L.ir_number;
				self.Prepped_rec_type		:=Bair._Constant.Events_Persons_persons_address;
				self.name_type					:=L.name_type;
				self.orig_address				:=L.persons_address;
				
				temp_adddr 	:= trim(regexreplace('USA$', L.persons_address, ' ' ), left, right);
				goodAddr 		:= if(count(STD.STr.SplitWords(temp_adddr,',')) = 3, true, false);
				
				self.orig_City					:=trim(if(goodAddr, STD.STr.SplitWords(temp_adddr,',')[2], ''), left, right);
				self.orig_st						:=trim(if(goodAddr, regexfind('[a-z]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				self.orig_zip						:=trim(if(goodAddr, regexfind('[0-9]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				
				self.age								:=bair.fnAge((unsigned4)L.clean_dob);
				self.orig_moniker				:=trim(L.moniker, left, right);
				self.name_hint					:='FML';
				self.orig_name					:=regexreplace('[^A-Z\\- ]', StringLib.StringCleanSpaces(L.first_name+' '+L.middle_name+' '+L.last_name+' '+ut.fGetSuffix(L.moniker)),'',nocase);
				self.orig_gender				:=L.sex;
				self.clean_gender				:='';
				self.latitude						:=(string)L.latitude;
				self.longitude					:=(string)L.longitude;
				self.orig_sid						:=L.persons_sid;
				self.dob								:=(unsigned)L.clean_dob;
				self.Sequence 					:=1;
				self.has_fn							:= if(L.first_name <> '' and L.middle_name <> '' and L.last_name <> '', true, false);
				self.fn									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.first_name,left,right)),'',nocase);
				self.mn									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.middle_name,left,right)),'',nocase);
				self.ln									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.last_name,left,right)),'',nocase);
				self := L;
				self := [];
			END;
			
			dStd := PROJECT(res(quarantined = '0'), tMapping(LEFT));
			return dStd;
	END;
	
	EXPORT PER_Full := FUNCTION
	
			int_deltas 	:= DISTRIBUTED(Bair.Files_Intermediary(pUseProd).per_d, hash(eid));					
			full_base		:= DISTRIBUTED(Bair.files().persons_Base.Built, hash(eid));
				
			new_base
					:= join(full_base,
									Bair.files().AgencyDeletes_base.Built(regexfind('^EVE', eid)),
									left.eid = right.eid,
									transform(left),
									left only,
									lookup);
									
			bair.MAC_Join(res,new_base,int_deltas,linkflags);
					
			r tMapping(res L) := TRANSFORM
				self.data_provider_id		:=L.ori;
				self.data_provider_ori	:=L.data_provider_ori;
				self.recordid_raids			:=L.recordid_raids;
				self.incident						:=L.ir_number;
				self.Prepped_rec_type		:=Bair._Constant.Events_Persons_persons_address;
				self.name_type					:=L.name_type;
				self.orig_address				:=L.persons_address;
				
				temp_adddr 	:= trim(regexreplace('USA$', L.persons_address, ' ' ), left, right);
				goodAddr 		:= if(count(STD.STr.SplitWords(temp_adddr,',')) = 3, true, false);
				
				self.orig_City					:=trim(if(goodAddr, STD.STr.SplitWords(temp_adddr,',')[2], ''), left, right);
				self.orig_st						:=trim(if(goodAddr, regexfind('[a-z]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				self.orig_zip						:=trim(if(goodAddr, regexfind('[0-9]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				
				self.age								:=bair.fnAge((unsigned4)L.clean_dob);
				self.orig_moniker				:=trim(L.moniker, left, right);
				self.name_hint					:='FML';
				self.orig_name					:=regexreplace('[^A-Z\\- ]', StringLib.StringCleanSpaces(L.first_name+' '+L.middle_name+' '+L.last_name+' '+ut.fGetSuffix(L.moniker)),'',nocase);
				self.orig_gender				:=L.sex;
				self.clean_gender				:='';
				self.latitude						:=(string)L.latitude;
				self.longitude					:=(string)L.longitude;
				self.orig_sid						:=L.persons_sid;
				self.dob								:=(unsigned)L.clean_dob;
				self.Sequence 					:=0;
				self.has_fn							:= if(L.first_name <> '' and L.middle_name <> '' and L.last_name <> '', true, false);
				self.fn									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.first_name, left, right)),'',nocase);
				self.mn									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.middle_name, left, right)),'',nocase);
				self.ln									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.last_name, left, right)),'',nocase);
				self := L;
				self := [];
			END;
				
			dStd := PROJECT(res(quarantined = '0'), tMapping(LEFT));
			return dStd;
	END;
	
	EXPORT VEH_Delta := FUNCTION	
					
			base_n 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_VEHICLE(FALSE);
			base_p 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_VEHICLE(TRUE);
			
			prev_deltas := DISTRIBUTED(bair.Files('', pUseProd, true).vehicle_base.built, hash(eid));
			prev 				:= join( prev_deltas
											 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^EVE', eid))
											 ,left.eid = right.eid
											 ,left only
											 ,lookup);
			
			bair.MAC_Join(curr,base_n,base_p,linkflags);			
			bair.MAC_Join(prev_w_curr,prev,curr,linkflags);
			
			res := if(Bair.BuildInfo.DeltaToBeFlushed
								,prev_w_curr
								,curr
								);	
			
			r tMapping(res L) := TRANSFORM
				self.data_provider_id		:=L.ori;
				self.data_provider_ori	:=L.data_provider_ori;
				self.recordid_raids			:=L.recordid_raids;
				self.incident						:=L.ir_number;
				self.Prepped_rec_type		:=Bair._Constant.Events_Vehicle_vehicle_address;
				self.orig_address				:=L.vehicle_address;
				
				temp_adddr 	:= trim(regexreplace('USA$', L.vehicle_address, ' ' ), left, right);
				goodAddr 		:= if(count(STD.STr.SplitWords(temp_adddr,',')) = 3, true, false);
				
				self.orig_City					:=trim(if(goodAddr, STD.STr.SplitWords(temp_adddr,',')[2], ''), left, right);
				self.orig_st						:=trim(if(goodAddr, regexfind('[a-z]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				self.orig_zip						:=trim(if(goodAddr, regexfind('[0-9]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				
				self.plate							:=STD.Str.ToUpperCase(trim(L.plate, left, right));
				self.plate_st						:=Bair_composite.fn_st2abbrev(trim(L.plate_state, left, right));
				self.make								:=STD.Str.ToUpperCase(trim(L.make, left, right));
				self.model							:=STD.Str.ToUpperCase(trim(L.model, left, right));
				self.style							:=STD.Str.ToUpperCase(trim(L.style, left, right));
				self.color							:=STD.Str.ToUpperCase(trim(L.color, left, right));
				self.wd_make						:=bair_composite.functions.make_clean(std.str.touppercase(trim(l.make,left,right)));
				self.wd_color						:=bair_composite.functions.color_clean(std.str.touppercase(trim(l.color,left,right)));
				self.wd_bodystyle				:=bair_composite.functions.body_clean(std.str.touppercase(trim(l.style,left,right)));
				self.wd_model						:=std.str.touppercase(trim(l.model,left,right));
				self.vehicle_type				:=trim(L.type,left,right);
				self.veh_id 						:=0;
				self.year								:=L.year;
				self.latitude						:=(string)L.latitude;
				self.longitude					:=(string)L.longitude;
				self.Sequence 					:=1;
				self.has_fn							:= false;
				self.fn									:= '';
				self.mn									:= '';
				self.ln									:= '';
				self := L;
				self := [];
			END;				

			dStd := PROJECT(res(quarantined = '0'), tMapping(LEFT));
			return dStd;
	END;
	
	EXPORT VEH_Full := FUNCTION
	
			int_deltas  := DISTRIBUTED(Bair.Files_Intermediary(pUseProd).veh_d, hash(eid));
			full_base		:= DISTRIBUTED(Bair.files().vehicle_Base.Built, hash(eid));
			
			new_base
					:= join(full_base,
									Bair.files().AgencyDeletes_base.Built(regexfind('^EVE', eid)),
									left.eid = right.eid,
									transform(left),
									left only,
									lookup);
									
			bair.MAC_Join(res,new_base,int_deltas,linkflags);
					
			r tMapping(res L) := TRANSFORM
				self.data_provider_id		:=L.ori;
				self.data_provider_ori	:=L.data_provider_ori;
				self.recordid_raids			:=L.recordid_raids;
				self.incident						:=L.ir_number;
				self.Prepped_rec_type		:=Bair._Constant.Events_Vehicle_vehicle_address;
				self.orig_address				:=L.vehicle_address;
				
				temp_adddr 	:= trim(regexreplace('USA$', L.vehicle_address, ' ' ), left, right);
				goodAddr 		:= if(count(STD.STr.SplitWords(temp_adddr,',')) = 3, true, false);
				
				self.orig_City					:=trim(if(goodAddr, STD.STr.SplitWords(temp_adddr,',')[2], ''), left, right);
				self.orig_st						:=trim(if(goodAddr, regexfind('[a-z]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				self.orig_zip						:=trim(if(goodAddr, regexfind('[0-9]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), ''), left, right);
				
				self.plate							:=STD.Str.ToUpperCase(trim(L.plate, left, right));
				self.plate_st						:=Bair_composite.fn_st2abbrev(trim(L.plate_state, left, right));
				self.make								:=STD.Str.ToUpperCase(trim(L.make, left, right));
				self.model							:=STD.Str.ToUpperCase(trim(L.model, left, right));
				self.style							:=STD.Str.ToUpperCase(trim(L.style, left, right));
				self.color							:=STD.Str.ToUpperCase(trim(L.color, left, right));
				self.wd_make						:=bair_composite.functions.make_clean(std.str.touppercase(trim(l.make,left,right)));
				self.wd_color						:=bair_composite.functions.color_clean(std.str.touppercase(trim(l.color,left,right)));
				self.wd_bodystyle				:=bair_composite.functions.body_clean(std.str.touppercase(trim(l.style,left,right)));
				self.wd_model						:=std.str.touppercase(trim(l.model,left,right));
				self.vehicle_type				:=trim(L.type,left,right);
				self.veh_id 						:=0;
				self.year								:=L.year;
				self.latitude						:=(string)L.latitude;
				self.longitude					:=(string)L.longitude;
				self.Sequence 					:=0;
				self.has_fn							:= false;
				self.fn									:= '';
				self.mn									:= '';
				self.ln									:= '';
				self := L;
				self := [];
			END;
				
			dStd := PROJECT(res(quarantined = '0'), tMapping(LEFT));
			return dStd;
	END;
	
	EXPORT OFF_Delta := FUNCTION
			
			base_n 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_OFFENDERS(FALSE);
			base_p 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_OFFENDERS(TRUE);		
			
			prev_deltas := DISTRIBUTED(bair.Files('', pUseProd, true).offenders_base.built, hash(eid));
			prev 				:= join( prev_deltas
											 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^OFF', eid))
											 ,left.eid = right.eid
											 ,left only
											 ,lookup);
			
			bair.MAC_Join(curr,base_n,base_p,linkflags);			
			bair.MAC_Join(prev_w_curr,prev,curr,linkflags);
			
			res := if(Bair.BuildInfo.DeltaToBeFlushed
								,prev_w_curr
								,curr
								);

			r tMapping(res L,  integer C) := TRANSFORM
				self.Prepped_rec_type		:=Bair._Constant.Offenders_;
				self.data_provider_id		:=L.data_provider_id;
				self.data_provider_ori	:=L.data_provider_ori;
				self.incident						:=L.agency_offender_id;
				self.name_type					:=L.name_type;
				self.orig_address				:=L.address;
				
				temp_adddr 	:= trim(regexreplace('USA$', L.address, ' ' ), left, right);
				goodAddr 		:= if(count(STD.STr.SplitWords(temp_adddr,',')) = 3, true, false);
				
				self.orig_City					:=if(goodAddr, STD.STr.SplitWords(temp_adddr,',')[2], '');
				self.orig_st						:=if(goodAddr, regexfind('[a-z]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), '');
				self.orig_zip						:=if(goodAddr, regexfind('[0-9]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), '');
				
				self.age								:=choose(C
																	,L.age_1
																	,if(L.age_2=0,L.age_1,L.age_2)
																	);
				self.orig_moniker				:=trim(L.moniker, left, right);
				self.name_hint					:='FML';
				self.orig_name					:=regexreplace('[^A-Z\\- ]', StringLib.StringCleanSpaces(L.first_name+' '+L.middle_name+' '+L.last_name+' '+ut.fGetSuffix(L.moniker)),'',nocase);
				self.dl									:=L.dl_number;
				self.dl_st							:=L.dl_state;
				self.dob								:=(unsigned)L.clean_dob;
				self.crime							:=StringLib.StringCleanSpaces(STD.Str.ToUpperCase(L.classification_description));
				self.orig_sid						:=L.Offenders_sid;
				self.latitude						:=(string)L.Y_coordinate;
				self.longitude					:=(string)L.X_coordinate;
				self.dt_first_seen			:=L.clean_user_datetime;
				self.dt_last_seen				:=L.clean_user_datetime;
				self.class_code					:=Bair.MapClassCodeNum(7,L.classification);
				self.Sequence 					:=1;
				self.has_fn							:= if(L.first_name <> '' and L.middle_name <> '' and L.last_name <> '', true, false);
				self.fn									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.first_name, left, right)),'',nocase);
				self.mn									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.middle_name, left, right)),'',nocase);
				self.ln									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.last_name, left, right)),'',nocase);
				self:=L;
				self:=[];
			END;
			
		dStd := dedup(NORMALIZE(res(quarantined = '0'), 2, tMapping(LEFT,counter)), all);
		return dStd;
		
	END;
	
	EXPORT OFF_Full := FUNCTION
	
			int_deltas  := DISTRIBUTED(Bair.Files_Intermediary(pUseProd).off_d, hash(eid));		
			full_base		:= DISTRIBUTED(Bair.files().offenders_Base.Built, hash(eid));
			
			new_base
					:= join(full_base,
								Bair.files().AgencyDeletes_base.Built(regexfind('^OFF', eid)),
								left.eid = right.eid,
								transform(left),
								left only,
								lookup);
									
			bair.MAC_Join(res,new_base,int_deltas,linkflags);
			
			r tMapping(res L,  integer C) := TRANSFORM
				self.Prepped_rec_type		:=Bair._Constant.Offenders_;
				self.data_provider_id		:=L.data_provider_id;
				self.data_provider_ori	:=L.data_provider_ori;
				self.incident						:=L.agency_offender_id;
				self.orig_address				:=L.address;
				
				temp_adddr 	:= trim(regexreplace('USA$', L.address, ' ' ), left, right);
				goodAddr 		:= if(count(STD.STr.SplitWords(temp_adddr,',')) = 3, true, false);
				
				self.orig_City					:=if(goodAddr, STD.STr.SplitWords(temp_adddr,',')[2], '');
				self.orig_st						:=if(goodAddr, regexfind('[a-z]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), '');
				self.orig_zip						:=if(goodAddr, regexfind('[0-9]+', STD.STr.SplitWords(temp_adddr,',')[3], 0, nocase), '');
				self.age								:=choose(C
																	,L.age_1
																	,if(L.age_2=0,L.age_1,L.age_2)
																	);
				self.orig_moniker				:=trim(L.moniker, left, right);
				self.name_hint					:='FML';
				self.orig_name					:=regexreplace('[^A-Z\\- ]', StringLib.StringCleanSpaces(L.first_name+' '+L.middle_name+' '+L.last_name+' '+ut.fGetSuffix(L.moniker)),'',nocase);
				self.dl									:=L.dl_number;
				self.dl_st							:=L.dl_state;
				self.dob								:=(unsigned)L.clean_dob;
				self.crime							:=StringLib.StringCleanSpaces(STD.Str.ToUpperCase(L.classification_description));
				self.orig_sid						:=L.Offenders_sid;
				self.latitude						:=(string)L.Y_coordinate;
				self.longitude					:=(string)L.X_coordinate;
				self.dt_first_seen			:=L.clean_user_datetime;
				self.dt_last_seen				:=L.clean_user_datetime;
				self.class_code					:=Bair.MapClassCodeNum(7,L.classification);
				self.Sequence 					:=0;
				self.has_fn							:= if(L.first_name <> '' and L.middle_name <> '' and L.last_name <> '', true, false);
				self.fn									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.first_name, left, right)),'',nocase);
				self.mn									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.middle_name, left, right)),'',nocase);
				self.ln									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.last_name, left, right)),'',nocase);
				self:=L;
				self:=[];
			END;
				
			dStd := dedup(NORMALIZE(res(quarantined = '0'), 2, tMapping(LEFT,counter)), all);
			return dStd;
		
	END;

	EXPORT CRA_Delta := FUNCTION
			
			base_n 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_CRASH(FALSE);
			base_p 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_CRASH(TRUE);
			
			prev_deltas := DISTRIBUTED(bair.Files('', pUseProd, true).crash_base.built, hash(eid));
			prev 				:= join( prev_deltas
											 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^CRA', eid))
											 ,left.eid = right.eid
											 ,left only
											 ,lookup);
			
			bair.MAC_Join(curr,base_n,base_p,linkflags);			
			bair.MAC_Join(prev_w_curr,prev,curr,linkflags);
			
			res := if(Bair.BuildInfo.DeltaToBeFlushed
								,prev_w_curr
								,curr
								);

			r tMapping(res L,  Integer C) := TRANSFORM
				self.Prepped_rec_type		:=choose(C
																	,Bair._Constant.Crash_Incident
																	,Bair._Constant.Crash_Person
																	,Bair._Constant.Crash_Vehicle
																	);
				self.data_provider_id		:=L.data_provider_id;
				self.data_provider_ori	:=L.data_provider_ori;
				self.incident						:=L.case_number;
				self.orig_address				:=L.address;
				self.orig_city					:=L.crash_city;
				self.orig_st						:=L.crash_state;
				self.orig_officer				:=L.officername;
				self.name_hint					:='FML';
				self.orig_name					:=Choose(C
																	,''
																	,regexreplace('[^A-Z\\- ]', StringLib.StringCleanSpaces(L.first_name+' '+L.last_name),'',nocase)
																	,''
																	);
				self.orig_gender				:=Choose(C
																	,''
																	,L.sex
																	,''
																	);
				self.dt_first_seen			:=L.clean_Report_Date;
				self.dt_last_seen				:=L.clean_Report_Date;
				self.class_code					:=Bair.MapClassCodeNum(3,L.crashType);
				self.age								:=Choose(C
																	,0
																	,L.age
																	,0
																	);
				self.dl									:=Choose(C
																	,''
																	,STD.Str.ToUpperCase(trim(L.licensenumber,left,right))
																	,''
																	);
				self.dl_st							:=Choose(C
																	,''
																	,STD.Str.ToUpperCase(trim(L.licensestate,left,right))
																	,''
																	);
				self.vin								:=Choose(C
																	,''
																	,''
																	,STD.Str.ToUpperCase(trim(L.vin,left,right))
																	);
				self.plate							:=Choose(C
																	,''
																	,''
																	,STD.Str.ToUpperCase(trim(L.plate,left,right))
																	);
				self.plate_st						:=Choose(C
																	,''
																	,''
																	,Bair_composite.fn_st2abbrev(trim(L.platestate,left,right))
																	);
				self.year								:=Choose(C
																	,''
																	,''
																	,L.year
																	);
				self.make								:=Choose(C
																	,''
																	,''
																	,STD.Str.ToUpperCase(trim(L.make,left,right))
																	);
				self.model							:=Choose(C
																	,''
																	,''
																	,STD.Str.ToUpperCase(trim(L.model,left,right))
																	);
				self.wd_make						:=Choose(C
																	,''
																	,''
																	,bair_composite.Functions.make_clean(STD.Str.ToUpperCase(trim(L.make,left,right)))
																	);
				self.wd_model						:=Choose(C
																	,''
																	,''
																	,STD.Str.ToUpperCase(trim(L.model,left,right))
																	);
				self.vehicle_type				:=Choose(C
																	,''
																	,''
																	,trim(L.vehicle_type,left,right)
																	);
				self.veh_id							:=Choose(C
																	,0
																	,0
																	,L.veh_id
																	);
				self.clean_report_date	:=Choose(C
																	,0
																	,0
																	,L.clean_report_date
																	);
				self.vehicleid					:=Choose(C
																	,0
																	,L.vehicleid
																	,L.vehicleid
																	);
				self.latitude						:=(string)L.Y;
				self.longitude					:=(string)L.X;
				self.Sequence 					:=1;
				self.has_fn							:= if(L.first_name <> '' and L.last_name <> '', true, false);
				self.fn									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.first_name, left, right)),'',nocase);
				self.mn									:= '';
				self.ln									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.last_name, left, right)),'',nocase);
				self.per_id							:= L.per_id;
				self:=L;
				self:=[];
			END;				

			dStd := dedup(sort(Normalize(res(quarantined = '0'),3, tMapping(LEFT,counter)),record,except Prepped_rec_type),record,except Prepped_rec_type);
			return dStd;
	END;
	
	EXPORT CRA_Full := FUNCTION
	
			int_deltas  := DISTRIBUTED(Bair.Files_Intermediary(pUseProd).cra_d, hash(eid));		
			full_base		:= DISTRIBUTED(Bair.files().crash_Base.Built, hash(eid));
			
			new_base
					:= join(full_base,
								Bair.files().AgencyDeletes_base.Built(regexfind('^CRA', eid)),
								left.eid = right.eid,
								transform(left),
								left only,
								lookup);
									
			bair.MAC_Join(res,new_base,int_deltas,linkflags);
			
			r tMapping(res L,  Integer C) := TRANSFORM
				self.Prepped_rec_type		:=choose(C
																	,Bair._Constant.Crash_Incident
																	,Bair._Constant.Crash_Person
																	,Bair._Constant.Crash_Vehicle
																	);
				self.data_provider_id		:=L.data_provider_id;
				self.data_provider_ori	:=L.data_provider_ori;
				self.incident						:=L.case_number;
				self.orig_address				:=L.address;
				self.orig_city					:=L.crash_city;
				self.orig_st						:=L.crash_state;
				self.orig_officer				:=L.officername;
				self.name_hint					:='FML';
				self.orig_name					:=Choose(C
																	,''
																	,regexreplace('[^A-Z\\- ]', StringLib.StringCleanSpaces(L.first_name+' '+L.last_name),'',nocase)
																	,''
																	);
				self.orig_gender				:=Choose(C
																	,''
																	,L.sex
																	,''
																	);													
				self.dt_first_seen			:=L.clean_Report_Date;
				self.dt_last_seen				:=L.clean_Report_Date;
				self.class_code					:=Bair.MapClassCodeNum(3,L.crashType);
				self.age								:=Choose(C
																	,0
																	,L.age
																	,0
																	);
				self.dl									:=Choose(C
																	,''
																	,STD.Str.ToUpperCase(trim(L.licensenumber,left,right))
																	,''
																	);
				self.dl_st							:=Choose(C
																	,''
																	,STD.Str.ToUpperCase(trim(L.licensestate,left,right))
																	,''
																	);
				self.vin								:=Choose(C
																	,''
																	,''
																	,STD.Str.ToUpperCase(trim(L.vin,left,right))
																	);
				self.plate							:=Choose(C
																	,''
																	,''
																	,STD.Str.ToUpperCase(trim(L.plate,left,right))
																	);
				self.plate_st						:=Choose(C
																	,''
																	,''
																	,Bair_composite.fn_st2abbrev(trim(L.platestate,left,right))
																	);
				self.year								:=Choose(C
																	,''
																	,''
																	,L.year
																	);
				self.make								:=Choose(C
																	,''
																	,''
																	,STD.Str.ToUpperCase(trim(L.make,left,right))
																	);
				self.model							:=Choose(C
																	,''
																	,''
																	,STD.Str.ToUpperCase(trim(L.model,left,right))
																	);
				self.wd_make						:=Choose(C
																	,''
																	,''
																	,bair_composite.Functions.make_clean(STD.Str.ToUpperCase(trim(L.make,left,right)))
																	);
				self.wd_model						:=Choose(C
																	,''
																	,''
																	,STD.Str.ToUpperCase(trim(L.model,left,right))
																	);
				self.vehicle_type				:=Choose(C
																	,''
																	,''
																	,trim(L.vehicle_type,left,right)
																	);
				self.veh_id							:=Choose(C
																	,0
																	,0
																	,L.veh_id
																	);
				self.clean_report_date	:=Choose(C
																	,0
																	,0
																	,L.clean_report_date
																	);
				self.vehicleid					:=Choose(C
																	,0
																	,L.vehicleid
																	,L.vehicleid
																	);
				self.latitude						:=(string)L.Y;
				self.longitude					:=(string)L.X;
				self.Sequence 					:=0;
				self.has_fn							:= if(L.first_name <> '' and L.last_name <> '', true, false);
				self.fn									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.first_name, left, right)),'',nocase);
				self.mn									:= '';
				self.ln									:= regexreplace('[^A-Z\\- ]', STD.Str.ToUpperCase(trim(L.last_name, left, right)),'',nocase);
				self.per_id							:= L.per_id;
				self:=L;
				self:=[];
			END;
				
			dStd := dedup(sort(Normalize(res(quarantined = '0'),3, tMapping(LEFT,counter)),record,except Prepped_rec_type),record,except Prepped_rec_type);
			return dStd;		
	END;
	
	EXPORT LPR_Delta := FUNCTION
			
			base_n 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_LPR(FALSE);
			base_p 	:= Bair.Update_Base(version, pUseProd, TRUE).MAC_JOININPUTS_LPR(TRUE);
			
			prev_deltas := DISTRIBUTED(bair.Files('', pUseProd, true).lpr_base.built, hash(eid));
			prev 				:= join( prev_deltas
											 ,Bair.AgencyDeletes.eids_to_delete(regexfind('^LPR', eid))
											 ,left.eid = right.eid
											 ,left only
											 ,lookup);
			
			bair.MAC_Join(curr,base_n,base_p,linkflags);			
			bair.MAC_Join(prev_w_curr,prev,curr,linkflags);
			
			res := if(Bair.BuildInfo.DeltaToBeFlushed
								,prev_w_curr
								,curr
								);
			r tMapping(res L) := TRANSFORM
				self.Prepped_rec_type		:=Bair._Constant.License_Plates;
				self.data_provider_ori	:=L.data_provider_ori;
				self.dt_first_seen			:=L.clean_CaptureDateTime;
				self.dt_last_seen				:=L.clean_CaptureDateTime;
				self.plate							:=L.plate;
				self.latitude						:=(string)L.Y_Coordinate;
				self.longitude					:=(string)L.X_Coordinate;
				self.class_code					:=600;
				self.Sequence 					:=1;
				self.has_fn							:= false;
				self.fn									:= '';
				self.mn									:= '';
				self.ln									:= '';
				self:=L;
				self:=[];
			END;				

			dStd := PROJECT(res, tMapping(LEFT));
			return dStd;
	END;
	
	EXPORT LPR_Full := FUNCTION
	
			int_deltas  := DISTRIBUTED(Bair.Files_Intermediary(pUseProd).lpr_d, hash(eid));		
			full_base		:= DISTRIBUTED(Bair.files().lpr_Base.Built, hash(eid));
			
			new_base
					:= join(full_base,
								Bair.files().AgencyDeletes_base.Built(regexfind('^LPR', eid)),
								left.eid = right.eid,
								transform(left),
								left only,
								lookup);
									
			bair.MAC_Join(res,new_base,int_deltas,linkflags);
			
			r tMapping(res L) := TRANSFORM
				self.Prepped_rec_type		:=Bair._Constant.License_Plates;
				self.data_provider_ori	:=L.data_provider_ori;
				self.dt_first_seen			:=L.clean_CaptureDateTime;
				self.dt_last_seen				:=L.clean_CaptureDateTime;
				self.plate							:=L.plate;
				self.latitude						:=(string)L.Y_Coordinate;
				self.longitude					:=(string)L.X_Coordinate;
				self.class_code					:=600;
				self.Sequence 					:=0;
				self.has_fn							:= false;
				self.fn									:= '';
				self.mn									:= '';
				self.ln									:= '';
				self:=L;
				self:=[];
			END;
				
			dStd := PROJECT(res, tMapping(LEFT));
			return dStd;		
	END;
	
END;
