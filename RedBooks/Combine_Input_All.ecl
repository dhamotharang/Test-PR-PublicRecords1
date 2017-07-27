export Combine_Input_All := 

DISTRIBUTE((Combine_Input_IAD_Advertiser.Combined_Input +
            Combine_Input_IAD_Agency.Combined_Input +
            Combine_Input_IAG.Combined_Input +
            Combine_Input_ISDA_Advertiser.Combined_Input + 
            Combine_Input_ISDA_Agency.Combined_Input+ 
            Combine_Input_ISDAA_Advertiser.Combined_Input),
			HASH(Key_fields.DocID, name,executives.ExecutiveName)): persist('persist::RedBooks::Combined_Input');
                                                
