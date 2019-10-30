import  STD,PRTE2, _control, PRTE;  
EXPORT PROC_BUILD_rid(String pversion) := FUNCTION
rid_layout:=RECORD
  unsigned8 rid;
  unsigned6 lnpid;
  integer2 rid_weight100;
  unsigned8 __internal_fpos__;
 END;
 
 rid_Build :=  DATASET([ ],rid_layout);
 rid_key := INDEX(rid_Build,
 {rid,lnpid, rid_weight100},{rid_Build},
	 prte2.constants.prefix + 'key::healthcareprovider::' + pversion + '::rid'); 
  
	BUILDindex(rid_Key);
 
 return 'Successful';
 end;

 