IMPORT Address, Residency_Services, VerificationOfOccupancy;

EXPORT fn_getVOO(DATASET(Residency_Services.Layouts.IntermediateData) ds_input, 
                 Residency_Services.IParam.BatchParams mod_params_in) := FUNCTION

	VerificationOfOccupancy.Layouts.Layout_VOOIn tf_input (ds_input l) := TRANSFORM
		SELF.acctno 				:= l.acctno;
		SELF.seq 						:= l.seq;
		SELF.name_first 		:= l.name_first;
		SELF.name_middle 		:= l.name_middle;
		SELF.name_last 			:= l.name_last;
		SELF.ssn						:= (STRING9)l.ssn;
		SELF.street_addr    := Address.Addr1FromComponents(l.prim_range, l.predir,	l.prim_name, 
		                                                   l.addr_suffix, l.postdir, l.unit_desig, 
																										   l.sec_range);
		SELF.streetnumber        :=	l.prim_range ;
		SELF.streetpredirection	 := l.predir     ;
		SELF.streetname	         := l.prim_name  ;
		SELF.streetsuffix	       := l.addr_suffix;
		SELF.streetpostdirection :=	l.postdir    ;
		SELF.unitdesignation	   :=  l.unit_desig ;
		SELF.unitnumber	         := l.sec_range  ;
		SELF.City_name	         := l.p_city_name;
		SELF.st					         := l.st;
		SELF.z5					         := l.z5;
		SELF := [];
	END;
		
	ds_VOO_In := PROJECT(ds_input, tf_input(LEFT));

  // Check a certain input param so the appropriate boolean value isUtility can be passed in below
  BOOLEAN isUtility :=  mod_params_in.isUtility();

	ds_VOO_recs := VerificationOfOccupancy.Search_Function(
	                  ds_VOO_In, 
										mod_params_in.DataRestrictionMask,
										mod_params_in.glb,
										mod_params_in.dppa,
										isUtility,
		                'PARATTRV1', //AttributesVersion
										TRUE,        //IncludeModel
										mod_params_in.DataPermissionMask
	                  //             IncludeReport, use default=FALSE
									  //             PAR_request, use default=FALSE
									).VOOReport;

	Residency_Services.Layouts.IntermediateData tf_output(ds_input le, ds_VOO_recs ri) := TRANSFORM
		SELF.AddressReportingSourceIndex     := ri.attributes.version1.AddressReportingSourceIndex;
		SELF.AddressReportingHistoryIndex    := ri.attributes.version1.AddressReportingHistoryIndex;
		SELF.AddressSearchHistoryIndex       := ri.attributes.version1.AddressSearchHistoryIndex;
		SELF.AddressUtilityHistoryIndex      := ri.attributes.version1.AddressUtilityHistoryIndex;
		SELF.AddressOwnershipHistoryIndex    := ri.attributes.version1.AddressOwnershipHistoryIndex;
		SELF.AddressOwnerMailingAddressIndex := ri.attributes.version1.AddressOwnerMailingAddressIndex;
		SELF.InferredOwnershipTypeIndex      := ri.attributes.version1.InferredOwnershipTypeIndex;
		SELF.OtherOwnedPropertyProximity     := ri.attributes.version1.OtherOwnedPropertyProximity;
		SELF := le
	END;	
	
	ds_VOO_ret := JOIN(ds_input, ds_VOO_recs, 
								           LEFT.acctno = RIGHT.acctno AND
								           LEFT.seq    = RIGHT.seq,
								         tf_output(LEFT, RIGHT), 
								         LEFT OUTER); 

	// OUTPUT(ds_input,    NAMED('ds_input'));
	// OUTPUT(ds_VOO_In,   NAMED('ds_VOO_In'));
	// OUTPUT(ds_VOO_recs, NAMED('ds_VOO_recs'));
	
	RETURN ds_VOO_ret;
	
END;
	