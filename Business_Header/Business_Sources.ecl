IMPORT  
	 acf
	,ak_busreg
	,amidir
	,atf
	,bankruptcyv2
	,Bankruptcy_Attorney_Trustee
	,bbb2
	,busdata
	,busreg
	,calbus
	,corp2
	,credit_unions
	,dcav2
	,dea
	,dnb_dmi
	,dnb_feinv2
	,domains
	,ebr
	,edgar
	,faa
	,fcc
	,fbnv2
	,gaming_licenses
	,gong_neustar
	,govdata
	,infousa
	,irs5500
	//,jigsaw - Removing due to the contractual restrictions, as per Jason. 
	,liensv2
	,liquor_licenses
	,ln_propertyv2
	,lobbyists
	,martindale_hubbell
	,oshair
	,prof_license
	,Redbooks
	,sda_sdaa
	,sheila_greco
	,spoke
	,txbus
	,uccv2
	,UtilFile
	,vickers
	,watercraft
	,wither_and_die
	,yellowpages
	,zoom
	,TXBUS
	;

export Business_Sources :=
module

	export business_headers :=
			ACF.ACF_AS_Business_Header
		+ ak_busreg.As_Business().Header
		+ AMIDIR.AMIDIR_As_Business_Header
		+ atf.ATF_as_Business_Header
		+ Bankruptcyv2.Bankruptv2_As_Business_Header 
		+ Bankruptcy_Attorney_Trustee.Attorney_As_Business_Header		
		+ bbb2.BBB_As_Business_Header
		+ busdata.Accurint_Tradeshow_As_Business_Header
		+ busdata.SKA_As_Business_Header
		+ BusReg.BusReg_As_Business_Header().Busreg
		+ CALBUS.CALBUS_As_Business_Header
		+ Corp2.As_Business_Header.corp
		+ Credit_Unions.as_business_header()
		+ dcav2.as_Business_Header()
		+ DEA.DEA_As_Business_Header
		+ DNB_dmi.As_Business_Header()
		+ DNB_FEINV2.As_Business_Header.DnbFeinV2			//bus header only, no contacts
		+ ebr.EBR_As_Business_Header
		+ Edgar.Edgar_As_Business_Header
		+ faa.faa_aircraft_reg_as_business_header
		+ fcc.FCC_Licenses_As_Business_Header
		+ FBNV2.FBNV2_As_Business_Header
		+ Gaming_Licenses.As_Business_Header().NJ
		+ Gong_Neustar.As_Business_Header().GongV2
		+ govdata.FDIC_As_Business_Header
		+ govdata.FL_FBN_As_Business_Header
		+ govdata.FL_Non_Profit_As_Business_Header
		+ govdata.Gov_Phones_As_Business_Header()
		+ govdata.IA_Sales_Tax_As_Business_Header
		+ govdata.IRS_Non_Profit_As_Business_Header
		+ govdata.MS_Workers_As_Business_Header
		+ govdata.OR_Workers_As_Business_Header					//bus header only
		+ govdata.SEC_Broker_Dealer_As_Business_Header
		+ infousa.ABIUS_Company_As_Business_Header
		+ infousa.DEADCO_As_Business_Header
		+ infousa.IDEXEC_As_Business_Header
		+ IRS5500.IRS5500_As_Business_Header
		//+ Jigsaw.As_Business_Header().Jigsaw					//Removing due to the contractual restrictions, as per Jason. 
		+ LiensV2.LiensV2_As_Business_Header()					//bus header only
		+ Liquor_Licenses.As_Business_Header.CA
		+ Liquor_Licenses.As_Business_Header.CT
		+ Liquor_Licenses.As_Business_Header.IN
		+ Liquor_Licenses.As_Business_Header.LA
		+ Liquor_Licenses.As_Business_Header.OH
		+ Liquor_Licenses.As_Business_Header.PA
		+ Liquor_Licenses.As_Business_Header.TX
		+ ln_propertyv2.LN_Propertyv2_as_Business_Header()
		//+ lobbyists.Cleaned_Lobbyists_As_Business_Header		//Not being updated, and the base file is missing. So, removing the code since the data already exists in the Business header file.
		+ martindale_hubbell.As_Business_Header().Organizations
		+ OSHAIR.OSHAIR_Inspection_As_Business_Header
		+ Prof_License.Prof_License_As_Business_Header()
		+ RedBooks.As_Business_Header()
		+ SDA_SDAA.SDA_SDAA_AS_Business_Header
		+ Sheila_Greco.As_Business_Header.Companies
		+ Spoke.As_Business.Header
		+ TXBUS.Cleaned_TXBUS_As_Business_Header
		+ UCCV2.UCCV2_As_Business_Header()
		+ UtilFile.As_Business_Header()
		+ Vickers.Vickers_As_Business_Header
		+ watercraft.Watercraft_as_Business_Header()
		+ wither_and_die.Wither_and_Die_as_Business_Header
		+ YellowPages.YellowPages_As_Business_Header
		+ Zoom.Zoom_As_Business_Header
		;
	
	export business_contacts :=
			ACF.ACF_As_Business_contact
		+ ak_busreg.As_Business().Contact
		+ amidir.AMIDIR_As_Business_Contact
		+ atf.ATF_as_Business_Contact
		+ BankruptcyV2.Bankruptv2_As_Business_Contact
		+ Bankruptcy_Attorney_Trustee.Attorney_As_Business_Contact
		+ BusData.Accurint_Tradeshow_As_Business_Contact
		+ BusData.SKA_As_Business_Contact
		+ BusReg.BusReg_As_Business_Contact().Busreg
		+ CALBUS.Calbus_As_Business_Contact
		+ Corp2.As_Business_Contact.cont
		+ Credit_Unions.as_business_Contact()
		+ dcav2.as_Business_Contact()
		+ DEA.DEA_As_Business_Contact
		+ DNB_dmi.As_Business_Contact()
		+ Domains.Whois_As_Business_Contact						//not being added to bus header anymore(but there are records in there still)
		+ ebr.EBR_As_Business_Contact
		+ Edgar.Edgar_As_Business_Contact
		+ faa.faa_aircraft_reg_as_business_contact
		+ fcc.FCC_licenses_As_Business_Contact
		+ FBNV2.FBNV2_As_Business_contact
		+ Gaming_Licenses.As_Business_Contact().NJ
		+ govdata.FL_FBN_As_Business_Contact
		+ govdata.FL_Non_Profit_As_Business_Contact
		+ govdata.Gov_Phones_As_Business_Contact()
		+ govdata.IA_Sales_Tax_As_Business_Contact
		+ govdata.IRS_Non_Profit_As_Business_Contact
		+ govdata.MS_Workers_As_Business_Contact
		+ govdata.SEC_Broker_Dealer_As_Business_Contact
		+ infousa.ABIUS_Executive_As_Business_Contact
		+ infousa.DEADCO_As_Business_Contact
		+ infousa.IDEXEC_As_Business_Contact
		+ IRS5500.IRS5500_As_Business_Contact
		//+ Jigsaw.As_Business_Contact().Jigsaw				//Removing due to the contractual restrictions, as per Jason.
		+ Liquor_Licenses.As_Business_Contact.CA
		+ Liquor_Licenses.As_Business_Contact.CT
		+ Liquor_Licenses.As_Business_Contact.IN
		+ Liquor_Licenses.As_Business_Contact.LA
		+ Liquor_Licenses.As_Business_Contact.OH
		+ Liquor_Licenses.As_Business_Contact.PA
		+ Liquor_Licenses.As_Business_Contact.TX
		+ ln_propertyv2.LN_Propertyv2_as_Business_Contact()
		//+ lobbyists.Cleaned_Lobbyists_As_Business_Contact    //Not being updated, and the base file is missing. So, removing the code since the data already exists in the Business header file.
		+ Martindale_Hubbell.As_Business_Contact().Individuals
		+ Prof_License.Prof_License_As_Business_Contact()
		+ RedBooks.As_Business_Contact()
		+ SDA_SDAA.SDA_SDAA_As_Business_contact
		+ Sheila_Greco.As_Business_Contact.Contacts
		+ Spoke.As_Business.Contact
		+ TXBUS.Cleaned_TXBUS_As_Business_Contact
		+ Vickers.Vickers_As_Business_Contact
		+ Wither_and_Die.Wither_and_Die_as_Business_Contact
		+ zoom.Zoom_As_Business_Contact 
		;

end;