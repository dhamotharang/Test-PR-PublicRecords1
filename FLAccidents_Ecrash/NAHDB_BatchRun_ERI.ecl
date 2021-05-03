import Address,ut,_control,std,Prof_License_preprocess; 

export NAHDB_BatchRun_ERI(string filedate) := function 

layoutNahdbBatch := Record
string STATE;
string ID;
string FIRST_NAME;
string MIDDILE_NAME;
string LAST_NAME;
string ADDRESS1;
string ADDRESS2;
string CITY;
string ST;
string ZIPCODE;
string BIRTH_DT;
string ACCIDENT_DT;
string ADMIT_DT;
string DISCHARGE_DT;
string MobilePhone;
string HomePhone;
string WorkPhone;
End;

//Commented fields as per Bug DF-23776
layoutOut := Record 
layoutNahdbBatch;
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
filein := dedup(dataset('~thor_data::in::nahdb::name', layoutNahdbBatch, csv(terminator (['\n','\r\n']), heading(1), quote('"'), separator([',']))),all);

layoutNahdbBatch convdatestr ( filein l ) := transform
self.BIRTH_DT := Prof_License_preprocess.dateconv( STD.Str.FilterOut ( trim(l.BIRTH_DT) , '-/'));
self.ACCIDENT_DT := Prof_License_preprocess.dateconv( STD.Str.FilterOut ( trim(l.ACCIDENT_DT) , '-/'));
self.ADMIT_DT := Prof_License_preprocess.dateconv( STD.Str.FilterOut ( trim(l.ADMIT_DT) , '-/'));
self.DISCHARGE_DT := Prof_License_preprocess.dateconv( STD.Str.FilterOut ( trim(l.DISCHARGE_DT) , '-/'));
self.FIRST_NAME := STD.Str.ToUpperCase ( l.FIRST_NAME);
self.LAST_NAME := STD.Str.ToUpperCase ( l.LAST_NAME);
self  := l;
end;

fileinfmt := project( filein, convdatestr(left));

// Bug #DF-23776
// Add Sequence number to the in file
// filter out I7 or Interactive reports																 
// Bug #.DF-23776
// 1.	Exclude any potential result rows where the reason_id is one of these values

EA_natl_keyed_inquiry_set   := ['FA','EA','TM','TF','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                                 'IA','IB','IC','ID','IE','IF','IG','IH','II','IJ','IK','IL','IM','IN','IO','IP','IQ','IR','IS','IT','IU','IV','IW','IX','IY','IZ'];
																 
EA_ds := dataset('~thor_data400::persist::ecrash_ssV2', Layout_eCrash.Consolidation_AgencyOri ,flat);

 accidents0:= EA_ds(report_code in EA_natl_keyed_inquiry_set); 
 
 accidents1 := project(accidents0,transform(recordof(accidents0),self.record_type := trim(regexreplace('\\t|\\n| ',left.record_type,'')),self.cru_jurisdiction_nbr  :=   regexreplace('\\^M',left.cru_jurisdiction_nbr,''),
             self := left));


 accidents := distribute(accidents1,hash(orig_lname,orig_fname,dob)); 
 accidentDedup := dedup(sort(accidents,vin,did,orig_accnbr,accident_date,jurisdiction_state,jurisdiction,cru_order_id, report_type_id,-date_vendor_last_reported,map(report_code in [ 'EA','TF','TM'] => 1,  report_code[1] = 'I' => 2,
																																																									 report_code = 'A' => 2,3),carrier_name,local), vin,did,orig_accnbr,accident_date,jurisdiction_state,jurisdiction,cru_order_id,report_type_id, local); 


 //vin match
vin_match:= dedup(join(accidentDedup, distribute(fileinfmt,hash(LAST_NAME,FIRST_NAME,BIRTH_DT)),
      	trim(left.orig_lname,left,right) = trim(right.LAST_NAME,left,right)  and 
				trim(left.orig_fname,left,right) = trim(right.FIRST_NAME,left,right)  and 
				trim(left.dob,left,right) = trim(right.BIRTH_DT,left,right)  and
				trim(left.accident_date,left,right)  between  ut.getDateOffset ( -30, trim(right.ACCIDENT_DT) ) and  trim( right.DISCHARGE_DT),
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
out := project(vin_match,transform(layoutOut, self.source_id := if (left.acc_dol ='', '', left.source_id), self := left)) ; 

//Add rowid to the output file
//// Bug #.DF-23776										
return sequential(Spray_nahdb_ERI(filedate),
                 count(out(acc_dol <>'')),              
                 output(out,,'~thor_data::out::nahdb_batch_name_'+filedate,
								 csv(heading('STATE|ID|FIRST_NAME|MIDDILE_NAME|LAST_NAME|ADDRESS1|ADDRESS2|CITY|ST|ZIPCODE|BIRTH_DT|ACCIDENT_DT|ADMIT_DT|DISCHARGE_DT|MobilePhone|HomePhone|WorkPhone|acc_vin| order_id	| sequence_nbr|	 reason_id| acct_nbr	| vehicle_incident_id| vehicle_unit_number |	vendor_code| work_type_id|  orig_lname | orig_fname | orig_mname |  vehicle_owner| dob| driver_license_nbr| dlnbr_st| vehicle_year|  vehicle_make|  vehicle_model| tag_nbr| tagnbr_st| report_type_id| loss_type| acc_dol| accident_location|  acc_city|	 vehicle_incident_city| acc_st	| jurisdiction| orig_accnbr|	 accident_nbr| addl_report_number| acc_county| crash_county| cru_jurisdiction_nbr| agency_ori| carrier_name|	  Insurance_policy_num|	    Insurance_policy_Eff_Date|    Insurance_policy_Exp_Date| source_id|	 report_code|	 match_flag|	 date_vendor_last_reported   \n','',SINGLE),
                     separator('|'), terminator('\n')), overwrite, __compressed__, expire(Constants.ThorFile_NAHDB_Days_To_Expire)),
						     STD.File.DeSpray('~thor_data::out::nahdb_batch_name_'+filedate, _control.IPAddress.bctlpedata10, '/data/hds_180/cjr/'+filedate+'/nahdb_out_name_'+filedate+'.csv',,,,true)); 

end; 
