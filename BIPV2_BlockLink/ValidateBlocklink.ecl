import BIPV2; 
EXPORT ValidateBlocklink := module

export ProxidBlocklink(dataset(BIPV2_Blocklink.ManualOverlinksPROXID.reducedlayout) cands_file, 
									dataset(BIPV2.CommonBase.layout) base=BIPV2.CommonBase.ds_built) :=function
			 
				J:=JOIN(base, cands_file,							
											left.cnp_name=right.cnp_name and
											left.cnp_number=right.cnp_number  and
											left.cnp_btype=right.cnp_btype  and
											left.prim_range_derived=right.prim_range_derived  and
											left.prim_name_derived=right.prim_name_derived  and
											left.sec_range=right.sec_range  and
											left.v_city_name=right.v_city_name  and
											left.st=right.st  and
											left.zip=right.zip  and
											left.active_duns_number=right.active_duns_number  and
											left.hist_duns_number=right.hist_duns_number  and
											left.active_enterprise_number=right.active_enterprise_number  and
											left.hist_enterprise_number=right.hist_enterprise_number  and
											left.ebr_file_number=right.ebr_file_number  and
											left.active_domestic_corp_key=right.active_domestic_corp_key  and
											left.hist_domestic_corp_key=right.hist_domestic_corp_key  and
											left.foreign_corp_key=right.foreign_corp_key  and
											left.unk_corp_key=right.unk_corp_key  and
											//left.source=right.source  and
											left.company_fein=right.company_fein  and
											left.company_phone=right.company_phone,
											transform({boolean good, unsigned6 proxid,unsigned6 seleid,unsigned6 lgid3},
											           self.good:=right.good,
																 self:=left), lookup);
																 
					J1:=dedup(J,good,proxid,seleid,lgid3,all);								 
					J_good:=J1(good=TRUE);
					J_bad:= J1(good=FALSE);

					output(J_good,named('prox_good_part'));
					output(J_bad,named('prox_bad_part'));
					Final:=Join(J_good,J_bad,left.lgid3=right.lgid3 or left.seleid=right.seleid or left.proxid=right.proxid,
					            transform({recordof(left)}, self:=left),ALL);
			 return Final;
	end;
	
	export Lgid3Blocklink(dataset(BIPV2_Blocklink.ManualOverlinksLGID3.reducedlayout) cands_file, 
									dataset(BIPV2.CommonBase.layout) base=BIPV2.CommonBase.ds_built) :=function
			 
				J:=JOIN(base, cands_file,							
											//left.Lgid3IfHrchy=right.Lgid3IfHrchy and
											left.company_name=right.company_name  and
											left.cnp_number=right.cnp_number  and
											left.active_duns_number=right.active_duns_number  and
											left.duns_number=right.duns_number  and
											left.company_fein=right.company_fein  and
											left.company_inc_state=right.company_inc_state  and
											left.company_charter_number=right.company_charter_number  and
											left.cnp_btype=right.cnp_btype,
											transform({boolean good, unsigned6 proxid,unsigned6 seleid,unsigned6 lgid3},
											           self.good:=right.good,
																 self:=left), lookup);
																 
					J1:=dedup(J,good,proxid,seleid,lgid3,all);								 
					J_good:=J1(good=TRUE);
					J_bad:= J1(good=FALSE);

					output(J_good,named('lgid3_good_part'));
					output(J_bad,named('lgid3_bad_part'));
					Final:=Join(J_good,J_bad,left.lgid3=right.lgid3 or left.seleid=right.seleid or left.proxid=right.proxid,
					            transform({recordof(left)}, self:=left),ALL);
			 return Final;
	end;
end;