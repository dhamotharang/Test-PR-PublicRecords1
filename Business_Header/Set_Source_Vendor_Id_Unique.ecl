import mdr;
// The following source types are considered to have a unique vendor_id which is persistent from
// build to build.  Otherwise is is assumed the vendor_id could change in the source from build
// to build
export Set_Source_Vendor_Id_Unique := 
		MDR.sourceTools.set_AK_Busreg								// license number
	+ MDR.sourceTools.set_Atf											// license number
	+ MDR.sourceTools.set_Bk											
	+ MDR.sourceTools.set_CorpV2
	+ MDR.sourceTools.set_Credit_Unions
	+ MDR.sourceTools.set_DCA
	+ MDR.sourceTools.set_Dea											// dea registration number
	+ MDR.sourceTools.set_Dunn_Bradstreet					// duns number
	+ MDR.sourceTools.set_Dunn_Bradstreet_Fein		// duns number
	+ MDR.sourceTools.set_EBR											// FILE_NUMBER
	+ MDR.sourceTools.set_FDIC
	+ MDR.sourceTools.set_FL_Non_Profit
	+ MDR.sourceTools.set_Fbnv2
	+ MDR.sourceTools.set_IRS_5500
	+ MDR.sourceTools.set_IRS_Non_Profit
	+ MDR.sourceTools.set_Professional_License
	+ MDR.sourceTools.set_Property
	+ MDR.sourceTools.set_SEC_Broker_Dealer
	+ MDR.sourceTools.set_SKA
	+ MDR.sourceTools.set_State_Sales_Tax
	+ MDR.sourceTools.set_TXBUS
	+ MDR.sourceTools.set_UCCS
	+ MDR.sourceTools.set_Vickers
	+ MDR.sourceTools.set_ZOOM
	;