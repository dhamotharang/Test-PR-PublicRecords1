// ===================================================================================
// ===== RETURNS Business Registration Source Doc records in an ESP-COMPLIANT WAY ====
// ===================================================================================
IMPORT BIPV2, Codes, iesp, TopBusiness_Services, ut;

EXPORT BusinessRegSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for bus reg to build the source doc from, for this reason
	// the payload file of the linkids key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get all bus reg recs for a set of linkids from the linkids key
  SHARED busreg_recs_all := TopBusiness_Services.Key_Fetches(DEDUP(in_docs_linkonly,ALL),
	                                                           inoptions.fetch_level
																														).ds_busreg_linkidskey_recs;

	// If a non-blank idvalue was passed in, join to match on source_rec_id.												 
	shared busreg_recs := JOIN(busreg_recs_all, in_docids,
	                             BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND			 
															 ((left.source_rec_id = (integer) right.IdValue AND
															 right.IdType = Constants.sourcerecid) OR	
															 ((right.IdValue = ut.fnTrim2Upper('BRO'+(STRING)left.br_id) OR 
															 right.IdValue = ut.fnTrim2Upper('BRC'+(STRING)left.br_id)) AND
															 right.IdType = Constants.busvlid) OR
														   right.IdValue = ''),
														   TRANSFORM(LEFT));
		
	iesp.business_registrations.t_BusinessRegistrationOfficer xform_officers(recordof(busreg_recs) L, INTEGER C) := TRANSFORM
		self.Name.First  := choose(C,L.clean_officer1_name.fname,L.clean_officer2_name.fname,L.clean_officer3_name.fname,
		                        L.clean_officer4_name.fname,L.clean_officer5_name.fname,L.clean_officer6_name.fname);  
	  self.Name.Middle := choose(C,L.clean_officer1_name.mname,L.clean_officer2_name.mname,L.clean_officer3_name.mname,
		                        L.clean_officer4_name.mname,L.clean_officer5_name.mname,L.clean_officer6_name.mname);
		self.Name.Last := choose(C,L.clean_officer1_name.lname,L.clean_officer2_name.lname,L.clean_officer3_name.lname,
		                        L.clean_officer4_name.lname,L.clean_officer5_name.lname,L.clean_officer6_name.lname);  
		self.Name.Suffix := choose(C,L.clean_officer1_name.name_suffix,L.clean_officer2_name.name_suffix,L.clean_officer3_name.name_suffix,
		                        L.clean_officer4_name.name_suffix,L.clean_officer5_name.name_suffix,L.clean_officer6_name.name_suffix);  	
		self.Name.Prefix := choose(C,L.clean_officer1_name.title,L.clean_officer2_name.title,L.clean_officer3_name.title,
		                        L.clean_officer4_name.title,L.clean_officer5_name.title,L.clean_officer6_name.title);  		
		self.Position := choose(C,L.rawfields.ofc1_title,L.rawfields.ofc2_title,L.rawfields.ofc3_title,
		                             L.rawfields.ofc4_title,L.rawfields.ofc5_title,L.rawfields.ofc6_title);
	  self.Phone := choose(C,L.clean_phones.ofc1_phone,'');  // Only officer1 has a phone number
		self.Address.StreetNumber 				:= choose(C,L.Clean_officer1_address.prim_range,L.Clean_officer2_address.prim_range,L.Clean_officer3_address.prim_range,
																				L.Clean_officer4_address.prim_range,L.Clean_officer5_address.prim_range,L.Clean_officer6_address.prim_range);
	  
		self.Address.StreetPreDirection 	:= choose(C,L.Clean_officer1_address.predir,L.Clean_officer2_address.predir,L.Clean_officer3_address.predir,
																				L.Clean_officer4_address.predir,L.Clean_officer5_address.predir,L.Clean_officer6_address.predir);
	  
		self.Address.StreetName          	:= choose(C,L.Clean_officer1_address.prim_name,L.Clean_officer2_address.prim_name,L.Clean_officer3_address.prim_name,
																				L.Clean_officer4_address.prim_name,L.Clean_officer5_address.prim_name,L.Clean_officer6_address.prim_name);
	  
		self.Address.StreetSuffix        	:= choose(C,L.Clean_officer1_address.addr_suffix,L.Clean_officer2_address.addr_suffix,L.Clean_officer3_address.addr_suffix,
																				L.Clean_officer4_address.addr_suffix,L.Clean_officer5_address.addr_suffix,L.Clean_officer6_address.addr_suffix);
																				
	  self.Address.StreetPostDirection  := choose(C,L.Clean_officer1_address.postdir,L.Clean_officer2_address.postdir,L.Clean_officer3_address.postdir,
																				L.Clean_officer4_address.postdir,L.Clean_officer5_address.postdir,L.Clean_officer6_address.postdir);
	  
		self.Address.UnitDesignation      := choose(C,L.Clean_officer1_address.unit_desig,L.Clean_officer2_address.unit_desig,L.Clean_officer3_address.unit_desig,
																				L.Clean_officer4_address.unit_desig,L.Clean_officer5_address.unit_desig,L.Clean_officer6_address.unit_desig);
	  
		self.Address.UnitNumber          	:= choose(C,L.Clean_officer1_address.sec_range,L.Clean_officer2_address.sec_range,L.Clean_officer3_address.sec_range,
																				L.Clean_officer4_address.sec_range,L.Clean_officer5_address.sec_range,L.Clean_officer6_address.sec_range);
	  
		self.Address.StreetAddress1      	:= choose(C,L.Clean_officer1_address1,L.Clean_officer2_address1,L.Clean_officer3_address1,
																								L.Clean_officer4_address1,L.Clean_officer5_address1,L.Clean_officer6_address1);
	  
		self.Address.StreetAddress2      	:= choose(C,L.Clean_officer1_address2,L.Clean_officer2_address2,L.Clean_officer3_address2,
																								L.Clean_officer4_address2,L.Clean_officer5_address2,L.Clean_officer6_address2);
	  
		self.Address.City                	:= choose(C,L.Clean_officer1_address.v_city_name,L.Clean_officer2_address.v_city_name,L.Clean_officer3_address.v_city_name,
																				L.Clean_officer4_address.v_city_name,L.Clean_officer5_address.v_city_name,L.Clean_officer6_address.v_city_name);
	  
		self.Address.State               	:= choose(C,L.Clean_officer1_address.st,L.Clean_officer2_address.st,L.Clean_officer3_address.st,
																				L.Clean_officer4_address.st,L.Clean_officer5_address.st,L.Clean_officer6_address.st);
	 
	  self.Address.Zip5                	:= choose(C,L.Clean_officer1_address.zip,L.Clean_officer2_address.zip,L.Clean_officer3_address.zip,
																				L.Clean_officer4_address.zip,L.Clean_officer5_address.zip,L.Clean_officer6_address.zip);
	  
		self.Address.Zip4                	:= choose(C,L.Clean_officer1_address.zip4,L.Clean_officer2_address.zip4,L.Clean_officer3_address.zip4,
																				L.Clean_officer4_address.zip4,L.Clean_officer5_address.zip4,L.Clean_officer6_address.zip4);
		self := [];
  end;
	
	iesp.business_registrations.t_BusinessRegistrationRecord toOut(recordof(busreg_recs) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.FilingNumber 			:= L.rawfields.filing_num;
		SELF.CompanyName      	:= L.rawfields.company;
		SELF.Description       	:= L.rawfields.descript;
		SELF.SicCode    				:= L.rawfields.sic;
		SELF.SicDesc 						:= Codes.Key_SIC4(keyed(sic4_code = L.rawfields.sic))[1].sic4_description;
		SELF.NaicsCode 					:= L.rawfields.naics;
		SELF.NaicsDesc					:= Codes.Key_NAICS(keyed(naics_code = L.rawfields.naics))[1].naics_description;
		SELF.NumberOfEmployees  := (Integer) L.rawfields.emp_size;
		SELF.NumberOfOwners   	:= (Integer) L.rawfields.own_size;
		SELF.CorporationCode 		:= L.rawfields.corpcode;
		SELF.CorporationDesc		:= CODES.BUSREG_COMPANY.CORPCODE(L.rawfields.corpcode);
		SELF.SecretaryOfStateCode	:= L.rawfields.sos_code;
		SELF.SecretaryOfStateDesc	:= CODES.BUSREG_COMPANY.SOS_CODE(L.rawfields.sos_code);
		SELF.FilingCode						:= L.rawfields.filing_cod;
		SELF.FilingDesc       	:= CODES.BUSREG_COMPANY.FILING_COD(L.rawfields.filing_cod);
	  SELF.Status							:= Codes.BUSREG_COMPANY.STATUS(L.rawfields.status); 
		SELF.LicenseNumber			:= L.rawfields.licid;
		SELF.Duration           := L.rawfields.duration;
		SELF.Email     					:= L.rawfields.email;
		
		fips_state 							:= ut.stFips2stAbbrev(L.rawfields.fips[..2]);
	  fips_county							:= Functions_Source.get_county_name(fips_state, 
																																L.rawfields.fips[3..5]);
																																
		SELF.Fips								:= IF(fips_state <> '' AND fips_county <> '',fips_county + '' + fips_state, '');
		
		SELF.Phone            	:= L.clean_phones.biz_phone;
		SELF.StartDate 					:= iesp.ECL2ESP.toDate((INTEGER)L.clean_dates.start_date);
		SELF.FilingDate 				:= iesp.ECL2ESP.toDate((INTEGER)L.clean_dates.file_date);
		SELF.ExpirationDate 		:= iesp.ECL2ESP.toDate((INTEGER)L.clean_dates.exp_date);
		SELF.DisolvedDate 			:= iesp.ECL2ESP.toDate((INTEGER)L.clean_dates.disol_date);
		SELF.ReportDate 				:= iesp.ECL2ESP.toDate((INTEGER)L.clean_dates.rpt_date);
		SELF.RenewalDate				:= iesp.ECL2ESP.toDate((INTEGER)L.clean_dates.renew_date);
		SELF.ChangeDate 				:= iesp.ECL2ESP.toDate((INTEGER)L.clean_dates.chang_date);
		SELF.AppointedDate 			:= iesp.ECL2ESP.toDate((INTEGER)L.clean_dates.appt_date);
		SELF.FiscalDate					:= iesp.ECL2ESP.toDate((INTEGER)L.clean_dates.fisc_date_);
		SELF.ProcessDate 				:= iesp.ECL2ESP.toDate((INTEGER)L.clean_dates.proc_date);
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.Clean_location_address.prim_name,L.Clean_location_address.prim_range,
															L.Clean_location_address.predir,L.Clean_location_address.postdir,
															L.Clean_location_address.addr_suffix,L.Clean_location_address.unit_desig,
															L.Clean_location_address.sec_range,L.Clean_location_address.v_city_name,
															L.Clean_location_address.st,L.Clean_location_address.zip,L.Clean_location_address.zip4,'','',
															L.Clean_location_address1,L.Clean_location_address2);
		SELF.MailingAddress := iesp.ECL2ESP.setAddress(
															L.Clean_mailing_address.prim_name,L.Clean_mailing_address.prim_range,
															L.Clean_mailing_address.predir,L.Clean_mailing_address.postdir,
															L.Clean_mailing_address.addr_suffix,L.Clean_mailing_address.unit_desig,
															L.Clean_mailing_address.sec_range,L.Clean_mailing_address.v_city_name,
															L.Clean_mailing_address.st,L.Clean_mailing_address.zip,L.Clean_mailing_address.zip4,'','',
															L.Clean_mailing_address1,L.Clean_mailing_address2);
		
		// Create a dataset from the 6 sets of officer fields.
		SELF.BusinessRegistrationOfficers := NORMALIZE(DATASET(L),iesp.Constants.BUSREG.MAX_OFFICERS,
		                                 xform_officers(LEFT, COUNTER));
		SELF.RegisteredAgent.Name := L.rawfields.ra_name;
		SELF.RegisteredAgent.Date := iesp.ECL2ESP.toDate((INTEGER)L.rawfields.ra_date);
		
		SELF.RegisteredAgent.Address := iesp.ECL2ESP.setAddress(
															L.Clean_ra_address.prim_name,L.Clean_ra_address.prim_range,
															L.Clean_ra_address.predir,L.Clean_ra_address.postdir,
															L.Clean_ra_address.addr_suffix,L.Clean_ra_address.unit_desig,
															L.Clean_ra_address.sec_range,L.Clean_ra_address.v_city_name,
															L.Clean_ra_address.st,L.Clean_ra_address.zip,L.Clean_mailing_address.zip4,'','',
															L.Clean_ra_address1,L.Clean_ra_address2);
		SELF := [];
	END;
	
	
	SourceView_RecsIesp := PROJECT(busreg_recs, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;
