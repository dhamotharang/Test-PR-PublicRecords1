IMPORT bipv2, govdata;

export Files := module

	//In files
	EXPORT FDIC_In := DATASET(Constants.FDIC_In, Layouts.FDIC_In_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	EXPORT IRS_In := DATASET(Constants.IRS_In, Layouts.IRS_In_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	EXPORT Salestax_CA_In := DATASET(Constants.Salestax_CA_In, Layouts.SalesTax_CA_In_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	EXPORT Salestax_IA_In := DATASET(Constants.Salestax_IA_In, Layouts.SalesTax_IA_In_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
	EXPORT Sec_Broker_In := DATASET(Constants.Sec_Broker_In, Layouts.Sec_Broker_In_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

	//Base files
	EXPORT FDIC_Base				:= DATASET(Constants.FDIC_Base_Name, 				Layouts.FDIC_Base_Layout, 							FLAT);
	EXPORT IRS_Base					:= DATASET(Constants.IRS_Base_Name, 				Layouts.IRS_NonProfit_Base_Layout, 			FLAT);
	EXPORT Salestax_CA_Base	:= DATASET(Constants.Salestax_CA_Base_Name, Layouts.CA_Sales_Tax_Base_Layout,				FLAT);
	EXPORT Salestax_IA_Base	:= DATASET(Constants.Salestax_IA_Base_Name, Layouts.IA_Sales_Tax_Base_Layout, 			FLAT);
	EXPORT Sec_Broker_Base	:= DATASET(Constants.Sec_Broker_Base_Name, 	Layouts.SEC_Broker_Dealer_Base_Layout, 	FLAT);

	//Key files
	EXPORT Key_Salestax_CA_Bdid 	:= PROJECT(Salestax_CA_Base(bdid != 0), TRANSFORM(govdata.Layout_CA_Sales_Tax-BIPV2.IDlayouts.l_xlink_ids-source_rec_id, SELF := LEFT, SELF := []));
	EXPORT Key_Salestax_CA_Linkids 	:= PROJECT(Salestax_CA_Base, 			TRANSFORM(govdata.Layout_CA_Sales_Tax, 											 SELF := LEFT, SELF := []));
	
	EXPORT Key_FDIC_Bdid 	:= PROJECT(FDIC_Base(bdid != 0), TRANSFORM(govdata.layout_FDIC_BDID, 		SELF := LEFT, SELF := []));
	EXPORT Key_FDIC_Linkids := PROJECT(FDIC_Base, 		  	 TRANSFORM(govdata.Layouts_FDIC.Base_AID, 	SELF := LEFT, SELF := []));

	EXPORT Key_Salestax_IA_In 		:= fBase_To_In_Layout(Salestax_IA_Base);
	EXPORT Key_Salestax_IA_Bdid 	:= PROJECT(Key_Salestax_IA_In(bdid != 0), TRANSFORM(govdata.Layout_IA_Sales_Tax_In-BIPV2.IDlayouts.l_xlink_ids, SELF := LEFT,SELF := []));
	EXPORT Key_Salestax_IA_Linkids  := PROJECT(Key_Salestax_IA_In, 			TRANSFORM(govdata.Layout_IA_Sales_Tax_In, 					  SELF := LEFT, SELF := []));

	EXPORT Key_Irsnonprofit_Bdid 	:= PROJECT(IRS_Base(bdid != 0), TRANSFORM(govdata.Layout_IRS_NonProfit_Base-[exempt_org_status_code], 		SELF := LEFT, SELF := []));
	EXPORT Key_Irsnonprofit_Linkids	:= PROJECT(IRS_Base, 			TRANSFORM(govdata.Layouts_IRS_NonProfit.Base_AID-[exempt_org_status_code],	SELF := LEFT, SELF := []));

	EXPORT Key_ms_workers_comp_Bdid		:= DATASET([],govdata.Layout_MS_Workers_Comp_base-BIPV2.IDlayouts.l_xlink_ids);
	EXPORT Key_ms_workers_comp_Linkids	:= DATASET([],govdata.Layout_MS_Workers_Comp_base);
	
	EXPORT Key_or_workers_comp_Bdid		:= DATASET([],govdata.Layout_OR_Workers_Comp_Base-BIPV2.IDlayouts.l_xlink_ids);
	EXPORT Key_or_workers_comp_Linkids	:= DATASET([],govdata.Layout_OR_Workers_Comp_Base);
	
	EXPORT Key_sec_broker_dealer_Bdid 	 := PROJECT(Sec_Broker_Base(bdid != 0), TRANSFORM(govdata.layout_sec_broker_dealer_BDID-BIPV2.IDlayouts.l_xlink_IDs, SELF := LEFT, SELF := []));
	EXPORT Key_sec_broker_dealer_Linkids := PROJECT(Sec_Broker_Base,			TRANSFORM(govdata.layout_sec_broker_dealer_BDID, 							 SELF := LEFT, SELF := []));

END;