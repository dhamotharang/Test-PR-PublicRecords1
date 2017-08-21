IMPORT LN_PropertyV2_Fast;
EXPORT fn_Audit_Input_archive := sequential(

					FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_reporting_fname
																		 ,LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_fname
																		 ,
																		 ,true
					 )
					,fileservices.clearsuperfile(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_frs_fname)
					,fileservices.clearsuperfile(LN_PropertyV2_Fast.Files_Vendor_Rpts.taxreport_bk_fname)
					,fileservices.clearsuperfile(LN_PropertyV2_Fast.Files_Vendor_Rpts.deedreport_frs_fname)
					,fileservices.clearsuperfile(LN_PropertyV2_Fast.Files_Vendor_Rpts.deedreport_bk_fname)
					,FileServices.FinishSuperFileTransaction()
);
