IMPORT PRTE2_DNB_FEIN, DNB_FEINV2, Experian_FEIN, ut, PromoteSupers, NID, Address, BIPV2, STD;

//Input
dMain := PRTE2_DNB_FEIN.Files.Main_in;

// Customer data -- future
//Project into same layout as Initial data

// New data -- future
//Project into same layout as Initial data

//Clean name/address
Layouts.tempComboLayout ClnMain(dMain L) := TRANSFORM
		string73 tempname 		 					 := if(trim(L.top_contact_name) = '', '',Address.CleanPersonFML73(L.top_contact_name));
		pname 							 	 					 := Address.CleanNameFields(tempName);
		self.title						 					 := pname.title;
		self.fname 						 					 := pname.fname;        
		self.mname 						 					 := pname.mname;
		self.lname 						 					 := pname.lname;		  
		self.name_suffix 			 					 := pname.name_suffix;
		self.name_score			   					 := pname.name_score;
																				
		//clean address
		TempPAddr					:= Address.CleanAddress182(TRIM(L.orig_address1,left,right),TRIM(L.orig_city,left,right) + ', '+
																								TRIM(L.orig_state,left,right) +' '+ TRIM(L.orig_ZIP5,left,right));

		self.prim_range 		:= TempPAddr[1..10];
		self.predir     		:= TempPAddr[11..12];
		self.prim_name			:= TempPAddr[13..40];
		self.addr_suffix		:= TempPAddr[41..44];
		self.postdir				:= TempPAddr[45..46];
		self.unit_desig			:= TempPAddr[47..56];
		self.sec_range			:= TempPAddr[57..64];
		self.p_city_name		:= TempPAddr[65..89];
		self.v_city_name		:= TempPAddr[90..114];
		self.st							:= TempPAddr[115..116];
		self.zip						:= TempPAddr[117..121];
		self.zip4						:= TempPAddr[122..125];
		self.cart						:= TempPAddr[126..129];
		self.cr_sort_sz			:= TempPAddr[130];
		self.lot						:= TempPAddr[131..134];
		self.lot_order			:= TempPAddr[135];
		self.dbpc						:= TempPAddr[136..137];
		self.chk_digit			:= TempPAddr[138];
		self.rec_type				:= TempPAddr[139..140];
		//self.fips_state			:= TempPAddr[141..142];
		self.county					:= TempPAddr[143..145];	
		self.geo_lat				:= TempPAddr[146..155];
		self.geo_long				:= TempPAddr[156..166];
		self.msa						:= TempPAddr[167..170];
		SELF.geo_blk				:= TempPAddr[171..177];
		self.geo_match			:= TempPAddr[178];
		self.err_stat				:= TempPAddr[179..182];
		self.prep_addr_line1			:= Address.Addr1FromComponents(ut.CleanSpacesAndUpper(L.orig_address1),'','','','','',''); 
		self.prep_addr_line_last	:= Address.Addr2FromComponents(ut.CleanSpacesAndUpper(L.orig_city),ut.CleanSpacesAndUpper(L.orig_state),TRIM(L.orig_ZIP5,left,right));
		self := L;
		SELF := [];
	END;
	
	pCleanMain	:= PROJECT(dMain, ClnMain(left));
	
	//Append source_rec_ID
	ut.MAC_Append_Rcid(pCleanMain,source_rec_id,Append_Rcid_file);
	
	//Project into DNB base layout
	Layouts.DNB_Main_di_ref xfrmDNB(Layouts.tempComboLayout L) := TRANSFORM
		SELF.BDID									:= '';
		SELF.orig_company_name		:= ut.CleanSpacesAndUpper(L.orig_company_name); 
		SELF.clean_cname					:= ut.CleanSpacesAndUpper(L.orig_company_name);       
		SELF.orig_address1				:= ut.CleanSpacesAndUpper(L.orig_address1);
		SELF.orig_address2				:= '';   
		SELF.orig_CITY						:= ut.CleanSpacesAndUpper(L.orig_CITY);
		SELF.orig_STATE						:= ut.CleanSpacesAndUpper(L.orig_STATE);
		SELF.orig_county					:= ut.CleanSpacesAndUpper(L.orig_county);
		SELF.duns_orig_source			:= ut.CleanSpacesAndUpper(L.duns_orig_source);
		SELF.company_name					:= ut.CleanSpacesAndUpper(L.company_name);     
		SELF.trade_style					:= ut.CleanSpacesAndUpper(L.trade_style);
		SELF.Top_Contact_Name			:= ut.CleanSpacesAndUpper(L.Top_Contact_Name);
		SELF.Top_Contact_Title		:= ut.CleanSpacesAndUpper(L.Top_Contact_Title);
		SELF.Hdqtr_Parent_Duns_Number	:= ut.CleanSpacesAndUpper(L.Hdqtr_Parent_Duns_Number);
		SELF	:= L;
	END;
	
	pDNB_base	:= PROJECT(Append_Rcid_file(source = 'DNB'), xfrmDNB(LEFT));
	
	PromoteSupers.Mac_SF_BuildProcess(pDNB_base, Constants.BASE_PREFIX + 'main', build_dnb_base);
	
	//Project into Experian base layout
	Layouts.Experian_Main_di_ref xfrmExpFEIN(Layouts.tempComboLayout L) := TRANSFORM
		SELF.Business_Identification_Number	:= L.Business_Identification_Number;	 
		SELF.Business_Name			:= ut.CleanSpacesAndUpper(L.orig_company_name);
		SELF.Business_Address		:= ut.CleanSpacesAndUpper(L.orig_address1);
		SELF.Business_City			:= ut.CleanSpacesAndUpper(L.orig_CITY);
		SELF.Business_State			:= ut.CleanSpacesAndUpper(L.orig_STATE);
		SELF.Business_Zip				:= ut.CleanSpacesAndUpper(L.orig_ZIP5);
		SELF.Norm_Type					:= L.Norm_Type;
		SELF.Norm_Tax_ID				:= L.FEIN;
		SELF.Norm_Confidence_Level			:= L.Norm_Confidence_Level;
		SELF.Norm_Display_Configuration	:= L.Norm_Display_Configuration;
		SELF.Long_Name					:= ut.CleanSpacesAndUpper(L.company_name);
		SELF.Source							:= ut.CleanSpacesAndUpper(L.source);
		self.source_rec_id 			:= HASH64(trim(l.Business_Identification_Number,left,right) + 
																		SELF.Long_Name               + 
																		SELF.Business_Name           +
																		SELF.Business_Address        + 
																		SELF.Business_City           + 
																		SELF.Business_State          + 
																		SELF.Business_Zip            +
																		SELF.Norm_Tax_ID 		 				 +
																		SELF.Norm_Type               +
																		SELF.Norm_Confidence_Level   +
																		SELF.Norm_Display_Configuration );
		SELF.BDID								:= 0;
		SELF.bdid_score					:= 0;
		SELF.dt_vendor_first_reported		:= (unsigned4)L.date_vendor_first_reported;
		SELF.dt_vendor_last_reported		:= (unsigned4)L.date_vendor_last_reported;	
		SELF.fips_state					:= '';
		SELF.fips_county				:= L.county;
		SELF	:= L;
	END;
	
	pExperian_base	:= PROJECT(pCleanMain(source <> 'DNB'), xfrmExpFEIN(LEFT))(Business_Identification_Number <> '');
	
	PromoteSupers.Mac_SF_BuildProcess(pExperian_base, Constants.EXP_BASE_PREFIX + 'data', build_exp_base);
		
EXPORT proc_build_base := ORDERED(build_dnb_base, build_exp_base);
