import aid, address, SAM, STD, ut;
			 
export StandardizeInputFile := module

	export trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
	end;
		
	export fPreProcess(string8 filedate) := function    
		// XML now comes from SAM and is in the format of what the Worldcheck Bridger uses.
		ds_GSA := PROJECT(SAM.File_Converted, transform(GSA.Layouts_GSA.layout_GSA_ID,self := left));

		// generating a sequence number for "gsa_id"
		ut.MAC_Sequence_Records(ds_GSA, gsa_id, ds_GSA_output);	

		ds_XML := DISTRIBUTE(ds_GSA_output, gsa_id);	

		dProcessReference				:= fProcessNewReferenceChildren(ds_XML);
		dProcessAddressList 		:= fProcessAddressListChildren(ds_XML);
		dProcessAdditionalInfo	:= fProcessAdditionalInfoChildren(ds_XML);
		dProcessIDListChildren	:= fProcessIDListChildren(ds_XML);
		dProcessSlimMain				:= fProcessSlimMain(ds_XML);
			
		layouts_gsa.slim_main_lo joinRefs(dProcessSlimMain L, dProcessReference R) := TRANSFORM, SKIP(R.name = '')
			SELF.primary_aka_name := R.primary_aka_name;
			SELF.name 						:= R.name;
			SELF := L;
		END;

		slim_main_ref := JOIN(dProcessSlimMain, dProcessReference,
													LEFT.gsa_id = RIGHT.gsa_id,
													joinRefs(LEFT, RIGHT),
													LEFT OUTER,
													LOCAL);	

		all_main_refs := sort(slim_main_ref + dProcessSlimMain,gsa_id,primary_aka_name,local);
					
		layouts_gsa.main_addrs_lo joinAddrs(all_main_refs L, dProcessAddressList R) := TRANSFORM
			SELF.State    := IF(R.State='XX','',IF(LENGTH(R.State) = 2, trimUpper(R.State), ''));
			SELF.city     := trimUpper(R.city);
			SELF.street1  := trimUpper(R.street_1);
			SELF.street2  := trimUpper(R.street_2);
			SELF.zip      := R.postal_code;
			SELF.street3  := '';
			SELF.province := IF(LENGTH(R.State) > 2, trimUpper(R.State), '');
			SELF.country  := trimUpper(R.country);
			SELF					:= L;
		END;
								 
		main_addrs := JOIN(all_main_refs, dProcessAddressList,
											 LEFT.gsa_id = RIGHT.gsa_id,
											 joinAddrs(LEFT, RIGHT),
											 LEFT OUTER,
											 LOCAL);		

		main_addrs_projected := PROJECT(main_addrs, TRANSFORM(layouts_gsa.main_addrs_info_id_lo, SELF := LEFT, SELF := []));

		layouts_gsa.main_addrs_info_id_lo joinAdditionalInfo(main_addrs_projected L, dProcessAdditionalInfo R) := TRANSFORM
			information 						:= trimUpper(R.information);
			comments    						:= trimUpper(R.comments);
			the_date                := STD.Date.ConvertDateFormat(comments);
			SELF.TermDateIndefinite := IF(information = 'TERMINATION DATE',
																		IF(REGEXFIND('indef', comments, NOCASE), 'Y', ''),
																		L.TermDateIndefinite);
			SELF.TermDatePermanent  := IF(information = 'TERMINATION DATE',
																		IF(REGEXFIND('perm', comments, NOCASE), 'Y', ''),
																		L.TermDatePermanent);
			SELF.ActionDate         := IF(information = 'ACTIVE DATE',
																		IF((INTEGER)the_date <= 0, '', the_date),
																		L.ActionDate);
			SELF.TermDate           := IF(information = 'TERMINATION DATE',
																		IF((INTEGER)the_date <= 0, '', the_date),
																		L.TermDate);
			SELF.Description        := IF(information = 'ADDITIONAL COMMENTS', comments, L.Description);
			SELF.CTType             := IF(information = 'EXCLUDING PROGRAM', comments, L.CTType);
			SELF.ExclusionType      := IF(information = 'EXCLUDING TYPE', comments, L.ExclusionType);
			SELF.CTCode             := IF(information = 'CT CODE', comments, L.CTCode);
			SELF.AgencyComponent    := IF(information = 'EXCLUDING AGENCY', comments, L.AgencyComponent);
			SELF.SAM_record_status  := IF(information = 'RECORD STATUS', comments, L.SAM_record_status);
			SELF 										:= L;
		END;

		main_addrs_info := DENORMALIZE(main_addrs_projected, dProcessAdditionalInfo,
																	 LEFT.gsa_id = RIGHT.gsa_id,
																	 joinAdditionalInfo(LEFT, RIGHT),
																	 LOCAL);
								
		layouts_gsa.main_addrs_info_id_lo joinID(main_addrs_info L, dProcessIDListChildren R) := TRANSFORM
			clean_type 		:= trimUpper(R.type);
			clean_number 	:= trimUpper(R.number);
			SELF.DUNS 		:= IF(clean_type = 'DUNS #', clean_number, L.DUNS);
			SELF 					:= L;
		END;

		main_addrs_info_id := JOIN(main_addrs_info, dProcessIDListChildren,
															 LEFT.gsa_id = RIGHT.gsa_id,
															 joinID(LEFT, RIGHT),
															 LEFT OUTER,
															 LOCAL);
								

		ds_dist	:= distribute(main_addrs_info_id,gsa_id);

		// Begin Clean Address Process
		addresslayout :=	record
			unsigned8										gsa_id;	//to tie back to original record
			string100										Append_Prep_Address1;
			string50										Append_Prep_AddressLast;
			AID.Common.xAID							Append_RawAID;	
			AID.Common.xAID							Append_ACEAID;		
		end;
								
		addresslayout tAddress(layouts_gsa.main_addrs_info_id_lo l) := transform
			self.gsa_id										:= l.gsa_id;
			self.Append_Prep_Address1			:= trimUpper(l.Street1) + ' ' +	trimUpper(l.Street2) + ' ' + trimUpper(l.Street3);           
			self.Append_Prep_AddressLast	:= trimUpper(l.city)  + if(trimUpper(l.city)<>'',', ','') + trimUpper(l.state) + ' ' +trimUpper(l.zip);
			self.Append_RawAID						:= 0;
			self.Append_ACEAID						:= 0;
		end;
					
		dAddressPrep			:= 	project(ds_dist, tAddress(left));
			
		HasAddress				:= 	trimUpper(dAddressPrep.Append_Prep_Address1) 		!= ''	or 
													trimUpper(dAddressPrep.Append_Prep_AddressLast) != '';
													
		dWith_address			:= 	dedup(sort(distribute(dAddressPrep(HasAddress),gsa_id),gsa_id,local),gsa_id,dAddressPrep.Append_Prep_address1,dAddressPrep.Append_Prep_addressLast,local);
																						
		AID.Common.xFlags	lAIDAppendFlags	:=	AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	
					
		AID.MacAppendFromRaw_2Line(dWith_address, Append_Prep_Address1, Append_Prep_AddressLast, Append_RawAID, dAddressCleaned, lAIDAppendFlags);

		cleanedAddrLayout :=	record
			addresslayout;
			address.Layout_Clean182		Clean_Address;
		end;
		
		cleanedAddrLayout	tCleanAddressAppended(dAddressCleaned l)	:=	transform
			self.gsa_id							:=  l.gsa_id;
			self.Append_RawAID			:=	l.AIDWork_RawAID;
			self.Append_ACEAID			:=	l.AIDWork_ACECache.AID;		
			self.clean_address.zip	:=	l.AIDWork_ACECache.zip5;
			self.clean_address			:=	l.AIDWork_ACECache;
			self										:=	l;
		end;
		
		dCleanAddressAppended				:= project(dAddressCleaned,tCleanAddressAppended(left));		
		dCleanAddressAppended_dist	:= sort(distribute(dCleanAddressAppended,gsa_id),gsa_id,local);
		
		layouts_gsa.layout_Base tCleanRecs(ds_dist L,dCleanAddressAppended_dist R) := transform
			self.gsa_id					 := l.gsa_id;
			self.bdid						 := 0;
			self.did						 := 0;
			self.dtype					 := '';
			self.dvalue					 := '';
			self.name            := trimUpper(l.name);	
			order                := if(stringlib.stringfind(l.name,' ',1)=stringlib.stringfind(l.name,',',1)+1,'L','F');
			cn                   := address.Clean_n_Validate_Name(l.name,order);
			self.title		       := cn.title;
			self.fname		       := cn.fname;
			self.mname		       := cn.mname;
			self.lname		       := cn.lname;
			self.name_suffix     := cn.name_suffix;
			self.name_score	     := cn.name_score;			
			self.street1         := trimUpper(l.street1);
			self.street2         := trimUpper(l.street2);
			self.street3         := trimUpper(l.street3);
			self.city            := trimUpper(l.city);
			self.state           := trimUpper(l.state);
			self.prim_range      := r.clean_address.prim_range;
			self.predir          := r.clean_address.predir;
			self.prim_name       := r.clean_address.prim_name;
			self.addr_suffix     := r.clean_address.addr_suffix;
			self.postdir         := r.clean_address.postdir;
			self.unit_desig      := r.clean_address.unit_desig;
			self.sec_range       := r.clean_address.sec_range;
			self.p_city_name     := r.clean_address.p_city_name;
			self.v_city_name     := r.clean_address.v_city_name;
			self.st              := r.clean_address.st;
			self.zip5            := r.clean_address.zip;
			self.zip4            := r.clean_address.zip4;
			self.cart            := r.clean_address.cart;
			self.cr_sort_sz      := r.clean_address.cr_sort_sz;
			self.lot             := r.clean_address.lot;
			self.lot_order       := r.clean_address.lot_order;
			self.dbpc            := r.clean_address.dbpc;
			self.chk_digit       := r.clean_address.chk_digit;
			self.rec_type        := r.clean_address.rec_type;
			self.county          := r.clean_address.county;
			self.geo_lat         := r.clean_address.geo_lat;
			self.geo_long        := r.clean_address.geo_long;
			self.msa             := r.clean_address.msa;
			self.geo_blk         := r.clean_address.geo_blk;
			self.geo_match       := r.clean_address.geo_match;
			self.err_stat        := r.clean_address.err_stat;
			self.append_rawaid	 := r.Append_RawAID;
			self.append_aceaid	 := r.Append_ACEAID;			
			self.dt_last_seen    := filedate;
			self                 := l;
		end;

		clean_recs := JOIN(ds_dist, dCleanAddressAppended_dist,
													LEFT.gsa_id = RIGHT.gsa_id,
													tCleanRecs(LEFT, RIGHT),
													LEFT OUTER,
													LOCAL);

		StandardizeInputFile := dedup(sort(distribute(clean_recs,gsa_id),gsa_id,local),record,local);

		return StandardizeInputFile;
	end; //end fPreProcess function

end; //end StandardizeInputFile 