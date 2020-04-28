IMPORT	Gateway;

export	IParam	:=
module
  export Report := interface
		export	unsigned1	Product										:=	Constants.Product.DEFAULT;
		export	boolean		RunGateway_ERC						:=	false;
		export	string1		ReportType								:=	'';
		export	string3		ResultOption							:=	Constants.Default_Option;
		export	boolean		IncludeConfidenceFactors	:=	true;
		export 	dataset(Gateway.Layouts.Config) GatewayConfig	:= 	dataset([], Gateway.Layouts.Config);
  end;

	export	SearchRecords	:=	interface(
		Report
	)
	export boolean isHomeGateway;
		//? need to store certain clean address components (used in logging)
		export string60	addr;
		export string25	city;
		export string2	state;
		export string5	zip;
		
	end;

end;
