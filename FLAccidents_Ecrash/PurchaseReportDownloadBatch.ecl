import ut; 
export PurchaseReportDownloadBatch := function
rec := record 
string report_download_id   ;                    
string updates_download_id    ;                 
string company_id         ;                      
string user_id           ;                           
string transaction_id   ;                            
string expiration_date  ;                                                                                   
string reference_number  ;                                                                                     
string search_first_name ;                  
string search_last_name  ;                    
string date_of_loss     ;                   
string location_1       ;                      
string location_2      ;                      
string  jurisdiction_state    ;                  
string jurisdiction      ;                        
string report_number    ;                         
string md5_hash       ;                          
string ecrash_permissible_purpose_id   ;        
string agency_id             ;                 
string has_cover_sheet     ;                    
string date_added         ;                         
string user_added        ;                        
string date_changed      ;                            
string user_changed    ;
string 	incident_id	,
string sent_to_hpcc_datetime	,
 string creation_date, 
 string 	source_id,
 string 	work_type_id
 end; 
ds := dataset('~thor_data400::ecrash::reportdownload_20140723',rec,csv(terminator(['\n','\r\n']),separator(','),quote('"')));

ds_d := project (ds,transform( {rec, string accident_date, string super_report_id:='' }, self.accident_date := stringlib.stringfilterout(trim(Left.date_of_loss,left,right),'-'),
                          self:= left)); 
													
ds_EA_TF  := ds_d (md5_hash <>'');
ds_TM     := ds_d (md5_hash ='');

eCrashBase := FLAccidents_Ecrash.BaseFile(is_Terminated_Agency = FALSE);

base  := dedup(distribute(eCrashBase (work_type_id not in ['2','3'] and trim(hash_key,left,right) <>''), hash32(hash_key)),   hash_key,loss_state_abbr,agency_name,all ,local):persist('test_ddedup') ; 

j_EA_1_0_TF := dedup(join ( base,ds_EA_TF ,  left.hash_key =right.md5_hash and left.loss_state_abbr =right.jurisdiction_state and
                                             stringlib.stringtouppercase(trim(left.agency_name,left,right)) = trim(right.jurisdiction,left,right),

                        transform({rec, string super_report_id }, 
												self.super_report_id := left.super_report_id , 
												self:= right), right outer ),all):persist('test_hash_key'); 
											
TM_no_hash := ds_TM(trim(agency_id,left,right) <> '1603437' ); 

BaseFile1 := dedup(eCrashBase (source_id ='TM'), state_report_number,agency_id,loss_state_abbr, all); 

GetTM := dedup(join (BaseFile1, TM_no_hash, left.state_report_number = right.report_number and 
                                     left.agency_id =right.agency_id and 
																		 left.loss_state_abbr =right.jurisdiction_state and 
																		 left.crash_date = right.accident_date ,
												transform({rec, string super_report_id }, 
												self.super_report_id := left.super_report_id , 
												self:= right), right outer ),all);

TM_Nassau := ds_TM(trim(agency_id,left,right) = '1603437' ); 

BaseFileD := dedup(eCrashBase (trim(agency_id,left,right) = '1603437' and work_type_id ='0' and source_id ='EA'), state_report_number,agency_id,loss_state_abbr, crash_date, all); 

GetTM_Nassau := dedup(join(BaseFileD, TM_Nassau,left.state_report_number = right.report_number and 
                                     left.agency_id =right.agency_id and 
																		 left.loss_state_abbr =right.jurisdiction_state and 
																		 left.crash_date = right.accident_date ,
												transform({rec, string super_report_id }, 
												self.super_report_id := left.super_report_id , self:= right), right outer ),all);



total := project(j_EA_1_0_TF + GetTM + GetTM_Nassau,{rec, string super_report_id }) ; 

total1 := total(super_report_id = ''); 

base_supp  := dedup(distribute(FLAccidents_Ecrash.Files.Base.supplemental (work_type_id not in ['2','3'] and trim(hash_key,left,right) <>''), hash32(hash_key)),   hash_key,jurisdiction_state,jurisdiction,all ,local) ; 


