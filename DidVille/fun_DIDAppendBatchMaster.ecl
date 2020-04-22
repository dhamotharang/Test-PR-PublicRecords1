import doxie;

export fun_DIDAppendBatchMaster(dataset(doxie.layout_inBatchMaster) inputs) :=
FUNCTION

//prep for did macro
didville.Layout_Did_OutBatch transform_BatchInputForDID(inputs l) := transform
  self.did := 0;
	self.ssn := l.ssn;
	self.dob := l.dob;
	self.phone10 := l.homephone;
	self.title := '';
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.suffix := l.name_suffix;
	self.prim_range := l.prim_range;
	self.predir := l.predir;
	self.prim_name := l.prim_name;
	self.addr_suffix := l.addr_suffix;
	self.postdir := l.postdir;
	self.unit_desig := l.unit_desig;
	self.sec_range := l.sec_range;
	self.p_city_name := l.p_city_name;
	self.st := l.st;
	self.z5 := l.z5;
	self.zip4 := l.zip4;
	self := l;
	self := [];
end;

fordid := project(inputs, transform_BatchInputForDID(left));

//get dids
didville.MAC_DidAppend(fordid,resu,false,'',true)

return resu;

end;
