import	_control, PRTE_CSV, BIPV2;

	LAY0	:= RECORD 
			PRTE_CSV.faa_airmen.rthor_data400__key__faa__airmen__autokey__payload; 
	END;
	DS0 	:= 	project(PRTE_CSV.faa_airmen.dthor_data400__key__faa__airmen__autokey__payload , LAY0);
	
	// ?? Will the following joins do just as well with just DID matching????  may not need the st,lname,fname matches ???
	LAY00	:= RECORD 
			PRTE_CSV.faa.rthor_data400__key__faa__autokey__payload;
	END;
	DS00	:= 	join(DS0,	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__payload , LAY00)
							,left.did_out6=right.did_out		// unsigned6 cp to unsigned8 - should not need a cast
							and left.st=right.st
							and left.lname=(string)right.lname
							and left.fname=right.fname
							,left outer
							,keep(1)
							);
							
/*
	LAY1 := RECORD
			PRTE_CSV.FAA_Airmen.rthor_data400__key__faa__airmen__autokey__address;
  END;
 	DS1		:= 	join(DS00,		project(PRTE_CSV.faa_airmen.dthor_data400__key__faa__airmen__autokey__address, LAY1)
   							,left.did_out6=right.did
   							and left.st=right.st
   							and left.lname=(string)right.lname
   							and left.fname=right.fname
   							,left outer
   							,keep(1)
   							);
   	LAY2 := RECORD
				PRTE_CSV.faa_airmen.rthor_data400__key__faa__airmen__autokey__citystname
		END;
   	DS2		:=	join(ds1,		project(PRTE_CSV.faa_airmen.dthor_data400__key__faa__airmen__autokey__citystname, LAY2)
   							,left.did=right.did
   							and left.st=right.st
   							and left.lname=(string)right.lname
   							and left.fname=right.fname
   							,left outer
   							,keep(1)
   							);
*/
		DS2 := DS00;

// ****************************************************************************************************************	
// DS00 already contains base_ssn so this will not give us anything new...
	// DS4					:= 	project(PRTE_CSV.faa_airmen.dthor_data400__key__faa__airmen__autokey__ssn2, PRTE_CSV.faa_airmen.rthor_data400__key__faa__airmen__autokey__ssn2);
	
//????? Check layouts --- not sure if the rest of these autokeys really will give us anything not already found above (IE: just different name, stname, zip lookups)
	// dKeyfaa_airmen__autokey__name					:= 	project(PRTE_CSV.faa_airmen.dthor_data400__key__faa__airmen__autokey__name, PRTE_CSV.faa_airmen.rthor_data400__key__faa__airmen__autokey__name);
	// dKeyfaa_airmen__autokey__stname				:= 	project(PRTE_CSV.faa_airmen.dthor_data400__key__faa__airmen__autokey__stname , PRTE_CSV.faa_airmen.rthor_data400__key__faa__airmen__autokey__stname);
	// dKeyfaa_airmen__autokey__zip					:= 	project(PRTE_CSV.faa_airmen.dthor_data400__key__faa__airmen__autokey__zip, PRTE_CSV.faa_airmen. rthor_data400__key__faa__airmen__autokey__zip);
	

// ********************** END faa_airman *********************** start faa 
	// faa_AIRCRAFT


// ****************************************************************************************************************	
//LinkIDs were all the way at the bottom but they look like they may contain a lot of fields not in the above...
// ****************************************************************************************************************	
	LAY3 := RECORD
			PRTE_CSV.faa.rthor_data400__key__faa__LinkIDs and NOT [__fpos, fp, lf];		// syntax check says doesn't contain __fileposition__ 
	END;
	DS3		:= 	join(DS2,		project(PRTE_CSV.faa.dthor_data400__key__faa__LinkIDs, LAY3)
							,left.did_out6= (UNSIGNED6)right.did_out
							and left.st=right.st
							and left.lname=(string)right.lname
							and left.fname=right.fname
							,left outer
							,keep(1)
							);
	
	OUTPUT(DS3,,'~prte::TMP::Research::FAA_Joins_V2',OVERWRITE);		
