IMPORT  mdr,  //mdr to handle the corp2 filtering case  --HS comment. See Corp2 below. 7/29/16  
	 bankruptcyv2
	,bbb2
  ,Business_Credit
	,business_header
	,busdata
	,busreg
	,cclue
	,corp2
	,CrashCarrier
	,credit_unions
	,dcav2
	,dea
	,dnb_dmi
	,dnb_feinv2
	,ebr
	,experian_crdb
	,experian_fein
	,faa
	,fbnv2
	,frandx
	,govdata
	,gong_v2
	,infousa
	,irs5500
	//,jigsaw //*** Removed based on the email from Joe & Ellion.
	,liensv2
	,ln_propertyv2
	,oshair
	,prof_licensev2	
	,txbus
	,uccv2
	,utilfile
	,vehiclev2
	,watercraft
	,workers_compensation
	,yellowpages
	,zoom
	;

   Business_Sources1 :=
			BankruptcyV2.Bankruptv2_As_Business_Linking
		//+	bbb2.BBB_As_Business_Linking //Need to comment out from sprint36
		+ BusData.SKA_As_Business_Linking
    + Business_Credit.Business_Credit_As_Business_Linking
		+ BusReg.BusReg_As_Business_Linking(false).Busreg  //*** set to false to use the dataland base files for input.
		//+ CClue.As_Business_Linking()  
		+ Corp2.Corp2_As_Business_Linking()
		+ CrashCarrier.As_Business_Linking
		+ Credit_Unions.as_business_linking(FALSE)
		+ dcav2.as_Business_linking()  								//** Due to layout change, Audra is reworking on it, so pulling in the older persist.
		+ DEA.DEA_As_Business_Linking
		+ DNB_DMI.As_Business_Linking()
		+ DNB_FEINV2.DNB_FEIN_As_Business_Linking			//***Business info only, no contacts
		+ EBR.EBR_As_Business_Linking
		//+ Experian_CRDB.As_Business_Linking()
		+ Experian_FEIN.As_Business_Linking()
		+ FAA.faa_aircraft_reg_as_business_linking
		+ FBNV2.As_Business_Linking
		+ Frandx.As_Business_Linking()
		+ Govdata.CA_Sales_Tax_As_Business_Linking()
		//+ Govdata.FDIC_As_Business_Linking  //commented out in sprint43
		+ Govdata.IRS_Non_Profit_As_Business_Linking
		+ Gong_v2.As_Business_Linking()
		+ InfoUSA.ABIUS_Company_As_Business_Linking
		+ InfoUSA.DEADCO_As_Business_Linking
		+ IRS5500.IRS5500_As_Business_Linking
		//+ Jigsaw.As_Business_Linking().Jigsaw		//*** Removed due to data contactual resitrictions as per Jason, Joe & Ellion.
		+ LiensV2.LiensV2_As_Business_Linking()
		+ LN_PropertyV2.LN_PropertyV2_as_Business_Linking()
		+ OSHAIR.Cleaned_OSHAIR_Inspection_As_Business_Linking
		+ Prof_LicenseV2.As_Business_Linking()
		+ TXBUS.Cleaned_TXBUS_As_Business_Linking()
		+ UCCV2.As_Business_Linking()
		+ UtilFile.As_Business_Linking()
		+ VehicleV2.VehicleV2_As_Business_Linking
		//+ Watercraft.Watercraft_as_Business_Linking  //comment out in sprint43
		+ Workers_Compensation.As_Business_Linking
		+ YellowPages.As_Business_Linking()
		+ Zoom.Zoom_As_Business_Linking
		;
		//remove these Corp2 special state data:
 export Business_Sources:=Business_Sources1
 (~(
           mdr.sourceTools.SourceIsNJ_Corporations(source) 
        or mdr.sourceTools.SourceIsNM_Corporations(source) 
        or mdr.sourceTools.SourceIsDC_Corporations(source) 
        // or mdr.sourceTools.SourceIsAK_Corporations(source)
        or mdr.sourceTools.SourceIsNV_Corporations(source)
        or mdr.sourceTools.SourceIsOK_Corporations(source)
				or mdr.sourceTools.SourceIsIA_Corporations(source) 
        or mdr.sourceTools.SourceIsIN_Corporations(source)
        or mdr.sourceTools.SourceIsMN_Corporations(source)
        or mdr.sourceTools.SourceIsSD_Corporations(source)
				or mdr.sourceTools.SourceIsKS_Corporations(source)
				or mdr.sourceTools.SourceIsVA_Corporations(source)
				
				// or mdr.sourceTools.SourceIsAL_Corporations(source)
				or mdr.sourceTools.SourceIsAZ_Corporations(source)
				or mdr.sourceTools.SourceIsID_Corporations(source)
				or mdr.sourceTools.SourceIsLA_Corporations(source)
				or mdr.sourceTools.SourceIsND_Corporations(source)
				or mdr.sourceTools.SourceIsUT_Corporations(source)
				or mdr.sourceTools.SourceIsWI_Corporations(source)
				or mdr.sourceTools.SourceIsWV_Corporations(source)
				
        or mdr.sourceTools.SourceIsHI_Corporations(source)
        or mdr.sourceTools.SourceIsMA_Corporations(source)
        or mdr.sourceTools.SourceIsNJ_Corporations(source)
        or mdr.sourceTools.SourceIsWY_Corporations(source)
    ));