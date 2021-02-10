import DID_Add;

export Function_Link_Masters(
	Interface_AsMasters.Unlinked.Base unlinked_data,
	dataset(Layout_Linking.Linked) linkage,
	dataset(Layout_LLID.Linked) old_llid = dataset([],Layout_LLID.Linked)) := module(Interface_AsMasters.Linked.Base)

	export dataset(Layout_LLID.Linked) As_LLID_Master := Function_LLID(linkage,old_llid);

	shared tempdeduplinking :=
		dedup(sort(
			distribute(linkage,hash64(source,source_docid)),
			source,source_docid,source_party,bid,local),source,source_docid,source_party,local);

	export dataset(Layout_Abstract.Linked) As_Abstract_Master := function

		add_ids := join(
			distribute(unlinked_data.As_Abstract_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid and
			left.source_party = right.source_party,
			transform(Layout_Abstract.Linked,
				self.bid := right.bid,
				self := left),
			local);

		return dedup(add_ids,record,all);

	end;

	export dataset(Layout_Aircraft.Main.Linked) As_Aircraft_Master := function

		add_ids := join(
			distribute(unlinked_data.As_Aircraft_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid,
			transform(Layout_Aircraft.Main.Linked,
				self.bid := right.bid,
				self.source_party := right.source_party,
				self := left),
			local);
		return dedup(add_ids,record,all);

	end;

	export dataset(Layout_Aircraft.Party) As_Aircraft_Master_Party := unlinked_data.As_Aircraft_Master_Party;

	export dataset(Layout_Bankruptcy.Main.Linked) As_Bankruptcy_Master := function

		add_ids := join(
			distribute(unlinked_data.As_Bankruptcy_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid,
			transform(Layout_Bankruptcy.Main.Linked,
				self.bid := right.bid,
				self.source_party := right.source_party,
				self := left),
			local);

		return dedup(add_ids,record,all);

	end;

	export dataset(Layout_Bankruptcy.Party) As_Bankruptcy_Master_Party := unlinked_data.As_Bankruptcy_Master_Party;

	export dataset(Layout_Contacts.Linked) As_Contact_Master := function

		add_ids := join(
			distribute(unlinked_data.As_Contact_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid and
			left.source_party = right.source_party,
			transform(Layout_Contacts.Linked,
				self.position_title := trim(stringlib.StringToUpperCase(left.position_title),left,right),
				self.bid := right.bid,
				self.brid := right.brid,
				self.blid := right.blid,
				self.segment_bid := right.segment_bid,
				self := left,
				self := []),
			local);

		pattern p_split_chars := pattern('[,;/&]');
		pattern p_nosplit_chars := pattern('[^,;/&]');
		pattern p_split_word := p_nosplit_chars*;
		pattern p_split_word_find := (p_split_word after (first or p_split_chars)) before (p_split_chars or last);

		tempdedup := dedup(add_ids(position_type = 'C'),position_title,all);

		tempparse := parse(tempdedup,trim(position_title),p_split_word_find,transform({tempdedup.position_title;string clean_position;},
			self.clean_position := trim(matchtext(p_split_word),left,right),
			self := left),scan all);

		pattern p_separator_word := ' AND ' or ' OR ';
		pattern p_separator_word_find := (p_split_word after (first or p_separator_word)) before (p_separator_word or last);

		tempparse2 := parse(tempparse,trim(clean_position),p_separator_word_find,transform(recordof(tempparse),
			self.clean_position := trim(matchtext(p_split_word),left,right),
			self := left),scan all);

		tempreplacepunc := project(tempparse2,transform(recordof(tempparse2),
			self.clean_position := stringlib.StringCleanSpaces(regexreplace('[^A-Z0-9 ]',left.clean_position,' ')),
			self := left));

		tempreplacephrases := project(tempreplacepunc,transform(recordof(tempreplacepunc),
			tempaddspace := ' ' + left.clean_position + ' ';
			tempceo := regexreplace(' CEO ',tempaddspace,' CHIEF EXECUTIVE OFFICER ');
			tempcfo := regexreplace(' CFO ',tempceo,' CHIEF FINANCIAL OFFICER ');
			temppres := regexreplace(' PRES ',tempceo,' PRESIDENT ');
			tempsenior := regexreplace(' SENIOR ',temppres,' SR ');
			tempexec := regexreplace(' EXEC ',tempsenior,' EXECUTIVE ');
			tempvp := regexreplace(' VP ',tempexec,' VICE PRESIDENT ');
			tempdir := regexreplace(' DIR ',tempvp,' DIRECTOR ');
			tempplurals := regexreplace(' (PRESIDENT|TRUSTEE|MANAGER|PROFESSOR|MEMBER|OWNER|OFFICER)S ',tempdir,' $1 ');
			tempvicepresident := regexreplace(' VICEPRESIDENT ',tempplurals,' VICE PRESIDENT ');
			tempvicepres := regexreplace(' VICEPRES ',tempvicepresident,' VICE PRESIDENT ');
			temppresi := regexreplace(' PRESI ',tempvicepres,' PRESIDENT ');
			temptreas := regexreplace(' (TREAS|TRES) ',temppresi,' TREASURER ');
			temptothe := regexreplace(' (.*) TO THE (.*) ',temptreas,' $1 ');
			tempof := regexreplace(' (.*) OF (.*) ',temptothe,' $1 ');
			self.clean_position := trim(tempof,left,right),
			self := left));

		tempselect := project(tempreplacephrases,transform(recordof(tempreplacephrases),
			tempaddspaces := ' ' + left.clean_position + ' ';
			self.clean_position := map(
				stringlib.StringFind(tempaddspaces,' CHIEF EXECUTIVE OFFICER ',1) > 0 => 'CHIEF EXECUTIVE OFFICER',
				stringlib.StringFind(tempaddspaces,' CHIEF FINANCIAL OFFICER ',1) > 0 => 'CHIEF FINANCIAL OFFICER',
				stringlib.StringFind(tempaddspaces,' CHIEF OPERATING OFFICER ',1) > 0 => 'CHIEF OPERATING OFFICER',
				stringlib.StringFind(tempaddspaces,' CHIEF TECHNOLOGY OFFICER ',1) > 0 => 'CHIEF TECHNOLOGY OFFICER',
				stringlib.StringFind(tempaddspaces,' CHIEF INFORMATION OFFICER ',1) > 0 => 'CHIEF INFORMATION OFFICER',
				regexfind(' CHIEF (.* )?OFF',tempaddspaces) => 'CHIEF OFFICER',
				stringlib.StringFind(tempaddspaces,' CHIEF ',1) > 0 => 'CHIEF',
				stringlib.StringFind(tempaddspaces,' OWNER ',1) > 0 => 'OWNER',
				stringlib.StringFind(tempaddspaces,' VICE CHAIR',1) > 0 => 'VICE CHAIRPERSON',
				stringlib.StringFind(tempaddspaces,' CHAIR',1) > 0 => 'CHAIRPERSON',
				stringlib.StringFind(tempaddspaces,' BOARD ',1) > 0 and stringlib.StringFind(tempaddspaces,' MEMBER ',1) > 0 => 'BOARD MEMBER',
				regexfind(' SR (.* )?DIRECTOR ',tempaddspaces) => 'SR DIRECTOR',
				regexfind(' SR (.* )?MANAGER ',tempaddspaces) => 'SR MANAGER',
				regexfind(' GENERAL (.* )?MANAGER ',tempaddspaces) => 'GENERAL MANAGER',
				stringlib.StringFind(tempaddspaces,' DIRECTOR ',1) > 0 => 'DIRECTOR',
				stringlib.StringFind(tempaddspaces,' MANAGER ',1) > 0 => 'MANAGER',
				stringlib.StringFind(tempaddspaces,' SR EXECUTIVE VICE PRESIDENT ',1) > 0 => 'SR EXECUTIVE VICE PRESIDENT',
				stringlib.StringFind(tempaddspaces,' EXECUTIVE VICE PRESIDENT ',1) > 0 => 'EXECUTIVE VICE PRESIDENT',
				stringlib.StringFind(tempaddspaces,' SR VICE PRESIDENT ',1) > 0 => 'SR VICE PRESIDENT',
				stringlib.StringFind(tempaddspaces,' VICE PRESIDENT ',1) > 0 => 'VICE PRESIDENT',
				stringlib.StringFind(tempaddspaces,' PRESIDENT ',1) > 0 => 'PRESIDENT',
				stringlib.StringFind(tempaddspaces,' TRUSTEE ',1) > 0 => 'TRUSTEE',
				stringlib.StringFind(tempaddspaces,' PROFESSOR ',1) > 0 => 'PROFESSOR',
				regexfind(' ASSISTANT $',tempaddspaces) => 'ASSISTANT',
				stringlib.StringFind(tempaddspaces,' HUMAN ',1) > 0 => 'HUMAN RESOURCES',
				stringlib.StringFind(tempaddspaces,' MARK',1) > 0 => 'MARKETING',
				stringlib.StringFind(tempaddspaces,' SALES',1) > 0 => 'SALES',
				stringlib.StringFind(tempaddspaces,' OFFICER ',1) > 0 => 'OFFICER',
				'CONTACT'),
			self := left));

		normalized_contacts := join(
			distribute(add_ids(position_title != ''),hash64(position_title)),
			distribute(tempselect(clean_position != ''),hash64(position_title)),
			left.position_title = right.position_title,
			transform(recordof(add_ids),
				self.ln_position_title := right.clean_position,
				self := left),
			left outer,
			local) + add_ids(position_title = '' or position_type != 'C');

			// pos_layout := recordof(constants.normalized_set);
			// outpos_layout := record
				// pos_layout - [normalizedTitle2,normalizedTitle3];
			// end;

			// outpos_layout exec_transform( pos_layout l,
			                           // integer c) := transform
			     // self.normalizedTitle := map(
						 // c = 1 => l.normalizedTitle,
						 // c = 2 => l.normalizedTitle2,
						 // /*owise*/l.normalizedTitle3),
					 // self := l;
			// end;

    // fully_normalized := normalize(constants.normalized_set,
		                         // map( left.normalizedTitle3 != '' => 3,
														      // left.normalizedTitle2 != '' => 2,
																	// 1),
                              // exec_transform(left,counter));


    // normalized_contacts := join(add_ids, fully_normalized,
		                       // left.position_title = right.position,
													 // transform(recordof(add_ids),
													 // self.position_title := if (right.position = '', left.position_title,right.normalizedTitle);
													 // self := left), left outer, lookup);




		DID_Add.MAC_Match_Flex( normalized_contacts,['A','S','P','4','Z'],
			ssn,'',name_first,name_middle,name_last,name_suffix,
			prim_range,prim_name,sec_range,zip,state,phone,
			did,
			recordof(add_ids),
			true,score,
			75,
			add_ids_dids)

		return project(dedup(add_ids_dids,record,all),Layout_Contacts.Linked);

	end;

	export dataset(Layout_FEINs.Linked) As_FEIN_Master := function

		base := project(tempdeduplinking(fein != ''),Layout_FEINs.Linked);

		return dedup(base,record,all);

	end;

	export dataset(Layout_Finance.Linked) As_Finance_Master := function

		add_ids := join(
			distribute(unlinked_data.As_Finance_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid and
			left.source_party = right.source_party,
			transform(Layout_Finance.Linked,
				self.bid := right.bid,
				self := left),
			local);

		return dedup(add_ids,record,all);

	end;

	// export dataset(Layout_Foreclosure.Main.Linked) As_Foreclosure_Master := function

		// add_ids := join(
			// distribute(unlinked_data.As_Foreclosure_Master,hash64(source,source_docid)),
			// tempdeduplinking,
			// left.source = right.source and
			// left.source_docid = right.source_docid,
			// transform(Layout_foreclosure.main.Linked,
				// self.bid := right.bid,
				// self := left),
			// local);

		// return dedup(add_ids,record,all);

	// end;

	// export dataset(Layout_Foreclosure.Party.Linked) As_Foreclosure_Master_Party := function

		// add_source_docid := project(
			// unlinked_data.As_Foreclosure_Master_Party,
			// transform({unlinked_data.As_Foreclosure_Master_Party,string2 source;string50 source_docid;string10 source_party;},
				// self.source := MDR.sourceTools.src_Foreclosures,
				// self.source_docid := left.foreclosure_id,
				// self.source_party := '',
				// self := left));

		// add_ids := join(
			// distribute(add_source_docid,hash64(source,source_docid)),
			// tempdeduplinking,
			// left.source = right.source and
			// left.source_docid = right.source_docid and
			// left.source_party = right.source_party,
			// transform(Layout_Foreclosure.Party.Linked,
				// self.bid := right.bid,
				// self := left),
			// local);

		// return dedup(add_ids,record,all);

	// end;

	export dataset(Layout_Incorporation.Linked) As_Incorporation_Master := function

		add_ids := join(
			distribute(unlinked_data.As_Incorporation_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid and
			left.source_party = right.source_party,
			transform(Layout_Incorporation.Linked,
				self.bid := right.bid,
				self.ln_corp_status_desc := '',
				self := left),
			local);

		add_ln_desc := join(add_ids,TopBusiness.Constants.Corp_Active_DS,
			left.corp_state_origin = right.stateAbbrev and
			left.corp_status_desc = right.codeDescrpt,
			transform(Layout_Incorporation.Linked,
				self.ln_corp_status_desc := right.LNNormalizedStatus,
				self := left),
			left outer,
			lookup);

		return dedup(add_ln_desc,record,all);

	end;

	export dataset(Layout_Industry.Linked) As_Industry_Master := function

		add_ids := join(
			distribute(unlinked_data.As_Industry_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid and
			left.source_party = right.source_party,
			transform(Layout_Industry.Linked,
				self.bid := right.bid,
				self := left),
			local);

		return dedup(add_ids,record,all);

	end;

	export dataset(Layout_License.Linked) As_License_Master := function

		add_ids := join(
			distribute(unlinked_data.As_License_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid and
			left.source_party = right.source_party,
			transform(Layout_License.Linked,
				self.bid := right.bid,
				self := left),
			local);

		return dedup(add_ids,record,all);

	end;

	export dataset(Layout_Liens.Main.Linked) As_Liens_Master := function

		add_ids := join(
			distribute(unlinked_data.As_Liens_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid,
			transform(Layout_Liens.Main.Linked,
				self.bid := right.bid,
				self.source_party := right.source_party,
				self := left),
			local);

		return dedup(add_ids,record,all);

	end;

	export dataset(Layout_Liens.Party) As_Liens_Master_Party := unlinked_data.As_Liens_Master_Party;

	export dataset(Layout_Mark.Linked) As_Mark_Master := function

		add_ids := join(
			distribute(unlinked_data.As_Mark_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid and
			left.source_party = right.source_party,
			transform(Layout_Mark.Linked,
				self.bid := right.bid,
				self := left),
			local);

		return dedup(add_ids,record,all);

	end;

	MotorVehicle_add_ids := join(
		distribute(unlinked_data.As_MotorVehicle_Master,hash64(source,source_docid)),
		tempdeduplinking,
		left.source = right.source and
		left.source_docid = right.source_docid,
		transform(Layout_MotorVehicle.Main.Linked,
			self.bid := right.bid,
			self.party_type    := right.source_party[1],
			self := left,
			self := []),
		local);

	MotorVehicle_Combined_Events :=
		join(
			dedup(distribute(MotorVehicle_add_ids,hash64(vehicle_id)),vehicle_id,all,local),
			dedup(distribute(
				table(unlinked_data.As_MotorVehicle_Master_Registration,{vehicle_id,event_id,date := registration_date}) +
				table(unlinked_data.As_MotorVehicle_Master_Title,{vehicle_id,event_id,date := title_date}),hash64(vehicle_id)),vehicle_id,event_id,all,local),
			left.vehicle_id = right.vehicle_id,
			local);

	MotorVehicle_Combined_Parties :=
		join(
			distribute(MotorVehicle_Combined_Events,hash64(event_id)),
			dedup(distribute(unlinked_data.As_MotorVehicle_Master_Party,hash64(event_id)),event_id,record,all,local),
			left.event_id = right.event_id,
			transform(Layout_MotorVehicle.Main.Linked,
				self.key_date_9999 := 99999999 - (unsigned4)left.date,
				self.current_prior := if(right.history = '',Constants.CURRENT,Constants.PRIOR),
				self := left),
			local);

	export dataset(Layout_MotorVehicle.Main.Linked) As_MotorVehicle_Master := function

		return dedup(dedup(MotorVehicle_Combined_Parties,record,all,local),record,all);

	end;

	export dataset(Layout_MotorVehicle.Registration) As_MotorVehicle_Master_Registration := unlinked_data.As_MotorVehicle_Master_Registration;
	export dataset(Layout_MotorVehicle.Title) As_MotorVehicle_Master_Title := unlinked_data.As_MotorVehicle_Master_Title;
	export dataset(Layout_MotorVehicle.Party) As_MotorVehicle_Master_Party := unlinked_data.As_MotorVehicle_Master_Party;

	shared tempmainids0 := join(
		distribute(unlinked_data.As_Property_Master,hash64(source,source_docid)),
		tempdeduplinking,
		left.source = right.source and
		left.source_docid = right.source_docid,
		transform(Layout_Property.Main.Linked,
			self.bid := right.bid,
			self.source_party := right.source_party,
			self.property_id := map(
				left.county_code != '' and left.apn != '' => 'APN'+hash64(left.county_code,left.apn),
				left.property_address.StreetNumber != '' and left.property_address.StreetName != '' and left.property_address.Zip5 != '' => 'ADD'+hash64(left.property_address.StreetNumber,left.property_address.StreetPredirection,left.property_address.StreetName,left.property_address.StreetSuffix,left.property_address.StreetPostdirection,left.property_address.UnitNumber,left.property_address.Zip5),
				'FAR' + left.event_id),
			self.current_flag := false,
			self.owner_date := 0,
			self := left),
		local);

	shared tempmainids := join(
		distribute(tempmainids0(property_id[1..3]='ADD'),hash64(property_address.StreetNumber,property_address.StreetPredirection,property_address.StreetName,property_address.StreetSuffix,property_address.StreetPostdirection,property_address.UnitNumber,property_address.Zip5)),
		distribute(tempmainids0(property_id[1..3]='APN'),hash64(property_address.StreetNumber,property_address.StreetPredirection,property_address.StreetName,property_address.StreetSuffix,property_address.StreetPostdirection,property_address.UnitNumber,property_address.Zip5)),
		left.property_address.StreetNumber = right.property_address.StreetNumber and
		left.property_address.StreetPredirection = right.property_address.StreetPredirection and
		left.property_address.StreetName = right.property_address.StreetName and
		left.property_address.StreetSuffix = right.property_address.StreetSuffix and
		left.property_address.StreetPostdirection = right.property_address.StreetPostdirection and
		left.property_address.UnitNumber = right.property_address.UnitNumber and
		left.property_address.Zip5 = right.property_address.Zip5,
		transform(Layout_Property.Main.Linked,
			self.property_id := if(right.property_id = '',left.property_id,right.property_id),
			self := left),
		left outer,
		local) + tempmainids0(property_id[1..3] != 'ADD');

	shared tempslimdedup := dedup(tempmainids,event_id,property_id,all);

	shared tempassessments := join(
		distribute(unlinked_data.As_Property_Master_Assessment,hash64(event_id)),
		distribute(tempslimdedup,hash64(event_id)),
		left.event_id = right.event_id,
		transform(Layout_Property.Assessment.Linked,
			self.property_id := right.property_id,
			self := left),
		local);

	shared tempdeeds := join(
		distribute(unlinked_data.As_Property_Master_Deed,hash64(event_id)),
		distribute(tempslimdedup,hash64(event_id)),
		left.event_id = right.event_id,
		transform(Layout_Property.Deed.Linked,
			self.property_id := right.property_id,
			self := left),
		local);

	shared tempforeclosures := join(
		distribute(unlinked_data.As_Property_Master_Foreclosure,hash64(foreclosure_event_id)),
		distribute(tempslimdedup,hash64(event_id)),
		left.foreclosure_event_id = right.event_id,
		transform(Layout_Property.Foreclosure.Linked,
			self.property_id := right.property_id,
			self.deed_event_id := '',
			self := left),
		local);

	tempparties := join(
		distribute(unlinked_data.As_Property_Master_Party,hash64(event_id)),
		distribute(tempslimdedup,hash64(event_id)),
		left.event_id = right.event_id,
		transform({recordof(unlinked_data.As_Property_Master_Party);tempslimdedup.property_id;},
			self.property_id := right.property_id,
			self := left),
		local);

	// tempforeclosuresids := join(
		// distribute(unlinked_data.As_Property_Master_Foreclosure,hash64(source,source_docid)),
		// tempdeduplinking,
		// left.source = right.source and
		// left.source_docid = right.source_docid and
		// left.source_party = right.source_party,
		// transform(Layout_Property.Foreclosure.Linked,
			// self.bid := right.bid,
			// self := left),
		// local);

	shared temppartiesids := join(
		distribute(tempparties,hash64(source,source_docid)),
		tempdeduplinking,
		left.source = right.source and
		left.source_docid = right.source_docid and
		left.source_party = right.source_party,
		transform(Layout_Property.Party.Linked,
			self.bid := right.bid,
			self := left),
		local);

	sorted_deeds := sort(tempdeeds,property_id,-if(contract_date != '',contract_date,recording_date),record);
	most_recent_deeds := dedup(sorted_deeds,property_id);
	apply_indicator := join(sorted_deeds,most_recent_deeds,
		left.property_id = right.property_id,
		transform({recordof(sorted_deeds),boolean current_flag;},
			self.current_flag := if(left.contract_date != '',left.contract_date,left.recording_date) = if(right.contract_date != '',right.contract_date,right.recording_date),
			self := left),
		left outer);

	shared owners_for_deeds := join(
		distribute(apply_indicator,hash64(event_id)),
		distribute(temppartiesids(party_type = 'O' and bid != 0),hash64(event_id)),
		left.event_id = right.event_id,
		transform({apply_indicator;temppartiesids.bid;},
			self.bid := right.bid,
			self := left),
		left outer,
		local);

	parties_on_foreclosures := join(
		distribute(tempforeclosures,hash64(foreclosure_event_id)),
		distribute(temppartiesids,hash64(event_id)),
		left.foreclosure_event_id = right.event_id,
		transform({tempforeclosures;temppartiesids.bid;},
			self.bid := right.bid,
			self := left),
		left outer,
		local);

	shared deeds_for_foreclosures_by_bid := join(
		distribute(parties_on_foreclosures,hash64(property_id,bid)),
		dedup(sort(distribute(owners_for_deeds,hash64(property_id,bid)),property_id,bid,-if(contract_date != '',contract_date,recording_date),local),property_id,bid,local),
		left.bid != 0 and
		left.property_id = right.property_id and
		left.bid = right.bid,
		transform(Layout_Property.Foreclosure.Linked,
			self.deed_event_id := right.event_id,
			self := left),
		left outer,
		local);

	shared add_current_flag := join(
		distribute(tempmainids,hash64(property_id,bid)),
		dedup(sort(distribute(owners_for_deeds,hash64(property_id,bid)),property_id,bid,if(current_flag,0,1),-if(contract_date != '',contract_date,recording_date),local),property_id,bid,local),
		left.property_id = right.property_id and
		left.bid = right.bid,
		transform(recordof(tempmainids),
			self.current_flag := right.current_flag,
			self.owner_date := (unsigned4)if(right.contract_date != '',right.contract_date,right.recording_date),
			self := left),
		left outer,
		local);

	deeds_for_foreclosures_by_date := join(
		distribute(deeds_for_foreclosures_by_bid,hash64(property_id)),
		distribute(owners_for_deeds,hash64(property_id)),
		left.deed_event_id = '' and
		left.property_id = right.property_id and
		(unsigned4)if(left.recordingdate != '',left.recordingdate,left.auction_date) > (unsigned4)if(right.contract_date != '',right.contract_date,right.recording_date),
		transform({Layout_Property.Foreclosure.Linked;add_current_flag.owner_date;},
			self.deed_event_id := if(left.deed_event_id != '',left.deed_event_id,right.event_id),
			self.owner_date := (unsigned4)if(right.contract_date != '',right.contract_date,right.recording_date),
			self := left),
		left outer,
		local);

	shared deeds_for_foreclosures :=
		project(
			dedup(sort(deeds_for_foreclosures_by_date,property_id,-owner_date,local),property_id,local),
			Layout_Property.Foreclosure.Linked);

	export dataset(Layout_Property.Main.Linked) As_Property_Master := function

		return dedup(dedup(add_current_flag,record,all,local),record,all);

	end;

	export dataset(Layout_Property.Party.Linked) As_Property_Master_Party := function

		return dedup(dedup(temppartiesids,record,all,local),record,all);

	end;

	export dataset(Layout_Property.Assessment.Linked) As_Property_Master_Assessment := function

		return dedup(dedup(tempassessments,record,all,local),record,all);

	end;

	export dataset(Layout_Property.Deed.Linked) As_Property_Master_Deed := function

		return dedup(dedup(tempdeeds,record,all,local),record,all);

	end;

	export dataset(Layout_Property.Foreclosure.Linked) As_Property_Master_Foreclosure := function

		return dedup(dedup(deeds_for_foreclosures,record,all,local),record,all);

	end;

	export dataset(Layout_Relationship.Linked) As_Relationship_Master := function

		add_ids_1 := join(
			distribute(unlinked_data.As_Relationship_Master,hash64(source_1,source_docid_1)),
			tempdeduplinking,
			left.source_1 = right.source and
			left.source_docid_1 = right.source_docid and
			(left.source_party_1 = '' or left.source_party_1 = right.source_party),
			transform(Layout_Relationship.Linked,
				self.source_party_1 := right.source_party,
				self.bid_1 := right.bid,
				self.bid_2 := 0,
				self := left),
			local);

		add_ids_2 := join(
			distribute(add_ids_1,hash64(source_2,source_docid_2)),
			tempdeduplinking,
			left.source_2 = right.source and
			left.source_docid_2 = right.source_docid and
			(left.source_party_2 = '' or left.source_party_2 = right.source_party),
			transform(Layout_Relationship.Linked,
				self.source_party_2 := right.source_party,
				self.bid_2 := right.bid,
				self := left),
			local);

		return dedup(add_ids_2,record,all);

	end;

	export dataset(Layout_TradeLines.Linked) As_TradeLine_Master := function

		return join(
			distribute(unlinked_data.As_TradeLine_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid and
			left.source_party = right.source_party,
			transform(Layout_TradeLines.Linked,
				self.bid := right.bid,
				self := left),
			local);

	end;

	export dataset(Layout_UCC.Main.Linked) As_UCC_Master := function

		add_ids := join(
			distribute(unlinked_data.As_UCC_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid,
			transform(Layout_UCC.Main.Linked,
				self.bid := right.bid,
				self.source_party := right.source_party,
				self.status_code := '',
				self := left),
			local);

		terminated := add_ids(
			status_type in ['LAPSED','L','RELEASE','EXPUNGED','DELETED','TERMINATED','TERMINATION','UCC3 TERMINATION'] OR
			filing_type in ['LAPSED','L','RELEASE','EXPUNGED','DELETED','TERMINATED','TERMINATION','UCC3 TERMINATION']);

		terminated_dedup := dedup(dedup(terminated,filing_jurisdiction,orig_filing_number,all,local),filing_jurisdiction,orig_filing_number,all);

		add_status_code := join(add_ids,terminated_dedup(filing_jurisdiction != '' and orig_filing_number != ''),
			left.filing_jurisdiction = right.filing_jurisdiction and
			left.orig_filing_number = right.orig_filing_number,
			transform(Layout_UCC.Main.Linked,
				self.status_code := if(right.orig_filing_number = '','A','T'),
				self := left),
			left outer);

		return dedup(add_status_code,record,all);

	end;

	export dataset(Layout_UCC.Party) As_UCC_Master_Party := unlinked_data.As_UCC_Master_Party;

	export dataset(Layout_UCC.Collateral) As_UCC_Master_Collateral := unlinked_data.As_UCC_Master_Collateral;

	export dataset(Layout_URLs.Linked) As_URL_Master := function

		pattern p_nodot := pattern('[^ .]');
		pattern p_prefix_part := (p_nodot+) before('.');
		pattern p_prefix := (p_prefix_part '.')+;
		pattern p_us_suffix := 'gov' or 'com' or 'net' or 'edu' or 'org' or 'mil' or 'info' or 'coop' or 'biz' or 'aero' or 'int';
		pattern p_us_state :=
			'ak' or 'hi' or 'ca' or 'wa' or 'or' or 'id' or 'nv' or 'az' or 'nm' or 'co' or 'ut' or 'wy' or 'mt' or
			'me' or 'vt' or 'nh' or 'ma' or 'ct' or 'ri' or 'ny' or 'nj' or 'pa' or 'md' or 'de' or 'va' or 'wv' or
			'nc' or 'sc' or 'ga' or 'fl' or 'oh' or 'mi' or 'ky' or 'tn' or 'al' or 'ms' or 'la' or 'ar' or 'mo' or
			'in' or 'il' or 'wi' or 'mn' or 'nd' or 'sd' or 'ia' or 'ne' or 'ok' or 'tx' or 'dc' or 'ks';
		pattern p_us_state_suffix := (('k12.' p_us_state) or (p_us_state penalty(10))) '.us';
		pattern p_us := p_us_suffix or p_us_state_suffix;
		pattern p_intl_suffix := p_us_suffix or 'co' or 'ac';
		pattern p_intl_cc := 'eu' or 'yu' or 'su' or 'uk' or 'ad' or 'ae' or 'af' or 'ag' or 'ai' or 'al' or 'am' or 'ao' or 'aq' or 'ar' or 'as' or 'at' or 'au' or 'aw' or 'ax' or 'az' or 'ba' or 'bb' or 'bd' or 'be' or 'bf' or 'bg' or 'bh' or 'bi' or 'bj' or 'bl' or 'bm' or 'bn' or 'bo' or 'bq' or 'br' or 'bs' or 'bt' or 'bv' or 'bw' or 'by' or 'bz' or 'ca' or 'cc' or 'cd' or 'cf' or 'cg' or 'ch' or 'ci' or 'ck' or 'cl' or 'cm' or 'cn' or 'co' or 'cr' or 'cu' or 'cv' or 'cw' or 'cx' or 'cy' or 'cz' or 'de' or 'dj' or 'dk' or 'dm' or 'do' or 'dz' or 'ec' or 'ee' or 'eg' or 'eh' or 'er' or 'es' or 'et' or 'fi' or 'fj' or 'fk' or 'fm' or 'fo' or 'fr' or 'ga' or 'gb' or 'gd' or 'ge' or 'gf' or 'gg' or 'gh' or 'gi' or 'gl' or 'gm' or 'gn' or 'gp' or 'gq' or 'gr' or 'gs' or 'gt' or 'gu' or 'gw' or 'gy' or 'hk' or 'hm' or 'hn' or 'hr' or 'ht' or 'hu' or 'id' or 'ie' or 'il' or 'im' or 'in' or 'io' or 'iq' or 'ir' or 'is' or 'it' or 'je' or 'jm' or 'jo' or 'jp' or 'ke' or 'kg' or 'kh' or 'ki' or 'km' or 'kn' or 'kp' or 'kr' or 'kw' or 'ky' or 'kz' or 'la' or 'lb' or 'lc' or 'li' or 'lk' or 'lr' or 'ls' or 'lt' or 'lu' or 'lv' or 'ly' or 'ma' or 'mc' or 'md' or 'me' or 'mf' or 'mg' or 'mh' or 'mk' or 'ml' or 'mm' or 'mn' or 'mo' or 'mp' or 'mq' or 'mr' or 'ms' or 'mt' or 'mu' or 'mv' or 'mw' or 'mx' or 'my' or 'mz' or 'na' or 'nc' or 'ne' or 'nf' or 'ng' or 'ni' or 'nl' or 'no' or 'np' or 'nr' or 'nu' or 'nz' or 'om' or 'pa' or 'pe' or 'pf' or 'pg' or 'ph' or 'pk' or 'pl' or 'pm' or 'pn' or 'pr' or 'ps' or 'pt' or 'pw' or 'py' or 'qa' or 're' or 'ro' or 'rs' or 'ru' or 'rw' or 'sa' or 'sb' or 'sc' or 'sd' or 'se' or 'sg' or 'sh' or 'si' or 'sj' or 'sk' or 'sl' or 'sm' or 'sn' or 'so' or 'sr' or 'ss' or 'st' or 'sv' or 'sx' or 'sy' or 'sz' or 'tc' or 'td' or 'tf' or 'tg' or 'th' or 'tj' or 'tk' or 'tl' or 'tm' or 'tn' or 'to' or 'tr' or 'tt' or 'tv' or 'tw' or 'tz' or 'ua' or 'ug' or 'um' or 'us' or 'uy' or 'uz' or 'va' or 'vc' or 've' or 'vg' or 'vi' or 'vn' or 'vu' or 'wf' or 'ws' or 'ye' or 'yt' or 'za' or 'zm' or 'zw';
		pattern p_intl := (p_intl_suffix '.' p_intl_cc) or ((p_intl_cc) penalty(10));
		pattern p_suffix := (p_us or p_intl) before('/' or '.' or last);
		pattern p_domain := p_nodot+ '.' p_suffix;
		pattern p_url := opt(p_prefix) p_domain;
		pattern p_ip_node := pattern('[0-9]') or pattern('[1-9][0-9]') or pattern('1[0-9][0-9]') or pattern('2[0-4][0-9]') or pattern('25[0-5]');
		pattern p_ip := p_ip_node '.' p_ip_node '.' p_ip_node '.' p_ip_node;
		pattern p_rest := pattern('.')+;
		pattern p_path := '/' opt(p_rest);
		pattern p_domain_find := first ((p_url or p_ip) opt(p_path)) last;

		Layout_URLs.Linked parseTransform(unlinked_data.As_URL_Master l) := transform
			self.cleanurl := if(matchtext(p_domain) != '',matchtext(p_domain),matchtext(p_ip));
			self.bid := 0;
			self.segment_bid := 0;
			self := l;
		end;

		tempparse := dedup(parse(unlinked_data.As_URL_Master,trim(url),p_domain_find,parseTransform(left),best),record,all);

		add_ids := join(
			distribute(tempparse,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid and
			left.source_party = right.source_party,
			transform(Layout_URLs.Linked,
				self.bid := right.bid,
				self.segment_bid := right.segment_bid,
				self := left),
			local);

		return dedup(add_ids,record,all);

	end;

	export dataset(Layout_Watercraft.Main.Linked) As_Watercraft_Master := function

		add_ids := join(
			distribute(unlinked_data.As_Watercraft_Master,hash64(source,source_docid)),
			tempdeduplinking,
			left.source = right.source and
			left.source_docid = right.source_docid,
			transform(Layout_Watercraft.Main.Linked,
				self.bid := right.bid,
				self.source_party := right.source_party,
				self := left),
			local);

		return dedup(add_ids,record,all);

	end;

	export dataset(Layout_Watercraft.Party) As_Watercraft_Master_Party := unlinked_data.As_Watercraft_Master_Party;

end;
