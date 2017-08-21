IMPORT ut;

// foreclosuresprayed := DATASET(cluster + 'in::foreclosure::using::fares_update', Layout_Foreclosure_Raw_Formatted, THOR);

// layoutForeclosureSec := record
	// unsigned8 sequence := 0;
	// Layout_Foreclosure_Raw_Formatted;
// end;
// ds_init := project (foreclosuresprayed, layoutForeclosureSec);

// ut.MAC_Sequence_Records (ds_init, sequence, ds_sequenced);

// export File_Foreclosure_Sprayed := ds_sequenced;

export File_Foreclosure_Sprayed :=	DATASET(thor_cluster + 'in::foreclosure::using::fares_update', Layout_Foreclosure_Raw_Formatted, THOR);