import _control,ut;

export Constants := Module
	
  EXPORT specialChars    := '~|`|!|@|#|\\$|%|\\^|\\&|\\*|\\(|\\)|_|\\+|\\=|\\{|\'|\\[|\\}|\\||\\¦|/|]|\\\\|:|;|<|>|\\.|,|\\?|¢|¬|-|"';
	EXPORT MinStartDate := '15000000';
	EXPORT MinYearBuilt := '1500';
	EXPORT DaysInYear   := 365;
	EXPORT Checked      := 1;
	EXPORT DefaultUnitDesig := '#';
	EXPORT E216Error    := 'E216';
	EXPORT ValidAptType := ['H','R','M'];
	EXPORT ErrorInd     := 'E';
	EXPORT NotFound     := 'NFND';
	EXPORT RecordTypes  := ENUM(unsigned1,NotFound=0,Properties,Contractors,Corrections,Inspections,Permits,PermitContractors,Calculations,Jurisdictions);
  
  shared current_date := Stringlib.GetDateYYYYMMDD(); 
	shared current_time := ut.getTime()[1..4]; 
		
	EXPORT landingzone  := IF(_control.ThisEnvironment.Name!='Prod',_control.IPAddress.dataland_esp,_control.IPAddress.prod_thor_esp);
  EXPORT infilename   := '~thor::BuildFax::append::input::' + workunit;
	EXPORT outfilename  := '~thor::BuildFax::append::output::' + workunit;
	EXPORT LZpathIn     := '/data/buildFax_ftp/in/';
	EXPORT LZpathOut    := '/data/buildFax_ftp/out/';
	EXPORT LZOrbit      := '/data/orbitprod/buildFax/';
	EXPORT LZOrbitProc  := '/data/orbitprod/buildFax/process/';
	EXPORT LZName       := 'buildFax_append.csv';
	EXPORT ipAddress    := IF(_control.ThisEnvironment.Name!='Prod','iroxieqa.sc.seisint.com:9876','iroxiebatchvip.sc.seisint.com:9876');
  EXPORT servicename  := 'BuildFaxServices.Service_BuildFax';	
	EXPORT servicenameDataAppend  := 'BuildFaxServices.Service_BuildFax_DataAppend';
	EXPORT dstcluster   := Thorlib.cluster();
	EXPORT csvseparator := ',';
	EXPORT csvquote     := '"';
	
end;

