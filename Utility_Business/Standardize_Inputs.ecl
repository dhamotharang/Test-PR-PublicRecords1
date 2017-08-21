import Address, Ut, lib_stringlib, _Control, business_header,_Validate, UtilFile;

// -- Merge Entity and SVCAddr file 
// -- normalize and slim record for date cleaning, keep unique id
// -- match back on unique id to get addresses and dates
export Standardize_Inputs := module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	export fMergeEntityWithSVCAddr(dataset(Layouts.Input.entity_raw) pEntityFile, dataset(Layouts.Input.svcaddr_raw) pSVCAddrFile) := function

		layout_extended := Utility_Business.Layouts.EntitySVCAddr;

		layout_extended joinEntitySVCAddr(Layouts.input.entity_raw l, Layouts.input.svcaddr_raw r) := transform
				self := l;
				self := r;
		end;

		extended_file := join(pEntityFile, pSVCAddrFile, trim(left.cps_sig_ent,left,right) = trim(right.cps_sig_ent,left,right), joinEntitySVCAddr(left,right));
		
		return extended_file;
		
	end;

	
	//////////////////////////////////////////////////////////////////////////////////////////
	// - Standardize the address and join name parts to make the company name
	//////////////////////////////////////////////////////////////////////////////////////////
	export fCleanAddress(dataset(Layouts.EntitySVCAddr) pEntitySVCAddr, string pversion) :=
	function
		
		Layouts.CleanAddr tCleanFields(Layouts.EntitySVCAddr l) :=	transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Prepare Addresses for Cleaning using macro
			//////////////////////////////////////////////////////////////////////////////////////
			address1 :=	
						trim(l.Addr_House_Num) + ' ' + trim(l.Addr_Street_Name) + ' ' + trim(l.Addr_Suff)
						+ ' ' + trim(l.Addr_Pre_Dir) + ' ' + trim(l.Addr_Apt_Num)
					;        
			address2 :=	
										trim(l.Addr_City		)
					+ ', '	+ trim(l.Addr_State_Abbr	)
					+ ' '		+ trim(l.Addr_Postal_Code	)
					;                

			Phone					:= 	ut.CleanPhone(l.Phone					);			
																										
                                
			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////                                    
			self.clean_phone									:= Phone;
	
			clean_addr												:= stringlib.StringToUpperCase(if(trim(address1) + trim(address2) <> '', 
																							Address.CleanAddress182(trim(address1),trim(address2)),''));
			self.prim_range										:= clean_addr[1..10];
			self.predir 	            				:= clean_addr[11..12];
			self.prim_name 	  	        			:= clean_addr[13..40];
			self.addr_suffix   	       				:= clean_addr[41..44];
			self.postdir 	    	    					:= clean_addr[45..46];
			self.unit_desig 	        				:= clean_addr[47..56];
			self.sec_range 	  	        			:= clean_addr[57..64];
			self.p_city_name	        				:= clean_addr[65..89];
			self.v_city_name	      				  := clean_addr[90..114];
			self.st		 			       						:= clean_addr[115..116];
			self.zip	 		            				:= clean_addr[117..121];
			self.zip4 		           					:= clean_addr[122..125];
			self.cart 		            				:= clean_addr[126..129];
			self.cr_sort_sz 	 	    					:= clean_addr[130];
			self.lot 		      	    					:= clean_addr[131..134];
			self.lot_order 	  	        			:= clean_addr[135];
			self.dbpc 		            				:= clean_addr[136..137];
			self.chk_digit 	  	       				:= clean_addr[138];
			self.rec_type		  	    					:= clean_addr[139..140];			
			self.county 		    							:= clean_addr[141..145];
			self.geo_lat 	    	    					:= clean_addr[146..155];
			self.geo_long 	           				:= clean_addr[156..166];
			self.msa 		      	    					:= clean_addr[167..170];
			self.geo_blk											:= clean_addr[171..177];
			self.geo_match 	  	        			:= clean_addr[178];
			self.err_stat 	            			:= clean_addr[179..182];
			
			string fmname 										:= if(length(trim(l.Name_First,left,right)) = 20, 
																							trim(l.Name_First) + trim(l.Name_Mid),
																							trim(l.Name_First) + ' ' + trim(l.Name_Mid));   
			string100 cname										:= if(UtilFile.fFixCompanyName.IsStrFound(UtilFile.fFixCompanyName.pLFMPattern, fmname),
																							UtilFile.fFixCompanyName.fMakeCompanyName1(trim(l.Name_Last),  trim(l.Name_First), trim(l.Name_Mid), trim(l.Name_Suffix)),
																							UtilFile.fFixCompanyName.fMakeCompanyName(trim(l.Name_Last),  trim(l.Name_First), trim(l.Name_Mid), trim(l.Name_Suffix)));
			self.Company_Name									:= UtilFile.fFixCompanyName.FixBrokenWords(trim(cname,left,right));
			self.Name_Flag										:= '';
			self															:= l;
		end;
		
		dCleaned := project(pEntitySVCAddr, tCleanFields(left));
		
		Address.Mac_Is_Business(dCleaned, Company_Name, dCleaned_out, name_flag);
	
		return dCleaned_out;

	end;
	
	export fMapToUtilBusBase(dataset(Layouts.CleanAddr) pCleanedEntitySVCAddr, string pversion) :=
	function
	
		Layouts.Base tMapToUtilBusBase(Layouts.CleanAddr l) :=	transform, skip(l.name_flag <> 'B')

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			////////////////////////////////////////////////////////////////////////////////////// 
			self.id														:= trim(l.vend_ref_num);
			self.record_date									:= trim(l.Cln_Vend_Add_Dte);
			self.date_added_to_exchange				:= trim(l.Cps_load_Dttm[7..10] + l.Cps_load_Dttm[1..2] + l.Cps_load_Dttm[4..5]);
			self.date_first_seen							:= trim(l.Cln_svc_dte);	
			
			self.orig_lname										:= trim(l.Name_Last);
			self.orig_fname										:= trim(l.Name_First);
			self.orig_mname										:= trim(l.Name_Mid);
			self.orig_name_suffix							:= trim(l.Name_Suffix);
			self.ssn													:= trim(l.cln_ssn);
			self.drivers_license_state_code		:= trim(l.DL_State_Abbr);
			self.drivers_license							:= trim(l.Cln_DL_Num);
			self.addr_type										:= trim(l.Cps_Addr_type_cd);
			self.address_street								:= trim(l.Addr_House_Num);
			self.address_street_name					:= trim(l.Addr_Street_Name);
			self.address_street_type					:= trim(l.Addr_Suff);
			self.address_street_direction			:= trim(l.Addr_Pre_Dir);
			self.address_apartment						:= trim(l.Addr_Apt_Num);
			self.address_city									:= trim(l.Addr_City);
			self.address_state								:= trim(l.Addr_State_Abbr);
			self.address_zip									:= trim(l.Addr_Postal_Code);
			self.phone												:= trim(l.clean_phone);
			self.source												:= 'CP';
			self															:= l;
			self															:= [];
		end;
		
		dMapToUtilBusBase := project(pCleanedEntitySVCAddr, tMapToUtilBusBase(left));
		
		dUtilBusBase := dedup(sort(dMapToUtilBusBase, record),record);
	
		return dUtilBusBase;

	end;

	
	export fAll( dataset(Layouts.input.entity_raw	)		pEntityFileInput
							,dataset(Layouts.input.svcaddr_raw	)	pSVCAddrFileInput
							,string													pversion
	) :=
	function
	
		dMergeEntityWithSVCAddr		:= fMergeEntityWithSVCAddr(pEntityFileInput, pSVCAddrFileInput);
		dCleaned									:= fCleanAddress					(dMergeEntityWithSVCAddr, pversion	);
		dUtilBusBase							:= fMapToUtilBusBase			(dCleaned, pversion);
		
  	return dUtilBusBase;
	
	end;

end;