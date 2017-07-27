import ut, did_add, header_slimsort, didville,watchdog,doxie,header,DriversV2,codes;

File_Dl:=dedup(sort(distribute(DriversV2.File_Dl,hash(did)),did, history, -dt_last_seen, -dt_first_seen,local),did,local);

cl:=distribute(File_compID_list,hash(did));
cw:=distribute(file_compid_best,hash(did));
cd:=distribute(File_delta,hash(did));

new_best:=join(cw, cd(assigned_did=0), left.did=right.did, transform(left), local);

Layout_compID_out tr1(cl l, new_best r) := transform
	self.last_name			:=r.lname;
	self.first_name			:=r.fname;
	self.middle_name		:=r.mname;
	self.Suffix				:=r.name_suffix;
	self.dob				:=(string8)r.dob[3..8];
	self.ssn				:=r.ssn;
	self.Zip_Code			:=r.zip;
	self.Address_1			:=	trim(r.prim_range)
							+' '+trim(r.predir)
							+' '+trim(r.prim_name)
							+' '+trim(r.suffix)
							+' '+trim(r.postdir);
	self.Address_2			:=	trim(r.unit_desig)
							+' '+trim(r.sec_range);
	self.City				:=r.city_name;
	self.State				:=r.st;
	self.ZIP4				:=r.zip4;
	self.DOD_Ind			:=if(r.DOD<>'','Y','');
	self.DOD				:=r.DOD[3..6];
	self.original_state		:='';
	self.Original_CID_ADL	:=(string16)intformat(l.did,16,1);
	self.new_cid_adl		:=(string16)intformat(l.did,16,1);
	self.adl_stability_flag	:='';
	self.cr					:='\n';
	self:=[];
end;

deltas:=join(cl, new_best, left.did=right.did, tr1(left,right), local);

shifts:=join(cl, cd(assigned_did>2)
				,left.did=right.assigned_did
				,transform({cd.did
							,cd.assigned_did}
								,self:=right)
				,lookup
				,local);

split:=project(shifts(assigned_did=did)
								,transform({Layout_compID_out}
										,self.Original_CID_ADL:=(string16)intformat(left.did,16,1)
										,self.adl_stability_flag:='S'
										,self:=[]
												));

Layout_compID_out tr2(cw l, shifts r) := transform
	self.last_name			:=l.lname;
	self.first_name			:=l.fname;
	self.middle_name		:=l.mname;
	self.Suffix				:=l.name_suffix;
	self.dob				:=(string8)l.dob[3..8];
	self.ssn				:=l.ssn;
	self.Zip_Code			:=l.zip;
	self.Address_1			:=	trim(l.prim_range)
							+' '+trim(l.predir)
							+' '+trim(l.prim_name)
							+' '+trim(l.suffix)
							+' '+trim(l.postdir);
	self.Address_2			:=	trim(l.unit_desig)
							+' '+trim(l.sec_range);
	self.City				:=l.city_name;
	self.State				:=l.st;
	self.ZIP4				:=l.zip4;
	self.DOD_Ind			:=if(l.DOD<>'','Y','');
	self.DOD				:=l.DOD[3..6];
	self.original_state		:='';
	self.Original_CID_ADL	:=(string16)intformat(r.did,16,1);
	self.new_cid_adl		:=(string16)intformat(r.assigned_did,16,1);
	self.adl_stability_flag	:='C';
	self.cr					:='\n';
	self:=l;
	self:=[];
end;

collapse:=join(cw, shifts(assigned_did<>did)
					,left.did=right.assigned_did
					,tr2(left,right)
					,lookup
					,local);

h:=header.file_headers;
segmented_wdog := distribute(Header.fn_ADLSegmentation(h).core_check,hash(did));
wdog_with_ind := JOIN(distribute(file_compid_best,hash(did)),segmented_wdog
					,left.did=right.did
					,transform({file_compid_best,segmented_wdog.ind}
								,self.ind:=right.ind
								,self:=left)
					,LOCAL)
					 :persist('~thor_data400::persist::compid::wdog_with_ind')
					;

Layout_compID_out tr_wdog(cl l, wdog_with_ind r) :=transform

	threshld :=15;
	integer YYYYMMDDToDays(string pInput) :=	(((integer)(pInput[1..4])*365)
											+	((integer)(pInput[5..6])*30)
											+	((integer)(pInput[7..8])));
	today := YYYYMMDDToDays(ut.GetDate);
	of_age :=(integer)((today - YYYYMMDDToDays((string) r.dob)) / 365) >= threshld;

	//even if the record ADLd, do not send it back if it is not in watchdog
	boolean new_core 		:= l.did=0 and r.ind='CORE' and r.dod='' and of_age;


	self.last_name			:=r.lname;
	self.first_name			:=r.fname;
	self.middle_name		:=r.mname;
	self.Suffix				:=r.name_suffix;
	self.dob				:=(string8)r.dob[3..8];
	self.ssn				:=r.ssn;
	self.Zip_Code			:=r.zip;
	self.Address_1			:=	trim(r.prim_range)
							+' '+trim(r.predir)
							+' '+trim(r.prim_name)
							+' '+trim(r.suffix)
							+' '+trim(r.postdir);
	self.Address_2			:=	trim(r.unit_desig)
							+' '+trim(r.sec_range);
	self.City				:=r.city_name;
	self.State				:=r.st;
	self.ZIP4				:=r.zip4;
	self.DOD_Ind			:=if(r.DOD<>'','Y','');
	self.DOD				:=r.DOD[3..6];
	self.original_state		:='';
	self.Original_CID_ADL	:='';
	self.new_cid_adl		:=if(new_core,(string16)intformat(r.did,16,1),'');
	self.adl_stability_flag	:='';
	self.cr					:='\n';
	self:=l;
	self:=[];
end;

with_wdog :=join(cl,distribute(wdog_with_ind,hash(did))
				,left.did=right.did
				,tr_wdog(left,right)
				,right outer
				,local)	:persist('~thor_data400::persist::compid::wdog');

new_cores:=with_wdog(new_cid_adl<>'');
append_dl:=	deltas
			+collapse
			+new_cores;

Layout_compID_out tr_dl(append_dl l,File_Dl r) :=transform
	self.Gender						:=r.sex_flag;
	self.License_Number				:=r.dl_number;
	self.License_Type				:=r.license_type;
	type_desc	:=codes.DRIVERS_LICENSE.LICENSE_TYPE(trim(r.state),trim(r.license_type));
	class_desc	:=codes.DRIVERS_LICENSE.LICENSE_TYPE(trim(r.state),trim(r.license_class));
	self.Commercial_Drivers_License_Indicator	:=
		if(	stringlib.stringfind(stringlib.stringtouppercase(type_desc+class_desc),'COMMER',1)>0
		and stringlib.stringfind(stringlib.stringtouppercase(type_desc+class_desc),'NON-COMMER',1)=0
		,'Y','');
	self.License_Restrictions		:=r.restrictions;
	self.License_State				:=r.state;
	self.License_Issue_Date			:=r.lic_issue_date[3..8];
	self.License_Expiration_Date	:=r.expiration_date[3..8];
	self:=l;
end;

// append DL
out0 := join(distribute(append_dl,hash((unsigned6)new_cid_adl)),File_Dl
				,(unsigned6)left.new_cid_adl=right.did
				,tr_dl(left,right)
				,left outer
				,local) + split  :persist('~thor_data400::persist::compid::out0');

export compID_monthly := out0;