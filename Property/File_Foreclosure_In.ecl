IMPORT ut, Data_Services, dx_Property;
foreclosurein := dataset(Data_Services.foreign_prod+'thor_data400::in::foreclosure', property.Layout_Foreclosure_In, THOR);
// foreclosurein := property.Foreclosure_Clean_AID;

layoutForeclosureSec := record
	unsigned8 sequence := 0;
	dx_Property.Layout_Fares_Foreclosure_v2;	
end;
ds_init := project (foreclosureIn, TRANSFORM(layoutForeclosureSec, SELF := LEFT; SELF := []));

//Removing BK as not needed for the CL build since it is appended at the end of the build
CLOnly	:= ds_init(source NOT IN ['B7','I5']);

ut.MAC_Sequence_Records (CLOnly, sequence, ds_sequenced);

export File_Foreclosure_In := ds_sequenced;