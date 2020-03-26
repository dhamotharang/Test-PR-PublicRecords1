//	Summary:			PROC_BUILD_BASE for the PRTE DEA process based originally from the DEA module

IMPORT  PRTE2_DEA,PromoteSupers,prte2, ut, std, address, aid;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION
	prte2.CleanFields(prte2_dea.files.DEA_IN, dea_Clean);		
	dea_new := dea_Clean(cust_name != '');
  dea_old := dea_Clean(cust_name = '');
	
	dea_new_clean_address := PRTE2.AddressCleaner(		dea_new, 					// Record set with addresses to be cleaned
																										['address3'],  			// Set of fields containing address line 1
																										['citystatezip'],  			// Set of fields containing address line 2
																										['address4'],										 			// Set of fields containing city
																										['state'],										 			// Set of fields containing state
																										['zip_code'],										 			// Set of fields containing zip
																										['clean_address'],		 			// Target fields for Address.Layout_Clean182_fips	
																										['admin_rawaid']) ;	   			// Target fields for rawaids
																							
	Layouts.Layout_DEA_OUT_baseV2 xform_dea(dea_new_clean_address l) := Transform 
	self.cname:=l.address1;
	
	inName:=L.Address2;
	v_lname := trim(inName[1..STD.Str.Find(inName, ',', 1) -1], right);
								v_fmid := trim(std.str.filterout(trim(inName[STD.Str.Find(inName, ',', 1)..], right),','), left,right);
								v_fname := trim(v_fmid[1..STD.Str.Find(v_fmid, ' ', 1) -1], right);
								v_mname := trim(v_fmid[length(v_fname)+1..], left,right);
								

self.fname                     := v_fname;
self.mname          					 := v_mname;        
self.lname            				 := v_lname;

 		self := l.clean_address;
		self.bd						:= IF(trim(l.cname) != '', Prte2.fn_AppendFakeID.bdid(l.cname, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip, L.cust_name),0);
		self.bdid := (string)self.bd;
		//self.did := (string12)prte2.fn_AppendFakeID.did(l.fname, l.lname, l.link_ssn, l.link_dob, l.cust_name);
		self.did := (string12)prte2.fn_AppendFakeID.did(self.fname, self.lname, l.link_ssn, l.link_dob, l.cust_name);
		my_did := self.did;
		vLinkingIds := Prte2.fn_AppendFakeID.LinkIds(L.cname, L.link_fein, L.link_inc_date, L.prim_range, L.prim_name, L.sec_range, L.v_city_name, L.st, L.zip, L.cust_name);
		self.powid	:= vLinkingIds.powid;
		self.proxid	:= vLinkingIds.proxid;
		self.seleid	:= vLinkingIds.seleid;
		self.orgid	:= vLinkingIds.orgid;
		self.ultid	:= vLinkingIds.ultid;
		self := l;
	end;
	
	dea_clean_new := PROJECT(	dea_new_clean_address, xform_dea(left));
	dea_old_prepped := PROJECT( dea_old, layouts.Layout_DEA_OUT_baseV2);

  dea_combined := dea_clean_new + dea_old_prepped;
	
	PromoteSupers.MAC_SF_BuildProcess(dea_combined,constants.dea_base, writefile)
	
	Return writefile;

END;