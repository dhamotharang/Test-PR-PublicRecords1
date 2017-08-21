import versioncontrol;

export PRTE_BIP_BH_Filenames(string  pname    = '',
														 string  pversion = '',
														 boolean pUseProd = false
) :=
module
		shared lBaseTemplate(string pname)	 := _Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::' + pname + '::@version@' + '::data';
			
		export Base_bankruptcy    		 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('bankruptcy'),pversion);
		export Base_busreg    				 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('busreg'),pversion);
		export Base_corp2    					 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('corp2'),pversion);
		export Base_dca    						 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('dca'),pversion);
		export Base_dea    						 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('dea'),pversion);
		export Base_dnb    						 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('dnb'),pversion);
		export Base_ebr    						 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('ebr'),pversion);
		export Base_faa    						 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('faa'),pversion);
		//export Base_gong_history    	 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('gong_history'),pversion);
		export Base_irs5500    				 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('irs5500'),pversion);
		export Base_liensv2    				 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('liensv2'),pversion);
		export Base_ln_propertyv2   	 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('ln_propertyv2'),pversion);
		export Base_prolicv2    			 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('prolicv2'),pversion);
		export Base_ucc    						 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('ucc'),pversion);
		export Base_vehiclev2    			 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('vehiclev2'),pversion);
		export Base_watercraft    		 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate('watercraft'),pversion);		
	
		export dAll_Base_filenames 		 :=  Base_bankruptcy.dAll_filenames 		+
																			 Base_busreg.dAll_filenames 				+
																			 Base_corp2.dAll_filenames 					+		
																			 Base_dca.dAll_filenames 						+
																			 Base_dea.dAll_filenames 						+
																			 Base_dnb.dAll_filenames 						+
																			 Base_ebr.dAll_filenames 						+	
																			 Base_faa.dAll_filenames 						+
																		//	 Base_gong_history.dAll_filenames 	+
																			 Base_irs5500.dAll_filenames 				+
																			 Base_liensv2.dAll_filenames 				+
																			 Base_ln_propertyv2.dAll_filenames 	+
																			 Base_prolicv2.dAll_filenames 			+
																			 Base_ucc.dAll_filenames 						+	
																			 Base_vehiclev2.dAll_filenames 			+
																			 Base_watercraft.dAll_filenames;
	
end;