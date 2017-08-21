IMPORT prte_csv,_control;

EXPORT Proc_Build_Oshair_Keys(string pIndexVersion)	:=
function

	rkeythor_data400__key__oshair_accident		        	:= PRTE_CSV.OSHAIR.rthor_data400__key__oshair_accident;
	rkeythor_data400__key__oshair_inspection	          := PRTE_CSV.OSHAIR.rthor_data400__key__oshair_inspection;
  rkeythor_data400__key__oshair_addressb2		        	:= PRTE_CSV.OSHAIR.rthor_data400__key__oshair_addressb2;
	rkeythor_data400__key__oshair_citystnameb2		    	:= PRTE_CSV.OSHAIR.rthor_data400__key__oshair_citystnameb2;
	rkeythor_data400__key__oshair_fein2	                := PRTE_CSV.OSHAIR.rthor_data400__key__oshair_fein2;
  rkeythor_data400__key__oshair_nameb2			          := PRTE_CSV.OSHAIR.rthor_data400__key__oshair_nameb2;
	rkeythor_data400__key__oshair_namewords2		      	:= PRTE_CSV.OSHAIR.rthor_data400__key__oshair_namewords2;
	rkeythor_data400__key__oshair_payload	              := PRTE_CSV.OSHAIR.rthor_data400__key__oshair_payload;
  rkeythor_data400__key__oshair_stnameb2		        	:= PRTE_CSV.OSHAIR.rthor_data400__key__oshair_stnameb2;
	rkeythor_data400__key__oshair_zipb2	                := PRTE_CSV.OSHAIR.rthor_data400__key__oshair_zipb2;
  rkeythor_data400__key__oshair_bdid			            := PRTE_CSV.OSHAIR.rthor_data400__key__oshair_bdid;
	rkeythor_data400__key__oshair_hazardous_substance		:= PRTE_CSV.OSHAIR.rthor_data400__key__oshair_hazardous_substance;
	rkeythor_data400__key__oshair_program	              := PRTE_CSV.OSHAIR.rthor_data400__key__oshair_program;
  rkeythor_data400__key__oshair_violations		      	:= PRTE_CSV.OSHAIR.rthor_data400__key__oshair_violations;
  rkeythor_data400__key__oshair_linkids	              := PRTE_CSV.OSHAIR.rthor_data400__key__oshair_linkids;
	
  dkeythor_data400__key__oshair_accident		        	:= project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__accident 				    ,rkeythor_data400__key__oshair_accident);
	dkeythor_data400__key__oshair_inspection	          := project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__inspection 			   	,rkeythor_data400__key__oshair_inspection);
  dkeythor_data400__key__oshair_addressb2		        	:= project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__addressb2 			 	    ,rkeythor_data400__key__oshair_addressb2);
	dkeythor_data400__key__oshair_citystnameb2		    	:= project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__citystnameb2 		 		,rkeythor_data400__key__oshair_citystnameb2);
	dkeythor_data400__key__oshair_fein2	                := project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__fein2 			        	,rkeythor_data400__key__oshair_fein2);
  dkeythor_data400__key__oshair_nameb2			          := project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__nameb2 			       	,rkeythor_data400__key__oshair_nameb2);
	dkeythor_data400__key__oshair_namewords2		      	:= project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__namewords2 			   	,rkeythor_data400__key__oshair_namewords2);
	dkeythor_data400__key__oshair_payload	              := project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__payload 				      ,rkeythor_data400__key__oshair_payload);
  dkeythor_data400__key__oshair_stnameb2		        	:= project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__stnameb2 				    ,rkeythor_data400__key__oshair_stnameb2);
	dkeythor_data400__key__oshair_zipb2	                := project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__zipb2 				        ,rkeythor_data400__key__oshair_zipb2);
  dkeythor_data400__key__oshair_bdid			            := project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__bdid 				        ,rkeythor_data400__key__oshair_bdid);
  dkeythor_data400__key__oshair_hazardous_substance		:= project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__hazardous_substance 	,rkeythor_data400__key__oshair_hazardous_substance);
	dkeythor_data400__key__oshair_program	              := project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__program 		      		,rkeythor_data400__key__oshair_program);
  dkeythor_data400__key__oshair_violations		      	:= project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__violations 			   	,rkeythor_data400__key__oshair_violations);
  dkeythor_data400__key__oshair_linkids	              := project(PRTE_CSV.OSHAIR.dthor_data400__key__oshair__linkids 			      	,rkeythor_data400__key__oshair_linkids);
	
  kkeythor_data400__key__oshair_accident		        	:= index(dkeythor_data400__key__oshair_accident  , {activity_number}, {dkeythor_data400__key__oshair_accident}, '~prte::key::oshair::' + pIndexVersion + '::accident');
	kkeythor_data400__key__oshair_inspection	          := index(dkeythor_data400__key__oshair_inspection, {activity_number}, {dkeythor_data400__key__oshair_inspection}, '~prte::key::oshair::' + pIndexVersion + '::inspection');
  kkeythor_data400__key__oshair_addressb2		        	:= index(dkeythor_data400__key__oshair_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dkeythor_data400__key__oshair_addressb2}, '~prte::key::oshair::' + pIndexVersion + '::autokey::addressb2'); 
	kkeythor_data400__key__oshair_citystnameb2		    	:= index(dkeythor_data400__key__oshair_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dkeythor_data400__key__oshair_citystnameb2}, '~prte::key::oshair::' + pIndexVersion + '::autokey::citystnameb2');
	kkeythor_data400__key__oshair_fein2	                := index(dkeythor_data400__key__oshair_fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dkeythor_data400__key__oshair_fein2}, '~prte::key::oshair::' + pIndexVersion + '::autokey::fein2');
  kkeythor_data400__key__oshair_nameb2			          := index(dkeythor_data400__key__oshair_nameb2, {cname_indic,cname_sec,bdid}, {dkeythor_data400__key__oshair_nameb2}, '~prte::key::oshair::' + pIndexVersion + '::autokey::nameb2');
	kkeythor_data400__key__oshair_namewords2		      	:= index(dkeythor_data400__key__oshair_namewords2, {word,state,seq,bdid}, {dkeythor_data400__key__oshair_namewords2}, '~prte::key::oshair::' + pIndexVersion + '::autokey::namewords2');
	kkeythor_data400__key__oshair_payload	              := index(dkeythor_data400__key__oshair_payload, {fakeid}, {dkeythor_data400__key__oshair_payload}, '~prte::key::oshair::' + pIndexVersion + '::autokey::payload');
  kkeythor_data400__key__oshair_stnameb2		        	:= index(dkeythor_data400__key__oshair_stnameb2, {st,cname_indic,cname_sec,bdid}, {dkeythor_data400__key__oshair_stnameb2}, '~prte::key::oshair::' + pIndexVersion + '::autokey::stnameb2');
	kkeythor_data400__key__oshair_zipb2	                := index(dkeythor_data400__key__oshair_zipb2, {zip,cname_indic,cname_sec,bdid}, {dkeythor_data400__key__oshair_zipb2}, '~prte::key::oshair::' + pIndexVersion + '::autokey::zipb2');
  kkeythor_data400__key__oshair_bdid			            := index(dkeythor_data400__key__oshair_bdid, {bdid}, {dkeythor_data400__key__oshair_bdid}, '~prte::key::oshair::' + pIndexVersion + '::bdid');
  kkeythor_data400__key__oshair_hazardous_substance		:= index(dkeythor_data400__key__oshair_hazardous_substance, {activity_number}, {dkeythor_data400__key__oshair_hazardous_substance}, '~prte::key::oshair::' + pIndexVersion + '::hazardous_substance');
	kkeythor_data400__key__oshair_program	              := index(dkeythor_data400__key__oshair_program, {activity_number}, {dkeythor_data400__key__oshair_program}, '~prte::key::oshair::' + pIndexVersion + '::program');
  kkeythor_data400__key__oshair_violations		      	:= index(dkeythor_data400__key__oshair_violations, {activity_number}, {dkeythor_data400__key__oshair_violations}, '~prte::key::oshair::' + pIndexVersion + '::violations');
  kkeythor_data400__key__oshair_linkids	              := index(dkeythor_data400__key__oshair_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkeythor_data400__key__oshair_linkids  }, '~prte::key::oshair::' + pIndexVersion + '::linkids');
 
	return 
	sequential(
		parallel(
			 build(kkeythor_data400__key__oshair_accident 		      	,update)
			,build(kkeythor_data400__key__oshair_inspection  	      	,update)
			,build(kkeythor_data400__key__oshair_addressb2  		      ,update)
			,build(kkeythor_data400__key__oshair_citystnameb2  	      ,update)
			,build(kkeythor_data400__key__oshair_fein2	  	  	      ,update)
			,build(kkeythor_data400__key__oshair_nameb2  	    	      ,update)
			,build(kkeythor_data400__key__oshair_namewords2  	      	,update)
			,build(kkeythor_data400__key__oshair_payload 		          ,update)
			,build(kkeythor_data400__key__oshair_stnameb2  	        	,update)
			,build(kkeythor_data400__key__oshair_zipb2  		          ,update)
			,build(kkeythor_data400__key__oshair_bdid  		            ,update)
			,build(kkeythor_data400__key__oshair_hazardous_substance 	,update)
			,build(kkeythor_data400__key__oshair_program	  	      	,update)
			,build(kkeythor_data400__key__oshair_violations       		,update)
	    ,build(kkeythor_data400__key__oshair_linkids  		        ,update)
		)
		,PRTE.UpdateVersion(
				'OshairKeys'												//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);

end;