import
			ut
			,PromoteSupers
			,ak_perm_fund
			,utilfile
			,vehiclev2
			,bankrupt
			,BankruptcyV2
			,BankruptcyV3
			,driversv2
			,gong
			,ln_property
			,LN_Mortgage
			,emerges
			,atf
			,prof_license
			,govdata
			,faa
			,dea
			,watercraft
			,property
			,targus
			,LiensV2
			,ln_propertyv2
			,american_student_list
            ,OKC_Student_List
			,votersv2
			,certegy
			,ExperianCred
			,ExperianIRSG_Build
			,eq_hist
			,TransunionCred
			,AlloyMedia_student_list
			;

EXPORT Mod_SetSources(boolean pFastHeader=false,string ver='default') := module

	SHARED SFname:=if(pFastheader,'SeqdFastHeaderSrc','SeqdHeaderSrc');

	SHARED Mac_output(dsIn,pSF,dsOut) := MACRO
	#uniquename(seq)
		PromoteSupers.MAC_SF_BuildProcess(dsIn,'~thor_data400::in::'+pSF,%seq%,numgenerations:=2,pVersion:=ver,pCompress:=true);
		dsOut:=%seq%;
	EndMacro;
	
	EQ := header.file_header_in(pFastheader).eq_uid_monthly;
	Mac_output(EQ,SFname+'_EQ',seq_EQ);
	EXPORT sequence_EQ:=seq_EQ;

	L2 := LiensV2.LiensV2_as_Source(pFastheader);
	Mac_output(L2,SFname+'_L2',seq_L2);
	EXPORT sequence_L2:=seq_L2;

	EN := ExperianCred.Experian_as_Source(,~pFastheader,pFastheader); 
	Mac_output(EN,SFname+'_EN',seq_EN);
	EXPORT sequence_EN:=seq_EN;

	TN := TransunionCred.as_source(,~pFastheader,pFastheader);
	Mac_output(TN,SFname+'_TN',seq_TN);
	EXPORT sequence_TN:=seq_TN;

	DL := driversv2.dls_as_source(,~pFastheader,pFastheader);
	Mac_output(DL,SFname+'_DL',seq_DL);
	EXPORT sequence_DL:=seq_DL;

	VH := vehiclev2.vehicle_as_source(,,~pFastheader,pFastheader);
	Mac_output(VH,SFname+'_VH',seq_VH);
	EXPORT sequence_VH:=seq_VH;

	BA := BankruptcyV3.BKv3_as_source(,,~pFastheader,pFastheader);
	Mac_output(BA,SFname+'_BA',seq_BA);
	EXPORT sequence_BA:=seq_BA;

	FAT := ln_propertyv2.ln_propertyv2_as_source(pFastheader).ln_propertyv2_tax_as_source;
	Mac_output(FAT,SFname+'_FAT',seq_FAT);
	EXPORT sequence_FAT:=seq_FAT;

	FAD := ln_propertyv2.ln_propertyv2_as_source(pFastheader).ln_propertyv2_deed_as_source;
	Mac_output(FAD,SFname+'_FAD',seq_FAD);
	EXPORT sequence_FAD:=seq_FAD;


	DE := death_as_source(,true);
	Mac_output(DE,SFname+'_DE',seq_DE);
	EXPORT sequence_DE:=seq_DE;

	DS := header.state_death_as_source(,true);
	Mac_output(DS,SFname+'_DS',seq_DS);
	EXPORT sequence_DS:=seq_DS;

	EM := emerges.master_As_source(,true);
	Mac_output(EM,SFname+'_EM',seq_EM);
	EXPORT sequence_EM:=seq_EM;

	UTL := utilfile.util_as_source;
	Mac_output(UTL,SFname+'_UT',seq_UT);
	EXPORT sequence_UT:=seq_UT;

	AK := ak_perm_fund.APF_As_Source(,,true);
	Mac_output(AK,SFname+'_AK',seq_AK);
	EXPORT sequence_AK:=seq_AK;

	ATF := atf.atf_as_Source(,true);
	Mac_output(ATF,SFname+'_ATF',seq_ATF);
	EXPORT sequence_ATF:=seq_ATF;

	PL := prof_license.proflic_as_Source(,true);
	Mac_output(PL,SFname+'_PL',seq_PL);
	EXPORT sequence_PL:=seq_PL;

	WC := govdata.MS_Worker_as_Source(,true);
	Mac_output(WC,SFname+'_WC',seq_WC);
	EXPORT sequence_WC:=seq_WC;

	LI := bankrupt.Liens_As_Source(,true);
	Mac_output(LI,SFname+'_LI',seq_LI);
	EXPORT sequence_LI:=seq_LI;

	FR := property.Foreclosure_as_Source(,true);
	Mac_output(FR,SFname+'_FR',seq_FR);
	EXPORT sequence_FR:=seq_FR;

	AM := faa.airmen_as_Source(,true);
	Mac_output(AM,SFname+'_AM',seq_AM);
	EXPORT sequence_AM:=seq_AM;

	AC := faa.aircraft_as_Source(,true);
	Mac_output(AC,SFname+'_AC',seq_AC);
	EXPORT sequence_AC:=seq_AC;

	WA := watercraft.Watercraft_as_Source(,,,true);
	Mac_output(WA,SFname+'_WA',seq_WA);
	EXPORT sequence_WA:=seq_WA;

	BO := emerges.boat_as_Source(,true);
	Mac_output(BO,SFname+'_BO',seq_BO);
	EXPORT sequence_BO:=seq_BO;

	DEA := dea.DEA_As_Source(,true);
	Mac_output(DEA,SFname+'_DEA',seq_DEA);
	EXPORT sequence_DEA:=seq_DEA;

	WP := targus.consumer_as_Source(,true);
	Mac_output(WP,SFname+'_WP',seq_WP);
	EXPORT sequence_WP:=seq_WP;

	S1 := OKC_Student_List.OKC_Student_List_as_source(,true);
	Mac_output(S1,SFname+'_S1',seq_S1);
	EXPORT sequence_S1:=seq_S1;

	SL := american_student_list.asl_as_Source(,true);
	Mac_output(SL,SFname+'_SL',seq_SL);
	EXPORT sequence_SL:=seq_SL;

	VO := votersv2.voters_as_Source(,true);
	Mac_output(VO,SFname+'_VO',seq_VO);
	EXPORT sequence_VO:=seq_VO;

	CY := Certegy.As_Source(,true);
	Mac_output(CY,SFname+'_CY',seq_CY);
	EXPORT sequence_CY:=seq_CY;

	ND := property.NOD_as_Source(,true);
	Mac_output(ND,SFname+'_ND',seq_ND);
	EXPORT sequence_ND:=seq_ND;

	EL := ExperianIRSG_Build.ExperianIRSG_asSource(,true); 
	Mac_output(EL,SFname+'_EL',seq_EL);
	EXPORT sequence_EL:=seq_EL;

	AY := AlloyMedia_student_list.alloy_as_Source(,true); 
	Mac_output(AY,SFname+'_AY',seq_AY);
	EXPORT sequence_AY:=seq_AY;

end;