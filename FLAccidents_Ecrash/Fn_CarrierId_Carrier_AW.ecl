import ut,carrierid_services;

export Fn_CarrierId_Carrier_AW (dataset(recordof(FLAccidents_Ecrash.layout_Accident_watch.temp)) in_ ) := function

key_in:=  distribute(project(FLAccidents_Ecrash.key_EcrashV2_accnbr,transform ({FLAccidents_Ecrash.key_EcrashV2_accnbr}, self.dob := if(stringlib.StringFilterout(left.dob, '0') = '', '',left.dob)
                                                                    ,self.driver_license_nbr := if(stringlib.StringFilterout(left.driver_license_nbr, '0') = '', '',left.driver_license_nbr), self.carrier_name := if(trim(left.Insurance_Company_Standardized,left,right) <>'' ,left.Insurance_Company_Standardized,left.carrier_name), self := left))(carrier_name <>''),hash(Did));  


key_did_dedup := dedup(sort(key_in,did,vin,accident_date,jurisdiction_state,-date_vendor_last_reported,map(report_code in [ 'EA','TF','TM'] => 1,
																																																											    report_code[1] = 'I' => 2,
																																																													report_code = 'A' => 2,3),carrier_name,local), did,vin,accident_date,jurisdiction_state,local); 
AW_in_w_name := distribute(in_((unsigned) did <> 0 ), hash(did));

jdid:= dedup(join (AW_in_w_name, key_did_dedup,
				 (unsigned)left.did = (unsigned)right.did and 
				 trim(left.vin,left,right) = trim(right.vin,left,right) and 
				 ut.daysapart(left.accident_date,right.accident_date)<=3 and 
				 left.jurisdiction_state = right.jurisdiction_state
				 , transform(FLAccidents_Ecrash.layout_Accident_watch.temp , self.carrier_id_carriername := right.carrier_name,
				 self.carrier_id_carrierSource := map(right.report_code in ['EA','FA','TM','TF']=>right.report_code,
															                           right.report_code[1] ='I' =>'NatInq',
																												 right.report_code in carrierid_services.constants.natl_keyed_set => 'NatAcc',''), self := left)
					, left outer, local ),all,local); 

No_did := in_ ((unsigned) did = 0 ) ;

name_match := distribute(No_did (fname <>'' and lname <>'')+  jdid(carrier_id_carriername =''), hash(fname,lname,vin));

//give prefrence to EA,Iyetek... and leave latest carrier.

key_sort :=sort( distribute(key_in , hash(fname,lname,vin)),fname,lname,vin,accident_date,-date_vendor_last_reported,driver_license_nbr,dob,jurisdiction_state,map(report_code in [ 'EA','TF','TM'] => 1,
																																																											    report_code[1] = 'I' => 2,
																																																													report_code = 'A' => 2,3),carrier_name,local) ;

key_namededup := dedup(key_sort, fname,lname,vin,accident_date,ut.nneq(left.driver_license_nbr,right.driver_license_nbr),ut.nneq(left.dob,right.dob),jurisdiction_state,local); 

jname:= dedup(join (name_match, key_namededup,
         trim(left.fname,left,right) = trim(right.fname,left,right) and 
				 trim(left.lname,left,right) = trim(right.lname,left,right) and 
				 trim(left.vin,left,right) = trim(right.vin,left,right) and 
				 ut.daysapart(left.accident_date,right.accident_date)<=3 and 
				 ut.nneq(left.driver_license_nbr,right.driver_license_nbr)and
				 ut.nneq(left.dob[1..6],right.dob[1..6]) and 
				 left.jurisdiction_state = right.jurisdiction_state
				 , transform(FLAccidents_Ecrash.layout_Accident_watch.temp , self.carrier_id_carriername := right.carrier_name,
				 self.carrier_id_carrierSource := map(right.report_code in ['EA','FA','TM','TF']=>right.report_code,
															                           right.report_code[1] ='I' =>'NatInq',
																												 right.report_code in carrierid_services.constants.natl_keyed_set => 'NatAcc',''), self := left)
					, left outer, local ),all,local); 

AW_vin :=  No_did(~(fname <>'' and lname <>''))+ project(jname(carrier_id_carriername =''),FLAccidents_Ecrash.layout_Accident_watch.temp); 

AW_vin_nblk := distribute(AW_vin (vin<> ''), hash(vin));

key_in_vin := sort(distribute(key_in, hash(vin)),vin,tag_nbr,accident_date,jurisdiction_state,-date_vendor_last_reported,map(report_code in [ 'EA','TF','TM'] => 1,
																																																											    report_code[1] = 'I' => 2,
																																																				report_code = 'A' => 2,3),carrier_name,local) ;

key_in_vin_dedup := dedup(key_in_vin,vin,tag_nbr,accident_date,jurisdiction_state,local); 

// if no match join by vin and +- 3 day dol.

jvin:= dedup(join (AW_vin_nblk,key_in_vin_dedup, 
				 trim(left.vin,left,right) = trim(right.vin,left,right) and 
				  trim(left.tag_nbr,left,right) = trim(right.tag_nbr,left,right) and 
				  ut.daysapart(left.accident_date,right.accident_date)<=3 and 
				 left.jurisdiction_state = right.jurisdiction_state
				 , transform(FLAccidents_Ecrash.layout_Accident_watch.temp, self.carrier_id_carriername := right.carrier_name , 
				 	 , self.carrier_id_carrierSource := map(right.report_code in ['EA','FA','TM','TF']=>right.report_code,
															                           right.report_code[1] ='I' =>'NatInq',
																												 right.report_code in carrierid_services.constants.natl_keyed_set => 'NatAcc',''), self := left)
					, left outer, local ),all,local); 

total := jdid(carrier_id_carriername <>'') + jname(carrier_id_carriername <>'')+ jvin + AW_vin (vin = '');

// if carrier_name <>'' and carrier_id_carrier_name = ''. lname blank and vin blank.around 17 records 

return project(total,transform(FLAccidents_Ecrash.layout_Accident_watch.temp , 

                               self.carrier_id_carriername := if(left.carrier_name <>'' and left.carrier_id_carriername = '' , 
															                                   if (left.Insurance_Company_Standardized <>'', left.Insurance_Company_Standardized, left.carrier_name), left.carrier_id_carriername) ; 
																self.carrier_id_carrierSource := if(left.carrier_name <>'' and left.carrier_id_carriername = '', left.source_id ,left.carrier_id_carrierSource); 
																self := left)); 

																
end; 
