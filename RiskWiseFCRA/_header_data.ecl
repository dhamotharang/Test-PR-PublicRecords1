import doxie, fcra, ut, header_quick, Riskwise, risk_indicators, Advo, Address, Std;

// call full header, call full override
// join them together by rid, left outer
// override key will only have fields populated that were corrected (recordid is RID), such as SSN, this will also have a bitmap field that stores a 1 for a null corrected value
// use left except for where right is populated 
// add temporary fields to store old value and new value for each field (first, middle, last, addr, city, state, zip, ssn, dob, and addr flags also)
// project through all the header records and replace old value fields with new value fields (this will correct any new records that came in with wrong value and has been corrected by customer) 
// fcra data layout will be layout_header plus addr flags
// layout override will be layout header plus string blankout plus addr flags


todaysdate := (string) Std.Date.Today(); // for checking derog's fcra-date compliance
unsigned3 history_date := 999999;	// removed the input history date, this query is not meant to be run in historical mode

export _header_data (dataset (doxie.layout_references) bshell_dids, 
                     dataset (fcra.Layout_override_flag) ds_flagfile) := function


Layout_working := RiskWiseFCRA.layouts.working;

// suppressions for header
flagged_hdr_suppressions := ds_flagfile(file_id = FCRA.FILE_ID.hdr);	
header_correction_keys  := SET(flagged_hdr_suppressions, trim(record_id) );	
											
quick_header_suppressions := join(flagged_hdr_suppressions, Header_Quick.key_DID_fcra,	
											keyed((unsigned)left.did=right.did) and
											(
												trim((string)right.did) + trim((string)right.rid) = trim(left.record_id) or // old way - retrieving corrected records from prior to 11/13/2012
												trim( (string)right.persistent_record_id ) = trim(left.record_id)   // new way - using persistent_record_id
											),
											transform( recordof(doxie.Key_fcra_Header), self.src:=if(right.src in ['QH','WH'],'EQ',right.src), self := right,  self := [] ),
											LIMIT(ut.limits.HEADER_PER_DID));

header_main_suppressions := join(flagged_hdr_suppressions, doxie.Key_fcra_Header,	
										keyed((unsigned)left.did=right.s_did) and
										(
												trim((string)right.did) + trim((string)right.rid) = trim(left.record_id) or // old way - retrieving corrected records from prior to 11/13/2012
												trim( (string)right.persistent_record_id ) = trim(left.record_id)   // new way - using persistent_record_id
											),
										transform( recordof(doxie.Key_fcra_Header), 
											ssnToUse := IF(right.valid_ssn<>'M', right.ssn, '');	// if manufactured, then blank out
											dobToUse := IF(right.valid_dob<>'M', right.dob, 0);	// if manufactured, then blank out
											self.ssn := ssnToUse;
											self.dob := dobToUse;
											self := right ),
										LIMIT(ut.limits.HEADER_PER_DID));	
header_suppressions := quick_header_suppressions + header_main_suppressions;

										
// get the header corrections
header_corr := join(bshell_dids, FCRA.Key_Override_Header_DID,	// this includes quick header
										left.did<>0 and keyed(left.did=right.did) and
										((right.head.src='BA' and FCRA.bankrupt_is_ok(todaysdate,(string)right.head.dt_first_seen)) or
										(right.head.src='L2' and FCRA.lien_is_ok(todaysdate,(string)right.head.dt_first_seen)) OR right.head.src not in ['BA','L2']) and
										trim((string)right.did) + trim((string)right.head.rid) not in header_correction_keys	// old way - exclude corrected records from prior to 11/13/2012
										and trim( (string)right.head.persistent_record_id ) not in header_correction_keys,  // new way - using persistent_record_id										
										transform(fcra.Layout_Override_Header, self := right),
										LIMIT(ut.limits.HEADER_PER_DID));	

										
// search the main keys										
qheader_main := join(bshell_dids, Header_Quick.key_DID_fcra,	
											left.did<>0 and keyed(left.did=right.did) and
											((right.src='BA' and FCRA.bankrupt_is_ok(todaysdate,(string)right.dt_first_seen)) or
											(right.src='L2' and FCRA.lien_is_ok(todaysdate,(string)right.dt_first_seen)) OR right.src not in ['BA','L2']) and
											~FCRA.Restricted_Header_Src(right.src, right.vendor_id[1]) and 
											trim((string)right.did) + trim((string)right.rid) not in header_correction_keys // old way - exclude corrected records from prior to 11/13/2012
											and trim( (string)right.persistent_record_id ) not in header_correction_keys,  // new way - using persistent_record_id		
											transform( recordof(doxie.Key_fcra_Header), self.src:=if(right.src in ['QH','WH'],'EQ',right.src), self := right,  self := [] ),
											LIMIT(ut.limits.HEADER_PER_DID));

header_main := join(bshell_dids, doxie.Key_fcra_Header,	
										left.did<>0 and keyed(left.did=right.s_did) and
										((right.src='BA' and FCRA.bankrupt_is_ok(todaysdate,(string)right.dt_first_seen)) or
										(right.src='L2' and FCRA.lien_is_ok(todaysdate,(string)right.dt_first_seen)) OR right.src not in ['BA','L2']) and
										~FCRA.Restricted_Header_Src(right.src, right.vendor_id[1]) and
										trim((string)right.did) + trim((string)right.rid) not in header_correction_keys// old way - exclude corrected records from prior to 11/13/2012
										and trim( (string)right.persistent_record_id ) not in header_correction_keys,  // new way - using persistent_record_id	
										transform( recordof(doxie.Key_fcra_Header), self := right ),
										LIMIT(ut.limits.HEADER_PER_DID));	

combo_header := qheader_main + header_main;
			
						
						
// search citystatezip for each header record to get the corp/mil flag
Riskwise.layouts_vru.Layout_Header_Data getZipFlag(recordof(doxie.Key_fcra_Header) le, riskwise.Key_CityStZip ri) := transform
	self.addr_flags.corpMil := if(ri.zipclass in ['U','M'], '1', '0');
	self := le;
	self := [];	// rest of the addr flags
end;
wZipClass := join(combo_header, riskwise.Key_CityStZip,	
															keyed(right.zip5=left.zip) and left.zip!='',
															getZipFlag(left, right), left outer, ATMOST(keyed(right.zip5=left.zip),RiskWise.max_atmost));



Riskwise.layouts_vru.Layout_Header_Data zipRoll(Riskwise.layouts_vru.Layout_Header_Data le, wZipClass ri) := transform
	self.addr_flags.corpMil := if(le.addr_flags.corpMil='1', '1', ri.addr_flags.corpMil);	
	self := le;
end;
wZipClassRoll := ROLLUP(SORT(wZipClass, rid),left.rid=right.rid,zipRoll(left,right));



// search HRI for each header record to get prisonAddr and highRisk addr
Riskwise.layouts_vru.Layout_Header_Data getHRIflags(Riskwise.layouts_vru.Layout_Header_Data le, risk_indicators.key_HRI_Address_To_SIC_filtered_fcra ri) := transform
	self.addr_flags.prisonAddr := if(ri.sic_code='2225', '1', '0');
	self.addr_flags.highRisk := if(ri.sic_code<>'', '1', '0');
	self := le;
end;
wHRI := join(wZipClassRoll, risk_indicators.key_HRI_Address_To_SIC_filtered_fcra,  
										left.zip!='' and left.prim_name != '' and
										keyed(left.zip=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.suffix=right.suffix) and 
										keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and 
										keyed(left.sec_range=right.sec_range) AND 
										// check date
										right.dt_first_seen < history_Date, getHRIflags(left,right), left outer,
										ATMOST(keyed(left.zip=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.suffix=right.suffix) and
												keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
												keyed(left.sec_range=right.sec_range), RiskWise.max_atmost), keep(100));	
						
						

Riskwise.layouts_vru.Layout_Header_Data hriRoll(Riskwise.layouts_vru.Layout_Header_Data le, Riskwise.layouts_vru.Layout_Header_Data ri) := transform
	self.addr_flags.prisonAddr := if(le.addr_flags.prisonAddr='1', '1', ri.addr_flags.prisonAddr);	
	self.addr_flags.highRisk := if(le.addr_flags.highRisk='1', '1', ri.addr_flags.highRisk);
	self := le;
end;
wHRIRoll := ROLLUP(SORT(wHRI, rid),left.rid=right.rid,hriRoll(left,right));



// search advo for each header record to get the advo flags
Riskwise.layouts_vru.Layout_Header_Data getAdvoFlags(wHRIRoll le, Advo.Key_Addr1_FCRA ri) := transform
	self.addr_flags.doNotDeliver := ri.dnd_indicator;
	self.addr_flags.deliveryStatus := Map(ri.throw_back_indicator='Y' => 'T',	// not sure that these are correct
																				ri.seasonal_delivery_indicator='E' => 'C',
																				ri.seasonal_delivery_indicator='Y' => 'S', // do we need to check if residential like attributes master does?
																				ri.address_vacancy_indicator='Y' => 'V',
																				'');
	self.addr_flags.addressType := Map(	ri.residential_or_business_ind = 'A' => 'A',
																			ri.residential_or_business_ind = 'B' => 'B',
																			ri.residential_or_business_ind = 'C' => 'C',
																			ri.residential_or_business_ind = 'D' => 'D',
																			'');
	self.addr_flags.dropIndicator := Map(	ri.drop_indicator = 'C' => 'C',	// not sure that these are correct
																				ri.drop_indicator = 'Y' => 'Y',
																				ri.drop_indicator = 'N' => 'N',
																				ri.drop_indicator = '' => 'S',
																				'');

	self.addr_flags.mail_usage  := ri.Mixed_Address_Usage;
																				
	self := le;
