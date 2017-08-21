import ut;

base:=ATF.file_firearms_explosives_base_BIP;

layout_prepped_for_keys tr(base l) := transform
	isLicense1 :=     l.fname=l.license1_fname
								and l.mname=l.license1_mname
								and l.lname=l.license1_lname
								and l.suffix=l.license1_name_suffix;
	isLicense2 :=     l.fname=l.license2_fname
								and l.mname=l.license2_mname
								and l.lname=l.license2_lname
								and l.suffix=l.license2_name_suffix;
	isCompany1 :=     l.company_name=l.license1_cname;
	isCompany2 :=     l.company_name=l.business_cname;

	self.license1_did  := if(isLicense1	,l.did_out	,'');
	self.license1_bdid := if(isCompany1	,l.bdid	,'');
	self.best_ssn      := if(isLicense1	,l.best_ssn	,'');
	self.license2_did  := if(isLicense2	,l.did_out	,'');
	self.license2_bdid := if(isCompany2	,l.bdid	,'');
	self.best_ssn2     := if(isLicense2	,l.best_ssn	,'');
	self.did           := 0;
	self.did_out       := '';
	self.d_score       := '';
	self.bdid          := '';
	self.bdid_score    := '';
	self.bid           := 0;
	self.bid_score     := 0;
	self.ATF_id := 0;
	self := L;
end;

p:=project(base,tr(left));

final_out_srt := sort(distribute(p,hash(seq)),seq,local);

layout_prepped_for_keys tr2(final_out_srt l, final_out_srt r) := transform
	license1_did  := intformat(ut.Min2((unsigned)l.license1_did	,(unsigned)r.license1_did),12,1);
	license1_bdid := intformat(ut.Min2((unsigned)l.license1_bdid	,(unsigned)r.license1_bdid),12,1);
	best_ssn      := if(self.license1_did=l.license1_did,l.best_ssn	,r.best_ssn);
	license2_did  := intformat(ut.Min2((unsigned)l.license2_did	,(unsigned)r.license2_did),12,1);
	license2_bdid := intformat(ut.Min2((unsigned)l.license2_bdid	,(unsigned)r.license2_bdid),12,1);
	best_ssn2     := if(self.license2_did=l.license2_did,l.best_ssn2	,r.best_ssn2);

	self.license1_did  := if((unsigned)license1_did=0,'',license1_did);
	self.license1_bdid := if((unsigned)license1_bdid=0,'',license1_bdid);
	self.best_ssn      := if((unsigned)license1_did=0,'',best_ssn);
	self.license2_did  := if((unsigned)license2_did=0,'',license2_did);
	self.license2_bdid := if((unsigned)license2_bdid=0,'',license2_bdid);
	self.best_ssn2     := if((unsigned)license2_did=0,'',best_ssn2);
	self.did_out:='';
	self.d_score:='';
	self.bdid:='';
	self.bdid_score:='';
	self := L;
end;

final_out_rld := rollup(final_out_srt,tr2(left,right),seq,local): PERSIST('persist::final_out_rld');

