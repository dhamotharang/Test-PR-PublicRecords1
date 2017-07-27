import Ut, lib_stringlib;						// utilities library

vehlic.Layout_Vehicles KYFullToCommon(vehlic.File_KY_Full pLeft) := transform
	self.orig_state:='KY';
	self.dt_first_seen := (unsigned8)(pLeft.append_PROCESS_DATE[1..6]);
    self.dt_last_seen := (unsigned8)(pLeft.append_PROCESS_DATE[1..6]);
	self.dt_vendor_first_reported:=(unsigned8)(pLeft.append_PROCESS_DATE[1..6]);
	self.dt_vendor_last_reported:=(unsigned8)(pLeft.append_PROCESS_DATE[1..6]);
	self.VEHICLE_NUMBERxBG1 := if(length(trim(pLeft.IDENTIFICATION_NUM_VEH)) < 17,
	                               pLeft.NUM_TITLE,pLeft.IDENTIFICATION_NUM_VEH);
	self.ORIG_VIN := pLeft.IDENTIFICATION_NUM_VEH;
	self.YEAR_MAKE := if(pLeft.YEAR_MODEL_VEHICLE <> '',
	                  if(pLeft.YEAR_MODEL_VEHICLE > '05',
					  '19' + pLeft.YEAR_MODEL_VEHICLE,
					  '20' + pLeft.YEAR_MODEL_VEHICLE), '');
	self.MAKE_CODE := pLeft.MAKE_VEHICLE;				
	self.BODY_CODE := pLeft.CODE_STYLE_BODY;
	self.LICENSE_PLATE_NUMBERxBG4 := pLeft.NUM_LICENSE_PLT;
	self.REGISTRATION_EXPIRATION_DATE := pLeft.DATE_EXPIR_REGISTRATION;
	self.REGISTRATION_STATUS_CODE := pLeft.CODE_STATUS_REGISTRATION;
	self.TRUE_LICENSE_PLSTE_NUMBER := pLeft.NUM_LICENSE_PLT;
	self.FIRST_REGISTRATION_DATE := pLeft.DATE_REGISTRATION;
	self.VEHICLE_TYPE := pLeft.CODE_TYPE_MODEL_VEH;
	self.MAJOR_COLOR_CODE := pLeft.CODE_COLOR_MAJOR;
	self.MINOR_COLOR_CODE := pLeft.CODE_COLOR_MINOR;
	self.TITLE_NUMBERxBG9 	:= pLeft.NUM_TITLE;		
	self.PREVIOUS_TITLE_STATE := pLeft.CODE_STATE_PREVIOUS;
	self.TITLE_TYPE := pLeft.CODE_TYPE_TITLE;
	self.TITLE_STATUS_CODE := pLeft.CODE_STATUS_TITLE;
	self.TITLE_ISSUE_DATE := pLeft.DATE_UPDATE_TITLE_LAST;

	
	self.REGISTRANT_1_CUSTOMER_TYPExBG5 :=     if(pLeft.NAME_REGISTRANT_ALT <> '' AND pLeft.Reg_Name1 <> '' OR pLeft.append_REG1_COMPANY_NAME <> '',
	                                               map(trim(pLeft.Reg_Name1) <> '' => 'I',trim(pLeft.append_REG1_COMPANY_NAME) <> '' => 'B','U'),
	                                               map(trim(pLeft.Own_Name1) <> '' => 'I',trim(pLeft.append_OWN_NAME_1_COMPANY) <> '' => 'B','U'));
	
	
	
	self.REG_1_CUSTOMER_NAME := if(pLeft.NAME_REGISTRANT_ALT <> '',
	                               if(pLeft.append_REG1_COMPANY_NAME <> '',
								      pLeft.append_REG1_COMPANY_NAME,
									  pLeft.Reg_Name1), 
									   if(pLeft.append_OWN_NAME_1_COMPANY <> '',
										  pLeft.append_OWN_NAME_1_COMPANY,
										   pLeft.Own_Name1));
								   
	self.REG_1_STREET_ADDRESS :=  if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                 pLeft.ADDR_STREET_REG_ALT,
	                                 pLeft.ADDR_STREET_OWNER_VEHICLE);
	self.REG_1_CITY :=           if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                 pLeft.ADDR_CITY_REG_ALT,
							         pLeft.ADDR_CITY_OWNER_VEHICLE);
	self.REG_1_STATE :=          if(pLeft.NAME_REGISTRANT_ALT <> '',
									 pLeft.ADDR_STATE_REG_ALT,
								     pLeft.ADDR_STATE_OWNER_VEHICLE);
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL := if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                           if(pLeft.ADDR_ZIPCODE_REG_ALT[7..10] != '0000',
											      pLeft.ADDR_ZIPCODE_REG_ALT[2..10],
												  pLeft.ADDR_ZIPCODE_REG_ALT[2..6]),
									                if(pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[7..10] != '0000',
													   pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[2..10],
													   pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[2..6]));
									  
	self.REGISTRANT_2_CUSTOMER_TYPE :=   if(pLeft.NAME_REGISTRANT_ALT <> '' AND pLeft.Reg_Name2 <> '',
	                                               map(trim(pLeft.Reg_Name2) <> '' => 'I','U'),
												   if(pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               map(trim(pLeft.Own_Name1) <> '' => 'I',trim(pLeft.append_OWN_NAME_2_COMPANY) <> '' => 'B','U'), ''));

	self.REG_2_CUSTOMER_NAME := if(pLeft.Reg_Name2 <> '',
	                               pLeft.Reg_Name2, 								   
								   if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.append_OWN_NAME_2_COMPANY <> '',
								      pLeft.append_OWN_NAME_2_COMPANY,
									   if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '',
								          pLeft.Own_Name2, '')));
										 
	self.REG_2_STREET_ADDRESS := if(pLeft.Reg_Name2 <> '',
	                                pLeft.ADDR_STREET_REG_ALT,
									if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
									   pLeft.ADDR_STREET_OWNER_VEHICLE, ''));
									   
	self.REG_2_CITY := 			  if(pLeft.Reg_Name2 <> '',
	                                 pLeft.ADDR_CITY_REG_ALT,
 									  if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '',
									     pLeft.ADDR_CITY_OWNER_VEHICLE, ''));
										
	self.REG_2_STATE := 		  if(pLeft.Reg_Name2 <> '',
	                                 pLeft.ADDR_STATE_REG_ALT,
									  if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '',
									     pLeft.ADDR_STATE_OWNER_VEHICLE, ''));
										
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL := if(pLeft.Reg_Name2 <> '',
	                                           if(pLeft.ADDR_ZIPCODE_REG_ALT[7..10] != '0000',
											      pLeft.ADDR_ZIPCODE_REG_ALT[2..10],
												  pLeft.ADDR_ZIPCODE_REG_ALT[2..6]),
									                if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '',
													   if(pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[7..10] != '0000',
													   pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[2..10],
													   pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[2..6]),''));
													   					
  	self.OWNER_1_CUSTOMER_TYPExBG3       :=     if(pLeft.Own_Name1 <> '' OR pLeft.append_OWN_NAME_1_COMPANY <> '',
	                                               map(trim(pLeft.Own_Name1) <> '' => 'I',trim(pLeft.append_OWN_NAME_1_COMPANY) <> '' => 'B','U'),
												    '');
	self.OWN_1_CUSTOMER_NAME             :=		if(pLeft.append_OWN_NAME_1_COMPANY <> '',
                                                    pLeft.append_OWN_NAME_1_COMPANY,
													pLeft.Own_Name1);
	//self.OWN_1_ADDR_NON_DISCLOSURE_FLAG  :=		pLeft.
	self.OWN_1_STREET_ADDRESS            :=		pLeft.ADDR_STREET_OWNER_VEHICLE;
	self.OWN_1_CITY                      :=		pLeft.ADDR_CITY_OWNER_VEHICLE;
	self.OWN_1_STATE                     :=		pLeft.ADDR_STATE_OWNER_VEHICLE;
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL  :=     if(pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[7..10] != '0000',
													   pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[2..10],
													   pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[2..6]);		
	
  	self.OWNER_2_CUSTOMER_TYPE           :=     if(pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               map(trim(pLeft.Own_Name2) <> '' => 'I',trim(pLeft.append_OWN_NAME_2_COMPANY) <> '' => 'B','U'),
												   '');
	self.OWN_2_CUSTOMER_NAME             :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                                   pLeft.append_OWN_NAME_2_COMPANY,
													   pLeft.Own_Name2);
	//self.OWN_2_ADDR_NON_DISCLOSURE_FLAG  :=		
	self.OWN_2_STREET_ADDRESS            :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.ADDR_STREET_OWNER_VEHICLE,
												   if(pLeft.Own_Name2 <> '',
												      pLeft.ADDR_STREET_OWNER_VEHICLE, ''));
	self.OWN_2_CITY                      :=	    if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.ADDR_CITY_OWNER_VEHICLE,
												   if(pLeft.Own_Name2 <> '',
												      pLeft.ADDR_CITY_OWNER_VEHICLE, ''));	

	self.OWN_2_STATE                     :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.ADDR_STATE_OWNER_VEHICLE,
												   if(pLeft.Own_Name2 <> '',
												      pLeft.ADDR_STATE_OWNER_VEHICLE, ''));
	self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL  :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               if(pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[7..10] != '0000',
													   pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[2..10],
													   pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[2..6]),
													   if(pLeft.Own_Name2 <> '',
													      if(pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[7..10] != '0000',
													         pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[2..10],
													         pLeft.ADDR_ZIPCODE_OWNER_VEHICLE[2..6]), ''));
													      
										
	self.LH_1_LIEN_DATE                  :=		if(pLeft.YEAR_LIEN_FILED_1 <> '',
	                                                if(pLeft.YEAR_LIEN_FILED_1 > '05',
													   '19' + pLeft.YEAR_LIEN_FILED_1 + pLeft.MONTH_LIEN_FILED_1 + pLeft.DAY_LIEN_FILED_1,
													   '20' + pLeft.YEAR_LIEN_FILED_1 + pLeft.MONTH_LIEN_FILED_1 + pLeft.DAY_LIEN_FILED_1), '');
	self.LH_1_CUSTOMER_NAME              :=		pLeft.NAME_LIENHOLDER_1;
	self.LH_1_STREET_ADDRESS             :=		pLeft.ADDR_STREET_LIENHOLDER_1;
	self.LH_1_CITY                       :=		pLeft.ADDR_CITY_LIENHOLDER_1;
	self.LH_1_STATE                      :=		pLeft.ADDR_STATE_LIENHOLDER_1;
	self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL   :=		pLeft.ADDR_ZIPCODE_LIENHOLDER_1;
	
	
	self.LH_2_LEIN_DATE                  :=	    if(pLeft.YEAR_LIEN_FILED_2 <> '',
	                                                if(pLeft.YEAR_LIEN_FILED_2 > '05',
													   '19' + pLeft.YEAR_LIEN_FILED_2 + pLeft.MONTH_LIEN_FILED_2 + pLeft.DAY_LIEN_FILED_2,
													   '20' + pLeft.YEAR_LIEN_FILED_2 + pLeft.MONTH_LIEN_FILED_2 + pLeft.DAY_LIEN_FILED_2), '');
	self.LH_2_CUSTOMER_NAME              :=		pLeft.NAME_LIENHOLDER_2;
	self.LH_2_STREET_ADDRESS             :=		pLeft.ADDR_STREET_LIENHOLDER_2;
	self.LH_2_CITY                       :=		pLeft.ADDR_CITY_LIENHOLDER_2;
	self.LH_2_STATE                      :=		pLeft.ADDR_STATE_LIENHOLDER_2;
	self.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL   :=		pLeft.ADDR_ZIPCODE_LIENHOLDER_2;

	
	
	self.own_1_title                     :=		pLeft.clean_NAME_OWNER_1_prefix;
	self.own_1_fname                     :=		pLeft.clean_NAME_OWNER_1_first;
	self.own_1_mname                     :=		pLeft.clean_NAME_OWNER_1_middle;
	self.own_1_lname                     :=		pLeft.clean_NAME_OWNER_1_last;
	self.own_1_name_suffix               :=		pLeft.clean_NAME_OWNER_1_suffix;
	self.own_1_company_name              :=		pLeft.append_OWN_NAME_1_COMPANY;
	self.own_1_prim_range                :=		pLeft.clean_OWNER_VEHICLE_prim_range;
	self.own_1_predir                    :=		pLeft.clean_OWNER_VEHICLE_predir;
	self.own_1_prim_name                 :=		pLeft.clean_OWNER_VEHICLE_prim_name;
	self.own_1_suffix                    :=		pLeft.clean_OWNER_VEHICLE_addr_suffix;
	self.own_1_postdir                   :=		pLeft.clean_OWNER_VEHICLE_postdir;
	self.own_1_unit_desig                :=		pLeft.clean_OWNER_VEHICLE_unit_desig;
	self.own_1_sec_range                 :=		pLeft.clean_OWNER_VEHICLE_sec_range;
	self.own_1_p_city_name               :=		pLeft.clean_OWNER_VEHICLE_p_city_name;
	self.own_1_v_city_name               :=		pLeft.clean_OWNER_VEHICLE_v_city_name;
	self.own_1_state_2                   :=		pLeft.clean_OWNER_VEHICLE_st;
	self.own_1_zip5                      :=		pLeft.clean_OWNER_VEHICLE_zip;
	self.own_1_zip4                      :=		pLeft.clean_OWNER_VEHICLE_zip4;
	self.own_1_county                    :=		pLeft.clean_OWNER_VEHICLE_fipscounty;
	self.own_1_geo_lat                   :=		pLeft.clean_OWNER_VEHICLE_geo_lat;
	self.own_1_geo_long                  :=		pLeft.clean_OWNER_VEHICLE_geo_long;

	self.own_2_title                     :=		pLeft.clean_NAME_OWNER_2_prefix;
	self.own_2_fname                     :=		pLeft.clean_NAME_OWNER_2_first;
	self.own_2_mname                     :=		pLeft.clean_NAME_OWNER_2_middle;
	self.own_2_lname                     :=		pLeft.clean_NAME_OWNER_2_last;
	self.own_2_name_suffix               :=		pLeft.clean_NAME_OWNER_2_suffix;
	self.own_2_company_name              :=		pLeft.append_OWN_NAME_2_COMPANY;
	
	self.own_2_prim_range                :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_prim_range,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_prim_range, ''));
	self.own_2_predir                    :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_predir,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_predir, ''));
	self.own_2_prim_name                 :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_prim_name,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_prim_name, ''));
	self.own_2_suffix                    :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_addr_suffix,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_addr_suffix, ''));
	self.own_2_postdir                   :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_postdir,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_postdir, ''));
	self.own_2_unit_desig                :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_unit_desig,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_unit_desig, ''));
	self.own_2_sec_range                 :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_sec_range,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_sec_range, ''));
	self.own_2_p_city_name               :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_p_city_name,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_p_city_name, ''));
	self.own_2_v_city_name               :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_v_city_name,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_v_city_name, ''));
	self.own_2_state_2                   :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_st,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_st, ''));
	self.own_2_zip5                      :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_zip,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_zip, ''));
	self.own_2_zip4                      :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_zip4,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_zip4, ''));
	self.own_2_county                    :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_fipscounty,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_fipscounty, ''));
	self.own_2_geo_lat                   :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_geo_lat,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_geo_lat, ''));
	self.own_2_geo_long                  :=		if(pLeft.append_OWN_NAME_2_COMPANY <> '',
	                                               pLeft.clean_OWNER_VEHICLE_geo_long,
												   if(pLeft.clean_NAME_OWNER_2_last <> '',
												      pLeft.clean_OWNER_VEHICLE_geo_long, ''));

	self.reg_1_title 		              :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_NAME_REG_1_ALT_prefix,
								                   pLeft.clean_NAME_OWNER_1_prefix);
	self.reg_1_fname 		              :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_NAME_REG_1_ALT_first,
								                   pLeft.clean_NAME_OWNER_1_first);
	self.reg_1_mname 		              :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_NAME_REG_1_ALT_middle,
								                   pLeft.clean_NAME_OWNER_1_middle);
	self.reg_1_lname 		              :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_NAME_REG_1_ALT_last,
								                   pLeft.clean_NAME_OWNER_1_last);
	self.reg_1_name_suffix 		          :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_NAME_REG_1_ALT_suffix,
								                   pLeft.clean_NAME_OWNER_1_suffix);
	self.reg_1_company_name 		      :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.append_REG1_COMPANY_NAME,
								                   pLeft.append_OWN_NAME_1_COMPANY);
	self.reg_1_prim_range 		          :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_prim_range,
								                   pLeft.clean_OWNER_VEHICLE_prim_range);
	self.reg_1_predir 		              :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_predir,
								                   pLeft.clean_OWNER_VEHICLE_predir);
	self.reg_1_prim_name 		          :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_prim_name,
								                   pLeft.clean_OWNER_VEHICLE_prim_name); 
	self.reg_1_suffix 		              :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_addr_suffix,
								                   pLeft.clean_OWNER_VEHICLE_addr_suffix);									   
	self.reg_1_postdir 		          	  :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_postdir,
								                   pLeft.clean_OWNER_VEHICLE_postdir);
	self.reg_1_unit_desig 		          :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_unit_desig,
								                   pLeft.clean_OWNER_VEHICLE_unit_desig);
	self.reg_1_sec_range 		          :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_sec_range,
								                   pLeft.clean_OWNER_VEHICLE_sec_range);
	self.reg_1_p_city_name 		          :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_p_city_name,
								                   pLeft.clean_OWNER_VEHICLE_p_city_name);
	self.reg_1_v_city_name 		          :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_v_city_name,
								                   pLeft.clean_OWNER_VEHICLE_v_city_name);
	self.reg_1_state_2 		              :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_st,
								                   pLeft.clean_OWNER_VEHICLE_st);
	self.reg_1_zip5 		              :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_zip,
								                   pLeft.clean_OWNER_VEHICLE_zip);
	self.reg_1_zip4 		              :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_zip4,
								                   pLeft.clean_OWNER_VEHICLE_zip4);
	self.reg_1_county 		              :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_fipscounty,
								                   pLeft.clean_OWNER_VEHICLE_fipscounty);
	self.reg_1_geo_lat                    :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_geo_lat,
								                   pLeft.clean_OWNER_VEHICLE_geo_lat);
	self.reg_1_geo_long                   :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               pLeft.clean_REG_ALT_geo_long,
								                   pLeft.clean_OWNER_VEHICLE_geo_long);												   
												   
	self.reg_2_title 		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_NAME_REG_2_ALT_prefix,
  												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '',
												       pLeft.clean_NAME_OWNER_2_prefix, ''));
	self.reg_2_fname 		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_NAME_REG_2_ALT_first,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '',
												       pLeft.clean_NAME_OWNER_2_first, ''));
	self.reg_2_mname 		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_NAME_REG_2_ALT_middle,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '',
												       pLeft.clean_NAME_OWNER_2_middle, ''));
	self.reg_2_lname 		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_NAME_REG_2_ALT_last,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '',
												       pLeft.clean_NAME_OWNER_2_last, ''));
												   
												   
	self.reg_2_name_suffix 		          :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_NAME_REG_2_ALT_suffix,
												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '',
												       pLeft.clean_NAME_OWNER_2_suffix, ''));
	self.reg_2_company_name 		      :=    if(pLeft.NAME_REGISTRANT_ALT <> '',
	                                               '',
								                     if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.append_OWN_NAME_2_COMPANY <> '',
													    pLeft.append_OWN_NAME_2_COMPANY, ''));
												   
	self.reg_2_prim_range 		          :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_prim_range,
  												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_prim_range, ''));
	self.reg_2_predir 		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_predir,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_predir, ''));
	self.reg_2_prim_name 		          :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_prim_name,
  												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_prim_name, ''));
	self.reg_2_suffix  		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_addr_suffix,
  												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_addr_suffix, ''));
	self.reg_2_postdir 		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_postdir,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_postdir, ''));
	self.reg_2_unit_desig 	              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_unit_desig,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_unit_desig, ''));
	self.reg_2_sec_range 	              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_sec_range,
  												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_sec_range, ''));
	self.reg_2_p_city_name 	              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_p_city_name,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_p_city_name, ''));
	self.reg_2_v_city_name 	              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_v_city_name,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_v_city_name, ''));
	self.reg_2_state_2 		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_st,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_st, ''));
	self.reg_2_zip5 		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_zip,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_zip, ''));
	self.reg_2_zip4 		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_zip4,
  												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_zip4, ''));
	self.reg_2_county		              :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_fipscounty,
  												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_fipscounty, ''));
	self.reg_2_geo_lat                    :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_geo_lat,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_geo_lat, ''));
	self.reg_2_geo_long                   :=    if(pLeft.Reg_Name2 <> '',
	                                               pLeft.clean_REG_ALT_geo_long,
   												    if(pLeft.NAME_REGISTRANT_ALT = '' AND pLeft.Own_Name2 <> '' OR pLeft.append_OWN_NAME_2_COMPANY <> '',
								                       pLeft.clean_OWNER_VEHICLE_geo_long, ''));

end;

export KY_as_Vehicles := project(vehlic.File_KY_Full + vehlic.File_Ky_Update, KYFullToCommon(left));