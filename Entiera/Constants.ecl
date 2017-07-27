import	_control;

export Constants
 :=
	module
		export	string		FileNameClusterPrefix			:=	'~thor_200::';
		export	string		PreppedFileSuperFileName	:=	FileNameClusterPrefix	+	'in::entiera::email_addresses';
		export	string		BaseFileSuperFileName			:=	FileNameClusterPrefix	+	'base::entiera::basefile';
		export	string		SprayTargetCluster				:=	if(_Control.ThisEnvironment.Name = 'Dataland',	'thor200_144',	'thor_200');

		export	string		InFileCSVSeparator				:=	',';
		export	string		InFileCSVTerminator				:=	'\r\n';
		export	string		InFileCSVQuote						:=	'"';
		export	integer2	InFileCSVMaxLength				:=	8192;

		export	string		PrepFileCSVSeparator			:=	'\t';
		export	string		PrepFileCSVTerminator			:=	InFileCSVTerminator;
		export	string		PrepFileCSVQuote					:=	InFileCSVQuote;
		export	integer2	PrepFileCSVMaxLength			:=	InFileCSVMaxLength;
		
		export	integer2	BaseFileMaxLength					:=	16384;	// 8192 may suffice, but data width possibilities unknown
	end
 ;
