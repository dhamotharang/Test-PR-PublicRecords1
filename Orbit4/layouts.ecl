EXPORT layouts := module

export rPlatformStatus := RECORD
string PlatformName { xpath('PlatformName')}  ;
string PlatformStatus { xpath('PlatformStatus')} ;
end;



EXPORT OrbitBuildInstanceLayout	:=	record
		string										ComponentType											{xpath('ComponentType')};
		string										DataType													{xpath('DataType')};
		string										Family														{xpath('Family')};
		string										Id																{xpath('Id')};
		string										Name															{xpath('Name')};
		string										Status														{xpath('Status')};
		string										Version														{xpath('Version')};
	end;
	
EXPORT OrbitBuildInstancenewLayout	:=	record
		string										ComponentType											;
		string										DataType													;
		string										Family														;
		string										Id																;
		string										Name														;
		string										Status														;
		string										Version														;
	end;	

EXPORT InputItem := record
string ItemName ;
 string SourceName ;
 string ReceiveDateTape ;
 string FilePathName;
 end;
 
EXPORT AdditionalNamespacesLayout := RECORD
    STRING arr_namespace {xpath('@xmlns:arr')} := 'http://schemas.microsoft.com/2003/10/Serialization/Arrays';
    STRING orb_namespace {xpath('@xmlns:orb')} := 'http://lexisnexis.com/Orbit/';
    STRING i_namespace {xpath('@xmlns:i')} := 'http://www.w3.org/2001/XMLSchema-instance';
	 end; 
  END;

 
