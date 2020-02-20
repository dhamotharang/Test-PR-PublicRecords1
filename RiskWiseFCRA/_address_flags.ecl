import riskwise, dx_header, risk_indicators, advo, header, address, Data_Services;

// function that appends address flags for a given address
// accepts a dataset of header addresses or inquiry addresses, can include duplicate records
// dedupes down to a single record for each unique address, 
// calculates the addr flags per address and returns just 1 record per address

EXPORT _address_flags(dataset(riskwisefcra.layouts.layout_addrflags_input) addresses_in) := function

sorted_input_addresses := sort(addresses_in, zip,prim_range,predir,prim_name,suffix,postdir,sec_range);
deduped_input_addresses := dedup(sorted_input_addresses, zip,prim_range,predir,prim_name,suffix,postdir,sec_range);

layout_working := RiskWiseFCRA.layouts.layout_addrflags_output;
	
// search citystatezip for each address to get the corp/mil flag
layout_working getZipFlag(riskwisefcra.layouts.layout_addrflags_input le, riskwise.Key_CityStZip ri) := transform
	self.addrID := Header.AddressID_fromparts(le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.sec_range,le.zip,le.st);
	self.addr_flags.corpMil := if(ri.zipclass in ['U','M'], '1', '0');
	self := le;
	self := [];	// blank out the rest of the addr flags initially
end;
wZipClass := join(deduped_input_addresses, riskwise.Key_CityStZip,	
															keyed(right.zip5=left.zip) and left.zip!='',
															getZipFlag(left, right), left outer, 
															ATMOST(keyed(right.zip5=left.zip),RiskWise.max_atmost));

layout_working zipRoll(layout_working le, layout_working ri) := transform
	self.addr_flags.corpMil := if(le.addr_flags.corpMil='1', '1', ri.addr_flags.corpMil);	
	self := le;
end;
wZipClassRoll := ROLLUP(SORT(wZipClass, addrID),left.addrID=right.addrID, zipRoll(left,right));


// search HRI for each record to get prisonAddr and highRisk addr flags
layout_working getHRIflags(layout_working le, risk_indicators.key_HRI_Address_To_SIC_filtered_fcra ri) := transform
	self.addr_flags.prisonAddr := if(ri.sic_code='2225', '1', '0');
	self.addr_flags.highRisk := if(ri.sic_code<>'', '1', '0');
	self := le;
end;
wHRI := join(wZipClassRoll, risk_indicators.key_HRI_Address_To_SIC_filtered_fcra,  
										left.zip!='' and left.prim_name != '' and
										keyed(left.zip=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.suffix=right.suffix) and 
										keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and 
										keyed(left.sec_range=right.sec_range), 
										// check date
										// and right.dt_first_seen < history_Date, // no history date filtering in this function currently, it's used in RiskWiseFCRA.FCRAData_Service only which doesn't support retro testing
										getHRIflags(left,right), left outer,
										ATMOST(keyed(left.zip=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.suffix=right.suffix) and
												keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
												keyed(left.sec_range=right.sec_range), RiskWise.max_atmost), keep(100));	
						
						
layout_working hriRoll(layout_working le, layout_working ri) := transform
	self.addr_flags.prisonAddr := if(le.addr_flags.prisonAddr='1', '1', ri.addr_flags.prisonAddr);	
	self.addr_flags.highRisk := if(le.addr_flags.highRisk='1', '1', ri.addr_flags.highRisk);
	self := le;
end;
wHRIRoll := ROLLUP(SORT(wHRI, addrID),left.addrID=right.addrID,hriRoll(left,right));



// search advo for each record to get the advo flags
layout_working getAdvoFlags(wHRIRoll le, Advo.Key_Addr1_FCRA ri) := transform
	self.addr_flags.doNotDeliver := ri.dnd_indicator;
	self.addr_flags.deliveryStatus := Map(ri.throw_back_indicator='Y' => 'T',	
																				ri.seasonal_delivery_indicator='E' => 'C',
																				ri.seasonal_delivery_indicator='Y' => 'S',
																				ri.address_vacancy_indicator='Y' => 'V',
																				'');
	self.addr_flags.addressType := Map(	ri.residential_or_business_ind = 'A' => 'A',
																			ri.residential_or_business_ind = 'B' => 'B',
																			ri.residential_or_business_ind = 'C' => 'C',
																			ri.residential_or_business_ind = 'D' => 'D',
																			'');
	self.addr_flags.dropIndicator := Map(	ri.drop_indicator = 'C' => 'C',	
																				ri.drop_indicator = 'Y' => 'Y',
																				ri.drop_indicator = 'N' => 'N',
																				ri.drop_indicator = '' => 'S',
																				'');
	self.addr_flags.mail_usage  := ri.Mixed_Address_Usage;
		
	self := le;
end;
wAdvo  := join(wHRIRoll, Advo.Key_Addr1_FCRA,
		left.zip != '' and left.prim_range != '' and
		keyed(left.zip = right.zip) and
		keyed(left.prim_range = right.prim_range) and
		keyed(left.prim_name = right.prim_name) and
		keyed(left.suffix = right.addr_suffix) and
		keyed(left.predir = right.predir) and
		keyed(left.postdir = right.postdir) and
		keyed(left.sec_range = right.sec_range),
		getAdvoFlags(left, right), LEFT OUTER,
		KEEP(1), atmost(riskwise.max_atmost));

key_apt_buildings := dx_Header.key_AptBuildings(data_services.data_env.iFCRA);
layout_working addUnitCount(layout_working le, key_apt_buildings ri) := transform
	SELF.addr_flags.unit_count := ri.apt_cnt;
	
	// clean the address here so that we can get valid, dwelling type
	street_address := risk_indicators.MOD_AddressClean.street_address(Address.Addr1FromComponents(le.Prim_Range, le.PreDir, le.Prim_Name, le.Suffix, le.PostDir, le.Unit_Desig, le.Sec_Range));
	cleanAddr := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.city_name, le.st, le.zip ) ;
	addrVal := Risk_Indicators.iid_constants.addrvalflag(cleanAddr[179..182]);
	self.addr_flags.valid := addrval;
	self.addr_flags.dwelltype := cleanAddr[139];
	
	SELF := le;
end;

wUnitCount := join(wADVO, key_apt_buildings,	
	left.zip <>'' and trim(left.prim_name)<>'' and
		keyed(left.prim_range=right.prim_range) and 
		keyed(left.prim_name=right.prim_name) and
		keyed(left.zip=right.zip) and 
		keyed(left.suffix=right.suffix) and 
		keyed(left.predir=right.predir),
	addUnitCount(left,right), 
		left outer, atmost(riskwise.max_atmost), keep(1));	
		
		
return wUnitCount;

end;