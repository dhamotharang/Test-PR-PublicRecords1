import FBNv2,_validate,ut, address, data_services;

 Fbn_in:=cleaned_fbn_experian_bdid;

        reformatDate(string rDate) := function
			string8 newDate := rDate[5..]+rDate[1..2]+rDate[3..4];	
			return  newDate	;	 
		end;

 trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end;
FBNv2.layout_common.Business_AID transHistFBN(Fbn_in  pInput):=transform


            			
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
			self.filing_jurisdiction        := pinput.Filing_state;
			self.filing_number           	:= pInput.Filing_Number; 
			self.FILING_TYPE                :='DBA';
			self.BUS_NAME                   :=trim(pInput.cname,left,right);									
			self.BUS_ADDRESS1				:=trimUpper(pinput.address);
			self.BUS_CITY     				:=trimUpper(pinput.CITY);           	
			self.BUS_STATE  				:=trimUpper(pinput.state);            	
			self.BUS_ZIP					:=(integer)trim(pinput.ZIP_code[1..5],left,right);
			self.BUS_PHONE_NUM              :=If((integer)pInput.bus_phone<>0,trim(pInput.bus_phone ,left,right),'');
			Self.bus_Zip4 := if((integer)(string)pinput.zip_code[6..]<>0 and trimUpper(pInput.Name_type)='B',(integer)pinput.zip_code[6..],0);
			self.Filing_date := (integer)(string)if(trim(reformatDate(pInput.FILING_DaTE),left,right)<>''
																							,if(_validate.date.fIsValid((string) (reformatDate(pInput.FILING_DATE))), (integer) (reformatDate(pInput.FILING_DATE)),0)
																							,0);									
			self.fips_state 				:= pinput.Bus_fips_state	; 
			self.fips_county 				:= pinput.Bus_fips_county	; 
	/*
			self.prim_range 				:= pinput.Bus_prim_range	;
			self.predir 					:= pinput.Bus_predir	;
			self.prim_name 					:= pinput.Bus_prim_name	;
			self.addr_suffix				:= pinput.Bus_addr_suffix	;
			self.postdir 					:= pinput.Bus_postdir	;
			self.unit_desig 				:= pinput.Bus_unit_desig	;
			self.sec_range 					:= pinput.Bus_sec_range	;
			self.v_city_name 				:= pinput.Bus_v_city_name	;
			s                               :=['XX','XY','YX'];
			self.st 						:= if(pinput.Bus_st not in s,pinput.Bus_st,'')	;
			self.zip5 						:= pinput.Bus_zip5	;
			self.zip4 						:= pinput.Bus_zip4	;
			self.addr_rec_type				:= pinput.Bus_addr_rec_type	;
			self.fips_state 				:= pinput.Bus_fips_state	;
			self.fips_county 				:= pinput.Bus_fips_county	;
			self.geo_lat 					:= pinput.Bus_geo_lat	;
			self.geo_long 					:= pinput.Bus_geo_long	;
			self.cbsa						:= pinput.Bus_cbsa	;
			self.geo_blk 					:= pinput.Bus_geo_blk	;
			self.geo_match 					:= pinput.Bus_geo_match	;
			self.err_stat 					:= pinput.Bus_err_stat	;
*/		
			st                        := ['XX','XY','YX'];	
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
			self.bdid                       := pinput.bdid;		
			self                            := pinput;
	end;

Business						:=	project(Fbn_in,transHistFBN(left));    
	
 fips_to_countyLayout := RECORD 
			string2 state_code; 
			string2 state_fips; 
			string3 county_fips; 
			string18 county_name; 
			string1 lf; 
		END; 
		
	fips_to_countyTable := dataset(data_services.foreign_prod + 'thor_data400::in::fips_to_counties',fips_to_countyLayout,flat); 
		
		FBNv2.layout_common.Business_AID   findCountyName(Business L, fips_to_countyLayout r) := transform 
				fips_county1 := L.fips_county; 
				fips_state1	:= L.fips_state	; 
				Self.BUS_COUNTY := If (fips_county1<>'' and fips_state1<>'', R.county_name, ''); 
				self                        := L; 
		end; // end transform 
		
		
		joinFips_to_county := 	join(Business,fips_to_countyTable, 
									trim(left.fips_state, left,right) = trim(right.state_fips,left,right) and 
									trim(left.fips_county, left,right) = trim(right.county_fips,left,right), 
									findCountyName(left,right),	left outer, lookup); 
									
	
	FBNv2.layout_common.Business_AID  rollupXform(FBNv2.layout_common.Business_AID pLeft, FBNv2.layout_common.Business_AID pRight) := transform
		self.dt_first_seen 				:= ut.min2(pleft.dt_first_seen,pright.dt_first_seen);
		self.dt_last_seen  				:= MAX(pleft.dt_last_seen ,pright.dt_last_seen);
		self.dt_vendor_first_reported 	:= ut.min2(pleft.dt_vendor_first_reported,pright.dt_vendor_first_reported);
		self.dt_vendor_last_reported  	:= MAX(pleft.dt_vendor_last_reported,pright.dt_vendor_last_reported);
		self 							:= pLeft;
    end;
	
	FBNv2.layout_common.Business_AID Trans_Rmsid(FBNv2.layout_common.Business_AID pLeft,string2 c ) := transform  
		self.rmsid          			:=	if(trim(C,left,right)='1',pleft.rmsid,trim(C,left,right)+trim(pleft.rmsid));
		self                			:=	pLeft;
	end;
				  
	                
	dist_FBN  						:=  distribute(joinFips_to_county,hash(tmsid));
	sort1_FBN 						:=  sort(dist_FBN,RECORD,local);
	dedup_FBN 						:=  dedup(sort1_FBN,RECORD,local);
	sort2_FBN 						:=  sort(dedup_FBN,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,bus_zip4,local);
				  
	FBN_Rollup     					:= rollup(sort2_FBN,rollupXform(left,right),
											RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,bus_zip4,local);

	FBN_Group      					:= group(sort(distribute(FBN_Rollup,hash(tmsid,rmsid)),
												tmsid,rmsid,dt_first_seen,local),
												tmsid,rmsid,local);
									   			  			              					
	FBN_Business_Out       			:=	Project(FBN_Group,Trans_Rmsid(left,(string2) counter),local):persist(cluster.cluster_out+'persist::FBNV2::Fbn_Experian_CommonBusiness');
		
	export Mapping_FBN_Experian_Business :=	FBN_Business_Out;