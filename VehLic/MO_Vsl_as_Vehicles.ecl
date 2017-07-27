import ut;
MOVesselsCombinedFile				:= vehlic.File_Mo_Vsl;

integer1 lCenturyThreshhold 		:= 30;

string10 lFormatZip9(string pZip9)	
 := if((integer4)pZip9 > 0,
	   if((integer4)(pZip9) <= 99999,
	      (string5)(integer4)pZip9,
		   pZip9[1..5] + if((integer)(pZip9[6..9])<>0,
						    '-' + pZip9[6..9],
							''
						   )
		 ),
		''
	   );

string8 lPrependCCToDate(string pYYMMDD)
 := if((integer)trim(pYYMMDD,left,right)=0,
	   '',
	   if((integer)(pYYMMDD[1..2]) <= lCenturyThreshhold,
		  '20',
		  '19'
		 )
	   + pYYMMDD[1..6]
	  );

string4 lPrependCCToYY(string pYY)
 := if((integer)trim(pYY,left,right)=0,
	   '',
	   if((integer)(pYY) <= lCenturyThreshhold,
		  '20',
		  '19'
		 )
	   + pYY[1..2]
	  );

string8 lPrependCCandAppend1231(string pYY)
 := if((integer)trim(pYY,left,right)=0,
	   '',
	   if((integer)(pYY[1..2]) <= lCenturyThreshhold,
		  '20',
		  '19'
		 )
	   + pYY[1..2] + '1231'
	  );


string lPassThruIfOwner2(string pSourceField,string pOwner2Name,string pCompany2Name)
 := if(length(trim(pOwner2Name,left,right)) <> 0 or length(trim(pCompany2Name,left,right)) <> 0,
	   pSourceField,
	   ''
	  );

