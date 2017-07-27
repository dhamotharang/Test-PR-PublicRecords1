import standard, ut, doxie; 

dParty := File_MFind_Clean;

rec := record
	dParty.did;
	dParty.trim_vid;
	standard.Addr addr;
	standard.name name;
	unsigned1 zero := 0;
	string1  blank:='';
end;

rec tra(dParty l) := transform
	self.addr.st := l.st;
	self.addr.zip5 := l.zip;
	self.addr := l;
	self.addr := [];
	self.name := l;
	self := l;
end;

d2 := distribute(project(dParty, tra(left)), hash(trim_vid));

export file_SearchAutokey := d2;
