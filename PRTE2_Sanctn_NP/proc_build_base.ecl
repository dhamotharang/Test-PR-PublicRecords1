import prte2_sanctn_np, prof_license_mari, prte2,std, address, PromoteSupers, ut, aid;


//uppercase and remove spaces from in files
	PRTE2.CleanFields(files.incident_in, CleanIncident);
	PRTE2.CleanFields(files.incidentcode_in, CleanIncidentCode);
	PRTE2.CleanFields(files.incidenttext_in, CleanIncidentText);
	PRTE2.CleanFields(files.party_in, CleanParty);
	PRTE2.CleanFields(files.partytext_in, CleanPartyText);
	PRTE2.CleanFields(files.party_aka_dba_in, CleanPartyAKA);
	
	
	tempCombineLayout := record
		STRING100 inADDRESS;				
		STRING45 	inCITY;        	
		STRING2 	inSTATE;      		
		STRING10 	inZIP;
		string1		file_type;
		string dummy;
	end;
	
	dsNewIncident := CleanIncident(cust_name != '');
	dsNewParty 		:= CleanParty(cust_name != '');

	dfIncident 	:= project(dsNewIncident(prop_addr <> ''), transform(tempCombineLayout, 
												  self.inAddress	:= left.prop_Addr;
												  self.inCity			:= left.prop_City;
													self.inState		:= left.prop_State;
													self.inZip			:= left.prop_Zip;
													self.file_type 	:= 'A';
													self := left, 
													self := []));
													

																																	
	dfParty 		:= project(dsNewParty(address <> ''), transform(tempCombineLayout, 
													self.inAddress	:= left.Address;
													self.inCity			:= left.City;
													self.inState		:= left.State;
													self.inZip			:= left.Zip;
													self.file_type	:= 'P';
													self := left, 
													self := []));
	
	// dfParty;
	dCombinedAddress	:= dfIncident + dfParty;
	
	dAddressCleaned := PRTE2.AddressCleaner(dCombinedAddress,
																					['inaddress'],
																					['dummy'], //blank field, not used but passed for attribute purposes
																					['inCity'],
																					['inState'],
																					['inZip'],
																					['clean_address'],
																					['addr_rawaid']
																					);

// Incident New Records
	jIncident	:= join(dsNewIncident, dAddressCleaned,
										 left.prop_Addr	= right.inAddress and
										 left.prop_City			= right.inCity and
										 left.prop_State		= right.inState and
										 left.prop_Zip			= right.inZip and
										 right.file_type = 'A',
										 transform(layouts.incident_base,
										 //Clean Addressess
															SELF.prim_range  :=  right.clean_address.prim_range;
															SELF.predir      :=  right.clean_address.predir;
															SELF.prim_name   :=  right.clean_address.prim_name;
															SELF.addr_suffix :=  right.clean_address.addr_suffix;
															SELF.postdir     :=  right.clean_address.postdir;
															SELF.unit_desig  :=  right.clean_address.unit_desig;
															SELF.sec_range   :=  right.clean_address.sec_range;
															SELF.p_city_name :=  right.clean_address.p_city_name;
															SELF.v_city_name :=  right.clean_address.v_city_name;
															SELF.st        	 :=  right.clean_address.st;
															SELF.zip5     	 :=  right.clean_address.zip;
															SELF.zip4	       :=	 right.clean_address.zip4;
															SELF.addr_rec_type	   :=	 right.clean_address.rec_type;
															self := right.clean_address;
															self := left;
															self := [];
															));


// New Party Records
	jParty	:= join(dsNewParty, dAddressCleaned,
										 left.Address	= right.inAddress and
										 left.City		= right.inCity and
										 left.State		= right.inState and
										 left.Zip			= right.inZip and
										 right.file_type = 'P',
										 transform(layouts.party_base,
										 //Clean Addressess
															SELF.prim_range  :=  right.clean_address.prim_range;
															SELF.predir      :=  right.clean_address.predir;
															SELF.prim_name   :=  right.clean_address.prim_name;
															SELF.addr_suffix :=  right.clean_address.addr_suffix;
															SELF.postdir     :=  right.clean_address.postdir;
															SELF.unit_desig  :=  right.clean_address.unit_desig;
															SELF.sec_range   :=  right.clean_address.sec_range;
															SELF.p_city_name :=  right.clean_address.p_city_name;
															SELF.v_city_name :=  right.clean_address.v_city_name;
															SELF.st        	 :=  right.clean_address.st;
															SELF.zip5     	 :=  right.clean_address.zip;
															SELF.zip4	       :=	 right.clean_address.zip4;
															SELF.addr_rec_type	   :=	 right.clean_address.rec_type;
															self.aid				:= right.addr_rawaid;
															self := right.clean_address;
															self := left;
															self := [];
															));