end;
wAdvo  := join(wHRIRoll, Advo.Key_Addr1_FCRA,
														left.did<>0 and left.zip != '' and left.prim_range != '' and
																	keyed(left.zip = right.zip) and
																	keyed(left.prim_range = right.prim_range) and
																	keyed(left.prim_name = right.prim_name) and
																	keyed(left.suffix = right.addr_suffix) and
																	keyed(left.predir = right.predir) and
																	keyed(left.postdir = right.postdir) and
																	keyed(left.sec_range = right.sec_range),
													getAdvoFlags(left, right), LEFT OUTER,
													KEEP(1), LIMIT(ut.limits.HEADER_PER_DID));

Riskwise.layouts_vru.Layout_Header_Data addUnitCount(Riskwise.layouts_vru.Layout_Header_Data le, doxie.Key_FCRA_AptBuildings ri) := transform
	SELF.addr_flags.unit_count := ri.apt_cnt;
	SELF := le;
end;
wUnitCount := join(wADVO, doxie.Key_FCRA_AptBuildings,	
	left.did<>0 and trim(left.prim_name)<>'' and
		keyed(left.prim_range=right.prim_range) and 
		keyed(left.prim_name=right.prim_name) and
		keyed(left.zip=right.zip) and 
		keyed(left.suffix=right.suffix) and 
		keyed(left.predir=right.predir),
	addUnitCount(left,right), 
		left outer, atmost(riskwise.max_atmost), keep(1));														


Layout_working combineHeaderCorrections(Riskwise.layouts_vru.Layout_Header_Data le, header_corr ri) := transform
	// clean the address here so that we can get valid, dwelling type
	street_address := risk_indicators.MOD_AddressClean.street_address(Address.Addr1FromComponents(le.Prim_Range, le.PreDir, le.Prim_Name, le.Suffix, le.PostDir, le.Unit_Desig, le.Sec_Range));
	cleanAddr := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.city_name, le.st, le.zip+le.zip4 ) ;
	addrVal := Risk_Indicators.iid_constants.addrvalflag(cleanAddr[179..182]);
	
	ssnToUse := IF(le.valid_ssn<>'M', le.ssn, '');	// if manufactured, then blank out
	dobToUse := IF(le.valid_dob<>'M', le.dob, 0);	// if manufactured, then blank out
	
	// correct fields where a correction was done or suppressed
	self.fname := if(ri.head.fname<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Fname]='1', ri.head.fname, le.fname);
	self.mname := if(ri.head.mname<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Mname]='1', ri.head.mname, le.mname);
	self.lname := if(ri.head.lname<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Lname]='1', ri.head.lname, le.lname);
	self.name_suffix := if(ri.head.name_suffix<>'' or ri.blankout[risk_indicators.iid_constants.suppress.NameSuffix]='1', ri.head.name_suffix, le.name_suffix);
	self.prim_range := if(ri.head.prim_range<>'' or ri.blankout[risk_indicators.iid_constants.suppress.PrimRange]='1', ri.head.prim_range, le.prim_range);
	self.predir := if(ri.head.predir<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Predir]='1', ri.head.predir, le.predir);
	self.prim_name := if(ri.head.prim_name<>'' or ri.blankout[risk_indicators.iid_constants.suppress.PrimName]='1', ri.head.prim_name, le.prim_name);
	self.suffix := if(ri.head.suffix<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Suffix]='1', ri.head.suffix, le.suffix);
	self.postdir := if(ri.head.postdir<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Postdir]='1', ri.head.postdir, le.postdir);
	self.unit_desig := if(ri.head.unit_desig<>'' or ri.blankout[risk_indicators.iid_constants.suppress.UnitDesig]='1', ri.head.unit_desig, le.unit_desig);
	self.sec_range := if(ri.head.sec_range<>'' or ri.blankout[risk_indicators.iid_constants.suppress.SecRange]='1', ri.head.sec_range, le.sec_range);
	self.city_name := if(ri.head.city_name<>'' or ri.blankout[risk_indicators.iid_constants.suppress.CityName]='1', ri.head.city_name, le.city_name);
	self.st := if(ri.head.st<>'' or ri.blankout[risk_indicators.iid_constants.suppress.St]='1', ri.head.st, le.st);
	self.zip := if(ri.head.zip<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Zip]='1', ri.head.zip, le.zip);
	self.zip4 := if(ri.head.zip4<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Zip4]='1', ri.head.zip4, le.zip4);
	self.ssn := if(ri.head.ssn<>'' or ri.blankout[risk_indicators.iid_constants.suppress.SSN]='1', ri.head.ssn, ssnToUse);
	self.dob := if(ri.head.dob<>0 or ri.blankout[risk_indicators.iid_constants.suppress.DOB]='1', ri.head.dob, dobToUse);
	
	// check to see what was changed to what and if changed, then populate the fields for the next project
	fnameCorrected := ri.head.fname<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Fname]='1';	// correction field will only be populated if a correction was done
	self.oldFname := if(fnameCorrected, le.fname, '');			// only populate the old if there is a new
	self.newFname := if(fnameCorrected, ri.head.fname, '');	// only populate the new if there is a new
	
	mnameCorrected := ri.head.mname<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Mname]='1';	// correction field will only be populated if a correction was done
	self.oldmname := if(mnameCorrected, le.mname, '');			// only populate the old if there is a new
	self.newmname := if(mnameCorrected, ri.head.mname, '');	// only populate the new if there is a new
	
	lnameCorrected := ri.head.lname<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Lname]='1';	// correction field will only be populated if a correction was done
	self.oldLname := if(lnameCorrected, le.lname, '');			// only populate the old if there is a new
	self.newLname := if(lnameCorrected, ri.head.lname, '');	// only populate the new if there is a new
	
	nameSuffixCorrected := ri.head.name_suffix<>'' or ri.blankout[risk_indicators.iid_constants.suppress.NameSuffix]='1';	// correction field will only be populated if a correction was done
	self.oldNameSuffix := if(nameSuffixCorrected, le.name_suffix, '');			// only populate the old if there is a new
	self.newNameSuffix := if(nameSuffixCorrected, ri.head.name_suffix, '');	// only populate the new if there is a new
	
	// check to see if any part of the address was corrected, if so, then populate all fields in the address so we can compare later to see what the original address was
	streetAddrCorrected := 	ri.head.prim_range<>'' or ri.blankout[risk_indicators.iid_constants.suppress.PrimName]='1' or 
													ri.head.predir<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Predir]='1' or 
													ri.head.prim_name<>'' or ri.blankout[risk_indicators.iid_constants.suppress.PrimName]='1' or
													ri.head.suffix<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Suffix]='1' or 
													ri.head.postdir<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Postdir]='1' or 
													ri.head.unit_desig<>'' or ri.blankout[risk_indicators.iid_constants.suppress.UnitDesig]='1' or
													ri.head.sec_range<>'' or ri.blankout[risk_indicators.iid_constants.suppress.SecRange]='1';
	
	// in the old fields for street address, check if streetAddrCorrected then use the original from left
	self.oldPrimRange := if(streetAddrCorrected, le.prim_range, '');			// only populate the old if there is a new
	self.newPrimRange := map(streetAddrCorrected and ri.head.prim_range<>'' => ri.head.prim_range,
													 streetAddrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.PrimRange]='1' => '',
													 streetAddrCorrected => le.prim_range,	// if another addr field was corrected, then keep the original
													 '');
		
	self.oldPredir := if(streetAddrCorrected, le.predir, '');			// only populate the old if there is a new
	self.newPredir := map(streetAddrCorrected and ri.head.predir<>'' => ri.head.predir,
												streetAddrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.predir]='1' => '',
												streetAddrCorrected => le.predir,	// if another addr field was corrected, then keep the original
												'');	// only populate the new if there is a new
	
	self.oldPrimName := if(streetAddrCorrected, le.prim_name, '');			// only populate the old if there is a new
	self.newPrimName := map(streetAddrCorrected and ri.head.prim_name<>'' => ri.head.prim_name,
													 streetAddrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.PrimName]='1' => '',
													 streetAddrCorrected => le.prim_name,	// if another addr field was corrected, then keep the original
													 '');	// only populate the new if there is a new
	
	self.oldSuffix := if(streetAddrCorrected, le.suffix, '');			// only populate the old if there is a new
	self.newSuffix := map(streetAddrCorrected and ri.head.suffix<>'' => ri.head.suffix,
													 streetAddrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.suffix]='1' => '',
													 streetAddrCorrected => le.suffix,	// if another addr field was corrected, then keep the original
													 '');	// only populate the new if there is a new

	self.oldPostDir := if(streetAddrCorrected, le.postdir, '');			// only populate the old if there is a new
	self.newPostDir := map(streetAddrCorrected and ri.head.postdir<>'' => ri.head.postdir,
													 streetAddrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.postdir]='1' => '',
													 streetAddrCorrected => le.postdir,	// if another addr field was corrected, then keep the original
													 '');	// only populate the new if there is a new
	
	self.oldUnitDesig := if(streetAddrCorrected, le.unit_desig, '');			// only populate the old if there is a new
	self.newUnitDesig := map(streetAddrCorrected and ri.head.unit_desig<>'' => ri.head.unit_desig,
													 streetAddrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.unitdesig]='1' => '',
													 streetAddrCorrected => le.unit_desig,	// if another addr field was corrected, then keep the original
													 '');	// only populate the new if there is a new
	
	self.oldSecRange := if(streetAddrCorrected, le.sec_range, '');			// only populate the old if there is a new
	self.newSecRange := map(streetAddrCorrected and ri.head.sec_range<>'' => ri.head.sec_range,
													 streetAddrCorrected and ri.blankout[risk_indicators.iid_constants.suppress.secrange]='1' => '',
													 streetAddrCorrected => le.sec_range,	// if another addr field was corrected, then keep the original
													 '');	// only populate the new if there is a new
	
	cityNameCorrected := ri.head.city_name<>'' or ri.blankout[risk_indicators.iid_constants.suppress.cityname]='1';	// correction field will only be populated if a correction was done
	self.oldCityname := if(cityNameCorrected, le.city_name, '');			// only populate the old if there is a new
	self.newCityName := if(cityNameCorrected, ri.head.city_name, '');	// only populate the new if there is a new
	
	stCorrected := ri.head.st<>'' or ri.blankout[risk_indicators.iid_constants.suppress.St]='1';	// correction field will only be populated if a correction was done
	self.oldSt := if(stCorrected, le.st, '');			// only populate the old if there is a new
	self.newSt := if(stCorrected, ri.head.st, '');	// only populate the new if there is a new
	
	zipCorrected := ri.head.zip<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Zip]='1';	// correction field will only be populated if a correction was done
	self.oldZip := if(zipCorrected, le.zip, '');			// only populate the old if there is a new
	self.newZip := if(zipCorrected, ri.head.zip, '');	// only populate the new if there is a new
	
	zip4Corrected := ri.head.zip4<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Zip4]='1';	// correction field will only be populated if a correction was done
	self.oldZip4 := if(zip4Corrected, le.zip4, '');			// only populate the old if there is a new
	self.newZip4 := if(zip4Corrected, ri.head.zip4, '');	// only populate the new if there is a new
	
	ssnCorrected := ri.head.ssn<>'' or ri.blankout[risk_indicators.iid_constants.suppress.SSN]='1';	// correction field will only be populated if a correction was done
	self.oldSSN := if(ssnCorrected, ssnToUse, '');			// only populate the old if there is a new
	self.newSSN := if(ssnCorrected, ri.head.ssn, '');	// only populate the new if there is a new
	
	dobCorrected := ri.head.dob<>0 or ri.blankout[risk_indicators.iid_constants.suppress.DOB]='1';	// correction field will only be populated if a correction was done
	self.oldDOB := if(dobCorrected, (string)dobToUse, '');			// only populate the old if there is a new
	self.newDOB := if(dobCorrected, (string)ri.head.dob, '');	// only populate the new if there is a new

	// set the flags
	self.addr_flags.dwelltype := if(ri.addr_flags.dwelltype<>'' or ri.blankout[risk_indicators.iid_constants.suppress.DwellType]='1', ri.addr_flags.dwelltype, cleanAddr[139]);
	self.addr_flags.valid := if(ri.addr_flags.valid<>'' or ri.blankout[19]='1', ri.addr_flags.valid, if((addrVal='N' and (	(street_address<>'' and le.city_name<>'' and le.st<>'') or 
																																																													(street_address<>'' and le.zip<>''))), '0', '1'));																																																														
	
	self.addr_flags.prisonAddr := if(ri.addr_flags.prisonAddr<>'' or ri.blankout[risk_indicators.iid_constants.suppress.PrisonAddr]='1', ri.addr_flags.prisonAddr, le.addr_flags.prisonAddr);
	
