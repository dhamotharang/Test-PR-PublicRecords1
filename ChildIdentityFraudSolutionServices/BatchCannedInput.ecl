/***************************************************************************************
	A sample input file to be used for testing batch services.
  This file should be read from IParam.getBatchIn(), when useCannedRecs parameter is set to true.
 ***************************************************************************************/
tmp_layout := record
	Layouts.BatchIn.acctno;
	Layouts.BatchIn.SSN;
	Layouts.BatchIn.name_first;
	Layouts.BatchIn.name_middle;
	Layouts.BatchIn.name_last;
	//Layouts.BatchIn.Address;
	Layouts.BatchIn.prim_range;
	Layouts.BatchIn.predir;
	Layouts.BatchIn.prim_name;
	Layouts.BatchIn.addr_suffix;
	Layouts.BatchIn.postdir;
	Layouts.BatchIn.unit_desig;
	Layouts.BatchIn.sec_range;
	Layouts.BatchIn.p_city_name;
	Layouts.BatchIn.st;
	Layouts.BatchIn.z5;
	Layouts.BatchIn.Identity_Type_Indicator;	
end;

_canned_recs := dataset([									
									
{'1','258214518','RODRICK'	,'T'	,'BROOKS'			,		'9142'		,		''	,'PUCKETT'							, 'ST'		,'SW'	,''		,''		,'COVINGTON'				,'GA','30014','A'},
{'2','351809728','CANDACE'	,''		,'MENDENHALL'	,'PO BOX 3701',		''	,''											,	 ''			,''		,''		,''   ,'GARDENA'					,'CA','90247','D'},
{'3','600803831','BRIAN'		,''		,'SATCHELL'		,    	'715'		, 	'N'	,	'ARROWHEAD '					,	'DR'		,''		,'APT','4'  ,'CHANDLER'					,'AZ','85224','D'},
{'4','545959376','JERMAINE'	,'A'	,'AFE'				,			'5123'	, 	' '	,	'STORMY'							,	'TRL'		,''		,''		,''   ,'SAN ANTONIO'			,'TX','78247','D'},
{'5','600286274','LARRY'		,'J'	,'SOWLER'			,			'715'		, 	'N'	,	'ARROWHEAD '					,	'DR'		,''		,'APT','3'  ,'CHANDLER'					,'AZ','85224','D'},
{'6','333780995','FREELIN'	,'A'	,'COLEMAN'		,		'653'			, 	''	,		'BOSTON '						,	'AVE'		,''		,''		,''   ,'WATERLOO'					,'IA','50703','D'},
{'7','418173525','ANTHONY'	,''		,'AMOMOO'			,			'3993'	, 	''	,		'COLLEGE HILL '			, 'RD'		,''		,''		,''   ,'MOBILE'						,'AL','36609','D'},
{'8','418987951','FREDICK'	,''		,'LOVETT'			,			'3993'	, 	''	,		'COTTAGE HILL '			, 'RD'		,''		,''		,''   ,'MOBILE'						,'AL','36609','D'},
{'9','370522108','LARRY'		,''		,'MCCAMMON'		,			'3993'	, 	''	,		'COTTAGE HILL '			, 'RD'		,''		,''		,''   ,'MOBILE'						,'AL','36609','D'},
{'10','417217495','MICHAEL'	,'J'	,'HUDSON'			,		'1253'		, 	''	,		'BARKER '						, 'DR'		,''		,''		,''   ,'MOBILE'						,'AL','36608','D'},
{'11','590445747','MONICA'	,'R'	,'ELLIS'			,			'1063'	, 	''	,		'RICE '							,	'DR'		,''		,''		,''   ,'COLORADO SPRINGS'	,'CO','80905','D'},
{'12','256512917','TORIANO'	,'D'	,'GRANT'			,		'2372'		, 	''	,		'LEXINGTON VILLAGE ','LN'			,''		,''		,''  	,'COLORADO SPRINGS'	,'CO','80916','D'},
{'13','591368214','DONALD'	,'F'	,'GRANT'			,			'2372'	, 	''	,		'LEXINGTON VILLAGE ','LN'			,''		,''		,''  	,'COLORADO SPRINGS'	,'CO','80916','D'},
{'14','531927970','KELLY'		,'J'	,'SMITH'			,			'3239'	, 	''	,		'BLACKHAWK '				,	'CIR'		,''		,''		,''   ,'AURORA'						,'CO','80011','D'},
{'15','595165058','LYN'			,'A'	,'SMITH'			,				'3239', 	''	,		'BLACKHAWK '				,	'CIR'		,''		,''		,''   ,'AURORA'						,'CO','80011','D'},
{'16','521855341','DAVID'		,'D'	,'VALDEZ'			,			'2107'	, 	''	,		'WOODSONG '					,	'WAY'		,''		,''		,''   ,'FOUNTAIN'					,'CO','80817','D'},
{'17','526918933','VIRGINIA',''		,'JONES'			,		'1418'		, 	''	,		'RUSHMORE '					,	'DR'		,''		,''		,''   ,'COLORADO SPRINGS'	,'CO','80910','D'},
{'18','600037154','EDWARD'	,'L'	,'JONES'			,			'1418'	, 	''	,		'RUSHMORE '					,	'DR'		,''		,''		,''   ,'COLORADO SPRINGS'	,'CO','80910','D'},
{'19','134486372','MICHAEL'	,'M'	,'SANDERS'		,	'3239'			, 	''	,		'BLACKHAWK '				,	'CIR'		,''		,''		,''   ,'AURORA'						,'CO','80011','D'},
{'20','600127049','BRIAN'		,'C'	,'SANDERS'		,		'3239'		, 	''	,		'BLACKHAWK '				,	'CIR'		,''		,''		,''   ,'AURORA'						,'CO','80011','D'},
{'21','589039923','KEAVIN'	,'A'	,'JONES'			,			'1418'	, 	''	,		'RUSHMORE '					,	'DR'		,''		,''		,''   ,'COLORADO SPRINGS'	,'CO','80910','D'},
{'22','265910517','LILLIAN'	,'M'	,'BROWN'			,		'2372'		, 	''	,		'LEXINGTON VILLAGE'	,'LN'			,''		,''		,''  	,'COLORADO SPRINGS'	,'CO','80916','D'},
{'23','44667919','ELLEN'		,'C'	,'BROWN'			,				'2372', 	''	,		'LEXINGTON VILLAGE ','LN'			,''		,''		,''  	,'COLORADO SPRINGS'	,'CO','80916','D'},
{'24','266970052','ERICA'		,'B'	,'BROWN'			,			'2372'	, 	''	,		'LEXINGTON VILLAGE ','LN'			,''		,''		,''  	,'COLORADO SPRINGS'	,'CO','80916','D'},
{'25','527518419','DINA'		,''		,'GONZALES'		,			'17808'	, 	'N'	,	'18TH '								,'DR'			,''		,''		,''  	,'PHOENIX'					,'AZ','85023','D'},
{'26','601402611','ANALISA'	,''		,'DELGADO'		,		'4626'		, 	'N'	,	'89TH '								,'AVE'		,''		,''		,'' 	,'PHOENIX'					,'AZ','85037','D'},
{'27','136766485','LOUIS'		,'J'	,'GAGLIARDI'	,	'69A'				, 	''	,		'WAVECREST '				,'AVE'		,''		,''		,'' 	,'WINFIELD PARK'		,'NJ','07036','D'},
{'28','131507240','SCOTT'		,''		,'ALLEN'			,				'3847', 	'N'	,	'48TH '								,'DR'			,''		,''		,''  	,'PHOENIX'					,'AZ','85031','D'},
{'29','272723745','RAY'			,'L'	,'JACKSON'		,			'2525'	, 	''	,		'AUBURN AVE '				,'STE'		,''		,''		,'' 	,'COLUMBUS'					,'GA','31906','D'},
{'30','126977084','ANDREW'	,''		,'SANCHEZ'		,		'41770'		, 	'W'	,	'SOMERSET'						,'DR'			,''		,''		,''   ,'MARICOPA'					,'AZ','85138','D'},
{'33','572516064', 'JOHN'		,''		,'SMITH'			,			'10761'	, 	''	,	'SKDLFKSDF'		,'SLKDFSDF'		,''		,''		,''   ,'BOYNTON BEACH'		,'FL',	'33437','D'},
{'34','509484864', 'TRACY'	,''		,'WWHITNEY'			,			'10761'	, 	''	,	'KJSDGLFSDK'		,'DFGDFG'		,''		,''		,''   ,'BOYNTON BEACH'		,'FL',	'33437','D'},
{'36','266089685', 'NANCY'	,''		,'DREW'			,			'10761'	, 	''	,	'LILLY'		,'LANE'		,''		,''		,''   ,'BOYNTON BEACH'		,'FL',	'33437','D'},
{'37','520509600', 'JANE'		,''		,'JONES'			,			'10761'	, 	''	,	'COCONUTCREEK'		,'LANE'		,''		,''		,''   ,'BOYNTON BEACH'		,'FL',	'33437','D'},
{'38','237764755', 'JOD'	,''		,'POLOMBO'			,			'10761'	, 	''	,	'SNOWMAN'		,'LANE'		,''		,''		,''   ,'BOYNTON BEACH'		,'FL',	'33437','D'},
{'32','556865027', 'MARIA'	,'A'	,'ACOSTA-MATHIS'						,		''	, 	''									,	''		,''		,''		,''		,''   ,''		,'',	'','A'},
{'11144596','250500193', 'THOMAS'	,''	,'WRIGHT'	,			'3269'	, 	''	,	'HEATON'							,'DR'		,''		,''		,''   ,'LADSON'		,'SC',	'29403','D'},
{'11161926','251364108', 'THOMAS'	,''	,'BRIGHT'	,			'3269'	, 	''	,	'HEATON'							,'DR'		,''		,''		,''   ,'LADSON'		,'SC',	'29403','D'}

									], tmp_layout);
									
// Death
// 556865027	ACOSTA-MATHIS       	    	MARIA          	A              
// 365541167	ABIAAD              	    	EMILE          	N              
// 365541167	ABI-AAD             	    	EMILE          	               
// 435668752	ADICKES             	    	HELEN          	M              
// 569245922	AACH                	    	ROBERT         	SEYMOUR        

EXPORT BatchCannedInput := project(_canned_recs, transform(Layouts.BatchIn,self := left, self := []));