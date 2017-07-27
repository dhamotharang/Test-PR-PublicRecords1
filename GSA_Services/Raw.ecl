import iesp,gsa,gsa_services,ut,AutoStandardI,Autokey_batch,BatchServices.Functions;

export Raw := module
//**********************************************************************************************//
//																			Layouts																									//
//**********************************************************************************************//
export layout_slim := GSA_Services.Layouts.gsa_slim;
export layout_output := GSA_Services.Layouts.primary_record;
export layout_w_penalty := Layouts.plus_penalty_primary_record;
Shared maxVal 			:= ut.limits.Max_GSA_Results;
gsa_ids 		:= GSA.Key_GSA_gsa_id; 
layout_in_ids := GSA_Services.Layouts.autokey_fetch_gsa_id;

//**********************************************************************************************//
//															Fetch payload for Document id's		(gsa_ids)											//
//**********************************************************************************************//
	export joinByGSAId(dataset(layout_in_ids) in_ids) := function
				
				outrec := join(in_ids,gsa_ids,
											 keyed(left.gsa_id=right.gsa_id),
											 transform(layout_slim,
											 self.acctno := left.acctno,
											 self.search_status := left.search_status,
											 self.matchCode := left.matchCode;
											 self := right),
											 keep(maxVal),limit(0)); 
				return outrec;
	end;
//**********************************************************************************************//
//																			Apply Date Restriction																	//
//**********************************************************************************************//
 export filterByDate(dataset(layout_slim) in_ds, string8 RestrictionStartDate, string8 RestrictionEndDate) := function
   
     // if ehter column is blank - keep the record
		 filt_recs := map(RestrictionStartDate != '' and RestrictionEndDate != '' 
		                                             => in_ds((TermDate >= RestrictionStartDate or (unsigned)TermDate=0 or termdateindefinite!='' or termdatepermanent!='') 
																				                   and (ActionDate <= RestrictionEndDate or (unsigned)ActionDate = 0)),
		                  RestrictionStartDate != '' => in_ds(TermDate >= RestrictionStartDate or (unsigned)TermDate=0 or termdateindefinite!='' or termdatepermanent!=''),
                      RestrictionEndDate != ''   => in_ds(ActionDate <= RestrictionEndDate or (unsigned)ActionDate = 0), 
											                              in_ds);
		 return filt_recs;
 end;
//**********************************************************************************************//
//																			Apply Address penality																	//
//**********************************************************************************************//
	penalt_addr( Layouts.gsa_rec_inBatchMaster l, GSA_Services.Layouts.address r) := function

          addr := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))
					
						// The 'input' address:
							// EXPORT addr         		:= '';//Removed to allow for not penalty as it will be evaluated and filtered later
							EXPORT predir         	:= l.predir;
							EXPORT prim_name      	:= l.prim_name;
							EXPORT prim_range     		:= l.prim_range;
							EXPORT postdir        	:= l.postdir;
							EXPORT addr_suffix    		:= l.addr_suffix;
							EXPORT sec_range      	:= l.sec_range;
							EXPORT p_city_name    		:= l.p_city_name;
							EXPORT st             	:= l.st;
							EXPORT z5             	:= l.z5;	
						
							// The address in the matching record:						
							EXPORT allow_wildcard  	:= FALSE;					
							EXPORT city_field      	:= r.v_city_name;
							EXPORT city2_field     	:= '';
							EXPORT pname_field     	:= r.prim_name;
							EXPORT postdir_field   	:= r.postdir;
							EXPORT prange_field    	:= r.prim_range;
							EXPORT predir_field    	:= r.predir;
							EXPORT state_field     	:= r.st;
							EXPORT suffix_field    	:= r.addr_suffix;
							EXPORT zip_field       	:= r.zip5;						
							EXPORT sec_range_field 		:= r.sec_range;
							EXPORT useGlobalScope  	:= FALSE;
						END;
						return AutoStandardI.LIBCALL_PenaltyI_Addr.val(addr);
				end;

		
//**********************************************************************************************//
//																			Apply company name penality															//
//**********************************************************************************************//
	penaltyBizName(Layouts.gsa_rec_inBatchMaster l, GSA_Services.Layouts.basic r) := FUNCTION
			cname :=	MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
								EXPORT companyname 			:= l.comp_name;									
								EXPORT cname_field 			:= r.companyname;		
								EXPORT allow_wildcard 	:= FALSE;
						END;
			return AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(cname);
		END;

//**********************************************************************************************//
//																			Apply name penality																			//
//**********************************************************************************************//
	penaltyName(Layouts.gsa_rec_inBatchMaster l, GSA_Services.Layouts.basic r) := FUNCTION
		name :=	MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))	
								EXPORT lastname       	:= l.name_last;      
								EXPORT middlename     		:= l.name_middle;     
								EXPORT firstname      	:= l.name_first;      
								EXPORT allow_wildcard 		:= FALSE;
								EXPORT lname_field    := r.lname;						                          
								EXPORT mname_field    := r.mname; 
								EXPORT fname_field    := r.fname; 
						END;
			RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(name);
		END;
		