// set the high risk address source and description based upon what the highrisk flag says	
	self.addr_flags.highRisk := if(ri.addr_flags.highRisk<>'' or ri.blankout[risk_indicators.iid_constants.suppress.HighRisk]='1', ri.addr_flags.highRisk, le.addr_flags.highRisk);
	self.high_Risk_Address_Source := if(ri.addr_flags.highRisk<>'' or ri.blankout[risk_indicators.iid_constants.suppress.HighRisk]='1', ri.high_Risk_Address_Source, le.high_Risk_Address_Source);
	self.high_Risk_Address_Description := if(ri.addr_flags.highRisk<>'' or ri.blankout[risk_indicators.iid_constants.suppress.HighRisk]='1', ri.high_Risk_Address_Description, le.high_Risk_Address_Description);
	
	self.addr_flags.corpMil := if(ri.addr_flags.corpMil<>'' or ri.blankout[risk_indicators.iid_constants.suppress.CorpMil]='1', ri.addr_flags.corpMil, le.addr_flags.corpMil);
	
	self.addr_flags.doNotDeliver := if(ri.addr_flags.doNotDeliver<>'' or ri.blankout[risk_indicators.iid_constants.suppress.DoNotDeliver]='1', ri.addr_flags.doNotDeliver, le.addr_flags.doNotDeliver);
	self.addr_flags.deliveryStatus := if(ri.addr_flags.deliveryStatus<>'' or ri.blankout[risk_indicators.iid_constants.suppress.DeliveryStatus]='1', ri.addr_flags.deliveryStatus, le.addr_flags.deliveryStatus);
	self.addr_flags.addressType := if(ri.addr_flags.addressType<>'' or ri.blankout[risk_indicators.iid_constants.suppress.AddressType]='1', ri.addr_flags.addressType, le.addr_flags.addressType);
	self.addr_flags.dropIndicator := if(ri.addr_flags.dropIndicator<>'' or ri.blankout[risk_indicators.iid_constants.suppress.DropIndicator]='1', ri.addr_flags.dropIndicator, le.addr_flags.dropIndicator);
	self.addr_flags.unit_count := if(ri.addr_flags.unit_count<>0 or ri.blankout[risk_indicators.iid_constants.suppress.unit_count]='1', ri.addr_flags.unit_count, le.addr_flags.unit_count);
	self.addr_flags.mail_usage := if(ri.addr_flags.mail_usage<>'' or ri.blankout[risk_indicators.iid_constants.suppress.mail_usage]='1', ri.addr_flags.mail_usage, le.addr_flags.mail_usage);
	
	
	dwellTypeCorrected := ri.addr_flags.dwelltype<>'' or ri.blankout[risk_indicators.iid_constants.suppress.DwellType]='1';	// correction field will only be populated if a correction was done
	self.oldDwellType := if(dwellTypeCorrected, cleanAddr[139], '');					// only populate the old if there is a new
	self.newDwellType := if(dwellTypeCorrected, ri.addr_flags.dwelltype, '');	// only populate the new if there is a new
	
	validCorrected := ri.addr_flags.valid<>'' or ri.blankout[risk_indicators.iid_constants.suppress.Valid]='1';	// correction field will only be populated if a correction was done
	self.oldValid := if(validCorrected, if((addrVal='N' and (	(street_address<>'' and le.city_name<>'' and le.st<>'') or 
																														(street_address<>'' and le.zip<>''))), '0', '1'), '');		// only populate the old if there is a new
	self.newValid := if(validCorrected, ri.addr_flags.valid, '');			// only populate the new if there is a new
	
	prisonAddrCorrected := ri.addr_flags.prisonAddr<>'' or ri.blankout[risk_indicators.iid_constants.suppress.PrisonAddr]='1';	// correction field will only be populated if a correction was done
	self.oldPrisonAddr := if(prisonAddrCorrected, le.addr_flags.prisonAddr, '');			// only populate the old if there is a new
	self.newPrisonAddr := if(prisonAddrCorrected, ri.addr_flags.prisonAddr, '');			// only populate the new if there is a new
	
	highRiskCorrected := ri.addr_flags.highRisk<>'' or ri.blankout[risk_indicators.iid_constants.suppress.HighRisk]='1';	// correction field will only be populated if a correction was done
	self.oldHighRisk := if(highRiskCorrected, le.addr_flags.highRisk, '');			// only populate the old if there is a new
	self.newHighRisk := if(highRiskCorrected, ri.addr_flags.highRisk, '');			// only populate the new if there is a new
	self.oldHighRiskAddressSource := if(highRiskCorrected, le.high_risk_address_source, '');			// only populate the old if there is a new
	self.newHighRiskAddressSource := if(highRiskCorrected, ri.high_risk_address_source, '');			// only populate the new if there is a new	
	self.oldHighRiskAddressDescription := if(highRiskCorrected, le.high_risk_address_description, '');			// only populate the old if there is a new
	self.newHighRiskAddressDescription := if(highRiskCorrected, ri.high_risk_address_description, '');			// only populate the new if there is a new
	
	corpMilCorrected := ri.addr_flags.corpMil<>'' or ri.blankout[risk_indicators.iid_constants.suppress.CorpMil]='1';	// correction field will only be populated if a correction was done
	self.oldCorpMil := if(corpMilCorrected, le.addr_flags.corpMil, '');			// only populate the old if there is a new
	self.newCorpMil := if(corpMilCorrected, ri.addr_flags.corpMil, '');			// only populate the new if there is a new
	
	doNotDeliverCorrected := ri.addr_flags.doNotDeliver<>'' or ri.blankout[risk_indicators.iid_constants.suppress.DoNotDeliver]='1';	// correction field will only be populated if a correction was done
	self.oldDoNotDeliver := if(doNotDeliverCorrected, le.addr_flags.doNotDeliver, '');			// only populate the old if there is a new
	self.newDoNotDeliver := if(doNotDeliverCorrected, ri.addr_flags.doNotDeliver, '');			// only populate the new if there is a new
	
	deliveryStatusCorrected := ri.addr_flags.deliveryStatus<>'' or ri.blankout[risk_indicators.iid_constants.suppress.DeliveryStatus]='1';	// correction field will only be populated if a correction was done
	self.oldDeliveryStatus := if(deliveryStatusCorrected, le.addr_flags.deliveryStatus, '');			// only populate the old if there is a new
	self.newDeliveryStatus := if(deliveryStatusCorrected, ri.addr_flags.deliveryStatus, '');			// only populate the new if there is a new
	
	addressTypeCorrected := ri.addr_flags.addressType<>'' or ri.blankout[risk_indicators.iid_constants.suppress.AddressType]='1';	// correction field will only be populated if a correction was done
	self.oldAddressType := if(addressTypeCorrected, le.addr_flags.addressType, '');			// only populate the old if there is a new
	self.newAddressType := if(addressTypeCorrected, ri.addr_flags.addressType, '');			// only populate the new if there is a new
	
	dropIndicatorCorrected := ri.addr_flags.dropIndicator<>'' or ri.blankout[risk_indicators.iid_constants.suppress.DropIndicator]='1';	// correction field will only be populated if a correction was done
	self.oldDropIndicator := if(dropIndicatorCorrected, le.addr_flags.dropIndicator, '');			// only populate the old if there is a new
	self.newDropIndicator := if(dropIndicatorCorrected, ri.addr_flags.dropIndicator, '');			// only populate the new if there is a new
	
	unit_countCorrected := ri.addr_flags.unit_count<>0 or ri.blankout[risk_indicators.iid_constants.suppress.unit_count]='1';	// correction field will only be populated if a correction was done
	self.oldunit_count := if(unit_countCorrected, le.addr_flags.unit_count, 0);			// only populate the old if there is a new
	self.newunit_count := if(unit_countCorrected, ri.addr_flags.unit_count, 0);			// only populate the new if there is a new
	
	mail_usageCorrected := ri.addr_flags.mail_usage<>'' or ri.blankout[risk_indicators.iid_constants.suppress.mail_usage]='1';	// correction field will only be populated if a correction was done
	self.oldmail_usage := if(mail_usageCorrected, le.addr_flags.mail_usage, '');			// only populate the old if there is a new
	self.newmail_usage := if(mail_usageCorrected, ri.addr_flags.mail_usage, '');			// only populate the new if there is a new
	
	self.isCorrected := (string)ri.head.rid not in ['','0'] or ri.head.persistent_record_id<>0;
	
	self := le;
