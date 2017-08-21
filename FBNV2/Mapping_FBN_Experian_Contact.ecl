import FBNv2, _validate,UT,address;
Fbn_in:=cleaned_fbn_experian_did ;
        reformatDate(string rDate) := function
			string8 newDate := rDate[5..]+rDate[1..2]+rDate[3..4];	
			return  newDate	;	
		end;
				trimUpper(string s) := function
				return trim(stringlib.StringToUppercase(s),left,right);
		        end;

FBNv2.layout_common.contact_AID transHistFBN(Fbn_in pInput):=transform


            			
			self.tmsid					    :=pInput.tmsid;
			self.rmsid                      :=pInput.rmsid;	
			self.dt_first_seen      		:= (integer) if( _validate.date.fIsValid(trim(reformatDate(pinput.Filing_Date),left,right)) and 
															 ((integer)trim(reformatDate(pinput.Filing_Date),left,right) ) <> 0,trim(reformatDate(pinput.Filing_Date),left,right),'');
			self.dt_last_seen       		:=  (integer) if( _validate.date.fIsValid(trim(reformatDate(pinput.Filing_Date),left,right)) and 
															 ((integer)trim(reformatDate(pinput.Filing_Date),left,right) ) <> 0,trim(reformatDate(pinput.Filing_Date),left,right),'');
			self.dt_vendor_first_reported  	:=(integer)if( _validate.date.fIsValid(trim(reformatDate(pinput.Insert_Date),left,right)) and 
																	((integer)trim(reformatDate(pinput.Insert_Date),left,right)) <> 0,
																	trim(reformatDate(pinput.Insert_Date),left,right),'');
			self.dt_vendor_last_reported  	:= (integer)if( _validate.date.fIsValid(trim(reformatDate(pinput.Insert_Date),left,right)) and 
																	((integer)trim(reformatDate(pinput.Insert_Date),left,right))<> 0,
																	trim(reformatDate(pinput.Insert_Date),left,right),'');
			list1                           :=['O','W']; 
			list2                           :=['R','A','F','L'];
			self.contact_type	    		:= if(trimUpper(pinput.Name_type)in list1,
												 'O',if(trimUpper(pinput.Name_type)in list2,
												 'C',''));
			self.contact_name_format        :=if((integer)pinput.Name_code =1,'C',if((integer) pinput.Name_code =2,'P',''));
			self.CONTACT_PHONE              :=if((integer)trim(pInput.Officer_phone,left,right)<> 0,trim(pInput.Officer_phone,left,right),'');
			self.title						:= pInput.title;
            self.fname						:= pInput.fname;
			self.mname						:= pInput.mname;
			self.lname					    := pInput.lname;
			self.name_suffix				:= pInput.name_suffix;
			self.name_score			        := pInput.name_score;
			self.contact_name			    := trim(pinput.officerName,left,right);															
			self.contact_addr 				:= trimUpper(pinput.address);																
			self.contact_city				:= trimUpper(pinput.city);
			st                              :=['XX','XY','YX'];
			self.contact_state				:= if(pinput.state not in st ,trimUpper(pinput.state),'');																										
			self.contact_zip				:= if((integer)(string)pinput.zip_code[6..]<>0 ,(integer)trim(pinput.zip_code,left,right),(integer)pinput.zip_code[1..5]);			
/*
			self.prim_range 				:= pinput.Contact_prim_range	;
			self.predir 					:= pinput.Contact_predir	;
			self.prim_name 					:= pinput.Contact_prim_name	;
			self.addr_suffix				:= pinput.Contact_addr_suffix	;
			self.postdir 					:= pinput.Contact_postdir	;
			self.unit_desig 				:= pinput.Contact_unit_desig	;
			self.sec_range 					:= pinput.Contact_sec_range	;
			self.v_city_name 				:= pinput.Contact_v_city_name	;
			self.st 						:= pinput.Contact_st	;
			self.zip5 						:= pinput.Contact_zip5	;
			self.zip4 						:= pinput.Contact_zip4	;
			self.addr_rec_type				:= pinput.Contact_addr_rec_type	;
			self.fips_state 				:= pinput.Contact_fips_state	;
			self.fips_county 				:= pinput.Contact_fips_county	;
			self.geo_lat 					:= pinput.Contact_geo_lat	;
			self.geo_long 					:= pinput.Contact_geo_long	;
			self.cbsa						:= pinput.Contact_cbsa	;
			self.geo_blk 					:= pinput.Contact_geo_blk	;
			self.geo_match 					:= pinput.Contact_geo_match	;
			self.err_stat 					:= pinput.Contact_err_stat	;
*/			
			self.prep_addr_line1		 := address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(pinput.address,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(pinput.city))
																					,if(stringlib.stringtouppercase(trim(pinput.state)) not in st,stringlib.stringtouppercase(trim(pinput.state)),'')
																					,pinput.ZIP_code[1..5]);
			self.did                        := pinput.did;		
			self                            := pinput;
	end;
			
		
		
		fbnv2.layout_common.contact_AID  rollupXform(fbnv2.layout_common.contact_AID pLeft, fbnv2.layout_common.contact_AID pRight) := transform
		
			self.Dt_First_Seen 			  := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
			self.Dt_Last_Seen  			  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
			self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
			self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
			self 						  := pLeft;
	  END;

	FBN_Contact				    := project(Fbn_in,transHistFBN(left));                         
	dist_FBN_Contact  			:= distribute(FBN_Contact,hash(tmsid));
	sort1_FBN_Contact 			:= sort(dist_FBN_Contact,RECORD,local);
	dedup_FBN_Contact 			:= dedup(sort1_FBN_Contact,RECORD,local);
	sort2_FBN_Contact 			:= sort(dedup_FBN_Contact,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,contact_zip,local);

FBN_Contact_Out    	 		    :=rollup(sort2_FBN_Contact,rollupXform(left,right),
												RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
														:persist(cluster.cluster_out+'persist::FBNV2::fbn_experian_CommonContact');

export Mapping_FBN_Experian_Contact := FBN_Contact_Out ;