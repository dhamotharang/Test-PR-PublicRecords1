/*--SOAP--
  <message name="service_test_addresscleaner">
	<part name="line1"                     type="string"/>
	<part name="linelast"                  type="string"/>

  </message>
*/

IMPORT Address,AID_Build,doxie;

EXPORT Service_AddressCacheDebug() := FUNCTION

  STRING line1    := ''	      : STORED('line1');
	STRING linelast := ''				: STORED('linelast');
	
  OutRec := record
		string    source;
		string200 cleanAddress;
	end;

	cleanerAddress := Address.CleanAddress182(StringLib.StringToUpperCase(line1),
	                                          StringLib.StringToUpperCase(linelast));

  
	addressCache := AID_Build.Key_AID_Base_AddressLookup();
  
	cacheSearch  := project(addressCache(hash_line1    = hash64(StringLib.StringToUpperCase(line1)) and
	                                     hash_linelast = hash64(StringLib.StringToUpperCase(linelast)))[1],
												  transform(OutRec, 
													          self.source       := 'CACHE';
													          self.cleanAddress := left.prim_range  + left.predir      + left.prim_name
	                                                     + left.addr_suffix + left.postdir     + left.unit_desig
	                                                     + left.sec_range   + left.p_city_name + left.v_city_name
	                                                     + left.st          + left.zip5        + left.zip4 
								                                       + left.cart        + left.cr_sort_sz  + left.lot         
									                                     + left.lot_order   + left.dbpc        + left.chk_digit   
									                                     + left.rec_type    + left.county      + left.geo_lat
	                                                     + left.geo_long    + left.msa         + left.geo_blk
	                                                     + left.geo_match   + left.err_stat;
																		)
												 );

	
	
	OutDs := dataset([{'CLEANER SERVICE',cleanerAddress}],OutRec) + cacheSearch;  
	
  return OutDs;
END;        