end;
corrPlusHeader := join(wUnitCount, header_corr,
											right.head.did<>0 and left.did=right.head.did and
											(
											(left.rid=right.head.rid)  // old way
												or 
											(left.persistent_record_id=right.head.persistent_record_id) // new way, using persistent_record_id
											),  
											combineHeaderCorrections(left, right), 
											LEFT OUTER, many lookup);

corrOnly := corrPlusHeader(isCorrected);
unCorrOnly := corrPlusHeader(~isCorrected);


Layout_working correctFutureData(unCorrOnly le, corrOnly ri) := transform
	self.fname := if((trim(ri.oldFname)<>'' or trim(ri.newFname)<>'') and ri.oldFname=le.fname, ri.newFname, le.fname);
	self.mname := if((trim(ri.oldMname)<>'' or trim(ri.newMname)<>'') and ri.oldMname=le.mname, ri.newMname, le.mname);
	self.lname := if((trim(ri.oldLname)<>'' or trim(ri.newLname)<>'') and ri.oldLname=le.lname, ri.newLname, le.lname);
	self.name_suffix := if((trim(ri.oldNameSuffix)<>'' or trim(ri.newNameSuffix)<>'') and ri.oldNameSuffix=le.name_suffix, ri.newNameSuffix, le.name_suffix);
	
	// need to check same address here and not individual parts before changing them
	origAddr := if(ri.oldPrimName<>'' or ri.oldPrimRange<>'', 
															address.Addr1FromComponents(ri.oldPrimRange,ri.oldPreDir,ri.oldPrimName,ri.oldSuffix,ri.oldPostDir,ri.oldUnitDesig,ri.oldSecRange),// use old because it has been corrected
															address.Addr1FromComponents(ri.prim_range,ri.predir,ri.prim_name,ri.suffix,ri.postdir,ri.unit_desig,ri.sec_range));	// use original because there is no old address because is has not been corrected
	sameAddr := address.Addr1FromComponents(le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.unit_desig,le.sec_range) = origAddr;		
	self.prim_range := if((trim(ri.oldPrimRange)<>'' or trim(ri.newPrimRange)<>'') and sameAddr, ri.newPrimRange, le.prim_range);
	self.predir := if((trim(ri.oldPreDir)<>'' or trim(ri.newPreDir)<>'') and sameAddr, ri.newPreDir, le.predir);
	self.prim_name := if((trim(ri.oldPrimName)<>'' or trim(ri.newPrimName)<>'') and sameAddr, ri.newPrimName, le.prim_name);
	self.suffix := if((trim(ri.oldSuffix)<>'' or trim(ri.newSuffix)<>'') and sameAddr, ri.newSuffix, le.suffix);
	self.postdir := if((trim(ri.oldPostDir)<>'' or trim(ri.newPostDir)<>'') and sameAddr, ri.newPostDir, le.postdir);
	self.unit_desig := if((trim(ri.oldUnitDesig)<>'' or trim(ri.newUnitDesig)<>'') and sameAddr, ri.newUnitDesig, le.unit_desig);
	self.sec_range := if((trim(ri.oldSecRange)<>'' or trim(ri.newSecRange)<>'') and sameAddr, ri.newSecRange, le.sec_range);
	self.city_name := if((trim(ri.oldCityName)<>'' or trim(ri.newCityName)<>'') and sameAddr, ri.newCityName, le.city_name);
	self.st := if((trim(ri.oldSt)<>'' or trim(ri.newSt)<>'') and sameAddr, ri.newSt, le.st);
	self.zip := if((trim(ri.oldZip)<>'' or trim(ri.newZip)<>'') and sameAddr, ri.newZip, le.Zip);
	self.zip4 := if((trim(ri.oldZip4)<>'' or trim(ri.newZip4)<>'') and sameAddr, ri.newZip4, le.Zip4);
	
	self.ssn := if((trim(ri.oldSSN)<>'' or trim(ri.newSSN)<>'') and ri.oldSSN=le.ssn, ri.newSSN, le.ssn);
	self.dob := if((trim(ri.oldDOB)<>'' or trim(ri.newDOB)<>'') and ri.oldDOB=(string)le.dob, (unsigned)ri.newDOB, le.dob);
	
	self.addr_flags.dwellType := if((trim(ri.oldDwellType)<>'' or trim(ri.newDwellType)<>'') and sameAddr, ri.newDwellType, le.addr_flags.dwellType);
	self.addr_flags.valid := if((trim(ri.oldValid)<>'' or trim(ri.newValid)<>'') and sameAddr, ri.newValid, le.addr_flags.Valid);
	self.addr_flags.prisonAddr := if((trim(ri.oldPrisonAddr)<>'' or trim(ri.newPrisonAddr)<>'') and sameAddr, ri.newPrisonAddr, le.addr_flags.prisonAddr);
	self.addr_flags.highRisk := if((trim(ri.oldHighRisk)<>'' or trim(ri.newHighRisk)<>'') and sameAddr, ri.newHighRisk, le.addr_flags.highRisk);
	self.addr_flags.corpMil := if((trim(ri.oldCorpMil)<>'' or trim(ri.newCorpMil)<>'') and sameAddr, ri.newCorpMil, le.addr_flags.corpMil);
	self.addr_flags.doNotDeliver := if((trim(ri.oldDoNotDeliver)<>'' or trim(ri.newDoNotDeliver)<>'') and sameAddr, ri.newDoNotDeliver, le.addr_flags.doNotDeliver);
	self.addr_flags.deliveryStatus := if((trim(ri.oldDeliveryStatus)<>'' or trim(ri.newDeliveryStatus)<>'') and sameAddr, ri.newDeliveryStatus, le.addr_flags.DeliveryStatus);
	self.addr_flags.addressType := if((trim(ri.oldAddressType)<>'' or trim(ri.newAddressType)<>'') and sameAddr, ri.newAddressType, le.addr_flags.AddressType);
	self.addr_flags.dropIndicator := if((trim(ri.oldDropIndicator)<>'' or trim(ri.newDropIndicator)<>'') and sameAddr, ri.newDropIndicator, le.addr_flags.DropIndicator);
	self.addr_flags.unit_count := if((ri.oldunit_count<>0 or ri.newunit_count<>0) and sameAddr, ri.newunit_count, le.addr_flags.unit_count);
	self.addr_flags.mail_usage := if((trim(ri.oldmail_usage)<>'' or trim(ri.newmail_usage)<>'') and sameAddr, ri.newmail_usage, le.addr_flags.mail_usage);
	
	// keep the old/new fields for below rollup
	self.oldFname := if(sameAddr and (trim(ri.oldFname)<>'' or trim(ri.newFname)<>''), ri.oldFname, '');
	self.newFname := if(sameAddr and (trim(ri.oldFname)<>'' or trim(ri.newFname)<>''), ri.newFname, '');
	self.oldMname := if(sameAddr and (trim(ri.oldMname)<>'' or trim(ri.newMname)<>''), ri.oldMname, '');
	self.newMname := if(sameAddr and (trim(ri.oldMname)<>'' or trim(ri.newMname)<>''), ri.newMname, '');
	self.oldLname := if(sameAddr and (trim(ri.oldLname)<>'' or trim(ri.newLname)<>''), ri.oldLname, '');
	self.newLname := if(sameAddr and (trim(ri.oldLname)<>'' or trim(ri.newLname)<>''), ri.newLname, '');
	self.oldNameSuffix := if(sameAddr and (trim(ri.oldNameSuffix)<>'' or trim(ri.newNameSuffix)<>''), ri.oldNameSuffix, '');
	self.newNameSuffix := if(sameAddr and (trim(ri.oldNameSuffix)<>'' or trim(ri.newNameSuffix)<>''), ri.newNameSuffix, '');
	self.oldPrimRange := if(sameAddr and (trim(ri.oldPrimRange)<>'' or trim(ri.newPrimRange)<>''), ri.oldPrimRange, '');
	self.newPrimRange := if(sameAddr and (trim(ri.oldPrimRange)<>'' or trim(ri.newPrimRange)<>''), ri.newPrimRange, '');
	self.oldPredir := if(sameAddr and (trim(ri.oldPredir)<>'' or trim(ri.newPredir)<>''), ri.oldPredir, '');
	self.newPredir := if(sameAddr and (trim(ri.oldPredir)<>'' or trim(ri.newPredir)<>''), ri.newPredir, '');
	self.oldPrimName := if(sameAddr and (trim(ri.oldPrimName)<>'' or trim(ri.newPrimName)<>''), ri.oldPrimName, '');
	self.newPrimName := if(sameAddr and (trim(ri.oldPrimName)<>'' or trim(ri.newPrimName)<>''), ri.newPrimName, '');
	self.oldSuffix := if(sameAddr and (trim(ri.oldSuffix)<>'' or trim(ri.newSuffix)<>''), ri.oldSuffix, '');
	self.newSuffix := if(sameAddr and (trim(ri.oldSuffix)<>'' or trim(ri.newSuffix)<>''), ri.newSuffix, '');
	self.oldPostdir := if(sameAddr and (trim(ri.oldPostdir)<>'' or trim(ri.newPostdir)<>''), ri.oldPostdir, '');
	self.newPostdir := if(sameAddr and (trim(ri.oldPostdir)<>'' or trim(ri.newPostdir)<>''), ri.newPostdir, '');
	self.oldUnitDesig := if(sameAddr and (trim(ri.oldUnitDesig)<>'' or trim(ri.newUnitDesig)<>''), ri.oldUnitDesig, '');
	self.newUnitDesig := if(sameAddr and (trim(ri.oldUnitDesig)<>'' or trim(ri.newUnitDesig)<>''), ri.newUnitDesig, '');
	self.oldSecRange := if(sameAddr and (trim(ri.oldSecRange)<>'' or trim(ri.newSecRange)<>''), ri.oldSecRange, '');
	self.newSecRange := if(sameAddr and (trim(ri.oldSecRange)<>'' or trim(ri.newSecRange)<>''), ri.newSecRange, '');
	self.oldCityName := if(sameAddr and (trim(ri.oldCityName)<>'' or trim(ri.newCityName)<>''), ri.oldCityName, '');
	self.newCityName := if(sameAddr and (trim(ri.oldCityName)<>'' or trim(ri.newCityName)<>''), ri.newCityName, '');
	self.oldSt := if(sameAddr and (trim(ri.oldSt)<>'' or trim(ri.newSt)<>''), ri.oldSt, '');
	self.newSt := if(sameAddr and (trim(ri.oldSt)<>'' or trim(ri.newSt)<>''), ri.newSt, '');
	self.oldZip := if(sameAddr and (trim(ri.oldZip)<>'' or trim(ri.newZip)<>''), ri.oldZip, '');
	self.newZip := if(sameAddr and (trim(ri.oldZip)<>'' or trim(ri.newZip)<>''), ri.newZip, '');
	self.oldZip4 := if(sameAddr and (trim(ri.oldZip4)<>'' or trim(ri.newZip4)<>''), ri.oldZip4, '');
	self.newZip4 := if(sameAddr and (trim(ri.oldZip4)<>'' or trim(ri.newZip4)<>''), ri.newZip4, '');
	self.oldSSN := if(sameAddr and (trim(ri.oldSSN)<>'' or trim(ri.newSSN)<>''), ri.oldSSN, '');
	self.newSSN := if(sameAddr and (trim(ri.oldSSN)<>'' or trim(ri.newSSN)<>''), ri.newSSN, '');
	self.oldDOB := if(sameAddr and (trim(ri.oldDOB)<>'' or trim(ri.newDOB)<>''), ri.oldDOB, '');
	self.newDOB := if(sameAddr and (trim(ri.oldDOB)<>'' or trim(ri.newDOB)<>''), ri.newDOB, '');
	self.oldDwellType := if(sameAddr and (trim(ri.oldDwellType)<>'' or trim(ri.newDwellType)<>''), ri.oldDwellType, '');
	self.newDwellType := if(sameAddr and (trim(ri.oldDwellType)<>'' or trim(ri.newDwellType)<>''), ri.newDwellType, '');
	self.oldValid := if(sameAddr and (trim(ri.oldValid)<>'' or trim(ri.newValid)<>''), ri.oldValid, '');
	self.newValid := if(sameAddr and (trim(ri.oldValid)<>'' or trim(ri.newValid)<>''), ri.newValid, '');
	self.oldPrisonAddr := if(sameAddr and (trim(ri.oldPrisonAddr)<>'' or trim(ri.newPrisonAddr)<>''), ri.oldPrisonAddr, '');
	self.newPrisonAddr := if(sameAddr and (trim(ri.oldPrisonAddr)<>'' or trim(ri.newPrisonAddr)<>''), ri.newPrisonAddr, '');
	self.oldHighRisk := if(sameAddr and (trim(ri.oldHighRisk)<>'' or trim(ri.newHighRisk)<>''), ri.oldHighRisk, '');
	self.newHighRisk := if(sameAddr and (trim(ri.oldHighRisk)<>'' or trim(ri.newHighRisk)<>''), ri.newHighRisk, '');
	self.oldCorpMil := if(sameAddr and (trim(ri.oldCorpMil)<>'' or trim(ri.newCorpMil)<>''), ri.oldCorpMil, '');
	self.newCorpMil := if(sameAddr and (trim(ri.oldCorpMil)<>'' or trim(ri.newCorpMil)<>''), ri.newCorpMil, '');
	self.oldDoNotDeliver := if(sameAddr and (trim(ri.oldDoNotDeliver)<>'' or trim(ri.newDoNotDeliver)<>''), ri.oldDoNotDeliver, '');
	self.newDoNotDeliver := if(sameAddr and (trim(ri.oldDoNotDeliver)<>'' or trim(ri.newDoNotDeliver)<>''), ri.newDoNotDeliver, '');
	self.oldDeliveryStatus := if(sameAddr and (trim(ri.oldDeliveryStatus)<>'' or trim(ri.newDeliveryStatus)<>''), ri.oldDeliveryStatus, '');
	self.newDeliveryStatus := if(sameAddr and (trim(ri.oldDeliveryStatus)<>'' or trim(ri.newDeliveryStatus)<>''), ri.newDeliveryStatus, '');
	self.oldAddressType := if(sameAddr and (trim(ri.oldAddressType)<>'' or trim(ri.newAddressType)<>''), ri.oldAddressType, '');
	self.newAddressType := if(sameAddr and (trim(ri.oldAddressType)<>'' or trim(ri.newAddressType)<>''), ri.newAddressType, '');
	self.oldDropIndicator := if(sameAddr and (trim(ri.oldDropIndicator)<>'' or trim(ri.newDropIndicator)<>''), ri.oldDropIndicator, '');
	self.newDropIndicator := if(sameAddr and (trim(ri.oldDropIndicator)<>'' or trim(ri.newDropIndicator)<>''), ri.newDropIndicator, '');
	self.oldunit_count := if(sameAddr and (ri.oldunit_count<>0 or ri.newunit_count<>0), ri.oldunit_count, 0);
	self.newunit_count := if(sameAddr and (ri.oldunit_count<>0 or ri.newunit_count<>0), ri.newunit_count, 0);
	self.oldmail_usage := if(sameAddr and (trim(ri.oldmail_usage)<>'' or trim(ri.newmail_usage)<>''), ri.oldmail_usage, '');
	self.newmail_usage := if(sameAddr and (trim(ri.oldmail_usage)<>'' or trim(ri.newmail_usage)<>''), ri.newmail_usage, '');
	
	self.high_risk_address_source := if((trim(ri.oldHighRiskAddressSource)<>'' or trim(ri.newHighRiskAddressSource)<>'') and sameAddr, ri.newHighRiskAddressSource, le.high_risk_address_source);
	self.high_risk_address_description := if((trim(ri.oldHighRiskAddressDescription)<>'' or trim(ri.newHighRiskAddressDescription)<>'') and sameAddr, ri.newHighRiskAddressDescription, le.high_risk_address_description);
	
	self := le;	// keep the remaining left fields
