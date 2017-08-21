import Inquiry_AccLogs, Data_Services, ut, doxie, Risk_Indicators;

layout_counts := record
	unsigned2 CountTotal;
	unsigned2 Count01;
	unsigned2 Count03;
	unsigned2 Count06;
	unsigned2 Count12;
	unsigned2 Count24;
	unsigned2 Count36;
	unsigned2 Count60;
end;

layout_final := record
	unsigned6 did;
	layout_counts Collection;
	layout_counts AccountOpen;
	layout_counts Other;
end;

filt := Inquiry_AccLogs.File_FCRA_Inquiry_Base(bus_intel.industry <> '' and  person_q.Appended_ADL > 0 );

layout_slim := record
	did          := filt.person_q.Appended_ADL;
	vertical     := StringLib.StringToUpperCase(filt.bus_intel.vertical);
	func         := StringLib.StringToUpperCase(filt.search_info.function_description);
	string8 date := filt.search_info.datetime[1..8];
end;

slim := table( filt, layout_slim );
dist := distribute( slim, did );


today := ut.getdate;
layout_final calc( dist le ) := TRANSFORM
	self.did := le.did;

	boolean isCollections := trim(le.vertical)='COLLECTIONS';
	boolean isAccountOpen := not isCollections and trim(le.func) in ['INSTANTID','FRAUDPOINT','FRAUDDEFENDER'];
	boolean isOther := not isCollections and not isAccountOpen;
	
	// date calculations as done in Risk_Indicators.iid_getHeader setting lnames_per_adl30, et al	
	days := ut.DaysApart( le.date, today );
	ageBucket := map(
		days <= 30  => 1,
		days <= 90  => 3,
		days <= 180 => 6,
		days <= Risk_Indicators.iid_constants.oneyear    => 12,
		days <= Risk_Indicators.iid_constants.twoyears   => 24,
		days <= Risk_Indicators.iid_constants.threeyears => 36,
		days <= Risk_Indicators.iid_constants.fiveyears  => 60,
		255 // anything older than five years
	);
	
	self.Collection.CountTotal := if( isCollections, 1, 0 );
	self.Collection.Count01 := if( isCollections and ageBucket <= 1,  1, 0 );
	self.Collection.Count03 := if( isCollections and ageBucket <= 3,  1, 0 );
	self.Collection.Count06 := if( isCollections and ageBucket <= 6,  1, 0 );
	self.Collection.Count12 := if( isCollections and ageBucket <= 12, 1, 0 );
	self.Collection.Count24 := if( isCollections and ageBucket <= 24, 1, 0 );
	self.Collection.Count36 := if( isCollections and ageBucket <= 36, 1, 0 );
	self.Collection.Count60 := if( isCollections and ageBucket <= 60, 1, 0 );

	self.AccountOpen.CountTotal := if( isAccountOpen, 1, 0 );
	self.AccountOpen.Count01 := if( isAccountOpen and ageBucket <= 1,  1, 0 );
	self.AccountOpen.Count03 := if( isAccountOpen and ageBucket <= 3,  1, 0 );
	self.AccountOpen.Count06 := if( isAccountOpen and ageBucket <= 6,  1, 0 );
	self.AccountOpen.Count12 := if( isAccountOpen and ageBucket <= 12, 1, 0 );
	self.AccountOpen.Count24 := if( isAccountOpen and ageBucket <= 24, 1, 0 );
	self.AccountOpen.Count36 := if( isAccountOpen and ageBucket <= 36, 1, 0 );
	self.AccountOpen.Count60 := if( isAccountOpen and ageBucket <= 60, 1, 0 );

	self.Other.CountTotal := if( isOther, 1, 0 );
	self.Other.Count01 := if( isOther and ageBucket <= 1,  1, 0 );
	self.Other.Count03 := if( isOther and ageBucket <= 3,  1, 0 );
	self.Other.Count06 := if( isOther and ageBucket <= 6,  1, 0 );
	self.Other.Count12 := if( isOther and ageBucket <= 12, 1, 0 );
	self.Other.Count24 := if( isOther and ageBucket <= 24, 1, 0 );
	self.Other.Count36 := if( isOther and ageBucket <= 36, 1, 0 );
	self.Other.Count60 := if( isOther and ageBucket <= 60, 1, 0 );
END;



calcd := project( dist, calc(left), local );

layout_final roll( layout_final le, layout_final ri ) := TRANSFORM
	self.did := le.did;
	
	self.Collection.CountTotal := le.Collection.CountTotal + ri.Collection.CountTotal;
	self.Collection.Count01 := le.Collection.Count01 + ri.Collection.Count01;
	self.Collection.Count03 := le.Collection.Count03 + ri.Collection.Count03;
	self.Collection.Count06 := le.Collection.Count06 + ri.Collection.Count06;
	self.Collection.Count12 := le.Collection.Count12 + ri.Collection.Count12;
	self.Collection.Count24 := le.Collection.Count24 + ri.Collection.Count24;
	self.Collection.Count36 := le.Collection.Count36 + ri.Collection.Count36;
	self.Collection.Count60 := le.Collection.Count60 + ri.Collection.Count60;

	self.AccountOpen.CountTotal := le.AccountOpen.CountTotal + ri.AccountOpen.CountTotal;
	self.AccountOpen.Count01 := le.AccountOpen.Count01 + ri.AccountOpen.Count01;
	self.AccountOpen.Count03 := le.AccountOpen.Count03 + ri.AccountOpen.Count03;
	self.AccountOpen.Count06 := le.AccountOpen.Count06 + ri.AccountOpen.Count06;
	self.AccountOpen.Count12 := le.AccountOpen.Count12 + ri.AccountOpen.Count12;
	self.AccountOpen.Count24 := le.AccountOpen.Count24 + ri.AccountOpen.Count24;
	self.AccountOpen.Count36 := le.AccountOpen.Count36 + ri.AccountOpen.Count36;
	self.AccountOpen.Count60 := le.AccountOpen.Count60 + ri.AccountOpen.Count60;

	self.Other.CountTotal := le.Other.CountTotal + ri.Other.CountTotal;
	self.Other.Count01 := le.Other.Count01 + ri.Other.Count01;
	self.Other.Count03 := le.Other.Count03 + ri.Other.Count03;
	self.Other.Count06 := le.Other.Count06 + ri.Other.Count06;
	self.Other.Count12 := le.Other.Count12 + ri.Other.Count12;
	self.Other.Count24 := le.Other.Count24 + ri.Other.Count24;
	self.Other.Count36 := le.Other.Count36 + ri.Other.Count36;
	self.Other.Count60 := le.Other.Count60 + ri.Other.Count60;
end;


s := sort( calcd, did, local );
rolled := rollup( s, roll(left,right), did, local );

export Key_FCRA_Inquiry_Table_DID := index( rolled, {did}, {rolled}, Data_Services.Data_Location.Prefix('Inquiry')+'thor10_231::key::fcra::inquiry_table_did_' + doxie.Version_SuperKey);