layout_prepped_for_keys Norm1 (layout_prepped_for_keys L,integer c) := transform
																
		// self.did                 :=(unsigned6)if(c=1,l.license1_did,l.license2_did);
		self.did                 :=(unsigned6)if(c=1,if(l.license1_did='',l.license2_did,l.license1_did)
																								,if(l.license2_did='',l.license1_did,l.license2_did));
		self.did_out             :=if(c=1,l.license1_did,l.license2_did);
		self.bdid                :=if(c=1,if(l.license1_bdid='',l.license2_bdid,l.license1_bdid)
																		 ,if(l.license2_bdid='',l.license1_bdid,l.license2_bdid));
		self.license1_did        :=if(c=1,l.license1_did,'');
		self.license2_did        :=if(c=1,'',l.license2_did);
		self.best_ssn            :=if(c=1,l.best_ssn,'');
		self.best_ssn2           :=if(c=1,'',l.best_ssn2);
		self.license1_bdid       :=if(c=1,l.license1_bdid,'');
		self.license2_bdid       :=if(c=1,'',l.license2_bdid);
    self.Business_Name       :=if(c=1,l.Business_cName,l.License1_cName);
    self.premise_prim_range  :=if(c=1,l.premise_prim_range,l.mail_prim_range);
		self.premise_predir      :=if(c=1,l.premise_predir,l.mail_predir);
		self.premise_prim_name   :=if(c=1,l.premise_prim_name,l.mail_prim_name);
		self.premise_suffix      :=if(c=1,l.premise_suffix,l.mail_suffix);
		self.premise_postdir     :=if(c=1,l.premise_postdir,l.mail_postdir);
		self.premise_unit_desig  :=if(c=1,l.premise_unit_desig,l.mail_unit_desig);
		self.premise_sec_range   :=if(c=1,l.premise_sec_range,l.mail_sec_range);
		self.premise_p_city_name :=if(c=1,l.premise_p_city_name,l.mail_p_city_name);
		self.premise_st          :=if(c=1,l.premise_st,l.mail_st);
		self.premise_zip         :=if(c=1,l.premise_zip,l.mail_zip);
		self.premise_zip4        :=if(c=1,l.premise_zip4,l.mail_zip4);
		self.ATF_id := HASH64(trim(l.license_number,left,right),
													trim(l.Lic_Regn,left,right),
													trim(l.Lic_Dist,left,right),
													trim(l.Lic_Cnty,left,right),
													trim(l.Lic_Type,left,right),
													trim(l.Lic_Xprdte,left,right),
													trim(l.License_Name,left,right),
													trim(l.Business_Name,left,right),
													trim(l.Premise_Street,left,right),
													trim(l.Premise_City,left,right),
													trim(l.Premise_State,left,right),
													trim(l.Premise_orig_Zip,left,right),
													trim(l.Mail_Street,left,right),
													trim(l.Mail_City,left,right),
													trim(l.Mail_State,left,right), 
													trim(l.Mail_Zip_Code,left,right),
													trim(l.Voice_Phone,left,right),
												trim(l.date_first_seen,left,right),
												trim(l.date_last_seen,left,right),
												trim(l.license1_title,left,right),
												trim(l.license1_fname,left,right),
												trim(l.license1_mname,left,right),
												trim(l.license1_lname,left,right),
												trim(l.license1_name_suffix,left,right),
												trim(l.license1_score,left,right),
												trim(l.license1_cname,left,right),
												trim(l.license2_title,left,right),
												trim(l.license2_fname,left,right),
												trim(l.license2_mname,left,right),
												trim(l.license2_lname,left,right),
												trim(l.license2_name_suffix,left,right),
												trim(l.license2_score,left,right),
												trim(l.license2_cname,left,right),
												trim(l.business_cname,left,right),
												trim(self.license1_did,left,right),
												trim(self.license2_did,left,right),
												trim(self.license1_bdid,left,right),
												trim(self.license2_bdid,left,right),
												trim(self.Business_Name,left,right),
												trim(self.premise_prim_range,left,right),
												trim(self.premise_predir,left,right),
												trim(self.premise_prim_name,left,right),
												trim(self.premise_suffix,left,right),
												trim(self.premise_postdir,left,right),
												trim(self.premise_unit_desig,left,right),
												trim(self.premise_sec_range,left,right),
												trim(self.premise_p_city_name,left,right),
												trim(self.premise_st,left,right),
												trim(self.premise_zip,left,right),
												trim(l.premise_geo_lat,left,right),
												trim(l.premise_geo_long,left,right),
												trim(l.premise_err_stat,left,right),
												trim(l.mail_prim_range,left,right),
												trim(l.mail_predir,left,right),
												trim(l.mail_prim_name,left,right),
												trim(l.mail_suffix,left,right),
												trim(l.mail_postdir,left,right),
												trim(l.mail_unit_desig,left,right),
												trim(l.mail_sec_range,left,right),
												trim(l.mail_p_city_name,left,right),
												trim(l.mail_v_city_name,left,right),
												trim(l.mail_st,left,right),
												trim(l.mail_zip,left,right),
												trim(l.mail_err_stat,left,right),
												c
													);
	self := L;
end;

final_out0 := normalize(final_out_rld, 2,Norm1(Left,counter)): PERSIST('persist::final_out_rld0');

final_out1 := sort(final_out0
											,record
												,except
														license1_did
														,best_ssn
														,license1_bdid
														,license2_did
														,best_ssn2
														,license2_bdid
														// ,bdid
														,bdid_score
														,ATF_id
														// ,did
														,d_score
														,did_out
														,local
														): PERSIST('persist::final_out_rld1');

layout_prepped_for_keys tr3(final_out1 l, final_out1 r) := transform
	self.license1_did  := if((unsigned)l.license1_did>0,l.license1_did,r.license1_did);
	self.license1_bdid := if((unsigned)l.license1_bdid>0,l.license1_bdid,r.license1_bdid);
	self.best_ssn      := if((unsigned)l.license1_did>0,l.best_ssn,r.best_ssn);
	self.license2_did  := if((unsigned)l.license2_did>0,l.license2_did,r.license2_did);
	self.license2_bdid := if((unsigned)l.license2_bdid>0,l.license2_bdid,r.license2_bdid);
	self.best_ssn2     := if((unsigned)l.license2_did>0,l.best_ssn2,r.best_ssn2);
	self.atf_id        := min(l.atf_id,r.atf_id);

	self := L;
end;

final_out := rollup(final_out1,tr3(left,right)
											,record
												,except
														license1_did
														,best_ssn
														,license1_bdid
														,license2_did
														,best_ssn2
														,license2_bdid
														// ,bdid
														,bdid_score
														,ATF_id
														// ,did
														,d_score
														,did_out
														,local
														);

export proc_prepped_for_keys := dedup(distribute(final_out,hash(atf_id)),atf_id,all,local)(date_first_seen<>'20121008');