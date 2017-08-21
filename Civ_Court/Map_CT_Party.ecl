Import Civ_Court, ut, crim_common, address, lib_stringlib, Civil_Court;
#option('multiplePersistInstances',FALSE);

PartyFile := Civ_Court.Map_CT_Joins;

lay_UncleanedParty := Record
  string8 process_date;
  string2 vendor;
  string2 state_origin;
  string20 source_file;
  string60 case_key;
  string60 parent_case_key;
  string10 court_code;
  string60 court;
  string35 case_number;
  string10 case_type_code;
  string60 case_type;
  string175 case_title;
  string5 ruled_for_against_code;
  string20 ruled_for_against;
  string80 entity_1;
  string1 entity_nm_format_1;
  string10 entity_type_code_1_orig;
  string30 entity_type_description_1_orig;
  string2 entity_type_code_1_master;
  string3 entity_seq_num_1;
  string3 atty_seq_num_1;
  string60 entity_1_address_1;
  string60 entity_1_address_2;
  string60 entity_1_address_3;
  string60 entity_1_address_4;
  string8 entity_1_dob;
  string80 primary_entity_2;
  string1 entity_nm_format_2;
  string10 entity_type_code_2_orig;
  string30 entity_type_description_2_orig;
  string2 entity_type_code_2_master;
  string3 entity_seq_num_2;
  string3 atty_seq_num_2;
  string60 entity_2_address_1;
  string60 entity_2_address_2;
  string60 entity_2_address_3;
  string60 entity_2_address_4;
  string8 entity_2_dob;
End;
lay_UncleanedParty xform1(PartyFile L, Unsigned1 c) := Transform
Self.process_date					:=civil_court.Version_Development;
Self.vendor							:='04';
Self.state_origin						:='CT';
Self.source_file						:='CT-CIVIL-COURT';
Self.case_key							:='04'+ Trim(L.LocCode, Left, Right) +(String)L.CaseRefNum;
Self.parent_case_key				:= '';
Self.court_code						:= L.LocCode;
Self.court								:= L.LocDesc;
Self.case_number					:= (String)L.CaseRefNum;
Self.case_type_code				:=Trim(L.CTMajorCd, Left, Right) + Trim(L.CTMinorCd, Left, Right);
Self.case_type						:= L.CTDesc;
Self.case_title							:= If(L.PlaintCapName <>'' and L.DefnCapName <>'', ut.CleanSpacesAndUpper(L.PlaintCapName) + ' ' +
																If(L.PlaintETAL<>'', Trim(L.PlaintETAL, Left, Right), '') + ' VS ' 
																			+ Trim(L.DefnCapName, Left, right) + ' ' +If(L.DefnETAL<>'', Trim(L.DefnETAL, Left, Right), ''), '');
				partyName :=	ut.CleanSpacesAndUpper(L.PartyFirstName+ ' ' + L.PartyMiddleName + ' ' + L.PartyLastName);
				BarMasterName := ut.CleanSpacesAndUpper(L.BR_MST_PREFIX + ' ' + L.BR_MST_FIRST_NM + ' ' + L.BR_MST_MID_NM + ' ' + L.BR_MST_LAST_NM + ' ' + L.BR_MST_SUFFIX);
				EntityName0 := Choose(c,	If(partyName <>'', partyName, Skip), 
																If(BarMasterName<>'', BarMasterName, Skip),
																If(L.PlaintCapName <>'', ut.CleanSpacesAndUpper(L.PlaintCapName), Skip),
																If(L.DefnCapName <>'', ut.CleanSpacesAndUpper(L.DefnCapName), Skip));
				EntityName := If(EntityName0 = 'CONNECTICUT STATE OF', 'STATE OF CONNECTICUT', EntityName0);
Self.entity_1 := EntityName;
Self.entity_type_code_1_orig := (String)L.PartyNo;
			EntityTypeDesc1Orig := Choose(C,If(partyName <>'' , If(L.PartyCatID = 1, 'PLAINTIFF', If(L.PartyCatID = 2,'DEFENDENT', Skip)), Skip),
																		If(BarMasterName <>'' , If(L.PartyCatID = 1, 'PLAINTIFF', If(L.PartyCatID = 2, 'DEFENDENT',Skip)), Skip),
																		If(EntityName = ut.CleanSpacesAndUpper(L.PlaintCapName), 'PLAINTIFF', Skip),
																		If(EntityName =  ut.CleanSpacesAndUpper(L.DefnCapName), 'DEFENDENT', Skip));
