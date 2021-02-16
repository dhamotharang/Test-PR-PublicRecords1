import Address,ut,_control; 

EXPORT NAHDB_Batch_Run(string8 filedate/*, string customerName*/) := function 

filein := dataset('~thor_data::in::nahdb', FLAccidents_Ecrash.Layout_Infiles.layoutNahdbBatch, csv(heading(1),terminator('\n'), separator(','),quote('"')));	

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

fileClean := project(filein , transform(FLAccidents_Ecrash.Layout_Infiles.layout_temp,
                 
			clean_name := Address.CleanPersonFML73(trim(left.FIRST_NAME,left,right)+' '+ trim(left.MIDDLE_INITIAL,left,right)+' '+ trim(left.LAST_NAME,left,right)); 
			self.title							:= clean_name[1..5];
			self.fname							:= clean_name[6..25];
			self.mname							:= clean_name[26..45];
			self.lname							:= clean_name[46..65];
			self.suffix 					  := clean_name[66..70];
			self.clean_dob:= fSlashedMDYtoCYMD(left.DOB); 
			self.clean_DATE_OF_INCIDENT := fSlashedMDYtoCYMD(left.DATE_OF_INCIDENT) ; 
			self.vin := stringlib.StringFilter(left.vin,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); 
      self.city := StringLib.StringToUpperCase(left.city); 
			self.state := StringLib.StringToUpperCase(left.state); 
			self:= left;
      self :=[];
     ));


 nodid := project(fileClean((unsigned)adl =0),transform(FLAccidents_Ecrash.Layout_Infiles.layout_temp,self :=left,self :=[]));

 // filter out I7 or Interactive reports 

 EA_natl_keyed_inquiry_set   := ['FA','EA','TM','TF','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
                                 'IA','IB','IC','ID','IE','IF','IG','IH','II','IJ','IK','IL','IM','IN','IO','IP','IQ','IR','IS','IT','IU','IV','IW','IX','IY','IZ'];

 accidents0:= Files_eCrash.Ds_Base_Consolidation_Ecrash(report_code in EA_natl_keyed_inquiry_set); 

 accidents := distribute(accidents0,hash((unsigned)did)); 
 accidentDedup := dedup(sort(accidents,did,vin,accident_date,jurisdiction_state,-date_vendor_last_reported,map(report_code in [ 'EA','TF','TM'] => 1,  report_code[1] = 'I' => 2,
																																																									 report_code = 'A' => 2,3),carrier_name,local), did,vin,accident_date,jurisdiction_state,local); 
