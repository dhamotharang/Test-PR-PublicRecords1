import Marketing_Best,_control;

export Mac_Spray_Marketing_Best_Equifax(source_ip, prefix, file_date, version_date, group_name='\'thor400_84\'') := Macro

#uniquename(spray_ip)
#uniquename(spray_files)
#uniquename(recordsize)  
#uniquename(super_equifax)
#uniquename(clear_superfile)

#workunit('name','Marketing Best Equifax Spray ');

%spray_ip% := map (	source_ip = 'edata10' => _control.IPAddress.edata10,
										source_ip = 'edata12' => _control.IPAddress.edata12,
										source_ip = 'edata14' => _control.IPAddress.edata14a,
										source_ip
									);
									
%recordsize% := 503;

%spray_files% := parallel(
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_AK.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_AK_'+file_date ,-1,,,true,true),  
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_AL.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_AL_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_AR.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_AR_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_AZ.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_AZ_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_CA.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_CA_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_CO.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_CO_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_CT.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_CT_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_DC.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_DC_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_DE.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_DE_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_FL.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_FL_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_GA.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_GA_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_HI.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_HI_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_IA.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_IA_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_ID.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_ID_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_IL.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_IL_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_IN.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_IN_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_KS.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_KS_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_KY.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_KY_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_LA.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_LA_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_MA.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_MA_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_MD.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_MD_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_ME.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_ME_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_MI.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_MI_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_MN.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_MN_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_MO.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_MO_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_MS.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_MS_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_MT.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_MT_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_NC.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_NC_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_ND.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_ND_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_NE.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_NE_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_NH.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_NH_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_NJ.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_NJ_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_NM.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_NM_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_NV.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_NV_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_NY.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_NY_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_OH.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_OH_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_OK.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_OK_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_OR.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_OR_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_PA.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_PA_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_RI.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_RI_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_SC.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_SC_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_SD.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_SD_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_TN.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_TN_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_TX.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_TX_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_UT.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_UT_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_VA.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_VA_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_VT.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_VT_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_WA.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_WA_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_WI.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_WI_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_WV.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_WV_'+file_date ,-1,,,true,true),
													FileServices.SprayFixed(%spray_ip%,'/ucc_new_build2/eq_total_source/in/' + file_date + '/' + prefix + '_WY.txt', %recordsize%, group_name, '~thor_data400::in::Marketing_Best_Equifax_WY_'+file_date ,-1,,,true,true)
													);
													
%clear_superfile% := fileservices.clearsuperfile('~thor_data400::in::Marketing_Best_Equifax',true);

%super_equifax% := sequential(
															fileservices.startsuperfiletransaction(),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_AK_'+file_date),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_AL_'+file_date),  
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_AR_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_AZ_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_CA_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_CO_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_CT_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_DC_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_DE_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_FL_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_GA_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_HI_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_IA_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_ID_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_IL_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_IN_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_KS_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_KY_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_LA_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_MA_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_MD_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_ME_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_MI_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_MN_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_MO_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_MS_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_MT_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_NC_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_ND_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_NE_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_NH_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_NJ_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_NM_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_NV_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_NY_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_OH_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_OK_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_OR_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_PA_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_RI_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_SC_'+file_date),   
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_SD_'+file_date),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_TN_'+file_date),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_TX_'+file_date),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_UT_'+file_date),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_VA_'+file_date),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_VT_'+file_date),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_WA_'+file_date),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_WI_'+file_date),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_WV_'+file_date),
															fileservices.addsuperfile('~thor_data400::in::Marketing_Best_Equifax',  '~thor_data400::in::Marketing_Best_Equifax_WY_'+file_date),
															fileservices.finishsuperfiletransaction()
															); 
			
sequential(%spray_files%,
					 %clear_superfile%,
					 %super_equifax%,
					 Marketing_Best.proc_build_equifax_base,
					 Marketing_Best.Proc_Build_Equifax_Keys(version_date),
					 Marketing_Best.equifax_new_records_sample,
					 Marketing_Best.fn_strata_stats(version_date)
					 //Marketing_Best.proc_Outfile_hhid_clickid  - Request to disable extract Bug# 177882
					);
							
endmacro;