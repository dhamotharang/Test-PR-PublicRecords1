import RiskWise, doxie, Business_Risk;

export getBDIDTable(dataset(Business_Risk.Layout_Output) biid, doxie.IDataAccess mod_access) := FUNCTION

	bt := Business_Risk.Key_BDID_Table;
	brt := Business_Risk.key_BDID_Risk_Table;

	layout_out := record
		unsigned4  seq := 0;
		unsigned6 bdid := 0;
		Business_Risk.Layout_Profile_Risk_model;
	end;

	// Append BDID Table data
	ftable := join(biid, bt,
				keyed(left.bdid = right.bdid) and left.bdid!=0,
				transform(layout_out,  
						   self.cnt_d := IF(mod_access.use_DnB(), RIGHT.cnt_d, 0),
						   self.dnb_emps := IF(mod_access.use_DnB(), RIGHT.dnb_emps, 0),
						   self.dt_first_seen_D := IF(mod_access.use_DnB(), RIGHT.dt_first_seen_D, 0) ,
						   self.dt_last_seen_D  := IF(mod_access.use_DnB(), RIGHT.dt_last_seen_D, 0) ,
						   self:=left, self:=right),
				left outer, ATMOST(keyed(left.bdid = right.bdid), RiskWise.max_atmost), keep(1));
	
	layout_out add_bdid_risk(ftable le, brt rt) := transform
		self.PRScore := rt.PRScore;
		self.PRScore_date := rt.PRScore_date;
		self.busreg_flag := rt.busreg_flag;
		self.corp_flag := rt.corp_flag;
		self.dnb_flag := IF(mod_access.use_DnB(), rt.dnb_flag, 0);
		self.irs5500_flag := rt.irs5500_flag;
		self.st_flag := rt.st_flag;
		self.ucc_flag := rt.ucc_flag;
		self.yp_flag := rt.yp_flag;
		self.tier1srcs := rt.tier1srcs;
		self.t1scr5 := rt.t1scr5;
		self.currphn := rt.currphn;
		self.currcorp := rt.currcorp;
		self.currbr := rt.currbr;
		self.currdnb := IF(mod_access.use_DnB(), rt.currdnb, 0 );
		self.currucc := rt.currucc;
		self.curry := rt.curry;
		self.currt1cnt := rt.currt1cnt;
		self.currt1src4 := rt.currt1src4;
		self.year_lj := rt.year_lj;
		self.lj := rt.lj;
		self.ustic := rt.ustic;
		self.t1x := rt.t1x;
		self.OFAC_cnt := rt.OFAC_cnt;
		self := le;	
	end;
	
	// Append profile risk score
	fscores := join(ftable, brt,
				 keyed(left.bdid=right.bdid) and left.bdid!=0,
				 add_bdid_risk(left,right),
				 left outer, ATMOST(keyed(left.bdid=right.bdid), RiskWise.max_atmost), keep(1));


	return fscores;
end;
