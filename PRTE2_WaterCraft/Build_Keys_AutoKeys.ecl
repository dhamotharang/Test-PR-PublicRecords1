/********************************************************************************************************** 
	Name: 			Build_Keys_Autokeys
	Created On: 08/10/2013
	By: 				ssivasubramanian
	Desc: 			This is used for building the auto keys. This is a copy of the following file:
								file watercraftv2_services.proc_autokeybuild
							The file has been modified to refer to the datasets which are present in the current module
***********************************************************************************************************/

IMPORT autokeyb2,doxie,ut,corp2,address;

EXPORT Build_Keys_Autokeys(STRING filedate) := FUNCTION

	Base_file 			:= _Datasets.Search_Ph_Supressed_bdid;

	dis_watercraft 	:=DISTRIBUTE(Base_file(watercraft_key <> ''),HASH(watercraft_key));

	layout_watercraft := RECORD
			_Layouts.Search_Slim;
			UNSIGNED6 ldid;
			UNSIGNED6 lbdid;
			STRING10 	phone :='';
			UNSIGNED1 zero := 0;
			STRING25 	city;
			STRING2 	bstate :='';
			STRING25 	bcity :='';
			STRING10 	bphone :='';
			STRING10	bprim_range :='';
			STRING28	bprim_name :='';
			STRING8		bsec_range :='';
			STRING5 	bzip5 :='';
			STRING9 	fein_use :='';
			STRING9 	ssn_use := '';
	END;

	layout_watercraft both_cities(dis_watercraft le,INTEGER C)		:=TRANSFORM
		SELF.city 		:=	CHOOSE(C,le.p_city_name,IF(le.v_city_name='' OR le.v_city_name=le.p_city_name,skip,le.v_city_name ));
		SELF.ldid 		:=	(UNSIGNED6) le.did;
		SELF.lbdid 		:=	(UNSIGNED6) le.bdid;
		SELF 					:=le;
	END;

	//capture both city names
	watercraft_both_cities :=NORMALIZE(dis_watercraft,2,both_cities(LEFT,COUNTER));


	//capture all phones
	layout_watercraft all_phones(layout_watercraft le,integer C)	:=TRANSFORM
		SELF.phone :=CHOOSE(C,le.phone_1,IF(le.phone_2='' OR le.phone_2=le.phone_1,skip,le.phone_2));
		SELF :=le;
	END;

	watercraft_both_phones :=DEDUP(NORMALIZE(watercraft_both_cities,2, all_phones(LEFT,COUNTER)),RECORD,ALL,LOCAL);


	layout_watercraft_use := RECORD
		_Layouts.Search.watercraft_key;
		_Layouts.Search.sequence_key;
		_Layouts.Search.state_origin;
		_Layouts.Search.fname;
		_Layouts.Search.lname;
		_Layouts.Search.mname;
		_Layouts.Search.dob;
		_Layouts.Search.prim_name;
		_Layouts.Search.prim_range;
		_Layouts.Search.st;
		_Layouts.Search.zip5;
		_Layouts.Search.sec_range;
		_Layouts.Search.company_name;	
		UNSIGNED6 	ldid;
		UNSIGNED6 	lbdid;
		STRING10 		phone :='';
		UNSIGNED1 	zero := 0;
		STRING25 		city;
		STRING2 		bstate :='';
		STRING25	 	bcity :='';
		STRING10 		bphone :='';
		STRING10		bprim_range :='';
		STRING28		bprim_name :='';
		STRING8			bsec_range :='';
		STRING5 		bzip5 :='';
		STRING9 		fein_use :='';
		STRING9 		ssn_use := '';
	END;

	layout_watercraft_use w_bState(layout_watercraft le)				:=TRANSFORM
		c 								:=	le.company_name <> '';
		SELF.fein_use 		:=	IF(le.orig_fein <> '',le.orig_fein,le.fein);
		SELF.ssn_use 			:=	IF(le.orig_ssn <>'',le.orig_ssn,le.ssn);
		SELF.bstate 			:= 	IF(c,le.st,'');
		SELF.bcity 				:= 	IF(c,le.city,'');
		SELF.bzip5 				:=	IF(c,le.zip5,'');
		SELF.bprim_name		:= 	IF(c,le.prim_name,'');
		SELF.bprim_range 	:=	IF(c,le.prim_range,'');
		SELF.bsec_range 	:=	IF(c,le.sec_range,'');
		SELF.bphone 			:=	IF(c,le.phone,'');
		SELF 							:=	le;
	END;

	watercraft :=PROJECT(watercraft_both_phones,w_bState(LEFT));

	autokey_ready := watercraft :PERSIST(_Files.Persist_Autokey_Data);

	AutoKeyB2.MAC_Build (autokey_ready,fname,mname,lname,
							ssn_use,
							dob,
							phone,
							prim_name,prim_range,st,city,zip5,sec_range,
							zero,
							zero,zero,zero,
							zero,zero,zero,
							zero,zero,zero,
							zero,
							ldid,
							company_name,
							fein_use,
							bphone,
							bprim_name,bprim_range,	bstate,bcity,	bzip5,bsec_range,
							lbdid,
							_Files.AutoKey.ak_keyname,
							_Files.AutoKey.ak_logical(filedate),
							outaction,FALSE,
							[],TRUE,_Files.AutoKey.ak_typeStr,TRUE,,,zero) 


	Autokey_ret := SEQUENTIAL(Create_AutoKeys_SuperFiles(_Files.AutoKey.ak_keyname).Do,outaction);
	
	RETURN Autokey_ret;

END;