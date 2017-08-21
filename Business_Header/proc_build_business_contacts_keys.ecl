import ut,doxie_cbrs,RoxieKeyBuild, versioncontrol, aid;

import ut,aid;

export proc_build_business_contacts_keys(string pversion) := 
module

	/////////////////////////////////////////////////////////////////////////
	in_hdr := filters.keys.business_contacts(files(,_Dataset().IsDataland).base.business_contacts.keybuild);

	//********************************* START of AID process *********************************
	//**** Getting the best address for business contacts keys.
	Layout_in_hdr_seq := record
		business_header.Layout_Business_Contact_Full_New;
		unsigned6 rec_seq := 0;
	end;

	in_hdr_seq := project(in_hdr, transform(Layout_in_hdr_seq, self := left,self.rec_seq := counter)): persist('~thor_data400::persist::business_header::proc_build_business_contacts_keys::in_hdr_seq');

	Layout_norm := record
		Layout_in_hdr_seq.prim_range;
		Layout_in_hdr_seq.predir;
		Layout_in_hdr_seq.prim_name;
		Layout_in_hdr_seq.addr_suffix;
		Layout_in_hdr_seq.postdir;
		Layout_in_hdr_seq.unit_desig;
		Layout_in_hdr_seq.sec_range;
		Layout_in_hdr_seq.city;
		Layout_in_hdr_seq.state;
		Layout_in_hdr_seq.zip;
		Layout_in_hdr_seq.zip4;
		Layout_in_hdr_seq.rawaid;
		string1	addr_type := '';
		unsigned6 rec_seq := 0;
	end;

	Layout_norm normAddrForAID(in_hdr_seq l, integer c) := transform
		 self.addr_type		:= choose(c,'O','C');
		 self.prim_range	:= choose(c, l.prim_range, l.company_prim_range); 
		 self.predir			:= choose(c, l.predir, l.company_predir); 
		 self.prim_name		:= choose(c, l.prim_name, l.company_prim_name); 
		 self.addr_suffix	:= choose(c, l.addr_suffix, l.company_addr_suffix); 
		 self.postdir			:= choose(c, l.postdir, l.company_postdir);              
		 self.unit_desig	:= choose(c, l.unit_desig, l.company_unit_desig); 
		 self.sec_range		:= choose(c, l.sec_range, l.company_sec_range); 
		 self.city				:= choose(c, l.city, l.company_city); 
		 self.state				:= choose(c, l.state, l.company_state); 
		 self.zip					:= choose(c, l.zip, l.company_zip); 
		 self.zip4				:= choose(c, l.zip4, l.company_zip4);
		 self.rawaid			:= choose(c, l.rawaid, l.company_rawaid);
		 self							:= l;
	end;

	in_hdr_norm_Addr := normalize(in_hdr_seq, 2, normAddrForAID(left,counter));
		
	//Propage the Business Contacts with AID and get the best address for keys
	macGetCleanAddr(in_hdr_norm_Addr, prim_range, predir, prim_name, addr_suffix, postdir, 
									unit_desig, sec_range, city, state, zip, zip4, RawAID, true, false, in_hdr_With_AID_result);
									
	dIn_hdr_With_AID_result := in_hdr_With_AID_result : INDEPENDENT;

	Layout_in_hdr_seq DenormRecs(Layout_in_hdr_seq l,  Layout_norm r) := transform	
		self.rawAID 								:= if(r.addr_type = 'O', r.rawAID, l.rawAID);
		self.Company_rawAID 				:= if(r.addr_type = 'C', r.rawAID, l.Company_rawAID);
		self.prim_range							:= if(r.addr_type = 'O', r.prim_range, l.prim_range); 
		self.predir									:= if(r.addr_type = 'O', r.predir, l.predir); 
		self.prim_name							:= if(r.addr_type = 'O', r.prim_name, l.prim_name); 
		self.addr_suffix						:= if(r.addr_type = 'O', r.addr_suffix, l.addr_suffix); 
		self.postdir								:= if(r.addr_type = 'O', r.postdir, l.postdir);              
		self.unit_desig							:= if(r.addr_type = 'O', r.unit_desig, l.unit_desig); 
		self.sec_range							:= if(r.addr_type = 'O', r.sec_range, l.sec_range); 
		self.city										:= if(r.addr_type = 'O', r.city, l.city); 
		self.state									:= if(r.addr_type = 'O', r.state, l.state); 
		self.zip										:= if(r.addr_type = 'O', r.zip, l.zip); 
		self.zip4										:= if(r.addr_type = 'O', r.zip4, l.zip4);
		
		self.company_prim_range			:= if(r.addr_type = 'C', r.prim_range, l.company_prim_range); 
		self.company_predir					:= if(r.addr_type = 'C', r.predir, l.company_predir); 
		self.company_prim_name			:= if(r.addr_type = 'C', r.prim_name, l.company_prim_name); 
		self.company_addr_suffix		:= if(r.addr_type = 'C', r.addr_suffix, l.company_addr_suffix); 
		self.company_postdir				:= if(r.addr_type = 'C', r.postdir, l.company_postdir);              
		self.company_unit_desig			:= if(r.addr_type = 'C', r.unit_desig, l.company_unit_desig); 
		self.company_sec_range			:= if(r.addr_type = 'C', r.sec_range, l.company_sec_range); 
		self.company_city						:= if(r.addr_type = 'C', r.city, l.company_city); 
		self.company_state					:= if(r.addr_type = 'C', r.state, l.company_state); 
		self.company_zip						:= if(r.addr_type = 'C', r.zip, l.company_zip); 
		self.company_zip4						:= if(r.addr_type = 'C', r.zip4, l.company_zip4);
		self        								:= l;		 
	end;

	in_hdr_denorm := denormalize(in_hdr_seq,
															 dIn_hdr_With_AID_result,
															 left.rec_seq = right.rec_seq,
															 DenormRecs(left, right)
															);

	in_hdr_With_Best_Addr := project(in_hdr_denorm, transform(business_header.Layout_Business_Contact_Full_New, self := left));
	
	VersionControl.macBuildNewLogicalFile(business_header._Dataset().thor_cluster_Files +'base::business_header::BC_bestAddr::keybuild',in_hdr_With_Best_Addr,abuildBaseForKeys,,,true);
	//********************************* End of AID process *********************************
	
	shared keyName			:= keynames(pversion);
	
	VersionControl.macBuildNewLogicalKeyWithName(Key_Business_Contacts_BDID									,keyName.Contacts.Bdid.New						,Build_Key1				);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Company_Title													,keyName.Contacts.Companytitle.New		,Build_Key2,,true	);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Business_Contacts_State_LFName					,keyName.Contacts.StateLfmname.New		,Build_Key3				);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Prep_Business_Contacts_State_City_Name	,keyName.Contacts.StateCityName.New		,Build_Key4				);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Business_Contacts_FP										,keyName.Contacts.filepos.New					,Build_Key5				);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Business_Contacts_DID									,keyName.Contacts.Did.New							,Build_Key6				);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Prep_Business_Contacts_Stats						,keyName.ContactsStat.FileposData.New	,Build_Key7				);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Business_Contacts_SSN									,keyName.Contacts.Ssn.New							,Build_Key8				);
	VersionControl.macBuildNewLogicalKeyWithName(doxie_cbrs.key_BDID_relsByContact					,keyName.Contacts.BdidScore.New				,Build_Key9				);

	shared keygroupnames := 
				keyName.contacts.dAll_filenames                                                                           
			+ keyName.ContactsStat.dAll_filenames
			; 
                                          
	export Build_All_Keys :=
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroupnames)
		,parallel(
						 
			 Build_Key1
			,Build_Key2
			,Build_Key3
			,Build_Key4
			,Build_Key5
			,Build_Key6
			,Build_Key7
			,Build_Key8
			,Build_Key9

		));

	export All :=
	sequential(
		 abuildBaseForKeys
		,Build_All_Keys
		,promote(pversion,'^(?!.*moxie)(.*?)key(.*?)$').new2built
	);

end;
	