import  address, did_add, ut;


df := business_risk.File_Sample;

business_risk.Layout_Input into_in(df L) := transform
	self.account := (integer)L.account;
	self.company_name := L.company;
	self.alt_company_name := L.dbaname;
	self.fein := L.fein;
	self.phone10 := L.cmpyphn1;
	self.ip_addr := L.website;
	self.rep_fname := L.firstname;
	self.rep_mname := '';
	self.rep_lname := L.lastname;
	self.rep_name_suffix := '';
	self.rep_alt_lname := '';
	self.rep_ssn := L.social;
	self.rep_dob := L.dob;
	self.rep_age := if (L.dob != '', (string)ut.GetAge(L.dob), '');
	self.rep_dl_num := L.drlc;
	self.rep_dl_state := L.drlcst;
	self.rep_phone := L.homephone;
	self.rep_email := L.email;
	bizaddr := addrcleanlib.cleanaddress183(L.cmpyaddr, address.Addr2FromComponents(L.cmpycity, L.cmpystate, L.cmpyzip));
	self.prim_range 	:= bizaddr[1..10];
	self.predir		:= bizaddr[11..12];
	self.prim_name		:= bizaddr[13..40];
	self.addr_suffix	:= bizaddr[41..44];
	self.postdir		:= bizaddr[45..46];
	self.unit_desig 	:= bizaddr[47..56];
	self.sec_range		:= bizaddr[57..64];
	self.p_city_name	:= bizaddr[65..89];
	self.st			:= bizaddr[115..116];
	self.z5			:= bizaddr[117..121];
	self.zip4			:= bizaddr[122..125];
	self.lat		 	:= bizaddr[146..155];
	self.long		 	:= bizaddr[156..166];
	self.addr_type  	:= bizaddr[183];
	self.addr_status 	:= bizaddr[179..182];
	repaddr := addrcleanlib.cleanaddress182(L.address, address.Addr2FromComponents(L.city, L.state, L.zip));
	self.rep_prim_range 	:= repaddr[1..10];
	self.rep_predir		:= repaddr[11..12];
	self.rep_prim_name		:= repaddr[13..40];
	self.rep_addr_suffix	:= repaddr[41..44];
	self.rep_postdir		:= repaddr[45..46];
	self.rep_unit_desig 	:= repaddr[47..56];
	self.rep_sec_range		:= repaddr[57..64];
	self.rep_p_city_name	:= repaddr[65..89];
	self.rep_st			:= repaddr[115..116];
	self.rep_z5			:= repaddr[117..121];
	self.rep_zip4			:= repaddr[122..125];
end;

df2 := project(df, into_in(LEFT));

#stored('roxie_regression_system','dev');

business_risk.Mac_InstID_Roxie(df2,outf,'1','1',false)

output(outf,,'~thor_data50::cjmtemp::busInstId_sample443',overwrite);
