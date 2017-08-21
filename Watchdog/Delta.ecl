//Compare the previous best file with the current one
import header;

string20 var1 := '' : stored('watchtype');

curr := dataset('persist::watchdog_joined',Watchdog.Layout_Best_Marketing_Flag,flat);

prev := map(var1='nonglb'=>watchdog.file_previous_best_nonglb,
		   var1='nonutility'=>watchdog.File_previous_best_nonutility,
		   var1='nonglb_nonutility'=>watchdog.File_previous_best_nonglb_nonutility,
		   var1='marketing'=>watchdog.file_previous_best_marketing,
		  watchdog.File_previous_best);

//join the two files in full outer join
watchdog.Layout_Delta  findDelta(curr l, prev r) := transform

unsigned6 l_addr_id := hash64(stringlib.stringcleanspaces(l.prim_range+l.prim_name+l.sec_range+l.zip+l.zip4));
unsigned6 r_addr_id := hash64(stringlib.stringcleanspaces(r.prim_range+r.prim_name+r.sec_range+r.zip+r.zip4));

boolean addr_change := if(l_addr_id <> r_addr_id ,true,false) ;

self.assigned_did := if(l.did=0,2,if(r.did=0,1,0));
self.did := if(l.did=0,r.did,l.did);
self.phone := if(l.phone=r.phone,'',if(l.phone='' and r.phone<>'','*NULL',l.phone));
self.ssn := if(l.ssn=r.ssn,'',if(l.ssn='' and r.ssn<>'','*NULL',l.ssn));
self.dob := if(l.dob=r.dob,0,if(l.dob=0 and r.dob<>0,-1,l.dob));
self.title := if(hash64(stringlib.stringcleanspaces(l.fname+l.lname))= hash64(stringlib.stringcleanspaces(r.fname+r.lname)),'',if(l.title=r.title,'',if(l.title='' and r.title<>'','*NULL',l.title)));
self.fname := if(l.fname=r.fname,'',if(l.fname='' and r.fname<>'','*NULL',l.fname));
self.mname := if(l.mname=r.mname,'',if(l.mname='' and r.mname<>'','*NULL',l.mname));
self.lname := if(l.lname=r.lname,'',if(l.lname='' and r.lname<>'','*NULL',l.lname));
self.name_suffix := if(l.name_suffix=r.name_suffix,'',if(l.name_suffix='' and r.name_suffix<>'','*NULL',l.name_suffix));
self.prim_range := if(~addr_change ,'', if(l.prim_range=r.prim_range,'',if(l.prim_range='' and r.prim_range<>'','*NULL',l.prim_range)));
self.predir :=  if(~addr_change ,'',if(l.predir=r.predir,'',if(l.predir='' and r.predir<>'','*NULL',l.predir)));
self.prim_name :=  if(~addr_change ,'',if(l.prim_name=r.prim_name,'',if(l.prim_name='' and r.prim_name<>'','*NULL',l.prim_name)));
self.suffix :=  if(~addr_change ,'',if(l.suffix=r.suffix,'',if(l.suffix='' and r.suffix<>'','*NULL',l.suffix)));
self.postdir :=  if(~addr_change ,'',if(l.postdir=r.postdir,'',if(l.postdir='' and r.postdir<>'','*NULL',l.postdir)));
self.unit_desig :=  if(~addr_change ,'',if(l.unit_desig=r.unit_desig,'',if(l.unit_desig='' and r.unit_desig<>'','*NULL',l.unit_desig)));
self.sec_range :=  if(~addr_change ,'',if(l.sec_range=r.sec_range,'',if(l.sec_range='' and r.sec_range<>'','*NULL',l.sec_range)));
self.city_name :=  if(~addr_change ,'',if(l.city_name=r.city_name,'',if(l.city_name='' and r.city_name<>'','*NULL',l.city_name)));
self.st :=  if(~addr_change ,'',if(l.st=r.st,'',if(l.st='' and r.st<>'','*NULL',l.st)));
self.zip :=  if(~addr_change ,'',if(l.zip=r.zip,'',if(l.zip='' and r.zip<>'','*NULL',l.zip)));
self.zip4 :=  if(~addr_change ,'',if(l.zip4=r.zip4,'',if(l.zip4='' and r.zip4<>'','*NULL',l.zip4)));

self.dod:= if(l.dod=r.dod,'',if(l.dod='' and r.dod<>'','*NULL',l.dod));
self.Prpty_deed_id:= if(l.Prpty_deed_id=r.Prpty_deed_id,'',if(l.Prpty_deed_id='' and r.Prpty_deed_id<>'','*NULL',l.Prpty_deed_id));
self.Vehicle_vehnum:= if(l.Vehicle_vehnum=r.Vehicle_vehnum,'',if(l.Vehicle_vehnum='' and r.Vehicle_vehnum<>'','*NULL',l.Vehicle_vehnum));
self.Bkrupt_CrtCode_CaseNo := if(l.Bkrupt_CrtCode_CaseNo[1..12]=r.Bkrupt_CrtCode_CaseNo[1..12],'',if(l.Bkrupt_CrtCode_CaseNo='' and r.Bkrupt_CrtCode_CaseNo<>'','*NULL',l.Bkrupt_CrtCode_CaseNo));
self.main_count:= if(l.main_count=r.main_count or l.main_count< r.main_count and l.main_count>0,0,
					if(l.main_count=0 and r.main_count>0,-1,l.main_count));
self.search_count := if(l.search_count=r.search_count or l.search_count< r.search_count and l.search_count>0,0,
					if(l.search_count=0 and r.search_count>0,-1,l.search_count));
self.DL_number := if(l.DL_number=r.DL_number,'',if(l.DL_number='' and r.DL_number<>'','*NULL',l.DL_number));
self.bdid := if(l.bdid=r.bdid,'',if(l.bdid='' and r.bdid<>'','*NULL',l.bdid));
self.run_date := l.run_date;
self.total_records := l.total_records;
end;

deltas := join(curr,prev,left.did=right.did,findDelta(left,right),full outer,local);

//Find the DID of all records with an Assigned DID (No current best record)
old_did := distribute(deltas(assigned_did=2),hash(did));

f := distribute(header.File_Headers,hash(rid));

Layout_Delta getDID(Layout_Delta l, f r) := transform
self.assigned_did := if(r.rid=0,2,r.did);
self := l;
end;

removed_dids := join(old_did,f,left.did=right.rid,getDID(left,right),left outer,local);

get_deltas := deltas(assigned_did!=2) + removed_dids;

export Delta := get_deltas(assigned_did!=0 or phone!='' or ssn!='' or dob!=0 or fname!='' or
					mname!='' or lname!='' or prim_range!='' or prim_name!='' or
					predir!='' or suffix!='' or postdir!='' or unit_desig!='' or
					sec_range!='' or city_name!= '' or st!='' or zip!='' or zip4!='' or
					dod!='' or Prpty_deed_id!='' or Vehicle_vehnum!='' or 
					Bkrupt_CrtCode_CaseNo!='' or main_count != 0 or search_count != 0 or 
					DL_number!='' or bdid!='');