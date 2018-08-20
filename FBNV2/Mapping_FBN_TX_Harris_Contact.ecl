import ut,fbnv2,_validate;

dFiling_combined := 
                       // File_TX_Harris_in.Cleaned_Old(file_number <> '') +
                       File_TX_Harris_in.Cleaned(file_number <> '');
dFiling_dist     := distribute(dFiling_combined, hash(FILE_NUMBER));
dFiling_sort     := sort(dFiling_dist, record, local);
dFiling          := dedup(dFiling_sort, record, local);

layout_common.contact_AID tFiling(dFiling pInput)
   :=TRANSFORM
   
			// All versions (old and new) stored as MMDDYYYY, translate back to YYYYMMDD
			string date                     := pInput.DATE_FILED[5..8] + pInput.DATE_FILED[1..4];
			
			self.tmsid					    := 'TXH'+ hash(pInput.CITY1+pInput.NAME1);
			self.rmsid                      := 'T'+if(pInput.FILe_NUMBER<>'',hash(pInput.FILE_NUMBER),
			                                    			if(DATE<>'',hash(DATE),hash(pInput.STREET_ADD1 )));
			self.dt_first_seen      		:= if(_validate.date.fIsValid((string) date), (integer) date,0); 
			self.dt_last_seen       		:= if(_validate.date.fIsValid((string) date), (integer) date,0); 
			self.dt_vendor_first_reported  	:= if(_validate.date.fIsValid((string) pInput.process_date), (integer) pInput.process_date,0); 
			self.dt_vendor_last_reported  	:= if(_validate.date.fIsValid((string) pInput.process_date), (integer) pInput.process_date,0); 
			self.contact_type	    		:= 'O';
			self.contact_NAME          		:= pInput.name2;			
			// NOTE: CONTACT_NAME_FORMAT is taken care of via the NID later down the line, so we leave
			//       it alone here.
			self.contact_ADDR           	:= pInput.STREET_ADD2;        
			self.contact_CITY          		:= pInput.CITY2;            
			self.contact_STATE          	:= pInput.STATE2 ;      
			self.contact_ZIP          		:= (integer)pInput.ZIP2 ;     
			// The new info supposedly stores the person's name properly and doesn't do what the old data did
			self.title										:= if((integer)pInput.process_date > 20110801,
			                                    pInput.name2_title,
																					pInput.name1_title);
			self.fname										:= if((integer)pInput.process_date > 20110801,
			                                    pInput.name2_fname,
																					pInput.name1_fname);
			self.mname										:= if((integer)pInput.process_date > 20110801,
			                                    pInput.name2_mname,
																					pInput.name1_mname);
			self.lname					   				:= if((integer)pInput.process_date > 20110801,
			                                    pInput.name2_lname,
																					pInput.name1_lname);
			self.name_suffix							:= if((integer)pInput.process_date > 20110801,
			                                    pInput.name2_name_suffix,
																					pInput.name1_name_suffix);
			self.name_score			       		:= if((integer)pInput.process_date > 20110801,
			                                    '',
																					pInput.name1_name_score);
			self.Prep_Addr_Line1			:= pInput.prep_addr1_line1;
			self.Prep_Addr_Line_last	:= pInput.prep_addr1_line_last;
			self                			:= pInput;
	 end;

layout_common.contact_AID  rollupXform(layout_common.contact_AID pLeft, layout_common.contact_AID pRight) 
	:= transform
	
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := MAX(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := MAX(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);

		self := pLeft;
	END;
	
// DEDUP removed because it's unnecessary
dSortFiling	:=SORT(DISTRIBUTE(project(dfiling,tfiling(left)),hash(tmsid))
					,RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local); 
					
dout        :=rollup(dSortFiling,rollupXform(left,right),
					RECORD,except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported,local)
					:persist(cluster.cluster_out+'persist::FBNV2::TXH::CONTACT');
export Mapping_FBN_TX_Harris_Contact :=dOut;