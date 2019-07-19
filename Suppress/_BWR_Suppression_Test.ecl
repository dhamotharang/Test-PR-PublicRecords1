// -----------------------------------------------------------------
// -- CCPA: MAC suppress source (CCPA) test
// -----------------------------------------------------------------

#STORED('GLBPurpose', 3)
#STORED('DPPAPurpose', 1)
#STORED('LexIdSourceOptout', 2) // <- to enable test suppression

import AutoStandardI, doxie;

g_mod := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(g_mod); // <-- GLB, DDPA, etc.

d_in := dataset([
	 {1, 364866, 23361, 0, true},
	 {1, 364866, 1000, 0, false}
	 // {1, 218, 12, 0, true},
	 // {2, 218, 15, 0, false},
	 // {3, 10597, 22, 0, true},
	 // {4, 10597, 30, 0, false}
	], {integer seq; unsigned6 did; unsigned4 global_sid; unsigned4 record_sid; boolean should_suppress;});

// call macro to suppress records
d_clean := Suppress.MAC_SuppressSource(d_in, mod_access);
output(d_clean, named('suppressed'));

// or call macro to flag suppressed
d_clean_flagged := Suppress.MAC_FlagSuppressedSource(d_in, mod_access);
output(d_clean_flagged, named('suppress_flagged'));

l_suppressed := record
	d_in;
	boolean is_suppressed := false;
end;

d_in_wsup := project(d_in, transform(l_suppressed, self := left;));

// or call macro to flag suppressed (2)
d_clean_flagged_wsupp := Suppress.MAC_FlagSuppressedSource(d_in_wsup, mod_access, did, global_sid);
output(d_clean_flagged_wsupp, named('d_clean_flagged_wsupp'));

// -----------------------------------------------------------------
// -- CCPA: Exemption bit test
// -----------------------------------------------------------------

// exempt for glb 7 and dppa 2: 0000 0000 0000 0000 0000 0000 0100 0000 => 0x000040
unsigned8 exempt_GLB7 := 0x00000040; 
// exempt for glb 7: 1000 0000 0000 0000 0000 0000 0100 0000 => 0x80000040
unsigned8 exempt_GLB7_TEST := 0x80000040; 
// exempt for glb 7 and dppa 2: 0000 0000 0000 0100 0000 0000 0100 0000 => 0x040040
unsigned8 exempt_GLB7_DPPA2 := 0x00002040; 
unsigned8 exempt_GLB7_DPPA2_TEST := 0x80002040; 

din := dataset([
	 {1, 1, 2, 1, exempt_GLB7, 'exempt for glb 7 ', true}
	,{2, 7, 0, 1, exempt_GLB7, 'exempt for glb 7', false}
	,{3, 1, 2, 1, exempt_GLB7_DPPA2, 'exempt for glb 7 and dppa 2', false}
	,{4, 7, 2, 1, exempt_GLB7_DPPA2, 'exempt for glb 7 and dppa 2', false}
	,{5, 7, 1, 1, exempt_GLB7_DPPA2, 'exempt for glb 7 and dppa 2', false}
	,{6, 4, 4, 1, exempt_GLB7_DPPA2, 'exempt for glb 7 and dppa 2', true}
	,{7, 2, 3, 1, exempt_GLB7_DPPA2, 'exempt for glb 7 and dppa 2', true}
	,{8, 1, 2, 2, exempt_GLB7_TEST, 'TEST exempt for glb 7', true}
	,{9, 7, 0, 2, exempt_GLB7_TEST, 'TEST exempt for glb 7', false}
	,{10, 1, 2, 1, exempt_GLB7_TEST, 'TEST exempt for glb 7', false}
	,{11, 7, 0, 1, exempt_GLB7_TEST, 'TEST exempt for glb 7', false}
	,{12, 1, 2, 2, exempt_GLB7, 'exempt for glb 7 ', true}
	,{13, 7, 0, 2, exempt_GLB7, 'exempt for glb 7', false}
	], {integer seq; integer glb; integer dppa; integer lex_id_source_optout; unsigned exemptions; string desc; boolean expect_suppress; boolean suppress := false;});

checkSuppression(unsigned exemptions, integer in_glb, integer in_dppa, integer in_lexid_source_optout) := 
	 (~Suppress.optout_exemption.is_test(exemptions) OR in_lexid_source_optout = 2) AND
	(exemptions &  (suppress.optout_exemption.bit_glb(in_glb) | suppress.optout_exemption.bit_dppa(in_dppa))) = 0;

dout := project(din, transform(recordof(din),
	self.seq := COUNTER;
	self.suppress := checkSuppression(left.exemptions, left.glb, left.dppa, left.lex_id_source_optout);
	self := left;
	));

dOut;


