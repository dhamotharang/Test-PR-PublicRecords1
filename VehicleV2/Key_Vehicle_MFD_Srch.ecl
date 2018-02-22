IMPORT VehicleV2, Doxie, Doxie_Build, data_services, ut;

	//advo does not exist in Distrix. Thus use Vehicle Party base file to determine if an address is MFD or not in Distrix environment.
	mac_get_address_list(rec_slim, distrix_flag):= FUNCTIONMACRO

		#IF(distrix_flag)
				temp_addr	 			:= TABLE(DISTRIBUTE(rec_slim, HASH(zip5,prim_name)),
																 {zip:=zip5,prim_range,predir,prim_name,addr_suffix:=suffix,postdir,unit_desig,sec_range},
																 zip5,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range);
				mfd_addr	 			:= TABLE(temp_addr,
																 {zip,prim_range,predir,prim_name,addr_suffix,postdir,addr_cnt:=COUNT(GROUP)},
																 zip,prim_range,predir,prim_name,addr_suffix,postdir)(addr_cnt>1);
		#ELSE
				IMPORT advo;
				addr						:=advo.Key_Addr1(zip+prim_name<>'');
				mfd_addr 				:= TABLE(DISTRIBUTE(addr, HASH(zip,prim_name)),
																 {zip,prim_range,predir,prim_name,addr_suffix,postdir,addr_cnt:=COUNT(GROUP)},
																 zip,prim_range,predir,prim_name,addr_suffix,postdir)(addr_cnt>1);
		#END

		rec_join						:= JOIN(rec_slim,
															  DISTRIBUTE(mfd_addr,HASH(zip)),
															  TRIM(LEFT.zip5)=TRIM(RIGHT.zip) AND
															  TRIM(LEFT.prim_range)=TRIM(RIGHT.prim_range) AND
															  TRIM(LEFT.prim_name)=TRIM(RIGHT.prim_name) AND
															  TRIM(LEFT.suffix)=TRIM(RIGHT.addr_suffix) AND
															  TRIM(LEFT.predir)=TRIM(RIGHT.predir) AND
															  TRIM(LEFT.postdir)=TRIM(RIGHT.postdir),
															  TRANSFORM({rec_slim},SELF.zip5:=LEFT.zip5;SELF:=LEFT),
															  INNER, KEEP(1), LOCAL);
		rec_mfd							:= dedup(sort(rec_join,RECORD,LOCAL),RECORD,LOCAL);
		
		RETURN rec_mfd;
		
	ENDMACRO;

	//Exclude party records marked as historical
	get_recs				:= VehicleV2.file_VehicleV2_Party_Clean_Sequence_Key(history<>'H' AND 
																																			 //Removed per Tony's requirement change on 7/27/16 email
	                                                                     //((unsigned3) (ut.GetDate[1..6]) - date_last_seen< 101 OR
																																			 //date_last_seen=0) AND			//For Infutor records, date_last_seen is 0
	                                                                     Append_Clean_Address.zip5+Append_Clean_Address.prim_name<>'');

	layout_slim := RECORD
		//key
		STRING5 	zip5;
		STRING10 	prim_range;
		STRING28 	prim_name;
		STRING4 	suffix;
		STRING2 	predir;
		STRING2 	postdir;
		//payload
		STRING10 	unit_desig;
		STRING8 	sec_range;
		STRING25 	v_city_name;
		STRING2 	st;
		STRING4 	zip4;	
		STRING30 	vehicle_key;
		STRING15 	iteration_key;
		STRING15 	sequence_key;
		STRING2 	source_code;
		STRING2 	state_origin;
		BOOLEAN 	is_minor;
		STRING1 	history;
		UNSIGNED3 date_last_seen;
		UNSIGNED6 reg_expire_date;						//reg_latest_expiration_date;
	END;

	layout_slim tx(get_recs L) := TRANSFORM
		SELF.zip5							:= L.Append_Clean_Address.zip5;
		SELF.prim_range				:= L.Append_Clean_Address.prim_range;
		SELF.prim_name				:= L.Append_Clean_Address.prim_name;
		SELF.predir						:= L.Append_Clean_Address.predir;
		SELF.postdir					:= L.Append_Clean_Address.postdir;
		SELF.suffix						:= L.Append_Clean_Address.addr_suffix;
		SELF.unit_desig				:= L.Append_Clean_Address.unit_desig;
		SELF.sec_range				:= L.Append_Clean_Address.sec_range;
		SELF.v_city_name			:= L.Append_Clean_Address.v_city_name;
		SELF.st								:= L.Append_Clean_Address.st;
		SELF.zip4							:= L.Append_Clean_Address.zip4;
		SELF.reg_expire_date 	:= (UNSIGNED6) L.reg_latest_expiration_date;
		age 									:= ut.age((INTEGER)l.orig_dob);
		SELF.is_minor 				:= if(age=0 or age>=18,FALSE,TRUE);
		SELF 									:= l;
	END;	 

	rec_slim 				:= DISTRIBUTE(project(get_recs, tx(LEFT)),HASH(zip5));

	//Doxie_Build.buildstate is set to PA in PA Distrix, OH in OH Distrix, and MN in Distrix Dev.
	distrix_flag 		:= IF(Doxie_Build.buildstate IN ['PA','OH', 'MN'],true, false);
	rec_dedup 			:= mac_get_address_list(rec_slim, distrix_flag);

// EXPORT Key_Vehicle_MFD_Srch := rec_join;
EXPORT Key_Vehicle_MFD_Srch := INDEX(rec_dedup, 
                                     {zip5, prim_range,prim_name,suffix,predir,postdir}, 
																		 {rec_dedup},
																		 data_services.data_location.prefix('Vehicle') + 'thor_data400::key::VehicleV2::mfd_srch_'+ doxie.Version_SuperKey);