import AutoStandardI,Doxie_Raw, AddressFeedback_Services,gateway;

EXPORT mod_expandedPhoneRecords (doxie.expandedPhones.searchParams in_mod, DATASET(gateway.layouts.config) gateways = DATASET([], gateway.layouts.config)) := MODULE
	EXPORT getPhonesRemote () := FUNCTION
			serviceURL := gateways(Gateway.Configuration.IsNeutralRoxie(servicename))[1].URL;
			serviceName := 'doxie.phone_noreconn_search';
			// serviceURL := 'http://certstagingvip.hpcc.risk.regn.net:9876';

			doxie.expandedPhones.soap_response_layout soapFailure() := TRANSFORM 
				SELF := [];
			END;

			doxie.expandedPhones.in_layout prepare_phoneplus_input() := transform
				self.DPPAPurpose :=  in_mod.DPPAPurpose;
				self.GLBPurpose := in_mod.GLBPurpose;
				self.DID := in_mod.DID;
				self.SSN := in_mod.SSN;
				self.UnParsedFullName := in_mod.UnParsedFullName;
				self.FirstName := in_mod.firstname;
				self.MiddleName := in_mod.middlename;
				self.LastName := in_mod.lastname;
				self.NameSuffix := in_mod.namesuffix;
				self.Addr := in_mod.addr;
				self.PrimRange := in_mod.primrange;
				self.PreDir := in_mod.predir;
				self.PrimName := in_mod.primname;
				self.Suffix := in_mod.suffix;
				self.PostDir := in_mod.postdir;
				self.SecRange := in_mod.secrange;
				self.City := in_mod.city;
				self.State := in_mod.state;
				self.Zip := in_mod.Zip;
				self.County := in_mod.County;
				self.Phone := in_mod.phone;
				self.IncludeLastResort := in_mod.IncludeLastResort;
				self.IncludeDeadContacts := in_mod.IncludeDeadContacts;
				self.DataPermissionMask := in_mod.DataPermissionMask;
				self.Gateways := gateways;
				self._TransactionId := in_mod._TransactionId;
				self._Blind := Gateway.Configuration.GetBlindOption(gateways);
			END;	

			soap_input := dataset ([prepare_phoneplus_input()]);
			soapResponse := IF(serviceURL!='', soapcall(soap_input, 
																									serviceURL, 
																									serviceName,  
																									{soap_input},
																									DATASET(doxie.expandedPhones.soap_response_layout),
																									XPATH(serviceName + 'Response/Results/Result/Dataset[@name=\'Results\']/Row'),
																									ONFAIL(soapFailure())),
																									DATASET([],doxie.expandedPhones.soap_response_layout));
			return soapResponse;
	END;

	getInRecsPhones (dataset(doxie.Layout_Rollup.KeyRec) recs) := FUNCTION
			slim_phonerec := RECORD
				STRING20 phone;
			END;		

			doxie.Layout_Rollup.AddrRec trans1(doxie.Layout_Rollup.AddrRec r) := transform 
				self := r;
			end;

			addrsRecs := normalize(recs, left.addrRecs, trans1(right));
			
			slim_phonerec trans2(doxie.Layout_Rollup.PhoneRec R) := TRANSFORM
				SELF.phone := R.phone;
				SELF := [];
			END;

			rollupphones := dedup(sort(normalize(addrsRecs, LEFT.phoneRecs, trans2(RIGHT)),phone));
			rollupphones_set := set(rollupphones, phone);
			return rollupphones_set;
	END;

	EXPORT getPhoneCombinedRecs (dataset(doxie.Layout_Rollup.KeyRec) recs, dataset(doxie.expandedPhones.soap_response_layout) phonePlusRecs) := FUNCTION

			phonePlusRecsDedup := dedup(sort(phonePlusRecs, phone), phone)(did='0' or did = '');
			rollupphones_set := getInRecsPhones(recs);
			phonePlusRecsTemp := phonePlusRecsDedup (phone not in rollupphones_set);

			doxie.Layout_Rollup.NameRec Names(doxie.expandedPhones.soap_response_layout le) := TRANSFORM
				SELF.title := le.title,
				SELF.fname := le.fname,
				SELF.mname := le.mname,
				SELF.lname := le.lname,
				SELF.name_suffix := le.name_suffix,
				SELF := [];
			END;		

			doxie.Layout_Rollup.PhoneRec phoneRecs(doxie.expandedPhones.soap_response_layout le) := TRANSFORM
				SELF.phone := le.phone,
				SELF.timezone  :=  le.timezone,
				SELF.bdid  := 0,
				SELF.did  := 0,
				SELF.listing_type_res  := le.listing_type_res,
				SELF.listing_type_bus  := le.listing_type_bus,
				SELF.listing_type_gov  := le.listing_type_gov,
				SELF.new_type  := le.new_type,
				SELF.carrier  := le.Carrier_Name,
				SELF.carrier_city  := le.phone_region_city,
				SELF.carrier_state  := le.phone_region_st,
				SELF.PhoneType   := le.append_phone_type,
				SELF.listed_name  :=  le.listed_name,
				SELF.caption_text  := le.caption_text,
				SELF := [];					
			END;

			doxie.Layout_Rollup.AddrRec addressRecs(doxie.expandedPhones.soap_response_layout le) := TRANSFORM
				SELF.tnt := le.tnt,
				SELF.first_seen := (unsigned6) le.dt_first_seen,  
				SELF.last_seen := (unsigned6) le.dt_last_seen,
				SELF.predir := le.predir,
				SELF.prim_range := le.prim_range,
				SELF.prim_name := le.prim_name,
				SELF.suffix := le.suffix,
				SELF.postdir := le.postdir,
				SELF.unit_desig := le.unit_desig,
				SELF.sec_range := le.sec_range,
				SELF.city_name := le.city_name,
				SELF.st := le.st,
				SELF.zip := le.zip,
				SELF.zip4 := le.zip4,
				SELF.county_name:= le.county_name,
				SELF.phonerecs := dataset([phoneRecs(le)]),
				self :=[];
			END;

			doxie.Layout_Rollup.SsnRec SsnRec(doxie.expandedPhones.soap_response_layout le) := TRANSFORM
				SELF.ssn := le.ssn,
				SELF := [];
			END;			

			doxie.Layout_Rollup.DodRec DodRec(doxie.expandedPhones.soap_response_layout le) := TRANSFORM
				SELF.dod := le.dod,
				SELF.deceased := le.deceased,
				SELF := [];
			END;

			doxie.Layout_Rollup.KeyRec trans(doxie.expandedPhones.soap_response_layout le):= transform
				self.nameRecs := dataset([Names(le)]);
				self.addrRecs := dataset([addressRecs(le)]); 
				self.ssnRecs := dataset([SsnRec(le)]); 
				self.dodRecs := dataset([DodRec(le)]);
				self.expandedPhonePlusRecord := true;
				self := [];
			END;

			proj_phonePlusRecsTemp := project(phonePlusRecsTemp, trans(LEFT));
			phonePlusRecsCombined := recs + proj_phonePlusRecsTemp;
			
			//applying the same sorting as done in doxie.rollup_presentation line#246 to guarantee that by adding expanded phone records we are not changing order of the records.
			phonePlusRecsFinalSorted := sort(phonePlusRecsCombined, includedByHHID,expandedPhonePlusRecord, penalt,bestSrchedValidSSNScore, bestSrchedAddrTntScore, -((unsigned6)did <> 0),
							-bestSrchedAddrDate, bestTntScore,-maxDate,-head_cnt,maxRid);

			return if(count(phonePlusRecsCombined) > 2000 , recs, phonePlusRecsFinalSorted);
	END;
END;
