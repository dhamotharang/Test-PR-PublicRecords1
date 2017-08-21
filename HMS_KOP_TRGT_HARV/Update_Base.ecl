IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility,hms_kop_trgt_harv,Scrubs;


EXPORT Update_Base (string filedate, boolean pUseProd = false) := MODULE


	EXPORT KopTrgtHarv_Base := FUNCTION
   	
			// hist_base	:= hms_kop_trgt_harv.Files(filedate,pUseProd).koptrgtharv_Base.built;
				
			//Cumulative
			std_input := hms_kop_trgt_harv.StandardizeInputFile(filedate, pUseProd).koptrgtharv;
			

			cleanNames := Fn_Clean.Parsed_name(std_input, hms_kop_trgt_harv.Layouts.LAYOUT_BASE, First, Middle, Last, Suffix);//Clean_name(std_input,hms_kop_trgt_harv.Layouts.layout_base,0)
									// :PERSIST('~thor400_data::persist::hms_kop_trgt_harv::stlic_names');
			
/* 			HMS_KOP_TRGT_HARV.LAYOUTS.LAYOUT_BASE resetZip(HMS_KOP_TRGT_HARV.LAYOUTS.LAYOUT_BASE L) := transform
   						self.zip := '';
   						self := L;
   			end;
   			
   			cleanNames := project(cleanNames_temp,resetZip(LEFT));
*/
			
			cleanAddr :=  Fn_Clean.Address(cleanNames); //Clean_addr(UniqueAddresses,hms_kop_trgt_harv.Layouts.layout_base)
														// :PERSIST('~thor400_data::persist::hms_kop_trgt_harv::stlic_uniq_addr');	
			
															 
	 		base_f := DISTRIBUTE(cleanAddr); //DISTRIBUTE(base_and_update); 
			
			new_base_s := SORT(base_f,
   											 first,
												 middle,
												 last,
												 suffix,
												 cred,
												 practitioner_type,
												 firm_name,
												 address1,
												 address2,
												 city,
												 state,
												 zip,
												 phone1,
												 phone2,
												 fax1,
												 date_born,
												 date_died,
												 gender,
												 stlic_number,
												 stlic_state,
												 stlic_type,
												 stlic_status,
												 stlic_qualifier,
												 stlic_subqualifier,
												 stlic_issue_date,
												 stlic_exp_date,
												 npi,
												 taxonomy_code,
												 dea1,
												 hms_spec1,
												 hms_spec2,
											LOCAL);
   		
   		HMS_KOP_TRGT_HARV.LAYOUTS.LAYOUT_BASE t_rollup(new_base_s L, new_base_s R) := TRANSFORM
   			// SELF.stlic_issue_date := ut.EarliestDate(L.stlic_issue_date, R.stlic_issue_date);
   			// SELF.stlic_exp_date  := ut.LatestDate	(L.stlic_exp_date, R.stlic_exp_date);
   			SELF 		 						:= IF(L.clean_stlic_exp_date>R.clean_stlic_exp_date,L,R);
				// SELF := L;
			END;
   
   		audit_base := ROLLUP(new_base_s
											,trim(left.first)=trim(right.first)
											AND trim(left.middle)=trim(right.middle)
											AND trim(left.last)=trim(right.last)
											AND trim(left.suffix)=trim(right.suffix)
											AND trim(left.cred)=trim(right.cred)
											AND trim(left.practitioner_type)=trim(right.practitioner_type)
											AND trim(left.firm_name)=trim(right.firm_name)
											AND trim(left.address1)=trim(right.address1)
											AND trim(left.address2)=trim(right.address2)
											AND trim(left.city)=trim(right.city)
											AND trim(left.state)=trim(right.state)
											AND trim(left.zip)=trim(right.zip)
											AND trim(left.phone1)=trim(right.phone1)
											AND trim(left.phone2)=trim(right.phone2)
											AND trim(left.fax1)=trim(right.fax1)
											AND trim(left.date_born)=trim(right.date_born)
											AND trim(left.date_died)=trim(right.date_died)
											AND trim(left.gender)=trim(right.gender)
											AND trim(left.stlic_number)=trim(right.stlic_number)
											AND trim(left.stlic_state)=trim(right.stlic_state)
											AND trim(left.stlic_type)=trim(right.stlic_type)
											AND trim(left.stlic_status)=trim(right.stlic_status)
											AND trim(left.stlic_qualifier)=trim(right.stlic_qualifier)
											AND trim(left.stlic_subqualifier)=trim(right.stlic_subqualifier)
											AND trim(left.stlic_issue_date)=trim(right.stlic_issue_date)
											AND trim(left.stlic_exp_date)=trim(right.stlic_exp_date)
											AND trim(left.npi)=trim(right.npi)
											AND trim(left.taxonomy_code)=trim(right.taxonomy_code)
											AND trim(left.dea1)=trim(right.dea1)
											AND trim(left.hms_spec1)=trim(right.hms_spec1)
											AND trim(left.hms_spec2)=trim(right.hms_spec2)
											,t_rollup(LEFT,RIGHT),LOCAL);	
						
   		Health_Provider_Services.mac_get_best_lnpid_on_thor (
      									 audit_base 
      									,lnpid
      									,fname
      									,mname
      									,lname
      									,name_suffix
      									,gender
      									,prim_range
      									,prim_name
      									,sec_range
      									,p_city_name
      									,st
      									,zip 
      									,//best_ssn
      									,date_born
      									,phone1
      									,stlic_state
      									,stlic_number
      									,//tin1
      									,dea1
      									,//group_key
      									,npi
      									,//UPIN
      									,//DID
      									,//BDID
      									,//SRC
      									,//SOURCE_RID
      									,dLnpidOut,false,38 //38 for providers
      				);
			
			with_lnpid:=dLnpidOut(lnpid>0);
			no_lnpid:=dLnpidOut(lnpid=0);
			
 			Health_Facility_Services.mac_get_best_lnpid_on_thor (
   									no_lnpid
   									,lnpid
   									,											
   									,prim_range
   									,prim_name
   									,sec_range
   									,p_city_name
   									,st
   									,zip
   									,//sanc_tin
   									,//tin1
   									,phone1
   									,fax1
   									,stlic_state
   									,stlic_number
   									,dea1
   									,//group_key
   									,npi
   									,//clia_num
   									,//medicare_fac_num
   									,//Input_MEDICAID_NUMBER
   									,//ncpdp_id
   									,taxonomy_code
   									,
   									,
   									,
   									,result
   									,false
   									,30 //30 for facilities
   									);

			
		
				final_base := with_lnpid + result;
				
				
				RETURN final_base;						

   END;

END;