/*--SOAP--
  <message name="Service_AddressLinking">
	<part name="LEXID" type="xsd:string"/>
  <part name="FullResults" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This is a service to look at Address Linking Results.*/

import idl_header,address,adl_idl_mapping,insuranceheader_bestofbest;

EXPORT Service_AddressLinking() := FUNCTION
  string16 Request     := ''    : STORED('LEXID', FEW);
	boolean showFull     := FALSE : STORED('FullResults', FEW);
	boolean showKey      := FALSE : STORED('KeyResults', FEW);
	id := (integer) Request;
	
	export slimrec := record
	  unsigned8 did,
		unsigned8 rid,
    //string9 src,
    integer dt_first_seen,
		integer dt_last_seen,
		integer dt_vendor_first_reported,
		integer dt_vendor_last_reported,
    string2 addr_ind,
    string10 prim_range,
		string predir,
		string28 prim_name,
		string addr_suffix,
		string postdir,
		string  unit_desig,
		string8 sec_range,
		string25 city,
		string2 st,
		string5 zip,
		string4 zip4,
		string addressstatus,
		string addresstype,
		//string1 best_addr_ind,
	end;

	//new results  
	ds := dataset('~thor_data400::base::insuranceheader::idl_salt_iter_w20140109-074938_best',{idl_header.Layout_Header_address,UNSIGNED8 RecPtr {virtual(fileposition)}}, FLAT);
  EXPORT AddrLink_Key := INDEX(ds,{did},{ds},'~thor::address_link::best::key');
  r1        := AddrLink_Key(did=ID); 
	p1        := project(r1,idl_header.Layout_Header_v2);
	goodtypes := ['BUS','SEA','SEC'];  
	badset    := ['OSD','OSR','OSS','OHD','IC1','IC2'];		
  lowdate (unsigned4 dt1, unsigned4 dt2) := IF(dt1=0,dt2,min(dt1,dt2));	
	newResult := rollup(sort(p1(addr_ind<>''),did,addr_ind,prim_range,prim_name,sec_range,-addressstatus),
	                       left.did = right.did and
												 left.addr_ind = right.addr_ind and
												 left.prim_range = right.prim_range and
												 left.prim_name = right.prim_name and
											  (left.sec_range = right.sec_range or
												 left.sec_range = '' or
												 right.sec_range = ''),
												 transform(recordof(left),
												           self.dt_last_seen  := IF(right.addressstatus in badset and right.addresstype not in goodtypes,
																	                          IF(left.addressstatus in badset and left.addresstype not in goodtypes,
																														   IF(left.addr_ind > '90',max(left.dt_last_seen,right.dt_last_seen),0),
																															 left.dt_last_seen),
																														IF(left.addressstatus in badset and left.addresstype not in goodtypes,
 																														   right.dt_last_seen,max(left.dt_last_seen,right.dt_last_seen))),
																	 self.dt_first_seen := IF(left.dt_first_seen = 0, 
																	                          right.dt_first_seen,
																														IF(right.addressstatus in badset and right.addresstype not in goodtypes,
																														   IF(left.addressstatus in badset and left.addresstype not in goodtypes,
																															    IF(left.addr_ind > '90',lowdate(left.dt_first_seen,right.dt_first_seen),0),
																																	left.dt_first_seen),
																															 IF(left.addressstatus in badset and left.addresstype not in goodtypes,
																															    right.dt_first_seen,lowdate(left.dt_first_seen,right.dt_first_seen)))),
                                   self.addressstatus := IF(left.addr_ind > '90',left.addressstatus,'');
                                   self.addresstype   := MAP(left.addresstype='' => right.addresstype,
																	                           right.addresstype='' => left.addresstype,
																														 min(left.addresstype,right.addresstype));																	 
																	 self := right));
  	
  newSlim := sort(project(newResult,slimrec),did,(integer) addr_ind, -dt_last_seen, -dt_first_seen);  
	
	//old results  
	OldRec := record
    idl_header.keys.idl;
		string addressstatus;
		string addresstype
	end;
  r2     := idl_header.keys.idl(did = ID);	
	didrid := adl_idl_mapping.keys.key_rid();
	r3     := join(r2,didrid,
	               left.rid = right.rid,
								 transform(oldrec,
								           self.addressstatus := right.addressstatus,
													 self.addresstype   := right.addresstype,
													 self := left),left outer);
	s3     := sort(r3,did,(integer) addr_ind,prim_range,prim_name,sec_range,-addressstatus);	
	oldResult  := rollup(s3(addr_ind<>''),
	                       left.did = right.did and
												 left.addr_ind = right.addr_ind and
												 left.prim_range = right.prim_range and
												 left.prim_name = right.prim_name and
												(left.sec_range = right.sec_range or
												 left.sec_range = '' or
												 right.sec_range = ''),
												 transform(recordof(left),
												           self.dt_last_seen  := IF(right.addressstatus in badset and right.addresstype not in goodtypes,
																	                          IF(left.addressstatus in badset and left.addresstype not in goodtypes,
																														   IF(left.addr_ind > '90',max(left.dt_last_seen,right.dt_last_seen),0),
																															 left.dt_last_seen),
																														IF(left.addressstatus in badset and left.addresstype not in goodtypes,
 																														   right.dt_last_seen,max(left.dt_last_seen,right.dt_last_seen))),
																	 self.dt_first_seen := IF(left.dt_first_seen = 0, 
																	                          right.dt_first_seen,
																														IF(right.addressstatus in badset and right.addresstype not in goodtypes,
																														   IF(left.addressstatus in badset and left.addresstype not in goodtypes,
																															    IF(left.addr_ind > '90',lowdate(left.dt_first_seen,right.dt_first_seen),0),
																																	left.dt_first_seen),
																															 IF(left.addressstatus in badset and left.addresstype not in goodtypes,
																															    right.dt_first_seen,lowdate(left.dt_first_seen,right.dt_first_seen)))),
                                   self.addressstatus := IF(left.addr_ind > '90',left.addressstatus,'');
                                   self.addresstype   := MAP(left.addresstype='' => right.addresstype,
																	                           right.addresstype='' => left.addresstype,
																														 min(left.addresstype,right.addresstype));																	                                    
																	 self := right));
	
  oldSlim := sort(project(oldResult,slimrec),did,(integer) addr_ind, -dt_last_seen, -dt_first_seen);  										 
	
  map(showFull =>
	   output(sort(p1(addr_ind > '' or (dt_first_seen > 0 and dt_last_seen > 0)),did,(integer) addr_ind),named('new_full_results'),extend),
     output(newSlim,named('new_results'),extend));	
	map(showFull =>
	   output(s3,named('old_full_results'),extend),
     output(oldSlim,named('old_results'),extend));

	RETURN '';
END;