import Gateway;

export Velocity_IParam :=
module

	export	Options	:=
	interface
		export	boolean	IndustryKBA		:=	false;
		export	boolean	EdataVelocity	:=	false;
	end;
	
	export	Gateway	:=
	interface(Options)
		export DATASET (Gateway.Layouts.Config) Gateway_cfg;
		// export	string150	GatewayURL;
	end;
	
	export	SearchRecords	:=
	interface(Gateway)
		export	unsigned6	UniqueID	:=	0;
		export	string50	Industry;
		export	string100	Product;
		export	string10	RetroDate;
		export	integer   DateRange  := 0;
  end;
	
end;