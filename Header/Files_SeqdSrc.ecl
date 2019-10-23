EXPORT Files_SeqdSrc(boolean pFastHeader=false, string filedate = '') := module

    // #stored ('versionBuild', 'yyyymmdd'   ); 
    versionBuild := if(filedate <> '', filedate, header.version_build) : stored('versionBuild');  
    
	SHARED pVersion:=if(pFastHeader,Header.Sourcedata_month.v_eq_as_of_date,versionBuild);

	SHARED SFname:=if(pFastheader,'SeqdFastHeaderSrc','SeqdHeaderSrc');

	EXPORT EQ:=dataset('~thor_data400::in::'+SFname+'_EQ_'+pVersion,Layouts_SeqdSrc.EQ_src_rec,flat);
	EXPORT LiensV2:=dataset('~thor_data400::in::'+SFname+'_L2_'+pVersion,Layouts_SeqdSrc.L2_src_rec,flat);
	EXPORT EN:=dataset('~thor_data400::in::'+SFname+'_EN_'+pVersion,Layouts_SeqdSrc.EN_src_rec,flat);
	EXPORT TN:=dataset('~thor_data400::in::'+SFname+'_TN_'+pVersion,Layouts_SeqdSrc.TN_src_rec,flat);
	EXPORT DL:=dataset('~thor_data400::in::'+SFname+'_DL_'+pVersion,Layouts_SeqdSrc.DL_src_rec,flat);
	EXPORT VH:=dataset('~thor_data400::in::'+SFname+'_VH_'+pVersion,Layouts_SeqdSrc.VH_src_rec,flat);
	EXPORT BA:=dataset('~thor_data400::in::'+SFname+'_BA_'+pVersion,Layouts_SeqdSrc.BA_src_rec,flat);
	EXPORT FAD:=dataset('~thor_data400::in::'+SFname+'_FAD_'+pVersion,Layouts_SeqdSrc.FAD_src_rec,flat);
	EXPORT FAT:=dataset('~thor_data400::in::'+SFname+'_FAT_'+pVersion,Layouts_SeqdSrc.FAT_src_rec,flat);
	EXPORT DE:=dataset('~thor_data400::in::SeqdHeaderSrc_DE_'+pVersion,Layouts_SeqdSrc.DE_src_rec,flat);
	EXPORT DS:=dataset('~thor_data400::in::SeqdHeaderSrc_DS_'+pVersion,Layouts_SeqdSrc.DS_src_rec,flat);
	EXPORT EM:=dataset('~thor_data400::in::SeqdHeaderSrc_EM_'+pVersion,Layouts_SeqdSrc.EM_src_rec,flat);
	EXPORT UT:=dataset('~thor_data400::in::SeqdHeaderSrc_UT_'+pVersion,Layouts_SeqdSrc.UT_src_rec,flat);
	EXPORT AK:=dataset('~thor_data400::in::SeqdHeaderSrc_AK_'+pVersion,Layouts_SeqdSrc.AK_src_rec,flat);
	EXPORT ATF:=dataset('~thor_data400::in::SeqdHeaderSrc_ATF_'+pVersion,Layouts_SeqdSrc.ATF_src_rec,flat);
	EXPORT PL:=dataset('~thor_data400::in::SeqdHeaderSrc_PL_'+pVersion,Layouts_SeqdSrc.PL_src_rec,flat);
	EXPORT WC:=dataset('~thor_data400::in::SeqdHeaderSrc_WC_'+pVersion,Layouts_SeqdSrc.WC_src_rec,flat);
	EXPORT LI:=dataset('~thor_data400::in::SeqdHeaderSrc_LI_'+pVersion,Layouts_SeqdSrc.LI_src_rec,flat);
	EXPORT FR:=dataset('~thor_data400::in::SeqdHeaderSrc_FR_'+pVersion,Layouts_SeqdSrc.FR_src_rec,flat);
	EXPORT AM:=dataset('~thor_data400::in::SeqdHeaderSrc_AM_'+pVersion,Layouts_SeqdSrc.AM_src_rec,flat);
	EXPORT AC:=dataset('~thor_data400::in::SeqdHeaderSrc_AC_'+pVersion,Layouts_SeqdSrc.AC_src_rec,flat);
	EXPORT WA:=dataset('~thor_data400::in::SeqdHeaderSrc_WA_'+pVersion,Layouts_SeqdSrc.WA_src_rec,flat);
	EXPORT BO:=dataset('~thor_data400::in::SeqdHeaderSrc_BO_'+pVersion,Layouts_SeqdSrc.BO_src_rec,flat);
	EXPORT DEA:=dataset('~thor_data400::in::SeqdHeaderSrc_DEA_'+pVersion,Layouts_SeqdSrc.DEA_src_rec,flat);
	EXPORT WP:=dataset('~thor_data400::in::SeqdHeaderSrc_WP_'+pVersion,Layouts_SeqdSrc.WP_src_rec,flat);
	EXPORT SL:=dataset('~thor_data400::in::SeqdHeaderSrc_SL_'+pVersion,Layouts_SeqdSrc.SL_src_rec,flat);
  EXPORT S1:=dataset('~thor_data400::in::SeqdHeaderSrc_S1_'+pVersion,Layouts_SeqdSrc.S1_src_rec,flat);
	EXPORT VO:=dataset('~thor_data400::in::SeqdHeaderSrc_VO_'+pVersion,Layouts_SeqdSrc.VO_src_rec,flat);
	EXPORT CY:=dataset('~thor_data400::in::SeqdHeaderSrc_CY_'+pVersion,Layouts_SeqdSrc.CY_src_rec,flat);
	EXPORT ND:=dataset('~thor_data400::in::SeqdHeaderSrc_ND_'+pVersion,Layouts_SeqdSrc.ND_src_rec,flat);
	EXPORT EL:=dataset('~thor_data400::in::SeqdHeaderSrc_EL_'+pVersion,Layouts_SeqdSrc.EL_src_rec,flat);
	EXPORT AY:=dataset('~thor_data400::in::SeqdHeaderSrc_AY_'+pVersion,Layouts_SeqdSrc.AY_src_rec,flat);

end;