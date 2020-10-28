import STD, address;

string uc(string s) := Std.Str.ToUpperCase(s);

reclean(DATASET(Nac_v2.Layouts.baseHistorical) filein) := FUNCTION
	
	
		//UniqueAddresses := dedup(filein, Prepped_addr1,Prepped_addr2,all);
		UniqueAddresses := dedup(SORT(DISTRIBUTE(filein(NAC_V2.fn_IsValidAddress(Prepped_addr1)), 
												HASH32(Prepped_addr1,Prepped_addr2)),
														Prepped_addr1,Prepped_addr2, LOCAL), Prepped_addr1,Prepped_addr2, LOCAL);

		Nac_v2.Layouts.baseHistorical tr4(UniqueAddresses l) := transform
			Clean_Address := address.CleanAddress182(l.Prepped_addr1,l.Prepped_addr2);
			STRING28  v_prim_name 		:= Clean_Address[13..40];
			STRING5   v_zip       		:= Clean_Address[117..121];
			STRING4   v_zip4      		:= Clean_Address[122..125];
			SELF.prim_range  			:= Clean_Address[ 1..  10];
			SELF.predir      			:= Clean_Address[ 11.. 12];
			SELF.prim_name   			:= if(v_prim_name in ['GENERAL DELIVERY', 'HOMELESS'], '', v_prim_name);
			SELF.addr_suffix 			:= Clean_Address[ 41.. 44];
			SELF.postdir     			:= Clean_Address[ 45.. 46];
			SELF.unit_desig  			:= Clean_Address[ 47.. 56];
			SELF.sec_range   			:= Clean_Address[ 57.. 64];
			SELF.p_city_name 			:= Clean_Address[ 65.. 89];
			SELF.v_city_name 			:= Clean_Address[ 90..114];
			SELF.st          			:= Clean_Address[115..116];
			SELF.zip         			:= if(v_zip='00000','',v_zip);
			SELF.zip4       	 		:= if(v_zip4='0000','',v_zip4);
			SELF.cart        			:= Clean_Address[126..129];
			SELF.cr_sort_sz  			:= Clean_Address[130..130];
			SELF.lot         			:= Clean_Address[131..134];
			SELF.lot_order   			:= Clean_Address[135..135];
			SELF.dbpc        			:= Clean_Address[136..137];
			SELF.chk_digit   			:= Clean_Address[138..138];
			SELF.rec_type    			:= Clean_Address[139..140];
			//SELF.fips_state 			:= Clean_Address[141..142];		// due to a bug in V1
			//SELF.fips_county 			:= Clean_Address[143..145];
			SELF.fips_county 			:= Clean_Address[141..142];
			SELF.county			 			:= Clean_Address[143..145];
			SELF.geo_lat     			:= Clean_Address[146..155];
			SELF.geo_long    			:= Clean_Address[156..166];
			SELF.msa         			:= Clean_Address[167..170];
			SELF.geo_blk     			:= Clean_Address[171..177];
			SELF.geo_match   			:= Clean_Address[178..178];
			SELF.err_stat    			:= Clean_Address[179..182];
			SELF := l;
		END;

		AddressClean := project(UniqueAddresses,tr4(left));
		
		restored1 := join(distribute(filein,  hash32(Prepped_addr2,Prepped_addr1))
								,distribute(AddressClean, hash32(Prepped_addr2,Prepped_addr1)),
								left.Prepped_addr2=right.Prepped_addr2
								and left.Prepped_addr1=right.Prepped_addr1
								,transform(Nac_v2.Layouts.baseHistorical
									,self.prim_range   :=if(left.Prepped_addr1=right.Prepped_addr1,right.prim_range,'')
									,self.predir       :=if(left.Prepped_addr1=right.Prepped_addr1,right.predir,'')
									,self.prim_name    :=if(left.Prepped_addr1=right.Prepped_addr1,right.prim_name,'')
									,self.addr_suffix  :=if(left.Prepped_addr1=right.Prepped_addr1,right.addr_suffix,'')
									,self.postdir      :=if(left.Prepped_addr1=right.Prepped_addr1,right.postdir,'')
									,self.unit_desig   :=if(left.Prepped_addr1=right.Prepped_addr1,right.unit_desig,'')
									,self.sec_range    :=if(left.Prepped_addr1=right.Prepped_addr1,right.sec_range,'')
									,self.p_city_name  :=if(left.Prepped_addr1=right.Prepped_addr1,right.p_city_name,'')
									,self.v_city_name  :=if(left.Prepped_addr1=right.Prepped_addr1,right.v_city_name,'')
									,self.st           :=if(left.Prepped_addr1=right.Prepped_addr1,right.st,'')
									,self.zip          :=if(left.Prepped_addr1=right.Prepped_addr1,right.zip,'')
									,self.zip4         :=if(left.Prepped_addr1=right.Prepped_addr1,right.zip4,'')
									,self.cart         :=if(left.Prepped_addr1=right.Prepped_addr1,right.cart,'')
									,self.cr_sort_sz   :=if(left.Prepped_addr1=right.Prepped_addr1,right.cr_sort_sz,'')
									,self.lot          :=if(left.Prepped_addr1=right.Prepped_addr1,right.lot,'')
									,self.lot_order    :=if(left.Prepped_addr1=right.Prepped_addr1,right.lot_order,'')
									,self.dbpc         :=if(left.Prepped_addr1=right.Prepped_addr1,right.dbpc,'')
									,self.chk_digit    :=if(left.Prepped_addr1=right.Prepped_addr1,right.chk_digit,'')
									,self.rec_type     :=if(left.Prepped_addr1=right.Prepped_addr1,right.rec_type,'')
									,self.fips_county  	:=if(left.Prepped_addr1=right.Prepped_addr1,right.fips_county,'')
									,self.county   :=if(left.Prepped_addr1=right.Prepped_addr1,right.county,'')
									,self.geo_lat      :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_lat,'')
									,self.geo_long     :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_long,'')
									,self.msa          :=if(left.Prepped_addr1=right.Prepped_addr1,right.msa,'')
									,self.geo_blk      :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_blk,'')
									,self.geo_match    :=if(left.Prepped_addr1=right.Prepped_addr1,right.geo_match,'')
									,self.err_stat     :=if(left.Prepped_addr1=right.Prepped_addr1,right.err_stat,'')
									,self:=left)
								,left outer
								,local);
								
										
		restored2 := SORT(DISTRIBUTE(restored1, PrepRecSeq),PrepRecSeq,-prim_name,LOCAL);
		// remove duplicate addresses that did not clean properly
		restored3 := DEDUP(restored2, left.PrepRecSeq=right.PrepRecSeq and (left.prim_name='' OR right.prim_name=''), LOCAL);

								
		restored := DEDUP(SORT(DISTRIBUTE(restored3, PrepRecSeq),
										PrepRecSeq,
										 prim_range, predir, prim_name, addr_suffix, postdir,
											unit_desig, sec_range, p_city_name, st, zip, zip4, LOCAL),
										PrepRecSeq,
										 prim_range, predir, prim_name, addr_suffix, postdir,
											unit_desig, sec_range, p_city_name, st, zip, zip4, LOCAL);
											
		return restored;
