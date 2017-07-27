#workunit('name','Foreclosure Keys');

sequential(Property.Out_Moxie_Foreclosure_Keys,Parallel(Property.DKC_Foreclosure_Keys,Property.Query_Foreclosure_DID_Stats));
