import ut;

export fn_append_puid(dataset(recordof(ibehavior.layout_behavior_search)) int0)
	:=
function

recordof(int0) t_append_puid(recordof(int0) pInput) := transform
self.persistent_record_id 	:= HASH64(TRIM(pInput.IB_Individual_ID)
																		+ TRIM(pInput.First_Order_Date)
																		+ TRIM(pInput.Last_Order_Date)
																		+ TRIM(pInput.First_Online_Order_Date)
																		+ TRIM(pInput.Last_Online_Order_Date)
																		+ TRIM(pInput.First_Offline_Order_Date)
																		+ TRIM(pInput.Last_Offline_Order_Date)
																		+ TRIM(pInput.First_Retail_Order_Date)
																		+ TRIM(pInput.Last_Retail_Order_Date)
																		+ TRIM(pInput.number_of_sources)
																		+ TRIM(pInput.Total_Number_of_Orders)
																		+ TRIM(pInput.Total_Dollars)
																		+ TRIM(pInput.Online_Orders)
																		+ TRIM(pInput.Online_Dollars)
																		+ TRIM(pInput.Offline_Orders)
																		+ TRIM(pInput.Offline_Dollars)
																		+ TRIM(pInput.Retail_Orders)
																		+ TRIM(pInput.Retail_Dollars)
																		+ TRIM(pInput.Average_Days_Between_Orders)
																		+ TRIM(pInput.Average_Days_Between_Online_Orders)
																		+ TRIM(pInput.Average_Days_Between_Offline_Orders)
																		+ TRIM(pInput.Average_Days_Between_Retail_Orders)
																		+ TRIM(pInput.Average_Amount_Per_Order)
																		+ TRIM(pInput.Online_Average_Amount_Per_Order)
																		+ TRIM(pInput.Offline_Average_Amount_Per_Order)
																		+ TRIM(pInput.Retail_Average_Amount_Per_Order)
																		+ TRIM(pInput.Online_Orders_Under_50_Range)
																		+ TRIM(pInput.Online_Orders_50_to_99_dot_99_Range)
																		+ TRIM(pInput.Online_Orders_100_to_249_dot_99_Range)
																		+ TRIM(pInput.Online_Orders_250_to_499_dot_99_Range)
																		+ TRIM(pInput.Online_Orders_500_to_999_dot_99_Range)
																		+ TRIM(pInput.Online_Orders_1000_plus_Range)
																		+ TRIM(pInput.Offline_Orders_Under_50_Range)
																		+ TRIM(pInput.Offline_Orders_50_to_99_dot_99_Range)
																		+ TRIM(pInput.Offline_Orders_100_to_249_dot_99_Range)
																		+ TRIM(pInput.Offline_Orders_250_to_499_dot_99_Range)
																		+ TRIM(pInput.Offline_Orders_500_to_999_dot_99_Range)
																		+ TRIM(pInput.Offline_Orders_1000_plus_Range)
																		+ TRIM(pInput.Retail_Orders_Under_50_Range)
																		+ TRIM(pInput.Retail_Orders_50_to_99_dot_99_Range)
																		+ TRIM(pInput.Retail_Orders_100_to_249_dot_99_Range)
																		+ TRIM(pInput.Retail_Orders_250_to_499_dot_99_Range)
																		+ TRIM(pInput.Retail_Orders_500_to_999_dot_99_Range)
																		+ TRIM(pInput.Retail_Orders_1000_plus_Range));											

		self								:=	pInput;
	END;
										

p_append_puid := project(int0,t_append_puid(left));

return p_append_puid;

end;