prte2_sanctn_np.Layouts.incident_base		xformIncident(jIncident l) := transform
		clean_name := if(L.SUBMITTER_NAME <> '',Address.CleanPersonLFM73(L.SUBMITTER_NAME), '');
			self.title 						:= Address.CleanNameFields(clean_name).title;
			self.fname 						:= Address.CleanNameFields(clean_name).fname;
			self.mname 						:= Address.CleanNameFields(clean_name).mname;
			self.lname 						:= Address.CleanNameFields(clean_name).lname;
			self.name_suffix      := Address.CleanNameFields(clean_name).name_suffix;
			self.cname						:= L.member_name;
			self.did := prte2.fn_AppendFakeID.did(self.fname, self.lname, L.link_ssn, L.link_dob, L.cust_name);
			self.bdid:= prte2.fn_AppendFakeID.bdid(self.cname,	L.prim_range,	L.prim_name, L.v_city_name, L.st, L.zip5, L.cust_name);
		
			vLinkingIds := prte2.fn_AppendFakeID.LinkIds(self.cname, L.link_fein, L.link_inc_date, L.prim_range, L.prim_name, L.sec_range, L.v_city_name, L.st, L.zip5, L.cust_name);
			self.powid	:= vLinkingIds.powid;
			self.proxid	:= vLinkingIds.proxid;
			self.seleid	:= vLinkingIds.seleid;
			self.orgid	:= vLinkingIds.orgid;
			self.ultid	:= vLinkingIds.ultid;
			self.submitter_email := STD.Str.FindReplace(trim(L.submitter_email,left,right),' ','.');
			self := L;
end;			
			
dsIncident := PROJECT(dedup(jIncident, record), xformIncident(left)) +
										PROJECT(CleanIncident(cust_name = ''), transform(prte2_sanctn_np.Layouts.incident_base, self := left));			
		


//Appending IDS9s)
prte2_sanctn_np.layouts.party_base xformParty(jParty l) := transform
		//Cleaning Full Name
				self.title 						:= '';
				self.fname 						:= L.name_first;
				self.mname 						:= L.name_middle;
				self.lname 						:= L.name_last;
				self.name_suffix      := L.suffix;
				self.cname						:= If(L.party_firm <> '', L.party_firm, L.party_employer);
				self.ename						:= L.party_employer;
				self.ssn							:= if(L.ssn <> '', L.ssn, L.link_ssn);
				self.dob							:= if(L.dob <> '', L.dob, L.link_dob);
				self.tin							:= if(L.tin <> '', L.tin, L.link_fein);
				
				self.did := prte2.fn_AppendFakeID.did(self.fname, self.lname, L.link_ssn, L.link_dob, L.cust_name);
				self.bdid:= prte2.fn_AppendFakeID.bdid(self.cname,	L.prim_range,	L.prim_name, L.v_city_name, L.st, L.zip5, L.cust_name);
		
				vLinkingIds := prte2.fn_AppendFakeID.LinkIds(self.cname, L.link_fein, L.link_inc_date, L.prim_range, L.prim_name, L.sec_range, L.v_city_name, L.st, L.zip5, L.cust_name);
				self.powid	:= vLinkingIds.powid;
				self.proxid	:= vLinkingIds.proxid;
				self.seleid	:= vLinkingIds.seleid;
				self.orgid	:= vLinkingIds.orgid;
				self.ultid	:= vLinkingIds.ultid;
				self.enh_did_src := 'N';				//Ehanced did source; M for Mari, S for SANCTN, N for SANCTN Non-public
				self := L;
				self := [];
				
	end;

	dsParty := PROJECT(dedup(jParty, record), xformParty(left)) +
								PROJECT(CleanParty(cust_name = ''), transform(prte2_sanctn_np.layouts.party_base, self := left));
						    
	


layouts.incidentcode_base	cleanLic(CleanIncidentCode L) := transform
	 self.CLN_LICENSE_NUMBER 	:= Prof_license_mari.fCleanLicenseNbr(STD.Str.ToUpperCase(L.code_value));
	 self.std_type_desc := L.code_type;
	 self    := L;
	 self    := [];
end;		
pLicenseBase := project(CleanIncidentCode, cleanLic(left));

pIncidentText	:= project(CleanIncidentText, transform(layouts.incidenttext_base, self := left, self := []));
pPartyText 		:= project(CleanPartyText, transform(layouts.partytext_base, self := left, self := []));
pPartyAka	 		:= project(CleanPartyAKA, transform(layouts.party_aka_dba_base, self := left, self := []));


PromoteSupers.MAC_SF_BuildProcess(dsParty, Constants.base_prefix_name + 'party', bld_base_party,,,true);
PromoteSupers.MAC_SF_BuildProcess(dsIncident, Constants.base_prefix_name + 'incident', bld_base_incident,,,true);
PromoteSupers.MAC_SF_BuildProcess(pLicenseBase, Constants.base_prefix_name + 'incidentcode', bld_base_incidentcode,,,true);
PromoteSupers.MAC_SF_BuildProcess(pPartyAka, Constants.base_prefix_name + 'party_aka_dba', bld_base_party_aka,,,true);
PromoteSupers.MAC_SF_BuildProcess(pIncidentText, Constants.base_prefix_name + 'incidenttext', bld_base_incident_text,,,true);
PromoteSupers.MAC_SF_BuildProcess(pPartyText, Constants.base_prefix_name + 'partytext', bld_base_party_text,,,true);


EXPORT proc_build_base := sequential(bld_base_party, bld_base_incident, bld_base_incidentcode, bld_base_party_aka, bld_base_incident_text,bld_base_party_text );



