import _control , ut, STD; 
export Proc_build_Accident_watch (string filedate,string timestamp):= function

// EA (2,3) and only records after july 2010 and vin status V should be allowed. 

curr := FLAccidents_Ecrash.key_EcrashV2_accnbr(report_code =  'EA' ); 
prev := FLAccidents_Ecrash.key_EcrashV2_accnbr_father(report_code =  'EA'); 

curr_dist := distribute(curr( work_type_id in ['2', '3'] and accident_date >= '20100701'),hash(orig_accnbr,report_code)) ; 
prev_dist := dedup(distribute(prev( work_type_id in ['2', '3'] and accident_date >= '20100701'),hash(orig_accnbr,report_code)),orig_accnbr,jurisdiction_state,accident_date,work_type_id,all,local) ; 


new_recs := join(curr_dist,prev_dist , left.orig_accnbr = right.orig_accnbr and 
                             					 left.jurisdiction_state = right.jurisdiction_state and 
																			 left.accident_date  = right.accident_date and 
                                       left.work_type_id = right.work_type_id 
														, 
	  													 transform({FLAccidents_Ecrash.layout_Accident_watch.temp},  self.agency_id:= left.jurisdiction_nbr, self.source_id := if(left.report_code in ['EA','FA','TM','TF'],left.report_code,
															                           if(left.report_code[1] ='I' ,'NatInq','NatAcc')), self.process_date_time := mod_Utilities.StrSysDate+'_'+timestamp , self.hash_key := left.image_hash,self.CRU_Seq_number := left.cru_sequence_nbr, self := left,self:= []), left only ,local); 

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
                  
	                self.record_type                    := STD.Str.FindReplace(left.record_type,'|',' ');
                  self.driver_license_nbr             := STD.Str.FindReplace(left.driver_license_nbr,'|',' ');
                  self.accident_location              := STD.Str.FindReplace(left.accident_location,'|',' ');
                  self.accident_street                := STD.Str.FindReplace(left.accident_street,'|',' ');
                  self.accident_cross_street          := STD.Str.FindReplace(left.accident_cross_street,'|',' ');
                  self.jurisdiction                   := STD.Str.FindReplace(left.jurisdiction,'|',' ');
                  self.jurisdiction_state             := STD.Str.FindReplace(left.jurisdiction_state,'|',' ');
                  self.vehicle_incident_city          := STD.Str.FindReplace(left.vehicle_incident_city,'|',' ');
                  tcarrier_name                       := STD.Str.FindReplace(left.carrier_name,'|',' '); 
                  tPolicy_num                         := STD.Str.FindReplace(left.Policy_num,'|',' ');
                  //self.Policy_Effective_Date        := STD.Str.FindReplace(left.Policy_Effective_Date,'|',' '); 
                  tInsurance_Company_Standardized     := STD.Str.FindReplace(left.Insurance_Company_Standardized,'|',' ');
                  tcarrier_id_carriername             := STD.Str.FindReplace(left.carrier_id_carriername,'|',' ');
                  self.carrier_id_carriername         := if(left.record_type in FLAccidents_Ecrash.personType_set , '', tcarrier_id_carriername); 
									self.carrier_id_carrierSource       := if(left.record_type in FLAccidents_Ecrash.personType_set , '',left.carrier_id_carrierSource); 
									self.Policy_Effective_Date          := if(left.record_type in FLAccidents_Ecrash.personType_set , '',left.Policy_Effective_Date); 
									self.Policy_num                     := if(left.record_type in FLAccidents_Ecrash.personType_set , '',tPolicy_num);
									self.carrier_name                   := if(left.record_type in FLAccidents_Ecrash.personType_set , '',tcarrier_name); 
									self.Insurance_Company_Standardized := if(left.record_type in FLAccidents_Ecrash.personType_set , '',tInsurance_Company_Standardized); 
									
									self := left));
									
dAccwatch := output(final  ,,'~thor_data::out::AccidentWatch_'+filedate+'_'+timestamp,csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

checkfileexists(string name )
 := if(fileservices.SuperFileExists(name) and fileservices.GetSuperFileSubCount(name) > 0,
	 true,
	 false
	)
 ;
 
 string_rec	:=
	record
		string1	flag;
		string20 process_datetime; 
	end;
 
AW_clear_trigger := dataset('~thor_data::base::accidentwatch_trigger',string_rec  ,flat);

clear_boca_super:= if (AW_clear_trigger[1].flag = 'C',
                          sequential(fileservices.clearsuperfile('~thor_data::base::AccidentWatch_update'), 
													fileservices.clearsuperfile('~thor_data::base::accidentwatch_trigger'))
													,output('ATL thor not picked latest files') );
													
	boca_super := if (checkfileexists('~thor_data::base::accidentwatch_trigger') , clear_boca_super, output('ATL thor not picked latest files so dont clear boca super')); 
	

sfShuffle := sequential(
  
	boca_super,
	fileservices.addsuperfile('~thor_data::base::AccidentWatch_update','~thor_data::out::AccidentWatch_'+filedate+'_'+timestamp),
	fileservices.addsuperfile('~thor_data::base::AccidentWatch_full','~thor_data::out::AccidentWatch_'+filedate+'_'+timestamp)
	
	/* copy file to ATL thor
	fileservices.Copy('~thor_data::base::AccidentWatch_update','thor100_80','~thor_data::base::accidentwatch_update',_control.IPAddress.prod_thor_dali,
												,'http://10.194.12.2:8010/FileSpray',,true,true,true)
	*/
);
	
 return sequential (dAccwatch, sfShuffle); 

end; 