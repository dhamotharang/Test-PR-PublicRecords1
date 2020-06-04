import ut, STD;

export	Mac_Setup_Latest_VehFlag	:=
module

	// setup owner flag fields
	export owner_latest_vehflag(dataset(VehicleV2.Layout_Base.Party_CCPA)	owner_seq,boolean	set_historyflag) :=
	function
		owner_seq_dist				:= distribute(owner_seq,hash(vehicle_key,iteration_key));
		owner_seq_dedup				:= dedup(sort(owner_seq_dist,vehicle_key,iteration_key,-sequence_key,local),vehicle_key,iteration_key,local);
		owner_seq_dedup_dist	:= distribute(owner_seq_dedup,hash(vehicle_key,iteration_key));

		owner_seq_dist townjoin(owner_seq_dist	L,owner_seq_dedup_dist	R) :=
		transform
			self.Latest_Vehicle_Flag						:=	if(l.sequence_key	=	r.sequence_key,'Y','N');
			self.Latest_Vehicle_iteration_Flag	:=	if(l.sequence_key	=	r.sequence_key,'Y','N');
			self.history												:=	if(set_historyflag,if(L.sequence_key	=	r.sequence_key,'','H'),L.history);
			self																:=	L;
		end;

		owner_out	:=	join(	owner_seq_dist,
												owner_seq_dedup_dist,
												Left.vehicle_key		= right.vehicle_key and
												Left.iteration_key	= right.iteration_key,
												townjoin(left,right),
												left outer,
												local
											);

		return	owner_out;
	end;

	// setup EXP reg flag fields
	export reg_latest_vehflag(dataset(VehicleV2.Layout_Base.Party_CCPA)	reg_seq,boolean	set_historyflag) :=
	function
		reg_seq_dist				:= distribute(reg_seq,hash(vehicle_key,iteration_key));
		reg_seq_dedup				:= dedup(sort(reg_seq_dist,vehicle_key,iteration_key,-sequence_key,local),vehicle_key,iteration_key,local);
		reg_seq_dedup_dist	:= distribute(reg_seq_dedup,hash(vehicle_key,iteration_key));

		reg_seq_dist tregjoin(reg_seq_dist	L,reg_seq_dedup_dist	R) :=
		transform
			self.Latest_Vehicle_Flag						:=	if(l.sequence_key	=	r.sequence_key,'Y','N');
			self.Latest_Vehicle_iteration_Flag	:=	if(l.sequence_key	=	r.sequence_key,'Y','N');
			self.history												:=	if(	set_historyflag,
																									if(	L.sequence_key	=	r.sequence_key,
																											if(	r.Reg_Latest_Expiration_Date	>	(STRING8)Std.Date.Today()	or	(unsigned4)r.Reg_Latest_Expiration_Date	=	0,
																													'',
																													if(r.Reg_Latest_Effective_Date	<	(string4)((unsigned2)((STRING8)Std.Date.Today())[1..4]	-	1)	+	((STRING8)Std.Date.Today())[5..8],'H','E')
																												),
																											'H'
																										 ),
																									L.history
																								);
			self																:=	L;
		end;

		reg_out	:=	join(	reg_seq_dist,
											reg_seq_dedup_dist,
											Left.vehicle_key		=	right.vehicle_key and
											Left.iteration_key	=	right.iteration_key,
											tregjoin(left,right),
											left outer,
											local
										);

		return	reg_out;
	end;

	//setup NC reg flag fields
	export NC_reg_latest_vehflag(dataset(VehicleV2.Layout_Base.Party_CCPA) reg_seq,boolean set_historyflag) :=
	function

		reg_seq_dist				:= distribute(reg_seq,hash(vehicle_key,iteration_key));
		reg_seq_dedup				:= dedup(sort(reg_seq_dist,vehicle_key,iteration_key,-sequence_key,local),vehicle_key,iteration_key,local);
		reg_seq_dedup_dist	:= distribute(reg_seq_dedup,hash(vehicle_key,iteration_key));

		reg_seq_dist tregjoin(reg_seq_dist L,reg_seq_dedup_dist R) :=
		transform
			self.Latest_Vehicle_Flag 						:= if(l.sequence_key = r.sequence_key,'Y','N');
			self.Latest_Vehicle_iteration_Flag	:= if(l.sequence_key = r.sequence_key,'Y','N');
			self.history   											:= if(	set_historyflag,
																									if(	L.sequence_key = r.sequence_key,
																											if(	r.Reg_Latest_Expiration_Date > (STRING8)Std.Date.Today() or (unsigned4)r.Reg_Latest_Expiration_Date = 0,
																													'',
																													if(r.Reg_Latest_Effective_Date < (string4)((unsigned2)((STRING8)Std.Date.Today())[1..4] - 1) + ((STRING8)Std.Date.Today())[5..8],'H','E')
																												),
																											'H'
																										),
																									L.history
																								);                                  
			self																:= L;
		end;

		reg_out := join(reg_seq_dist,
										reg_seq_dedup_dist,
										Left.vehicle_key = right.vehicle_key and
										Left.iteration_key = right.iteration_key,
										tregjoin(left,right),
										left outer,
										local);

		return reg_out;
	end;

	//setup OH reg flag fields
	export	OH_reg_latest_vehflag(dataset(VehicleV2.Layout_Base.Party_CCPA)	reg_seq,boolean	set_historyflag) :=
	function

		reg_seq_dist				:= distribute(reg_seq,hash(vehicle_key,iteration_key));
		reg_seq_dedup				:= dedup(sort(reg_seq_dist,vehicle_key,iteration_key,-sequence_key,local),vehicle_key,iteration_key,local);
		reg_seq_dedup_dist	:= distribute(reg_seq_dedup,hash(vehicle_key,iteration_key));

		reg_seq_dist tregjoin(reg_seq_dist L,reg_seq_dedup_dist R) :=
		transform
			self.Latest_Vehicle_Flag						:= if(l.sequence_key	=	r.sequence_key,'Y','N');
			self.Latest_Vehicle_iteration_Flag	:= if(l.sequence_key	=	r.sequence_key,'Y','N');
			self.history												:= if(set_historyflag,
																								if(L.sequence_key	=	r.sequence_key,
																									 if(r.Reg_Latest_Expiration_Date	>	(STRING8)Std.Date.Today()	or	(unsigned4)r.Reg_Latest_Expiration_Date	=	0,
																											'',
																											if(r.Reg_Latest_Effective_Date	<	(string4)((unsigned2)((STRING8)Std.Date.Today())[1..4] - 1)	+	((STRING8)Std.Date.Today())[5..8],'H','E')),
																									 'H'),
																								L.history);
			self																:= L;
		end;

		reg_out	:=	join(	reg_seq_dist,reg_seq_dedup_dist,
											Left.vehicle_key		=	right.vehicle_key	and
											Left.iteration_key	=	right.iteration_key,
											tregjoin(left,right),
											left outer,
											local
										);

		return	reg_out;
	end;
	
	//setup MA reg flag fields
	export	MA_reg_latest_vehflag(dataset(VehicleV2.Layout_Base.Party_CCPA)	reg_seq,boolean	set_historyflag) :=
	function

		reg_seq_dist				:= distribute(reg_seq,hash(vehicle_key,iteration_key));
		reg_seq_dedup				:= dedup(sort(reg_seq_dist,vehicle_key,iteration_key,-sequence_key,local),vehicle_key,iteration_key,local);
		reg_seq_dedup_dist	:= distribute(reg_seq_dedup,hash(vehicle_key,iteration_key));

		reg_seq_dist tregjoin(reg_seq_dist L,reg_seq_dedup_dist R) :=
		transform
			self.Latest_Vehicle_Flag						:= if(l.sequence_key	=	r.sequence_key,'Y','N');
			self.Latest_Vehicle_iteration_Flag	:= if(l.sequence_key	=	r.sequence_key,'Y','N');
			self.history												:= if(set_historyflag,
																								if(L.sequence_key	=	r.sequence_key,
																									 if(r.Reg_Latest_Expiration_Date	>	(STRING8)Std.Date.Today()	or	(unsigned4)r.Reg_Latest_Expiration_Date	=	0,
																											'',
																											if(r.Reg_Latest_Effective_Date	<	(string4)((unsigned2)((STRING8)Std.Date.Today())[1..4] - 1)	+	((STRING8)Std.Date.Today())[5..8],'H','E')),
																									 'H'),
																								L.history);
			self																:= L;
		end;

		reg_out	:=	join(	reg_seq_dist,reg_seq_dedup_dist,
											Left.vehicle_key		=	right.vehicle_key	and
											Left.iteration_key	=	right.iteration_key,
											tregjoin(left,right),
											left outer,
											local
										);

		return	reg_out;
	end;

end;