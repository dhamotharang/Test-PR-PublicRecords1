IMPORT ut, Data_Services;
foreclosurein := dataset(Data_Services.foreign_prod+'thor_data400::in::foreclosure', property.Layout_Foreclosure_In, THOR);
// foreclosurein := property.Foreclosure_Clean_AID;

layoutForeclosureSec := record
	unsigned8 sequence := 0;
	Layout_Fares_Foreclosure_v2;
	
end;
ds_init := project (foreclosureIn, layoutForeclosureSec);

ut.MAC_Sequence_Records (ds_init, sequence, ds_sequenced);

export File_Foreclosure_In := ds_sequenced;