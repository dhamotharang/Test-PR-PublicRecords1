mycod2 := Project(Ares.file_gpcod2, Transform(Ares.layout_gpcod2 or {string version},
																						self.version := 'mine',
																						self := left));
qccod2 := Project(Ares.Files.gpcod2_mc, Transform(Ares.layout_gpcod2 or {string version},
																						self.version := 'qc',
																						self := left));
cmbcod2 := mycod2(accuity_location_id != '') + qccod2;

RecordOf(cmbcod2) xform(cmbcod2 l) := Transform
	self.version := 'both';
	self := l;
End;		
		
cmbcod2_dist := distribute(cmbcod2, hash(	update_flag,accuity_location_id,department_function,cmbcod2.rank,routing_type,routing_code,routing_code_alternate_presentation,federal_reserve_district_code));
cmbcod2_sorted := sort(cmbcod2_dist, update_flag,accuity_location_id,department_function,cmbcod2.rank,routing_type,routing_code,routing_code_alternate_presentation,federal_reserve_district_code,local);
rolled := Rollup(cmbcod2_sorted, xform(left), update_flag,accuity_location_id,department_function,cmbcod2_dist.rank,routing_type,routing_code,routing_code_alternate_presentation,federal_reserve_district_code,local);


Output(count(rolled(version='both')), named('cnt_matching'));
Output(count(rolled(version='mine')), named('cnt_mine_only'));
Output(count(rolled(version='qc')), named('cnt_qc_only'));													
Output(sort(rolled(version='mine'),accuity_location_id) , named('mine_only'));
Output(sort(rolled(version='qc'),accuity_location_id), named('qc_only'));	
Output(sort(rolled(version='both'),accuity_location_id), named('both_only'));	

mine := rolled(version='mine');
qc := rolled(version='qc');

diff_layout := record
	mine.accuity_location_id;
	mine.routing_code_alternate_presentation;
	string mine_routingcode;
	string qc_routingcode;
	string mine_rank;
	string qc_rank;
	string mine_federal_reserve_district_code;
	string qc_federal_reserve_district_code;
	string mine_routing_type;
	string qc_routing_type;
	string mine_department_function;
	string qc_department_function;
	string diff;
End;

diff_layout xform_diff(mine l, qc r) := Transform
	self.accuity_location_id := l.accuity_location_id;
	self.routing_code_alternate_presentation := l.routing_code_alternate_presentation;
	self.mine_routingcode := l.routing_code;
	self.qc_routingcode := r.routing_code;
	self.mine_rank := l.rank;
	self.qc_rank := r.rank;
	self.mine_federal_reserve_district_code := l.federal_reserve_district_code;
	self.qc_federal_reserve_district_code := r.federal_reserve_district_code;
	self.mine_routing_type := l.routing_type;
	self.qc_routing_type := r.routing_type;
	self.mine_department_function := l.department_function;
	self.qc_department_function := r.department_function;
	self.diff := ROWDIFF(L,R);
End;

joined := join(	mine, qc, 
								left.accuity_location_id = right.accuity_location_id and 
								left.routing_code_alternate_presentation = right.routing_code_alternate_presentation,
								xform_diff(left,right));
output(sort(joined,accuity_location_id) , named('joined_diffs'));