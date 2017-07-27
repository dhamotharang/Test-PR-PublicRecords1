#Stored('DPPAPurpose',1);
#Stored('GLBPurpose',1);
#Stored('DataRestrictionMask','00000000000000000');
#WORKUNIT('name','Healthcare_Cleaners.CannedInput_AddressCleaner Test');    //name it "MyJob"
Import Healthcare_Cleaners;
rec_in := Healthcare_Cleaners.Layouts.rawAddressInput;
rec_in setinput():=transform
		self.acctno := '1';
		self.addressLine1 := '18201 SW 12TH ST';
		self.addressLine2 := '';
		self.prim_range := '';
		self.predir := '';
		self.prim_name := '';
		self.addr_suffix := '';
		self.postdir := '';
		self.unit_desig := '';
		self.sec_range := '';
		self.p_city_name := 'MIAMI';
		self.st := 'FL';
		self.z5 := '33194';
	self:=[]
end;
IncludeHRI := true;
IncludeFlags := true;
ds_in:=dataset([setinput()]);
results:=project(ds_in,transform(Healthcare_Cleaners.Layouts.cleanAddressOutput,
															cln:=Healthcare_Cleaners.Functions.doAddressClean(left,IncludeHRI,IncludeFlags);
															self := cln[1];));
output(results);