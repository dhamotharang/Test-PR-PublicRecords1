export Constants := module

	// shared root := '~thor_data400::key::courtSearch::';
	
	// export str_autokeyname								:= root + 'autokey::';
	// export ak_keyname											:= root + '@version@::autokey::'; //used to build autokeys
	// export ak_logicalname               	:= root + filedate + '::autokey::';
	// export ak_QAname                      := root + 'qa::autokey::';
	// export ak_skipSet											:= ['P','Q','F'];
	// export ak_typeStr											:= 'BC';
	
	export layout_real := record
	          real price;
	 end;
	
	// export StateBasePrice_tmp := project(CourtSearch.key_jurisdiction(Jurisdiction='STATE' AND st='1'),
	                                  // transform(layout_real,
																		   // self.price := (real) left.price,
																			 // self := left
																			 // ));
  // export real StateBasePrice := (real) StateBaseprice_tmp[1].price;				
	export real StateBasePrice := 24;  // this is obtained from running the code above..simpler to list it as a constant.
	export unsigned2 CS_MAX_COMPANIES := 100; // obtained from doing various tests on different company searches
	export String CS_County  := 'COUNTY';
	export String CS_Federal := 'FEDERAL';
	export String CS_State := 'STATE';
	export String CS_CIVIL := 'CIVIL';
	export String CS_CRIMINAL := 'CRIMINAL';
end;