IMPORT header,mdr,ut,address;

dMain:=DEDUP(DISTRIBUTE(reunion.mapping_reunion_main(get_other_elements=TRUE AND TRIM(date_of_death)=''),HASH(did)),did,ALL,LOCAL);
dMainDeduped:=DEDUP(SORT(DISTRIBUTE(dMain,HASH(did,prim_range,prim_name,sec_range,zip)),did,prim_range,prim_name,sec_range,zip,LOCAL),did,prim_range,prim_name,sec_range,zip,ALL,LOCAL);

dHeader:=DISTRIBUTE(reunion.files.file_header_nonglb_dppa(~(mdr.sourcetools.sourceisdeath(src))),HASH(prim_range,prim_name,sec_range,zip));
dAddressRecency:=DISTRIBUTE(header.address_recency(dHeader,48).recent_addresses,HASH(prim_range,prim_name,sec_range,zip));
dHeaderRecency:=DISTRIBUTE(JOIN(dHeader,dAddressRecency,LEFT.prim_range=RIGHT.prim_range AND LEFT.prim_name=RIGHT.prim_name AND LEFT.sec_range=RIGHT.sec_range AND LEFT.zip=RIGHT.zip,TRANSFORM(header.Layout_Header,SELF:=LEFT;),LOCAL),HASH(did));
													
lRecency:=RECORD
  dHeaderRecency.did;
  STRING10 prim_range;
  STRING2 predir;
  STRING28 prim_name;
  STRING4 suffix;
  STRING2 postdir;
  STRING10 unit_desig;
  STRING8 sec_range;
  STRING25 city_name;
  STRING2 st;
  STRING5 zip;
  STRING4 zip4;
  UNSIGNED6 addr_id;
  UNSIGNED3 min_dt_first_seen:=0;
  UNSIGNED3 max_dt_last_seen:=0;
  INTEGER counter_:=0;
END;

lRecency tGetAddressID(dHeaderRecency L,dMainDeduped R):=TRANSFORM
  SELF.unit_desig:=IF(TRIM(L.sec_range)='','',IF(TRIM(L.unit_desig)='' AND L.sec_range<>'','#',L.unit_desig));
  SELF.addr_id:=HASH64(stringlib.stringcleanspaces(L.prim_range+L.predir+L.prim_name+L.postdir+L.suffix+L.sec_range+L.city_name+L.st+L.zip));
  SELF.min_dt_first_seen:=L.dt_first_seen;
  SELF.max_dt_last_seen:=L.dt_last_seen;
  SELF:= L;
END;
dWithID:=SORT(DISTRIBUTE(JOIN(dHeaderRecency,dMainDeduped,left.did=right.did,tGetAddressID(LEFT,RIGHT),LOCAL),HASH(did,addr_id)),did,addr_id,LOCAL);	  

lRecency tRoll(dWithID L,dWithID R):=TRANSFORM
  SELF.min_dt_first_seen:=ut.Min2(L.min_dt_first_seen,R.min_dt_first_seen);
  SELF.max_dt_last_seen:=ut.max2(L.max_dt_last_seen,R.max_dt_last_seen);
  SELF:=L;
END;
dRolled:=GROUP(SORT(DISTRIBUTE(ROLLUP(dWithID,LEFT.did=RIGHT.did AND LEFT.addr_id=RIGHT.addr_id,tRoll(LEFT,RIGHT),LOCAL),HASH(did)),did,-max_dt_last_seen,LOCAL),did,LOCAL);

//where counter_ equals 3, 4, or 5 SHOULD be the 3 most recent addresses
dMostRecent3:=DISTRIBUTE(PROJECT(dRolled,TRANSFORM(lRecency,SELF.counter_:=COUNTER+1;SELF:=LEFT;))(counter_<=5),HASH(did,prim_range,prim_name,sec_range,zip));

//counter_=2 will hopefully be the BEST address (
//join to BEST address and keep those 3 addresses that don't match
dOldAddresses:=JOIN(dMostRecent3,dMainDeduped,LEFT.did=RIGHT.did AND LEFT.prim_range=RIGHT.prim_range AND LEFT.prim_name=RIGHT.prim_name AND LEFT.sec_range=RIGHT.sec_range AND LEFT.zip=RIGHT.zip,TRANSFORM(lRecency,SELF:=LEFT;),LEFT ONLY,LOCAL);

export old_addresses:=SORT(dOldAddresses,did,-max_dt_last_seen,-min_dt_first_seen):PERSIST('~thor::persist::reunion::old_addresses');