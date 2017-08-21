IMPORT  PRTE2_Workers_Compensation,PromoteSupers, Address, PRTE2;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

df_Workers_Compensation := PROJECT
	(Files.file_IN(SOURCE_REC_ID <> 0), 
   TRANSFORM(	Layouts.Layout_Base,
	 						SELF.Description 				:= LEFT.Business_Name; 
							SELF.EffectiveMonth 		:= LEFT.Policy_Eff_Month;
							SELF.Effective_Date 		:= LEFT.Policy_Eff_Date;  
							SELF.NAICCarrierName 		:= LEFT.Carrier_NAIC_Name;
							SELF.NAICCarrierNumber	:= LEFT.Carrier_NAIC_Id;
							SELF.NAICGroupName 			:= LEFT.Group_NAIC_NAME; 
							SELF.NAICGroupNumber 		:= LEFT.Group_NAIC_Id; 
							SELF.PolicySelf 				:= LEFT.Policy_Number;
							SELF.FEIN	:= IF (LEFT.FEIN = '000000001','',LEFT.FEIN);
							SELF.state := IF (StringLib.StringToUpperCase(LEFT.state) in Constants.valid_states, StringLib.StringToUpperCase(LEFT.state), '' );
  						clean_address := address.CleanAddressParsed(LEFT.standardaddress, LEFT.city + ', ' + LEFT.state + ' ' + LEFT.zip).addressrecord;
							SELF.m_prim_range := clean_address.prim_range;
							SELF.m_predir := clean_address.predir;
							SELF.m_prim_name := clean_address.prim_name;	
							SELF.m_addr_suffix := clean_address.addr_suffix;
							SELF.m_postdir := clean_address.postdir;
							SELF.m_unit_desig := clean_address.unit_desig;
							SELF.m_sec_range := clean_address.sec_range;
							SELF.m_p_city_name := LEFT.city;
							SELF.m_v_city_name := LEFT.city;
							SELF.m_st := clean_address.st;
							SELF.m_zip := clean_address.zip;
							SELF.m_zip4 := clean_address.zip4;
							SELF.m_cart := clean_address.cart;
							SELF.m_cr_sort_sz := clean_address.cr_sort_sz;
							SELF.m_lot := clean_address.lot;
							SELF.m_lot_order := clean_address.lot_order;
							SELF.m_chk_digit := clean_address.chk_digit;	
							SELF.m_rec_type := clean_address.rec_type;
							SELF.m_fips_state := clean_address.fips_state;
							SELF.m_fips_county := clean_address.fips_county;
							SELF.m_geo_lat := clean_address.geo_lat;
							SELF.m_geo_long := clean_address.geo_long;
							SELF.m_msa := clean_address.msa;
							SELF.m_geo_blk := clean_address.geo_blk;
							SELF.m_geo_match := clean_address.geo_match;
							SELF.m_err_stat := clean_address.err_stat;
							SELF.Append_MailAddress1		:=  StringLib.StringCleanSpaces(TRIM(LEFT.standardaddress));
							SELF.Append_MailAddressLast	:= 	IF (LEFT.City!='',
																									StringLib.StringCleanSpaces(TRIM(LEFT.City) + ', ' + TRIM(LEFT.State) + ' ' + TRIM(LEFT.Zip[1..5])),
																									StringLib.StringCleanSpaces(TRIM(LEFT.State) + ' ' + TRIM(LEFT.Zip[1..5])) ); 
							//generating fake BDID
							SELF.bdid := prte2.fn_AppendFakeID.bdid(LEFT.business_name,	clean_address.prim_range,	
																											clean_address.prim_name, LEFT.city, LEFT.state, 
																											LEFT.zip, LEFT.cust_name);		
							SELF := LEFT;
    					//default values
							SELF.append_mailrawaid := 0;
							SELF.append_mailaceaid := 0;
							Self.m_dbpc := '';
				
						)
	);

													
PromoteSupers.MAC_SF_BuildProcess(df_Workers_Compensation, Constants.base_workers_compensation, writefile_Workers_Compensation);

sequential(writefile_Workers_Compensation);

Return 'success';
END;