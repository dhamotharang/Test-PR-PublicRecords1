import	_control, PRTE_CSV;

export	Proc_Build_ERO_keys(string pIndexVersion)	:=
function

	rKeyERO_facility_address	:=
	record
		PRTE_CSV.ERO.rCSVERO__facility_address;
	end;
	
	// dKeyERO_facility_address          		:= 	project(PRTE_CSV.Appriss.dCSVERO_facility_address, rKeyERO_facility_address);
		
	dKeyERO_facility_address			:= 	dataset([], rKeyERO_facility_address);
	
	kKeyERO_facility_address	           :=	//index(dKeyERO_facility_address,{state_id},{booking_sid}, '~prte::key::Appriss::' + pIndexVersion + '::state_id');
                                          index(dKeyERO_facility_address, {prim_range,prim_name,zip,recptr},
                                                '~prte::key::ERO::'+ pIndexVersion +'::Facility_address' );
	return	sequential(							
											build(kKeyERO_facility_address		    , update)		,														
											
											PRTE.UpdateVersion('ERO_Keys',							   			    //	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;

