/*import uccd, gong, edgar, ut;

rec := bdid_regression.Layout_Common;

//U is for UCC Party recs, which have some address and some FEIN
u_in := choosen(uccd.File_UCC_Party_In, 10000);

rec utra(u_in l) := transform
	self.source := 'U';
	self.name := l.name;
	self.fein := l.fein;
	self.phone10 := '';

	self.prim_range := l.address1_prim_range;
	self.predir := l.address1_predir;
	self.prim_name := l.address1_prim_name;
	self.addr_suffix := l.address1_addr_suffix;
	self.postdir := l.address1_postdir;
	self.unit_desig := l.address1_unit_desig;
	self.sec_range := l.address1_sec_range;
	self.p_city_name := l.address1_p_city_name;
	self.st := l.address1_st;
	self.z5 := l.address1_zip;
	self.zip4 := l.address1_zip4;
end;

u_prep := project(u_in, utra(left));

//G is for Gong recs, which have some phone and some address
g_in := gong.File_Gong_full(listing_type_bus<>'',publish_code IN ['P','U']);

rec gtra(g_in l) := transform
	self.source := 'G';
	self.name := l.listed_name;
	self.fein := '';
	self.phone10 := l.phone10;

	self.prim_range := l.prim_range;
	self.predir := l.predir;
	self.prim_name := l.prim_name;
	self.addr_suffix := l.suffix;
	self.postdir := l.postdir;
	self.unit_desig := l.unit_desig;
	self.sec_range := l.sec_range;
	self.p_city_name := l.p_city_name;
	self.st := l.st;
	self.z5 := l.z5;
	self.zip4 := l.z4;
end;

g_prep := project(choosen(g_in((integer)phone10 > 5555555555), 5000), gtra(left)) + 
					project(choosen(g_in((integer)phone10 = 0), 5000), gtra(left));


//E is for Edgar, which have phone and address
e_in := edgar.File_Edgar_Company_Base;

rec etra(e_in l, boolean justname) := transform
	self.source := 'E';
	self.name := l.companyName;
	self.fein := if(~justname, l.taxid, '');
	self.phone10 := if(~justname, stringlib.StringFilterOut(l.busphone, '-()'), '');

	self.prim_range := if(~justname, l.bus_prim_range, '');
	self.predir := if(~justname, l.bus_predir, '');
	self.prim_name := if(~justname, l.bus_prim_name, '');
	self.addr_suffix := if(~justname, l.bus_addr_suffix, '');
	self.postdir := if(~justname, l.bus_postdir, '');
	self.unit_desig := if(~justname, l.bus_unit_desig, '');
	self.sec_range := if(~justname, l.bus_sec_range, '');
	self.p_city_name := if(~justname, l.bus_p_city_name, '');
	self.st := if(~justname, l.bus_st, '');
	self.z5 := if(~justname, l.bus_zip, '');
	self.zip4 := if(~justname, l.bus_zip4, '');
end;

e_prep := project(choosen(e_in, 3000), etra(left, true)) + 
				  project(choosen(e_in, 7000), etra(left, false));

prep := distribute(u_prep + g_prep + e_prep, random());

ut.MAC_Sequence_Records(prep, rid, prep_id)

//output(prep_id,,'BASE::BDID_Reg_Common_Prep', overwrite);*/

export Common_Prep := dataset('~thor_hank::BASE::BDID_Reg_Common_Prep', bdid_regression.Layout_Common, flat);