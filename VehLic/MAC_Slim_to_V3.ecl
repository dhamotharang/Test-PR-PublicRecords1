//veh_slim := vehlic.File_Slim_Vehreg_V3; //not really the file, but the format
//veh_fat := vehlic.File_Vehreg_Raw;
export mac_Slim_to_V3(veh_slim, veh_fat, outfile) := macro

//-- put them back on the node where they came from

typeof(veh_fat) clear_did(veh_fat le) := transform
  self.own_1_did := '';
  self.reg_1_did := '';
  self.own_2_did := '';
  self.reg_2_did := '';
  self.own_1_bdid := '';
  self.own_2_bdid := '';
  self.reg_1_bdid := '';
  self.reg_2_bdid := '';
  self := le;
  end;

veh_fat_1 := project(veh_fat,clear_did(left));
//****** Put back the own_1 results
typeof(veh_fat) put_did(veh_fat l, veh_slim r) := transform
	self.own_1_did := IF(r.rec_source<>'own_1' or r.did=0,l.own_1_did,
						 intformat(r.did, 12, 1));
	self.own_1_ssn := IF(r.rec_source<>'own_1',l.own_1_ssn,r.ssn);
	self.own_1_bdid := if(r.rec_source <>'own_1' or R.bdid = 0, L.own_1_bdid, intformat(R.bdid,12,1));

	self.own_2_did := IF(r.rec_source<>'own_2' or r.did=0,l.own_2_did,
						 intformat(r.did, 12, 1));
	self.own_2_ssn := IF(r.rec_source<>'own_2',l.own_2_ssn,r.ssn);
	self.own_2_bdid := if(r.rec_source <>'own_2' or R.bdid = 0, L.own_2_bdid, intformat(R.bdid,12,1));

	self.reg_1_did := IF(r.rec_source<>'reg_1' or r.did=0,l.reg_1_did,
						 intformat(r.did, 12, 1));
	self.reg_1_ssn := IF(r.rec_source<>'reg_1',l.reg_1_ssn,r.ssn);
	self.reg_1_bdid := if(r.rec_source <>'reg_1' or R.bdid = 0, L.reg_1_bdid, intformat(R.bdid,12,1));

	self.reg_2_did := IF(r.rec_source<>'reg_2' or r.did=0,l.reg_2_did,
						 intformat(r.did, 12, 1));
	self.reg_2_ssn := IF(r.rec_source<>'reg_2',l.reg_2_ssn,r.ssn);
	self.reg_2_bdid := if(r.rec_source <>'reg_2' or R.bdid = 0, L.reg_2_bdid, intformat(R.bdid,12,1));
	self := l;
end;

veh := denormalize(distribute(veh_fat_1, hash(seq_no)),
				   distribute(veh_slim, hash(seq_no)),
				   left.seq_no=right.seq_no,put_did(left,right),local);

outfile := veh;
endmacro;