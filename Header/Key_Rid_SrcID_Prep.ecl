import doxie, data_services,ut,header_quick,doxie;

src_rec:=Layout_RID_SrcID;

export Key_Rid_SrcID_Prep(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function

	final_header := distribute(header.file_headers,hash(fname,lname,zip));
	NHR_dis := distribute(header.File_New_Header_Records,hash(fname,lname,zip));
	NHR_srt := sort(NHR_dis
									,src
									,fname
									,mname
									,lname
									,name_suffix
									,phone
									,ssn
									,dob
									,prim_range
									,predir
									,prim_name
									,suffix
									,postdir
									,unit_desig
									,sec_range
									,city_name
									,st
									,zip
									,zip4
									,county
									,local);

	new_rec := dedup(NHR_srt
									,src
									,fname
									,mname
									,lname
									,name_suffix
									,phone
									,ssn
									,dob
									,prim_range
									,predir
									,prim_name
									,suffix
									,postdir
									,unit_desig
									,sec_range
									,city_name
									,st
									,zip
									,zip4
									,county
									,local);

	Layout_RID_SrcID getID(new_rec L, final_header R) := transform
	 self.rid := r.rid;
	 self     := l;
	end;

	get_recs0 := join(new_rec, final_header
										,   left.fname=right.fname
										and left.lname=right.lname
										and left.zip=right.zip
										and left.src=right.src
										and ut.nneq_date(left.dob, right.dob)
										and left.mname=right.mname
										and	left.prim_range=right.prim_range
										and left.predir=right.predir
										and left.prim_name=right.prim_name
										and left.suffix=right.suffix
										and left.postdir=right.postdir
										and	ut.NNEQ(left.sec_range, right.sec_range)
										and left.st=right.st
										and	ut.NNEQ_Phone(left.phone,right.phone)
										and (ut.nneq_ssn(left.ssn, right.ssn) or right.pflag3 <>'')
										and	(left.name_suffix=right.name_suffix or ut.is_unk(right.name_suffix))
										,getID(left,right)
										,local);			

	dFheader:=project(dataset('~thor_data400::persist::qh_seqd',header.Layout_New_Records,flat),Layout_RID_SrcID);
	get_recs := if(pCombo,pDataset,if(pFastHeader, dFheader, get_recs0 + header.file_transunion_rid_srcid + header.file_tn_rid_srcid));

	return index(get_recs, {rid}, {get_recs},data_services.Data_location.prefix('Source')+'thor_data400::key::header_rid_srid'+if(pCombo,'',SF_suffix(pFastHeader))+'_' + doxie.Version_SuperKey,opt);

end;