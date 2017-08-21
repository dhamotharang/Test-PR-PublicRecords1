EXPORT proc_udfs(
	 string	 pversion		= ''
	,boolean pUseProd 	= false
	,boolean pUseDelta 	= false) := module

	mudf_base := DISTRIBUTED(Bair.files('', pUseProd, pUseDelta).mo_udf_Base.built(eid <> ''), hash(eid));
	
	mudf_types := record
		UNSIGNED4	ori;
		unsigned1 udf1_type; // 1-string, 2-integer, 3-decimal, 4-date, 5-boolean
		unsigned1 udf2_type;
		unsigned1 udf3_type;
		unsigned1 udf4_type;
		unsigned1 udf5_type;
		unsigned1 udf6_type;
		unsigned1 udf7_type;
		unsigned1 udf8_type;
	end;
	
	mtypes := project(mudf_base(string_val <> '' or integer_val <> 0 or decimal_val <> 0.0 or datetime_val <> '' or yes_no_val <> '')
								,transform(mudf_types,
									Self.udf1_type	:= IF(left.fieldid=1,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									Self.udf2_type	:= IF(left.fieldid=2,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									Self.udf3_type	:= IF(left.fieldid=3,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									Self.udf4_type	:= IF(left.fieldid=4,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									Self.udf5_type	:= IF(left.fieldid=5,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									Self.udf6_type	:= IF(left.fieldid=6,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									Self.udf7_type	:= IF(left.fieldid=7,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									Self.udf8_type	:= IF(left.fieldid=8,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									self := left;
								));

	mtypes roll_mudf(mtypes L, mtypes R) := TRANSFORM
		SELF.udf1_type := if(L.udf1_type <> 0, L.udf1_type, R.udf1_type);
		SELF.udf2_type := if(L.udf2_type <> 0, L.udf2_type, R.udf2_type);
		SELF.udf3_type := if(L.udf3_type <> 0, L.udf3_type, R.udf3_type);
		SELF.udf4_type := if(L.udf4_type <> 0, L.udf4_type, R.udf4_type);
		SELF.udf5_type := if(L.udf5_type <> 0, L.udf5_type, R.udf5_type);
		SELF.udf6_type := if(L.udf6_type <> 0, L.udf6_type, R.udf6_type);
		SELF.udf7_type := if(L.udf7_type <> 0, L.udf7_type, R.udf7_type);
		SELF.udf8_type := if(L.udf8_type <> 0, L.udf8_type, R.udf8_type);
		self := L;
	END;

	mtypes_r := rollup(sort(distribute(mtypes, hash(ori)), ori, local), left.ori = right.ori, roll_mudf(left, right), local);
	
	mudf_tmp := RECORD
		UNSIGNED4	data_provider_id;
		string23 	eid 		:= '';
		string 		moudf1	:='';
		string 		moudf2	:='';
		string 		moudf3	:='';
		string 		moudf4	:='';
		string 		moudf5	:='';
		string 		moudf6	:='';
		string 		moudf7	:='';
		string 		moudf8	:='';
		UNSIGNED5	recordID_RAIDS;
	end;
	
	mudfv2_p := project(mudf_base(string_val <> '' or integer_val <> 0 or decimal_val <> 0.0 or datetime_val <> '' or yes_no_val <> '')
				,transform(mudf_tmp,
						self.data_provider_id := left.ori;
						Self.moudf1						:= IF(left.fieldid=1,if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, if(left.yes_no_val <> '', left.yes_no_val, left.string_val)))), '');
						Self.moudf2						:= IF(left.fieldid=2,if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, if(left.yes_no_val <> '', left.yes_no_val, left.string_val)))), '');
						Self.moudf3						:= IF(left.fieldid=3,if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, if(left.yes_no_val <> '', left.yes_no_val, left.string_val)))), '');
						Self.moudf4						:= IF(left.fieldid=4,if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, if(left.yes_no_val <> '', left.yes_no_val, left.string_val)))), '');
						Self.moudf5						:= IF(left.fieldid=5,if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, if(left.yes_no_val <> '', left.yes_no_val, left.string_val)))), '');
						Self.moudf6						:= IF(left.fieldid=6,if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, if(left.yes_no_val <> '', left.yes_no_val, left.string_val)))), '');
						Self.moudf7						:= IF(left.fieldid=7,if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, if(left.yes_no_val <> '', left.yes_no_val, left.string_val)))), '');
						Self.moudf8						:= IF(left.fieldid=8,if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, if(left.yes_no_val <> '', left.yes_no_val, left.string_val)))), '');
						self := left;
						));
	
	mudfv2_r := ROLLUP(SORT(mudfv2_p, data_provider_id, eid, recordid_raids, local)
				,LEFT.eid = RIGHT.eid and LEFT.recordid_raids = RIGHT.recordid_raids and LEFT.data_provider_id = RIGHT.data_provider_id
				,TRANSFORM(mudf_tmp,
						SELF.MoUDF1 := IF(LEFT.MoUDF1<>'', LEFT.MoUDF1, RIGHT.MoUDF1), 
						SELF.MoUDF2 := IF(LEFT.MoUDF2<>'', LEFT.MoUDF2, RIGHT.MoUDF2), 
						SELF.MoUDF3 := IF(LEFT.MoUDF3<>'', LEFT.MoUDF3, RIGHT.MoUDF3), 
						SELF.MoUDF4 := IF(LEFT.MoUDF4<>'', LEFT.MoUDF4, RIGHT.MoUDF4), 
						SELF.MoUDF5 := IF(LEFT.MoUDF5<>'', LEFT.MoUDF5, RIGHT.MoUDF5), 
						SELF.MoUDF6 := IF(LEFT.MoUDF6<>'', LEFT.MoUDF6, RIGHT.MoUDF6), 
						SELF.MoUDF7 := IF(LEFT.MoUDF7<>'', LEFT.MoUDF7, RIGHT.MoUDF7), 
						SELF.MoUDF8 := IF(LEFT.MoUDF8<>'', LEFT.MoUDF8, RIGHT.MoUDF8),
						SELF 				:= LEFT
					), local);
					
	mudf_w_type := join(mudfv2_r, mtypes_r, left.data_provider_id = right.ori, lookup);
	
	export mov2 := join(bair.files('', pUseProd, pUseDelta).mo_base.built
							,mudf_w_type
							,left.data_provider_id = right.data_provider_id and left.eid = right.eid and left.recordid_raids = right.recordid_raids
							,transform(Bair.Layouts.mudfv2_Key, self.eid := left.eid; self.stamp := left.mostamp; self.data_provider_id := left.data_provider_id; self := right;)
							,keep(1)
							,local);
							
	pudf_base := DISTRIBUTED(Bair.files('', pUseProd, pUseDelta).persons_udf_Base.built, hash(eid));
	
	pudf_types := record
		UNSIGNED4	ori;
		unsigned1 personudf1_type; // 1-string, 2-integer, 3-decimal, 4-date, 5-boolean
		unsigned1 personudf2_type; 
		unsigned1 personudf3_type; 
		unsigned1 personudf4_type; 
	end;
	
	ptypes := project(pudf_base(string_val <> '' or integer_val <> 0 or decimal_val <> 0.0 or datetime_val <> '' or yes_no_val <> '')
								,transform(pudf_types,
									Self.personudf1_type	:= IF(left.fieldid=9,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									Self.personudf2_type	:= IF(left.fieldid=10,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									Self.personudf3_type	:= IF(left.fieldid=11,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									Self.personudf4_type	:= IF(left.fieldid=12,if(left.integer_val <> 0, 2, if(left.decimal_val <> 0.0, 3, if(left.datetime_val<>'', 4, if(left.yes_no_val <> '', 5, 1)))), 0);
									self := left;
								));

	ptypes roll_pudf(ptypes L, ptypes R) := TRANSFORM
		SELF.personudf1_type := if(L.personudf1_type <> 0, L.personudf1_type, R.personudf1_type);
		SELF.personudf2_type := if(L.personudf2_type <> 0, L.personudf2_type, R.personudf2_type);
		SELF.personudf3_type := if(L.personudf3_type <> 0, L.personudf3_type, R.personudf3_type);
		SELF.personudf4_type := if(L.personudf4_type <> 0, L.personudf4_type, R.personudf4_type);
		self := L;
	END;

	ptypes_r := rollup(sort(distribute(ptypes, hash(ori)), ori, local), left.ori = right.ori, roll_pudf(left, right), local);
							
	pudf_tmp := RECORD
		UNSIGNED4	data_provider_id;
		string23 	eid 				:= '';
		string 		personudf1	:='';
		string 		personudf2	:='';
		string 		personudf3	:='';
		string 		personudf4	:='';
		UNSIGNED5	recordID_RAIDS;
	end;
	
	pudfv2_p := project(pudf_base(string_val <> '' or integer_val <> 0 or decimal_val <> 0.0 or datetime_val <> '' or yes_no_val <> '')
				,transform(pudf_tmp,
						self.data_provider_id := left.ori;
						Self.personudf1				:= IF(left.fieldid=9,if(left.string_val <> '', left.string_val, if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, left.yes_no_val)))),'');
						Self.personudf2				:= IF(left.fieldid=10,if(left.string_val <> '', left.string_val, if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, left.yes_no_val)))),'');
						Self.personudf3				:= IF(left.fieldid=11,if(left.string_val <> '', left.string_val, if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, left.yes_no_val)))),'');
						Self.personudf4				:= IF(left.fieldid=12,if(left.string_val <> '', left.string_val, if(left.integer_val <> 0, (string)left.integer_val, if(left.decimal_val <> 0.0, (string)left.decimal_val, if(left.datetime_val<>'', left.datetime_val, left.yes_no_val)))),'');
						self := left;
						));
		
	pudfv2_r := ROLLUP(SORT(pudfv2_p, data_provider_id, eid, recordid_raids, local)
				,LEFT.eid = RIGHT.eid and LEFT.recordid_raids = RIGHT.recordid_raids and LEFT.data_provider_id = RIGHT.data_provider_id
				,transform(pudf_tmp,
						SELF.personudf1 := IF(LEFT.personudf1<>'', LEFT.personudf1, RIGHT.personudf1), 
						SELF.personudf2 := IF(LEFT.personudf2<>'', LEFT.personudf2, RIGHT.personudf2), 
						SELF.personudf3 := IF(LEFT.personudf3<>'', LEFT.personudf3, RIGHT.personudf3), 
						SELF.personudf4 := IF(LEFT.personudf4<>'', LEFT.personudf4, RIGHT.personudf4),
						SELF 						:= LEFT
						));	
	
	pudf_w_type := join(pudfv2_r, ptypes_r, left.data_provider_id = right.ori, lookup);
	
	export perv2 := join(bair.files('', pUseProd, pUseDelta).persons_base.built
							,pudf_w_type
							,left.data_provider_id = right.data_provider_id and left.eid = right.eid and left.recordid_raids = right.recordid_raids
							,transform(Bair.Layouts.pudfv2_Key, self.eid := left.eid; self.stamp := left.personstamp; self.data_provider_id := left.data_provider_id; self := right;)
							,keep(1)
							,local);
END;