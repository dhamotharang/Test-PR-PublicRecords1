IMPORT AccountMonitoring;

EXPORT config_UpdateSuperFiles(AccountMonitoring.types.productMask product_mask = 
                                 AccountMonitoring.types.productMask.allProducts,
                                 boolean GetAll = false 
                                ) := function



/* This config file is based on the following layout: 
   
roxie_monitor_superfile_layout := RECORD
  STRING250 RoxieSuperFile;    // Name of the Roxie superfile.  
  STRING250 MonitorSuperFile;  // Name (unique portion of the name - without prefix and suffix) of the new superfile on thor that will contain the same data as the Roxie superfile. 
  UNSIGNED8 product_mask_supported; // The sum of all the product's product-masks that this superfile will be used for. 
end;

       
*/
    
     Superfiles := DATASET([
                    {
      							 AccountMonitoring.product_files.header_files.r_doxie_key_header_superfile,
										 AccountMonitoring.product_files.header_files.r_doxieKeyHeader_for_monitor,
										 AccountMonitoring.types.productMask.phone
										    + AccountMonitoring.types.productMask.address
												+ AccountMonitoring.types.productMask.reverseaddress
                        + AccountMonitoring.types.productMask.personheader 
                    }
									 ,{
                     AccountMonitoring.product_files.header_files.r_quick_header_superfile,
                     AccountMonitoring.product_files.header_files.r_quick_header_for_monitor,
                     AccountMonitoring.types.productMask.phone
										    + AccountMonitoring.types.productMask.address
                    }
									 ,{
                     AccountMonitoring.product_files.header_files.r_daily_utility_superfile,
                     AccountMonitoring.product_files.header_files.r_daily_utility_for_monitor,
                     AccountMonitoring.types.productMask.phone
										    + AccountMonitoring.types.productMask.address
                    }
									,{
                     AccountMonitoring.product_files.header_files.r_doxie_key_rid_did_superfile,
                     AccountMonitoring.product_files.header_files.r_doxieKeyRid_did_for_monitor,
                     AccountMonitoring.types.productMask.didupdate
                    }
									 ,{
                     AccountMonitoring.product_files.header_files.r_doxie_key_rid_did_split_superfile,
                     AccountMonitoring.product_files.header_files.r_doxieKeyRid_did_split_for_monitor,
                     AccountMonitoring.types.productMask.didupdate
                    }
									 ,{
                     AccountMonitoring.product_files.header_files.r_business_header_rcid_superfile,
                     AccountMonitoring.product_files.header_files.r_business_header_rcid_for_monitor,
                     AccountMonitoring.types.productMask.bdidupdate
                    }
									 ,{
                     AccountMonitoring.product_files.header_files.r_bipbest_header_superfile,
                     AccountMonitoring.product_files.header_files.r_bipbest_header_for_monitor,
                     AccountMonitoring.types.productMask.bipbestupdate
                    }
                   ,{
                     'thor_data400::key::sbfe::qa::linkids',
                     'monitor::sbfe::linkids',
                      AccountMonitoring.types.productMask.sbfe 
                    }
                   ,{
                     'thor_data400::key::sbfe::qa::tradeline',
                     'monitor::sbfe::tradeline', 
                      AccountMonitoring.types.productMask.sbfe 
                    }
                   ,{
                     'thor_data400::key::sbfescoring::qa::scoringindex',
                     'monitor::sbfescoring::scoringindex', 
                      AccountMonitoring.types.productMask.sbfe 
                    }
                   ,{
                      AccountMonitoring.product_files.Email.emailLexid_superfile,
                      AccountMonitoring.product_files.Email.emailLexid_for_superkey_monitor,
                      AccountMonitoring.types.productMask.email 
                    }
                   ,{
                      AccountMonitoring.product_files.Email.emailaddr_superfile,
                      AccountMonitoring.product_files.Email.emailaddr_for_superkey_monitor,
                      AccountMonitoring.types.productMask.email 
                    }
                   ,{
                      AccountMonitoring.product_files.Email.emailmain_superfile,
                      AccountMonitoring.product_files.Email.emailmain_for_superkey_monitor,
                      AccountMonitoring.types.productMask.email 
                    },
                    {
                      AccountMonitoring.product_files.Inquiry.inquiryLinkid_Roxie_SuperFile, //(thor_data400::key::inquiry_table::linkids_qa)
                      AccountMonitoring.product_files.Inquiry.inquiryLinkid_superkey_monitor, //(batchr3::monitor::inquiry::linkids_qa)
                      AccountMonitoring.types.productMask.Inquiry 
                    },
                    {
                      AccountMonitoring.product_files.Inquiry.inquiryUpdLinkid_Roxie_SuperFile, //(thor_data400::key::inquiry_table::qa::linkids_update)
                      AccountMonitoring.product_files.Inquiry.inquiryUpdLinkid_superkey_monitor, //(batchr3::monitor::inquiry_table::linkids_qa)
                      AccountMonitoring.types.productMask.Inquiry 
                    },
                    {
                      AccountMonitoring.product_files.phonefeedback.phonefeedback_phone_keyname, //(thor_data400::key::phonesFeedback::qa::phone)
                      AccountMonitoring.product_files.phonefeedback.PhonesFeedback_superkey, //(batchr3::monitor::PhonesFeedback::Phone_qa)
                      AccountMonitoring.types.productMask.phonefeedback
                    }
                    ,{
                      AccountMonitoring.product_files.Phone.phones_type_superfile,
                      AccountMonitoring.product_files.Phone.phones_type_for_superkey_monitor,
                      AccountMonitoring.types.productMask.phone +
                      AccountMonitoring.types.productMask.phoneownership
                    }
                    ,{
                      AccountMonitoring.product_files.Phone.phones_lerg6_superfile,
                      AccountMonitoring.product_files.Phone.Phones_Lerg6_for_superkey_monitor,
                      AccountMonitoring.types.productMask.phone +
                      AccountMonitoring.types.productMask.phoneownership
                    }
                    ,{
                      AccountMonitoring.product_files.Phone.carrier_reference_superfile,
                      AccountMonitoring.product_files.Phone.carrier_reference_for_superkey_monitor,
                      AccountMonitoring.types.productMask.phone +
                      AccountMonitoring.types.productMask.phoneownership
                    },
                    {
                      AccountMonitoring.product_files.PhoneOwnership.phones_transaction_superfile,
                      AccountMonitoring.product_files.PhoneOwnership.phones_transaction_for_superkey_monitor,
                      AccountMonitoring.types.productMask.phoneownership
                    }
                    ,{
                      AccountMonitoring.product_files.Property.Property_search_Roxiesuperfile, //(thor_data400::key::ln_propertyv2::qa::search.fid)
                      AccountMonitoring.product_files.Property.Property_search_keyname_monitor, //(monitor::LN_PropertyV2::Search_fid)
                      AccountMonitoring.types.productMask.property 
                    }
                    ,{
                      AccountMonitoring.product_files.Property.Property_deed_Roxiesuperfile, //(thor_data400::key::ln_propertyv2::qa::addlfaresdeed.fid)
                      AccountMonitoring.product_files.Property.Property_deed_keyname_monitor, //(monitor::LN_PropertyV2::addlfaresdeed.fid)
                      AccountMonitoring.types.productMask.property 
                    }
                    ,{
                      AccountMonitoring.product_files.Property.Property_SearchLinkid_Roxie_superfile, //(thor_data400::key::ln_propertyv2::qa::search.linkids)
                      AccountMonitoring.product_files.Property.Property_SearchLinkid_keyname_monitor, //(monitor::LN_PropertyV2::search.linkids)
                      AccountMonitoring.types.productMask.property 
                    }
				            ],AccountMonitoring.layouts.UPDATE_SOURCE.roxie_monitor_superfile_layout);
                         
                              
   SuperfilesReturn := if(GetAll,Superfiles,Superfiles(AccountMonitoring.types.testPMBits(product_mask_supported, product_mask)));
  return(SuperfilesReturn);
end;
