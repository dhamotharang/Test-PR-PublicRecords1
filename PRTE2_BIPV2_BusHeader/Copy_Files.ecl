IMPORT _control, STD, data_services;

EXPORT Copy_Files := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING current_version, string dest_cluster) := FUNCTION

 CopyFiles1(data_services.foreign_prod + 'prte::key::proxid::bipv2_proxid::protected::specificities_debug','~prte::key::proxid::bipv2_proxid::' + current_version + '::specificities_debug',dest_cluster); 

 CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2_lgid3::protected::specificities_debug','~prte::key::bipv2_lgid3::' + current_version + '::specificities_debug',dest_cluster); 

 CopyFiles1(data_services.foreign_prod + 'prte::key::proxid::bipv2_proxid::protected::match_candidates_debug','~prte::key::proxid::bipv2_proxid::' + current_version + '::match_candidates_debug',dest_cluster); 

 CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2_seleid_relative::protected::specificities','~prte::key::bipv2_seleid_relative::' + current_version + '::specificities',dest_cluster); 

 CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2_seleid_relative::protected::match_candidates','~prte::key::bipv2_seleid_relative::' + current_version + '::match_candidates',dest_cluster); 

 CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2::business_header::protected2::contact_title_linkids','~prte::key::bipv2::business_header::' + current_version + '::contact_title_linkids',dest_cluster); 
 
 CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2::crosswalk::permanent::biz2consumer','~prte::key::bipv2::crosswalk::' + current_version + '::biz2consumer',dest_cluster); 
 
 CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2::crosswalk::permanent::consumer2biz','~prte::key::bipv2::crosswalk::' + current_version + '::consumer2biz',dest_cluster); 
 
 CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2::business_header::permanent::segmentation_linkids','~prte::key::bipv2::business_header::' + current_version + '::segmentation_linkids',dest_cluster); 
 
 CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2::protected::high_risk_industries','~prte::key::bipv2::' + current_version + '::high_risk_industries',dest_cluster); 

 CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2::protected::high_risk_industries_phone','~prte::key::bipv2::' + current_version + '::high_risk_industries_phone',dest_cluster); 

 CopyFiles1(data_services.foreign_prod + 'prte::key::bipv2::protected::high_risk_industries_addr','~prte::key::bipv2::' + current_version + '::high_risk_industries_addr',dest_cluster); 
 
                                                                                 
 RETURN 'Success';	
	END;
END;