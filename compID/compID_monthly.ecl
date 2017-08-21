import ut, did_add, header_slimsort, didville,watchdog,doxie,header,DriversV2,codes;

// replace BestDL.curr with watchdog.BestDL.curr after Certegy and new logic is incorporated there

cid_list	:=distribute(File_compID_list,hash(did));
best_cid	:=distribute(file_compid_best,hash(did));
// changes in delta records are labeled as follow:
// assigned_did=0; the link id still exist in the new best_compid but at least one field changed
// assigned_did=1; indicates a new link id
// assigned_did=2; the link id no longer exist in watchdog nor the row id (rid) exist in header -possibly dedupped during header.last_rollup.
// assigned_did>2 and did=assigned_did represents a splits of the previous link id; assigned_did is the new link id of the record with the lowest rid.
// assigned_did>2 and did<>assigned_did indicates a collapses of the previous link id; assigned_did is the link id it collapsesd into.
cid_delta	:=distribute(File_delta,hash(did));

// create a best_cid record set for link ids that changed
changes0:=join(best_cid, cid_delta(assigned_did=0), left.did=right.did, transform(left), local);

// obtain the best info for link ids that changed that are in cid_list
Layout_compID_out tr1(cid_list l, changes0 r) := transform
	self.last_name			:=r.lname;
	self.first_name			:=r.fname;
	self.middle_name		:=r.mname;
	self.Suffix				:=r.name_suffix;
	self.dob				:=(string8)r.dob[3..8];
	self.ssn				:=r.ssn;
	self.Zip_Code			:=r.zip;
	self.Address_1			:=	stringlib.stringcleanspaces(trim(r.prim_range)
														+' '+trim(r.predir)
														+' '+trim(r.prim_name)
														+' '+trim(r.suffix)
														+' '+trim(r.postdir));
	self.Address_2			:=	stringlib.stringcleanspaces(trim(r.unit_desig)
														+' '+trim(r.sec_range));
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

// create a record set of link ids that changed that are in cid_list
changes:=join(cid_list, changes0, left.did=right.did, tr1(left,right), local);

// create a record set of link ids that splits or collapsesd that are in cid_list
shifts:=join(cid_list, cid_delta(assigned_did>2)
				,left.did=right.assigned_did
				,transform({cid_delta.did
							,cid_delta.assigned_did
							,cid_delta.Original_State}
								,self:=right)
				,lookup
				,local);

// create a record set of link ids that splits and are in cid_list
splits:=project(shifts(assigned_did=did)
								,transform({Layout_compID_out}
										,self.state:=left.Original_State
										,self.Original_State:=left.Original_State
										,self.Original_CID_ADL:=(string16)intformat(left.did,16,1)
										,self.adl_stability_flag:='S'
										,self.cr:='\n'
										,self:=[]
												));

// create a record set of link ids that collapsesd and are in cid_list
collapses:=project(shifts(assigned_did<>did)
								,transform({Layout_compID_out}
										,self.state:=left.Original_State
										,self.Original_State:=left.Original_State
										,self.Original_CID_ADL:=(string16)intformat(left.did,16,1)
										,self.adl_stability_flag:='C'
										,self.cr:='\n'
										,self:=[]
												));

h:=header.file_headers;
segmented_header := distribute(Header.fn_ADLSegmentation(h).core_check,hash(did));
// append segmentation indicator to best_cid
bcid_with_ind := JOIN(best_cid, segmented_header
					,left.did=right.did
					,transform({best_cid
								,segmented_header.ind}
									,self:=left
									,self:=right)
					,LOCAL)
					 :persist('~thor_data400::persist::compid::bcid_with_ind')
					;

Layout_compID_out tr_wdog(cid_list l, bcid_with_ind r) :=transform
	threshld :=15;
	integer YYYYMMDDToDays(string pInput) :=	(((integer)(pInput[1..4])*365)
											+	((integer)(pInput[5..6])*30)
											+	((integer)(pInput[7..8])));
	today := YYYYMMDDToDays(ut.GetDate);
	of_age :=(integer)((today - YYYYMMDDToDays((string) r.dob)) / 365) >= threshld;

	//send new CORES if it is of age and not dead
	boolean new_core 		:= l.did=0 and r.ind='CORE' and r.dod='' and of_age;

	self.last_name			:=r.lname;
	self.first_name			:=r.fname;
	self.middle_name		:=r.mname;
	self.Suffix				:=r.name_suffix;
	self.dob				:=(string8)r.dob[3..8];
	self.ssn				:=r.ssn;
	self.Zip_Code			:=r.zip;
	self.Address_1			:=	stringlib.stringcleanspaces(trim(r.prim_range)
														+' '+trim(r.predir)
														+' '+trim(r.prim_name)
														+' '+trim(r.suffix)
														+' '+trim(r.postdir));
	self.Address_2			:=	stringlib.stringcleanspaces(trim(r.unit_desig)
														+' '+trim(r.sec_range));
	self.City				:=r.city_name;
	self.State				:=r.st;
	self.ZIP4				:=r.zip4;
	self.DOD_Ind			:=if(r.DOD<>'','Y','');
	self.DOD				:=r.DOD[3..6];
	self.original_state		:=r.st;
	self.Original_CID_ADL	:='';
	self.new_cid_adl		:=if(new_core,(string16)intformat(r.did,16,1),'');
	self.adl_stability_flag	:='';
	self.cr					:='\n';
	self:=l;
	self:=[];
end;

// obtain new qualifying CORES
new_cores :=join(cid_list,distribute(bcid_with_ind,hash(did))
				,left.did=right.did
				,tr_wdog(left,right)
				,right only
				,local)(new_cid_adl<>'')	:persist('~thor_data400::persist::compid::new_cores');

changes_n_new_cores0 := changes + new_cores;

// append DL to changes and new CORES
Layout_compID_out tr_dl(changes_n_new_cores0 l,File_Curr_BestDL r) :=transform
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
	self.License_State				:=stringlib.stringfilterout(r.state,'0123456789');
	self.License_Issue_Date			:=r.lic_issue_date[3..8];
	self.License_Expiration_Date	:=r.expiration_date[3..8];
	self:=l;
end;

changes_n_new_cores := join(distribute(changes_n_new_cores0,hash((unsigned6)new_cid_adl)),File_Curr_BestDL
												,(unsigned6)left.new_cid_adl=right.did
												,tr_dl(left,right)
												,left outer
												,local);

export compID_monthly := changes_n_new_cores + splits + collapses :persist('persist::compid::compID_monthly');