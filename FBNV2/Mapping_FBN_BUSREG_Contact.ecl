import ut,fbnv2,address,_validate;

contIn	  := FBNV2.File_BUSREG_Contact_in;			

trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end; 
 
layout_common.contact_AID createFBN(contIn pInput)
   :=TRANSFORM
           			
			self.tmsid					    	:= 'ACU'+hash64(trim(pInput.mail_zip_orig,left,right) + trim(pInput.company_name,left,right));
			self.rmsid              	:= ''+if(trim(pInput.dt_last_seen,left,right)<>'',
																				 trim(pInput.dt_last_seen,left,right),													 
																				 if(trim(pInput.dt_first_seen,left,right)<>'',
																						trim(pinput.dt_first_seen,left,right),
																						''));
			self.dt_first_seen      	:= if(_validate.date.fIsValid((string)pInput.dt_first_seen),(integer) pInput.dt_first_seen,0);
			self.dt_last_seen       	:= if(_validate.date.fIsValid((string)pInput.dt_last_seen),(integer) pInput.dt_last_seen,0);
			self.contact_type	    		:= if(trimUpper(pinput.title)='OWN',
																			'O',
																			'C');
			self.contact_name_format  := if(trim(pinput.name,left,right)='',
																			'C',
																			'P');
			self.contact_name			    := trim(pinput.name,left,right);																
			self.contact_phone				:= trim(pinput.phone,left,right);															
			self.contact_addr 				:= trim(pinput.add,left,right);																
			self.contact_city					:= pinput.p_city_name;												
			self.contact_state				:= pinput.st;																										
			self.contact_zip					:= (integer)pinput.zip;																
			self.contact_fei_num			:= (integer)pinput.fein;		
			self.ssn									:= pinput.ssn;																
			self.seq_no								:= 0;														
			self.title								:= pInput.name_prefix;
			self.fname								:= pInput.name_first;
			self.mname								:= pInput.name_middle;
			self.lname					    	:= pInput.name_last;
			self.name_suffix					:= pInput.name_suffix;
			self.name_score			      := pInput.name_score;
/*			
			self.prim_range 					:= pInput.prim_range;
			self.predir 							:= pInput.predir;			
			self.prim_name 						:= pInput.prim_name;
			self.addr_suffix					:= pInput.addr_suffix;
			self.postdir 							:= pInput.postdir;
			self.unit_desig 					:= pInput.unit_desig;
			self.sec_range 						:= pInput.sec_range;
			self.v_city_name 					:= pInput.v_city_name;
			self.st 									:= pInput.st;
			self.zip5 								:= pInput.zip;
			self.zip4 								:= pInput.zip4;
			self.addr_rec_type				:= pInput.rec_type;
			self.fips_state 					:= pInput.ace_fips_st;
			self.fips_county 					:= pInput.fipscounty;
			self.geo_lat 							:= pInput.geo_lat;
			self.geo_long 						:= pInput.geo_long;
			self.cbsa									:= pInput.msa;
			self.geo_blk 							:= pInput.geo_blk;
			self.geo_match 						:= pInput.geo_match;
			self.err_stat 						:= pInput.err_stat;

			self.prep_addr_line1			:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pinput.add,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last	:= address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pinput.loc_city))
																					,stringlib.stringtouppercase(trim(pinput.loc_state))
																					,pinput.loc_zip_orig);
*/		
			self.prep_addr_line1			:= pInput.prep_addr_line1;
			self.prep_addr_line_last	:= pInput.prep_addr_line_last;
			self.RawAid 							:= pInput.Append_RawAID;
			self.ACEAid 							:= pInput.Append_ACEAID;
			self.did									:= pinput.did;
			self                			:= pinput;
			self                			:= [];
			end;
layout_common.contact_AID  rollupXform(layout_common.contact_AID pLeft, layout_common.contact_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
		self := pLeft;
	END;

dsFBN		:= project(contIn,createFBN(left));                          
dist_dsFBN  := distribute(dsFBN,hash64(tmsid));
sort1_dsFBN := sort(dist_dsFBN,RECORD,local);
dedup_dsFBN := dedup(sort1_dsFBN,RECORD,local);
sort2_dsFBN := sort(dedup_dsFBN,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,contact_zip,local);

dOut    	 :=rollup(sort2_dsFBN,rollupXform(left,right),
			   		 RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					 :persist(cluster.cluster_out+'persist::FBNV2::BUSREG::Contact');
					
export Mapping_FBN_BUSREG_Contact := dout;
