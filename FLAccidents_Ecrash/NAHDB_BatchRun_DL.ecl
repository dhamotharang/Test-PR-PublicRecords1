
import Address,ut,_control; 

EXPORT NAHDB_BatchRun_DL(string filedate/*, string customerName*/) := function 

layoutNahdbBatchDL := Record
string DriverLicenseNumber,
string Driver_Last_Name,
string Driver_First_Name,
string DOB,
string LexID,
string Accident_Date
end;


/*string lesse, 
string gaurentor,*/ 

layoutOut := Record 
string acc_vin,
string order_id	,
string sequence_nbr,	
string reason_id,
string acct_nbr	,
string vehicle_incident_id,
string vehicle_unit_number,	
string vendor_code,
string work_type_id, 
string orig_lname, 
string orig_fname,
string orig_mname,
string vehicle_owner,
string dob,
string driver_license_nbr,
string dlnbr_st,
string vehicle_year,
string  vehicle_make,
string  vehicle_model,
string tag_nbr,
string tagnbr_st,
string report_type_id,
string loss_type,
string acc_dol,
string accident_location, 
string acc_city,	
string vehicle_incident_city,
string acc_st	,
string jurisdiction,
string orig_accnbr,	
string accident_nbr,
string addl_report_number,
string acc_county,
string crash_county,
string cru_jurisdiction_nbr,
string agency_ori,
string carrier_name,	
string  Insurance_policy_num,	   
string Insurance_policy_Eff_Date,   
string Insurance_policy_Exp_Date,
string source_id,	
string report_code,	
string match_flag,	
string date_vendor_last_reported
	