// ****************************************************************************************************************	
// ********************** We need to browse through all these to see if these contain anything important.	
// ****************************************************************************************************************	
/*	
  dKeyfaa__aircraft_info		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__aircraft_info , PRTE_CSV.faa.rthor_data400__key__faa__aircraft_info);
  dKeyfaa__engine_info		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__engine_info , PRTE_CSV.faa.rthor_data400__key__faa__engine_info);

	rkey__faa__aircraft_id	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__aircraft_id and not [lf, __internal_fpos__];
			unsigned8 persistent_record_id:= 0;
			BIPV2.IDlayouts.l_xlink_ids;
	end;
	
  dKeyfaa__aircraft_id		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__aircraft_id , rkey__faa__aircraft_id);

	rkey__faa__aircraft_reg_bdid	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__aircraft_reg_bdid;
	end;
	
  dKeyfaa__aircraft_reg_bdid		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__aircraft_reg_bdid , rkey__faa__aircraft_reg_bdid);

	rkey__faa__aircraft_reg_did	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__aircraft_reg_did;
			 unsigned8 persistent_record_id:= 0;
	end;
	
  dKeyfaa__aircraft_reg_did		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__aircraft_reg_did , rkey__faa__aircraft_reg_did);

	rkey__faa__aircraft_reg_nnum	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__aircraft_reg_nnum;
			unsigned8 persistent_record_id := 0;
	end;
	
    dKeyfaa__aircraft_reg_nnum		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__aircraft_reg_nnum , rkey__faa__aircraft_reg_nnum);

	rkey__faa__airmen_certs	:=
			record
				PRTE_CSV.faa.rthor_data400__key__faa__airmen_certs;
				unsigned8 persistent_record_id:= 0
	end;

// ********************** still main section = faa 
	// FAA_Airmen
  dKeyfaa__airmen_certs		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__airmen_certs, rkey__faa__airmen_certs);

	rkey__faa__airmen_did	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__airmen_did;
			unsigned8 persistent_record_id:= 0
	end;
	
  dKeyfaa__airmen_did		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__airmen_did, rkey__faa__airmen_did);

	rkey__faa__airmen_id	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__airmen_id;
			unsigned8 persistent_record_id := 0; 
	end;
	
  dKeyfaa__airmen_id	:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__airmen_id, rkey__faa__airmen_id);

	rkey__faa__airmen_rid	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__airmen_rid;
					unsigned8 persistent_record_id := 0; 
	end;
  dKeyfaa__airmen_rid	:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__airmen_rid, rkey__faa__airmen_rid);


// ********************** still main section = faa 
	// FAA_autokeys
	rkey__faa__autokey__address	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__autokey__address;
	end;	
	dkey__faa__autokey__address			            := 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__address, rkey__faa__autokey__address);

	rKeyfaa__autokey__addressb2	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__autokey__addressb2;
	end;
	
	dKeyfaa__autokey__addressb2		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__addressb2 , rKeyfaa__autokey__addressb2);

   rKeyfaa__autokey__citystname	:=
			record
				PRTE_CSV.faa.rthor_data400__key__faa__autokey__citystname;
	end;
	dKeyfaa__autokey__citystname		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__citystname, rKeyfaa__autokey__citystname);

  rKeyfaa__autokey__citystnameb2	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__autokey__citystnameb2;
	end;
	dKeyfaa__autokey__citystnameb2		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__citystnameb2, rKeyfaa__autokey__citystnameb2);

	rKeyfaa__autokey__name	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__autokey__name;
	end;
	dKeyfaa__autokey__name					:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__name, rKeyfaa__autokey__name);
 
	rKeyfaa__autokey__nameb2	:=
		record
			PRTE_CSV.faa.rthor_data400__key__faa__autokey__nameb2;
	end;
	dKeyfaa__autokey__nameb2				:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__nameb2, rKeyfaa__autokey__nameb2);

	dKeyfaa__autokey__namewords2		:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__namewords2, PRTE_CSV.faa.rthor_data400__key__faa__autokey__namewords2);
	dKeyfaa__autokey__ssn2					:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__ssn2, PRTE_CSV.faa.rthor_data400__key__faa__autokey__ssn2);
	dKeyfaa__autokey__stname				:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__stname , PRTE_CSV.faa.rthor_data400__key__faa__autokey__stname);
	dKeyfaa__autokey__stnameb2			:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__stnameb2, PRTE_CSV.faa.rthor_data400__key__faa__autokey__stnameb2);
	dKeyfaa__autokey__zip					:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__zip, PRTE_CSV.faa. rthor_data400__key__faa__autokey__zip);
	dKeyfaa__autokey__zipb2				:= 	project(PRTE_CSV.faa.dthor_data400__key__faa__autokey__zipb2, PRTE_CSV.faa. rthor_data400__key__faa__autokey__zipb2);
*/

