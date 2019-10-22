IMPORT AID, ut, NID, codes, Address;

EXPORT Standardize_NameAddr := MODULE	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes people names
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fStandardizeName(DATASET(Database_USA.Layouts.Base) pPreProcessInput) :=	FUNCTION

		// -- Mapping Clean Person Name - uses NID to clean names
		sendRecs		:= pPreProcessInput(trim(first_name + middle_initial + last_name) <> '');
		notSendRecs := pPreProcessInput(trim(first_name + middle_initial + last_name) = '');

		NID.Mac_CleanParsedNames(PROJECT(sendRecs, Database_USA.Layouts.Base) 
																		,NID_output
																		,first_name,middle_initial,last_name,Suffix);
		
		Database_USA.Layouts.Base tCleanPers(NID_output L) := TRANSFORM
			SELF.title		    := if(L.nameType in ['P','D'], L.cln_title,  '');
			SELF.fname	      := if(L.nameType in ['P','D'], L.cln_fname,  '');
			SELF.mname	      := if(L.nameType in ['P','D'], L.cln_mname,  '');
			SELF.lname		    := if(L.nameType in ['P','D'], L.cln_lname,  '');
			SELF.name_suffix	:= if(L.nameType in ['P','D'], L.cln_suffix, '');
			SELF						  := L;			
		END;
		
		dStandardizedPerson := project(NID_output, tCleanPers(LEFT)) + notSendRecs : INDEPENDENT;
			
		RETURN dStandardizedPerson;

	END;  //End fStandardizeName
			
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeAddresses
	// -- Standardizes addresses
	// -- Apply AID process on the entire base recs for getting fresh address.
	//////////////////////////////////////////////////////////////////////////////////////
	
	export fStandardizeAddresses(DATASET(Database_USA.Layouts.Base) pStandardizeNameInput) :=	function
	
		tempLayout		:=	record
			unsigned8					unique_id;
			Database_USA.Layouts.Base;
		end;
		
		tempLayout tPreProcess(Database_USA.Layouts.Base l, unsigned4 cnt) :=	transform
			self.unique_id		:=	cnt;
			self							:=	l;
			self							:=	[];
		end;
	
		BaseSeq := 	project(pStandardizeNameInput, tPreProcess(left,counter));
	
		addresslayout :=	record
			unsigned8					unique_id;								//to tie back to original record
			string1						record_type;
			unsigned4					address_type;							// company (physical & mailing) and contact
			string100					Append_Prep_Address1;
			string50					Append_Prep_AddressLast;
			AID.Common.xAID		Append_RawAID;		
			AID.Common.xAID		Append_AceAID;			
		end;

		addresslayout tNormalizeAddress(tempLayout l, unsigned4 cnt) := transform
			self.unique_id								:= 	l.unique_id;
			self.record_type							:=	l.record_type;
			self.address_type							:= 	cnt;
		
			self.Append_Prep_Address1			:= 	choose(cnt	,l.phy_prep_address_line1
																										,l.mail_prep_address_line1
																										,l.DB_cons_prep_address_line1
																				       );              
			self.Append_Prep_AddressLast	:= 	choose(cnt	,l.phy_prep_address_line_last
																										,l.mail_prep_address_line_last
																										,l.DB_cons_prep_address_line_last
																							);  
			self.Append_RawAID						:=	choose(cnt 	,l.phy_raw_aid
																										,l.mail_raw_aid
																										,l.DB_cons_raw_aid
																							);
			self.Append_ACEAID						:=	choose(cnt 	,l.phy_ace_aid
																										,l.mail_ace_aid
																										,l.DB_cons_ace_aid
																							);	
		end;
				
		dAddressPrep						:= 	normalize(BaseSeq, 3, tNormalizeAddress(left,counter),local);

		HasAddress							:= 	trim(dAddressPrep.Append_Prep_AddressLast, left,right) != '';	

		dWith_address						:= 	dAddressPrep(HasAddress);

		dWithout_address				:= 	dAddressPrep(not(HasAddress));
										
		dStandardizeInput_dist 	:= 	distribute(BaseSeq,hash(unique_id,record_type));

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
																		
		dCleanAddressAppended_dist	:= distribute(dCleanAddressAppended	,hash(unique_id,record_type));

		DedupAppended	:=	dedup(sort(dCleanAddressAppended_dist,record,local),record,local);
		
		tempLayout tGetStandardizedAddress(tempLayout l	,cleanedAddrLayout r) :=	transform
			self.phy_raw_aid					:= if(r.address_type = 1	,r.Append_RawAID							,l.phy_raw_aid);
			self.phy_ace_aid					:= if(r.address_type = 1	,r.Append_ACEAID							,l.phy_ace_aid);
			self.phy_prim_range				:= if(r.address_type = 1	,r.Clean_address.prim_range		,l.phy_prim_range);
			self.phy_predir						:= if(r.address_type = 1	,r.Clean_address.predir				,l.phy_predir);
			self.phy_prim_name				:= if(r.address_type = 1	,r.Clean_address.prim_name		,l.phy_prim_name);
			self.phy_addr_suffix			:= if(r.address_type = 1	,r.Clean_address.addr_suffix	,l.phy_addr_suffix);
			self.phy_postdir					:= if(r.address_type = 1	,r.Clean_address.postdir			,l.phy_postdir);
			self.phy_unit_desig				:= if(r.address_type = 1	,r.Clean_address.unit_desig		,l.phy_unit_desig);
			self.phy_sec_range				:= if(r.address_type = 1	,r.Clean_address.sec_range		,l.phy_sec_range);
			self.phy_p_city_name			:= if(r.address_type = 1	,r.Clean_address.p_city_name	,l.phy_p_city_name);
			self.phy_v_city_name			:= if(r.address_type = 1	,r.Clean_address.v_city_name	,l.phy_v_city_name);
			self.phy_st								:= if(r.address_type = 1	,r.Clean_address.st						,l.phy_st);
			self.phy_zip							:= if(r.address_type = 1	,r.Clean_address.zip					,l.phy_zip);
			self.phy_zip4							:= if(r.address_type = 1	,r.Clean_address.zip4					,l.phy_zip4);		
			self.phy_cart							:= if(r.address_type = 1	,r.Clean_address.cart					,l.phy_cart);
			self.phy_cr_sort_sz				:= if(r.address_type = 1	,r.Clean_address.cr_sort_sz		,l.phy_cr_sort_sz);
			self.phy_lot							:= if(r.address_type = 1	,r.Clean_address.lot					,l.phy_lot);
			self.phy_lot_order				:= if(r.address_type = 1	,r.Clean_address.lot_order		,l.phy_lot_order);
			self.phy_dbpc							:= if(r.address_type = 1	,r.Clean_address.dbpc					,l.phy_dbpc);
			self.phy_chk_digit				:= if(r.address_type = 1	,r.Clean_address.chk_digit		,l.phy_chk_digit);
			self.phy_rec_type					:= if(r.address_type = 1	,r.Clean_address.rec_type			,l.phy_rec_type);
			self.phy_fips_state				:= if(r.address_type = 1	,r.Clean_address.county[1..2]	,l.phy_fips_state);
			self.phy_fips_county			:= if(r.address_type = 1	,r.Clean_address.county[3..5]	,l.phy_fips_county);
			self.phy_geo_lat					:= if(r.address_type = 1	,r.Clean_address.geo_lat			,l.phy_geo_lat);
			self.phy_geo_long					:= if(r.address_type = 1	,r.Clean_address.geo_long			,l.phy_geo_long);
			self.phy_msa							:= if(r.address_type = 1	,r.Clean_address.msa					,l.phy_msa);
			self.phy_geo_blk					:= if(r.address_type = 1	,r.Clean_address.geo_blk			,l.phy_geo_blk);
			self.phy_geo_match				:= if(r.address_type = 1	,r.Clean_address.geo_match		,l.phy_geo_match);
			self.phy_err_stat					:= if(r.address_type = 1	,r.Clean_address.err_stat			,l.phy_err_stat);
		
			self.mail_raw_aid					:= if(r.address_type = 2	,r.Append_RawAID							,l.mail_raw_aid);
			self.mail_ace_aid					:= if(r.address_type = 2	,r.Append_ACEAID							,l.mail_ace_aid);
			self.mail_prim_range			:= if(r.address_type = 2	,r.Clean_address.prim_range		,l.mail_prim_range);
			self.mail_predir					:= if(r.address_type = 2	,r.Clean_address.predir				,l.mail_predir);
			self.mail_prim_name				:= if(r.address_type = 2	,r.Clean_address.prim_name		,l.mail_prim_name);
			self.mail_addr_suffix			:= if(r.address_type = 2	,r.Clean_address.addr_suffix	,l.mail_addr_suffix);
			self.mail_postdir					:= if(r.address_type = 2	,r.Clean_address.postdir			,l.mail_postdir);
			self.mail_unit_desig			:= if(r.address_type = 2	,r.Clean_address.unit_desig		,l.mail_unit_desig);
			self.mail_sec_range				:= if(r.address_type = 2	,r.Clean_address.sec_range		,l.mail_sec_range);
			self.mail_p_city_name			:= if(r.address_type = 2	,r.Clean_address.p_city_name	,l.mail_p_city_name);
			self.mail_v_city_name			:= if(r.address_type = 2	,r.Clean_address.v_city_name	,l.mail_v_city_name);
			self.mail_st							:= if(r.address_type = 2	,r.Clean_address.st						,l.mail_st);
			self.mail_zip							:= if(r.address_type = 2	,r.Clean_address.zip					,l.mail_zip);
			self.mail_zip4						:= if(r.address_type = 2	,r.Clean_address.zip4					,l.mail_zip4);		
			self.mail_cart						:= if(r.address_type = 2	,r.Clean_address.cart					,l.mail_cart);
			self.mail_cr_sort_sz			:= if(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.mail_cr_sort_sz);
			self.mail_lot							:= if(r.address_type = 2	,r.Clean_address.lot					,l.mail_lot);
			self.mail_lot_order				:= if(r.address_type = 2	,r.Clean_address.lot_order		,l.mail_lot_order);
			self.mail_dbpc						:= if(r.address_type = 2	,r.Clean_address.dbpc					,l.mail_dbpc);
			self.mail_chk_digit				:= if(r.address_type = 2	,r.Clean_address.chk_digit		,l.mail_chk_digit);
			self.mail_rec_type				:= if(r.address_type = 2	,r.Clean_address.rec_type			,l.mail_rec_type);
			self.mail_fips_state			:= if(r.address_type = 2	,r.Clean_address.county[1..2]	,l.mail_fips_state);
			self.mail_fips_county			:= if(r.address_type = 2	,r.Clean_address.county[3..5]	,l.mail_fips_county);
			self.mail_geo_lat					:= if(r.address_type = 2	,r.Clean_address.geo_lat			,l.mail_geo_lat);
			self.mail_geo_long				:= if(r.address_type = 2	,r.Clean_address.geo_long			,l.mail_geo_long);
			self.mail_msa							:= if(r.address_type = 2	,r.Clean_address.msa					,l.mail_msa);
			self.mail_geo_blk					:= if(r.address_type = 2	,r.Clean_address.geo_blk			,l.mail_geo_blk);
			self.mail_geo_match				:= if(r.address_type = 2	,r.Clean_address.geo_match		,l.mail_geo_match);
			self.mail_err_stat				:= if(r.address_type = 2	,r.Clean_address.err_stat			,l.mail_err_stat);
			
			self.DB_cons_raw_aid			:= if(r.address_type = 3	,r.Append_RawAID							,l.DB_cons_raw_aid);
			self.DB_cons_ace_aid			:= if(r.address_type = 3	,r.Append_ACEAID							,l.DB_cons_ace_aid);
			self.DB_cons_prim_range		:= if(r.address_type = 3	,r.Clean_address.prim_range		,l.DB_cons_prim_range);
			self.DB_cons_predir				:= if(r.address_type = 3	,r.Clean_address.predir				,l.DB_cons_predir);
			self.DB_cons_prim_name		:= if(r.address_type = 3	,r.Clean_address.prim_name		,l.DB_cons_prim_name);
			self.DB_cons_addr_suffix	:= if(r.address_type = 3	,r.Clean_address.addr_suffix	,l.DB_cons_addr_suffix);
			self.DB_cons_postdir			:= if(r.address_type = 3	,r.Clean_address.postdir			,l.DB_cons_postdir);
			self.DB_cons_unit_desig		:= if(r.address_type = 3	,r.Clean_address.unit_desig		,l.DB_cons_unit_desig);
			self.DB_cons_sec_range		:= if(r.address_type = 3	,r.Clean_address.sec_range		,l.DB_cons_sec_range);
			self.DB_cons_p_city_name	:= if(r.address_type = 3	,r.Clean_address.p_city_name	,l.DB_cons_p_city_name);
			self.DB_cons_v_city_name	:= if(r.address_type = 3	,r.Clean_address.v_city_name	,l.DB_cons_v_city_name);
			self.DB_cons_st						:= if(r.address_type = 3	,r.Clean_address.st						,l.DB_cons_st);
			self.DB_cons_zip					:= if(r.address_type = 3	,r.Clean_address.zip					,l.DB_cons_zip);
			self.DB_cons_zip4					:= if(r.address_type = 3	,r.Clean_address.zip4					,l.DB_cons_zip4);		
			self.DB_cons_cart					:= if(r.address_type = 3	,r.Clean_address.cart					,l.DB_cons_cart);
			self.DB_cons_cr_sort_sz		:= if(r.address_type = 3	,r.Clean_address.cr_sort_sz		,l.DB_cons_cr_sort_sz);
			self.DB_cons_lot					:= if(r.address_type = 3	,r.Clean_address.lot					,l.DB_cons_lot);
			self.DB_cons_lot_order		:= if(r.address_type = 3	,r.Clean_address.lot_order		,l.DB_cons_lot_order);
			self.DB_cons_dbpc					:= if(r.address_type = 3	,r.Clean_address.dbpc					,l.DB_cons_dbpc);
			self.DB_cons_chk_digit		:= if(r.address_type = 3	,r.Clean_address.chk_digit		,l.DB_cons_chk_digit);
			self.DB_cons_rec_type			:= if(r.address_type = 3	,r.Clean_address.rec_type			,l.DB_cons_rec_type);
			self.DB_cons_fips_state		:= if(r.address_type = 3	,r.Clean_address.county[1..2]	,l.DB_cons_fips_state);
			self.DB_cons_fips_county	:= if(r.address_type = 3	,r.Clean_address.county[3..5]	,l.DB_cons_fips_county);
			self.DB_cons_geo_lat			:= if(r.address_type = 3	,r.Clean_address.geo_lat			,l.DB_cons_geo_lat);
			self.DB_cons_geo_long			:= if(r.address_type = 3	,r.Clean_address.geo_long			,l.DB_cons_geo_long);
			self.DB_cons_msa					:= if(r.address_type = 3	,r.Clean_address.msa					,l.DB_cons_msa);
			self.DB_cons_geo_blk			:= if(r.address_type = 3	,r.Clean_address.geo_blk			,l.DB_cons_geo_blk);
			self.DB_cons_geo_match		:= if(r.address_type = 3	,r.Clean_address.geo_match		,l.DB_cons_geo_match);
			self.DB_cons_err_stat			:= if(r.address_type = 3	,r.Clean_address.err_stat			,l.DB_cons_err_stat);
			self											:= l;
			self											:= [];
		end;
				
		dCleanPhyAddressAppended	:= join(
																				dStandardizeInput_dist
																				,dCleanAddressAppended_dist(address_type = 1)
																				,left.unique_id = right.unique_id and
																				 left.record_type = right.record_type
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
		
		dCleanMailAddressAppended	:= join(
																				dCleanPhyAddressAppended
																				,dCleanAddressAppended_dist(address_type = 2)
																				,left.unique_id = right.unique_id and
																				 left.record_type = right.record_type
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
		
		dCleanDBConsAddressAppended	:= join(
																				dCleanMailAddressAppended
																				,dCleanAddressAppended_dist(address_type = 3)
																				,left.unique_id = right.unique_id and
																				 left.record_type = right.record_type
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);																				
																				
		dTransformBase		:=	PROJECT(dCleanDBConsAddressAppended,TRANSFORM(Database_USA.Layouts.Base,SELF := LEFT;));
																				
		dedupCleanAppend	:=	dedup(sort(dTransformBase,record,local),record,local);	
		
		return dedupCleanAppend;
		
	end;	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(Database_USA.Layouts.Base) pBaseFile) := FUNCTION

  	dStandardizeName	:= fStandardizeName(pBaseFile);			 
								 
		dStandardizeAddr	:= fStandardizeAddresses(dStandardizeName) : PERSIST(Database_USA.Persist_Names().StandardizeNameAddr);
		
		RETURN dStandardizeAddr;
	
	END;

END;