end; 
filein := dedup(dataset('~thor_data::in::nahdb::mvr', layoutNahdbBatchDL, CSV(Terminator (['\n','\r\n']), Heading(1), Quote('"'), Separator([',']))),all);


 // filter out I7 or Interactive reports 

 EA_natl_keyed_inquiry_set   := ['FA','EA','TM','TF','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                                 'IA','IB','IC','ID','IE','IF','IG','IH','II','IJ','IK','IL','IM','IN','IO','IP','IQ','IR','IS','IT','IU','IV','IW','IX','IY','IZ'];

 accidents0:= FLAccidents_Ecrash.File_KeybuildV2.out(report_code in EA_natl_keyed_inquiry_set); 
 
 accidents1 := PROJECT(accidents0,transform(recordof(accidents0),self.record_type := trim(regexreplace('\\t|\\n| ',left.record_type,'')),self.cru_jurisdiction_nbr  :=   regexreplace('\\^M',left.cru_jurisdiction_nbr,''),
             self := left));


 accidents := distribute(accidents1(vin <> ''),hash(driver_license_nbr,lname,fname)); 
 accidentDedup := dedup(sort(accidents,vin,did,orig_accnbr,accident_date,jurisdiction_state,jurisdiction,cru_order_id, report_type_id,-date_vendor_last_reported,map(report_code in [ 'EA','TF','TM'] => 1,  report_code[1] = 'I' => 2,
																																																									 report_code = 'A' => 2,3),carrier_name,local), vin,did,orig_accnbr,accident_date,jurisdiction_state,jurisdiction,cru_order_id,report_type_id, local); 

 //vin match 

vin_match:= dedup(join(accidentDedup, distribute(filein,hash(DriverLicenseNumber,Driver_Last_Name,Driver_First_Name)),
                
				trim(left.driver_license_nbr,left,right) = trim(right.DriverLicenseNumber,left,right) and
				trim(left.lname,left,right) = trim(right.Driver_Last_Name,left,right) and
				trim(left.fname,left,right) = trim(right.Driver_First_Name,left,right) /*and
				trim(left.dob,left,right) = trim(right.DOB,left,right) and
				trim(left.did,left,right) = trim(right.LexID,left,right) /*and
				trim(left.accident_date,left,right) = trim(right.Accident_Date,left,right) /*and 
				ut.daysapart(right.clean_date_of_incident,left.accident_date) <=90 */,
				transform(layoutOut, 
				  
				   self.acc_dol := left.accident_date ; 
				   self.acc_city := left.vehicle_incident_city; 
				   self.acc_st := left.vehicle_incident_st; 
				   self.acc_county := left.crash_county; 
					 self.acc_vin  :=left.vin,
					 self.order_id:= left.cru_order_id ; 
	         self.sequence_nbr :=left.cru_sequence_nbr;;
	         self.acct_nbr := left.acct_nbr;
	         self.vehicle_incident_id := left.vehicle_incident_id; 
	         self.carrier_name := left.carrier_name; 
           self.source_id := if(left.report_code in ['EA','FA','TM','TF'],left.report_code,
															                           if(left.report_code[1] ='I' ,'NatInq','NatAcc')); 

	         self.report_code := left.report_code ; 
					 self.orig_accnbr := left.orig_accnbr;
	         self.date_vendor_last_reported := left.date_vendor_last_reported; 
	         self.match_flag := if(self.acc_dol <>'' ,'E',''); 
					 self.loss_type := left.report_code_desc;
					 self.orig_lname := left.orig_lname;
					 self.orig_fname := left.orig_fname;
					 self.orig_mname := left.orig_mname;
				//	 self.Involved_party := trim(left.orig_lname) + ' '+ trim(left.orig_fname) + ' '+ trim(left.orig_mname);
					 self.vehicle_owner := if ( trim(left.record_type) = 'UNKNOWN','',left.record_type);
					 self.vehicle_year  := left.vehicle_year;
					 self.vehicle_make := left.make_description;
					 self.vehicle_model := left.model_description;
					 self.Insurance_policy_num := left.Policy_num;
					 self.Insurance_policy_Eff_Date := left.Policy_Effective_Date;
					 self.Insurance_policy_Exp_Date := left.Policy_Expiration_Date;
					 self.accident_location     :=  left.accident_location ;
           self.accident_nbr          :=  left.accident_nbr ;
           self.addl_report_number    :=  left.addl_report_number     ;
           self.agency_ori            :=  left.agency_ori;
           self.crash_county          :=  left.crash_county;
           self.cru_jurisdiction_nbr  :=  left.cru_jurisdiction_nbr   ;
           self.dlnbr_st              :=  left.dlnbr_st ;
           self.dob                   :=  left.dob ;
           self.driver_license_nbr    :=  left.driver_license_nbr     ;
           self.jurisdiction          :=  left.jurisdiction ;
           self.reason_id             :=  left.reason_id ;
           self.report_type_id        :=  left.report_type_id;
           self.tag_nbr               :=  left.tag_nbr;
           self.tagnbr_st             :=  left.tagnbr_st;
           self.vehicle_incident_city :=  left.vehicle_incident_city  ;
           self.vehicle_unit_number   :=  left.vehicle_unit_number    ;
           self.vendor_code           :=  left.vendor_code;
           self.work_type_id          :=  left.work_type_id;
					 self := right 
				   ), right outer,local),all);


// remove multiple vin records caused due to VIN lookup from batch

out := project(vin_match,transform(layoutOut, self.source_id := if (left.acc_dol ='', '', left.source_id), self := left)); 

										
return sequential(FLAccidents_Ecrash.Spray_nahdb_mvr(filedate), 
                 count(filein); 
                 //output(out); 
                 count(out); 
                 count(out(acc_dol <>'')); 
                 output(out,,'~thor_data::out::nahdb_batch_mvr_'+filedate,csv(
                 HEADING('acc_vin| order_id	| sequence_nbr|	 reason_id| acct_nbr	| vehicle_incident_id| vehicle_unit_number |	vendor_code| work_type_id|  orig_lname | orig_fname | orig_mname |  vehicle_owner| dob| driver_license_nbr| dlnbr_st| vehicle_year|  vehicle_make|  vehicle_model| tag_nbr| tagnbr_st| report_type_id| loss_type| acc_dol| accident_location|  acc_city|	 vehicle_incident_city| acc_st	| jurisdiction| orig_accnbr|	 accident_nbr| addl_report_number| acc_county| crash_county| cru_jurisdiction_nbr| agency_ori| carrier_name|	  Insurance_policy_num|	    Insurance_policy_Eff_Date|    Insurance_policy_Exp_Date| source_id|	 report_code|	 match_flag|	 date_vendor_last_reported  \n','',SINGLE),
                 SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE), 
						     fileservices.despray('~thor_data::out::nahdb_batch_mvr_'+filedate, _control.IPAddress.bctlpedata10, '/data/hds_180/cjr/nahdb_out_mvr_'+filedate+'.csv',,,,TRUE)); 

end; 