VehLic.Layout_Vehicles MOVesselsTransform(MOVesselsCombinedFile pSource) := transform
	self.orig_state					:= 'MO';
	self.dt_first_seen 				:= (unsigned8)(pSource.process_date[1..6]);
	self.dt_last_seen 				:= (unsigned8)(pSource.process_date[1..6]);
	self.dt_vendor_first_reported	:= (unsigned8)(pSource.process_date[1..6]);
	self.dt_vendor_last_reported	:= (unsigned8)(pSource.process_date[1..6]);
	self.VEHICLE_NUMBERxBG1 		:= pSource.TITLE;
	self.ORIG_VIN	                := pSource.VIN;
	self.FIRST_REGISTRATION_DATE    := lPrependCCToDate(pSource.ISSUE_DATE);	//Prepend CC to YYMMDD
	self.YEAR_MAKE	                := lPrependCCToYY(pSource.orig_YEAR);		//Prepend CC to YY
	self.MAKE_CODE					:= pSource.orig_MAKE;						//CODES_V3 & THOR_CODES
	self.VEHICLE_TYPE				:= 'VS'; 									//Vessel
	self.VEHICLE_USE	            := pSource.orig_TYPE_USEAGE;				//CODES_V3
	self.MAJOR_COLOR_CODE           := trim(pSource.COLOR[1..3],left,right);	//CODES_V3 (XXX/yyy)
	self.MINOR_COLOR_CODE	        := trim(pSource.COLOR[5..7],left,right);	//CODES_V3 (xxx/YYY)
	self.LENGTH_FEET	            := trim(pSource.orig_LENGTH[1..3],left,right);		//(FFFII) [1..3]
	self.VESSEL_PROPULSION_TYPE	    := pSource.orig_PROPULSION_CD;						//CODES_V3
	self.HULL_MATERIAL_TYPE	        := pSource.orig_MATERIAL;							//CODES_V3
	self.VESSEL_TYPE	            := pSource.orig_BOAT_TYPE;							//CODES_V3 & THOR_CODES
	self.OWNER_1_CUSTOMER_TYPExBG3  := VehLic.GetCusType(pSource.fname1, pSource.lname1, pSource.company1);	//	If cleans as company name, then = "B", Individual =  "I", else " "
	self.OWN_1_CUSTOMER_NAME        := pSource.orig_OWNER;
	self.OWN_1_STREET_ADDRESS       := pSource.orig_ADDRESS;
	self.OWN_1_CITY	                := pSource.orig_CITY;
	self.OWN_1_STATE                := pSource.orig_STATE;
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= lFormatZip9(pSource.orig_ZIP);
	self.OWN_1_RESIDENCE_COUNTY	    := pSource.orig_COUNTY_CODE;				//CODES_V3??
	self.REGISTRATION_NUMBER	    := pSource.REG_NO;
	self.REGISTRATION_EFFECTIVE_DATE := lPrependCCToDate(pSource.REGISTER_DATE);	//Prepend CC to YYMMDD
	self.REGISTRATION_EXPIRATION_DATE := lPrependCCAndAppend1231(pSource.EXP_YEAR);	//Prepent CC to YY, append 12/31
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:= VehLic.GetCusType(pSource.fname1, pSource.lname1, pSource.company1);	//	If cleans as company name, then = "B", Individual =  "I", else " "
	self.REG_1_CUSTOMER_NAME        := pSource.orig_OWNER;
	self.REG_1_STREET_ADDRESS       := pSource.orig_ADDRESS;
	self.REG_1_CITY                 := pSource.orig_CITY;
	self.REG_1_STATE                := pSource.orig_STATE;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= lFormatZip9(pSource.orig_ZIP);
	self.REG_1_RESIDENCE_COUNTY     := pSource.orig_COUNTY_CODE;
	self.TITLE_NUMBERxBG9			:= pSource.TITLE;
	self.TITLE_ISSUE_DATE           := lPrependCCToDate(pSource.ISSUE_DATE);	//Prepend CC to YYMMDD
	self.TITLE_STATUS_CODE          := pSource.TITLE_TYPE;						//I know it's not below
	self.LH_1_LIEN_DATE             := lPrependCCToDate(pSource.LIEN_DATE_1);	//Prepend CC to YYMMDD
	self.LH_1_CUSTOMER_NAME	        := pSource.LIEN_NAME_1;
	self.LH_1_STREET_ADDRESS        := pSource.LIEN_ADDR_1;
	self.LH_1_CITY                  := pSource.LIEN_CITY_1;
	self.LH_1_STATE                 := pSource.LIEN_STATE_1;
	self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL := lFormatZip9(pSource.LIEN_ZIP_1);		//Add '-', remove '0000' plus4
	self.LH_2_LEIN_DATE             := lPrependCCToDate(pSource.LIEN_DATE_2);	//Prepend CC to YYMMDD
	self.LH_2_CUSTOMER_NAME         := pSource.LIEN_NAME_2;
	self.LH_2_STREET_ADDRESS        := pSource.LIEN_ADDR_2;
	self.LH_2_CITY                  := pSource.LIEN_CITY_2;
	self.LH_2_STATE                 := pSource.LIEN_STATE_2;
	self.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL := lFormatZip9(pSource.LIEN_ZIP_2);		//Add '-', remove '0000' plus4
	self.own_1_title                := pSource.title1;
	self.own_1_fname                := pSource.fname1;
	self.own_1_mname                := pSource.mname1;
	self.own_1_lname                := pSource.lname1;
	self.own_1_name_suffix          := pSource.suffix1;
	self.own_1_company_name         := pSource.company1;
	self.own_1_prim_range           := pSource.prim_range;
	self.own_1_predir               := pSource.predir;
	self.own_1_prim_name            := pSource.prim_name;
	self.own_1_suffix               := pSource.addr_suffix;
	self.own_1_postdir              := pSource.postdir;
	self.own_1_unit_desig           := pSource.unit_desig;
	self.own_1_sec_range            := pSource.sec_range;
	self.own_1_p_city_name          := pSource.p_city_name;
	self.own_1_v_city_name          := pSource.v_city_name;
	self.own_1_state_2              := pSource.st;
	self.own_1_zip5                 := pSource.zip;
	self.own_1_zip4                 := pSource.zip4;
	self.own_1_county               := pSource.county;
	self.own_2_title                := pSource.title2;
	self.own_2_fname                := pSource.fname2;
	self.own_2_mname                := pSource.mname2;
	self.own_2_lname                := pSource.lname2;
	self.own_2_name_suffix 	        := pSource.suffix2;
	self.own_2_company_name         := pSource.company2;
	self.own_2_prim_range	        := lPassThruIfOwner2(pSource.prim_range,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.own_2_predir               := lPassThruIfOwner2(pSource.predir,pSource.lname2,pSource.company2);		//Only if name2 is nonblank
	self.own_2_prim_name            := lPassThruIfOwner2(pSource.prim_name,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.own_2_suffix               := lPassThruIfOwner2(pSource.addr_suffix,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.own_2_postdir              := lPassThruIfOwner2(pSource.postdir,pSource.lname2,pSource.company2);		//Only if name2 is nonblank
	self.own_2_unit_desig           := lPassThruIfOwner2(pSource.unit_desig,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.own_2_sec_range            := lPassThruIfOwner2(pSource.sec_range,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.own_2_p_city_name          := lPassThruIfOwner2(pSource.p_city_name,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.own_2_v_city_name          := lPassThruIfOwner2(pSource.v_city_name,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.own_2_state_2              := lPassThruIfOwner2(pSource.st,pSource.lname2,pSource.company2);			//Only if name2 is nonblank
	self.own_2_zip5                 := lPassThruIfOwner2(pSource.zip,pSource.lname2,pSource.company2);			//Only if name2 is nonblank
	self.own_2_zip4                 := lPassThruIfOwner2(pSource.zip4,pSource.lname2,pSource.company2);			//Only if name2 is nonblank
	self.own_2_county               := lPassThruIfOwner2(pSource.county,pSource.lname2,pSource.company2);		//Only if name2 is nonblank
	self.reg_1_title                := pSource.title1;	
	self.reg_1_fname                := pSource.fname1;	
	self.reg_1_mname                := pSource.mname1;	
	self.reg_1_lname                := pSource.lname1;	
	self.reg_1_name_suffix          := pSource.suffix1;	
	self.reg_1_company_name         := pSource.company1;	
	self.reg_1_prim_range           := pSource.prim_range;	
	self.reg_1_predir               := pSource.predir;	
	self.reg_1_prim_name            := pSource.prim_name;	
	self.reg_1_suffix               := pSource.addr_suffix;	
	self.reg_1_postdir              := pSource.postdir;	
	self.reg_1_unit_desig           := pSource.unit_desig;	
	self.reg_1_sec_range            := pSource.sec_range;	
	self.reg_1_p_city_name          := pSource.p_city_name;	
	self.reg_1_v_city_name          := pSource.v_city_name;	
	self.reg_1_state_2              := pSource.st;	
	self.reg_1_zip5			        := pSource.zip;	
	self.reg_1_zip4			        := pSource.zip4;	
	self.reg_1_county				:= pSource.county;	
	self.reg_2_title				:= pSource.title2;	
	self.reg_2_fname                := pSource.fname2;	
	self.reg_2_mname				:= pSource.mname2;	
	self.reg_2_lname				:= pSource.lname2;	
	self.reg_2_name_suffix			:= pSource.suffix2;	
	self.reg_2_company_name			:= pSource.company2;	
	self.reg_2_prim_range			:= lPassThruIfOwner2(pSource.prim_range,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.reg_2_predir				:= lPassThruIfOwner2(pSource.predir,pSource.lname2,pSource.company2);		//Only if name2 is nonblank
	self.reg_2_prim_name            := lPassThruIfOwner2(pSource.prim_name,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.reg_2_suffix               := lPassThruIfOwner2(pSource.addr_suffix,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.reg_2_postdir              := lPassThruIfOwner2(pSource.postdir,pSource.lname2,pSource.company2);		//Only if name2 is nonblank
	self.reg_2_unit_desig           := lPassThruIfOwner2(pSource.unit_desig,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.reg_2_sec_range            := lPassThruIfOwner2(pSource.sec_range,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.reg_2_p_city_name          := lPassThruIfOwner2(pSource.p_city_name,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.reg_2_v_city_name          := lPassThruIfOwner2(pSource.v_city_name,pSource.lname2,pSource.company2);	//Only if name2 is nonblank
	self.reg_2_state_2              := lPassThruIfOwner2(pSource.st,pSource.lname2,pSource.company2);			//Only if name2 is nonblank
	self.reg_2_zip5                 := lPassThruIfOwner2(pSource.zip,pSource.lname2,pSource.company2);			//Only if name2 is nonblank
	self.reg_2_zip4                 := lPassThruIfOwner2(pSource.zip4,pSource.lname2,pSource.company2);			//Only if name2 is nonblank
	self.reg_2_county               := lPassThruIfOwner2(pSource.county,pSource.lname2,pSource.company2);		//Only if name2 is nonblank
//	self 							:= pSource; //get the stragglers
end;

export MO_Vsl_as_Vehicles := project(MOVesselsCombinedFile, MOVesselsTransform(left));