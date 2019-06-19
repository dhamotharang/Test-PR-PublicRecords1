// this attribute is only for beta testing for 5.2.  
// when we put this into the real shell, the macro call to pii_stability can probably replace the DIDAppend macro in iid_getDIDprepOutput to be most efficient

import didville, risk_indicators;

EXPORT Boca_Shell_PII_Stability(GROUPED DATASET (risk_indicators.Layout_Boca_Shell) clam) := function

weights_input := project(clam, 
	transform(DidVille.Layout_Did_InBatch, 
		// not sure if this impacts anything, but when comparing to test in august, there were a few fields like addr_suffix and zip4 that didn't get mapped
		// self := left.shell_input;
		// self := left; 
		
		// don't map all of the fields, just the ones that were used in the test in August to try to re-create the same answer
		self.seq := left.seq;
		self.fname := left.shell_input.fname;
		self.mname := left.shell_input.mname;
		self.lname := left.shell_input.lname;
		self.prim_range := left.shell_input.prim_range;
		self.prim_name := left.shell_input.prim_name;
		self.sec_range := left.shell_input.sec_range;
		self.p_city_name := left.shell_input.p_city_name;
		self.st := left.shell_input.st;
		self.z5 := left.shell_input.z5;
		self.ssn := left.shell_input.ssn;
		self.dob := left.shell_input.dob;
		self.phone10 := left.shell_input.phone10;
		
		self := []));

pii_weights := didville.PII_STABILITY_WEIGHTS.PII_STABILITY_WEIGHTS(ungroup(weights_input));
// output(pii_weights,,'~dvstemp::out::pii_stability_weights_' + thorlib.wuid());


pii_stats := table(pii_weights, {
seq := reference, // seq number
link_candidate_cnt	:= count(group),  // did on file for that input
link_wgt_dob_npos_cnt	:= count(group, 	dobweight > 0	),
link_wgt_fname_npos_cnt	:= count(group, 	fnameweight > 0	),
link_wgt_lname_npos_cnt	:= count(group, 	lnameweight > 0	),
link_wgt_phone_npos_cnt	:= count(group, 	phoneweight > 0	),
link_wgt_prim_name_npos_cnt	:= count(group, 	prim_nameweight > 0	),
link_wgt_prim_range_npos_cnt	:= count(group, 	prim_rangeweight > 0	),
link_wgt_ssn4_npos_cnt	:= count(group, 	ssn4weight > 0	),
link_wgt_ssn5_npos_cnt	:= count(group, 	ssn5weight > 0	),

link_wgt_dob_nneg_cnt	:= count(group, 	dobweight < 0	),
link_wgt_fname_nneg_cnt	:= count(group, 	fnameweight < 0	),
link_wgt_lname_nneg_cnt	:= count(group, 	lnameweight < 0	),
link_wgt_phone_nneg_cnt	:= count(group, 	phoneweight < 0	),
link_wgt_prim_name_nneg_cnt	:= count(group, 	prim_nameweight < 0	),
link_wgt_prim_range_nneg_cnt	:= count(group, 	prim_rangeweight < 0	),
link_wgt_ssn4_nneg_cnt	:= count(group, 	ssn4weight < 0	),
link_wgt_ssn5_nneg_cnt	:= count(group, 	ssn5weight < 0	),

link_wgt_dob_nzero_cnt	:= count(group, 	dobweight = 0	),
link_wgt_fname_nzero_cnt	:= count(group, 	fnameweight = 0	),
link_wgt_lname_nzero_cnt	:= count(group, 	lnameweight = 0	),
link_wgt_phone_nzero_cnt	:= count(group, 	phoneweight = 0	),
link_wgt_prim_name_nzero_cnt	:= count(group, 	prim_nameweight = 0	),
link_wgt_prim_range_nzero_cnt	:= count(group, 	prim_rangeweight = 0	),
link_wgt_ssn4_nzero_cnt	:= count(group, 	ssn4weight = 0	),
link_wgt_ssn5_nzero_cnt	:= count(group, 	ssn5weight = 0	),

link_max_dobweight	:= max(group, dobweight);
link_max_fnameweight	:= max(group, fnameweight);
link_max_lnameweight	:= max(group, lnameweight);
link_max_phoneweight	:= max(group, phoneweight);
link_max_prim_nameweight	:= max(group, prim_nameweight);
link_max_prim_rangeweight	:= max(group, prim_rangeweight);
link_max_ssn4weight	:= max(group, ssn4weight);
link_max_ssn5weight	:= max(group, ssn5weight);

link_min_dobweight	:= min(group, dobweight);
link_min_fnameweight	:= min(group, fnameweight);
link_min_lnameweight	:= min(group, lnameweight);
link_min_phoneweight	:= min(group, phoneweight);
link_min_prim_nameweight	:= min(group, prim_nameweight);
link_min_prim_rangeweight	:= min(group, prim_rangeweight);
link_min_ssn4weight	:= min(group, ssn4weight);
link_min_ssn5weight	:= min(group, ssn5weight);
// link_max_weight_element := "One of [""dob"",""fname"",""lname"",""phone"",""prim_name"",""prim_range"",""ssn4"",""ssn5""]
// with the corresponding highest weight. In case of tie choose first in array order."	),

// link_min_weight_element	:= count(group, 	"One of [""dob"",""fname"",""lname"",""phone"",""prim_name"",""prim_range"",""ssn4"",""ssn5""]
// with the corresponding lowest weight. In case of tie choose first in array order."	),


}, reference);