end;
finalCorr := join(unCorrOnly, corrOnly, 
									left.did=right.did and 
									((trim(right.oldFname)<>'' or trim(right.newFname)<>'') and right.oldFname=left.fname OR	
									(trim(right.oldMname)<>'' or trim(right.newMname)<>'') and right.oldMname=left.mname  OR
									(trim(right.oldLname)<>'' or trim(right.newLname)<>'') and right.oldLname=left.lname OR
									(trim(right.oldNameSuffix)<>'' or trim(right.newNameSuffix)<>'') and right.oldNameSuffix=left.name_suffix  OR
									(trim(right.oldSSN)<>'' or trim(right.newSSN)<>'') and right.oldSSN=left.ssn OR
									(trim(right.oldDOB)<>'' or trim(right.newDOB)<>'') and right.oldDOB=(string)left.dob OR
									// same address and an address field is different
									address.Addr1FromComponents(right.oldPrimRange,right.oldPredir,right.oldPrimName,right.oldSuffix,right.oldPostDir,right.oldUnitDesig,right.oldSecRange) = 
									address.Addr1FromComponents(left.Prim_Range,left.PreDir,left.Prim_Name,left.Suffix,left.PostDir,left.Unit_Desig,left.Sec_Range) OR
									// same address and a flag is different
									(	address.Addr1FromComponents(right.oldPrimRange,right.oldPredir,right.oldPrimName,right.oldSuffix,right.oldPostDir,right.oldUnitDesig,right.oldSecRange) = 
										address.Addr1FromComponents(left.Prim_Range,left.PreDir,left.Prim_Name,left.Suffix,left.PostDir,left.Unit_Desig,left.Sec_Range) AND
									(trim(right.oldDwellType)<>'' or trim(right.newDwellType)<>'') and right.oldDwellType=left.addr_flags.dwelltype OR
									(trim(right.oldValid)<>'' or trim(right.newValid)<>'')  and right.oldValid=left.addr_flags.valid OR
									(trim(right.oldPrisonAddr)<>'' or trim(right.newPrisonAddr)<>'')  and right.oldPrisonAddr=left.addr_flags.PrisonAddr OR
									(trim(right.oldHighRisk)<>'' or trim(right.newHighRisk)<>'')  and right.oldHighRisk=left.addr_flags.HighRisk OR
									(trim(right.oldCorpMil)<>'' or trim(right.newCorpMil)<>'')  and right.oldCorpMil=left.addr_flags.CorpMil OR
									(trim(right.oldDoNotDeliver)<>'' or trim(right.newDoNotDeliver)<>'')  and right.oldDoNotDeliver=left.addr_flags.DoNotDeliver OR
									(trim(right.oldDeliveryStatus)<>'' or trim(right.newDeliveryStatus)<>'')  and right.oldDeliveryStatus=left.addr_flags.DeliveryStatus OR
									(trim(right.oldAddressType)<>'' or trim(right.newAddressType)<>'')  and right.oldAddressType=left.addr_flags.AddressType OR
									(trim(right.oldDropIndicator)<>'' or trim(right.newDropIndicator)<>'')  and right.oldDropIndicator=left.addr_flags.DropIndicator)), 
									correctFutureData(left, right), all, left outer);
									
							
									
