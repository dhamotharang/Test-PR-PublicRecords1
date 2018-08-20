﻿import ut,fbnv2,_validate;
		
dFiling			       := dedup(sort(
                                 // File_CA_ventura_in.Cleaned_Old(BUSINESS_NAME<>'') +
																 File_CA_ventura_in.Cleaned(BUSINESS_NAME<>''),instrument_id,-process_date),all,except process_date);

layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
			string8  dtFirst := (string) ut.Min2((integer) pInput.recorded_date,(integer) pInput.start_date);   
      string8  dtLast  := (string) MAX((integer) pInput.recorded_date,(integer) pInput.start_date);
			
            self.tmsid					    := 'CAV'+hasH(pInput.BUSINESS_NAME) ;
			self.rmsid					    := pINput.instrument_id;    
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) dtFirst), (integer) dtFirst,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) dtLast),  (integer) dtLast,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.recorded_date), (integer) pInput.recorded_date,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.recorded_date), (integer) pInput.recorded_date,0); 
			self.contact_type	    		:= 'O';
			self.contact_NAME          		:= if(pInput.Cname='',trim(pInput.owner_firstname)+' '
			                                                      +trim(pInput.owner_name,left,right),
			                                                      pInput.cname);			
			self.contact_NAME_FORMAT        := if(pInput.Owner_cln_fname='' and pInput.Owner_cln_lname='','C','P');
			self.contact_ADDR           	:= pInput.OWNER_ADDRESS;       
			self.contact_CITY          		:= pInput.OWNER_CITY ;         
			self.contact_STATE          	:= pInput.OWNER_STATE  ;       
			self.contact_ZIP          		:= (integer)pInput.owner_zipcode5  ;    
			self.title										:=	pInput.Owner_cln_title;
			self.fname										:=	pInput.Owner_cln_fname;
			self.mname										:=	pInput.Owner_cln_mname;
			self.lname					    			:=	pInput.Owner_cln_lname;
			self.name_suffix							:=	pInput.Owner_cln_name_suffix;
			self.name_score			        	:=	pInput.Owner_cln_name_score;
/*
			self.prim_range 				:=	pInput.clean_owner_address[1..10];			
			self.predir 					:=	pInput.clean_owner_address[11..12];			
			self.prim_name 					:=	pInput.clean_owner_address[13..40];			
			self.addr_suffix				:=	pInput.clean_owner_address[41..44];			
			self.postdir 					:=	pInput.clean_owner_address[45..46];			
			self.unit_desig 				:=	pInput.clean_owner_address[47..56];			
			self.sec_range 					:=	pInput.clean_owner_address[57..64];			
			self.v_city_name 				:=	pInput.clean_owner_address[90..114];			
			self.st 						:=	pInput.clean_owner_address[115..116];			
			self.zip5 						:=	pInput.clean_owner_address[117..121];			
			self.zip4 						:=	pInput.clean_owner_address[122..125];			
			self.addr_rec_type				:=	pInput.clean_owner_address[139..140];			
			self.fips_state 				:=	pInput.clean_owner_address[141..142];			
			self.fips_county 				:=  pInput.clean_owner_address[143..145];				
			self.geo_lat 					:=	pInput.clean_owner_address[146..155];			
			self.geo_long 					:=	pInput.clean_owner_address[156..166];			
			self.cbsa						:=	pInput.clean_owner_address[167..170];			
			self.geo_blk 					:=	pInput.clean_owner_address[171..177];			
			self.geo_match 					:=	pInput.clean_owner_address[178];			
			self.err_stat 					:=	pInput.clean_owner_address[179..182];
*/
			self.Prep_Addr_Line1 			:= pInput.Prep_Owner_Addr_Line1;
			self.Prep_Addr_Line_Last 	:= pInput.Prep_Owner_Addr_Line_Last;
			self                			:= pinput;
			//self                			:= [];

	 end;

layout_common.contact_AID  rollupXform(layout_common.contact_AID pLeft, layout_common.contact_AID pRight) 
	:= transform
		
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
	    self := pLeft;
	END;
	
dSortFiling	:=SORT(DISTRIBUTE(dedup(project(dfiling,tfiling(left))
              // +FBNV2.Mapping_FBN_CA_Ventura_Contact_xml
							,all),hash(tmsid))
					,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
					
dout        :=rollup(dSortFiling,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_out+'persist::FBNv2::CA::ventura::CONTACT');
export Mapping_FBN_CA_Ventura_Contact := dOut;