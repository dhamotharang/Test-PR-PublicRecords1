EXPORT layouts := module

export rPlatformStatus := RECORD
string PlatformName { xpath('PlatformName')}  ;
string PlatformStatus { xpath('PlatformStatus')} ;
end;

EXPORT RequestGetProfileLayout             := RECORD
    string     ProfileName                                        {xpath('ProfileName')};
    string     ProfileTypeName                                    {xpath('ProfileTypeName')};
END;

EXPORT OrbitPlatformUpdateLayout           := RECORD
    string     PlatformName                                       {xpath('PlatformName')};
    string     PlatformStatus                                     {xpath('PlatformStatus')};
END;

EXPORT OrbitProfileDynamicPropertiesLayout := RECORD
         STRING     PropertyKey                                        {xpath('Key')};
         BOOLEAN    PropertyValue                                      {xpath('Value')};
   END;

   EXPORT OrbitProfileDynamicRulePropertiesLayout := RECORD
         STRING     PropertyKey                                        {xpath('Key')};
         STRING     PropertyValue                                      {xpath('Value')};
   END;

//*************************************************************************************************************												
//** ECL copied from Insurance for Orbit Profile setup in PR  
//*******************************************************************************************	 
EXPORT ResponseGetProfileLayout            := RECORD
         string    Id                                                  {xpath('Id')};
         dataset(OrbitProfileDynamicPropertiesLayout)DynamicProperties {xpath('DynamicProperties/Property')};
         string    DateCreated                                         {xpath('DateCreated')};
         string    DateUpdated                                         {xpath('DateUpdated')};
         string    Description                                         {xpath('Description')};
         string    IsEnabled                                           {xpath('IsEnabled')};
         string    Name                                                {xpath('Name')};
         string    ProfileTypeId                                       {xpath('ProfileTypeId')};
         string    StatStatus                                          {xpath('StatStatus')};
         string    StatVersion                                         {xpath('StatVersion')};
         string    UserCreated                                         {xpath('UserCreated')};
         string    UserUpdated                                         {xpath('UserUpdated')};
   END;

EXPORT Layout_Profile_Status               := RECORD
         string128    ProfileName;
         String25    ProfileStatus;
         String      ProfileVersion;
   END;

//*******************************************************************************************

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

 
