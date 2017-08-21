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
	,dca
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
	,gong_v2
	,govdata
	,infousa
	,irs5500
	,jigsaw
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

Output(Business_Research.hygiene(ACF.ACF_AS_Business_Header																).all_profiles				,named('profilesACF'												 ),all);
Output(Business_Research.hygiene(ak_busreg.As_Business().Header														).all_profiles				,named('profilesak_busreg'									 ),all);
Output(Business_Research.hygiene(AMIDIR.AMIDIR_As_Business_Header													).all_profiles				,named('profilesAMIDIR'											 ),all);
Output(Business_Research.hygiene(atf.ATF_as_Business_Header																).all_profiles				,named('profilesatf'                         ),all);
Output(Business_Research.hygiene(Bankruptcyv2.Bankruptv2_As_Business_Header 							).all_profiles				,named('profilesBankruptcyv2'                ),all);
Output(Business_Research.hygiene(Bankruptcy_Attorney_Trustee.Attorney_As_Business_Header	).all_profiles				,named('profilesBankruptcy_Attorney_Trustee' ),all);
Output(Business_Research.hygiene(bbb2.BBB_As_Business_Header															).all_profiles				,named('profilesbbb2'                        ),all);
Output(Business_Research.hygiene(busdata.Accurint_Tradeshow_As_Business_Header						).all_profiles				,named('profilesAccurint_Tradeshow'          ),all);
Output(Business_Research.hygiene(busdata.SKA_As_Business_Header														).all_profiles				,named('profilesSKA'                         ),all);
Output(Business_Research.hygiene(BusReg.BusReg_As_Business_Header().Busreg								).all_profiles				,named('profilesBusReg'                      ),all);
Output(Business_Research.hygiene(CALBUS.CALBUS_As_Business_Header													).all_profiles				,named('profilesCALBUS'                      ),all);
Output(Business_Research.hygiene(Corp2.As_Business_Header.corp														).all_profiles				,named('profilesCorp2'                       ),all);
Output(Business_Research.hygiene(Credit_Unions.as_business_header()												).all_profiles				,named('profilesCredit_Unions'               ),all);
Output(Business_Research.hygiene(dca.DCA_as_Business_Header																).all_profiles				,named('profilesdca'                         ),all);
Output(Business_Research.hygiene(DEA.DEA_As_Business_Header																).all_profiles				,named('profilesDEA'                         ),all);
Output(Business_Research.hygiene(DNB_dmi.As_Business_Header()															).all_profiles				,named('profilesDNB_dmi'                     ),all);
Output(Business_Research.hygiene(DNB_FEINV2.As_Business_Header.DnbFeinV2									).all_profiles				,named('profilesDNB_FEINV2'                  ),all);
Output(Business_Research.hygiene(ebr.EBR_As_Business_Header																).all_profiles				,named('profilesebr'                         ),all);
Output(Business_Research.hygiene(Edgar.Edgar_As_Business_Header														).all_profiles				,named('profilesEdgar'                       ),all);
Output(Business_Research.hygiene(faa.faa_aircraft_reg_as_business_header									).all_profiles				,named('profilesfaa'                         ),all);
Output(Business_Research.hygiene(fcc.FCC_Licenses_As_Business_Header											).all_profiles				,named('profilesfcc'                         ),all);
Output(Business_Research.hygiene(FBNV2.FBNV2_As_Business_Header														).all_profiles				,named('profilesFBNV2'                       ),all);
Output(Business_Research.hygiene(Gaming_Licenses.As_Business_Header().NJ									).all_profiles				,named('profilesGaming_Licenses_NJ'          ),all);
Output(Business_Research.hygiene(Gong_v2.As_Business_Header().GongV2											).all_profiles				,named('profilesGong_v2'                     ),all);
Output(Business_Research.hygiene(govdata.FDIC_As_Business_Header													).all_profiles				,named('profilesFDIC'                        ),all);
Output(Business_Research.hygiene(govdata.FL_FBN_As_Business_Header												).all_profiles				,named('profilesFL_FBN'                      ),all);
Output(Business_Research.hygiene(govdata.FL_Non_Profit_As_Business_Header									).all_profiles				,named('profilesFL_Non_Profit'               ),all);
Output(Business_Research.hygiene(govdata.Gov_Phones_As_Business_Header()									).all_profiles				,named('profilesGov_Phones'                  ),all);
Output(Business_Research.hygiene(govdata.IA_Sales_Tax_As_Business_Header									).all_profiles				,named('profilesIA_Sales_Tax'                ),all);
Output(Business_Research.hygiene(govdata.IRS_Non_Profit_As_Business_Header								).all_profiles				,named('profilesIRS_Non_Profit'              ),all);
Output(Business_Research.hygiene(govdata.MS_Workers_As_Business_Header										).all_profiles				,named('profilesMS_Workers'                  ),all);
Output(Business_Research.hygiene(govdata.OR_Workers_As_Business_Header										).all_profiles				,named('profilesOR_Workers'	                 ),all);
Output(Business_Research.hygiene(govdata.SEC_Broker_Dealer_As_Business_Header							).all_profiles				,named('profilesSEC_Broker_Dealer'           ),all);
Output(Business_Research.hygiene(infousa.ABIUS_Company_As_Business_Header									).all_profiles				,named('profilesinfousa_ABIUS'               ),all);
Output(Business_Research.hygiene(infousa.DEADCO_As_Business_Header												).all_profiles				,named('profilesinfousa_DEADCO'              ),all);
Output(Business_Research.hygiene(infousa.IDEXEC_As_Business_Header												).all_profiles				,named('profilesinfousa_IDEXEC'              ),all);
Output(Business_Research.hygiene(IRS5500.IRS5500_As_Business_Header												).all_profiles				,named('profilesIRS5500'                     ),all);
Output(Business_Research.hygiene(Jigsaw.As_Business_Header().Jigsaw												).all_profiles				,named('profilesJigsaw'                      ),all);
Output(Business_Research.hygiene(LiensV2.LiensV2_As_Business_Header												).all_profiles				,named('profilesLiensV2'                     ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.CA										).all_profiles				,named('profilesLiquor_Licenses_CA'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.CT										).all_profiles				,named('profilesLiquor_Licenses_CT'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.IN										).all_profiles				,named('profilesLiquor_Licenses_IN'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.LA										).all_profiles				,named('profilesLiquor_Licenses_LA'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.OH										).all_profiles				,named('profilesLiquor_Licenses_OH'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.PA										).all_profiles				,named('profilesLiquor_Licenses_PA'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.TX										).all_profiles				,named('profilesLiquor_Licenses_TX'          ),all);
Output(Business_Research.hygiene(ln_propertyv2.LN_Propertyv2_as_Business_Header()					).all_profiles				,named('profilesln_propertyv2'               ),all);
Output(Business_Research.hygiene(lobbyists.Cleaned_Lobbyists_As_Business_Header						).all_profiles				,named('profileslobbyists'                   ),all);
Output(Business_Research.hygiene(martindale_hubbell.As_Business_Header().Organizations		).all_profiles				,named('profilesmartindale_hubbell'          ),all);
Output(Business_Research.hygiene(OSHAIR.OSHAIR_Inspection_As_Business_Header							).all_profiles				,named('profilesOSHAIR'                      ),all);
Output(Business_Research.hygiene(Prof_License.Prof_License_As_Business_Header()						).all_profiles				,named('profilesProf_License'                ),all);
Output(Business_Research.hygiene(RedBooks.As_Business_Header()														).all_profiles				,named('profilesRedBooks'                    ),all);
Output(Business_Research.hygiene(SDA_SDAA.SDA_SDAA_AS_Business_Header											).all_profiles				,named('profilesSDA_SDAA'                    ),all);
Output(Business_Research.hygiene(Sheila_Greco.As_Business_Header.Companies								).all_profiles				,named('profilesSheila_Greco'                ),all);
Output(Business_Research.hygiene(Spoke.As_Business.Header																	).all_profiles				,named('profilesSpoke'                       ),all);
Output(Business_Research.hygiene(TXBUS.Cleaned_TXBUS_As_Business_Header										).all_profiles				,named('profilesTXBUS'                       ),all);
Output(Business_Research.hygiene(UCCV2.UCCV2_As_Business_Header()													).all_profiles				,named('profilesUCCV2'                       ),all);
Output(Business_Research.hygiene(UtilFile.As_Business_Header()														).all_profiles				,named('profilesUtilFile'                    ),all);
Output(Business_Research.hygiene(Vickers.Vickers_As_Business_Header												).all_profiles				,named('profilesVickers'                     ),all);
Output(Business_Research.hygiene(watercraft.Watercraft_as_Business_Header()								).all_profiles				,named('profileswatercraft'                  ),all);
Output(Business_Research.hygiene(wither_and_die.Wither_and_Die_as_Business_Header					).all_profiles				,named('profileswither_and_die'              ),all);
Output(Business_Research.hygiene(YellowPages.YellowPages_As_Business_Header								).all_profiles				,named('profilesYellowPages'                 ),all);
Output(Business_Research.hygiene(Zoom.Zoom_As_Business_Header															).all_profiles				,named('profilesZoom'												 ),all);


