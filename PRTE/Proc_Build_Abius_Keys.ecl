IMPORT prte_csv,_control;

EXPORT Proc_Build_Abius_Keys(STRING pIndexVersion):= 
FUNCTION

	rkeythor_data400__key__abius_fran		        	:= PRTE_CSV.ABIUS.rthor_data400__key__abius_fran;
	rkeythor_data400__key__abius_abi_number		    := PRTE_CSV.ABIUS.rthor_data400__key__abius_abi_number;
	rkeythor_data400__key__abius_doc_abinumber	  := PRTE_CSV.ABIUS.rthor_data400__key__abius_doc_abinumber;
  rkeythor_data400__key__abius_address		     	:= PRTE_CSV.ABIUS.rthor_data400__key__abius_address;
  rkeythor_data400__key__abius_addressb2		   	:= PRTE_CSV.ABIUS.rthor_data400__key__abius_addressb2;	
	rkeythor_data400__key__abius_citystname		  	:= PRTE_CSV.ABIUS.rthor_data400__key__abius_citystname;
	rkeythor_data400__key__abius_citystnameb2		 	:= PRTE_CSV.ABIUS.rthor_data400__key__abius_citystnameb2;
	rkeythor_data400__key__abius_name	            := PRTE_CSV.ABIUS.rthor_data400__key__abius_name;
  rkeythor_data400__key__abius_nameb2			      := PRTE_CSV.ABIUS.rthor_data400__key__abius_nameb2;
	rkeythor_data400__key__abius_namewords2		   	:= PRTE_CSV.ABIUS.rthor_data400__key__abius_namewords2;
	rkeythor_data400__key__abius_payload	        := PRTE_CSV.ABIUS.rthor_data400__key__abius_payload;
	rkeythor_data400__key__abius_phone2	          := PRTE_CSV.ABIUS.rthor_data400__key__abius_phone2;
	rkeythor_data400__key__abius_phoneb2	        := PRTE_CSV.ABIUS.rthor_data400__key__abius_phoneb2;
  rkeythor_data400__key__abius_stname		      	:= PRTE_CSV.ABIUS.rthor_data400__key__abius_stname;
  rkeythor_data400__key__abius_stnameb2		     	:= PRTE_CSV.ABIUS.rthor_data400__key__abius_stnameb2;
	rkeythor_data400__key__abius_zip	            := PRTE_CSV.ABIUS.rthor_data400__key__abius_zip;
	rkeythor_data400__key__abius_zipb2	          := PRTE_CSV.ABIUS.rthor_data400__key__abius_zipb2;
  rkeythor_data400__key__abius_bdid			        := PRTE_CSV.ABIUS.rthor_data400__key__abius_bdid;
	//rkeythor_data400__key__abius_linkids	        := PRTE_CSV.ABIUS.rthor_data400__key__abius_linkids;
	
  dkeythor_data400__key__abius_fran		        	:= PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__fran 				    ,rkeythor_data400__key__abius_fran);
  dkeythor_data400__key__abius_abi_number      	:= PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__abi_number 	    ,rkeythor_data400__key__abius_abi_number);
	dkeythor_data400__key__abius_doc_abinumber	  := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__doc_abinumber 		,rkeythor_data400__key__abius_doc_abinumber);
  dkeythor_data400__key__abius_address		     	:= PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__address 			 	  ,rkeythor_data400__key__abius_address);
  dkeythor_data400__key__abius_addressb2		   	:= PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__addressb2 			  ,rkeythor_data400__key__abius_addressb2);
	dkeythor_data400__key__abius_citystname		   	:= PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__citystname 		 	,rkeythor_data400__key__abius_citystname);
	dkeythor_data400__key__abius_citystnameb2		 	:= PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__citystnameb2 		,rkeythor_data400__key__abius_citystnameb2);
	dkeythor_data400__key__abius_name	            := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__name 			     	,rkeythor_data400__key__abius_name);
  dkeythor_data400__key__abius_nameb2			      := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__nameb2 			   	,rkeythor_data400__key__abius_nameb2);
	dkeythor_data400__key__abius_namewords2		   	:= PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__namewords2 		 	,rkeythor_data400__key__abius_namewords2);
	dkeythor_data400__key__abius_payload	        := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__payload 				  ,rkeythor_data400__key__abius_payload);
	dkeythor_data400__key__abius_phone2	          := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__phone2 				  ,rkeythor_data400__key__abius_phone2);
	dkeythor_data400__key__abius_phoneb2	        := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__phoneb2 			    ,rkeythor_data400__key__abius_phoneb2);
	dkeythor_data400__key__abius_stname		      	:= PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__stname 				  ,rkeythor_data400__key__abius_stname);
	dkeythor_data400__key__abius_stnameb2		      := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__stnameb2 	      ,rkeythor_data400__key__abius_stnameb2);
	dkeythor_data400__key__abius_zip	            := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__zip 				      ,rkeythor_data400__key__abius_zip);
  dkeythor_data400__key__abius_zipb2	          := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__zipb2 		        ,rkeythor_data400__key__abius_zipb2);
  dkeythor_data400__key__abius_bdid			        := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__bdid 			      ,rkeythor_data400__key__abius_bdid);
	//dkeythor_data400__key__abius_linkids	        := PROJECT(PRTE_CSV.ABIUS.dthor_data400__key__abius__linkids 	      	,rkeythor_data400__key__abius_linkids);
	
  kkeythor_data400__key__abius_fran		        	:= INDEX(dkeythor_data400__key__abius_fran  , {sic_code,franchise_char}, {dkeythor_data400__key__abius_fran}, '~prte::key::abius::' + pIndexVersion + '::fran');
  kkeythor_data400__key__abius_abi_number		   	:= INDEX(dkeythor_data400__key__abius_abi_number  , {abi_number}, {dkeythor_data400__key__abius_abi_number}, '~prte::key::infousa::abius::' + pIndexVersion + '::abi_number');
	kkeythor_data400__key__abius_doc_abinumber	  := INDEX(dkeythor_data400__key__abius_doc_abinumber, {src,doc,abi_number}, {dkeythor_data400__key__abius_doc_abinumber}, '~prte::key::abius::' + pIndexVersion + '::doc.abinumber');
  kkeythor_data400__key__abius_address		    	:= INDEX(dkeythor_data400__key__abius_address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dkeythor_data400__key__abius_address}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::address'); 
  kkeythor_data400__key__abius_addressb2		   	:= INDEX(dkeythor_data400__key__abius_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dkeythor_data400__key__abius_addressb2}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::addressb2'); 
 	kkeythor_data400__key__abius_citystname		  	:= INDEX(dkeythor_data400__key__abius_citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3}, {dkeythor_data400__key__abius_citystname}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::citystname');
	kkeythor_data400__key__abius_citystnameb2		 	:= INDEX(dkeythor_data400__key__abius_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dkeythor_data400__key__abius_citystnameb2}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::citystnameb2');
	kkeythor_data400__key__abius_name	            := INDEX(dkeythor_data400__key__abius_name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dkeythor_data400__key__abius_name}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::name');
  kkeythor_data400__key__abius_nameb2			      := INDEX(dkeythor_data400__key__abius_nameb2, {cname_indic,cname_sec,bdid}, {dkeythor_data400__key__abius_nameb2}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::nameb2');
	kkeythor_data400__key__abius_namewords2		   	:= INDEX(dkeythor_data400__key__abius_namewords2, {word,state,seq,bdid}, {dkeythor_data400__key__abius_namewords2}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::namewords2');
	kkeythor_data400__key__abius_payload	        := INDEX(dkeythor_data400__key__abius_payload, {fakeid}, {dkeythor_data400__key__abius_payload}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::payload');
	kkeythor_data400__key__abius_phone2	          := INDEX(dkeythor_data400__key__abius_phone2, {p7,p3,dph_lname,pfname,st,did}, {dkeythor_data400__key__abius_phone2}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::phone2');
	kkeythor_data400__key__abius_phoneb2	        := INDEX(dkeythor_data400__key__abius_phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dkeythor_data400__key__abius_phoneb2}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::phoneb2');
	kkeythor_data400__key__abius_stname		      	:= INDEX(dkeythor_data400__key__abius_stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dkeythor_data400__key__abius_stname}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::stname');
	kkeythor_data400__key__abius_stnameb2		     	:= INDEX(dkeythor_data400__key__abius_stnameb2, {st,cname_indic,cname_sec,bdid}, {dkeythor_data400__key__abius_stnameb2}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::stnameb2');
	kkeythor_data400__key__abius_zip	            := INDEX(dkeythor_data400__key__abius_zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dkeythor_data400__key__abius_zip}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::zip');
	kkeythor_data400__key__abius_zipb2	          := INDEX(dkeythor_data400__key__abius_zipb2, {zip,cname_indic,cname_sec,bdid}, {dkeythor_data400__key__abius_zipb2}, '~prte::key::infousa::abius::' + pIndexVersion + '::autokey::zipb2');
  kkeythor_data400__key__abius_bdid			        := INDEX(dkeythor_data400__key__abius_bdid, {bdid}, {dkeythor_data400__key__abius_bdid}, '~prte::key::infousa::abius::' + pIndexVersion + '::bdid');
	//kkeythor_data400__key__abius_linkids	        := INDEX(dkeythor_data400__key__abius_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkeythor_data400__key__abius_linkids  }, '~prte::key::infousa::abius::' + pIndexVersion + '::linkids');
 
	return 
	sequential(
		parallel(
			 build(kkeythor_data400__key__abius_fran 		      	,update)
			,build(kkeythor_data400__key__abius_abi_number  	 	,update)
			,build(kkeythor_data400__key__abius_doc_abinumber   ,update)
			,build(kkeythor_data400__key__abius_address  		    ,update)
			,build(kkeythor_data400__key__abius_addressb2  		  ,update)
			,build(kkeythor_data400__key__abius_citystname  	  ,update)
			,build(kkeythor_data400__key__abius_citystnameb2  	,update)
			,build(kkeythor_data400__key__abius_name	  	  	  ,update)
			,build(kkeythor_data400__key__abius_nameb2  	    	,update)
			,build(kkeythor_data400__key__abius_namewords2  	  ,update)
			,build(kkeythor_data400__key__abius_payload 		    ,update)
			,build(kkeythor_data400__key__abius_phone2 		      ,update)
			,build(kkeythor_data400__key__abius_phoneb2 		    ,update)
			,build(kkeythor_data400__key__abius_stname  	      ,update)
			,build(kkeythor_data400__key__abius_stnameb2  	    ,update)
			,build(kkeythor_data400__key__abius_zip  		        ,update)
			,build(kkeythor_data400__key__abius_zipb2  		      ,update)
			,build(kkeythor_data400__key__abius_bdid  		      ,update)
	//		,build(kkeythor_data400__key__abius_linkids  		    ,update)
		)
		,PRTE.UpdateVersion(
				'ABIKeys'										    		//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);






END;