IMPORT  PRTE2_GSA,PromoteSupers, address, prte2;

EXPORT PROC_BUILD_BASE := FUNCTION

	layouts.Layout_Base xform(Files.gsa_in l) := transform
		addr1 := l.street1 + ' ' + l.street2 + ' ' + l.street3;
		addrlast := l.city + ', ' + l.state + ' ' + l.zip;
		addrclean182 := address.CleanAddress182(addr1, addrlast);
		addrfields := address.CleanAddressFieldsFips(addrclean182).addressrecord;
		fullname := address.CleanPersonFML73_fields(if (l.ssn != '',l.name,''));
		self.prim_range:=addrfields.prim_range;
		self.predir:=addrfields.predir;
		self.prim_name:=addrfields.prim_name;
		self.addr_suffix:=addrfields.addr_suffix;
		self.postdir:=addrfields.postdir;
		self.unit_desig:=addrfields.unit_desig;
		self.sec_range:=addrfields.sec_range;
		self.p_city_name:=addrfields.p_city_name;
		self.v_city_name:=addrfields.v_city_name;
		self.st:=addrfields.st;
		self.zip5:=addrfields.zip;
		self.zip4:=addrfields.zip4;
		self.cart:=addrfields.cart;
		self.cr_sort_sz:=addrfields.cr_sort_sz;
		self.lot:=addrfields.lot;
		self.lot_order:=addrfields.lot_order;
		self.dbpc:=addrfields.dbpc;
		self.chk_digit:=addrfields.chk_digit;
		self.rec_type:=addrfields.rec_type;
		self.geo_lat:=addrfields.geo_lat;
		self.geo_long:=addrfields.geo_long;
		self.msa:=addrfields.msa;
		self.geo_blk:=addrfields.geo_blk;
		self.geo_match:=addrfields.geo_match;
		self.err_stat:=addrfields.err_stat;
		self.title := fullname.title;
		self.fname := fullname.fname;
		self.mname := fullname.mname;
		self.lname := fullname.lname;
		self.name_suffix := fullname.name_suffix;
		self.name_score := fullname.name_score;
		self.county := addrfields.fips_county;
		SELF.append_rawaid := 0;
		SELF.append_aceaid := 0;
		self.bdid := 0;// prte2.fn_AppendFakeID.bdid(l.fein, l.inc_date, l.cust_name);
		self.did :=  prte2.fn_AppendFakeID.did(fullname.fname, fullname.lname, l.ssn, l.dob, l.cust_name);
		self.cust_name := l.cust_name;
		self.bug_num := l.bug_num;
		self := l;
	end;
	
	df_gsa := PROJECT(Files.gsa_in, xform(left));

	PromoteSupers.MAC_SF_BuildProcess(df_gsa, '~PRTE::BASE::gsa', writefile_gsa);

	sequential(writefile_gsa);

	Return 'success';
END;