END;

EXPORT fn_Base1ToBase2(DATASET(NAC_V2.Layouts.base) b) := FUNCTION
		b1_flat := nac_v2.fn_flatten(b);			// first, roll up all the records to make a date range;
		
		b1_sameaddr := PROJECT(b1_flat((Phys_addr1=Mail_addr1 AND Phys_addr2=Mail_addr2) OR Phys_addr1='' OR Mail_addr1=''),	// physical = mailing
											TRANSFORM({b1_flat},
												self.AddressType := MAP(
														left.Phys_addr1 = left.Mail_addr1 AND left.Phys_addr2 = left.Mail_addr2 => 'B',
														left.Phys_addr1 = '' => 'M',
														'P');
												self := left;));
		b1_diffaddr := NORMALIZE(b1_flat(Phys_addr1<>Mail_addr1 OR Phys_addr2<>Mail_addr2,Phys_addr1<>'', Mail_addr1<>''), 2, 
											TRANSFORM({b1_flat},
												self.AddressType := CHOOSE(COUNTER, 'P', 'M');
												self.Prepped_addr1 := CHOOSE(COUNTER, left.Phys_addr1, left.Mail_addr1);
												self.Prepped_addr2 := CHOOSE(COUNTER, left.Phys_addr2, left.Mail_addr2);
												self := LEFT;));
												
		b1_recleaned := reclean(b1_diffaddr);
		
		b1_converted := b1_sameaddr & b1_recleaned;
		
		// convert to base 2 layout
		base2 := PROJECT(b1_converted, TRANSFORM(nac_v2.Layout_Base2,
						self.ProgramState := left.Case_State_Abbreviation;
						self.ProgramCode := IF(left.Case_Benefit_Type='R','S',left.Case_Benefit_Type);
						self.GroupId := left.Case_State_Abbreviation + '01';	// default group for v1
						self.OrigGroupId := left.Case_State_Abbreviation + '01';	// default group for v1
						self.CaseID := left.Case_Identifier;
						self.ClientID := left.Client_Identifier;
						self.MonthlyAllotment := '0';	// whole dollar

						self.LastName := left.Client_Last_Name;
						self.FirstName := left.Client_First_Name;
						self.MiddleName := left.Client_Middle_Name;
						self.NameSuffix := left.Client_Name_Suffix;
						
						self.HoH_Indicator := IF(left.Client_Last_Name=left.Case_Last_Name
														and left.Client_First_Name=left.Case_First_Name
														and left.Client_Middle_Name=left.Case_Middle_Name,
														'Y','N');

						self.Relationship := if(self.HoH_indicator='H', 'H', 'O');
						self.Gender := left.Client_Gender;
						self.Race := left.Client_Race;
						self.Ethnicity := left.Client_Ethnicity;
						self.ABAWDIndicator := 'U';
						self.Certificate_id_type := '';
						self.HistoricalBenefitCount := '';
						
						self.ssn := left.Client_SSN;
						self.ssn_Type_indicator := left.Client_SSN_Type_Indicator;
						self.dob := left.Client_DOB;
						self.dob_Type_indicator := left.Client_DOB_Type_Indicator;
						
						// temp fix for missouri
						self.eligibility_status_indicator := IF(left.Client_Eligible_Status_Indicator in NAC_V2.Mod_Sets.Eligible_Status,
																left.Client_Eligible_Status_Indicator, 'E');
																
						self.eligibility_status_date := left.Client_Eligible_Status_Date;
						self.PeriodType := 'M';
						
						self.client_Phone := left.Client_Phone;
						self.client_Email := left.Client_Email;
						
						self.StartDate_Raw := ((string8)left.StartDate)[1..6];
						self.EndDate_Raw := ((string8)left.EndDate)[1..6];
						//sd := TRIM(left.StartDate,LEFT,RIGHT);
						//ed := TRIM(left.EndDate,LEFT,RIGHT);
						//self.StartDate := (Std.Date.Date_t)IF(LENGTH(sd)=6, sd+'01', sd);
						//self.EndDate := (Std.Date.Date_t)IF(LENGTH(ed)=6, ed + nac_v2.DaysInMonth(ed), ed);
						self.StartDate := left.StartDate;
						self.EndDate := left.EndDate;
						
						// case fields
						self.case_Last_Name := left.case_last_name;
						self.case_First_Name := left.case_first_name;
						self.case_Middle_Name := left.case_middle_name;
						self.case_Name_Suffix := left.case_name_suffix;
						self.RegionCode := '';
						self.CountyCode := left.case_county_parish_code;
						self.CountyName := left.case_county_parish_name;
						self.case_Phone1 := left.Case_Phone_1;
						self.case_Phone2 := left.Case_Phone_2;
						self.case_Email := left.Case_Email;
						
						// address fields
						self.Physical_AddressCategory := '';	
						self.Physical_Street1 := left.case_physical_address_Street_1;
						self.Physical_Street2 := left.case_physical_address_Street_2;
						self.Physical_City := left.case_physical_address_City;
						self.Physical_State := left.case_physical_address_State;
						self.Physical_Zip := left.case_physical_address_zip;
						
						self.Mailing_AddressCategory := '';	
						self.Mailing_Street1 := left.case_mailing_address_Street_1;
						self.Mailing_Street2 := left.case_mailing_address_Street_2;
						self.Mailing_City := left.case_mailing_address_City;
						self.Mailing_State := left.case_mailing_address_State;
						self.Mailing_Zip := left.case_mailing_address_zip;
						
						// state contact
						self.contactname := left.state_contact_name;
						self.contactphone := left.state_contact_phone;
						self.contactext := left.state_contact_phone_extension;
						self.contactemail := left.state_contact_email;
						
						SELF.fips_state 			:= left.fips_county;
						SELF.fips_county 			:= left.county;

						self.created := Std.Date.Today();
						self.updated := Std.Date.Today();
						self := left;
						//self := [];
				));

				base2_ok := (base2(lname<>''));
				base2_noname := (base2(lname=''));
				base2_fixed := NAC_V2.fn_Nid_CleanNames(base2_noname);

				base3 := base2_ok + base2_fixed;
				
		return base3;
END;