EXPORT Layouts := Module

	EXPORT OrbitBuildInstanceLayout	:=	record
		string		ComponentType											{xpath('ComponentType')};
		string		DataType													{xpath('DataType')};
		string		Family														{xpath('Family')};
		string		Id																{xpath('Id')};
		string		Name															{xpath('Name')};
		string		Status														{xpath('Status')};
		string		Version														{xpath('Version')};
	end;
	
	EXPORT OrbitPlatformUpdateLayout	:=	record
		string 	PlatformName							{xpath('PlatformName')};
		string 	PlatformStatus						{xpath('PlatformStatus')};
	end;

	EXPORT OrbitUpdateBuildInstanceLayout := RECORD
		 STRING20 	BuildInstanceId	;
		 STRING			BuildInstanceName;
		 STRING20		BuildInstanceVersion;
		 STRING20 	ApplicationName;
		 STRING20 	SourceName;
		 STRING2		SPC;
		 STRING26 	DateCreated;
		 STRING20 	ReceivingId;
		 STRING20		Date;
		 STRING			FilePathName;
		 STRING			LoginToken;
		 BOOLEAN		Evaluated := FALSE;
	END;
END;