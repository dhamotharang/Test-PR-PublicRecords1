IMPORT ut, doxie,_control, lib_StringLib;

EXPORT Constants(STRING build_date = '', BOOLEAN FCRA = FALSE) := MODULE
	EXPORT sProdID            					:= 'PPR';
	EXPORT URL_Prod											:= 'HTTP://riskmultiproduct_gateway:rmpgw@10.194.3.14:9393/WsProxy/WsAccurintRMP/?ver_=1.65&internal';
	EXPORT URL_Dev											:= 'HTTP://riskmultiproduct_gateway:rmpgw@10.194.3.14:9393/WsProxy/WsAccurintRMP/?ver_=1.65&internal';
	EXPORT Node_30  										:=	30;
	EXPORT Node_50  										:=	50;
	EXPORT insurance_category_property	:=	'PC';
	EXPORT Insurance_Type_PP						:=	'PP';
	EXPORT ValidHouseNumberCharacters		:=	'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789/- ';


	SHARED FileSeparator			:= '/';
	EXPORT RecordTerminator   := ['\n','\r\n','\n\r'];
	EXPORT FieldSeparator     := ['\t', '|'];
	EXPORT landingzone        := IF(_control.ThisEnvironment.Name!='Prod','10.194.72.226','10.194.64.250');
	EXPORT MBSi_PPR			  		:= 'MBSi_PortfolioPeril';
	EXPORT PortfolioPeril  		:= 'PortfolioPeril';
	EXPORT GeoSpatialRisk  		:= 'GeoSpatialRisk';
	EXPORT dirname            := 'PortfolioPeril';
	
	EXPORT inDir        			 := IF(_control.ThisEnvironment.Name!='Prod','/data/orbittesting/' + trim(dirname,left,right) + '/in',
	                                '/data/orbitprod/' + trim(dirname,left,right) + '/in');

	EXPORT processDir        		:= IF(_control.ThisEnvironment.Name!='Prod','/data/orbittesting/' + trim(dirname,left,right) + '/process',
	                                '/data/orbitprod/' + trim(dirname,left,right) + '/process');

	EXPORT processfile        := inDir + FileSeparator + 'ppr_cc_extract*'; 
	EXPORT devespserverIPport := 'http://'+_control.ThisEnvironment.ESP_IPAddress+':8010/FileSpray';
	EXPORT thor_dest          := if(_control.ThisEnvironment.Name!='Prod','thor21',_control.TargetQueue.Prod_FCRA);
	EXPORT QC_email_target		:= IF (_control.ThisEnvironment.Name = 'Prod', 
	                                 'DataFab-ALP@lexisnexis.com',
	                                 'Charles.Jones@lexisnexis.com');

	EXPORT WorkUnit_Ref				:=	StringLib.StringFilterOut(workunit,'W');
	EXPORT WorkUnit_Reformat	:=	StringLib.StringFindReplace(WorkUnit_Ref,'-','_');
	
	// EXPORT ThorFileName				:= '~thor::spray::' + build_date + '::' + lib_StringLib.StringLib.StringFindReplace(trim(filelist.name,left,right),'.txt', '_txt');
	
	EXPORT spray_str := '~thor::spray::' + 'mbsi' + '::' + PortfolioPeril;
	EXPORT spray_file := spray_str;
	EXPORT spray_subfile := spray_str + '::' + build_date;
	
	EXPORT base_str := '~thor::base::' + sProdID;
	EXPORT base_file := base_str + '::qa::' + PortfolioPeril;
	EXPORT base_subFile := base_str + '::' + build_date + '::' + PortfolioPeril;

//MFD SFD
	EXPORT	isSFD := ['','100','109','135','136','137','138','160','163','454','460','465','500','999','1000','1001','1006','1007','1008','1012','1015','1016','1109','1999','8000','8001','9300','9301'];
	EXPORT	isMFD := ['102','103','106','112','113','114','115','161','117','118','132','133','134','151','165','245','450','452','1002','1003','1004','1005','1010','1100','1101','1102','1103','1104','1106','1107','1108','1110','1111','1112','1113','8007'];

	EXPORT set of string5		sPeril_CauseOfLoss  :=
			[
			'FIRE ',		//Fire																									FIRE
			'HAIL ',		//Hail																									HAIL
			'LIAB ',		//Liability(All Other)																LIAB
			'LIGHT',		//Lightning																						LIGHT
			'MOVE ',		//Earth Movement																				MOVE
			'OTHER',		//All Other																						OTHER
			'PHYDA',		//All Other Physical Damage														PHYDA
			'SINK ',		//Sink Hole																						SINK
			'THEFT',		//Theft/Burgalary																			THEFT
			'WATER',		//Water Damage																					WATER
			'WEATH',		//Weather Related Water Damage												WEATH
			'WIND '			//Wind																									WIND
			];  

	
	END;
	