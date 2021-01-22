EXPORT Key_ecrashV2_PhotoId := INDEX(mod_PrepEcrashKeys().ds_PhotoSuperCmbnd,
                                     {Super_Report_Id, Document_id, Report_Type},
							                       {mod_PrepEcrashKeys().ds_PhotoSuperCmbnd},
							                       Files_eCrash.FILE_KEY_PHOTO_ID_SF);
																		
																		