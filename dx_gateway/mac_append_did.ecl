// -------------------------------------------------------------------------
// This macro is called by the parser and it is part of the interface between 
// thor and roxie.
// -------------------------------------------------------------------------
export mac_append_did(ds_in, ds_out, mod_access, append_did_local = TRUE,matchset = ['']) := MACRO  
// Option to append DID remotely is here just for convenience to faciliate testing on 1-ways.  
// It triggers a remote call to DidVille.Did_Batch_Service_Raw to resolve LexID.   
// By default, all queries will be deployed with LOCAL option.  
// For testing with remote option, set dx_gateway.Constants.DID_APPEND_LOCAL=FALSE    
#uniquename(layout_append_did)  
%layout_append_did% := RECORD(dx_gateway.Layouts.common_optout)   
                       unsigned seq_orig;  
											 END;  
#uniquename(ds_in_seq)  
%ds_in_seq% := project(ds_in, TRANSFORM(%layout_append_did%, self.seq_orig := left.seq; self.seq := COUNTER; self := left));  
#uniquename(ds_in_nodids)  
%ds_in_nodids% := %ds_in_seq%(did = 0);   
#IF(append_did_local)   
 import did_add, AutoKeyI;     
 #uniquename(ds_in_append_local)    
 did_add.MAC_Match_Flex(%ds_in_nodids%                                      // export MAC_Match_Flex(infile, 
                        ,matchset                                           // matchset,    //see above
                        ,ssn,dob,fname,mname,lname,suffix                   // ssn_field, dob_field, fname_field, mname_field,lname_field, suffix_field, 
                        ,prim_range,prim_name,sec_range,zip4,st,phone10     // prange_field, pname_field, srange_field,zip_field, state_field, phone_field,
                        ,did                                                // DID_field,  //these will be set to zero before the linking                                            
                        ,%layout_append_did%                                // outrec, 
                        ,false,fake_DID_Score_field                         // bool_outrec_has_score, DID_Score_field,              //these should default to zero in definition
                        ,dx_gateway.Constants.DID_SCORE_THRESHOLD                    // low_score_threshold,    //dids with a score below here will be dropped 
                        ,%ds_in_append_local% );                            // outfile,
                        // ,true,src)                                       // bool_infile_has_name_source = 'false', src_field = '',
                                                                            // bool_all_scores ='false',  // will pass through even records with a 100 score// on to further match macros, to get further scores
                                                                            // bool_outrec_has_indiv_scores='false',score_a_field='score_a',score_d_field='score_d',
                                                                            // score_s_field='score_s',score_p_field='score_p', score_f_field='score_f', score_n_field = 'score_n',// appends individual match scores
                                                                            // bool_clean_addr = 'false', // re-cleans addresses before trying match. 
                                                                            // predir_field = 'predir',addr_suffix_field = 'addr_suffix',postdir_field = 'postdir',
                                                                            // udesig_field = 'unit_desig',city_field = 'p_city_name', zip4_field = 'zip4', weight_threshold=30, distance=3, segmentation=true)      
                                                                                                   
  
 ds_out := join(%ds_in_seq%, %ds_in_append_local%,       
               left.seq = right.seq ,    
							 TRANSFORM(dx_gateway.Layouts.common_optout,         self.seq := left.seq_orig;        
							                                                     self.did := if(right.did > 0, right.did, left.did);        
																																	 self.error_code := if(right.did > 0,
																																	 left.error_code, AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT),         
																																	 self := left),       LEFT OUTER, KEEP(1), LIMIT(0));  
#ELSE    import dx_gateway,batchshare,gateway;    
 #uniquename(didville_params)		
 %didville_params% := MODULE(PROJECT(BatchShare.IParam.getBatchParams(),Gateway.IParam.DidVilleParams,OPT))			
 EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();			
 EXPORT UNSIGNED3 DidScoreThreshold := 80;		END;   
 #uniquename(ds_in_remote)   
 %ds_in_remote% := project(%ds_in_nodids%, transform(dx_gateway.Layouts.common_did_append_remote,      
                                                     self.acctno := (string) left.seq;      
																										 self.orig_acctno := (string) left.seq;      
																										 self.name_first := left.fname;      
																										 self.name_middle := left.mname;     
																										 self.name_last := left.lname;      
																										 self.name_suffix := left.suffix;      
																										 self := left));   
 #uniquename(ds_out_remote)      
 BatchShare.MAC_AppendDidVilleDID(%ds_in_remote%, %ds_out_remote%, %didville_params%, dx_gateway.Constants.DID_SCORE_THRESHOLD);    
 ds_out := join(%ds_in_seq%, %ds_out_remote%,       left.seq = (unsigned) right.acctno,      
               transform(dx_gateway.Layouts.common_optout, self.seq := left.seq_orig;        
							                                             self.did := if(right.did > 0, right.did, left.did);        
																													 self.error_code := if(right.did > 0, 
																													 seft.error_code, AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT),         
																													 self := left),       
																													 LEFT OUTER, KEEP(1), LIMIT(0));  
#END
ENDMACRO;