Output(Business_Research.hygiene(ACF.ACF_AS_Business_Header																).Summary('Report')	,named('SummaryACF'												  ),all);
Output(Business_Research.hygiene(ak_busreg.As_Business().Header														).Summary('Report')	,named('Summaryak_busreg'									  ),all);
Output(Business_Research.hygiene(AMIDIR.AMIDIR_As_Business_Header													).Summary('Report')	,named('SummaryAMIDIR'											),all);
Output(Business_Research.hygiene(atf.ATF_as_Business_Header																).Summary('Report')	,named('Summaryatf'                         ),all);
Output(Business_Research.hygiene(Bankruptcyv2.Bankruptv2_As_Business_Header 							).Summary('Report')	,named('SummaryBankruptcyv2'                ),all);
Output(Business_Research.hygiene(Bankruptcy_Attorney_Trustee.Attorney_As_Business_Header	).Summary('Report')	,named('SummaryBankruptcy_Attorney_Trustee' ),all);
Output(Business_Research.hygiene(bbb2.BBB_As_Business_Header															).Summary('Report')	,named('Summarybbb2'                        ),all);
Output(Business_Research.hygiene(busdata.Accurint_Tradeshow_As_Business_Header						).Summary('Report')	,named('SummaryAccurint_Tradeshow'          ),all);
Output(Business_Research.hygiene(busdata.SKA_As_Business_Header														).Summary('Report')	,named('SummarySKA'                         ),all);
Output(Business_Research.hygiene(BusReg.BusReg_As_Business_Header().Busreg								).Summary('Report')	,named('SummaryBusReg'                      ),all);
Output(Business_Research.hygiene(CALBUS.CALBUS_As_Business_Header													).Summary('Report')	,named('SummaryCALBUS'                      ),all);
Output(Business_Research.hygiene(Corp2.As_Business_Header.corp														).Summary('Report')	,named('SummaryCorp2'                       ),all);
Output(Business_Research.hygiene(Credit_Unions.as_business_header()												).Summary('Report')	,named('SummaryCredit_Unions'               ),all);
Output(Business_Research.hygiene(dca.DCA_as_Business_Header																).Summary('Report')	,named('Summarydca'                         ),all);
Output(Business_Research.hygiene(DEA.DEA_As_Business_Header																).Summary('Report')	,named('SummaryDEA'                         ),all);
Output(Business_Research.hygiene(DNB_dmi.As_Business_Header()															).Summary('Report')	,named('SummaryDNB_dmi'                     ),all);
Output(Business_Research.hygiene(DNB_FEINV2.As_Business_Header.DnbFeinV2									).Summary('Report')	,named('SummaryDNB_FEINV2'                  ),all);
Output(Business_Research.hygiene(ebr.EBR_As_Business_Header																).Summary('Report')	,named('Summaryebr'                         ),all);
Output(Business_Research.hygiene(Edgar.Edgar_As_Business_Header														).Summary('Report')	,named('SummaryEdgar'                       ),all);
Output(Business_Research.hygiene(faa.faa_aircraft_reg_as_business_header									).Summary('Report')	,named('Summaryfaa'                         ),all);
Output(Business_Research.hygiene(fcc.FCC_Licenses_As_Business_Header											).Summary('Report')	,named('Summaryfcc'                         ),all);
Output(Business_Research.hygiene(FBNV2.FBNV2_As_Business_Header														).Summary('Report')	,named('SummaryFBNV2'                       ),all);
Output(Business_Research.hygiene(Gaming_Licenses.As_Business_Header().NJ									).Summary('Report')	,named('SummaryGaming_Licenses_NJ'          ),all);
Output(Business_Research.hygiene(Gong_v2.As_Business_Header().GongV2											).Summary('Report')	,named('SummaryGong_v2'                     ),all);
Output(Business_Research.hygiene(govdata.FDIC_As_Business_Header													).Summary('Report')	,named('SummaryFDIC'                        ),all);
Output(Business_Research.hygiene(govdata.FL_FBN_As_Business_Header												).Summary('Report')	,named('SummaryFL_FBN'                      ),all);
Output(Business_Research.hygiene(govdata.FL_Non_Profit_As_Business_Header									).Summary('Report')	,named('SummaryFL_Non_Profit'               ),all);
Output(Business_Research.hygiene(govdata.Gov_Phones_As_Business_Header()									).Summary('Report')	,named('SummaryGov_Phones'                  ),all);
Output(Business_Research.hygiene(govdata.IA_Sales_Tax_As_Business_Header									).Summary('Report')	,named('SummaryIA_Sales_Tax'                ),all);
Output(Business_Research.hygiene(govdata.IRS_Non_Profit_As_Business_Header								).Summary('Report')	,named('SummaryIRS_Non_Profit'              ),all);
Output(Business_Research.hygiene(govdata.MS_Workers_As_Business_Header										).Summary('Report')	,named('SummaryMS_Workers'                  ),all);
Output(Business_Research.hygiene(govdata.OR_Workers_As_Business_Header										).Summary('Report')	,named('SummaryOR_Workers'	                ),all);
Output(Business_Research.hygiene(govdata.SEC_Broker_Dealer_As_Business_Header							).Summary('Report')	,named('SummarySEC_Broker_Dealer'           ),all);
Output(Business_Research.hygiene(infousa.ABIUS_Company_As_Business_Header									).Summary('Report')	,named('Summaryinfousa_ABIUS'               ),all);
Output(Business_Research.hygiene(infousa.DEADCO_As_Business_Header												).Summary('Report')	,named('Summaryinfousa_DEADCO'              ),all);
Output(Business_Research.hygiene(infousa.IDEXEC_As_Business_Header												).Summary('Report')	,named('Summaryinfousa_IDEXEC'              ),all);
Output(Business_Research.hygiene(IRS5500.IRS5500_As_Business_Header												).Summary('Report')	,named('SummaryIRS5500'                     ),all);
Output(Business_Research.hygiene(Jigsaw.As_Business_Header().Jigsaw												).Summary('Report')	,named('SummaryJigsaw'                      ),all);
Output(Business_Research.hygiene(LiensV2.LiensV2_As_Business_Header												).Summary('Report')	,named('SummaryLiensV2'                     ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.CA										).Summary('Report')	,named('SummaryLiquor_Licenses_CA'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.CT										).Summary('Report')	,named('SummaryLiquor_Licenses_CT'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.IN										).Summary('Report')	,named('SummaryLiquor_Licenses_IN'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.LA										).Summary('Report')	,named('SummaryLiquor_Licenses_LA'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.OH										).Summary('Report')	,named('SummaryLiquor_Licenses_OH'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.PA										).Summary('Report')	,named('SummaryLiquor_Licenses_PA'          ),all);
Output(Business_Research.hygiene(Liquor_Licenses.As_Business_Header.TX										).Summary('Report')	,named('SummaryLiquor_Licenses_TX'          ),all);
Output(Business_Research.hygiene(ln_propertyv2.LN_Propertyv2_as_Business_Header()					).Summary('Report')	,named('Summaryln_propertyv2'               ),all);
Output(Business_Research.hygiene(lobbyists.Cleaned_Lobbyists_As_Business_Header						).Summary('Report')	,named('Summarylobbyists'                   ),all);
Output(Business_Research.hygiene(martindale_hubbell.As_Business_Header().Organizations		).Summary('Report')	,named('Summarymartindale_hubbell'          ),all);
Output(Business_Research.hygiene(OSHAIR.OSHAIR_Inspection_As_Business_Header							).Summary('Report')	,named('SummaryOSHAIR'                      ),all);
Output(Business_Research.hygiene(Prof_License.Prof_License_As_Business_Header()						).Summary('Report')	,named('SummaryProf_License'                ),all);
Output(Business_Research.hygiene(RedBooks.As_Business_Header()														).Summary('Report')	,named('SummaryRedBooks'                    ),all);
Output(Business_Research.hygiene(SDA_SDAA.SDA_SDAA_AS_Business_Header											).Summary('Report')	,named('SummarySDA_SDAA'                    ),all);
Output(Business_Research.hygiene(Sheila_Greco.As_Business_Header.Companies								).Summary('Report')	,named('SummarySheila_Greco'                ),all);
Output(Business_Research.hygiene(Spoke.As_Business.Header																	).Summary('Report')	,named('SummarySpoke'                       ),all);
Output(Business_Research.hygiene(TXBUS.Cleaned_TXBUS_As_Business_Header										).Summary('Report')	,named('SummaryTXBUS'                       ),all);
Output(Business_Research.hygiene(UCCV2.UCCV2_As_Business_Header()													).Summary('Report')	,named('SummaryUCCV2'                       ),all);
Output(Business_Research.hygiene(UtilFile.As_Business_Header()														).Summary('Report')	,named('SummaryUtilFile'                    ),all);
Output(Business_Research.hygiene(Vickers.Vickers_As_Business_Header												).Summary('Report')	,named('SummaryVickers'                     ),all);
Output(Business_Research.hygiene(watercraft.Watercraft_as_Business_Header()								).Summary('Report')	,named('Summarywatercraft'                  ),all);
Output(Business_Research.hygiene(wither_and_die.Wither_and_Die_as_Business_Header					).Summary('Report')	,named('Summarywither_and_die'              ),all);
Output(Business_Research.hygiene(YellowPages.YellowPages_As_Business_Header								).Summary('Report')	,named('SummaryYellowPages'                 ),all);
Output(Business_Research.hygiene(Zoom.Zoom_As_Business_Header															).Summary('Report')	,named('SummaryZoom'												),all);