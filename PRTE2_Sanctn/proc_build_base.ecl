import prte2_sanctn, prof_license_mari, prte2,std, address, PromoteSupers, ut, aid;

//uppercase and remove spaces from in files
	PRTE2.CleanFields(files.incident_in, CleanIncident);
	PRTE2.CleanFields(files.party_in, CleanParty);
	PRTE2.CleanFields(files.license_in, CleanLicense);
	PRTE2.CleanFields(files.party_aka_dba_in, CleanPartyAKA);
	PRTE2.CleanFields(files.rebuttal_in, CleanRebuttal);

	
	tempLayout := record
	PRTE2_sanctn.Layouts.party_ext;
	string dummy;
	end;
	
	df := project(CleanParty(cust_name != ''), transform(tempLayout, self := left, self := []));
	
	dAddressCleaned := PRTE2.AddressCleaner(df,
																				['inaddress'],
																				['dummy'], //blank field, not used but passed for attribute purposes
																				['inCity'],
																				['inState'],
																				['inZip'],
																				['clean_address'],
																				['addr_rawaid']
																				);

prte2_sanctn.layouts.party_ext xform_clean(dAddressCleaned l) := transform
		//Cleaning Full Name
		  	is_company      			:= L.Party_Name[1..25] = L.Party_Firm[1..25];
				
				v_clean_name						:= if(not(is_company), Address.CleanPersonLFM73(L.party_name), '');
			
			// Reforrmattin Names that did not clean correctly the initial pass
				v_last_name 					:= trim(l.party_name[1..STD.Str.Find(l.party_name, ', ', 1)-1], right);
				v_first_mid						:= trim(l.party_name[STD.Str.Find(l.party_name, ', ', 1)+2..],left,right);		
				v_full_fml						:= v_first_mid +' '+ v_last_name;
				
				is_match							:= trim(l.party_name[1..STD.Str.Find(l.party_name, ', ', 1)-1], right) = trim(Address.CleanNameFields(v_clean_name).lname, right);
				clean_name						:= if(is_match and not(is_company), v_clean_name, Address.CleanPersonFML73(v_full_fml));
				
				self.title 						:= Address.CleanNameFields(clean_name).title;
				self.fname 						:= Address.CleanNameFields(clean_name).fname;
				self.mname 						:= Address.CleanNameFields(clean_name).mname;
				self.lname 						:= Address.CleanNameFields(clean_name).lname;
				self.name_suffix      := Address.CleanNameFields(clean_name).name_suffix;
				self.cname						:= if(is_company, l.party_firm, l.party_firm);
		
		//Clean Addressess		
				SELF.prim_range  :=  l.clean_address.prim_range;
				SELF.predir      :=  l.clean_address.predir;
				SELF.prim_name   :=  l.clean_address.prim_name;
				SELF.addr_suffix :=  l.clean_address.addr_suffix;
				SELF.postdir     :=  l.clean_address.postdir;
				SELF.unit_desig  :=  l.clean_address.unit_desig;
				SELF.sec_range   :=  l.clean_address.sec_range;
				SELF.p_city_name :=  l.clean_address.p_city_name;
				SELF.v_city_name :=  l.clean_address.v_city_name;
				SELF.st        	 :=  l.clean_address.st;
				SELF.zip5     	 :=  l.clean_address.zip;
				SELF.zip4	       :=	 l.clean_address.zip4;
				SELF.cart	       :=	 l.clean_address.cart;
				SELF.cr_sort_sz	 :=	 l.clean_address.cr_sort_sz;
				SELF.lot	       :=	 l.clean_address.lot;
				SELF.lot_order	 :=	 l.clean_address.lot_order;
				SELF.dpbc	       :=	 l.clean_address.dbpc;
				SELF.chk_digit	 :=	 l.clean_address.chk_digit;
				SELF.addr_rec_type	   :=	 l.clean_address.rec_type;
				SELF.fips_state 	:= l.clean_address.fips_state;
				SELF.fips_county	:=	 l.clean_address.fips_county;
				SELF.geo_lat	   :=	 l.clean_address.geo_lat;
				SELF.geo_long	   :=	 l.clean_address.geo_long;
				SELF.geo_blk	   :=	 l.clean_address.geo_blk;
				SELF.geo_match	 :=	 l.clean_address.geo_match;
				SELF.err_stat	   :=	 l.clean_address.err_stat;
				self 	:= l.clean_address;
				self.ssn_appended := if(L.cust_name = 'LN_PR' and l.link_ssn <> '', L.link_ssn, L.ssn_appended);
				self	:= l;
				self := [];
	end;

	dfParty := PROJECT(dAddressCleaned, xform_clean(left));
						    
																												
