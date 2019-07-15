import Business_Header, Business_Header_SS, ut, business_risk, doxie_cbrs, roxiekeybuild, VersionControl;

export Proc_Build_Business_Header_Keys(

	 string pversion
	,dataset(Business_Header.Layout_BH_Best													)	pBH_Best									= PRTE2_Business_Header.BestAll()
	,dataset(Business_Header_SS.Layout_CompanyName_SS								)	pCompanyName							= PRTE2_Business_Header.fCompany_Name()
	,dataset(Business_Header_SS.Layout_CompanyName_Address_SS				)	pCompanyName_Addr					= PRTE2_Business_Header.fCompany_Name_Addr()
	,dataset(Business_Header_SS.Layout_CompanyName_Address_Broad_SS	) pCompanyName_Addr_Broad		= PRTE2_Business_Header.fCompany_Name_Addr_Broad()
	,dataset(Business_Header_SS.Layout_CompanyName_Phone_SS					)	pCompanyName_Phone				= PRTE2_Business_Header.fCompany_Name_Phone()
	,dataset(Business_Header_SS.Layout_CompanyName_FEIN_SS					)	pCompanyName_FEIN					= PRTE2_Business_Header.fCompany_Name_FEIN()
	,dataset(Business_Header.Layout_BH_Super_Group									)	pBH_Super_Group						= PRTE2_Business_Header.BH_Super_Group()
	,boolean																													pbuild_base_files					= true
                                                                             
) :=
module

	shared keyName		:= PRTE2_Business_Header.keynames	(pversion)			;
	shared names 			:= PRTE2_Business_Header.filenames(pversion).base	;
	
	////////////////////////////////////////////////////////
	// -- Build Output Files
	////////////////////////////////////////////////////////

	VersionControl.macBuildNewLogicalFile( names.HeaderBest.new							,pBH_Best									,Build_Header_Best_File								);
	VersionControl.macBuildNewLogicalFile( names.Companyname.new						,pCompanyName							,Build_Slimsort_CN_File								);
	VersionControl.macBuildNewLogicalFile( names.CompanynameAddress.new			,pCompanyName_Addr				,Build_Slimsort_CN_Address_File				);
	VersionControl.macBuildNewLogicalFile( names.CompanynameAddressBroad.new,pCompanyName_Addr_Broad	,Build_Slimsort_CN_Address_Broad_File	);
	VersionControl.macBuildNewLogicalFile( names.CompanynamePhone.new				,pCompanyName_Phone				,Build_Slimsort_CN_Phone_File					);
	VersionControl.macBuildNewLogicalFile( names.CompanynameFein.new				,pCompanyName_FEIN				,Build_Slimsort_CN_Fein_File					);
	VersionControl.macBuildNewLogicalFile( names.SuperGroup.new							,pBH_Super_Group					,Build_Supergroup_File								);

	////////////////////////////////////////////////////////
	// -- Build Keys
	////////////////////////////////////////////////////////

	VersionControl.macBuildNewLogicalKeyWithName(business_header.Key_BH_Best											,keyname.HeaderBest.FileposData.New				,Build_HeaderBest_FileposData_Key				);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_BH_Best_KnowX								,keyname.HeaderBest.FileposData_Knowx.New	,Build_HeaderBestKnowx_FileposData_Key	);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_CompanyName				,keyname.Base.CompanynameBdidCnBdids.New	,Build_Base_CompanynameBdidCnBdids_Key	);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_BH_CompanyName_Unlimited	,keyname.Base.Companyname.New							,Build_Base_Companyname_Key							);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_Addr_pr_pn_sr_st	,keyname.Base.AddrPrPnSrSt.New						,Build_Base_AddrPrPnSrSt_Key						);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_Addr_pr_pn_zip		,keyname.Base.AddrPrPnZip.New							,Build_Base_AddrPrPnZip_Key							);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_Addr_st						,keyname.Base.AddrSt.New									,Build_Base_AddrSt_Key									);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_Addr_zip					,keyname.Base.AddrZip.New									,Build_Base_AddrZip_Key									);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_Phone							,keyname.Base.Phone.New										,Build_Base_Phone_Key										);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_FEIN							,keyname.Base.Fein.New										,Build_Base_Fein_Key										);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_Source						,keyname.Base.Src.New											,Build_Base_Src_Key											);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_BDID							,keyname.Base.Bdid.New										,Build_Base_Bdid_Key										);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_BH_BDID_pl								,keyname.Base.BdidPl.New									,Build_Base_BdidPl_Key									);
	VersionControl.macBuildNewLogicalKeyWithName(business_header.Key_Business_Relatives						,keyname.Relatives.Bdid1.New							,Build_Relatives_Bdid1_Key							);
	VersionControl.macBuildNewLogicalKeyWithName(business_header.Key_Business_Relatives_Group			,keyname.RelativesGroup.Groupid.New				,Build_RelativesGroup_Groupid_Key				);
	VersionControl.macBuildNewLogicalKeyWithName(doxie_cbrs.key_addr_bdid													,keyname.Base.Addr.New										,Build_Base_Addr_Key										);
	VersionControl.macBuildNewLogicalKeyWithName(Doxie_cbrs.key_BDID_NameVariations								,keyname.Base.BdidSeq.New									,Build_Base_BdidSeq_Key									);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_BH_SuperGroup_GroupID				,keyname.Supergroup.Groupid.New						,Build_Supergroup_Groupid_Key						);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_BH_SuperGroup_BDID						,keyname.Supergroup.Bdid.New							,Build_Supergroup_Bdid_Key							);
	//VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_Prep_SIC_Code								,keyname.Base.Siccode.New									,Build_Base_Siccode_Key									);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_SICCode_Zip									,keyname.Base.SiccodeZip.New							,Build_Base_SiccodeZip_Key							);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_ZipPRLName										,keyname.Base.ZipPRLName.New							,Build_Base_ZipPRLName_Key							);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_Business_Header_RCID					,keyname.Base.Rcid.New										,Build_Base_Rcid_Key										);
	//VersionControl.macBuildNewLogicalKeyWithName(Business_Header.Key_Commercial_SIC_Zip						,keyname.Base.Commercial.New							,Build_Commercial_Siccode_Key						);
																																																											 
																																																											 
	shared Build_Bases :=
	sequential(

		 Build_Header_Best_File
		,PRTE2_Business_Header.promote(pversion,'^~prte.*?base::business_header.*best$').new2built
		,Build_Slimsort_CN_File			
		,Build_Slimsort_CN_Address_File	
  	,Build_Slimsort_CN_Address_Broad_File	
		,Build_Slimsort_CN_Phone_File	
		,Build_Slimsort_CN_Fein_File	
		,Build_Supergroup_File			
	) : success(output('Build PRCT Business Header Base Files Complete'));

	shared keygroupnames := 
				keyname.HeaderBest.FileposData.dAll_filenames                                                                           
			+ keyname.HeaderBest.FileposData_Knowx.dAll_filenames                                                                           
			+ keyname.Base.CompanynameBdidCnBdids.dAll_filenames
			+ keyname.Base.Companyname.dAll_filenames
			+ keyname.Base.AddrPrPnSrSt.dAll_filenames
			+ keyname.Base.AddrPrPnZip.dAll_filenames
			+ keyname.Base.AddrSt.dAll_filenames
			+ keyname.Base.AddrZip.dAll_filenames
			+ keyname.Base.Phone.dAll_filenames
			+ keyname.Base.Fein.dAll_filenames
			+ keyname.Base.Src.dAll_filenames
			+ keyname.Base.Bdid.dAll_filenames
			+ keyname.Base.BdidPl.dAll_filenames
			+ keyname.Relatives.Bdid1.dAll_filenames
			+ keyname.RelativesGroup.Groupid.dAll_filenames
			+ keyname.Base.Addr.dAll_filenames
			+ keyname.Base.BdidSeq.dAll_filenames
			+ keyname.Supergroup.Groupid.dAll_filenames
			+ keyname.Supergroup.Bdid.dAll_filenames
			+ keyname.Base.Siccode.dAll_filenames
			+ keyname.Base.SiccodeZip.dAll_filenames
			+ keyname.Base.ZipPRLName.dAll_filenames
			+ keyname.Base.Rcid.dAll_filenames
			+ keyname.Base.Commercial.dAll_filenames
			; 

	shared Build_Keys :=
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroupnames)
		,parallel(

			 Build_HeaderBest_FileposData_Key		
			,Build_HeaderBestKnowx_FileposData_Key
			,Build_Base_CompanynameBdidCnBdids_Key
			,Build_Base_Companyname_Key			
			,Build_Base_AddrPrPnSrSt_Key			
			,Build_Base_AddrPrPnZip_Key			
			,Build_Base_AddrSt_Key			
			,Build_Base_AddrZip_Key			
			,Build_Base_Phone_Key					
			,Build_Base_Fein_Key					
			,Build_Base_Src_Key					
			,Build_Base_Bdid_Key					
			,Build_Base_BdidPl_Key				
			,Build_Relatives_Bdid1_Key			
			,Build_RelativesGroup_Groupid_Key		
			,Build_Base_Addr_Key					
			,Build_Base_BdidSeq_Key				
			,Build_Supergroup_Groupid_Key			
			,Build_Supergroup_Bdid_Key			
			//,Build_Base_Siccode_Key	
			,Build_Base_SiccodeZip_Key
			,Build_Base_ZipPRLName_Key
			,Build_Base_Rcid_Key
			//,Build_Commercial_Siccode_Key				

		)) : success(output('Build PRCT Business Header Slimsort, Supergroup, and Best Keys Complete'));

	export all := sequential(
		 if(pbuild_base_files, Build_Bases, output('PRCT Base files and SFs not affected.'))
		,PRTE2_business_header.promote(pversion,'^~prte.*?base::business_header.*').new2built
		,Build_Keys
		,PRTE2_business_header.promote(pversion,'^(.*?)key(.*?)$').new2built
		
	);
end;