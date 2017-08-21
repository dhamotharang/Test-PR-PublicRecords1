import _Control, ut;

export DesprayFiles(
										dataset(Layouts.Base)				pUpdateFile,
										dataset(Layouts.Base)				pBaseFile,										
										string pversion
									) := function

	layouts.output_slim getNewSlimFile(pBaseFile l, pUpdateFile r) := transform
		self.company_name					:= ut.fntrim2upper(l.company_name);
		self.company_street				:= ut.fntrim2upper(l.prim_range + l.predir + l.prim_name + l.addr_suffix + l.postdir + l.unit_desig + l.sec_range);
		self.company_city					:= ut.fntrim2upper(l.p_city_name);
		self.company_st						:= ut.fntrim2upper(l.st);
		self.company_zip					:= ut.fntrim2upper(l.zip);
		self.company_zip4					:= ut.fntrim2upper(l.zip4);
		self.company_fein					:= ut.fntrim2upper(l.company_fein);
		self.contact_fname				:= ut.fntrim2upper(l.fname);
		self.contact_mname				:= ut.fntrim2upper(l.mname);
		self.contact_lname				:= ut.fntrim2upper(l.lname);
		self.dotid								:= l.dotid;
		self.empid								:= l.empid;
		self.powid								:= l.powid;
		self.proxid								:= l.proxid;
		self.seleid								:= l.seleid;
		self.lgid3								:= l.lgid3;
		self.orgid								:= l.orgid;
		self.ultid								:= l.ultid;
		self.company_bdid					:= l.company_bdid;
		self.contact_did					:= l.contact_did;
		self											:= l;
	end;

	newSlimFile := join(pBaseFile,pUpdateFile,
											left.company_name  	 = right.company_name 	and
											left.prim_range  		 = right.prim_range			and
											left.predir  		 		 = right.predir					and
											left.prim_name  		 = right.prim_name			and
											left.addr_suffix  	 = right.addr_suffix		and
											left.postdir  		 	 = right.postdir				and
											left.unit_desig  		 = right.unit_desig			and
											left.sec_range  		 = right.sec_range			and											
											left.p_city_name  	 = right.p_city_name 		and
											left.st  		 				 = right.st 						and
											left.zip  	 				 = right.zip 						and
											left.zip4    				 = right.zip4 					and
											left.company_fein    = right.company_fein 	and
											left.fname  				 = right.fname 					and
											left.mname   				 = right.mname 				  and
											left.lname   				 = right.lname,									
											getNewSlimFile(left,right),
											inner
											);

	create_updated_slim_file := output(newSlimFile,,_Dataset().thor_cluster_files+_Dataset().name+'::'+pversion+'::updated_slim.csv',csv(separator(['|'])),overwrite,compressed);

	despray_file	 := sequential( create_updated_slim_file,
																fileservices.despray(_Dataset().thor_cluster_files+_Dataset().name+'::'+pversion+'::updated_slim.csv'                                   
																									   ,PRTE_BIP._Constants().sServerIP
																									   ,PRTE_BIP._Constants().sDirectory + regexreplace('~',_Dataset().thor_cluster_files,'')+_Dataset().name+'::'+pversion + '::updated_slim.csv'
																									   ,,,
																									   ,true)
															);
	return despray_file;

end;