//Append ID(s)
layouts.party_ext		appendId(dfParty L) := transform
		self.did := prte2.fn_AppendFakeID.did(L.fname, L.lname, L.link_ssn, L.link_dob, L.cust_name);
		self.bdid:= prte2.fn_AppendFakeID.bdid(L.cname,	L.prim_range,	L.prim_name, L.v_city_name, L.st, L.zip5, L.cust_name);
		
		vLinkingIds := prte2.fn_AppendFakeID.LinkIds(L.cname, L.link_fein, L.link_inc_date, L.prim_range, L.prim_name, L.sec_range, L.v_city_name, L.st, L.zip5, L.cust_name);
	  self.powid	:= vLinkingIds.powid;
	  self.proxid	:= vLinkingIds.proxid;
	  self.seleid	:= vLinkingIds.seleid;
	  self.orgid	:= vLinkingIds.orgid;
	  self.ultid	:= vLinkingIds.ultid;
	  self := L;
		self := [];
END;

pPartyBase	:= PROJECT(dfParty, appendId(LEFT)) + 
								PROJECT(CleanParty(cust_name = ''), transform(Layouts.party_ext, self := left));;


Layouts.Incident_ext  CleanDates(CleanIncident L) := transform
		self.incident_date_clean	:= if(L.INCIDENT_DATE = '', '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(trim(L.INCIDENT_DATE,left,right)));
		self.fcr_date_clean			  := if(L.FCR_DATE= '','',Prof_License_Mari.DateCleaner.ToYYYYMMDD(trim(L.FCR_DATE,left,right)));
	  self.cln_modified_date    := if(L.MODIFIED_DATE = '','',Prof_License_Mari.DateCleaner.ToYYYYMMDD(trim(L.MODIFIED_DATE,left,right)));
	  self.cln_load_date			  := if(L.LOAD_DATE = '','',Prof_License_Mari.DateCleaner.ToYYYYMMDD(trim(L.LOAD_DATE,left,right)));
		self := L;
		self := [];
end;

pIncidentBase := project(CleanIncident, cleanDates(left));


layouts.License_ext	cleanLic(CleanLicense L) := transform
	 self.CLN_LICENSE_NUMBER 	:= Prof_license_mari.fCleanLicenseNbr(STD.Str.ToUpperCase(L.LICENSE_NUMBER));
	 self.std_type_desc := L.license_type;
	 self    := L;
	 self    := [];
end;		
pLicenseBase := project(CleanLicense, cleanLic(left));


pRebuttal := project(CleanPartyAKA, transform(layouts.Rebuttal_ext, self := left, self := []));
pPartyAka := project(CleanPartyAKA, layouts.Party_AKA_DBA_ext);

PromoteSupers.MAC_SF_BuildProcess(pPartyBase, Constants.base_prefix_name + 'party', bld_base_party,,,true);
PromoteSupers.MAC_SF_BuildProcess(pIncidentBase, Constants.base_prefix_name + 'incident', bld_base_incident,,,true);
PromoteSupers.MAC_SF_BuildProcess(pLicenseBase, Constants.base_prefix_name + 'license', bld_base_license,,,true);
PromoteSupers.MAC_SF_BuildProcess(pPartyAka, Constants.base_prefix_name + 'party_aka_dba', bld_base_party_aka,,,true);
PromoteSupers.MAC_SF_BuildProcess(pRebuttal, Constants.base_prefix_name + 'rebuttal', bld_base_rebuttal,,,true);


EXPORT proc_build_base := sequential(bld_base_party, bld_base_incident, bld_base_license, bld_base_party_aka, bld_base_rebuttal);

