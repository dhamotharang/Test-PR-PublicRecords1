IMPORT PersonSlimReport_Services, PersonReports, doxie, doxie_crs, ut, iesp, suppress;
IMPORT address as ad; //had to do this to avoid error in dl transform - error C2167: Unknown identifier "Sec_Range_Eq"
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
	
	//function will return NonDMVSources if ('IncludeNonDMVSources', TRUE)
	//is #STORED or #CONSTANT somewhere
	EXPORT dlsRecsByDid(DATASET(doxie.layout_references_hh) in_did):= FUNCTION 
		//helper functions
		d2i(iesp.share.t_Date d) := iesp.ECL2ESP.DateToInteger(d);
		pickLatestDate(iesp.share.t_Date l, iesp.share.t_Date r) := if(d2i(l) > d2i(r), l, r);
		pickLongestStr(string l, string r) := if ( length(trim(l)) > length(trim(r)), l, r );
		
		dls := PersonReports.DL_records(in_did);
		
		s_preRoll := sort(dls, OriginState, DriverLicense,Address.State,Address.City,Address.StreetNumber,
											Address.StreetName, -Address.UnitNumber,-Address.StreetPreDirection, Address.StreetSuffix='',
											Address.Zip4='', -Name.first, -Name.middle[1], -Name.last,-d2i(DOB), SSN,-d2i(expirationDate));
									
		//address rollup inspired from - PublicRecords.Doxie.MAC_Address_Rollup							
		rolled := rollup(s_preRoll,
                    LEFT.OriginState   = RIGHT.OriginState   and LEFT.DriverLicense = RIGHT.DriverLicense and
                    LEFT.Address.State = RIGHT.Address.State and LEFT.Address.City  = RIGHT.Address.City  and
                    LEFT.Address.StreetNumber = RIGHT.Address.StreetNumber and
                    //only rollup a mismatched prim_name / StreetName when one is better than the other
                    ( LEFT.Address.StreetName = RIGHT.Address.StreetName or
                    	(LEFT.Address.Zip4<>'' and RIGHT.Address.Zip4='') and 
                    	( ut.StringSimilar(LEFT.Address.StreetName,RIGHT.Address.StreetName)<3 or
                    	length(trim(left.Address.StreetNumber))>2 )
                    )  and 
                    ut.nneq(LEFT.Address.StreetPreDirection, RIGHT.Address.StreetPreDirection) and
                    ad.Sec_Range_Eq(LEFT.Address.UnitNumber,RIGHT.Address.UnitNumber)<10 and
                    LEFT.Name.last = RIGHT.Name.last and LEFT.Name.first = RIGHT.Name.first and
                    LEFT.Name.middle[1] = RIGHT.Name.middle[1] and
                    d2i(LEFT.DOB) = d2i(RIGHT.DOB) and LEFT.SSN = RIGHT.SSN,
                    TRANSFORM(iesp.driverlicense2.t_DLEmbeddedReport2Record,
                       SELF.expirationdate     := pickLatestDate(LEFT.expirationDate,     RIGHT.expirationDate);
                       SELF.issueDate          := pickLatestDate(LEFT.issueDate,          RIGHT.issueDate);
                       SELF.Address.UnitNumber := pickLongestStr(LEFT.Address.UnitNumber, RIGHT.Address.UnitNumber);
                       SELF.Address.County     := pickLongestStr(LEFT.Address.County, 		 RIGHT.Address.County );
                       SELF := LEFT)	);
 
		fdls := CHOOSEN(sort(rolled, OriginState, DriverLicense, -d2i(expirationDate),-d2i(issueDate)),
                  iesp.Constants.PersonSlim.MaxDLs);

		RETURN fdls;
	END;
	
	EXPORT pawRecsByDid(DATASET(doxie.layout_references_hh) in_did,
                       PersonSlimReport_Services.IParams.PersonSlimReportOptions in_mod):= FUNCTION
      // standard restrictions - glb, dppa etc not enforced on PAW data					 
      paw_raw := PersonReports.peopleatwork_records(in_did);
      Suppress.MAC_Mask(paw_raw, recs_masked,ssn,none,true,false,,,,in_mod.ssn_mask);
      paws := CHOOSEN(recs_masked,iesp.Constants.PersonSlim.MaxPeopleAtWork);
      RETURN paws;
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