Self.entity_type_description_1_orig := EntityTypeDesc1Orig;
Self.entity_type_code_1_master :=  If(EntityTypeDesc1Orig = 'PLAINTIFF', '10', If(EntityTypeDesc1Orig = 'DEFENDENT', '30' , '90'));
Self.entity_seq_num_1 :=(String) L.PartyNo;
Self.atty_seq_num_1 := (String)L.PartyNo;

				Entity1_Addr1 := Choose(c, ut.CleanSpacesAndUpper(L.AddressLine1), ut.CleanSpacesAndUpper(L.BR_MST_OFFICE_ADDRESS_1),	'',  '');
address_1 := Entity1_Addr1;

				partyAddr2_1 := If(L.AddressLine2 <> '',  
														If(L.POBox<> '', ut.CleanSpacesAndUpper(L.AddressLine2)+ ', ' + ut.CleanSpacesAndUpper(L.POBox), L.AddressLine2), 
														If(L.POBox<> '', ut.CleanSpacesAndUpper(L.POBox), ''));
														
				partyAddr2 := If(partyAddr2_1  <> '', 
														If(L.SecUnitDesig <>'', partyAddr2_1 + ', ' + L.SecUnitDesig, partyAddr2_1), 
														If(L.SecUnitDesig <>'', L.SecUnitDesig, ''));
				Entity1_Addr2 := Choose(c,  ut.CleanSpacesAndUpper(partyAddr2), ut.CleanSpacesAndUpper(L.BR_MST_OFFICE_ADDRESS_2), '', '');
address_2 := Entity1_Addr2;

				Entity1_CityState := Choose(c,  If(L.CityTown <> '', If(L.StateCode <> '', ut.CleanSpacesAndUpper(L.CityTown) + ' ' + ut.CleanSpacesAndUpper(L.StateCode),  ut.CleanSpacesAndUpper(L.CityTown)), 
																				If(L.StateCode <> '' , ut.CleanSpacesAndUpper(L.StateCode), '')),
																		If(L.BR_MST_OFFICE_CITY <> '', If(L.BR_MST_OFFICE_STATE_CD <> '', ut.CleanSpacesAndUpper(L.BR_MST_OFFICE_CITY) + ' ' + ut.CleanSpacesAndUpper(L.BR_MST_OFFICE_STATE_CD), ut.CleanSpacesAndUpper(L.BR_MST_OFFICE_CITY) ),
																				If(L.BR_MST_OFFICE_STATE_CD <> '' , ut.CleanSpacesAndUpper(L.BR_MST_OFFICE_STATE_CD), '')),	'',  '');
address_3 :=  If(regexfind('[A-Z, ]', Entity1_Addr2) and ~regexfind('[0-9.]', Entity1_Addr2), 
																									If(Entity1_CityState <> '', Entity1_Addr2+ ' ' + Entity1_CityState,  Entity1_Addr2 ),
																									If(Entity1_CityState <> '', Entity1_CityState, ''));

				Entity1_ZipZip4 := Choose(c, ut.CleanSpacesAndUpper(L.Zip + L.ZipPlus4), ut.CleanSpacesAndUpper(L.BR_MST_OFFICE_ZIP), '', '');
address_4 := Entity1_ZipZip4;


Self.entity_1_address_1 :=ut.CleanSpacesAndUpper(  If(address_1 = '', If(address_2 <> '', address_2, ''), If(address_2 <> '', address_1 + ', ' +address_2, address_1)));

Self.entity_1_address_2 :=ut.CleanSpacesAndUpper( If( address_3  = '' , If(address_4 <>'', address_4, ''), If(address_4 <>'', address_3 + ' ' +address_4, address_3)));

Self := [];
End;
Map_Party := Normalize(PartyFile, 4, xform1(Left, Counter));
dsMappedParty := Project(Map_Party, Transform(Civil_Court.Layout_In_Party, Self := Left; Self := [];));
Civ_court.Civ_Court_Cleaner(dsMappedParty, ClnMappedParty);
Mapped_Party := ClnMappedParty;
dMapped_Party := Dedup(Sort( Distribute(Mapped_Party, Hash32(case_key)),
															case_key, court_code, court, case_number, case_type_code, case_type, entity_1, entity_type_code_1_orig, 
																	entity_1_address_1, entity_1_address_2, entity_1_address_3, entity_1_address_4, Local),
															case_key, court_code, court, case_number, case_type_code, case_type, entity_1, entity_type_code_1_orig, 
																	entity_1_address_1, entity_1_address_2, entity_1_address_3, entity_1_address_4, Local): PERSIST('~thor_200::in::civil_CT_party');
Export Map_CT_Party := dMapped_Party;