IMPORT BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR;

EXPORT getPropertyByInputs(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

  // This code was moved from Business_Risk_BIP.getProperty to allow these attributes to be calculated when BIP IDs are not assigned.
  // Property data by address
	KAF := LN_PropertyV2.key_addr_fid(false);
	KASF := LN_PropertyV2.key_assessor_fid(FALSE /*isFCRA*/);
	proprec := RECORD
	  Business_Risk_BIP.Layouts.INPUT ;
		string12 fares_id;
		string2 state_code;
		unsigned4 InputAddrLotSize; 
		unsigned4 InputAddrAssessedTotal; 
		unsigned4 InputAddrSqFootage;
	END;

	proprec get_property_by_addr(Shell le, KAF ri) := TRANSFORM
		SELF.fares_id := ri.ln_fares_id;
		SELF := le.CLEAN_INPUT;
		SELF := [];
	END;

	property_by_address := JOIN(Shell, KAF,
						LEFT.clean_input.prim_name<>'' AND
						keyed(LEFT.clean_input.prim_name=RIGHT.prim_name) AND
						keyed(LEFT.clean_input.prim_range=RIGHT.prim_range) AND
						keyed(LEFT.clean_input.zip5=RIGHT.zip) AND
						keyed(LEFT.clean_input.predir=RIGHT.predir) AND
						keyed(LEFT.clean_input.postdir=RIGHT.postdir) AND
						keyed(LEFT.clean_input.addr_suffix=RIGHT.suffix) AND
						keyed(LEFT.clean_input.sec_range=RIGHT.sec_range) and
						keyed(right.source_code_2 = 'P'),
					   get_property_by_addr(LEFT,RIGHT), KEEP(100), LEFT OUTER,
					   ATMOST(
						   keyed(LEFT.clean_input.prim_name=RIGHT.prim_name) AND
						   keyed(LEFT.clean_input.prim_range=RIGHT.prim_range) AND
						   keyed(LEFT.clean_input.zip5=RIGHT.zip) AND
						   keyed(LEFT.clean_input.predir=RIGHT.predir) AND
						   keyed(LEFT.clean_input.postdir=RIGHT.postdir) AND
						   keyed(LEFT.clean_input.addr_suffix=RIGHT.suffix) AND
						   keyed(LEFT.clean_input.sec_range=RIGHT.sec_range) and
						   keyed(right.source_code_2 = 'P'),
						   Business_Risk_BIP.Constants.Limit_Default
					   ));
						 
						 
	proprec get_Assessements(property_by_address le, KASF ri) :=		TRANSFORM			 
					SELF.state_code := ri.state_code;
					SELF.InputAddrLotSize	:= (INTEGER)StringLib.StringFilter(ri.land_square_footage, '0123456789');					 
          SELF.InputAddrSqFootage := (INTEGER)StringLib.StringFilter(ri.Building_Area, '0123456789');	
				  SELF.InputAddrAssessedTotal := (INTEGER)max((INTEGER)ri.assessed_total_value, (INTEGER)ri.market_total_value);	
					SELF := LE;
					SELF := [];
	END;
	
	PropertyAssessments_pre := JOIN(DEDUP(SORT(property_by_address, Seq, Fares_ID), Seq, Fares_ID), KASF, 
															KEYED(LEFT.Fares_ID = RIGHT.LN_Fares_ID) 
															AND (unsigned3)((STRING)right.proc_date)[1..6] <= left.historydate
															AND (unsigned3)right.recording_date[1..6] <= left.historydate,
															get_Assessements(LEFT,RIGHT),
															ATMOST(keyed(LEFT.fares_id=RIGHT.ln_fares_id),Business_Risk_BIP.Constants.Limit_Assessments));

	// Under the most recent definition for source codes that are allowed for Marketing purposes, all Property
	// are ALLOWED with the exception of the following states ['ID','IL','KS','NM','SC','WA', ''] when they are
	// in records whose src type is src_LnPropV2_Lexis_Asrs or src_LnPropV2_Lexis_Deeds_Mtgs (i.e. 'LA','LP').
	PropertyAssessments_src := 
		PROJECT(
			PropertyAssessments_pre,
			TRANSFORM( { RECORDOF(PropertyAssessments_pre), STRING src },
				SELF.src := MDR.SourceTools.fProperty(LEFT.fares_id),
				SELF := LEFT
			)
		);
	
	PropertyAssessments := IF( Options.MarketingMode = 1,
			PropertyAssessments_src(src IN AllowedSourcesSet AND Business_Risk_BIP.Common.isMarketingAllowedProperty(src, state_code)),
			PropertyAssessments_src);
			
	PropertyBusnAssessRolled := ROLLUP(SORT(PropertyAssessments, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(RECORDOF(LEFT),
																				SELF.InputAddrLotSize := MAX(LEFT.InputAddrLotSize, RIGHT.InputAddrLotSize);
																				SELF.InputAddrSqFootage := MAX(LEFT.InputAddrSqFootage, RIGHT.InputAddrSqFootage);
																				SELF.InputAddrAssessedTotal := MAX(LEFT.InputAddrAssessedTotal, RIGHT.InputAddrAssessedTotal);
																				SELF := LEFT));        
                                          
 	withPropertyAssess := JOIN(Shell, PropertyBusnAssessRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                              // In v30 and up, assign -1 to these attributes if address isn't populated.
                                              AddrNotInput_v30 := LEFT.Input.InputCheckBusAddrZip = '0' AND Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30;
																							SELF.Input_Characteristics.InputAddrLotSize := IF(AddrNotInput_v30, '-1', (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InputAddrLotSize, -1, 999999999));
																							SELF.Input_Characteristics.InputAddrAssessedTotal := IF(AddrNotInput_v30, '-1', (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InputAddrAssessedTotal, -1, 999999999));
																							SELF.Input_Characteristics.InputAddrSqFootage := IF(AddrNotInput_v30, '-1', (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InputAddrSqFootage, -1, 999999999));
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);    

  // OUTPUT(CHOOSEN(PropertyAssessments, 100), NAMED('Sample_PropertyAssessments'));
	// OUTPUT(CHOOSEN(PropertyBusnAssessRolled, 100), NAMED('Sample_PropertyBusnAssessRolled'));
	// OUTPUT(CHOOSEN(withPropertyAssess, 100), NAMED('Sample_withPropertyAssess'));
	RETURN withPropertyAssess;
END;