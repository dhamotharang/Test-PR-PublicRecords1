IMPORT Business_Header, Business_Header_SS, DID_Add, Address, PromoteSupers;

#workunit('name', 'Govt Phones Reset BDID ' + govdata.Gov_Phones_Reset_Date);

gov_in := govdata.File_Gov_Phones_In;

govdata.Layout_Gov_Phones_Base AddFields(gov_in l, INTEGER ct) := TRANSFORM
	SELF.bdid := 0;
	SELF.unique_id := govdata.Gov_Phones_Reset_Date + INTFORMAT(ct, 12, 1);
	SELF.phone := (UNSIGNED6) (if(length(trim(Stringlib.StringFilter(l.area_code_1, '0123456789'))) = 3, l.area_code_1, '000')
	                           + if((Address.CleanPhone(l.phone_1))[4..10] <> '', (Address.CleanPhone(l.phone_1))[4..10], '0000000'));
	SELF.agency := stringlib.StringToUpperCase(l.agency);
	SELF.p_city_name := if(l.p_city_name <> '', l.p_city_name, Stringlib.StringToUpperCase(l.city));  // Fix city field if address did not clean
    SELF.v_city_name := if(l.v_city_name <> '', l.v_city_name, Stringlib.StringToUpperCase(l.city));
	SELF.st := if(l.st <> '', l.st, l.state);  // Fix st field if address did not clean
	SELF := l;
END;

gov_base := PROJECT(gov_in, AddFields(LEFT, COUNTER));

// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(
	gov_base, gov_base_BDID_Init,
	FALSE, bdid,
	FALSE, 'GP',
	FALSE, source_group_field,
	agency,
	prim_range, prim_name, sec_range, zip,
	TRUE, phone,
	FALSE, fein_field)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

gov_base_BDID_Match := gov_base_BDID_Init(bdid <> 0);
gov_base_BDID_NoMatch := gov_base_BDID_Init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(gov_base_BDID_NoMatch,
                                  BDID_Matchset,
                                  agency,
                                  prim_range, prim_name, zip,
                                  sec_range, st,
                                  phone, fein_field,
                                  bdid, govdata.Layout_Gov_Phones_Base,
                                  FALSE, BDID_score_field,
                                  gov_base_BDID_Rematch)

gov_base_BDID_All := gov_base_BDID_Match + gov_base_BDID_Rematch;

/*OUTPUT(gov_base_BDID_All,, 
	'~thor_data400::BASE::gov_phones_' + govdata.Gov_Phones_Reset_Date, OVERWRITE);*/
	
PromoteSupers.MAC_SF_BuildProcess(gov_base_bdid_all,'~thor_data400::base::gov_phones',do1,2);

export Make_Gov_Phones_Base_Reset_BDID := do1;

