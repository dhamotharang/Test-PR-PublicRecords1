IMPORT _Control;

EXPORT Proc_Build_iBehavior_Keys(STRING pIndexVersion) := FUNCTION

	rKeyiBehavior__did := RECORD
		unsigned8 persistent_record_id;
		string10	IB_Individual_ID;
		string10	IB_Household_ID;
		unsigned8 DID;
		string5		title;
		string20	fname;
		string20	mname;
		string20	lname;
		string5		name_suffix;
		string10  prim_range;
		string2  	predir;
		string28  prim_name;
		string4   addr_suffix;
		string2   postdir;
		string10  unit_desig;
		string8   sec_range;
		string25  p_city_name;
		string2   st;
		string5   zip5;
		string4   zip4;
		string4   cart;
		string5 	county;
		string10  geo_lat;
		string11  geo_long;
		string7   geo_blk;
		string4   err_stat;
		string10	phone_1;
		string10	phone_2;
		string8		date_first_seen;
		string8		date_last_seen;
		unsigned8 __internal_fpos__;
	END;

	rKeyibehavior__purchase_behavior := RECORD
			unsigned8 persistent_record_id;
			string10	IB_Individual_ID;
			string8		First_Order_Date;
			string8		Last_Order_Date;
			string8		First_Online_Order_Date;
			string8		Last_Online_Order_Date;
			string8		First_Offline_Order_Date;
			string8		Last_Offline_Order_Date;
			string8		First_Retail_Order_Date;
			string8		Last_Retail_Order_Date;
			string3		number_of_sources;
			string4		Total_Number_of_Orders;
			string9		Total_Dollars;
			string4		Online_Orders;
			string9		Online_Dollars;
			string4		Offline_Orders;
			string9		Offline_Dollars;
			string4		Retail_Orders;
			string9		Retail_Dollars;
			string4		Average_Days_Between_Orders;
			string4		Average_Days_Between_Online_Orders;
			string4		Average_Days_Between_Offline_Orders;
			string4		Average_Days_Between_Retail_Orders;
			string9		Average_Amount_Per_Order;
			string9		Online_Average_Amount_Per_Order;
			string9		Offline_Average_Amount_Per_Order;
			string9		Retail_Average_Amount_Per_Order;
			string4		Online_Orders_Under_50_Range;
			string4		Online_Orders_50_to_99_dot_99_Range;
			string4		Online_Orders_100_to_249_dot_99_Range;
			string4		Online_Orders_250_to_499_dot_99_Range;
			string4		Online_Orders_500_to_999_dot_99_Range;
			string4		Online_Orders_1000_plus_Range;
			string4		Offline_Orders_Under_50_Range;
			string4		Offline_Orders_50_to_99_dot_99_Range;
			string4		Offline_Orders_100_to_249_dot_99_Range;
			string4		Offline_Orders_250_to_499_dot_99_Range;
			string4		Offline_Orders_500_to_999_dot_99_Range;
			string4		Offline_Orders_1000_plus_Range;
			string4		Retail_Orders_Under_50_Range;
			string4		Retail_Orders_50_to_99_dot_99_Range;
			string4		Retail_Orders_100_to_249_dot_99_Range;
			string4		Retail_Orders_250_to_499_dot_99_Range;
			string4		Retail_Orders_500_to_999_dot_99_Range;
			string4		Retail_Orders_1000_plus_Range;
			string8		date_first_seen;
			string8		date_last_seen;
			unsigned8 __internal_fpos__;
	END;
		
	
	ds_did      						:= DATASET([], rKeyiBehavior__did);
	ds_purchase_behavior  	:= DATASET([], rKeyiBehavior__purchase_behavior);

  KeyIBehavior__did      						:= INDEX(ds_did, {did}, {ds_did}, '~prte::key::ibehavior_consumer::' + pIndexVersion + '::did');	
  KeyIBehavior__purchase_behavior  	:= INDEX(ds_purchase_behavior,{IB_Individual_ID},{ds_purchase_behavior}, '~prte::key::ibehavior_behavior::' + pIndexVersion + '::purchase_behavior');	
  
//fcra keys
	KeyIBehavior__did_fcra      					:= INDEX(ds_did, {did}, {ds_did}, '~prte::key::fcra::ibehavior_consumer::' + pIndexVersion + '::did');	
  KeyIBehavior__purchase_behavior_fcra  := INDEX(ds_purchase_behavior,{IB_Individual_ID},{ds_purchase_behavior}, '~prte::key::fcra::ibehavior_behavior::' + pIndexVersion + '::purchase_behavior');	
  
  
	RETURN SEQUENTIAL(PARALLEL(BUILD(KeyIBehavior__did, update),
														 BUILD(KeyIBehavior__purchase_behavior, update),
														 BUILD(KeyIBehavior__did_fcra, update),
														 BUILD(KeyIBehavior__purchase_behavior_fcra, update)
														 ),
															PRTE.UpdateVersion('iBehaviorKeys', //	Package name
														  pIndexVersion,											 //	Package version
															'terri.hardy-george@lexisnexis.com;anantha.venkatachalam@lexisnexis.com', //	Who to email with specifics
															'B',																 //	B = Boca, A = Alpharetta
															'N',																 //	N = Non-FCRA, F = FCRA
															'N'																 //	N = Do not also include boolean, Y = Include boolean, too
															  ),
														 
														 PRTE.UpdateVersion('FCRA_iBehaviorKeys', //	Package name
												     pIndexVersion,											 //	Package version
      									    'terri.hardy-george@lexisnexis.com;anantha.venkatachalam@lexisnexis.com', //	Who to email with specifics
			  								     'B',																 //	B = Boca, A = Alpharetta
												     'F',																 //	N = Non-FCRA, F = FCRA
												     'N'																 //	N = Do not also include boolean, Y = Include boolean, too
																		  )
									 );
END;


