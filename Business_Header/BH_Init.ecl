IMPORT Gong, YellowPages, Corp, DNB, UCC, Bankrupt, FBN, BusReg, Edgar, IRS5500, govdata, Vickers, Prof_License, Busdata, wither_and_die, faa, atf, property, dca, lobbyists, fcc, experian_business_reports, infousa, fictitious_business_names, vehlic, watercraft, ln_property, bbb, ebr, bbb2;


BH_Combined := Gong.Gong_As_Business_Header +
               YellowPages.YellowPages_As_Business_Header +
               Corp.Corp_As_Business_Header +
               DNB.DNB_As_Business_Header +
               UCC.UCC_Party_As_Business_Header +
               Bankrupt.Bankrupt_As_Business_Header +
			   Bankrupt.Liens_As_Business_Header +
               BusReg.BusReg_As_Business_Header +
               Edgar.Edgar_As_Business_Header +
               IRS5500.IRS5500_As_Business_Header +
			   govdata.Gov_Phones_As_Business_Header +
               govdata.CA_Sales_Tax_As_Business_Header +
               govdata.FDIC_As_Business_Header +
               govdata.SEC_Broker_Dealer_As_Business_Header +
			   govdata.FL_Non_Profit_As_Business_Header +
			   govdata.MS_Workers_As_Business_Header +
			   govdata.OR_Workers_As_Business_Header +
			   govdata.IRS_Non_Profit_As_Business_Header +
			   govdata.IA_Sales_Tax_As_Business_Header +
			   Vickers.Vickers_As_Business_Header + 
			   Prof_License.Prof_License_As_Business_Header +
			   govdata.FL_FBN_As_Business_Header + 
			   govdata.DEA_As_Business_Header +
			   busdata.Accurint_Tradeshow_As_Business_Header +
			   busdata.SKA_As_Business_Header +
			   busdata.Credit_Unions_As_Business_Header +
			   wither_and_die.Wither_and_Die_as_Business_Header +
			   faa.faa_aircraft_reg_as_business_header +
			   atf.ATF_as_Business_Header +
//			   property.property_as_business_header +
			   dca.DCA_as_Business_Header +
			   lobbyists.Cleaned_Lobbyists_As_Business_Header +
			   dnb.DNB_FEIN_As_Business_Header +
			   fcc.FCC_Licenses_As_Business_Header +
			   infousa.ABIUS_Company_As_Business_Header +
			   infousa.IDEXEC_As_Business_Header +
			   infousa.DEADCO_As_Business_Header + 
			   fictitious_business_names.FBN_as_Business_Header +
			   vehlic.Vehicle_as_Business_Header +
			   watercraft.Watercraft_as_Business_Header +
			   ln_property.LN_Property_as_Business_Header +
			   bbb2.BBB_As_Business_Header +
			   ebr.EBR_As_Business_Header;
	/* + govdata.MEWA_As_Business_Header*/

STRING name_chars := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

Layout_Business_Header ClearBadFEINs(Layout_Business_Header l) := TRANSFORM
SELF.fein := if(ValidFEIN(l.fein), l.fein, 0);  // Zero the FEIN if prefix is invalid
SELF := L;
END;

EXPORT BH_Init := PROJECT(BH_Combined(company_name <> '', StringLib.StringFilter(company_name, name_chars) <> '', not(source in ['AW'] and vendor_id[1..2] in ['OR'])),
                          ClearBadFEINs(LEFT)) : PERSIST('TEMP::BH_Init');