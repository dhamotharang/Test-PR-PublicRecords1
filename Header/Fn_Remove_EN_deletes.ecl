import  ExperianCred ; 

export Fn_Remove_EN_deletes ( dataset(header.Layout_Header) h ) := FUNCTION

	headerEN   :=distribute(h(src='EN')                     ,hash((string)vendor_id));
	baseEN     :=distribute(ExperianCred.Files.Base_File_Out,hash(Encrypted_Experian_PIN));
  EN_del     :=Header.Mod_CreditBureau_address.files.prepped_nlr;
  EN_del_dedp:=dedup(sort(distribute(EN_del, hash(vendor_id)),vendor_id, local) ,vendor_id, local) ;
	
	//find, in header, EN records removed from ExperianCred
	del_rids_:=join(headerEN, baseEN
											,left.vendor_id = right.Encrypted_Experian_PIN
											,transform(left)
											,left only
											,local);
	//append delete code and date
	del_rids:=join(del_rids_, EN_del_dedp
											,left.vendor_id = right.vendor_id
											,transform({h, string8 delete_date, string2 suppression_code},self:=left,self:=right,self:=[])
											,left outer
											,local);

	//find, in header, records from other sources that match the EN records being deleted
	hdis        :=distribute(h(src<>'EN'),hash(fname,lname,ssn,dob,prim_range,prim_name,sec_range,st));
	del_rids_dis:=distribute(del_rids,    hash(fname,lname,ssn,dob,prim_range,prim_name,sec_range,st));
	del_rids_ddp:=dedup(del_rids_dis,fname,lname,ssn,dob,prim_range,prim_name,sec_range,st,local,all);
	OtherSrcMatch:=join(hdis, del_rids_ddp
															,   left.fname      = right.fname
															and left.lname      = right.lname
															and left.ssn        = right.ssn
															and left.dob        = right.dob
															and left.prim_range = right.prim_range
															and left.prim_name  = right.prim_name
															and left.sec_range  = right.sec_range
															and left.st         = right.st
															,local);

	//save a copy of records from other sources that are equal to those deleted by EN - see bug for reason why
	bName        :='~thor_data400::base::Experian_deletes_flagged_entities';
	saveClusters :=output(OtherSrcMatch,,bName+'_'+workunit,__compressed__,overwrite);
	move2Super   :=fileservices.addsuperfile(bName,bName+'_'+workunit);
	sequential(saveClusters, move2Super);

	//left only to keep header minus EN deleted rids
	EN_purged_header:=join(distribute(h,hash(rid)), distribute(del_rids,hash(rid))
																	,left.rid = right.rid
																	,left only
																	,local);

	return project(EN_purged_header,header.Layout_Header);

end;