layout_temp := record
	unsigned seq;
	Risk_Indicators.Layouts.layout_pii_stability;
end;

pii_stability_final := project(pii_stats, transform(layout_temp,
	self.link_max_weight_element := map(
		left.link_max_dobweight >=	left.link_max_fnameweight and
		left.link_max_dobweight >=	left.link_max_lnameweight and
		left.link_max_dobweight >=	left.link_max_phoneweight and
		left.link_max_dobweight >=	left.link_max_prim_nameweight and
		left.link_max_dobweight >=	left.link_max_prim_rangeweight and
		left.link_max_dobweight >=	left.link_max_ssn4weight and
		left.link_max_dobweight >=	left.link_max_ssn5weight => 'dob',
		
		left.link_max_fnameweight >=	left.link_max_dobweight and
		left.link_max_fnameweight >=	left.link_max_lnameweight and
		left.link_max_fnameweight >=	left.link_max_phoneweight and
		left.link_max_fnameweight >=	left.link_max_prim_nameweight and
		left.link_max_fnameweight >=	left.link_max_prim_rangeweight and
		left.link_max_fnameweight >=	left.link_max_ssn4weight and
		left.link_max_fnameweight >=	left.link_max_ssn5weight => 'fname',
		
		left.link_max_lnameweight >=	left.link_max_dobweight and
		left.link_max_lnameweight >=	left.link_max_fnameweight and
		left.link_max_lnameweight >=	left.link_max_phoneweight and
		left.link_max_lnameweight >=	left.link_max_prim_nameweight and
		left.link_max_lnameweight >=	left.link_max_prim_rangeweight and
		left.link_max_lnameweight >=	left.link_max_ssn4weight and
		left.link_max_lnameweight >=	left.link_max_ssn5weight => 'lname',
		
		left.link_max_phoneweight >=	left.link_max_dobweight and
		left.link_max_phoneweight >=	left.link_max_fnameweight and
		left.link_max_phoneweight >=	left.link_max_lnameweight and
		left.link_max_phoneweight >=	left.link_max_prim_nameweight and
		left.link_max_phoneweight >=	left.link_max_prim_rangeweight and
		left.link_max_phoneweight >=	left.link_max_ssn4weight and
		left.link_max_phoneweight >=	left.link_max_ssn5weight => 'phone',
		
		left.link_max_prim_nameweight >=	left.link_max_dobweight and
		left.link_max_prim_nameweight >=	left.link_max_fnameweight and
		left.link_max_prim_nameweight >=	left.link_max_lnameweight and
		left.link_max_prim_nameweight >=	left.link_max_phoneweight and
		left.link_max_prim_nameweight >=	left.link_max_prim_rangeweight and
		left.link_max_prim_nameweight >=	left.link_max_ssn4weight and
		left.link_max_prim_nameweight >=	left.link_max_ssn5weight => 'prim_name',
		
		left.link_max_prim_rangeweight >=	left.link_max_dobweight and
		left.link_max_prim_rangeweight >=	left.link_max_fnameweight and
		left.link_max_prim_rangeweight >=	left.link_max_lnameweight and
		left.link_max_prim_rangeweight >=	left.link_max_phoneweight and
		left.link_max_prim_rangeweight >=	left.link_max_prim_nameweight and
		left.link_max_prim_rangeweight >=	left.link_max_ssn4weight and
		left.link_max_prim_rangeweight >=	left.link_max_ssn5weight => 'prim_range',

		left.link_max_ssn4weight >=	left.link_max_dobweight and
		left.link_max_ssn4weight >=	left.link_max_fnameweight and
		left.link_max_ssn4weight >=	left.link_max_lnameweight and
		left.link_max_ssn4weight >=	left.link_max_phoneweight and
		left.link_max_ssn4weight >=	left.link_max_prim_nameweight and
		left.link_max_ssn4weight >=	left.link_max_prim_rangeweight and
		left.link_max_ssn4weight >=	left.link_max_ssn5weight => 'ssn4',
		
		'ssn5'  // only case left
);
	self.link_min_weight_element := 
	map(
		left.link_min_dobweight <=	left.link_min_fnameweight and
		left.link_min_dobweight <=	left.link_min_lnameweight and
		left.link_min_dobweight <=	left.link_min_phoneweight and
		left.link_min_dobweight <=	left.link_min_prim_nameweight and
		left.link_min_dobweight <=	left.link_min_prim_rangeweight and
		left.link_min_dobweight <=	left.link_min_ssn4weight and
		left.link_min_dobweight <=	left.link_min_ssn5weight => 'dob',
		
		left.link_min_fnameweight <=	left.link_min_dobweight and
		left.link_min_fnameweight <=	left.link_min_lnameweight and
		left.link_min_fnameweight <=	left.link_min_phoneweight and
		left.link_min_fnameweight <=	left.link_min_prim_nameweight and
		left.link_min_fnameweight <=	left.link_min_prim_rangeweight and
		left.link_min_fnameweight <=	left.link_min_ssn4weight and
		left.link_min_fnameweight <=	left.link_min_ssn5weight => 'fname',
		
		left.link_min_lnameweight <=	left.link_min_dobweight and
		left.link_min_lnameweight <=	left.link_min_fnameweight and
		left.link_min_lnameweight <=	left.link_min_phoneweight and
		left.link_min_lnameweight <=	left.link_min_prim_nameweight and
		left.link_min_lnameweight <=	left.link_min_prim_rangeweight and
		left.link_min_lnameweight <=	left.link_min_ssn4weight and
		left.link_min_lnameweight <=	left.link_min_ssn5weight => 'lname',
		
		left.link_min_phoneweight <=	left.link_min_dobweight and
		left.link_min_phoneweight <=	left.link_min_fnameweight and
		left.link_min_phoneweight <=	left.link_min_lnameweight and
		left.link_min_phoneweight <=	left.link_min_prim_nameweight and
		left.link_min_phoneweight <=	left.link_min_prim_rangeweight and
		left.link_min_phoneweight <=	left.link_min_ssn4weight and
		left.link_min_phoneweight <=	left.link_min_ssn5weight => 'phone',
		
		left.link_min_prim_nameweight <=	left.link_min_dobweight and
		left.link_min_prim_nameweight <=	left.link_min_fnameweight and
		left.link_min_prim_nameweight <=	left.link_min_lnameweight and
		left.link_min_prim_nameweight <=	left.link_min_phoneweight and
		left.link_min_prim_nameweight <=	left.link_min_prim_rangeweight and
		left.link_min_prim_nameweight <=	left.link_min_ssn4weight and
		left.link_min_prim_nameweight <=	left.link_min_ssn5weight => 'prim_name',
		
		left.link_min_prim_rangeweight <=	left.link_min_dobweight and
		left.link_min_prim_rangeweight <=	left.link_min_fnameweight and
		left.link_min_prim_rangeweight <=	left.link_min_lnameweight and
		left.link_min_prim_rangeweight <=	left.link_min_phoneweight and
		left.link_min_prim_rangeweight <=	left.link_min_prim_nameweight and
		left.link_min_prim_rangeweight <=	left.link_min_ssn4weight and
		left.link_min_prim_rangeweight <=	left.link_min_ssn5weight => 'prim_range',

		left.link_min_ssn4weight <=	left.link_min_dobweight and
		left.link_min_ssn4weight <=	left.link_min_fnameweight and
		left.link_min_ssn4weight <=	left.link_min_lnameweight and
		left.link_min_ssn4weight <=	left.link_min_phoneweight and
		left.link_min_ssn4weight <=	left.link_min_prim_nameweight and
		left.link_min_ssn4weight <=	left.link_min_prim_rangeweight and
		left.link_min_ssn4weight <=	left.link_min_ssn5weight => 'ssn4',
		
		'ssn5'  // only case left
	);

	self := left));
	
	j := join(clam, pii_stability_final, left.seq=right.seq, 
		transform(risk_indicators.Layout_Boca_Shell, 
			self.pii_stability := right,
			self := left),
		left outer);
	
// output(weights_input, named('weights_input'));
// output(pii_weights, named('pii_weights'));
// output(pii_stats, named('pii_stats'));
// output(pii_stability_final, named('pii_stability_final'));

	return group(j, seq);
	
end;

