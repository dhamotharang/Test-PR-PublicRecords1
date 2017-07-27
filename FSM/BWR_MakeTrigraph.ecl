fp := fsm.prim_Names();
ff := fsm.first_Names();
fl := fsm.last_Names();
fc := fsm.Company_Names();

fsm.MAC_Trigraphs(fp,prim_name,cnt,pi1);
fsm.MAC_Trigraphs(ff,fname,cnt,fi1);
fsm.MAC_Trigraphs(fl,lname,cnt,li1);
fsm.MAC_Trigraphs(fc,company_name,cnt,ci1);

resp := pi1(pcnt>=1);
resl := li1(pcnt>=1);
resf := fi1(pcnt>=1);
resc := ci1(pcnt>=1);

r1 := record
  string5 s;
	unsigned1 pcnt;
  end;
	
r1 fip(resp le) := transform
  self.s := '"' + le.s + '"';
	self.pcnt := le.pcnt;
  end;	

r1 fil(resl le) := transform
  self.s := '"' + le.s + '"';
	self.pcnt := le.pcnt;
  end;	
r1 fif(resf le) := transform
  self.s := '"' + le.s + '"';
	self.pcnt := le.pcnt;
  end;	
r1 fic(resc le) := transform
  self.s := '"' + le.s + '"';
	self.pcnt := le.pcnt;
  end;	

output( choosen( project(resp,fip(left)), 30000 ) );
output( choosen( project(resl,fil(left)), 30000 ) );
output( choosen( project(resf,fif(left)), 30000 ) );
output( choosen( project(resc,fic(left)), 30000 ) );