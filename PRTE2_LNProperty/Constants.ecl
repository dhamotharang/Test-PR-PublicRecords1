import _control;
EXPORT Constants := module

EXPORT KeyName_ln_propertyv2 := 	'~prte::key::ln_propertyv2::'; 

EXPORT FCRA_KeyName_ln_propertyv2 := '~prte::key::ln_propertyv2::fcra::';

EXPORT ak_keyname := KeyName_ln_propertyv2 +'autokey::'; 

EXPORT ak_logical(string filedate) := KeyName_ln_propertyv2 + filedate + '::autokey::'; 

EXPORT skip_set := []; 

EXPORT ak_typestr := 'AK'; 

EXPORT unsigned2 MAX_EMBEDDED := 100;

EXPORT Fares_NoOnwershipChangeDocTypes := ['T','N','U','L','R','X','J','F','S','D','CD','C','M','I','JH','M','T=','TR',''];

EXPORT OKC_NoOnwershipChangeDocTypes   := ['VL','CR','RR','FC','AF','RA','CN','RL','SA','AA',''];

//Spray constants
	EXPORT IN_PREFIX_NAME				:= '~prte::in::ln_propertyv2';
	
	EXPORT LandingZoneIP						:= _control.IPAddress.bctlpedata12;													 
	EXPORT SourcePathForCSV		    	:= '/data/prct/infiles/dev_16/';  	
	EXPORT CSVSprayFieldSeparator		:= '\\t';     
	EXPORT CSVSprayLineSeparator		:= '\\n,\\r\\n';
	EXPORT CSVSprayQuote						:= '';
	EXPORT CSVMaxCount							:= 100000;  
	EXPORT CSVOutFieldSeparator			:= ',';
	EXPORT CSVOutQuote							:= '"';
	EXPORT CSVSuffix								:= '.txt';

	EXPORT st_restrict := [];
	EXPORT max_owners := 10;
	EXPORT max_hist := 100;
END;

