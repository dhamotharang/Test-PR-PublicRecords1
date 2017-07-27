import business_header;
export PersistNames
 :=
module

	shared Root := business_header._dataset().thor_cluster_Persists + 'persist::Govdata::';
	
	export AsBusinessHeader :=
	module
	
		export CA_Sales_Tax				:= Root + 'CA_Sales_Tax_As_Business_Header'			;
		export FDIC								:= Root + 'FDIC_As_Business_Header'							;
		export FL_FBN							:= Root + 'FL_FBN_As_Business_Header'						;
		export FL_Non_Profit			:= Root + 'FL_Non_Profit_As_Business_Header'		;
		export Gov_Phones					:= Root + 'Gov_Phones_As_Business_Header'				;
		export IA_Sales_Tax				:= Root + 'IA_Sales_Tax_As_Business_Header'			;
		export IRS_Non_Profit			:= Root + 'IRS_Non_Profit_As_Business_Header'		;
		export MEWA								:= Root + 'MEWA_As_Business_Header'							;
		export MS_Workers					:= Root + 'MS_Workers_As_Business_Header'				;
		export OR_Workers					:= Root + 'OR_Workers_As_Business_Header'				;
		export SEC_Broker_Dealer	:= Root + 'SEC_Broker_Dealer_As_Business_Header';
	
	end;
	
	export AsBusinessLinking :=
	module
	
		export CA_Sales_Tax				:= Root + 'CA_Sales_Tax_As_Business_Linking'			;
		export FDIC         			:= Root + 'FDIC_As_Business_Linking'          		;
		export IRS_Non_Profit			:= Root + 'IRS_Non_Profit_As_Business_Linking'		;
		
	end;
	
	export AsBusinessContact :=
	module
	
		export CA_Sales_Tax				:= Root + 'CA_Sales_Tax_As_Business_Contact'			;
		export FL_FBN							:= Root + 'FL_FBN_As_Business_Contact'						;
		export FL_Non_Profit			:= Root + 'FL_Non_Profit_As_Business_Contact'			;
		export Gov_Phones					:= Root + 'Gov_Phones_As_Business_Contact'				;
		export IA_Sales_Tax				:= Root + 'IA_Sales_Tax_As_Business_Contact'			;
		export IRS_Non_Profit			:= Root + 'IRS_Non_Profit_As_Business_Contact'		;
		export MEWA								:= Root + 'MEWA_As_Business_Contact'							;
		export MS_Workers					:= Root + 'MS_Workers_As_Business_Contact'				;
		export SEC_Broker_Dealer	:= Root + 'SEC_Broker_Dealer_As_Business_Contact'	;

	end;

end;