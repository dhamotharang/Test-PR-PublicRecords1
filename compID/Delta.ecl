import header,watchdog,ut,codes,DriversV2;
//Compare the previous best file with the current one
// assigned_did in delta records are labeled as follow:
// assigned_did=0; the link id still exist in the new best_compid but at least one field changed
// assigned_did=1; indicates a new link id
// assigned_did=2; the link id no longer exist in watchdog nor the row id (rid) exist in header -possibly dedupped during header.last_rollup.
// assigned_did>2 and did=assigned_did represents a split of the previous link id; assigned_did is the new link id of the record with the lowest rid.
// assigned_did>2 and did<>assigned_did indicates a collapse of the previous link id; assigned_did is the link id it collapsed into.

curr0 := distribute(file_compid_best,hash(did));
curr := join(curr0, File_Curr_BestDL
				,left.did=right.did
				,transform({curr0
							,DriversV2.layout_dl dl} 
								,self:=left
								,self.dl:=right)
				,left outer
				,local);

prev0 := distribute(dataset('~thor_data400::base::best_compid_father',Watchdog.Layout_Best,flat),hash(did));
prev := join(prev0, File_Prev_BestDL
				,left.did=right.did
				,transform({prev0
							,DriversV2.layout_dl dl} 
								,self:=left
								,self.dl:=right)
				,left outer
				,local);

//join the two files in full outer join
{Layout_Delta, DriversV2.layout_dl dl}  findDelta(curr l, prev r) := transform

self.assigned_did			:=	if(l.did=0,2,if(r.did=0,1,0));
self.did					:=	if(l.did=0,r.did,l.did);
self.ssn					:=	if(l.ssn=r.ssn,'',if(l.ssn<>'' and r.ssn='',l.ssn,''));
self.dob					:=	if(l.dob=r.dob,0,if(l.dob<>0 and r.dob=0,l.dob,0));
self.fname					:=	if(l.fname=r.fname,'',if(l.fname<>'' and r.fname='',l.fname,''));
self.mname					:=	if(l.mname=r.mname,'',if(l.mname<>'' and r.mname='',l.mname,''));
self.lname					:=	if(l.lname=r.lname,'',if(l.lname<>'' and r.lname='',l.lname,''));
self.name_suffix			:=	if(l.name_suffix=r.name_suffix,'',if(l.name_suffix<>'' and r.name_suffix='',l.name_suffix,''));
// 1 – an address changes states.  FL->GA for instance.
// 2 – any element (outside of address) goes from blank to something.
self.st						:=	if(l.st=r.st,'',if(l.st<>'' and l.st in Set_states and r.st<>'',l.st,''));
self.dod					:=	if(l.dod=r.dod,'',if(l.dod<>'' and r.dod='',l.dod,''));
self.run_date				:=	l.run_date;
self.total_records			:=	l.total_records;

self.dl.sex_flag			:=if(l.dl.sex_flag=r.dl.sex_flag,'',if(l.dl.sex_flag<>'' and r.dl.sex_flag='',l.dl.sex_flag,''));
self.dl.dl_number			:=if(l.dl.dl_number=r.dl.dl_number,'',if(l.dl.dl_number<>'' and r.dl.dl_number='',l.dl.dl_number,''));
self.dl.License_Type		:=if(l.dl.license_type=r.dl.license_type,'',if(l.dl.license_type<>'' and r.dl.license_type='',l.dl.license_type,''));
self.dl.restrictions		:=if(l.dl.restrictions=r.dl.restrictions,'',if(l.dl.restrictions<>'' and r.dl.restrictions='',l.dl.restrictions,''));
self.dl.state				:=if(l.dl.state=r.dl.state,'',if(l.dl.state<>'' and  l.dl.state in Set_states and r.dl.state='',l.dl.state,''));
self.dl.lic_issue_date		:=if(l.dl.lic_issue_date=r.dl.lic_issue_date,0,if(l.dl.lic_issue_date<>0 and r.dl.lic_issue_date=0,l.dl.lic_issue_date,0));
self.dl.expiration_date		:=if(l.dl.expiration_date=r.dl.expiration_date,0,if(l.dl.expiration_date<>0 and r.dl.expiration_date=0,l.dl.expiration_date,0));
self.Original_State:=r.st;
self.dl:=[];
end;

deltas := join(curr,prev,left.did=right.did,findDelta(left,right),full outer,local);

//Find the DID of all records with an Assigned DID (No current best record)
old_did := distribute(deltas(assigned_did=2),hash(did));

f := distribute(header.File_Headers,hash(rid));

deltas getDID(old_did l, f r) := transform
	self.assigned_did := if(r.rid=0,2,r.did);
	self := l;
end;

removed_dids := join(old_did, f, left.did=right.rid, getDID(left,right), left outer,local);

get_deltas := deltas(assigned_did!=2) + removed_dids;

Delta0 := get_deltas(
								assigned_did	!=0
							or	ssn				!=''
							or	dob				!=0
							or	fname			!=''
							or	mname			!=''
							or	lname			!=''
							or	name_suffix		!=''
							or	st				!=''
							or	dod				!=''
							or	dl.sex_flag		!=''
							or	dl.dl_number	!=''
							or	dl.License_Type	!=''
							or	dl.restrictions	!=''
							or	dl.state		!=''
							or	dl.lic_issue_date	!=0
							or	dl.expiration_date	!=0
						):persist('temp::compid::delta');

export Delta := project(Delta0,Layout_Delta);