import iesp,BatchServices,FraudDefenseNetwork_Services,FraudShared_Services,doxie;
 
EXPORT trisv31_get_fdn(dataset(BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_in_wdid) ds_batch_w_did,
                       BatchServices.TaxRefundISv3_BatchService_Interfaces.Input in_args) := function

ds_excl_ind := dataset([],iesp.frauddefensenetwork.t_FDNIndType);
ds_rec_file := dataset([],iesp.frauddefensenetwork.t_FDNFileType);
fdn_const := BatchServices.Constants.TRISv31_FDN;
   	
   	
FraudShared_Services.Layouts.batch_search_rec xfdnForm(ds_batch_w_did l) := transform
   	
   	self.seq := (UNSIGNED)l.acctno;
   	self.did	:= l.did;
   	self := [];
end;
   	
ds_did_fdn := project(ds_batch_w_did,xfdnForm(left));

ds_res_fdn:= FraudDefenseNetwork_Services.Search_Records(ds_did_fdn,in_args.GlobalCompanyId,in_args.IndustryType,in_args.ProductCode,ds_excl_ind,ds_rec_file);
		
// classification value filter and contributory data filter
ds_fdn_filter := ds_res_fdn((StringLib.StringToUpperCase(ds_res_fdn.classification_source.source_type) NOT IN fdn_const.classification_source_sourc_type AND 
         		            StringLib.StringToUpperCase(ds_res_fdn.classification_Activity.Confidence_that_activity_was_deceitful)NOT IN fdn_const.classification_activity_confidence AND
         								StringLib.StringToUpperCase(ds_res_fdn.classification_Activity.Threat)NOT IN fdn_const.classification_activity_Threat  AND
         								StringLib.StringToUpperCase(ds_res_fdn.classification_Entity.role) NOT IN fdn_const.classification_entity_role AND
         								StringLib.StringToUpperCase(ds_res_fdn.classification_Entity.Evidence)NOT IN fdn_const.classification_entity_Evidence) 
   											AND(doxie.DataPermission.use_FDNContributoryData OR   
									        classification_Permissible_use_access.file_type <> 
													                     FraudShared_Services.Constants.FileTypeCodes.CONTRIBUTORY));
												 
																		 
return ds_fdn_filter;											 
end;