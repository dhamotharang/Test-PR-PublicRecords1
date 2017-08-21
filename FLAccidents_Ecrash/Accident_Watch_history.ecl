curr := FLAccidents_Ecrash.key_EcrashV2_accnbr(report_code =  'EA' ); 
prev := FLAccidents_Ecrash.key_EcrashV2_accnbr_father(report_code =  'EA'); 

curr_dist := distribute(curr( work_type_id in ['2', '3'] and accident_date >= '20100701'),hash(orig_accnbr,report_code)) ; 
prev_dist := dedup(distribute(prev( work_type_id in ['2', '3'] and accident_date >= '20100701'),hash(orig_accnbr,report_code)),orig_accnbr,jurisdiction_state,accident_date,work_type_id,all,local) ; 


new_recs := join(curr_dist(accident_date between  '20101001' AND '20121030' ),prev_dist(~(accident_date between   '20101001' AND '20121030' ))   , left.orig_accnbr = right.orig_accnbr and 
                             					 left.jurisdiction_state = right.jurisdiction_state and 
																			 left.accident_date  = right.accident_date and 
                                       left.work_type_id = right.work_type_id 
														, 
	  													 transform({FLAccidents_Ecrash.layout_Accident_watch.temp},  self.agency_id:= left.jurisdiction_nbr, self.source_id := if(left.report_code in ['EA','FA','TM','TF'],left.report_code,
															                           if(left.report_code[1] ='I' ,'NatInq','NatAcc')), self.process_date_time := ut.getdate+'_'+ut.gettime() , self.hash_key := left.image_hash,self.CRU_Seq_number := left.cru_sequence_nbr, self := left,self:= []), left only ,local); 

valid_recs  := new_recs(fname <> '' or lname <>'' or vin<>''); 
// Append carrier id carrier. 

get_carrier_id_carrier := FLAccidents_Ecrash.Fn_CarrierId_Carrier_AW (valid_recs); 

// keep two records one for vin and one for person. 
vin_non_blank := get_carrier_id_carrier(vin != '') ; 
vin_blank := project(get_carrier_id_carrier(vin = ''),transform(FLAccidents_Ecrash.layout_Accident_watch.temp, self.tag_nbr := '', self.tagnbr_st:= '', self.report_type := 'P',self.vehicle_status :='', self := left));  
vin_non_blank_person := project(vin_non_blank, transform(FLAccidents_Ecrash.layout_Accident_watch.temp, self.vin := '', self.tag_nbr := '', self.tagnbr_st:= '', self.report_type := 'P' ,self.vehicle_status :='', self := left)); 

vin := project(vin_non_blank, transform(FLAccidents_Ecrash.layout_Accident_watch.temp, 
 self.did := ''; 
  self.title:= ''; 
  self.fname:= ''; 
  self.mname:= ''; 
  self.lname:= ''; 
  self.name_suffix:= ''; 
  self.dob:= ''; 
  self.b_did:= ''; 
  self.cname:= ''; 
  self.prim_range:= ''; 
  self.predir:= ''; 
  self.prim_name:= ''; 
  self.addr_suffix:= ''; 
  self.postdir:= ''; 
  self.unit_desig:= ''; 
  self.sec_range:= ''; 
  self.v_city_name:= ''; 
  self.st:= ''; 
  self.zip:= ''; 
  self.zip4:= ''; 
  self.driver_license_nbr:= ''; 
  self.dlnbr_st:= ''; 
	self.report_type := 'V' ; 
	self.record_type := ''; 
	//self.vehicle_unit_number := ''; 
	self:= left;
))(vehicle_status = 'V'); 

total := (vin_blank+vin_non_blank_person +vin) (fname <> '' or lname <>'' or vin<>'') ;


final := project(dedup(total,record,all), transform({FLAccidents_Ecrash.layout_Accident_watch.final},
 
                  self.carrier_id_carriername := if(left.record_type in FLAccidents_Ecrash.personType_set , '', left.carrier_id_carriername); 
									self.carrier_id_carrierSource := if(left.record_type in FLAccidents_Ecrash.personType_set , '',left.carrier_id_carrierSource); 
									self.Policy_Effective_Date := if(left.record_type in FLAccidents_Ecrash.personType_set , '',left.Policy_Effective_Date); 
									self.Policy_num := if(left.record_type in FLAccidents_Ecrash.personType_set , '',left.Policy_num);
									self.carrier_name := if(left.record_type in FLAccidents_Ecrash.personType_set , '',left.carrier_name); 
									self.Insurance_Company_Standardized := if(left.record_type in FLAccidents_Ecrash.personType_set , '',left.Insurance_Company_Standardized); 
									self := left));
									
 output(final(accident_date between '20101001' and '20101030')  ,,'~thor_data::out::AccidentWatch_201010',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20101101' and '20101130')  ,,'~thor_data::out::AccidentWatch_201011',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20101201' and '20101230')  ,,'~thor_data::out::AccidentWatch_201012',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final (accident_date between '20110101' and '20110130') ,,'~thor_data::out::AccidentWatch_201101',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20110201' and '20110230')  ,,'~thor_data::out::AccidentWatch_201102',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20110301' and '20110330')  ,,'~thor_data::out::AccidentWatch_201103',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20110401' and '20110430')  ,,'~thor_data::out::AccidentWatch_201104',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20110501' and '20110530')  ,,'~thor_data::out::AccidentWatch_201105',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20110601' and '20110630')  ,,'~thor_data::out::AccidentWatch_201106',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20110701' and '20110730')  ,,'~thor_data::out::AccidentWatch_201107',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20110801' and '20110830')  ,,'~thor_data::out::AccidentWatch_201108',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20110901' and '20110930')  ,,'~thor_data::out::AccidentWatch_201109',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20111001' and '20111030')  ,,'~thor_data::out::AccidentWatch_201110',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20111101' and '20111130')  ,,'~thor_data::out::AccidentWatch_201111',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20111201' and '20111230')  ,,'~thor_data::out::AccidentWatch_201112',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20120101' and '20120130')  ,,'~thor_data::out::AccidentWatch_201201',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20120201' and '20120230')  ,,'~thor_data::out::AccidentWatch_201202',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20120301' and '20120330')  ,,'~thor_data::out::AccidentWatch_201203',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20120401' and '20120430')  ,,'~thor_data::out::AccidentWatch_201204',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20120501' and '20120530')  ,,'~thor_data::out::AccidentWatch_201205',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20120601' and '20120630')  ,,'~thor_data::out::AccidentWatch_201206',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

 output(final(accident_date between '20120701' and '20120730')  ,,'~thor_data::out::AccidentWatch_201207',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);
 output(final(accident_date between '20120801' and '20120830')  ,,'~thor_data::out::AccidentWatch_201208',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);
			 output(final(accident_date between '20120901' and '20120930')  ,,'~thor_data::out::AccidentWatch_201209',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);
			 output(final(accident_date between '20121001' and '20121030')  ,,'~thor_data::out::AccidentWatch_201210',csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);