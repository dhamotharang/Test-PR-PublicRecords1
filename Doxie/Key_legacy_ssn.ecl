import ut,header;

dHeader  :=table(header.file_headers(ssn<>''),{ssn,did,rid});
dSnapShot:=header.file_ssn_snapshot(ssn<>'');

dSyncd1:=join(distribute(dHeader,hash(rid))
					,distribute(dSnapShot,hash(rid))
							,   left.rid=right.rid
							and left.ssn=right.ssn
							,transform({dHeader.ssn,dHeader.did},self:=left)
							,local);

dHeader2:=table((header.file_tn_did+header.file_transunion_did+header.File_TUCS_did)(ssn<>''),{ssn,did,src,frid:=hashmd5(src,fname,lname,prim_range,prim_name,sec_range,zip,ssn,dob)});
dSnapShot2:=header.file_TU_ssn_snapshot(ssn<>'');
dSyncd2:=join(distribute(dHeader2,hash(frid))
						,distribute(dSnapShot2,hash(frid))
							,   left.frid=right.frid
							and left.ssn=right.ssn
							and left.src=right.src
							,transform({dHeader2.ssn,dHeader2.did},self:=left)
							,local);

records := dedup(sort(dSyncd1+dSyncd2,record),record);

export Key_legacy_ssn := INDEX(records, {records},ut.Data_Location.Person_header + 'thor_data400::key::header.legacy_ssn_' + doxie.version_superkey,opt);