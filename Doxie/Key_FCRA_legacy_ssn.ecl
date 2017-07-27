import ut,header,mdr;

dSyncd1:=header.fn_FCRA_sync_legacy_ssn;

dHeader2:=table((header.file_tn_did+header.file_transunion_did+header.File_TUCS_did)(ssn<>''),{ssn,did,src,frid:=hashmd5(src,fname,lname,prim_range,prim_name,sec_range,zip,ssn,dob)});
dSnapShot2:=header.file_TU_ssn_snapshot(ssn<>'');
dSyncd2:=join(distribute(dHeader2(src in mdr.sourceTools.set_scoring_FCRA),hash(frid))
						,distribute(dSnapShot2(src in mdr.sourceTools.set_scoring_FCRA),hash(frid))
							,   left.frid=right.frid
							and left.ssn=right.ssn
							and left.src=right.src
							,transform({dHeader2.ssn,dHeader2.did},self:=left)
							,local);

records := dedup(sort(distribute(dSyncd1+dSyncd2,hash(did)),record,local),record,local);

export Key_FCRA_legacy_ssn := INDEX(records((unsigned)ssn>0), {records},ut.Data_Location.Person_header + 'thor_data400::key::FCRA::header.legacy_ssn_' + doxie.version_superkey,opt);