//**********************************************************************************************//
//	Create the datasets for primary, addresses ,references and actions
//	Apply penalty
//  Denormalize to create child datasets for addresses, references and actions with Primary/Parent 												
//**********************************************************************************************//		
		export layout_output getPrimaryRecords(dataset(layout_slim) ds_in, dataset(Layouts.gsa_rec_inBatchMaster) ds_batch_in) := function

				ds_primary := dedup(sort(ds_in(primary_aka_name = GSA_Services.Constants.RECORD_TYPE_PRIMARY),acctno,gsa_id,title,fname,mname,lname,name_suffix,name),
													acctno,gsa_id,title,fname,mname,lname,name_suffix,name);
													
				//Added boolean to check to see if the data in each row has an address that matches the 
				//cln input or if the data coming back is empty to just allow it. If input address is empty
				BOOLEAN validRec(layout_slim l,Layouts.gsa_rec_inBatchMaster r) := FUNCTION
					emptyRec := trim(l.prim_name,all) = '' or r.cln_prim_name=''; 
					matchPrimName := trim(l.prim_name,all) = trim(r.cln_prim_name,all);
					matchPrimRange := trim(l.prim_range,all) = trim(r.cln_prim_range,all);
					matchSecRange := trim(l.sec_range,all) = trim(r.cln_sec_range,all);
					return emptyRec or matchPrimName and matchPrimRange and matchSecRange;
				end;	
				
				// Create a dataset with the same subset of records as before and then filter them based on 
				// address existing and matching the cln input fields if an input address was supplied and the
				// gsa data actually has address data to compare too.
				ds_addresses := ds_in(primary_aka_name= GSA_Services.Constants.RECORD_TYPE_PRIMARY);
				ds_filtered_addresses := join(ds_addresses,ds_batch_in,left.acctno = right.acctno,
														transform(layout_slim,
														self.acctno := if(validRec(left,right),left.acctno,skip),
														SELF:=LEFT),keep(maxVal),limit(0));
														
				ds_caddresses := project(dedup(sort(ds_filtered_addresses,acctno,gsa_id,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,st,zip5,zip4),
													acctno,gsa_id,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,st,zip5,zip4),GSA_Services.Layouts.address);
				
				plus_penalty_addr := join(ds_caddresses, ds_batch_in,
														left.acctno = right.acctno,
														transform(gsa_services.Layouts.address_plus_penality,
														self.penalt := penalt_addr(right,left),self:=left),keep(maxVal),limit(0));
				
				ds_cactions := project(dedup(sort(ds_in(primary_aka_name = GSA_Services.Constants.RECORD_TYPE_PRIMARY),acctno,gsa_id,ctcode,agencycomponent,actiondate),
													acctno,gsa_id,ctcode,agencycomponent,actiondate),GSA_Services.Layouts.action);
				
				// some reference records are for individuals and since in new index built individual's name is moved to lname,fname,mname columns, the column name is empty for them, we need to attaend to it.  
				ds_creferences__ := dedup(sort( ds_in(primary_aka_name != GSA_Services.Constants.RECORD_TYPE_PRIMARY),
				                               acctno,gsa_id,name,fname,mname,lname,name_suffix),
																	acctno,gsa_id,name,fname,mname,lname,name_suffix);
				
				// Instead of showing blank name in references for individuals we need to pull subject's name into name column as is shown in references ex. (appendixB) of orig.product requirements.
				ds_creferences := project(sort(ds_creferences__,acctno,gsa_id,if(name='',1,0)),
																		 transform(GSA_Services.Layouts.reference,
																		          self.name:=if(left.name='',stringlib.StringCleanSpaces(left.FName+' '+left.MName+' '+left.LName+' '+left.name_suffix),left.name), 
																							self:=left)
																		)(name!='');

				ds_parent := project(ds_primary,transform(GSA_Services.Layouts.basic,self.CompanyName := if(stringlib.StringToUpperCase(left.classification) <> GSA_Services.Constants.RECORD_TYPE_INDIVIDUAL or (left.LName='' and left.fName=''/*individual name wasn't recognized as a person*/),left.name,''),self:=left));
				
				plus_penalty_parent := join(ds_parent, ds_batch_in,
														left.acctno = right.acctno,
														transform(gsa_services.Layouts.basic_plus_penality,
														self.penalt := penaltyBizName(right,left)+penaltyName(right,left),
														self:=left),keep(maxVal),limit(0));
				

				// Street Address removed from user input due to matching problems
				// filter results by input / cleaned address must be re applied as a filter

				//TODO: we have a penalty for each record in plus_penalty_parent and we need to apply a filter 
				// for each row whereby it an address exists and it does not match the input criteria we remove
				// that record. If ds_batch_in has cln address information then filter result that also have addresses

				//pc = parent child recordset
				ds_pc := GSA_Services.Transforms.denormalizeRecs(plus_penalty_parent,plus_penalty_addr,ds_cactions,ds_creferences);
				
				return ds_pc;
	end;

end;