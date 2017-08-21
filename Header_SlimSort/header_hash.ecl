import header;
h := header.File_Headers; // (src<>'EN');

hf := record
	h;
	unsigned4 mob := h.dob div 100;
	unsigned4 dayob := h.dob % 100;
	string5 z5 := h.zip;
	string10 phone10 := h.phone;
end;
   
t := table(h(fname<>''),hf);

re := record
	unsigned6 did;
	unsigned8 hash_val;  
end;
  
re take(t l,unsigned1 c) := transform
	self.hash_val := mac_hash_inputfile(c);
	self.did := l.did;
end;
  
n := normalize(t,17,take(left,counter));

res := record
	n.hash_val;
	unsigned6 did := max(group,n.did);
	unsigned6 min_did := min(group,n.did);
end;
  
ts := table(n(hash_val<>0),res,hash_val);

gd := table(ts(did=min_did),{hash_val,did});  

export header_hash := gd;// index(gd,{gd},'~thor_Data400::key.hashes');
