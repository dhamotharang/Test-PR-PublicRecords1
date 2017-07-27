//this attribute uses the logic as in salt20.MAC_External_AddPcnt
//to convert individual weights returned by ADL2 to score_any_ fields used in did service

export MAC_Convert_Score_Any(infile, outfile, LMaxScores = 'didville.MaxScores.MMax', need_score_any_value = false) := macro
	
//step1: merge seperate wirght into ssn, addr, dob(phone weight is ready)	
infile_ext_rec := record
	infile;
	unsigned3 ssn_weight;
	unsigned3 addr_weight;
	unsigned3 dob_weight;
	unsigned3 max_ssn_weight;
	unsigned3 max_addr_weight;
	unsigned3 max_dob_weight;
	unsigned3 max_phone_weight;
	real ssn_chance;
	real addr_chance;
	real dob_chance;
	real phone_chance;
	unsigned2 score_any_ssn;
	unsigned2 score_any_addr;
	unsigned2 score_any_dob;
	unsigned2 score_any_phn;
end;
	
infile_ext_rec combine_weight(infile l) := transform
  self.ssn_weight := IF(l.ssn5weight <0, 0, l.ssn5weight) + 
											IF(l.ssn4weight < 0, 0, l.ssn4weight);
	self.addr_weight := IF(l.prim_rangeweight < 0, 0, l.prim_rangeweight) + 
											IF(l.prim_nameweight < 0, 0, l.prim_nameweight) + 
											IF(l.sec_rangeweight < 0, 0, l.sec_rangeweight) + 
											IF(l.cityweight < 0, 0, l.cityweight) + 
											IF(l.stweight < 0, 0, l.stweight) + 
											IF(l.zipweight < 0, 0, l.zipweight)/* + zip4weight*/;
	self.dob_weight := IF(l.dobweight_year < 0, 0, l.dobweight_year) + 
										IF(l.dobweight_month < 0, 0, l.dobweight_month) + 
										IF(l.dobweight_day < 0, 0, l.dobweight_day);
	self := l; 
	self := [];
end;	

f_cmb_weight := project(infile, combine_weight(left));

//step2: rollup weights
reference_weight_rec := record
	f_cmb_weight.reference;
	f_cmb_weight.ssn_weight;
	f_cmb_weight.addr_weight;
	f_cmb_weight.dob_weight;
	f_cmb_weight.PHONEWeight;
end;
	
reference_weight_rec roll_weight(reference_weight_rec l, reference_weight_rec r) := transform
	self.reference := l.reference;
	self.ssn_weight := if(l.ssn_weight < r.ssn_weight, r.ssn_weight, l.ssn_weight);
	self.addr_weight := if(l.addr_weight < r.addr_weight, r.addr_weight, l.addr_weight);
	self.dob_weight := if(l.dob_weight < r.dob_weight, r.dob_weight, l.dob_weight);
	self.PHONEWeight := if(l.PHONEWeight < r.PHONEWeight, r.PHONEWeight, l.PHONEWeight);
end;	
	
f_refrence_weight := rollup(project(f_cmb_weight, reference_weight_rec), 
                            left.reference = right.reference,
														roll_weight(left, right));	

//step3: compute chances	
infile_ext_rec get_max_weight(f_cmb_weight l, f_refrence_weight r) := transform
	self.max_ssn_weight := r.ssn_weight;
	self.max_addr_weight := r.addr_weight;
	self.max_dob_weight := r.dob_weight;
	self.max_phone_weight := r.PHONEWeight;
	self.ssn_chance := 1.0/power(2,r.ssn_weight-l.ssn_weight);
	self.addr_chance := 1.0/power(2,r.addr_weight - l.addr_weight);
	self.dob_chance := 1.0/power(2,r.dob_weight - l.dob_weight);
	self.phone_chance := 1.0/power(2,r.PHONEWeight - l.PHONEWeight);
	self := l;
end;	
	
f_convert_ready := join(f_cmb_weight, f_refrence_weight,
                       left.reference = right.reference,
											 get_max_weight(left, right));	

//step4: compute total chances	
reference_chance_rec := record
	f_convert_ready.reference;
	f_convert_ready.ssn_chance;
	f_convert_ready.addr_chance;
	f_convert_ready.dob_chance;
	f_convert_ready.phone_chance;
end;

reference_chance_rec roll_chance(reference_chance_rec l, reference_chance_rec r) := transform
	self.reference := l.reference;
	self.ssn_chance := l.ssn_chance + r.ssn_chance;
	self.addr_chance := l.addr_chance + r.addr_chance;
	self.dob_chance := l.dob_chance + r.dob_chance;
	self.phone_chance := l.phone_chance + r.phone_chance;
	self := l;
end;	
	
f_refrence_chance := rollup(project(f_convert_ready, reference_chance_rec), 
                            left.reference = right.reference,
														roll_chance(left, right));	

//step5: compute score_any_ fields
infile_ext_rec get_score_any(f_cmb_weight l, f_refrence_chance r) := transform
  max_score_from_dts := dataset([{if(l.ssn_weight>0, LMaxScores.MaxScoreFromSSN, 0)},
	                               {if(l.addr_weight>0, LMaxScores.MaxScoreFromAddress, 0)},
																 {if(l.dob_weight>0, LMaxScores.MaxScoreFromDob, 0)}, 
	                               {if(l.phoneweight>0, LMaxScores.MaxScoreFromPhone, 0)}],{unsigned2 score});
  max_score_from := max(max_score_from_dts, score);
  dob_weight_cnt := if(l.dobweight_year<>0,1,0) + if(l.dobweight_month<>0,1,0) + if(l.dobweight_day<>0,1,0);
	self.score_any_ssn := if(l.ssn_weight<>0,round(round(l.ssn_chance*100/r.ssn_chance)*LMaxScores.MaxScoreFromSSN/100),0);
	self.score_any_addr := if(l.addr_weight<>0,round(round(l.addr_chance*100/r.addr_chance)*LMaxScores.MaxScoreFromAddress/100),0);
	self.score_any_dob := if(dob_weight_cnt>=2,round(round(l.dob_chance*100/r.dob_chance)*LMaxScores.MaxScoreFromDOB/100),0);
	self.score_any_phn := if(l.PHONEWeight<>0,round(round(l.phone_chance*100/r.phone_chance)*LMaxScores.MaxScoreFromPhone/100),0);
	self.score := if(l.score>max_score_from, max_score_from, l.score);
	self := l;
end;	
	
f_out_ready4444 := join(f_convert_ready, f_refrence_chance,
                left.reference = right.reference,
				 			  get_score_any(left, right));

//step6: slim down	
out_ready_slim_rec := record
	unsigned6 reference;
	unsigned6 did;
	unsigned2 score;
	unsigned2 score_any_ssn;
	unsigned2 score_any_addr;
	unsigned2 score_any_dob;
	unsigned2 score_any_phn;
end;
 
outfile := if(need_score_any_value, project(f_out_ready4444, out_ready_slim_rec),
              project(infile, transform(out_ready_slim_rec, self:=left, self:=[])));

endmacro;