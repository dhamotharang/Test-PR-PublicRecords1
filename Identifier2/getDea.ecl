import doxie, iesp, deaV2_Services, ut, suppress, dea, riskwise;

t_deaLayout := iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record;
t_deaChildren := iesp.deacontrolledsubstance.t_DEAControlledSubstanceRecord;
dea_child := DeaV2_Services.assorted_layouts.layout_output_child;

export getDea(dataset(identifier2.layout_Identifier2) indata, boolean Include_Dea_Data=false, string6 ssnMask='') := function 

	working_layout := record
		indata;
		
		string9 RegistrationNumber;
		iesp.deacontrolledsubstance.t_DEAControlledSubstanceRecord ctrl;
		
		boolean isExpired;
		boolean isExactSSN;
		boolean isExactLast;
		boolean isExactFirst;
		// unsigned ExpirationDate;
	end;

	dea_rn := join( indata, DEA.key_DEA_did, keyed( right.my_did in ID2Common.didset(left) ),
		transform( working_layout, self.RegistrationNumber := right.Dea_Registration_Number, self := left, self := [] ),
		keep(ut.limits.DEA_PER_DID),
		atmost(riskwise.max_atmost)
	);
	dea_nodup := dedup(sort(dea_rn,RegistrationNumber),RegistrationNumber);


	working_layout getLicenses( working_layout le, dea.Key_dea_reg_num ri ) := TRANSFORM
		// calculate exact matches
		self.isExactSSN   := not input.Exact_SSN_Match        or ri.best_ssn=le.ssn;
		self.isExactLast  := not input.Exact_Last_Name_Match  or ri.lname=le.lname;
		self.isExactFirst := not input.Exact_First_Name_Match or ri.fname=le.fname;

		self.isExpired := ri.expiration_date < ut.GetDate;

		self.ctrl.SSN            := ri.best_ssn;
		self.ctrl.CompanyName    := ri.cname;
		
		name := trim(ri.address1,left,right);// from DeaV2_Services.DEAV2_Search_recs:64
		self.ctrl.Name           := iesp.ECL2ESP.SetName (ri.fname, ri.mname, ri.lname, ri.name_suffix, ri.title, name);

		add := TRIM(ri.Address2,LEFT,RIGHT)
			+' '+TRIM(ri.Address3,LEFT,RIGHT)
			+' '+TRIM(ri.Address4,LEFT,RIGHT)
			+' '+TRIM(ri.Address5,LEFT,RIGHT); // from DeaV2_Services.DEAV2_Search_recs:58
		self.ctrl.Address        := iesp.ECL2ESP.SetAddress( ri.prim_name, ri.prim_range, ri.predir, ri.postdir, ri.addr_suffix, ri.unit_desig, ri.sec_range, ri.p_city_name, ri.st, ri.zip, ri.zip4, '', '', add);
		self.ctrl.BusinessType   := DeaV2_Services.business_activity(ri.Business_Activity_code);
		self.ctrl.DrugSchedules  := ri.Drug_Schedules;
		self.ctrl.ExpirationDate := iesp.ECL2ESP.toDate( (integer4)ri.Expiration_Date );
		// self.ctrl.RegistrationNumber := ri.dea_registration_number;
		
		// self.ExpirationDate := (unsigned)ri.Expiration_Date;

		// self.d := ri;
		self   := le;
	end;
	lic := join( dea_nodup, dea.Key_dea_reg_num,
		left.RegistrationNumber != ''
			and keyed(left.RegistrationNumber=right.dea_registration_number),
		getLicenses(left,right),
		atmost(riskwise.max_atmost)
	);
	lic_filtered := lic( isExactSSN and isExactFirst and isExactLast );

	lic_sorted  := sort( lic_filtered, RegistrationNumber, ctrl.Address.State, -ID2Common.fromESDLDate(ctrl.ExpirationDate) );
	lic_deduped := dedup( lic_sorted, RegistrationNumber, ctrl.Address.state);
	
	Suppress.MAC_Mask(lic_deduped, lic_masked, ctrl.ssn, '', true, false, false, false, '', ssnMask);

	//---------------------------------------------------------------------------	 
	identifier2.layout_Identifier2 add_dea(lic_masked le) := TRANSFORM
		self.DEALicense.HasValidDEALicense := not le.isExpired; // 'found' is implied since there's a record being processed here
		self.DEALicense.ControlledSubstanceRecord.AlsoFound := false;
		self.DEALicense.ControlledSubstanceRecord.RegistrationNumber := le.RegistrationNumber;
		
		self.DEALicense.ControlledSubstanceRecord.ControlledSubstancesInfo := if( Include_DEA_Data,
			dataset( [le.ctrl], iesp.deacontrolledsubstance.t_DEAControlledSubstanceRecord ),
			dataset( [], iesp.deacontrolledsubstance.t_DEAControlledSubstanceRecord )
		);
		self := le;
	end;

	with_dea := project(lic_masked, add_dea(left));

	identifier2.layout_Identifier2 dea_roll( identifier2.layout_Identifier2 le, identifier2.layout_Identifier2 ri ) := TRANSFORM
		self.DEALicense.ControlledSubstanceRecord.ControlledSubstancesInfo := le.DEALicense.ControlledSubstanceRecord.ControlledSubstancesInfo + ri.DEALicense.ControlledSubstanceRecord.ControlledSubstancesInfo;
		self.DEALicense.HasValidDEALicense                                 := le.DEALicense.HasValidDEALicense or ri.DEALicense.HasValidDEALicense;
		self := le;
	END;
	dea_rolled := rollup( with_dea, true, dea_roll(left,right) );

	hasRecord := if( exists(dea_rolled), dea_rolled, indata );

	identifier2.layout_Identifier2 finalFormat( hasRecord le ) := TRANSFORM
		found   := exists( le.DEALicense.ControlledSubstanceRecord.ControlledSubstancesInfo );
		notExpired := exists( le.DEALicense.ControlledSubstanceRecord.ControlledSubstancesInfo( ID2Common.fromESDLDate( ExpirationDate ) <= (integer)ut.GetDate ) );

		self.DEALicense.RiskIndicators := MAP(
			not found  => dataset([iesp.ECL2ESP.setRiskIndicator('DN',Identifier2.getRiskStatusDesc('DN'))], iesp.share.t_RiskIndicator),
			notExpired => dataset([], iesp.share.t_RiskIndicator),
			dataset([iesp.ECL2ESP.setRiskIndicator('DE',Identifier2.getRiskStatusDesc('DE'))], iesp.share.t_RiskIndicator)
		);
		self.DEALicense.StatusIndicators := if(found and notExpired,
			dataset([iesp.ECL2ESP.setStatusIndicator('DA',Identifier2.getRiskStatusDesc('DA'))], iesp.share.t_RiskIndicator),
			dataset([], iesp.share.t_RiskIndicator));
		
		self := le;
	END;
	dea_final := project( hasRecord, finalFormat(left) );

	return dea_final;
end;