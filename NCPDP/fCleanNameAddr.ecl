IMPORT lib_fileservices,_Control,lib_stringlib,AID,address,idl_header, NID;

EXPORT fCleanNameAddr	:= MODULE

	EXPORT Clean_addr (pBaseFile, pLayout_base)	:= FUNCTIONMACRO

		UNSIGNED4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
		AID.MacAppendFromRaw_2Line(pBaseFile,Append_Addr1,Append_AddrLast,Append_RawAID,cleanAddr, lFlags);

		pLayout_base addr(cleanAddr L)	:= TRANSFORM
			SELF.Append_RawAID     := L.aidwork_rawaid;
			SELF.Append_ACEAID			:= L.aidwork_acecache.aid;
			SELF.prim_range := stringlib.stringfilterout(L.aidwork_acecache.prim_range,'.');
			SELF.prim_name  := stringlib.stringfilterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
			SELF.sec_range  := stringlib.stringfilterout(L.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
			SELF.v_city_name:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.v_city_name,'');
			SELF.p_city_name:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.p_city_name,'');
			SELF.state			:= L.aidwork_acecache.st;
			SELF.zip5       := L.aidwork_acecache.zip5;
			SELF.fips_st    := L.aidwork_acecache.county[1..2];
			SELF.fips_county:= L.aidwork_acecache.county[3..5];
			SELF.msa        := IF(L.aidwork_acecache.msa='','',L.aidwork_acecache.msa+'0');
			SELF            := L.aidwork_acecache;
			SELF            := L;
		END;
		RETURN PROJECT(cleanAddr, addr(LEFT));
	ENDMACRO;

	EXPORT prov_info(DATASET(NCPDP.layouts.base.prov_information) pBaseFile) := FUNCTION

		seqRec	:=	record
				NCPDP.layouts.base.prov_information;
				unsigned4	unique_id;
		end;			
		
		seqrec into_seq(pBaseFile L, integer cnt) := transform
				self.unique_id	:= 	cnt;
				self.clean_fname			:=	l.Contact_first_name;
				self.clean_lname			:=	l.Contact_last_name;
				self.clean_mname			:=	l.contact_middle_initial;
				self 						:= 	L;
				self						:= 	[];
		end;

		SeqFile := distribute(project(pBaseFile,into_seq(LEFT,COUNTER)),unique_id);

		addresslayout :=	record
				unsigned8					unique_id			;	// to tie back to original record
				unsigned4					address_type	;	// physical or mailing
				string100					Append_Prep_Address1;
				string50					Append_Prep_AddressLast;
				AID.Common.xAID		Append_RawAID;		
				AID.Common.xAID		Append_AceAID;			
		end;

		addresslayout tNormalizeAddress(seqrec l, unsigned4 cnt) := transform
				self.unique_id								:= 	l.unique_id;
				self.address_type							:= 	cnt;
				self.Append_Prep_Address1			:= 	choose(cnt	,l.Append_PhyAddr1
																											,l.Append_MailAddr1
																								);              
				self.Append_Prep_AddressLast	:= 	choose(cnt	,l.Append_PhyAddrLast
																											,l.Append_MailAddrLast
																								);  
				self.Append_RawAID						:=	choose(cnt 	,l.Append_PhyRawAID
																											,l.Append_MailRawAID
																								);
				self.Append_ACEAID						:=	choose(cnt 	,l.Append_PhyACEAID
																											,l.Append_MailAceAID
																								);	
		end;
				
		dAddressPrep			:= 	normalize(SeqFile, 2, tNormalizeAddress(left,counter),local);

		HasAddress				:= 	trim(dAddressPrep.Append_Prep_AddressLast, left,right) != '';
												
		dWith_address			:= 	dAddressPrep(HasAddress);
		dWithout_address	:= 	dAddressPrep(not(HasAddress));
										
		dStandardizeInput_dist 	:= distribute(SeqFile	,unique_id);

		cleanedAddrLayout :=	record
			addresslayout;
			address.Layout_Clean182		Clean_Address;
		end;
						
		unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
				
		AID.MacAppendFromRaw_2Line(dWith_address, Append_Prep_Address1, Append_Prep_AddressLast, Append_RawAID, dAddressCleaned, lAIDAppendFlags);
		
		cleanedAddrLayout	tCleanAddressAppended(dAddressCleaned pInput)	:=	transform
				self.Append_RawAID			:=	pInput.AIDWork_RawAID;
				self.Append_ACEAID			:=	pInput.aidwork_acecache.aid;		
				self.clean_address.zip	:=	pInput.AIDWork_ACECache.zip5;
				self.clean_address			:=	pInput.AIDWork_ACECache;
				self										:=	pInput;
		end;
					
		dCleanAddressAppended				:=	project(dAddressCleaned,tCleanAddressAppended(left));	
				
		dCleanAddressAppended_dist	:= 	distribute(dCleanAddressAppended	,unique_id);
		
		seqRec tGetStandardizedAddress(seqRec l	,cleanedAddrLayout r) :=	transform
				self.Append_PhyRawAID	:= if(r.address_type = 1	,r.Append_RawAID							,l.Append_PhyRawAID);
				self.Append_PhyACEAID	:= if(r.address_type = 1	,r.Append_ACEAID							,l.Append_PhyACEAID);
				self.phys_prim_range	:= if(r.address_type = 1	,r.Clean_address.prim_range		,l.phys_prim_range);
				self.phys_predir			:= if(r.address_type = 1	,r.Clean_address.predir				,l.phys_predir);
				self.phys_prim_name		:= if(r.address_type = 1	,r.Clean_address.prim_name		,l.phys_prim_name);
				self.phys_addr_suffix	:= if(r.address_type = 1	,r.Clean_address.addr_suffix	,l.phys_addr_suffix);
				self.phys_postdir			:= if(r.address_type = 1	,r.Clean_address.postdir			,l.phys_postdir);
				self.phys_unit_desig	:= if(r.address_type = 1	,r.Clean_address.unit_desig		,l.phys_unit_desig);
				self.phys_sec_range		:= if(r.address_type = 1	,r.Clean_address.sec_range		,l.phys_sec_range);
				self.phys_p_city_name	:= if(r.address_type = 1	,r.Clean_address.p_city_name	,l.phys_p_city_name);
				self.phys_v_city_name	:= if(r.address_type = 1	,r.Clean_address.v_city_name	,l.phys_v_city_name);
				self.phys_state				:= if(r.address_type = 1	,r.Clean_address.st						,l.phys_state);
				self.phys_zip5				:= if(r.address_type = 1	,r.Clean_address.zip					,l.phys_zip5);
				self.phys_zip4				:= if(r.address_type = 1	,r.Clean_address.zip4					,l.phys_zip4);		
				self.phys_cart				:= if(r.address_type = 1	,r.Clean_address.cart					,l.phys_cart);
				self.phys_cr_sort_sz	:= if(r.address_type = 1	,r.Clean_address.cr_sort_sz		,l.phys_cr_sort_sz);
				self.phys_lot					:= if(r.address_type = 1	,r.Clean_address.lot					,l.phys_lot);
				self.phys_lot_order		:= if(r.address_type = 1	,r.Clean_address.lot_order		,l.phys_lot_order);
				self.phys_dpbc				:= if(r.address_type = 1	,r.Clean_address.dbpc					,l.phys_dpbc);
				self.phys_chk_digit		:= if(r.address_type = 1	,r.Clean_address.chk_digit		,l.phys_chk_digit);
				self.phys_rec_type		:= if(r.address_type = 1	,r.Clean_address.rec_type			,l.phys_rec_type);
				self.phys_ace_fips_st	:= if(r.address_type = 1	,r.Clean_address.county[1..2]	,l.phys_ace_fips_st);
				self.phys_county			:= if(r.address_type = 1	,r.Clean_address.county[3..5]	,l.phys_county);
				self.phys_geo_lat			:= if(r.address_type = 1	,r.Clean_address.geo_lat			,l.phys_geo_lat);
				self.phys_geo_long		:= if(r.address_type = 1	,r.Clean_address.geo_long			,l.phys_geo_long);
				self.phys_msa					:= if(r.address_type = 1	,r.Clean_address.msa					,l.phys_msa);
				self.phys_geo_blk			:= if(r.address_type = 1	,r.Clean_address.geo_blk			,l.phys_geo_blk);
				self.phys_geo_match		:= if(r.address_type = 1	,r.Clean_address.geo_match		,l.phys_geo_match);
				self.phys_err_stat		:= if(r.address_type = 1	,r.Clean_address.err_stat			,l.phys_err_stat);
		
				self.Append_MailRawAID:= if(r.address_type = 2	,r.Append_RawAID							,l.Append_MailRawAID);
				self.Append_MailAceAID:= if(r.address_type = 2	,r.Append_ACEAID							,l.Append_MailAceAID);
				self.mail_prim_range	:= if(r.address_type = 2	,r.Clean_address.prim_range		,l.mail_prim_range);
				self.mail_predir			:= if(r.address_type = 2	,r.Clean_address.predir				,l.mail_predir);
				self.mail_prim_name		:= if(r.address_type = 2	,r.Clean_address.prim_name		,l.mail_prim_name);
				self.mail_addr_suffix	:= if(r.address_type = 2	,r.Clean_address.addr_suffix	,l.mail_addr_suffix);
				self.mail_postdir			:= if(r.address_type = 2	,r.Clean_address.postdir			,l.mail_postdir);
				self.mail_unit_desig	:= if(r.address_type = 2	,r.Clean_address.unit_desig		,l.mail_unit_desig);
				self.mail_sec_range		:= if(r.address_type = 2	,r.Clean_address.sec_range		,l.mail_sec_range);
				self.mail_p_city_name	:= if(r.address_type = 2	,r.Clean_address.p_city_name	,l.mail_p_city_name);
				self.mail_v_city_name	:= if(r.address_type = 2	,r.Clean_address.v_city_name	,l.mail_v_city_name);
				self.mail_state				:= if(r.address_type = 2	,r.Clean_address.st						,l.mail_state);
				self.mail_zip5				:= if(r.address_type = 2	,r.Clean_address.zip					,l.mail_zip5);
				self.mail_zip4				:= if(r.address_type = 2	,r.Clean_address.zip4					,l.mail_zip4);		
				self.mail_cart				:= if(r.address_type = 2	,r.Clean_address.cart					,l.mail_cart);
				self.mail_cr_sort_sz	:= if(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.mail_cr_sort_sz);
				self.mail_lot					:= if(r.address_type = 2	,r.Clean_address.lot					,l.mail_lot);
				self.mail_lot_order		:= if(r.address_type = 2	,r.Clean_address.lot_order		,l.mail_lot_order);
				self.mail_dpbc				:= if(r.address_type = 2	,r.Clean_address.dbpc					,l.mail_dpbc);
				self.mail_chk_digit		:= if(r.address_type = 2	,r.Clean_address.chk_digit		,l.mail_chk_digit);
				self.mail_rec_type		:= if(r.address_type = 2	,r.Clean_address.rec_type			,l.mail_rec_type);
				self.mail_ace_fips_st	:= if(r.address_type = 2	,r.Clean_address.county[1..2]	,l.mail_ace_fips_st);
				self.mail_county			:= if(r.address_type = 2	,r.Clean_address.county[3..5]	,l.mail_county);
				self.mail_geo_lat			:= if(r.address_type = 2	,r.Clean_address.geo_lat			,l.mail_geo_lat);
				self.mail_geo_long		:= if(r.address_type = 2	,r.Clean_address.geo_long			,l.mail_geo_long);
				self.mail_msa					:= if(r.address_type = 2	,r.Clean_address.msa					,l.mail_msa);
				self.mail_geo_blk			:= if(r.address_type = 2	,r.Clean_address.geo_blk			,l.mail_geo_blk);
				self.mail_geo_match		:= if(r.address_type = 2	,r.Clean_address.geo_match		,l.mail_geo_match);
				self.mail_err_stat		:= if(r.address_type = 2	,r.Clean_address.err_stat			,l.mail_err_stat);
				self									:= l;
				self									:= [];
		end;
				
		dCleanPhysAddrAppended		:= join(
																			dStandardizeInput_dist
																			,dCleanAddressAppended_dist(address_type = 1)
																			,left.unique_id = right.unique_id
																			,tGetStandardizedAddress(left,right)
																			,local
																			,left outer
																			);
																			
		dCleanMailAddrAppended		:= join(
																			dCleanPhysAddrAppended
																			,dCleanAddressAppended_dist(address_type = 2)
																			,left.unique_id = right.unique_id
																			,tGetStandardizedAddress(left,right)
																			,local
																			,left outer
																			);
																			
		ut.mac_flipnames(dCleanMailAddrAppended,contact_first_name,contact_middle_initial,contact_last_name,cleanNames);
		
		NID.Mac_CleanFullNames(cleanNames,clean_doctor_Names,doctor_name,includeInRepository:=false, normalizeDualNames:=true);
			 
		layouts.base.prov_information tCleanNames(clean_doctor_Names l) := transform
			self.clean_dr_fname       	:= l.cln_fname;
			self.clean_dr_mname       	:= l.cln_mname;
			self.clean_dr_lname       	:= l.cln_lname;
			self.clean_dr_suffix				:= l.cln_suffix;
			self:=l;
		end;

		parsed_doctor_name:=project(clean_doctor_Names,tCleanNames(left))
			:persist('~thor_data400::persist::NCPDP::prov_information::clean_doctor_names');

		CleanedUpFile	:=	project(parsed_doctor_name,TRANSFORM(NCPDP.layouts.base.prov_information,SELF := LEFT;));
		
		return CleanedUpFile;
	end;	
	
	EXPORT demographic(DATASET(NCPDP.layouts.base.relationship_demographic) pBaseFile) := FUNCTION
	
		NID.Mac_CleanFullNames(pBaseFile,clean_contract_Names,contractual_contact_name,includeInRepository:=false, normalizeDualNames:=true);
			 
		layouts.base.relationship_demographic tCleanNames1(clean_contract_Names l) := transform
			self.contractual_contact_fname       	:= l.cln_fname;
			self.contractual_contact_mname       	:= l.cln_mname;
			self.contractual_contact_lname       	:= l.cln_lname;
			self.contractual_contact_suffix				:= l.cln_suffix;
			self:=l;
		end;

		parsed_contract_name:=project(clean_contract_Names,tCleanNames1(left))
			:persist('~thor_data400::persist::NCPDP::demographics::clean_contract_names');
	
		NID.Mac_CleanFullNames(parsed_contract_name,clean_operational_Names,operational_contact_name,includeInRepository:=false, normalizeDualNames:=false);

		layouts.base.relationship_demographic tCleanNames2(clean_operational_Names l) := transform
			self.operational_contact_fname       	:= l.cln_fname;
			self.operational_contact_mname       	:= l.cln_mname;
			self.operational_contact_lname       	:= l.cln_lname;
			self.operational_contact_suffix 			:= l.cln_suffix;
			self:=l;
		end;   										 

		parsed_operation_name:=project(clean_operational_Names,tCleanNames2(left))
			:persist('~thor_data400::persist::NCPDP::demographics::clean_operational_names');;
	 	
		NID.Mac_CleanFullNames(parsed_operation_name,clean_technical_Names,technical_contact_name,includeInRepository:=false, normalizeDualNames:=false);

		layouts.base.relationship_demographic tCleanNames3(clean_technical_Names l) := transform
			self.technical_contact_fname       := l.cln_fname;
			self.technical_contact_mname       := l.cln_mname;
			self.technical_contact_lname       := l.cln_lname;
			self.technical_contact_suffix			 := l.cln_suffix;
			self															 := l;
		end;

		parsed_technical_name		:=	project(clean_technical_names,tCleanNames3(left))
				:persist('~thor_data400::persist::NCPDP::demographics::clean_technical_names');;


		NID.Mac_CleanFullNames(parsed_technical_name,clean_audit_Names,audit_contact_name,includeInRepository:=false, normalizeDualNames:=true);
			 
		layouts.base.relationship_demographic tCleanNames4(clean_audit_Names l) := transform
			self.audit_contact_fname       := l.cln_fname;
			self.audit_contact_mname       := l.cln_mname;
			self.audit_contact_lname       := l.cln_lname;
			self.audit_contact_suffix			 := l.cln_suffix;
			self													 := l;
		end;

		parsed_audit_name		:=	project(clean_audit_Names,tCleanNames4(left))
				:persist('~thor_data400::persist::NCPDP::demographics::clean_audit_names');;

		NID.Mac_CleanFullNames(parsed_audit_name,clean_demog_Names,demog_contact_name,includeInRepository:=false, normalizeDualNames:=true);
			 
		layouts.base.relationship_demographic tCleanNames5(clean_demog_Names l) := transform
			self.demog_contact_fname       := l.cln_fname;
			self.demog_contact_mname       := l.cln_mname;
			self.demog_contact_lname       := l.cln_lname;
			self.demog_contact_suffix			 := l.cln_suffix;
			self													 := l;
		end;

		parsed_demog_name		:=	project(clean_demog_Names,tCleanNames5(left))
			:persist('~thor_data400::persist::NCPDP::demographics::clean_demog_names');;


		cleanAddr	:= Clean_addr(parsed_demog_name, layouts.base.relationship_demographic)
			:PERSIST('~thor_data400::persist::NCPDP::demographic::demographic_addr');
		
		return cleanAddr;
	end;	
	
	EXPORT pay_center(DATASET(NCPDP.layouts.base.payment_center_information) pBaseFile) := FUNCTION
	
		NID.Mac_CleanFullNames(pBaseFile,clean_Names,contact_name,includeInRepository:=false, normalizeDualNames:=true);
			 
		layouts.base.payment_center_information tCleanNames(clean_Names l) := transform
			self.contact_fname       	:= l.cln_fname;
			self.contact_mname       	:= l.cln_mname;
			self.contact_lname       	:= l.cln_lname;
			self.contact_suffix				:= l.cln_suffix;
			self:=l;
		end;

		parsed_name:=project(clean_Names,tCleanNames(left))
			:persist('~thor_data400::persist::NCPDP::pay_center::clean_names');
	
		cleanAddr	:= Clean_addr(parsed_name, layouts.base.payment_center_information)
			:PERSIST('~thor_data400::persist::NCPDP::pay_center::pay_center_addr');
		
		return cleanAddr;
	end;	
	
	EXPORT parent_org(DATASET(NCPDP.layouts.base.parent_organization_information) pBaseFile) := FUNCTION
	
		NID.Mac_CleanFullNames(pBaseFile,clean_Names,contact_name,includeInRepository:=false, normalizeDualNames:=true);
			 
		layouts.base.parent_organization_information tCleanNames(clean_Names l) := transform
			self.contact_fname       	:= l.cln_fname;
			self.contact_mname       	:= l.cln_mname;
			self.contact_lname       	:= l.cln_lname;
			self.contact_suffix				:= l.cln_suffix;
			self:=l;
		end;

		parsed_name:=project(clean_Names,tCleanNames(left))
			:persist('~thor_data400::persist::NCPDP::parent_org::clean_names');
	
		cleanAddr	:= Clean_addr(parsed_name, layouts.base.parent_organization_information)
			:PERSIST('~thor_data400::persist::NCPDP::parent_org::parent_org_addr');
		
		return cleanAddr;
	end;	
	
	EXPORT remit(DATASET(NCPDP.layouts.base.remit_information) pBaseFile) := FUNCTION
	
		NID.Mac_CleanFullNames(pBaseFile,clean_Names,contact_name,includeInRepository:=false, normalizeDualNames:=true);
			 
		layouts.base.remit_information tCleanNames(clean_Names l) := transform
			self.contact_fname       	:= l.cln_fname;
			self.contact_mname       	:= l.cln_mname;
			self.contact_lname       	:= l.cln_lname;
			self.contact_suffix				:= l.cln_suffix;
			self:=l;
		end;

		parsed_name:=project(clean_Names,tCleanNames(left))
			:persist('~thor_data400::persist::NCPDP::remit::clean_names');
	
		cleanAddr	:= Clean_addr(parsed_name, layouts.base.remit_information)
			:PERSIST('~thor_data400::persist::NCPDP::remit::parent_org_addr');
		
		return cleanAddr;
	end;	


end;