j := dedup(join(base_supp,total1, trim(left.hash_key,left,right) = trim(right.md5_hash,left,right) and 
                          trim( left.agency_id,left,right) = trim(right.agency_id,left,right) and 
													 trim(left.jurisdiction_state,left,right) = trim(right.jurisdiction_state,left,right),
													 transform({rec, string super_report_id }, 
												self.super_report_id := left.super_report_id , self:= right), right outer ),all);
													 
													 
fullfile := j+total(super_report_id <> '');

// TM nassau old 

BaseFileD_old := dedup(FLAccidents_Ecrash.Files.Base.supplemental (trim(agency_id,left,right) = '1603437' and work_type_id ='0' and source_id ='EA'), addl_report_number,agency_id,jurisdiction_state, accident_date, all); 

GetTM_Nassau_old := dedup(join(BaseFileD_old, fullfile (super_report_id ='' and agency_id = '1603437'),left.addl_report_number = right.report_number and 
                                     left.agency_id =right.agency_id and 
																		 left.jurisdiction_state =right.jurisdiction_state and 
																		 left.accident_date = stringlib.stringfilterout(trim(right.date_of_loss,left,right),'-') ,
												transform({rec, string super_report_id }, 
												self.super_report_id := left.super_report_id , self:= right), right outer ),all);


final := GetTM_Nassau_old + fullfile(~(super_report_id ='' and agency_id = '1603437')); 


// final Out 

final_TM := final(md5_hash ='' and super_report_id =''); 

BaseFileD_TM:= dedup(FLAccidents_Ecrash.Files.Base.supplemental (report_code ='TM'), ORIG_ACCNBR,agency_id,jurisdiction_state, accident_date, all); 


J_Tm:= DEDUP(join( BaseFileD_TM , final(md5_hash ='' and super_report_id =''),
left.ORIG_ACCNBR = right.report_number and 
                                     left.agency_id =right.agency_id and 
																		 left.jurisdiction_state =right.jurisdiction_state and 
																		 left.accident_date = stringlib.stringfilterout(trim(right.date_of_loss,left,right),'-') ,
												transform({rec, string super_report_id }, 
												self.super_report_id := left.super_report_id , self:= right), right outer ),all);

GOOD := J_Tm + final(~(md5_hash ='' and super_report_id =''));

patch_TM := Good(trim(md5_hash,left,right) ='' and trim(super_report_id ,left,right)='') ; 

BaseFileD_TM0:= dedup(FLAccidents_Ecrash.Files.Base.supplemental (report_code in ['TM', 'TF']), ORIG_ACCNBR,agency_id,jurisdiction_state, accident_date, all); 


patch_TM_join := dedup(join (  BaseFileD_TM0, patch_TM, 

   left.ORIG_ACCNBR = right.report_number and 
                                     left.agency_id =right.agency_id and 
																		 left.jurisdiction_state =right.jurisdiction_state ,
																		 //left.accident_date = stringlib.stringfilterout(trim(right.date_of_loss,left,right),'-') ,
												transform({rec, string super_report_id }, 
												self.super_report_id := left.super_report_id , self:= right), right outer ),all)+ Good(~(trim(md5_hash,left,right) ='' and trim(super_report_id ,left,right)='')) ;

jout := join (patch_TM_join(trim(super_report_id,left,right) ='') , dedup(FLAccidents_Ecrash.Files.Base.supplemental, incident_id,all), 
                 trim(left.incident_id,left,right) = trim(right.incident_id,left,right) , 
								 transform({patch_TM_join},
						 self.super_report_id := right.super_report_id  ,
						 self := left), left outer) + patch_TM_join(trim(super_report_id,left,right) <>'');
						 

return sequential(
    count(jout), 
		count(jout( super_report_id = '')),
		output(jout( super_report_id = ''),all),
				
 output(dedup(jout,record,all),,'~thor_data400::out::ecrash::'+ut.GetDate+'::report_download_batch'
												,csv(terminator(['\n','\r\n'])
												,separator(','),quote('"'))
												,overwrite) ,
fileservices.Despray('~thor_data400::out::ecrash::'+ut.GetDate+'::report_download_batch'
												, Constants.LandingZone
												, '/data/super_credit/ecrash/despray/report_dwld/report_download_batch_out_'+ut.GetDate+'.csv')	);											

		end; 
												