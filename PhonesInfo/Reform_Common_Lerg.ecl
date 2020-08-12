IMPORT std, ut;

//DF-28036: Convert 6-Digit Spids to 4-Character Spids

//MAP INPUTS TO COMMON LAYOUT

EXPORT Reform_Common_Lerg(string version) := MODULE
	
			///////////////////////////////////////////////////////////////////////////////////////////////////////////
			//Lerg1 File: Carrier Information//////////////////////////////////////////////////////////////////////////
			///////////////////////////////////////////////////////////////////////////////////////////////////////////
			dsLerg1			:= PhonesInfo.File_Lerg.Lerg1;

			//Lerg1 Mapping	
			PhonesInfo.Layout_Lerg.lergPrep lerg1Tr(dsLerg1 l):= transform
					trimFile:= trim(l.filename, left, right);
			
					self.override_file									:= 'A'; //Carrier Flag
					self.ocn														:= PhonesInfo._functions.fn_standardName(l.ocn);			//Clean-up Field for Join
					self.name														:= PhonesInfo._Functions.fn_standardName(l.ocn_name); //Clean-up Field for Join
					self.dt_first_reported							:= version;
					self.dt_last_reported								:= version;
					self.dt_start												:= trimFile[length(trimFile)-7..];
					self.dt_end													:= '';
					self.carrier_name										:= l.ocn_name;
					self.serv														:= '';
					self.line														:= '';
					self.prepaid												:= '';
					self.high_risk_indicator						:= '';
					self.activation_dt									:= 0;
					self.number_in_service							:= '';
					self.spid														:= PhonesInfo._functions.fn_standardName(l.ocn);			//Assume OCN is equivalent to SPID
					self.operator_full_name							:= l.ocn_name; 																				//Assume OCN is equivalent to SPID
					self.is_current											:= TRUE;
					self.data_type 											:= '';
					self.ocn_state 											:= l.ocn_state;
					self.overall_ocn 										:= l.overall_ocn;
					self.target_ocn											:= l.target_ocn;
					self.overall_target_ocn							:= l.overall_target_ocn;
					self.ocn_abbr_name									:= l.ocn_abbr_name;
					self.rural_lec_indicator 						:= stringlib.stringfilter(l.rural_lec_indicator, 'X');
					self.small_ilec_indicator 					:= stringlib.stringfilter(l.small_ilec_indicator, 'X');
					self.category												:= l.category;
					self.carrier_address1								:= l.address1;
					self.carrier_address2								:= l.address2;
					self.carrier_floor									:= l.floor;
					self.carrier_room										:= l.room;
					self.carrier_city										:= l.city;
					self.carrier_state									:= l.state;
					self.carrier_zip										:= l.postal_code;
					self.carrier_phone									:= PhonesInfo._Functions.fn_standardName(l.phone);
					self.affiliated_to									:= l.company_name;
					self.overall_company								:= '';
					self.contact_function								:= '';
					self.contact_name										:= if(trim(l.last_name, left, right)<>'' and trim(l.first_name, left, right)<>'',
																										trim(trim(trim(l.first_name, left, right)+' '+trim(l.middle_initial, left, right), left, right)+' '+trim(l.last_name, left, right), left, right),
																										trim(l.last_name, left, right));	
					self.contact_title									:= l.title;
					self.contact_address1								:= '';
					self.contact_address2								:= '';
					self.contact_city										:= '';
					self.contact_state									:= '';
					self.contact_zip										:= '';
					self.contact_phone									:= '';
					self.contact_fax										:= '';
					self.contact_email									:= '';
					self.contact_information						:= '';
					self.prim_range											:= '';
					self.predir													:= '';
					self.prim_name											:= '';
					self.addr_suffix										:= '';
					self.postdir												:= '';
					self.unit_desig											:= '';
					self.sec_range											:= '';
					self.p_city_name										:= '';
					self.v_city_name										:= '';
					self.st															:= '';
					self.z5															:= '';
					self.zip4														:= '';
					self.cart														:= '';
					self.cr_sort_sz											:= '';
					self.lot														:= '';
					self.lot_order											:= '';
					self.dpbc														:= '';
					self.chk_digit											:= '';
					self.rec_type												:= '';
					self.ace_fips_st										:= '';
					self.fips_county										:= '';
					self.geo_lat												:= '';
					self.geo_long												:= '';
					self.msa														:= '';
					self.geo_blk												:= '';
					self.geo_match											:= '';
					self.err_stat												:= '';	
					self.append_rawaid									:= 0;
					self.address_type										:= '';
					self.privacy_indicator 							:= '';
					self.address1												:= '';
					self.address2												:= '';
					self.country												:= if(PhonesInfo._Functions.fn_isUSStateTerr(l.ocn_state),
																										'US',
																									if(PhonesInfo._Functions.fn_isCanTerr(l.ocn_state),
																										'CA',
																										l.ocn_state));
					self.opname													:= '';
					self.is_new													:= '';
					self.rec_update											:= '';
					self																:= l;
			end;
		
	EXPORT Lerg1		:= project(dsLerg1, lerg1Tr(left)):independent;
	
			///////////////////////////////////////////////////////////////////////////////////////////////////////////
			//Lerg1 Contact File: Contact Information//////////////////////////////////////////////////////////////////
			///////////////////////////////////////////////////////////////////////////////////////////////////////////
			layoutCount := record
					PhonesInfo.Layout_Lerg.lerg1Con;
					integer infoCt;
			end;	
				
			layoutCount proj_rec(PhonesInfo.Layout_Lerg.lerg1Con l) := transform
					self 					:= l;
					self.infoCt 	:= std.str.countwords(l.contact_information,',');
			end;	

			dsLerg1Con	:= project(PhonesInfo.File_Lerg.Lerg1Con, proj_rec(left));
	
			//Lerg1Con Mapping	
			PhonesInfo.Layout_Lerg.lergPrep lerg1ConTr(dsLerg1Con l):= transform
					trimFile := trim(l.filename, left, right);
					
					self.override_file									:= 'B'; //Contact Flag
					self.ocn														:= PhonesInfo._functions.fn_standardName(l.ocn);			//Clean-up Field for Join
					self.name														:= PhonesInfo._Functions.fn_standardName(l.ocn_name);	//Clean-up Field for Join	
					self.dt_first_reported							:= version;
					self.dt_last_reported								:= version;
					self.dt_start												:= trimFile[length(trimFile)-7..];
					self.dt_end													:= '';
					self.carrier_name										:= l.ocn_name;
					self.serv														:= '';
					self.line														:= '';
					self.prepaid												:= '';
					self.high_risk_indicator						:= '';
					self.activation_dt									:= 0;
					self.number_in_service							:= '';
					self.spid														:= PhonesInfo._functions.fn_standardName(l.ocn);	//Assume OCN is equivalent to SPID
					self.operator_full_name							:= l.ocn_name;																		//Assume OCN is equivalent to SPID
					self.is_current											:= TRUE;
					self.data_type 											:= '';	
					self.ocn_state 											:= l.ocn_state;
					self.overall_ocn 										:= '';
					self.target_ocn											:= '';
					self.overall_target_ocn							:= '';
					self.ocn_abbr_name									:= '';
					self.rural_lec_indicator 						:= '';
					self.small_ilec_indicator 					:= '';
					self.category												:= '';
					self.carrier_address1								:= '';
					self.carrier_address2								:= '';
					self.carrier_floor									:= '';
					self.carrier_room										:= '';
					self.carrier_city										:= '';
					self.carrier_state									:= '';
					self.carrier_zip										:= '';
					self.carrier_phone									:= '';
					self.affiliated_to									:= '';
					self.overall_company								:= '';
					self.contact_function								:= l.contact_function;
					self.contact_name										:= map(l.infoCt=5 and regexfind('SUBPOENA COMPLIANCE', trim(ut.Word(l.contact_information, 1,','), left, right), 0)<>'' => trim(ut.Word(l.contact_information, 1,','), left, right)+', '+trim(ut.Word(l.contact_information, 2,','), left, right),
																										 l.infoCt=5 and regexfind('JR', trim(ut.Word(l.contact_information, 2,','), left, right), 0)<>'' 									=> trim(ut.Word(l.contact_information, 1,','), left, right)+', '+trim(ut.Word(l.contact_information, 2,','), left, right),		
																										 std.str.Find(l.contact_information, ',', 1)<>0 																																	=> trim(ut.Word(l.contact_information, 1,','), left, right),
																										 '');
					self.contact_title									:= '';				
					self.contact_address1 							:= map(l.infoCt=5 and regexfind('SUBPOENA COMPLIANCE', trim(ut.Word(l.contact_information, 1,','), left, right), 0)<>'' => trim(ut.Word(l.contact_information, 3,','), left, right),	
																										 l.infoCt=5 and regexfind('JR', trim(ut.Word(l.contact_information, 2,','), left, right), 0)<>'' 									=> trim(ut.Word(l.contact_information, 3,','), left, right),		
																										 l.infoCt=5 and regexfind('BOX|FL|SUITE', trim(ut.Word(l.contact_information, 3,','), left, right), 0)<>'' 				=> trim(ut.Word(l.contact_information, 2,','), left, right),
																										 l.infoCt=5 and length(trim(ut.Word(l.contact_information, 4,','), left, right))=2																=> trim(ut.Word(l.contact_information, 2,','), left, right),	
																										 l.infoCt=5 																																																			=> trim(ut.Word(l.contact_information, 2,','), left, right),	
																										 l.infoCt=4																																																				=> trim(ut.Word(l.contact_information, 2,','), left, right),
																											'');																						
					self.contact_address2 							:= map(l.infoCt=5 and regexfind('SUBPOENA COMPLIANCE', trim(ut.Word(l.contact_information, 1,','), left, right), 0)<>'' => '',	
																										 l.infoCt=5 and regexfind('BOX|FL|SUITE', trim(ut.Word(l.contact_information, 3,','), left, right), 0)<>'' 				=> trim(ut.Word(l.contact_information, 3,','), left, right),
																										 l.infoCt=5 and regexfind('JR', trim(ut.Word(l.contact_information, 2,','), left, right), 0)='' 									=> trim(ut.Word(l.contact_information, 3,','), left, right),
																										 l.infoCt=4 and regexfind('#', trim(ut.Word(l.contact_information, 3,','), left, right), 0)<>'' 									=> trim(ut.Word(l.contact_information, 3,','), left, right),
																											'');
					self.contact_city 									:= map(l.infoCt=5 and regexfind('SUBPOENA COMPLIANCE', trim(ut.Word(l.contact_information, 1,','), left, right), 0)<>'' => trim(ut.Word(l.contact_information, 4,','), left, right),
																										 l.infoCt=5 and regexfind('BOX|FL|SUITE', trim(ut.Word(l.contact_information, 3,','), left, right), 0)<>'' 				=> trim(ut.Word(l.contact_information, 4,','), left, right),
																										 l.infoCt=5 and length(trim(ut.Word(l.contact_information, 4,','), left, right))=2																=> trim(ut.Word(l.contact_information, 3,','), left, right),	
																										 l.infoCt=5 																																																			=> trim(ut.Word(l.contact_information, 4,','), left, right),
																										 l.infoCt=4 and regexfind('#', trim(ut.Word(l.contact_information, 3,','), left, right), 0)<>'' 									=> trim(ut.Word(l.contact_information, 4,','), left, right)[1..stringlib.stringfind(trim(ut.Word(l.contact_information, 4,','), left, right), ' ', 1)],	
																										 l.infoCt=4 																																																			=> trim(ut.Word(l.contact_information, 3,','), left, right),
																											'');
					self.contact_state									:= map(l.infoCt=5 and regexfind('SUBPOENA COMPLIANCE', trim(ut.Word(l.contact_information, 1,','), left, right), 0)<>'' => stringlib.stringfilter(trim(ut.Word(l.contact_information, 5,','), left, right),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), 
																										 l.infoCt=5 and regexfind('BOX|FL|SUITE', trim(ut.Word(l.contact_information, 3,','), left, right), 0)<>''        => stringlib.stringfilter(trim(ut.Word(l.contact_information, 5,','), left, right),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')[1..2],
																										 l.infoCt=5 and length(trim(ut.Word(l.contact_information, 4,','), left, right))=2 																=> stringlib.stringfilter(trim(ut.Word(l.contact_information, 4,','), left, right),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
																										 l.infoCt=5 																																																			=> stringlib.stringfilter(trim(ut.Word(l.contact_information, 5,','), left, right),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')[1..2],	
																										 l.infoCt=4 and regexfind('#', trim(ut.Word(l.contact_information, 3,','), left, right), 0)<>'' 									=> trim(trim(ut.Word(l.contact_information, 4,','), left, right)[stringlib.stringfind(trim(ut.Word(l.contact_information, 4,','), left, right), ' ', 1)..stringlib.stringfind(trim(ut.Word(l.contact_information, 4,','), left, right), ' ', 2)], all),
																										 l.infoCt=4 																																																			=> stringlib.stringfilter(trim(ut.Word(l.contact_information, 4,','), left, right),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')[1..2],
																											'');
					self.contact_zip										:= map(l.infoCt=5 and regexfind('SUBPOENA COMPLIANCE', trim(ut.Word(l.contact_information, 1,','), left, right), 0)<>'' => stringlib.stringfilter(trim(ut.Word(l.contact_information, 5,','), left, right), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),
																										 l.infoCt=5 and regexfind('BOX|FL|SUITE', trim(ut.Word(l.contact_information, 3,','), left, right), 0)<>'' 				=> stringlib.stringfilter(trim(ut.Word(l.contact_information, 5,','), left, right), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),
																										 l.infoCt=5 and length(trim(ut.Word(l.contact_information, 4,','), left, right))=2 																=> trim(ut.Word(l.contact_information, 5,','), left, right),
																										 l.infoCt=5 																																																			=> stringlib.stringfilter(trim(ut.Word(l.contact_information, 5,','), left, right), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),	
																										 l.infoCt=4 and regexfind('#', trim(ut.Word(l.contact_information, 3,','), left, right), 0)<>'' 									=> trim(trim(ut.Word(l.contact_information, 4,','), left, right)[stringlib.stringfind(trim(ut.Word(l.contact_information, 4,','), left, right), ' ', 2)..], all),		
																										 l.infoCt=4 																																																			=> stringlib.stringfilter(trim(ut.Word(l.contact_information, 4,','), left, right), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),
																											'');
					self.contact_phone									:= if(std.str.Find(l.contact_information, 'DEDICATED FAX', 1)<>0 and PhonesInfo._Functions.fn_standardName(l.contact_phone)<>'', 
																										'',
																										PhonesInfo._Functions.fn_standardName(l.contact_phone));
					self.contact_fax										:= if(std.str.Find(l.contact_information, 'DEDICATED FAX', 1)<>0 and PhonesInfo._Functions.fn_standardName(l.contact_phone)<>'', PhonesInfo._Functions.fn_standardName(l.contact_phone),
																										map((std.str.Find(l.contact_information, ' FAX ', 1)<>0 or std.str.Find(l.contact_information, ' FAX: ', 1)<>0) and stringlib.stringfilter(l.contact_information[std.str.Find(l.contact_information, ' FAX ', 1)+5..], '0123456789')[1]='1' => stringlib.stringfilter(l.contact_information[std.str.Find(l.contact_information, ' FAX ', 1)+5..], '0123456789')[2..],
																										    std.str.Find(l.contact_information, ' FAX ', 1)<>0 or std.str.Find(l.contact_information, ' FAX: ', 1)<>0 																																																															=> stringlib.stringfilter(l.contact_information[std.str.Find(l.contact_information, ' FAX ', 1)+5..], '0123456789'),
																												''));
					self.contact_email									:= map(std.str.Find(l.contact_information, ' EMAIL: ', 1)<>0 																																							=> l.contact_information[std.str.Find(l.contact_information, ' EMAIL: ', 1)+8..],
																										 std.str.Find(l.contact_information, ' EMAIL ADDRESS: ', 1)<>0 																																			=> l.contact_information[std.str.Find(l.contact_information, ' EMAIL ADDRESS: ', 1)+17..],
																										 std.str.Find(l.contact_information, ' EMAIL ', 1)<>0 																																							=> l.contact_information[std.str.Find(l.contact_information, ' EMAIL ', 1)+7..], 
																										 std.str.Find(trim(l.contact_information, left, right),' ',1)=0 and std.str.Find(trim(l.contact_information, left, right),'@',1)<>0 => trim(l.contact_information, left, right), 
																										 '');
					self.contact_information						:= l.contact_information;
					self.prim_range											:= '';
					self.predir													:= '';
					self.prim_name											:= '';
					self.addr_suffix										:= '';
					self.postdir												:= '';
					self.unit_desig											:= '';
					self.sec_range											:= '';
					self.p_city_name										:= '';
					self.v_city_name										:= '';
					self.st															:= '';
					self.z5															:= '';
					self.zip4														:= '';
					self.cart														:= '';
					self.cr_sort_sz											:= '';
					self.lot														:= '';
					self.lot_order											:= '';
					self.dpbc														:= '';
					self.chk_digit											:= '';
					self.rec_type												:= '';
					self.ace_fips_st										:= '';
					self.fips_county										:= '';
					self.geo_lat												:= '';
					self.geo_long												:= '';
					self.msa														:= '';
					self.geo_blk												:= '';
					self.geo_match											:= '';
					self.err_stat												:= '';	
					self.append_rawaid									:= 0;
					self.address_type										:= '';
					self.privacy_indicator 							:= '';
					self.address1												:= '';
					self.address2												:= '';
					self.country												:= if(PhonesInfo._Functions.fn_isUSStateTerr(l.ocn_state),
																										'US',
																									if(PhonesInfo._Functions.fn_isCanTerr(l.ocn_state),
																										'CA',
																										l.ocn_state));
					self.opname													:= '';
					self.is_new													:= '';
					self.rec_update											:= '';
					self 																:= l;
				end;
			
	EXPORT Lerg1Con := project(dsLerg1Con, lerg1ConTr(left)):independent;
	
END;