import MDR, codes, Royalty;

export Constants := module

	// All codes defined here must match the master definition in Royalty.Master.
	export RoyaltyCode := module
		export unsigned2 QSENT					:= 100;
		export unsigned2 QSENT_IQ411		:= 101;
		export unsigned2 QSENT_PVS			:= 102;
		export unsigned2 TARGUS					:= 110;
		export unsigned2 TARGUS_PDE			:= 111;
		export unsigned2 TARGUS_WCS			:= 112;	// Wireless Connection Search/Confirm Connect
		export unsigned2 TARGUS_VE			:= 113;
		export unsigned2 TARGUS_NV			:= 114;
		export unsigned2 METRONET				:= 120;
		export unsigned2 POLK						:= 130;
		export unsigned2 EXPERIAN				:= 140;
		export unsigned2 EN_HEADER_FCRA	:= 141;
		export unsigned2 INVIEW_DEFAULT	:= 150;
		export unsigned2 INVIEW_REPORT	:= 151;
		export unsigned2 INVIEW_BCRCI_BFRL := 152;
		export unsigned2 INVIEW_BCRCI_BCIR := 153;
		export unsigned2 INVIEW_BFRL_BCIR	:= 154;
		export unsigned2 INVIEW_BCRCI		:= 155;
		export unsigned2 INVIEW_BFRL		:= 156;
		export unsigned2 INVIEW_BCIR		:= 157;
		export unsigned2 GDCVERIFY			:= 160;
		export unsigned2 NETACUITY			:= 170;
		export unsigned2 ERC						:= 180;
		export unsigned2 ATTUS					:= 190;
		export unsigned2 FARES					:= 200;
		export unsigned2 LAST_RESORT		:= 220;
		export unsigned2 EFX_DATA_MART	:= 225;
		export unsigned2 DMXML					:= 230;
		export unsigned2 TEASER					:= 240;
		export unsigned2 FDN_DL_DATA		:= 250;
		export unsigned2 SBFE					  := 260;
		export unsigned2 SBFE_PDF		  := 261;
		export unsigned2 EMAIL					:= 300;
		export unsigned2 EMAIL_AW				:= 301;
		export unsigned2 EMAIL_M1				:= 302;
		export unsigned2 EMAIL_OM				:= 303;
		export unsigned2 EMAIL_TM				:= 304;
		export unsigned2 EMAIL_TP				:= 305;
		export unsigned2 EMAIL_IB				:= 306;
		export unsigned2 EMAIL_IM				:= 307;
		export unsigned2 EMAIL_WA				:= 308;
		export unsigned2 EMAIL_AO				:= 309;
		export unsigned2 EMAIL_DG				:= 310;
		export unsigned2 EMAIL_SC				:= 311;
		export unsigned2 WORKPLACE			:= 320;
		export unsigned2 WORKPLACE_OC		:= 321;
		export unsigned2 WORKPLACE_TT		:= 322;
		export unsigned2 WORKPLACE_SC		:= 323;
		export unsigned2 WORKPLACE_TL		:= 324;
		export unsigned2 WORKPLACE_TP		:= 325;
		export unsigned2 WORKPLACE_SP_OC := 326;
		export unsigned2 WORKPLACE_SP_TT := 327;
		export unsigned2 WORKPLACE_SP_SC := 328;
		export unsigned2 WORKPLACE_SP_TL := 329;
		export unsigned2 WORKPLACE_SP_TP := 330;
		export unsigned2 WORLDCHECK			:= 350;
		export unsigned2 EAH_EQ					:= 360;
		export unsigned2 EAH_DB_SALES		:= 361;
		export unsigned2 EAH_DB_EMPS		:= 362;
		export unsigned2 DNB						:= 370;
		export unsigned2 POWERVIEW			:= 428;
		export unsigned2 FICOSCOREXD		:= 429;
		export unsigned2 TU_FRAUD_ALERT	:= 431;
		export unsigned2 GG2						:= 450;
		export unsigned2 GDC						:= 500;
		export unsigned2 MLAALERT				:= 590;
		export unsigned2 ZUMIGO_IDENTITY:= 601;
		export unsigned2 ATT_IAP_DQ_IRS	:= 611;
		export unsigned2 EFX_CCR        := 620;
		export unsigned2 EFX_TWN_VOE   	:= 621;
		export unsigned2 EFX_TWN_VOI   	:= 622;
		export unsigned2 EFX_ATTR       := 625;
		export unsigned2 EFX_TWN_VOE_GW := 626;
		export unsigned2 EFX_TWN_VOI_GW := 627;
		export unsigned2 EFX_EMS				:= 628;
		export unsigned2 FDNCORR   := 650;
		export unsigned2 ACCUITY_BANK_ROUTING := 690;
		export unsigned2 CORTERA_FILE := 701;
		export unsigned2 ACCUDATA_CNAM_CNM2   := 711;
		export unsigned2 ACCUDATA_OCN_LNP   := 712;
		export unsigned2 BRITE_VERIFY_EMAIL := 720;
    
	end;

	export RoyaltyType := module
		shared _TYPE(unsigned2 _code)	:= TRIM(Royalty.Master(file_name='ROYALTY', field_name2=(string)_code)[1].field_name, LEFT, RIGHT);
		export QSENT					:= _TYPE(RoyaltyCode.QSENT);
		export QSENT_IQ411		:= _TYPE(RoyaltyCode.QSENT_IQ411);
		export QSENT_PVS			:= _TYPE(RoyaltyCode.QSENT_PVS);
		export TARGUS					:= _TYPE(RoyaltyCode.TARGUS);
		export TARGUS_PDE			:= _TYPE(RoyaltyCode.TARGUS_PDE);
		export TARGUS_WCS			:= _TYPE(RoyaltyCode.TARGUS_WCS);
		export TARGUS_VE			:= _TYPE(RoyaltyCode.TARGUS_VE);
		export TARGUS_NV			:= _TYPE(RoyaltyCode.TARGUS_NV);
		export METRONET				:= _TYPE(RoyaltyCode.METRONET);
		export POLK						:= _TYPE(RoyaltyCode.POLK);
		export EXPERIAN				:= _TYPE(RoyaltyCode.EXPERIAN);
		export EN_HEADER_FCRA	:= _TYPE(RoyaltyCode.EN_HEADER_FCRA);
		export FDN_DL_DATA  	:= _TYPE(RoyaltyCode.FDN_DL_DATA);
		export SBFE           := _TYPE(RoyaltyCode.SBFE);
		export SBFE_PDF       := _TYPE(RoyaltyCode.SBFE_PDF);
		export INVIEW_DEFAULT	:= _TYPE(RoyaltyCode.INVIEW_DEFAULT);
		export INVIEW_REPORT	:= _TYPE(RoyaltyCode.INVIEW_REPORT);
		export INVIEW_BCRCI_BFRL := _TYPE(RoyaltyCode.INVIEW_BCRCI_BFRL);
		export INVIEW_BCRCI_BCIR := _TYPE(RoyaltyCode.INVIEW_BCRCI_BCIR);
		export INVIEW_BFRL_BCIR	 := _TYPE(RoyaltyCode.INVIEW_BFRL_BCIR);
		export INVIEW_BCRCI		:= _TYPE(RoyaltyCode.INVIEW_BCRCI);
		export INVIEW_BFRL		:= _TYPE(RoyaltyCode.INVIEW_BFRL);
		export INVIEW_BCIR		:= _TYPE(RoyaltyCode.INVIEW_BCIR);
		export GDCVERIFY			:= _TYPE(RoyaltyCode.GDCVERIFY);
		export NETACUITY			:= _TYPE(RoyaltyCode.NETACUITY);
		export ERC						:= _TYPE(RoyaltyCode.ERC);
		export ATTUS					:= _TYPE(RoyaltyCode.ATTUS);
		export FARES					:= _TYPE(RoyaltyCode.FARES);
		export FARES_SLINX		:= _TYPE(RoyaltyCode.FARES);
		export LAST_RESORT		:= _TYPE(RoyaltyCode.LAST_RESORT);
		export EFX_DATA_MART  := _TYPE(RoyaltyCode.EFX_DATA_MART);
		export DMXML					:= _TYPE(RoyaltyCode.DMXML);
		export TEASER					:= _TYPE(RoyaltyCode.TEASER);
		export EMAIL					:= _TYPE(RoyaltyCode.EMAIL);
		export EMAIL_AW				:= _TYPE(RoyaltyCode.EMAIL_AW);
		export EMAIL_M1				:= _TYPE(RoyaltyCode.EMAIL_M1);
		export EMAIL_OM				:= _TYPE(RoyaltyCode.EMAIL_OM);
		export EMAIL_TM				:= _TYPE(RoyaltyCode.EMAIL_TM);
		export EMAIL_TP				:= _TYPE(RoyaltyCode.EMAIL_TP);
		export EMAIL_IB				:= _TYPE(RoyaltyCode.EMAIL_IB);
		export EMAIL_IM				:= _TYPE(RoyaltyCode.EMAIL_IM);
		export EMAIL_WA				:= _TYPE(RoyaltyCode.EMAIL_WA);
		export EMAIL_AO				:= _TYPE(RoyaltyCode.EMAIL_AO);
		export EMAIL_DG				:= _TYPE(RoyaltyCode.EMAIL_DG);
		export EMAIL_SC				:= _TYPE(RoyaltyCode.EMAIL_SC);
		export WORKPLACE			:= _TYPE(RoyaltyCode.WORKPLACE);
		export WORKPLACE_OC		:= _TYPE(RoyaltyCode.WORKPLACE_OC);
		export WORKPLACE_TT		:= _TYPE(RoyaltyCode.WORKPLACE_TT);
		export WORKPLACE_SC		:= _TYPE(RoyaltyCode.WORKPLACE_SC);
		export WORKPLACE_TL		:= _TYPE(RoyaltyCode.WORKPLACE_TL);
		export WORKPLACE_TP		:= _TYPE(RoyaltyCode.WORKPLACE_TP);
		export WORKPLACE_SP_OC := _TYPE(RoyaltyCode.WORKPLACE_SP_OC);
		export WORKPLACE_SP_TT := _TYPE(RoyaltyCode.WORKPLACE_SP_TT);
		export WORKPLACE_SP_SC := _TYPE(RoyaltyCode.WORKPLACE_SP_SC);
		export WORKPLACE_SP_TL := _TYPE(RoyaltyCode.WORKPLACE_SP_TL);
		export WORKPLACE_SP_TP := _TYPE(RoyaltyCode.WORKPLACE_SP_TP);
		export WORLDCHECK			:= _TYPE(RoyaltyCode.WORLDCHECK);
		export EAH_EQ					:= _TYPE(RoyaltyCode.EAH_EQ);
		export EAH_DB_SALES		:= _TYPE(RoyaltyCode.EAH_DB_SALES);
		export EAH_DB_EMPS		:= _TYPE(RoyaltyCode.EAH_DB_EMPS);
		export DNB						:= _TYPE(RoyaltyCode.DNB);
		export POWERVIEW			:= _TYPE(RoyaltyCode.POWERVIEW);
		export FICOSCOREXD		:= _TYPE(RoyaltyCode.FICOSCOREXD);
		export TU_FRAUD_ALERT	:= _TYPE(RoyaltyCode.TU_FRAUD_ALERT);
		export MLAALERT				:= _TYPE(RoyaltyCode.MLAALERT);
		export GG2						:= _TYPE(RoyaltyCode.GG2);
		export GDC						:= _TYPE(RoyaltyCode.GDC);
		export ZUMIGO_IDENTITY:= _TYPE(RoyaltyCode.ZUMIGO_IDENTITY);
		export ATT_IAP_DQ_IRS	:= _TYPE(RoyaltyCode.ATT_IAP_DQ_IRS);
		export EFX_CCR        := _TYPE(RoyaltyCode.EFX_CCR);
		export EFX_TWN_VOE		:= _TYPE(RoyaltyCode.EFX_TWN_VOE);
		export EFX_TWN_VOI		:= _TYPE(RoyaltyCode.EFX_TWN_VOI);
		export EFX_ATTR       := _TYPE(RoyaltyCode.EFX_ATTR);
		export EFX_TWN_VOE_GW := _TYPE(RoyaltyCode.EFX_TWN_VOE_GW);
		export EFX_TWN_VOI_GW := _TYPE(RoyaltyCode.EFX_TWN_VOI_GW);
		export EFX_EMS				:= _TYPE(RoyaltyCode.EFX_EMS);
		export FDNCORR				:= _TYPE(RoyaltyCode.FDNCORR);
		export ACCUITY_BANK_ROUTING			:= _TYPE(RoyaltyCode.ACCUITY_BANK_ROUTING);
		export CORTERA_FILE			:= _TYPE(RoyaltyCode.CORTERA_FILE);
		export ACCUDATA_CNAM_CNM2				:= _TYPE(RoyaltyCode.ACCUDATA_CNAM_CNM2);
		export ACCUDATA_OCN_LNP					:= _TYPE(RoyaltyCode.ACCUDATA_OCN_LNP);
		export BRITE_VERIFY_EMAIL  			:= _TYPE(RoyaltyCode.BRITE_VERIFY_EMAIL);
	end;

	// *** DO NOT USE: TO BE DEPRECATED AND DELETED once batch can handle RoyaltySet dataset.
	export RoyaltySrc := module
		export string2 POLK				:=  'PO';
		export string2 EXPERIAN		:= 	'XP';
	end;

	export set of string2 LastResortRoyalty := [MDR.sourceTools.src_wired_Assets_Royalty];

	export WORKPLACE_ROYALTY_SET := [
		MDR.sourceTools.src_One_Click_Data,
		MDR.sourceTools.src_Teletrack,
		MDR.sourceTools.src_SalesChannel,
		MDR.sourceTools.src_Thrive_LT,
		MDR.sourceTools.src_Thrive_PD
		];

	// Email Royalties: Ensure that removed providers are absent from FCRA/non-FCRA queries
	base_email_tab := Codes.Key_Codes_V3(keyed(file_name = 'EMAIL_SOURCES'), keyed(field_name = 'ROYALTY'));
	set_removed_email := [];
	set_removed_email_fcra := [MDR.sourceTools.src_Datagence];	// Datagence/V12 has been removed from FCRA

	export EMAIL_ROYALTY_TABLE(boolean isFCRA = false) := if(isFCRA,
		base_email_tab(code not in set_removed_email_fcra),
		base_email_tab(code not in set_removed_email));
	export EMAIL_ROYALTY_SET(boolean isFCRA = false) := set(EMAIL_ROYALTY_TABLE(isFCRA), code);

	export SourceType := MODULE
		export string1 INHOUSE := 'I';
		export string1 GATEWAY := 'G';
	end;

	export GatewayRoyalties := SET(Royalty.Master(source_type=SourceType.GATEWAY), (unsigned2) field_name2);

end;