// doing the above join results in too many records per rid (potentially), we need to rollup by rid and figure out which field to keep from the multiple choices
layout_working getCorrectCorrections(finalCorr le, finalCorr ri) := transform
	self.fname := map(trim(le.fname)=trim(ri.fname) => le.fname,	// same on both, keep left
										(trim(le.oldFname)<>'' or trim(le.newFname)<>'') and trim(le.newFname)=trim(le.fname) => le.fname,	// correction on this rid and left matches new, so keep left
										(trim(le.oldFname)<>'' or trim(le.newFname)<>'') => ri.fname, // correction on this rid and left doesnt match new, so keep right
										(trim(ri.oldFname)<>'' or trim(ri.newFname)<>'') => ri.fname,	// correction on this rid and right had the correction, so keep right?
										le.fname);	// default to keep left
	self.mname := map(trim(le.mname)=trim(ri.mname) => le.mname,	// same on both, keep left
										(trim(le.oldmname)<>'' or trim(le.newmname)<>'') and trim(le.newmname)=trim(le.mname) => le.mname,	// correction on this rid and left matches new, so keep left
										(trim(le.oldmname)<>'' or trim(le.newmname)<>'') => ri.mname, // correction on this rid and left doesnt match new, so keep right
										(trim(ri.oldMname)<>'' or trim(ri.newMname)<>'') => ri.mname,	// correction on this rid and right had the correction, so keep right?
										le.mname);	// default to keep left
	self.lname := map(trim(le.lname)=trim(ri.lname) => le.lname,	// same on both, keep left
										(trim(le.oldlname)<>'' or trim(le.newlname)<>'') and trim(le.newlname)=trim(le.lname) => le.lname,	// correction on this rid and left matches new, so keep left
										(trim(le.oldlname)<>'' or trim(le.newlname)<>'') => ri.lname, // correction on this rid and left doesnt match new, so keep right
										(trim(ri.oldLname)<>'' or trim(ri.newLName)<>'') => ri.lname,	// correction on this rid and right had the correction, so keep right?
										le.lname);	// default to keep left
	self.name_suffix := map(trim(le.name_suffix)=trim(ri.name_suffix) => le.name_suffix,	// same on both, keep left
													(trim(le.oldNameSuffix)<>'' or trim(le.newNameSuffix)<>'') and trim(le.newNameSuffix)=trim(le.name_suffix) => le.name_suffix,	// correction on this rid and left matches new, so keep left
													(trim(le.oldNameSuffix)<>'' or trim(le.newNameSuffix)<>'') => ri.name_suffix, // correction on this rid and left doesnt match new, so keep right
													(trim(ri.oldNameSuffix)<>'' or trim(ri.newNameSuffix)<>'') => ri.name_suffix,	// correction on this rid and right had the correction, so keep right?
													le.name_suffix);	// default to keep left
	
	self.prim_range := map(	trim(le.prim_range)=trim(ri.prim_range) => le.prim_range,	// same on both, keep left
													(trim(le.oldPrimRange)<>'' or trim(le.newPrimRange)<>'') and trim(le.newPrimRange)=trim(le.prim_range) => le.prim_range,	// correction on this rid and left matches new, so keep left
													(trim(le.oldPrimRange)<>'' or trim(le.newPrimRange)<>'') => ri.prim_range, // correction on this rid and left doesnt match new, so keep right
													(trim(ri.oldPrimRange)<>'' or trim(ri.newPrimRange)<>'') => ri.prim_range,	// correction on this rid and right had the correction, so keep right?
													le.prim_range);	// default to keep left
	self.predir := map(	trim(le.predir)=trim(ri.predir) => le.predir,	// same on both, keep left
											(trim(le.oldpredir)<>'' or trim(le.newpredir)<>'') and trim(le.newpredir)=trim(le.predir) => le.predir,	// correction on this rid and left matches new, so keep left
											(trim(le.oldpredir)<>'' or trim(le.newpredir)<>'') => ri.predir, // correction on this rid and left doesnt match new, so keep right
											(trim(ri.oldPredir)<>'' or trim(ri.newPredir)<>'') => ri.predir,	// correction on this rid and right had the correction, so keep right?
											le.predir);	// default to keep left
	self.prim_name := map(trim(le.prim_name)=trim(ri.prim_name) => le.prim_name,	// same on both, keep left
												(trim(le.oldPrimName)<>'' or trim(le.newPrimName)<>'') and trim(le.newPrimName)=trim(le.prim_name) => le.prim_name,	// correction on this rid and left matches new, so keep left
												(trim(le.oldPrimName)<>'' or trim(le.newPrimName)<>'') => ri.prim_name, // correction on this rid and left doesnt match new, so keep right
												(trim(ri.oldPrimName)<>'' or trim(ri.newPrimName)<>'') => ri.prim_name,	// correction on this rid and right had the correction, so keep right?
												le.prim_name);	// default to keep left
	self.suffix := map(	trim(le.suffix)=trim(ri.suffix) => le.suffix,	// same on both, keep left
											(trim(le.oldsuffix)<>'' or trim(le.newsuffix)<>'') and trim(le.newsuffix)=trim(le.suffix) => le.suffix,	// correction on this rid and left matches new, so keep left
											(trim(le.oldsuffix)<>'' or trim(le.newsuffix)<>'') => ri.suffix, // correction on this rid and left doesnt match new, so keep right
											(trim(ri.oldSuffix)<>'' or trim(ri.newSuffix)<>'') => ri.suffix,	// correction on this rid and right had the correction, so keep right?
											le.suffix);	// default to keep left
	self.postdir := map(trim(le.postdir)=trim(ri.postdir) => le.postdir,	// same on both, keep left
											(trim(le.oldpostdir)<>'' or trim(le.newpostdir)<>'') and trim(le.newpostdir)=trim(le.postdir) => le.postdir,	// correction on this rid and left matches new, so keep left
											(trim(le.oldpostdir)<>'' or trim(le.newpostdir)<>'') => ri.postdir, // correction on this rid and left doesnt match new, so keep right
											(trim(ri.oldPostdir)<>'' or trim(ri.newPostdir)<>'') => ri.postdir,	// correction on this rid and right had the correction, so keep right?
											le.postdir);	// default to keep left
	self.unit_desig := map(	trim(le.unit_desig)=trim(ri.unit_desig) => le.unit_desig,	// same on both, keep left
													(trim(le.oldUnitDesig)<>'' or trim(le.newUnitDesig)<>'') and trim(le.newUnitDesig)=trim(le.unit_desig) => le.unit_desig,	// correction on this rid and left matches new, so keep left
													(trim(le.oldUnitDesig)<>'' or trim(le.newUnitDesig)<>'') => ri.unit_desig, // correction on this rid and left doesnt match new, so keep right
													(trim(ri.oldUnitDesig)<>'' or trim(ri.newUnitDesig)<>'') => ri.unit_desig,	// correction on this rid and right had the correction, so keep right?
													le.unit_desig);	// default to keep left
	self.sec_range := map(trim(le.sec_range)=trim(ri.sec_range) => le.sec_range,	// same on both, keep left
												(trim(le.oldSecRange)<>'' or trim(le.newSecRange)<>'') and trim(le.newSecRange)=trim(le.sec_range) => le.sec_range,	// correction on this rid and left matches new, so keep left
												(trim(le.oldSecRange)<>'' or trim(le.newSecRange)<>'') => ri.sec_range, // correction on this rid and left doesnt match new, so keep right
												(trim(ri.oldSecRange)<>'' or trim(ri.newSecRange)<>'') => ri.sec_range,	// correction on this rid and right had the correction, so keep right?
												le.sec_range);	// default to keep left
	self.city_name := map(trim(le.city_name)=trim(ri.city_name) => le.city_name,	// same on both, keep left
												(trim(le.oldCityName)<>'' or trim(le.newCityName)<>'') and trim(le.newCityName)=trim(le.city_name) => le.city_name,	// correction on this rid and left matches new, so keep left
												(trim(le.oldCityName)<>'' or trim(le.newCityName)<>'') => ri.city_name, // correction on this rid and left doesnt match new, so keep right
												(trim(ri.oldCityName)<>'' or trim(ri.newCityName)<>'') => ri.city_name,	// correction on this rid and right had the correction, so keep right?
												le.city_name);	// default to keep left
	self.st := map(	trim(le.st)=trim(ri.st) => le.st,	// same on both, keep left
									(trim(le.oldst)<>'' or trim(le.newst)<>'') and trim(le.newst)=trim(le.st) => le.st,	// correction on this rid and left matches new, so keep left
									(trim(le.oldst)<>'' or trim(le.newst)<>'') => ri.st, // correction on this rid and left doesnt match new, so keep right
									(trim(ri.oldSt)<>'' or trim(ri.newSt)<>'') => ri.st,	// correction on this rid and right had the correction, so keep right?
									le.st);	// default to keep left
	self.zip := map(trim(le.zip)=trim(ri.zip) => le.zip,	// same on both, keep left
									(trim(le.oldzip)<>'' or trim(le.newzip)<>'') and trim(le.newzip)=trim(le.zip) => le.zip,	// correction on this rid and left matches new, so keep left
									(trim(le.oldzip)<>'' or trim(le.newzip)<>'') => ri.zip, // correction on this rid and left doesnt match new, so keep right
									(trim(ri.oldZip)<>'' or trim(ri.newZip)<>'') => ri.zip,	// correction on this rid and right had the correction, so keep right?
									le.zip);	// default to keep left
	self.zip4 := map(	trim(le.zip4)=trim(ri.zip4) => le.zip4,	// same on both, keep left
										(trim(le.oldzip4)<>'' or trim(le.newzip4)<>'') and trim(le.newzip4)=trim(le.zip4) => le.zip4,	// correction on this rid and left matches new, so keep left
										(trim(le.oldzip4)<>'' or trim(le.newzip4)<>'') => ri.zip4, // correction on this rid and left doesnt match new, so keep right
										(trim(ri.oldZip4)<>'' or trim(ri.newZip4)<>'') => ri.zip4,	// correction on this rid and right had the correction, so keep right?
										le.zip4);	// default to keep left
	
	self.ssn := map(trim(le.ssn)=trim(ri.ssn) => le.ssn,	// same on both, keep left
									(trim(le.oldssn)<>'' or trim(le.newssn)<>'') and trim(le.newssn)=trim(le.ssn) => le.ssn,	// correction on this rid and left matches new, so keep left
									(trim(le.oldssn)<>'' or trim(le.newssn)<>'') => ri.ssn, // correction on this rid and left doesnt match new, so keep right
									(trim(ri.oldSSN)<>'' or trim(ri.newSSN)<>'') => ri.ssn,	// correction on this rid and right had the correction, so keep right?
									le.ssn);	// default to keep left
	self.dob := map((le.dob)=(ri.dob) => le.dob,	// same on both, keep left
									(trim(le.olddob)<>'' or trim(le.newdob)<>'') and trim(le.newdob)=(string)le.dob => le.dob,	// correction on this rid and left matches new, so keep left
									(trim(le.olddob)<>'' or trim(le.newdob)<>'') => ri.dob, // correction on this rid and left doesnt match new, so keep right
									(trim(ri.oldDOB)<>'' or trim(ri.newDOB)<>'') => ri.dob,	// correction on this rid and right had the correction, so keep right?
									le.dob);	// default to keep left
									
	self.addr_flags.dwellType := map(	(le.addr_flags.dwellType)=(ri.addr_flags.dwellType) => le.addr_flags.dwellType,	// same on both, keep left
																		(trim(le.oldDwellType)<>'' or trim(le.newDwellType)<>'') and trim(le.newDwellType)=(string)le.addr_flags.dwellType => le.addr_flags.dwellType,	// correction on this rid and left matches new, so keep left
																		(trim(le.oldDwellType)<>'' or trim(le.newDwellType)<>'') => ri.addr_flags.dwellType, // correction on this rid and left doesnt match new, so keep right
																		(trim(ri.oldDwellType)<>'' or trim(ri.newDwellType)<>'') => ri.addr_flags.dwellType,	// correction on this rid and right had the correction, so keep right?
																		le.addr_flags.dwellType);	// default to keep left
	self.addr_flags.valid := map(	(le.addr_flags.valid)=(ri.addr_flags.valid) => le.addr_flags.valid,	// same on both, keep left
																(trim(le.oldvalid)<>'' or trim(le.newvalid)<>'') and trim(le.newvalid)=(string)le.addr_flags.valid => le.addr_flags.valid,	// correction on this rid and left matches new, so keep left
																(trim(le.oldvalid)<>'' or trim(le.newvalid)<>'') => ri.addr_flags.valid, // correction on this rid and left doesnt match new, so keep right
																(trim(ri.oldValid)<>'' or trim(ri.newValid)<>'') => ri.addr_flags.valid,	// correction on this rid and right had the correction, so keep right?
																le.addr_flags.valid);	// default to keep left;
	self.addr_flags.prisonAddr := map((le.addr_flags.prisonAddr)=(ri.addr_flags.prisonAddr) => le.addr_flags.prisonAddr,	// same on both, keep left
																		(trim(le.oldprisonAddr)<>'' or trim(le.newprisonAddr)<>'') and trim(le.newprisonAddr)=(string)le.addr_flags.prisonAddr => le.addr_flags.prisonAddr,	// correction on this rid and left matches new, so keep left
																		(trim(le.oldprisonAddr)<>'' or trim(le.newprisonAddr)<>'') => ri.addr_flags.prisonAddr, // correction on this rid and left doesnt match new, so keep right
																		(trim(ri.oldPrisonAddr)<>'' or trim(ri.newPrisonAddr)<>'') => ri.addr_flags.prisonAddr,	// correction on this rid and right had the correction, so keep right?
																		le.addr_flags.prisonAddr);	// default to keep left;
	self.addr_flags.highRisk := map((le.addr_flags.highRisk)=(ri.addr_flags.highRisk) => le.addr_flags.highRisk,	// same on both, keep left
																	(trim(le.oldhighRisk)<>'' or trim(le.newhighRisk)<>'') and trim(le.newhighRisk)=(string)le.addr_flags.highRisk => le.addr_flags.highRisk,	// correction on this rid and left matches new, so keep left
																	(trim(le.oldhighRisk)<>'' or trim(le.newhighRisk)<>'') => ri.addr_flags.highRisk, // correction on this rid and left doesnt match new, so keep right
																	(trim(ri.oldHighRisk)<>'' or trim(ri.newHighRisk)<>'') => ri.addr_flags.highRisk,	// correction on this rid and right had the correction, so keep right?
																	le.addr_flags.highRisk);	// default to keep left;
	self.addr_flags.corpMil := map(	(le.addr_flags.corpMil)=(ri.addr_flags.corpMil) => le.addr_flags.corpMil,	// same on both, keep left
																	(trim(le.oldcorpMil)<>'' or trim(le.newcorpMil)<>'') and trim(le.newcorpMil)=(string)le.addr_flags.corpMil => le.addr_flags.corpMil,	// correction on this rid and left matches new, so keep left
																	(trim(le.oldcorpMil)<>'' or trim(le.newcorpMil)<>'') => ri.addr_flags.corpMil, // correction on this rid and left doesnt match new, so keep right
																	(trim(ri.oldCorpMil)<>'' or trim(ri.newCorpMil)<>'') => ri.addr_flags.corpMil,	// correction on this rid and right had the correction, so keep right?
																	le.addr_flags.corpMil);	// default to keep left
	self.addr_flags.doNotDeliver := map((le.addr_flags.doNotDeliver)=(ri.addr_flags.doNotDeliver) => le.addr_flags.doNotDeliver,	// same on both, keep left
																			(trim(le.olddoNotDeliver)<>'' or trim(le.newdoNotDeliver)<>'') and trim(le.newdoNotDeliver)=(string)le.addr_flags.doNotDeliver => le.addr_flags.doNotDeliver,	// correction on this rid and left matches new, so keep left
																			(trim(le.olddoNotDeliver)<>'' or trim(le.newdoNotDeliver)<>'') => ri.addr_flags.doNotDeliver, // correction on this rid and left doesnt match new, so keep right
																			(trim(ri.oldDoNotDeliver)<>'' or trim(ri.newDoNotDeliver)<>'') => ri.addr_flags.doNotDeliver,	// correction on this rid and right had the correction, so keep right?																			
																			le.addr_flags.doNotDeliver);	// default to keep left
	self.addr_flags.deliveryStatus := map((le.addr_flags.deliveryStatus)=(ri.addr_flags.deliveryStatus) => le.addr_flags.deliveryStatus,	// same on both, keep left
																				(trim(le.olddeliveryStatus)<>'' or trim(le.newdeliveryStatus)<>'') and trim(le.newdeliveryStatus)=(string)le.addr_flags.deliveryStatus => le.addr_flags.deliveryStatus,	// correction on this rid and left matches new, so keep left
																				(trim(le.olddeliveryStatus)<>'' or trim(le.newdeliveryStatus)<>'') => ri.addr_flags.deliveryStatus, // correction on this rid and left doesnt match new, so keep right
																				(trim(ri.oldDeliveryStatus)<>'' or trim(ri.newDeliveryStatus)<>'') => ri.addr_flags.deliveryStatus,	// correction on this rid and right had the correction, so keep right?
																				le.addr_flags.deliveryStatus);	// default to keep left
	self.addr_flags.addressType := map(	(le.addr_flags.addressType)=(ri.addr_flags.addressType) => le.addr_flags.addressType,	// same on both, keep left
																			(trim(le.oldaddressType)<>'' or trim(le.newaddressType)<>'') and trim(le.newaddressType)=(string)le.addr_flags.addressType => le.addr_flags.addressType,	// correction on this rid and left matches new, so keep left
																			(trim(le.oldaddressType)<>'' or trim(le.newaddressType)<>'') => ri.addr_flags.addressType, // correction on this rid and left doesnt match new, so keep right
																			(trim(ri.oldAddressType)<>'' or trim(ri.newAddressType)<>'') => ri.addr_flags.addressType,	// correction on this rid and right had the correction, so keep right?
																			le.addr_flags.addressType);	// default to keep left
	self.addr_flags.dropIndicator := map(	(le.addr_flags.dropIndicator)=(ri.addr_flags.dropIndicator) => le.addr_flags.dropIndicator,	// same on both, keep left
																				(trim(le.olddropIndicator)<>'' or trim(le.newdropIndicator)<>'') and trim(le.newdropIndicator)=(string)le.addr_flags.dropIndicator => le.addr_flags.dropIndicator,	// correction on this rid and left matches new, so keep left
																				(trim(le.olddropIndicator)<>'' or trim(le.newdropIndicator)<>'') => ri.addr_flags.dropIndicator, // correction on this rid and left doesnt match new, so keep right
																				(trim(ri.oldDropIndicator)<>'' or trim(ri.newDropIndicator)<>'') => ri.addr_flags.dropIndicator,	// correction on this rid and right had the correction, so keep right?
																				le.addr_flags.dropIndicator);	// default to keep left
																																					
	self.addr_flags.unit_count := map(	(le.addr_flags.unit_count)=(ri.addr_flags.unit_count) => le.addr_flags.unit_count,	// same on both, keep left
																				(le.oldunit_count<>0 or le.newunit_count<>0) and le.newunit_count=le.addr_flags.unit_count => le.addr_flags.unit_count,	// correction on this rid and left matches new, so keep left
																				(le.oldunit_count<>0 or le.newunit_count<>0) => ri.addr_flags.unit_count, // correction on this rid and left doesnt match new, so keep right
																				(ri.oldunit_count<>0 or ri.newunit_count<>0) => ri.addr_flags.unit_count,	// correction on this rid and right had the correction, so keep right?
																				le.addr_flags.unit_count);	// default to keep left	
																				
	self.addr_flags.mail_usage := map(	(le.addr_flags.mail_usage)=(ri.addr_flags.mail_usage) => le.addr_flags.mail_usage,	// same on both, keep left
																				(trim(le.oldmail_usage)<>'' or trim(le.newmail_usage)<>'') and trim(le.newmail_usage)=(string)le.addr_flags.mail_usage => le.addr_flags.mail_usage,	// correction on this rid and left matches new, so keep left
																				(trim(le.oldmail_usage)<>'' or trim(le.newmail_usage)<>'') => ri.addr_flags.mail_usage, // correction on this rid and left doesnt match new, so keep right
																				(trim(ri.oldmail_usage)<>'' or trim(ri.newmail_usage)<>'') => ri.addr_flags.mail_usage,	// correction on this rid and right had the correction, so keep right?
																				le.addr_flags.mail_usage);	// default to keep left
	
	self := le;	// keep the remaining left fields
