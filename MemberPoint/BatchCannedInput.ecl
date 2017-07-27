/***************************************************************************************
	A sample input file to be used for testing batch services.
  This file should be read from IParam.getBatchIn(), when useCannedRecs parameter is set to true.
 ***************************************************************************************/
tmp_layout := record
		MemberPoint.Layouts.BatchIn.acctno;
		MemberPoint.Layouts.BatchIn.ssn;
		
		//MemberPoint.Layouts.BatchIn.name_middle;
		MemberPoint.Layouts.BatchIn.name_last;
		MemberPoint.Layouts.BatchIn.name_first;
		MemberPoint.Layouts.BatchIn.prim_range;
		//MemberPoint.Layouts.BatchIn.predir;
		MemberPoint.Layouts.BatchIn.prim_name;
		MemberPoint.Layouts.BatchIn.addr_suffix;
		//MemberPoint.Layouts.BatchIn.postdir;
		//MemberPoint.Layouts.BatchIn.unit_desig;
		//MemberPoint.Layouts.BatchIn.sec_range;
		MemberPoint.Layouts.BatchIn.p_city_name;
		MemberPoint.Layouts.BatchIn.st;
		MemberPoint.Layouts.BatchIn.z5;
		//string1 junk;
		//MemberPoint.Layouts.BatchIn.zip4;
		//MemberPoint.Layouts.BatchIn.record_type; // minor or non minor
		MemberPoint.Layouts.BatchIn.dob;
		//MemberPoint.Layouts.BatchIn.primary_address_date;
		//MemberPoint.Layouts.BatchIn.enrollment_date;
		MemberPoint.Layouts.BatchIn.primary_phone_number;
		//MemberPoint.Layouts.BatchIn.email;
		//MemberPoint.Layouts.BatchIn.guardian_name_first;
		//MemberPoint.Layouts.BatchIn.guardian_name_last;
		//MemberPoint.Layouts.BatchIn.guardian_DOB;
		//MemberPoint.Layouts.BatchIn.guardian_SSN;
end;

_canned_recs := dataset([									
{'1','250792637','MATTISON','DAMIAN','125','REAVES','PL','ANDERSON','SC','29625','19890923','3217570471'},
{'2','248792336','PINKNEY','DONTE','301','MARTIN','ST','GEORGETOWN','SC','29440','19890702','3217570471'},
{'3','49825528','GRAHAM','REGINALD','301','BELTLINE','BLVD','COLUMBIA','SC','29205','19880611','3217570471'},
{'4','250735160','WOODRUFF','DUSTIN','2224','SMITH','ST','CONWAY','SC','29526','19871218','3217570471'},
{'5','250735161','WOODRUFF','TONY','2224','SMITH','ST','CONWAY','SC','29526','20051218','3217570471'},
{'6','250500193','WRIGHT','THOMAS','3269','HEATON','DR','LADSON','SC','29456','19350627','3217570471'},
{'7','251364108','STRUHS','ESTHER','PO BOX 218','','', 'BLYTHEWOOD','SC','29016','19231207','3217570471'},
{'8','249642035','BEAUDROT','BERTHA','118','BASSET','LN','SAINT GEORGE','SC','29477','19101018','3217570471'},
{'9','356059688','GOULD','NORMAN','216','MIDNIGHT STAR','TRL','SPARTANBURG','SC','29303','19200324','3217570471'},
{'10','248406195','EVANS','ANNIE','1156','S EDISTO','DR','FLORENCE','SC','29501','19231121','3217570471'},
{'11','184240464','ECKMAN','BETTY','202','GOVERNORS GRANT','BLVD','LEXINGTON','SC','29072','19301001','3217570471'},
{'12','250541824','TOWE','ROSA','3','BRANDYWINE','CT','OWINGS MILLS','MD','21117','19241013','3217570471'},
{'13','403348506','CROWE','ALFRED','108','ELON','DR','LADSON','SC','29456','19281216','3217570471'},
{'14','251583186','LOVE','ANDREW','PO BOX 444','','', 'CATAWBA','SC','29704','18950831','3217570471'},
{'15','427119932','HERITAGE','RANDALL','1065','FARM POND','LN','ROCK HILL','SC','2973','19730116','3217570471'},
{'16','427119976','HERITAGE','BECKY','1065','FARM POND','LN','ROCK HILL','SC','2973','20071106','3217570471'},
{'17','590926086','DILLON','TYLER','905 ','154TH','','BRADENTON','FL','34212','19870605',''}

									], tmp_layout);	
	
	
// Death
// 556865027	ACOSTA-MATHIS       	    	MARIA          	A              
// 365541167	ABIAAD              	    	EMILE          	N              
// 365541167	ABI-AAD             	    	EMILE          	               
// 435668752	ADICKES             	    	HELEN          	M              
// 569245922	AACH                	    	ROBERT         	SEYMOUR        

EXPORT BatchCannedInput := project(_canned_recs, transform(MemberPoint.Layouts.BatchIn,self := left, self := []));