ADLmatch:= join(distribute(accidentDedup((unsigned)did <>0),hash((unsigned)did)), distribute(fileClean((unsigned)adl <>0),hash((unsigned)adl)),
              (unsigned) left.did =  (unsigned)right.adl and 
				       ut.daysapart(right.clean_DATE_OF_INCIDENT,left.accident_date)<=90 ,
			         transform(FLAccidents_Ecrash.Layout_Infiles.layout_temp,
				             
				             self.acc_dol := left.accident_date ; 
				             self.acc_city := left.vehicle_incident_city; 
				             self.acc_st := left.vehicle_incident_st; 
				             self.acc_county := left.crash_county; 
					           self.acc_vin := left.vin; 
	                   self.person_type := left.record_type ; 
	                   self.order_id:= left.cru_order_id ; 
	                   self.sequence_nbr :=left.cru_sequence_nbr;;
	                   self.acct_nbr := left.acct_nbr;
	                   self.vehicle_incident_id := left.vehicle_incident_id; 
	                   self.carrier_name := left.carrier_name; 
                     self.source_id := if(left.report_code in ['EA','FA','TM','TF'],left.report_code,
															                           if(left.report_code[1] ='I' ,'NatInq','NatAcc')); 
	                   self.orig_accnbr := left.orig_accnbr; 
	                   self.report_code := left.report_code ; 
										 self.date_vendor_last_reported:= left. date_vendor_last_reported;
										 self.match_flag := if(self.acc_dol <>'' , 'D', ''); 
										 self := right ; 
				                 ),right outer,local)+nodid; 

 // name 
 
 Namematch := dedup(join(distribute(accidentDedup(fname <>'' and lname <>''),hash(fname,lname)),distribute(ADLmatch(acc_dol =''),hash(fname,lname)), 

                                 trim(left.fname,left,right) = trim(right.fname,left,right) and 
				                         trim(left.lname ,left,right)= trim(right.lname,left,right) and 
				                         ut.NNEQ(left.mname,right.mname) and 
				                         trim(right.clean_dob,left,right)= trim(left.dob,left,right )and 
				                         ut.daysapart(right.clean_DATE_OF_INCIDENT,left.accident_date)<=90 and 				
			                           (trim(left.v_city_name ,left,right)= trim(right.CITY,left,right) or 
				                          trim(left.st,left,right) = trim(right.State,left,right))  ,
				
					transform(FLAccidents_Ecrash.Layout_Infiles.layout_temp, 
				   
				             self.acc_dol := left.accident_date ; 
				             self.acc_city := left.vehicle_incident_city; 
				             self.acc_st := left.vehicle_incident_st; 
				             self.acc_county := left.crash_county; 
					           self.acc_vin := left.vin; 
	                   self.person_type := left.record_type ; 
	                   self.order_id:= left.cru_order_id ; 
	                   self.sequence_nbr :=left.cru_sequence_nbr;;
	                   self.acct_nbr := left.acct_nbr;
	                   self.vehicle_incident_id := left.vehicle_incident_id; 
	                   self.carrier_name := left.carrier_name; 
                     self.source_id := if(left.report_code in ['EA','FA','TM','TF'],left.report_code,
															                           if(left.report_code[1] ='I' ,'NatInq','NatAcc')); 
	                   self.orig_accnbr := left.orig_accnbr; 
	                   self.report_code := left.report_code ; 
										 self.date_vendor_last_reported:= left. date_vendor_last_reported;
										 self.match_flag := if(self.acc_dol <>'' , 'N', right.match_flag); 
 
					           self := right ; 
				       ),right outer,local )+ADLmatch(acc_dol <>''),all,local);

//vin match 

VINmatch:= dedup(join(distribute(accidentDedup(vin <>''),hash(vin)), distribute(Namematch(vin <> '' and acc_dol =''),hash(vin)),
                
				trim(left.vin,left,right) = trim(right.vin,left,right) and 
				ut.daysapart(right.clean_date_of_incident,left.accident_date) <=90 ,
				transform(FLAccidents_Ecrash.Layout_Infiles.layout_temp, 
				  
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
	         self.match_flag := if(self.acc_dol <>'' ,'E',right.match_flag); 
	         self.person_type := ''; 
					 self := right ;
				   ), right outer,local)+Namematch(~(vin <> '' and acc_dol ='')),all) :persist('output_test');


// remove multiple vin records caused due to VIN lookup from batch

out := project(dedup(VINmatch(match_flag <> 'E'), except vin, all) + VINmatch(match_flag ='E'),transform(FLAccidents_Ecrash.Layout_Infiles.layout_out, self.source_id := if (left.acc_dol ='', '', left.source_id), self := left)); 
													
return sequential(FLAccidents_Ecrash.Spray_nahdb(filedate), output(out,,'~thor_data::out::nahdb_batch_'+filedate,csv(
                 HEADING('EVENT_ID|DATE_OF_INCIDENT|FIRST_NAME|MIDDLE_INITIAL|LAST_NAME|ADDRESS1|ADDRESS2|CITY|STATE|ZIP|DOB|SSN|ADL|VIN|acc_dol|acc_city|acc_st|acc_county|acc_vin|order_id|sequence_nbr|acct_nbr|vehicle_incident_id|carrier_name|source_id|orig_accnbr|report_code|person_type|match_flag|date_vendor_last_reported\n','',SINGLE),
                 SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE), 
						     fileservices.despray('~thor_data::out::nahdb_batch_'+filedate, _control.IPAddress.edata12, '/hds_180/cjr/nahdb_out_'+filedate+'.csv',,,,TRUE)); 

end; 
