export Mac_fix_lessee_lessor_only(file_in, file_out)	:=
macro	
	// owner and registrant with no name 
	veh_no_name		:=	file_in(orig_name_type	in	['1','4']	and	orig_name	=	'');

	// owner and registrant with name
	veh_with_name	:=	file_in(orig_name_type	in	['1','4']	and	orig_name	<>	'');

	// lienholder, lessor and lesss with name 
	veh_without_reg_owner	:=	file_in(orig_name_type	not in	['1','4']	and	orig_name	<>	'');

	// drop owner and registrant with the same VIN and name type have no name
	veh_no_name_dist		:=	distribute(veh_no_name,hash(state_origin,orig_vin,orig_name_type));
	veh_with_name_dist	:=	distribute(veh_with_name,hash(state_origin,orig_vin,orig_name_type));

	veh_no_name_dist	tjoinnoname(veh_no_name_dist	L,veh_with_name_dist	R) :=
	transform
		self	:=	L ;
	end;

	veh_name_join	:=	join(	veh_no_name_dist,
													veh_with_name_dist,
													left.state_origin		=	right.state_origin	and
													left.orig_vin				=	right.orig_vin			and
													left.orig_name_type	= right.orig_name_type,
													tjoinnoname(left, right),
													left only,
													local
												);

	// combine owner, registrant, lienholder, lessor and lessee 
	file_out	:=	veh_name_join	+	veh_with_name	+	veh_without_reg_owner; 
endmacro;