import POE, Database_USA;

export As_POE(

	 dataset(Database_USA.Layouts.Base) pBase	= Database_USA.Files().Base.qa

) :=
function

	POE.Layouts.Base	tMapToPOE(Database_USA.Layouts.Base l) :=
	transform
		
		self.source								 				:=	l.source;
		self.did													:=	l.did;
		self.did_score										:= 	0;
		self.dt_first_seen								:=	l.dt_first_seen;
		self.dt_last_seen					 				:=	l.dt_last_seen;
		self.vendor_id										:= 	l.DBUSA_Business_ID + l.DBUSA_Executive_ID;
		self.subject_name.title						:=	l.title;
		self.subject_name.fname						:=	l.fname;
		self.subject_name.mname						:=	l.mname;
		self.subject_name.lname						:=	l.lname;
		self.subject_name.name_suffix			:=	l.name_suffix;
		self.subject_name.name_score			:=	l.name_score;
		self.subject_address.prim_range		:=	l.DB_cons_prim_range;
		self.subject_address.predir				:=	l.DB_cons_predir;
		self.subject_address.prim_name		:=	l.DB_cons_prim_name;
		self.subject_address.addr_suffix	:=	l.DB_cons_addr_suffix;
		self.subject_address.postdir			:=	l.DB_cons_postdir;
		self.subject_address.unit_desig		:=	l.DB_cons_unit_desig;
		self.subject_address.sec_range		:=	l.DB_cons_sec_range;
		self.subject_address.city_name		:=	l.DB_cons_v_city_name;
		self.subject_address.st						:=	l.DB_cons_st;
		self.subject_address.zip					:=	l.DB_cons_zip;
		self.subject_address.zip4					:=	l.DB_cons_zip4;
		self.subject_phone								:= 	(unsigned5)l.DB_Cons_Phone;
		self.subject_ssn									:= 	0;
		self.subject_dob									:= 	(unsigned4)trim(l.DB_Cons_Date_Of_Birth_Year+l.DB_Cons_Date_Of_Birth_Month,all);
		self.subject_job_title						:=	l.Standardized_Title;
		self.subject_rawaid 							:=	l.DB_cons_raw_aid;
		self.subject_aceaid 							:=	l.DB_cons_ace_aid;
		self.company_name					 				:=	l.Company_Name;
		self.company_address.prim_range		:=	l.phy_prim_range;
		self.company_address.predir				:=	l.phy_predir;
		self.company_address.prim_name		:=	l.phy_prim_name;
		self.company_address.addr_suffix	:=	l.phy_addr_suffix;
		self.company_address.postdir			:=	l.phy_postdir;
		self.company_address.unit_desig		:=	l.phy_unit_desig;
		self.company_address.sec_range		:=	l.phy_sec_range;
		self.company_address.city_name		:=	l.phy_v_city_name;
		self.company_address.st						:=	l.phy_st;
		self.company_address.zip					:= 	l.phy_zip;
		self.company_address.zip4					:= 	l.phy_zip4;
		self.company_phone								:= 	(unsigned5)l.phone;
		self.company_fein					 				:= 	0;
		self.company_rawaid				 				:= 	l.phy_raw_aid;
		self.company_aceaid				 				:= 	l.phy_ace_aid;
		self.record_sid										:=	l.record_sid;
		self.global_sid										:=	l.global_sid;										
		self															:= 	[];
	end;

	dMappedToPOE := project(pBase	,tMapToPOE(left));
	
	return dMappedToPOE;

end;