/*   ??? DO we need each of these as well or are they handled above?   USUALLY Danny says we don't need FCRA versions of the keys...
//  AND IT LOOKS LIKE ALL OF THESE COME FROM CSV FILES LOADED ABOVE - 99% SURE THERE IS NOTHING NEW HERE BELOW...
// FCRA FAA Keys 
   kKeyfaa__aircraft_reg_did_fcra	        :=	index(dKeyfaa__aircraft_reg_did,{ did }, {n_number,aircraft_id,persistent_record_id}, '~prte::key::faa::FCRA::' + pIndexVersion + '::aircraftreg_did');
	kKeyfaa__aircraft_info_fcra	        :=	index(dKeyfaa__aircraft_info,{code}, {dKeyfaa__aircraft_info}, '~prte::key::faa::FCRA::' + pIndexVersion + '::aircraft_info');
	kKeyfaa__aircraft_id_fcra		:=	index(dKeyfaa__aircraft_id,{aircraft_id}, {dKeyfaa__aircraft_id}, '~prte::key::faa::FCRA::' + pIndexVersion + '::aircraft_id');
	kKeyfaa__aircraft_reg_nnum_fcra	        :=	index(dKeyfaa__aircraft_reg_nnum,{n_number,aircraft_id}, {dKeyfaa__aircraft_reg_nnum}, '~prte::key::faa::FCRA::' + pIndexVersion + '::aircraft_reg_nnum');
	kKeyfaa__engine_info_fcra		:=	index(dKeyfaa__engine_info,{code}, {dKeyfaa__engine_info}, '~prte::key::faa::FCRA::' + pIndexVersion + '::engine_info');
	kKeyfaa__airmen_did_fcra		:=	index(dKeyfaa__airmen_did,{did , airmen_id}, {dKeyfaa__airmen_did}, '~prte::key::faa::FCRA::' + pIndexVersion + '::airmen_did');
	kKeyfaa__airmen_rid_fcra		:=	index(dKeyfaa__airmen_rid,{airmen_id,unique_id}, {dKeyfaa__airmen_rid}, '~prte::key::faa::FCRA::' + pIndexVersion + '::airmen_rid');
	kKeyfaa__airmen_certs_fcra		:=	index(dKeyfaa__airmen_certs,{uid}, {dKeyfaa__airmen_certs}, '~prte::key::faa::FCRA::' + pIndexVersion + '::airmen_certs');
	kKeyfaa__airmen_id_fcra		        :=	index(dKeyfaa__airmen_id,{unique_id, airmen_id}, {dKeyfaa__airmen_id}, '~prte::key::faa::FCRA::' + pIndexVersion + '::airmen_id');
*/


