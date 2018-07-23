EXPORT mac_testHRIAddress (infile, addr_field, outfile, isFCRA) := MACRO

IMPORT Risk_Indicators, ut;

#uniquename(tester)
infile %tester% (infile le, Risk_Indicators.Key_HRI_Address_To_Sic ri) := TRANSFORM
	SELF.Address_Verification.addr_field.HR_Address := ri.sic_code<>'';
	SELF := le;
END;

#uniquename(tester_fcra)
infile %tester_FCRA% (infile le, Risk_Indicators.Key_HRI_Address_To_Sic_filtered ri) := TRANSFORM
	SELF.Address_Verification.addr_field.HR_Address := ri.sic_code<>'';
	SELF := le;
END;

#uniquename(outfile_roxie)
%outfile_roxie% := if (isFCRA, 
               JOIN (infile, risk_indicators.Key_HRI_Address_To_Sic_filtered_FCRA,
                     KEYED(LEFT.Address_Verification.addr_field.zip5=RIGHT.z5) AND
                     KEYED(LEFT.Address_Verification.addr_field.prim_name=RIGHT.prim_name) AND
                     KEYED(LEFT.Address_Verification.addr_field.addr_suffix=RIGHT.suffix) AND
                     KEYED(LEFT.Address_Verification.addr_field.predir=RIGHT.predir) AND
                     KEYED(LEFT.Address_Verification.addr_field.postdir=RIGHT.postdir) AND
                     KEYED(LEFT.Address_Verification.addr_field.prim_range=RIGHT.prim_range) AND
                     (LEFT.Address_Verification.addr_field.sec_range=RIGHT.sec_range) and 
										 // check date
											right.dt_first_seen <= left.historydate,
                     %tester_FCRA%(LEFT,RIGHT), LEFT OUTER, ATMOST(RiskWise.max_atmost), KEEP(1)),
               JOIN (infile, risk_indicators.Key_HRI_Address_to_Sic,
                     KEYED(LEFT.Address_Verification.addr_field.zip5=RIGHT.z5) AND
                     KEYED(LEFT.Address_Verification.addr_field.prim_name=RIGHT.prim_name) AND
                     KEYED(LEFT.Address_Verification.addr_field.addr_suffix=RIGHT.suffix) AND
                     KEYED(LEFT.Address_Verification.addr_field.predir=RIGHT.predir) AND
                     KEYED(LEFT.Address_Verification.addr_field.postdir=RIGHT.postdir) AND
                     KEYED(LEFT.Address_Verification.addr_field.prim_range=RIGHT.prim_range) AND
                     (LEFT.Address_Verification.addr_field.sec_range=RIGHT.sec_range) and 
										 // check date
										 right.dt_first_seen <= left.historydate,
                     %tester%(LEFT,RIGHT), LEFT OUTER, ATMOST(RiskWise.max_atmost), KEEP(1)));

#uniquename(outfile_thor)
%outfile_thor% := if (isFCRA, 
               JOIN (distribute(infile(Address_Verification.addr_field.zip5 <> '' AND Address_Verification.addr_field.prim_name <> ''), hash64(Address_Verification.addr_field.zip5,Address_Verification.addr_field.prim_name,Address_Verification.addr_field.prim_range)), 
										 distribute(pull(risk_indicators.Key_HRI_Address_To_Sic_filtered_FCRA), hash64(z5, prim_name, prim_range)),
                     (LEFT.Address_Verification.addr_field.zip5=RIGHT.z5) AND
                     (LEFT.Address_Verification.addr_field.prim_name=RIGHT.prim_name) AND
                     (LEFT.Address_Verification.addr_field.addr_suffix=RIGHT.suffix) AND
                     (LEFT.Address_Verification.addr_field.predir=RIGHT.predir) AND
                     (LEFT.Address_Verification.addr_field.postdir=RIGHT.postdir) AND
                     (LEFT.Address_Verification.addr_field.prim_range=RIGHT.prim_range) AND
                     (LEFT.Address_Verification.addr_field.sec_range=RIGHT.sec_range) and 
										 // check date
											right.dt_first_seen <= left.historydate,
                     %tester_FCRA%(LEFT,RIGHT), LEFT OUTER, KEEP(1), LOCAL) + 
										 infile(Address_Verification.addr_field.zip5 = '' OR Address_Verification.addr_field.prim_name = ''),
               JOIN (distribute(infile(Address_Verification.addr_field.zip5 <> '' AND Address_Verification.addr_field.prim_name <> ''), hash64(Address_Verification.addr_field.zip5,Address_Verification.addr_field.prim_name,Address_Verification.addr_field.prim_range)), 
										 distribute(pull(risk_indicators.Key_HRI_Address_to_Sic), hash64(z5, prim_name, prim_range)),
                     (LEFT.Address_Verification.addr_field.zip5=RIGHT.z5) AND
                     (LEFT.Address_Verification.addr_field.prim_name=RIGHT.prim_name) AND
                     (LEFT.Address_Verification.addr_field.addr_suffix=RIGHT.suffix) AND
                     (LEFT.Address_Verification.addr_field.predir=RIGHT.predir) AND
                     (LEFT.Address_Verification.addr_field.postdir=RIGHT.postdir) AND
                     (LEFT.Address_Verification.addr_field.prim_range=RIGHT.prim_range) AND
                     (LEFT.Address_Verification.addr_field.sec_range=RIGHT.sec_range) and 
										 // check date
										 right.dt_first_seen <= left.historydate,
                     %tester%(LEFT,RIGHT), LEFT OUTER, KEEP(1), LOCAL) + 
										 infile(Address_Verification.addr_field.zip5 = '' OR Address_Verification.addr_field.prim_name = ''));


#IF(onThor)
	outfile := group(%outfile_thor%, seq);
#ELSE
	outfile := %outfile_roxie%;
#END

ENDMACRO;