end;
s := sort(finalCorr, persistent_record_id, -Fname,-Mname,-Lname,-Name_Suffix,-Prim_Range,-Predir,-Prim_Name,-Suffix,-Postdir,-Unit_Desig,-Sec_Range,-City_Name,-St,-Zip,-Zip4,-SSN,-DOB,
																			-addr_flags.DwellType,-addr_flags.Valid,-addr_flags.PrisonAddr,-addr_flags.HighRisk,-addr_flags.CorpMil,-addr_flags.DoNotDeliver,
																			-addr_flags.DeliveryStatus,-addr_flags.AddressType,-addr_flags.DropIndicator,-addr_flags.unit_count, -addr_flags.mail_usage);
finalCorr2 := rollup (s, left.persistent_record_id=right.persistent_record_id, getCorrectCorrections(left,right));									
								
// need to add back the corrOnly records
header_recs_temp := finalCorr2 + corrOnly;

// don't return any future header records with PII information that has been suppressed in a previous RID
header_recs_filtered := join(header_recs_temp, header_suppressions,
						left.did=right.did and 
						left.fname=right.fname and
						left.mname=right.mname and
						left.lname=right.lname and
						left.name_suffix=right.name_suffix and
						left.prim_range=right.prim_range and
						left.predir=right.predir and
						left.prim_name=right.prim_name and
						left.suffix=right.suffix and
						left.postdir=right.postdir and
						left.unit_desig=right.unit_desig and
						left.sec_range=right.sec_range and 
						(left.ssn=right.ssn OR (left.ssn='' and left.valid_ssn='M') or (right.ssn='' and right.valid_ssn='M') ) and
						(left.dob=right.dob OR (left.dob=0 and left.valid_dob='M') OR (right.dob=0 and right.valid_dob='M') ), 
						
						transform(layout_working, self := left), 
						left only );  
					
header_recs := sort(header_recs_filtered, src, fname, mname, lname, name_suffix, prim_range, predir, prim_name, suffix, postdir, unit_desig, sec_range, ssn, dob, rid); 

// output(wUnitCount, named('wUnitCount_dave'));
// output(header_corr, named('header_corr_dave'));
// output(corrPlusHeader, named('corrPlusHeader_dave'));
// output(finalCorr, named('finalCorr_dave'));

// output (header_recs_temp, named ('header_recs_temp_dave'));
// output(header_recs_filtered, named('header_recs_filtered_dave'));
// output(header_suppressions, named('header_suppressions_dave'));
// output (header_recs, named ('header_recs_dave'));

return header_recs;

end;