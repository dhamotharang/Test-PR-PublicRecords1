export Constants := Module;

 // Insurance Header SRC values
 export Current_Carrier_Data 		:= 'IVS'; //Insurance Verification Services 
 export Clue_Auto_Data			 		:= 'ICA';
 export Clue_Property_Data	 		:= 'ICP';
 export Commercial_Claims_Data 	:= 'ICC'; 
 export NC_DMV_Data					 		:= 'INC'; // North Carolina DMV Data
 export KS_DMV_Data							:= 'IKS'; // Kensas DMV Data
 export NM_DMV_Data 						:= 'INM'; // New Mexico DMV Data

 export EQ_Business_Class_Data 	:= 'IEQ'; // Equifax Business Class file
 
 export Boca_Header_Records			:= 'ADL';
 export Boca_Business_Records   := 'BDL';
 
 shared ds_src := DATASET([{Current_Carrier_Data},	{Clue_Auto_Data},	{Clue_Property_Data},
													 {NC_DMV_Data}, {KS_DMV_Data}, {NM_DMV_Data}, 
													 {Boca_Header_Records}],{STRING SourceType});
													 
 export Set_InsuranceHeader_Src := set(ds_src, SourceType);
end;
 

