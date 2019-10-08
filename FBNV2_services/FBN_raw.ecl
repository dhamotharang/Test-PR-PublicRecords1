import AutoStandardI, doxie, doxie_cbrs, FBNv2, FBNV2_services, suppress, ut;


export FBN_raw := module

	
	// Gets RMSIDs from DIDs
	export get_rmsids_from_dids (dataset(doxie.layout_references) in_dids) := function

			key := FBNV2.Key_DID;
			res:= join(dedup(sort(in_dids,did),did), key,
										keyed(left.did = right.did),
										transform(FBNV2_services.layout_rmsid,self := right),
										keep(10000));

		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;

	// Gets RMSIDs from BDIDs
	export get_rmsids_from_bdids(dataset(doxie_cbrs.layout_references) in_bdids,
	                             unsigned in_limit = 0) := function
	  key := FBNV2.Key_BDID;
		res := join(dedup(sort(in_bdids,bdid),bdid),key,
		            keyed(left.bdid = right.bdid),
								transform(FBNV2_services.layout_rmsid,self := right),
								keep(10000));							
		ded := dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
		
		return if(in_limit = 0,ded,choosen(ded,in_limit));
	end;
	
	// Gets RMSIDs from Casenumber ST
	export get_rmsids_from_FilingNumber(dataset(FBNV2_Services.layout_FilingNumber) in_FilingNumber) := function
		key := FBNV2.Key_Filing_Number;
		res := join(dedup(sort(in_FilingNumber,Filing_Number),Filing_Number),key,
								keyed(left.Filing_Number= right.Filing_Number), 
								transform(FBNV2_services.layout_rmsid,self := right),
								keep(1000));
		return dedup(sort(res,tmsid,rmsid),tmsid,rmsid);
	end;
	
	shared gm := AutoStandardI.GlobalModule();
	
	shared temp_mod_one := module(project(gm,AutoStandardI.LIBIN.PenaltyI.base,opt))
		// export nofail := true;
	end;
	shared temp_mod_two := module(project(gm,AutoStandardI.LIBIN.PenaltyI.base,opt))
		// export nofail := true;
		export firstname := gm.entity2_firstname;
		export middlename := gm.entity2_middlename;
		export lastname := gm.entity2_lastname;
		export allownicknames := gm.entity2_allownicknames;
		export phoneticmatch := gm.entity2_phoneticmatch;
		export companyname := gm.entity2_companyname;
		export addr := gm.entity2_addr;
		export city := gm.entity2_city;
		export state := gm.entity2_state;
		export zip := gm.entity2_zip;
		export zipradius := gm.entity2_zipradius;
		export phone := gm.entity2_phone;
		export fein := gm.entity2_fein;
		export bdid := gm.entity2_bdid;
		export did := gm.entity2_did;
		export ssn := gm.entity2_ssn;
	end;

	export search_view := module
	
		export by_rmsid(dataset(FBNV2_services.layout_search_IDs) in_rmsids,boolean is_search):= function
			return IF(gm.TwoPartySearch,
				FBNV2_services.get_FBN(in_rmsids,is_search,temp_mod_one,temp_mod_two).search,
				FBNV2_services.get_FBN(in_rmsids,is_search,temp_mod_one,temp_mod_one).search);
		end;
	
	end;
	
	export report_view := module
		export by_rmsid(dataset(FBNV2_services.layout_search_IDs) in_rmsids,boolean is_search,boolean addr_penalty_skip = true) := FUNCTION
			return IF(gm.TwoPartySearch,
				FBNV2_services.get_FBN(in_rmsids,is_search,temp_mod_one,temp_mod_two,addr_penalty_skip).report,
				FBNV2_services.get_FBN(in_rmsids,is_search,temp_mod_one,temp_mod_one,addr_penalty_skip).report);
		end;
	end;
	
	export batch_view := MODULE
		
		export batch_layout(dataset(FBNV2_services.Layout_FBN_Report) rpt) := FUNCTION
		  out_rec := FBNV2_services.assorted_layouts.batch_out_layout;
			format_addr_1(FBNV2_services.Layout_Contact ct) := FUNCTION
				  addr_1 := TRIM(ct.prim_range) + ' '+ TRIM(ct.predir) + ' '+ TRIM(ct.prim_name) + ' '+ TRIM(ct.addr_suffix) + ' '+ TRIM(ct.postdir)   ;
					return addr_1;
			END;
			format_addr_2(FBNV2_services.Layout_Contact ct) := FUNCTION
				  addr_2 := TRIM(ct.unit_desig) + ' '+ TRIM(ct.sec_range);
					return addr_2;
			END;
			format_zip(FBNV2_services.Layout_Contact ct) := FUNCTION
				  zip := TRIM(ct.zip5) + ' '+ TRIM(ct.zip4);
					return zip;
			END;
			get_CType(string ct) := FUNCTION
			 RETURN MAP(ct='O' => 'OWNER'
				    	    ,ct ='C' => 'CONTACT'
						     	,'');
			ENd;
			get_bstatus(string bs) := FUNCTION
				RETURN MAP(      bs ='AB'   => 'Abandonment'
												 , bs ='AC'   => 'Active'
												 , bs ='AD'   => 'Amended'
												 , bs ='AR'   => 'AnnualReport'
												 , bs ='CA'   => 'AddressChange'
												 , bs ='BR'   => 'Bankruptcy'
												 , bs ='CC'   => 'Cancelled'
												 , bs ='CH'   => 'Change'
												 , bs ='CL'   => 'Closed'
												 , bs ='CN'   => 'NameChange'
												 , bs ='CO'   => 'OwnerChange'
												 , bs ='CR'   => 'Correction'
												 , bs ='DL'   => 'Delinquent'
												 , bs ='DS'   => 'disolved'
												 , bs ='EN'   => 'Entry'
												 , bs ='EP'   => 'Expunged'
												 , bs ='EX'   => 'Expired'
												 , bs ='FR'   => 'Forteiture'
												 , bs ='GS'   => 'Goodstanding'
												 , bs ='IA'   => 'Inactive'
												 , bs ='IN'   => 'Incomplete'
												 , bs ='MG'   => 'Mergedin'
												 , bs ='MO'   => 'MergedOut'
												 , bs ='MS'   => 'MergedSurvivor'
												 , bs ='NW'   => 'New'
												 , bs ='PD'   => 'Pending'
												 , bs ='RF'   => 'Renewal'
												 , bs ='RG'   => 'Registration'
												 , bs ='RJ'   => 'Rejected'
												 , bs ='RV'   => 'Revoked'
												 , bs ='RS'   => 'Reinstated'
												 , bs ='SS'   => 'Suspended'
												 , bs ='TF'   => 'Transfer'
												 , bs ='TR'   => 'Terminated'
												 , bs ='WD'   => 'Withdrawal'
												 ,'');
			END;
			get_Contact_NameType(string code) := FUNCTION
				RETURN MAP(code ='P'=>'PERSON'
				           ,code ='C'=>'COMPANY'
									 ,'');
			END;
			clean_int(unsigned6 val) := FUNCTION
				RETURN IF((string)val='0','',(string)val);
			END;
			clean_str(string val) := FUNCTION
				RETURN IF(val='0','',val);
			END;
			out_rec xfm_final(FBNV2_services.Layout_FBN_Report r) := TRANSFORM
			   cnts := r.contacts;
				 SELF.Tmsid_1	:=   cnts[1].Tmsid   ;
				 SELF.Rmsid_1	:=   cnts[1].Rmsid   ;
				 SELF.dt_first_seen_1	:=   clean_int(cnts[1].dt_first_seen)   ;
				 SELF.dt_last_seen_1	:=   clean_int(cnts[1].dt_last_seen )  ;
				 SELF.CONTACT_TYPE_1	:=   get_Ctype(cnts[1].CONTACT_TYPE)   ;
				 SELF.ssn_1	:=   cnts[1].ssn   ;
				 SELF.CONTACT_NAME_1	:=   cnts[1].CONTACT_NAME   ;
				 SELF.CONTACT_STATUS_1	:=   cnts[1].CONTACT_STATUS   ;
				 SELF.CONTACT_PHONE_1	:=   cnts[1].CONTACT_PHONE   ;
				 SELF.CONTACT_NAME_FORMAT_1	:=   get_Contact_NameType(cnts[1].CONTACT_NAME_FORMAT)   ;
				 SELF.CONTACT_ADDR_1_1	:=   format_addr_1(cnts[1]);
				 SELF.CONTACT_ADDR_1_2	:=   format_addr_2(cnts[1]);
				 SELF.CONTACT_CITY_1	:=   cnts[1].v_city_name   ;
				 SELF.CONTACT_STATE_1	:=   cnts[1].st   ;
				 SELF.CONTACT_ZIP_1	:=   format_zip(cnts[1]);
				 SELF.CONTACT_COUNTRY_1	:=   cnts[1].CONTACT_COUNTRY   ;
				 // SELF.CONTACT_FEI_NUM_1	:=   cnts[1].CONTACT_FEI_NUM   ;
				 SELF.CONTACT_CHARTER_NUM_1	:=   cnts[1].CONTACT_CHARTER_NUM   ;
				 SELF.Tmsid_2	:=   cnts[2].Tmsid   ;
				 SELF.Rmsid_2	:=   cnts[2].Rmsid   ;
				 SELF.dt_first_seen_2	:=   clean_int(cnts[2].dt_first_seen)   ;
				 SELF.dt_last_seen_2	:=   clean_int(cnts[2].dt_last_seen)   ;
				 SELF.CONTACT_TYPE_2	:=   get_Ctype(cnts[2].CONTACT_TYPE)   ;
				 SELF.ssn_2	:=   cnts[2].ssn   ;
				 SELF.CONTACT_NAME_2	:=   cnts[2].CONTACT_NAME   ;
				 SELF.CONTACT_STATUS_2	:=   cnts[2].CONTACT_STATUS   ;
				 SELF.CONTACT_PHONE_2	:=   cnts[2].CONTACT_PHONE   ;
				 SELF.CONTACT_NAME_FORMAT_2	:=   get_Contact_NameType(cnts[2].CONTACT_NAME_FORMAT)   ;
				 SELF.CONTACT_ADDR_2_1	:=   format_addr_1(cnts[2]);
				 SELF.CONTACT_ADDR_2_2	:=   format_addr_2(cnts[2]);
				 SELF.CONTACT_CITY_2	:=   cnts[2].v_city_name   ;
				 SELF.CONTACT_STATE_2	:=   cnts[2].st   ;
				 SELF.CONTACT_ZIP_2	:=   format_zip(cnts[2]);
				 SELF.CONTACT_COUNTRY_2	:=   cnts[2].CONTACT_COUNTRY   ;
				 // SELF.CONTACT_FEI_NUM_2	:=   cnts[2].CONTACT_FEI_NUM   ;
				 SELF.CONTACT_CHARTER_NUM_2	:=   cnts[2].CONTACT_CHARTER_NUM   ;
				 SELF.Tmsid_3	:=   cnts[3].Tmsid   ;
				 SELF.Rmsid_3	:=   cnts[3].Rmsid   ;
				 SELF.dt_first_seen_3	:=   clean_int(cnts[3].dt_first_seen)   ;
				 SELF.dt_last_seen_3	:=   clean_int(cnts[3].dt_last_seen)   ;
				 SELF.CONTACT_TYPE_3	:=   get_Ctype(cnts[3].CONTACT_TYPE)   ;
				 SELF.ssn_3	:=   cnts[3].ssn   ;
				 SELF.CONTACT_NAME_3	:=   cnts[3].CONTACT_NAME   ;
				 SELF.CONTACT_STATUS_3	:=   cnts[3].CONTACT_STATUS   ;
				 SELF.CONTACT_PHONE_3	:=   cnts[3].CONTACT_PHONE   ;
				 SELF.CONTACT_NAME_FORMAT_3	:=   get_Contact_NameType(cnts[3].CONTACT_NAME_FORMAT)   ;
				 SELF.CONTACT_ADDR_3_1	:=   format_addr_1(cnts[3]);
				 SELF.CONTACT_ADDR_3_2	:=   format_addr_2(cnts[3]);
				 SELF.CONTACT_CITY_3	:=   cnts[3].v_city_name   ;
				 SELF.CONTACT_STATE_3	:=   cnts[3].st   ;
				 SELF.CONTACT_ZIP_3	:=   format_zip(cnts[3]);
				 SELF.CONTACT_COUNTRY_3	:=   cnts[3].CONTACT_COUNTRY   ;
				 // SELF.CONTACT_FEI_NUM_3	:=   cnts[3].CONTACT_FEI_NUM   ;
				 SELF.CONTACT_CHARTER_NUM_3	:=   cnts[3].CONTACT_CHARTER_NUM   ;
				 SELF.Tmsid_4	:=   cnts[4].Tmsid   ;
				 SELF.Rmsid_4	:=   cnts[4].Rmsid   ;
				 SELF.dt_first_seen_4	:=   clean_int(cnts[4].dt_first_seen)   ;
				 SELF.dt_last_seen_4	:=   clean_int(cnts[4].dt_last_seen)   ;
				 SELF.CONTACT_TYPE_4	:=   get_Ctype(cnts[4].CONTACT_TYPE)   ;
				 SELF.ssn_4	:=   cnts[4].ssn   ;
				 SELF.CONTACT_NAME_4	:=   cnts[4].CONTACT_NAME   ;
				 SELF.CONTACT_STATUS_4	:=   cnts[4].CONTACT_STATUS   ;
				 SELF.CONTACT_PHONE_4	:=   cnts[4].CONTACT_PHONE   ;
				 SELF.CONTACT_NAME_FORMAT_4	:=   get_Contact_NameType(cnts[4].CONTACT_NAME_FORMAT)   ;
				 SELF.CONTACT_ADDR_4_1	:=   format_addr_1(cnts[4]);
				 SELF.CONTACT_ADDR_4_2	:=   format_addr_2(cnts[4]);
				 SELF.CONTACT_CITY_4	:=   cnts[4].v_city_name   ;
				 SELF.CONTACT_STATE_4	:=   cnts[4].st   ;
				 SELF.CONTACT_ZIP_4	:=   format_zip(cnts[4]);
				 SELF.CONTACT_COUNTRY_4	:=   cnts[4].CONTACT_COUNTRY   ;
				 // SELF.CONTACT_FEI_NUM_4	:=   cnts[4].CONTACT_FEI_NUM   ;
				 SELF.CONTACT_CHARTER_NUM_4	:=   cnts[4].CONTACT_CHARTER_NUM   ;
				 SELF.Tmsid_5	:=   cnts[5].Tmsid   ;
				 SELF.Rmsid_5	:=   cnts[5].Rmsid   ;
				 SELF.dt_first_seen_5	:=   clean_int(cnts[5].dt_first_seen)   ;
				 SELF.dt_last_seen_5	:=   clean_int(cnts[5].dt_last_seen)   ;
				 SELF.CONTACT_TYPE_5	:=   get_Ctype(cnts[5].CONTACT_TYPE)   ;
				 SELF.ssn_5	:=   cnts[5].ssn   ;
				 SELF.CONTACT_NAME_5	:=   cnts[5].CONTACT_NAME   ;
				 SELF.CONTACT_STATUS_5	:=   cnts[5].CONTACT_STATUS   ;
				 SELF.CONTACT_PHONE_5	:=   cnts[5].CONTACT_PHONE   ;
				 SELF.CONTACT_NAME_FORMAT_5	:=   get_Contact_NameType(cnts[5].CONTACT_NAME_FORMAT)   ;
				 SELF.CONTACT_ADDR_5_1	:=   format_addr_1(cnts[5]);
				 SELF.CONTACT_ADDR_5_2	:=   format_addr_2(cnts[5]);
				 SELF.CONTACT_CITY_5	:=   cnts[5].v_city_name   ;
				 SELF.CONTACT_STATE_5	:=   cnts[5].st   ;
				 SELF.CONTACT_ZIP_5	:=   format_zip(cnts[5]);
				 SELF.CONTACT_COUNTRY_5	:=   cnts[5].CONTACT_COUNTRY   ;
				 // SELF.CONTACT_FEI_NUM_5	:=   cnts[5].CONTACT_FEI_NUM   ;
				 SELF.CONTACT_CHARTER_NUM_5	:=   cnts[5].CONTACT_CHARTER_NUM   ;
				 SELF.bus_status := get_bstatus(r.bus_status);
				 SELF.ORIG_FILING_DATE := clean_int(r.ORIG_FILING_DATE);
				 SELF.bus_zip := clean_int(r.bus_zip);
				 SELF.bus_zip4 := clean_int(r.bus_zip4);
				 SELF.orig_fein := clean_str(r.orig_fein);
				 SELF.cancellation_date := clean_int(r.cancellation_date);
				 SELF.filing_date  := clean_int(r.filing_date);
				 SELF.expiration_date  := clean_int(r.expiration_date);
				 SELF.bus_comm_date  := clean_int(r.bus_comm_date);
         SELF.dt_first_seen	:=   clean_int(r.dt_first_seen)   ;
				 SELF.dt_last_seen	:=   clean_int(r.dt_last_seen)   ;				 
				 SELf := r;
				 SELF := [];
			END;
			
			res := PROJECT(rpt,xfm_final(LEFT));
			
			
			RETURN res;
		END;
		
	
	END;


END;