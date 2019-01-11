IMPORT PersonSlimReport_Services, doxie, doxie_crs, ut, iesp;
EXPORT Functions := MODULE

	EXPORT addressRecsByDid(DATASET(doxie.layout_references_hh) in_did):= FUNCTION 
		//get header recs and apply restrictions
        header_out := doxie.header_records_byDID(dids            := in_did,
                                                 include_dailies := true,
                                                 ReturnLimit     := ut.limits.HEADER_PER_DID,
                                                 DoSearch        := false);
 
		addr_unrolled := project(header_out, TRANSFORM(doxie.Layout_Comp_Addresses,SELF:=LEFT,SELF:=[]));
		doxie.MAC_Address_Rollup(addr_unrolled, iesp.Constants.PersonSlim.MaxAddresses, addresses_rolled);

		iesp.personslimreport.t_PersonSlimReportAddress transAddress(doxie.Layout_Comp_Addresses L)  := TRANSFORM 
			self.streetnumber        := L.prim_range;
			self.streetpredirection  := L.predir;
			self.streetname          := L.prim_name;
			self.streetsuffix        := L.suffix;
			self.streetpostdirection := L.postdir;
			self.unitdesignation     := L.unit_desig;
			self.unitnumber          := L.sec_range;
			self.streetaddress1      := '';
			self.streetaddress2      := '';
			self.city                := L.city_name;
			self.state               := L.st;
			self.zip5                := L.zip;
			self.zip4                := L.zip4;
			self.county              := L.county_name;
			self.postalcode          := '';
			self.statecityzip        := L.st+L.city_name+L.zip;
			self.geoblk              := L.geo_blk;
			self.DateLastSeen        := iesp.ECL2ESP.toDateYM (L.dt_last_seen);
		END;
		
		addresses := PROJECT(addresses_rolled,transAddress(LEFT));
		
		RETURN addresses;
	END;
	
		EXPORT utilityRecsByDid(DATASET(doxie.layout_references_hh) in_did,
                 PersonSlimReport_Services.IParams.PersonSlimReportOptions in_mod):= FUNCTION
								 
			utils := doxie.Util_records(in_did, in_mod.ssn_mask, in_mod.mask_dl, in_mod.GLBPurpose, in_mod.industry_class);

			iesp.personslimreport.t_PersonSlimReportUtility transUtil(doxie_crs.layout_utility.record_layout_slim L)  := TRANSFORM 
			self.utiltype                := L.util_type;
			self.utilcategory            := L.util_category;
			self.utiltypedescription     := L.util_type_description;
			self.connectdate             := iesp.ECL2ESP.toDateString8 (L.connect_date);
			self.datefirstseen           := iesp.ECL2ESP.toDateString8 (L.date_first_seen);
			self.recorddate              := iesp.ECL2ESP.toDateString8 (L.record_date);
			self.name                    := iesp.ECL2ESP.SetName(L.fname,L.mname,L.lname,L.name_suffix,'');
			self.ssn                     := L.ssn;
			self.dob                     := iesp.ECL2ESP.toDateString8 (L.dob);
			self.driverslicensestatecode := L.drivers_license_state_code;
			self.driverslicense          := L.drivers_license;
			self.workphone               := L.work_phone;
			self.phone                   := L.phone;
			self.addrdual                := L.addr_dual;
			self.addresses               := PROJECT(L.address_recs,
                                              TRANSFORM(iesp.share.t_Address,
                                              	SELF := iesp.ECL2ESP.SetAddress(
                                              		 LEFT.prim_name,LEFT.prim_range,LEFT.predir,LEFT.postdir,
                                              		 LEFT.addr_suffix,LEFT.unit_desig,LEFT.sec_range,
                                              		 LEFT.city,LEFT.state,LEFT.zip,LEFT.zip4,LEFT.county_name)));
		END;
		
		utilities := PROJECT(utils,transUtil(LEFT));

		RETURN utilities;
	END;
	
END;