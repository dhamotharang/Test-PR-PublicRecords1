IMPORT BusinessInstantID20_Services, Advo, risk_indicators;

EXPORT fn_CalculateAddressIsCMRA( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_inputClean
                                ) := 
		FUNCTION
	  CleanInputLayoutTemp := RECORD
      BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean;
      STRING1 drop_indicator;
      STRING  baddrtype;
      STRING  sic_code;
      STRING  hriskaddrflag;
      STRING  hrisksic;
    END;
    ds_AdvoKeyAddr1 := Advo.Key_Addr1;
    ds_AddressRisk  := 
      JOIN(
        ds_inputClean, ds_AdvoKeyAddr1,
        KEYED(LEFT.Zip5  = RIGHT.zip) AND
        KEYED(LEFT.prim_range = RIGHT.prim_range) AND
        KEYED(LEFT.prim_name  = RIGHT.prim_name) AND
        KEYED(LEFT.addr_suffix  = RIGHT.addr_suffix) AND
        KEYED(LEFT.predir     = RIGHT.predir) AND
        KEYED(LEFT.postdir  = RIGHT.postdir) AND
        KEYED(LEFT.sec_range  = RIGHT.sec_range), 
        TRANSFORM(CleanInputLayoutTemp,
          SELF.drop_indicator := RIGHT.drop_indicator,
          SELF.baddrtype := RIGHT.address_type, 
          SELF := LEFT,
          SELF := [];
        ), 
				INNER, KEEP(1), PARALLEL, FEW );
    isAddressInADVO := EXISTS(ds_AddressRisk(drop_indicator='C'));                        
    CleanInputLayoutTemp hrtrans(CleanInputLayoutTemp l, risk_indicators.key_HRI_Address_To_SIC r) := transform
        self.hriskaddrflag := MAP( l.baddrtype = 'M'                           => '3',
                                   l.prim_name='' OR l.Zip5='' => '5',
                                   r.sic_code=''                               => '0',// need a 1,2 here yet	 
                                   r.sic_code<>''                              => '4',
                                                                                  '');
        self.hrisksic := r.sic_code;
        self := l;
      END;
    ds_SIC_Codes := join(ds_AddressRisk, 
			   risk_indicators.key_HRI_Address_To_SIC,
				keyed(left.Zip5=right.z5) and 
				keyed(left.prim_name=right.prim_name) and 
				keyed(left.addr_suffix=right.suffix) and 
				keyed(left.predir=right.predir) and 
				keyed(left.postdir=right.postdir) and 
				keyed(left.prim_range=right.prim_range) and
				keyed(left.sec_range=right.sec_range) and 
        right.dt_first_seen < left.historydate,
			   hrtrans(left,right),
			   left outer, atmost(100));
    isSICinSetCRMA := IF(
                      (ds_SIC_Codes[1].hrisksic IN Risk_Indicators.iid_constants.setCRMA)
                      , TRUE, FALSE);
    AddressRisk :=  
			PROJECT(
				ds_inputClean,
				TRANSFORM( BusinessInstantID20_Services.Layouts.BusinessAddressRiskLayout,
					SELF.AddressIsCMRA    := (boolean)isAddressInADVO OR (boolean)isSICinSetCRMA,
          SELF := LEFT,
          SELF := []
				)
			);
    
    // DEBUGs...:			
    // OUTPUT(ds_inputClean, named('_ds_inputClean') );
    // OUTPUT(COUNT(ds_AddressRisk(drop_indicator='C')), named('_dropISc') );
    // OUTPUT(ds_SIC_Codes[1].hrisksic, named('_hrisksic') );
    // OUTPUT(ds_AddressRisk, named('_ds_AddressRisk') );
    RETURN AddressRisk;
  END;