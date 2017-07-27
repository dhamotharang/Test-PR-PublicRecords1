import riskwise, risk_indicators;

export Layout_BocaShell_BtSt_Out := record
	layout_boca_Shell Bill_To_Out;
	layout_boca_Shell Ship_To_Out;
	layout_eddo eddo ;
	riskwise.Layout_IP2O ip2o ;
	boolean isShipToBillToDifferent;
	risk_indicators.Layout_BocaShell_BtSt.Btst_Fields              
end;
