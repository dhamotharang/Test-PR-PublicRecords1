IMPORT Misc, ut;

EXPORT Files_VendorSrc(STRING pVersion) :=  MODULE

	EXPORT OldData												:= DATASET(Misc.VendorSrc_SF_List(pVersion).Old_Vendor_Src, Layout_VendorSrc.MergedSrc_Base,flat, __compressed__);
																							// CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));
	EXPORT Bankruptcy											:= DATASET(Misc.VendorSrc_SF_List(pVersion).Update_Bank_Court, Layout_VendorSrc.Bank_Court,
																							CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));
	EXPORT Lien														:= DATASET(Misc.VendorSrc_SF_List(pVersion).Update_Lien_Court, Layout_VendorSrc.Lien_Court,
																							CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));
	EXPORT RiskviewFFD										:= DATASET(Misc.VendorSrc_SF_List(pVersion).Update_RiskView, Layout_VendorSrc.Riskview_FFD,
																							CSV(SEPARATOR([',']), HEADING(1), TERMINATOR(['\n','\r\n']), QUOTE(['\"'])));
	EXPORT Combined_Base									:= DATASET(Misc.VendorSrc_SF_List(pVersion).Source_List_Base, Layout_VendorSrc.MergedSrc_Base, FLAT, __COMPRESSED__);
		
	EXPORT create_superfiles	:= PARALLEL(
		IF(~FileServices.SuperFileExists('~thor_data400::base::vendor_src_info'),fileservices.createsuperfile('~thor_data400::base::vendor_src_info')),
		IF(~FileServices.SuperFileExists('~thor_data400::base::vendor_src_info_delete'),fileservices.createsuperfile('~thor_data400::base::vendor_src_info_delete')),
		IF(~FileServices.SuperFileExists('~thor_data400::in::vendor_src_info_father'),fileservices.createsuperfile('~thor_data400::in::vendor_src_info_father')),
		IF(~FileServices.SuperFileExists('~thor_data400::in::vendor_src_info_load_father'),fileservices.createsuperfile('~thor_data400::in::vendor_src_info_load_father')),
		IF(~FileServices.SuperFileExists('~thor_data400::in::vendor_src_info_load_delete'),fileservices.createsuperfile('~thor_data400::in::vendor_src_info_load_delete')));
		
END;