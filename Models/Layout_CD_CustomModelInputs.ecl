EXPORT Layout_CD_CustomModelInputs := RECORD
	UNSIGNED8 seq := 0;

	// Best Buy - CDN1109_1_0
	STRING1 Ship_Mode_ := '';
	REAL8 Original_Total_Amount_ := 0;
	INTEGER8 Item_Lines_ := 0;
	STRING8 CVV_Description_ := '';
	STRING15 Payment_Type_ := '';
	STRING2 AVS_Code_ := '';
	STRING20 Device_Result_ := '';
	STRING20 True_IP_Region_ := '';
	STRING2 Browser_Language_ := '';
	STRING2 Proxy_Ip_Geo_ := '';
	STRING Reason_Code_ := '';
	INTEGER1 Time_Zone_Hours_ := 0;
	STRING2 True_Ip_Geo_ := '';
	REAL8 Policy_Score_ := 0;
	STRING2 Marked_For_Full_Name_H_ := '';
	STRING Entry_Type_ := '';
	STRING Line_Type_Header_ := '';
	STRING50 Paypal_Email_Address_ := '';
	/* ***** Not used in the model ***** */
	// STRING10 Line_LOS_ := '';
	// STRING10 Paypal_Ship_Address_Status_ := '';
	// STRING50 Delivery_Email_ := '';
	
	// Tiger Direct - CDN1305_1_0
	STRING2 TD_avs := '';	
	STRING2 TD_pay_method := '';	
	REAL    TD_product_dollars := 0;	
	STRING2 TD_ship_method := '';	
	
	
	// Tiger Direct - CDN1410_1_0
	REAL TD_day_velocity_threshold        := 0;
	REAL TD_week_velocity_threshold       := 0;
	
	
	// Future Custom Models with Custom Inputs
END;