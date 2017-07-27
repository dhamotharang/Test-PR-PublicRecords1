/*2013-09-20T19:01:05Z (Brenton Pahl)
Translating the QH and WH sources to EQ so that our data restriction filters work as expected.  Per Bug 88987.
*/
import doxie, header, header_quick, mdr, drivers, risk_indicators;

d := record
	unsigned6 did := 0;
end;

export getHeaderByDid(dataset(d) input, unsigned1 dppa, unsigned1 glb, boolean ln_branded, 
										string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction) := function

glb_ok := glb > 0 and glb < 8 or glb=11 or glb=12;
dppa_ok := dppa > 0 and dppa < 8;

layout_outx := RECORD
	doxie.key_header;
END;

layout_outx getHeader(input le,doxie.key_header rt) := TRANSFORM
	SELF := rt;
end;

eqfs := join(input, doxie.key_header, 
			LEFT.did<>0 AND keyed(LEFT.did = RIGHT.s_did) AND
			// check permissions	
			(~mdr.Source_is_Utility(RIGHT.src) AND// rm Utility from NAS
			right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, FALSE/*IsFCRA*/) AND
			(header.isPreGLB(RIGHT) OR glb_ok)
							AND
							(~mdr.Source_is_DPPA(RIGHT.src) OR
								(dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa,RIGHT.src))) AND
								~risk_indicators.iid_constants.filtered_source(right.src, right.st)						
							),
		getHeader(LEFT,RIGHT), atmost(keyed(LEFT.did = RIGHT.s_did), riskwise.max_atmost), keep(500), LEFT OUTER);
		
		


// append quick header to regular header.
layout_outx getQuickHeader(input le, header_quick.key_DID rt) := TRANSFORM
	SELF.src := IF(rt.src in ['QH', 'WH'], MDR.sourceTools.src_Equifax, rt.src);
	SELF := rt;
	SELF := [];
end;

quick_head := join(input, header_quick.key_DID, 
			LEFT.did<>0 AND keyed(LEFT.did = RIGHT.did) AND
			// check permissions	
			(~mdr.Source_is_Utility(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src)) AND// rm Utility from NAS
			IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, FALSE/*IsFCRA*/) AND
			(header.isPreGLB(RIGHT) OR glb_ok)
							AND
							(~mdr.Source_is_DPPA(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src)) OR
								(dppa_ok AND drivers.state_dppa_ok(header.translateSource(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src)),dppa,IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src)))) AND
								~risk_indicators.iid_constants.filtered_source(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src), right.st)						
							),
		getQuickHeader(LEFT,RIGHT), atmost(keyed(LEFT.did = RIGHT.did), riskwise.max_atmost), keep(500), LEFT OUTER);


all_head := eqfs + quick_head;



return all_head;

end;