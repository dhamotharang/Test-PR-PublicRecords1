a := dataset('~thor_data400::delta::watchdog_delta_nonglbw20041120-080148',watchdog.Layout_Delta,flat);
b := watchdog.File_Previous_Best_nonglb;

watchdog.Layout_Best getNew(b L, a R) := transform
	self.phone := map(r.phone='' => l.phone,
				   r.phone[1..2]='*N' => '',
				   r.phone);
	self.ssn := map(r.ssn='' => l.ssn,
				    r.ssn[1..2]='*N' => '',
				    r.ssn);
	self.dob := map(r.dob=0 => l.dob,
				    r.dob=-1 => 0,
				    r.dob);
	self.title := map(r.title='' => l.title,
				    r.title[1..2]='*N' => '',
				    r.title);
	self.fname := map(r.fname='' => l.fname,
				    r.fname[1..2]='*N' => '',
				    r.fname);
	self.mname := map(r.mname='' => l.mname,
				    r.mname[1..2]='*N' => '',
				    r.mname);
	self.lname := map(r.lname='' => l.lname,
				    r.lname[1..2]='*N' => '',
				    r.lname);
	self.name_suffix := map(r.name_suffix='' => l.name_suffix,
					    r.name_suffix[1..2]='*N' => '',
					    r.name_suffix);
	self.prim_range := map(r.prim_range='' => l.prim_range,
					    r.prim_range[1..2]='*N' => '',
					    r.prim_range);
	self.predir := map(r.predir='' => l.predir,
				    r.predir[1..2]='*N' => '',
				    r.predir);
	self.prim_name := map(r.prim_name='' => l.prim_name,
					    r.prim_name[1..2]='*N' => '',
					    r.prim_name);
	self.suffix := map(r.suffix='' => l.suffix,
				    r.suffix[1..2]='*N' => '',
				    r.suffix);
	self.postdir := map(r.postdir='' => l.postdir,
				    r.postdir[1..2]='*N' => '',
				    r.postdir);
	self.unit_desig := map(r.unit_desig='' => l.unit_desig,
					    r.unit_desig[1..2]='*N' => '',
					    r.unit_desig);
	self.sec_range := map(r.sec_range='' => l.sec_range,
					    r.sec_range[1..2]='*N' => '',
					    r.sec_range);
	self.city_name := map(r.city_name='' => l.city_name,
					    r.city_name[1..2]='*N' => '',
					    r.city_name);
	self.st := map(r.st='' => l.st,
			    r.st[1..2]='*N' => '',
			    r.st);
	self.zip := map(r.zip='' => l.zip,
			    r.zip[1..2]='*N' => '',
			    r.zip);
	self.zip4 := map(r.zip4='' => l.zip4,
				    r.zip4[1..2]='*N' => '',
				    r.zip4);
	self.addr_dt_last_seen := if(r.addr_dt_last_seen=0, l.addr_dt_last_seen,
						    r.addr_dt_last_seen);
	self.DOD := map(r.DOD='' => l.DOD,
				    r.DOD[1..2]='*N' => '',
				    r.DOD);
	self.Prpty_deed_id := map(r.Prpty_deed_id='' => l.Prpty_deed_id,
						    r.Prpty_deed_id[1..2]='*N' => '',
						    r.Prpty_deed_id);
	self.Vehicle_vehnum := map(r.Vehicle_vehnum='' => l.Vehicle_vehnum,
						    r.Vehicle_vehnum[1..2]='*N' => '',
						    r.Vehicle_vehnum);
	self.Bkrupt_CrtCode_CaseNo :=	map(r.Bkrupt_CrtCode_CaseNo='' => l.Bkrupt_CrtCode_CaseNo,
							    r.Bkrupt_CrtCode_CaseNo[1..2]='*N' => '',
							    r.Bkrupt_CrtCode_CaseNo);
	self.DL_number := map(r.DL_number='' => l.DL_number,
					    r.DL_number[1..2]='*N' => '',
					    r.DL_number);
	self.run_date := 20041120;
	self.total_records := l.total_records;
     self := l;
end;

NEW_best := join(b,a,left.did=right.did,getNew(left,right),left outer,local);

output(new_best,,'~thor_data400::base::watchdog_best_nonglb20041120_restored');