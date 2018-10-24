IMPORT $, address, iesp, Doxie, progressive_phone, ut, LN_PropertyV2_Services, STD;

date6todate8(date):= (UNSIGNED4)ut.date6_to_date8(date);

EXPORT Transforms := MODULE
		
	EXPORT $.Layouts.borrower_layout xform_bestDmap(Doxie.layout_best L):= TRANSFORM
		SELF.Did:= L.did;
		SELF.Name:= iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix, '', L.fname+L.mname+L.lname+L.name_suffix);
		SELF.SSN:= L.SSN;
		SELF.DOB:= L.dob;
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
		SELF.dob                  := (STRING)L.dob;
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
	
	EXPORT $.Layouts.addr_layout xform_subjectToaddrLayout($.Layouts.dmap_Layout L):= TRANSFORM
		SELF.is_input_property:= FALSE;
		SELF:= L.Address;
		SELF:= [];
	END;
	
END;