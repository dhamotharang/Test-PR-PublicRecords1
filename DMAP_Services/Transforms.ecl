IMPORT $, address, iesp, Doxie, progressive_phone, ut, LN_PropertyV2_Services, STD, Suppress, VerificationOfOccupancy;

date6todate8(date):= (UNSIGNED4)ut.date6_to_date8(date);

EXPORT Transforms := MODULE
		
	EXPORT $.Layouts.borrower_layout xform_bestDmap(Doxie.layout_best L):= TRANSFORM
		SELF.Did:= L.did;
		SELF.Name:= iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix, '', L.fname+L.mname+L.lname+L.name_suffix);
		SELF.SSN:= L.SSN;
		SELF.DOB:= (STRING8)L.dob;
		SELF.Address.PrimRange:= L.prim_range;
		SELF.Address.PrimName:= L.prim_name;
		SELF.Address.PreDir:= L.predir;
		SELF.Address.PostDir:= L.postdir;
		SELF.Address.AddrSuffix:= L.suffix;
		SELF.Address.UnitDesig:= L.unit_desig;
		SELF.Address.SecRange:= L.sec_range;
		SELF.Address.CityName:= L.city_name;
		SELF.Address.St:= L.st;
		SELF.Address.Zip:= L.zip;
		SELF.DateLastSeen:= date6todate8(L.addr_dt_last_seen);
		SELF.is_best_address:= TRUE;
		SELF:= [];
		SELF:= L;
	END;	
		
	EXPORT Address.Layout_Batch_In xform_inputAddr(iesp.Share.t_Address L) := TRANSFORM
		SELF.uid := 0;
		SELF.addr1 := MAP( L.StreetName<> ''=> Address.Addr1FromComponents(L.StreetNumber, L.StreetPreDirection, L.StreetName, L.StreetSuffix, L.StreetPostDirection, L.UnitDesignation, L.UnitNumber) , STD.Str.CleanSpaces(L.StreetAddress1+' '+L.StreetAddress2));
		SELF.city_name := L.City;
		SELF.st := L.State;
		SELF.zip := L.Zip5;
		SELF:= [];
	END;	
	
	EXPORT $.Layouts.addr_layout xform_cleanAddr(address.Layout_Batch_Out L):= TRANSFORM
		SELF.PrimRange:= L.prim_range;
		SELF.PrimName:= L.prim_name;
		SELF.PreDir:= L.predir;
		SELF.PostDir:= L.postdir;
		SELF.AddrSuffix:= L.addr_suffix;
		SELF.UnitDesig:= L.unit_desig;
		SELF.SecRange:= L.sec_range;
		SELF.CityName:= L.P_city_name;
		SELF.St:= L.st;
		SELF.Zip:= L.zip;
		SELF.is_input_property:= TRUE;
		SELF:= [];
	END;
	
	EXPORT iesp.dmap.t_DMAPPropertyBase xform_ownedPropAddr($.Layouts.addr_layout L, $.Layouts.deed_layout R):= TRANSFORM 
		SELF.Address.StreetAddress1 := Address.Addr1FromComponents(L.PrimRange, L.Predir, L.PrimName, L.AddrSuffix, L.Postdir, L.UnitDesig, L.SecRange);
		SELF.Address.StreetAddress2 := Address.Addr2FromComponents(L.CityName, L.St, L.zip);
		SELF.Address.City := L.CityName;
		SELF.Address.State:= L.St;
		SELF.Address.Zip5 := L.zip;
		SELF.PropertyType	:= R.PropertyType;
		SELF := [];
	END;
														
	EXPORT iesp.share.t_address xform_t_address($.Layouts.addr_layout L):= TRANSFORM
		SELF.StreetAddress1 := Address.Addr1FromComponents(L.PrimRange, L.Predir, L.PrimName, L.AddrSuffix, L.Postdir, L.UnitDesig, L.SecRange);
		SELF.StreetAddress2 := Address.Addr2FromComponents(L.CityName, L.St, L.zip);
		SELF.City := L.CityName;
		SELF.State := L.St;
		SELF.Zip5 := L.zip;
		SELF := [];
	END;
	
	EXPORT $.Layouts.borrower_layout xform_compAddr(Doxie.Layout_Comp_Addresses L):= TRANSFORM
		SELF.Did:= L.did;
		SELF.Address.PrimRange:= L.prim_range;
		SELF.Address.PrimName:= L.prim_name;
		SELF.Address.PreDir:= L.predir;
		SELF.Address.PostDir:= L.postdir;
		SELF.Address.AddrSuffix:= L.suffix;
		SELF.Address.UnitDesig:= L.unit_desig;
		SELF.Address.SecRange:= L.sec_range;
		SELF.Address.CityName:= L.city_name;
		SELF.Address.St:= L.st;
		SELF.Address.Zip:= L.zip;
		SELF.DateLastSeen:= date6todate8(L.dt_last_seen);
		SELF.DateFirstSeen:= date6todate8(L.dt_first_seen);
		SELF.is_best_address:= FALSE;
		SELF:=[];
	END;	
	
	EXPORT progressive_phone.layout_progressive_batch_in xform_phoneIn($.Layouts.borrower_layout L):= TRANSFORM
		SELF.did									:= (INTEGER)L.did;
		SELF.ssn									:= (STRING)L.ssn;
		SELF.dob                  := L.dob;
		SELF.name_first 					:= L.name.First;
		SELF.name_middle 					:= L.name.middle;
		SELF.name_last  					:= L.name.last;
		SELF.name_suffix 					:= L.name.suffix;
		SELF.prim_range						:= L.Address.PrimRange;
		SELF.predir								:= L.Address.Predir;
		SELF.prim_name						:= L.Address.PrimName;
		SELF.suffix								:= L.Address.AddrSuffix;
		SELF.postdir							:= L.Address.Postdir;
		SELF.unit_desig						:= L.Address.UnitDesig;
		SELF.sec_range						:= L.Address.SecRange;
		SELF.p_city_name        	:= L.Address.CityName;
		SELF.st        						:= L.Address.St;
		SELF.z5      							:= L.Address.Zip;
		SELF											:= L;
		SELF											:= [];
	END;	

	EXPORT $.Layouts.phone_layout xform_phoneOut(progressive_phone.layout_progressive_online_out L):= TRANSFORM
		SELF.Phone:= L.subj_phone10;
	END;
	
	EXPORT $.Layouts.Deed_layout xform_deedRollUp($.Layouts.Deed_layout L, $.Layouts.Deed_layout R):= TRANSFORM
		SELF.BorrowerVestingDesc := IF(L.BorrowerVestingDesc<>'', L.BorrowerVestingDesc, R.BorrowerVestingDesc);
		SELF.BuyerVestingDesc := IF(L.BuyerVestingDesc<>'', L.BuyerVestingDesc, R.BuyerVestingDesc);
		SELF.YearLotAcquired:= IF(L.YearLotAcquired<>'', L.YearLotAcquired, R.YearLotAcquired);
		SELF.OriginalCost:= IF(L.OriginalCost<>'', L.OriginalCost, R.OriginalCost);
		SELF.PropertyType:= IF(L.PropertyType<>'', L.PropertyType, R.PropertyType);
		SELF:= L;
		SELF:= [];
	END; 
	
	EXPORT $.Layouts.Assessment_layout xform_assessmentsRollUp($.Layouts.Assessment_layout L, $.Layouts.Assessment_layout R):= TRANSFORM
		SELF.NoOfUnits := IF(L.NoOfUnits<>'', L.NoOfUnits, R.NoOfUnits);
		SELF.SubjectPropertyType := IF(L.SubjectPropertyType<>'', L.SubjectPropertyType, R.SubjectPropertyType);
		SELF.LegalDescription := IF(L.LegalDescription<>'', L.LegalDescription, R.LegalDescription);
		SELF.YearBuilt := IF(L.YearBuilt<>'', L.YearBuilt, R.YearBuilt);
		SELF.RealEstateTaxesCurrentProperty := IF(L.RealEstateTaxesCurrentProperty<>'', L.RealEstateTaxesCurrentProperty, R.RealEstateTaxesCurrentProperty);
		SELF:= [];
	END;
		
	EXPORT $.Layouts.fids_layout xform_fidsOut($.Layouts.addr_layout L, RECORDOF(LN_PropertyV2_Services.keys.search_addr) R):= TRANSFORM
		SELF.AddrSeq:=L.AddrSeq;
		SELF.is_input_property:= L.is_input_property;
		SELF:= R;
	END;
	
	EXPORT $.Layouts.addr_layout xform_inputToaddrLayout($.Layouts.Input_Layout L):= TRANSFORM
		SELF:= L.PropertyAddr;
		SELF:= L;
	END;
		
  EXPORT $.Layouts.addr_layout xform_vooOwnedAddr(VerificationOfOccupancy.Layouts.Layout_property L, INTEGER C) := TRANSFORM
    SELF.PrimRange:= L.property_prim_range;
    SELF.PreDir:= L.property_predir;
    SELF.PrimName:= L.property_prim_name;
    SELF.AddrSuffix:= L.property_suffix;
    SELF.PostDir:= L.property_postdir;
    SELF.UnitDesig:= L.property_unit_desig;
    SELF.SecRange:= L.property_sec_range;
    SELF.CityName:= L.property_city;
    SELF.St:= L.property_st;
    SELF.Zip:= L.property_zip;
    SELF.is_input_property:= FALSE;
    SELF.AddrSeq := C;
    SELF:= [];
  END;
		
  EXPORT VerificationOfOccupancy.Layouts.Layout_VOOShell xform_vooShellIn(DMAP_Services.Layouts.borrower_layout L) := TRANSFORM
    todaysDate	 						:= std.Date.Today();
    SELF.DID 								:= L.did;		
    SELF.Seq								:= L.Address.AddrSeq;			
    SELF.historydate 				:= (INTEGER)(todaysDate[1..6]);
    SELF.ssn 								:= L.ssn;
    SELF.dob 								:= L.dob;
    SELF.fname  						:= L.Name.First;
    SELF.mname 							:= L.Name.Middle;
    SELF.lname  						:= L.Name.last;
    SELF.prim_range					:= L.Address.PrimRange;
    SELF.predir							:= L.Address.Predir;
    SELF.prim_name					:= L.Address.primname;
    SELF.addr_suffix				:= L.Address.AddrSuffix;
    SELF.postdir						:= L.Address.Postdir;
    SELF.unit_desig					:= L.Address.UnitDesig;
    SELF.sec_range					:= L.Address.SecRange;
    SELF.p_city_name        := L.Address.CityName;
    SELF.st        					:= L.Address.St;
    SELF.z5      						:= L.Address.zip;
    SELF										:= [];
  END;	
		
	EXPORT $.Layouts.dmap_Layout xform_dataMask($.Layouts.dmap_Layout L, $.IParams.ReportParams input_params):= TRANSFORM
		t_dob			 :=	iesp.ECL2ESP.toMaskableDatestring8(L.dob);
		masked_dob := IF( L.dob != '',
											iesp.ECL2ESP.ApplyDateStringMask(t_dob, input_params.dob_mask_val),
											t_dob);
		SELF.dob   := masked_dob.YEAR + masked_dob.MONTH + masked_dob.DAY;
		SELF.SSN	 := Suppress.ssn_mask(L.ssn, input_params.ssn_mask_val);
		SELF	 		 := L;	
	END;
	
	EXPORT iesp.dmap.t_DMAPReportResult xform_finalLayout($.Layouts.dmap_Layout subject_with_currentAddr,
																												$.Layouts.dmap_Layout subject_with_priorAddr,
																												STRING10 phone1,
																												STRING10 phone2,
																												DATASET($.Layouts.addr_layout) input_prop_addr,
																												$.Layouts.Deed_layout input_prop_deed_info,
																												$.Layouts.Assessment_layout input_prop_assess_info,
																												DATASET(iesp.dmap.t_DMAPPropertyBase) owned_prop_addr
																												):= TRANSFORM
		SELF.Borrower.UniqueId:=(STRING)subject_with_currentAddr.did,
		SELF.Borrower.Name:= subject_with_currentAddr.Name;
		SELF.Borrower.DOB:= iesp.ECL2ESP.toMaskableDatestring8(subject_with_currentAddr.dob);
		SELF.Borrower.SSN:= subject_with_currentAddr.ssn;
		SELF.Borrower.Phone1:= Phone1;
		SELF.Borrower.Phone2:= Phone2;
		SELF.Borrower.CurrentAddress:= ROW(xform_t_address(subject_with_currentAddr.Address));
		Years_at_Address_current:= STD.Date.YearsBetween(subject_with_currentAddr.datefirstseen, subject_with_currentAddr.datelastseen);
		SELF.Borrower.CurrentAddress.YearsAtAddress:= (STRING)Years_at_Address_current;
		SELF.Borrower.CurrentAddress.VerificationOfOccupancyScore:= (STRING)subject_with_currentAddr.VerificationOfOccupancyScore;
		SELF.Borrower.CurrentAddress.InferredOwnershipTypeIndex:= (STRING)subject_with_currentAddr.InferredOwnershipTypeIndex;
		SELF.Borrower.CurrentAddress.OwnOrRent:= subject_with_currentAddr.OwnOrRent;
		SELF.Borrower.CurrentAddress.VerificationOfOccupancyAsOfDate:= iesp.ECL2ESP.toDatestring8(subject_with_currentAddr.AsOfDate);
		prior_address:= ROW(xform_t_address(subject_with_priorAddr.Address));
		SELF.Borrower.PriorAddress:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, prior_address, ROW([],iesp.share.t_Address));
		SELF.Borrower.PriorAddress.VerificationOfOccupancyScore:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, (STRING)subject_with_priorAddr.VerificationOfOccupancyScore, '');
		SELF.Borrower.PriorAddress.InferredOwnershipTypeIndex:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, (STRING)subject_with_priorAddr.InferredOwnershipTypeIndex, '');
		SELF.Borrower.PriorAddress.OwnOrRent:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, subject_with_priorAddr.OwnOrRent, '');	
		Years_at_Address_prior:= STD.Date.YearsBetween(subject_with_priorAddr.datefirstseen, subject_with_priorAddr.datelastseen);
		SELF.Borrower.PriorAddress.VerificationOfOccupancyAsOfDate:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, iesp.ECL2ESP.toDatestring8(subject_with_priorAddr.AsOfDate), ROW([], iesp.share.t_Date));
		SELF.Borrower.PriorAddress.YearsAtAddress:= If(Years_at_Address_current< $.Constants.YEARS_AT_CURRENT_ADDRESS_THRESHOLD, (STRING)Years_at_Address_prior, '');
		SELF.OwnedProperties:= owned_prop_addr;
		SELF.SubjectProperty.Address:= ROW(xform_t_address(input_prop_addr[1]));;
		SELF.SubjectProperty.NoOfUnits:= input_prop_assess_info.NoOfUnits;
		SELF.SubjectProperty.PropertyType:= input_prop_assess_info.SubjectPropertyType;
		SELF.SubjectProperty.LegalDescription:= input_prop_assess_info.LegalDescription;
		SELF.SubjectProperty.YearBuilt:= input_prop_assess_info.YearBuilt;
		SELF.SubjectProperty.RealEstateTaxesCurrentProperty:= input_prop_assess_info.RealEstateTaxesCurrentProperty;		
		SELF.SubjectProperty.BorrowerVestingDescription:= input_prop_deed_info.BorrowerVestingDesc;
		SELF.SubjectProperty.BuyerVestingDescription:= input_prop_deed_info.BuyerVestingDesc;
		SELF.SubjectProperty.YearLotAcquired:= input_prop_deed_info.YearLotAcquired;
		SELF.SubjectProperty.OriginalCost:= input_prop_deed_info.OriginalCost;		
		SELF:= [];
	END;
	
END;