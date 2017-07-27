import ut,fbnv2;

dFiling			            := dedup(File_NYC_in,all);

layout_common.contact tFiling(dFiling pInput)
   :=TRANSFORM
           
		    string  clean_address           := if(pInput.clean_owner_address='',pInput.clean_address,pInput.clean_owner_address);
			string  o_address               := if(pInput.owner_address='',
			                                      regexreplace('[ ]+',pInput.STREET_NUMBER+' '+pInput.DIRECTION+
			                                                    pInput.STREET_NAME+' '+pinput.STREET_TYPE+' '+pInput.APARTMENT_NUMBER,' '),
												  regexreplace('[ ]+',pInput.owner_address,' '));			
			string Filing_Jurisdiction      :=Map(pInput.COURT_CODE='1011007'=>'NBX',
												   pInput.COURT_CODE='1011018'=>'NYN',
												   pInput.COURT_CODE='1011028'=>'NKI',
												   pInput.COURT_CODE='1011035'=>'NYN',
												   pInput.COURT_CODE='1011040'=>'NYN',
												   pInput.COURT_CODE='1011048'=>'NQU',
												   pInput.COURT_CODE='1011046'=>'NRI',
												   pInput.COURT_CODE='1011057'=>'NYN',
												   pInput.COURT_CODE='1011060'=>'NYN','');
			
			self.tmsid					    := Filing_Jurisdiction+hash(pInput.business_name);
			self.rmsid					    := pInput.DOCKET_NUMBER ;
			self.dt_first_seen      		:= (integer) pInput.Process_date;
			self.dt_last_seen       		:= (integer) pInput.Process_date;
			self.dt_vendor_first_reported  	:= (integer) pInput.file_date;
			self.dt_vendor_last_reported  	:= (integer) pInput.file_date;
			self.contact_type	    		:= 'O';
			self.contact_name_format		:= IF(pinput.pname='','C','P');
			self.contact_name			    := pInput.owner_Name ;
			self.contact_addr 				:= o_address;
			self.title						:=	pInput.pname[1..5];
			self.fname						:=	pInput.pname[6..25];
			self.mname						:=	pInput.pname[26..45];
			self.lname					    :=	pInput.pname[46..65];
			self.name_suffix				:=	pInput.pname[66..70];
			self.name_score			        :=	pInput.pname[71..73];
			self.prim_range 				:=	clean_address[1..10];			
			self.predir 					:=	clean_address[11..12];			
			self.prim_name 					:=	clean_address[13..40];			
			self.addr_suffix				:=	clean_address[41..44];			
			self.postdir 					:=	clean_address[45..46];			
			self.unit_desig 				:=	clean_address[47..56];			
			self.sec_range 					:=	clean_address[57..64];			
			self.v_city_name 				:=	clean_address[90..114];			
			self.st 						:=	clean_address[115..116];			
			self.zip5 						:=	clean_address[117..121];			
			self.zip4 						:=	clean_address[122..125];			
			self.addr_rec_type				:=	clean_address[139..140];			
			self.fips_state 				:=	clean_address[141..142];			
			self.fips_county 				:=  clean_address[143..145];				
			self.geo_lat 					:=	clean_address[146..155];			
			self.geo_long 					:=	clean_address[156..166];			
			self.cbsa						:=	clean_address[167..170];			
			self.geo_blk 					:=	clean_address[171..177];			
			self.geo_match 					:=	clean_address[178];			
			self.err_stat 					:=	clean_address[179..182];		

	 end;
layout_common.contact  rollupXform(layout_common.contact pLeft, layout_common.contact pRight) 
	:= transform
		
		self.Dt_First_Seen := IF(pLeft.dt_First_Seen > pRight.dt_First_Seen, pRight.dt_First_Seen, pLeft.dt_First_Seen);
		self.Dt_Last_Seen  := IF(pLeft.dt_Last_Seen  < pRight.dt_Last_Seen,  pRight.dt_Last_Seen,  pLeft.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := IF(pLeft.dt_Vendor_First_Reported > pRight.dt_Vendor_First_Reported, 
											pRight.dt_Vendor_First_Reported, pLeft.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := IF(pLeft.dt_Vendor_Last_Reported  < pRight.dt_Vendor_Last_Reported,  
											pRight.dt_Vendor_Last_Reported, pLeft.dt_Vendor_Last_Reported);
		self := pLeft;
	END;
	
dProj   	:=dedup(project(dfiling,tfiling(left)),all);
			
dSort       :=SORT(Distribute(dProj, hash(tmsid)),
                   RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 

dOut    	:=rollup(dSort ,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_out+'persist::FBNV2::NY::contact');
					
export Mapping_FBN_NY_Contact := dout;