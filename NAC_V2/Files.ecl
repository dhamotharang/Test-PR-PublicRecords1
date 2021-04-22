import ut, Std, NAC_V2;
export Files := module;

	export Base1      := DATASET(Superfile_List.Base,Layouts.base, THOR, opt);
	
	export Base := PROJECT(Base1,
										TRANSFORM(Nac_v2.Layouts.base,
											self.case_benefit_type := IF(left.Case_Benefit_Type='R','S',left.Case_Benefit_Type);
											self := left;
									));		
	
	export BaseBadAddressRemoved:=project(Base
								,transform(Layouts.Base
									,self.prim_name
											:=if(trim(
														regexreplace(Mod_Sets.RegexBadAddress
																,Std.Str.CleanSpaces(left.prim_name),'$2',nocase)
																) in Mod_Sets.SetBadAddress
																			,''
																			,left.prim_name)
									,self:=left));

	export BaseBadAddressRemoved2:=project(BaseBadAddressRemoved,Layouts.Base-[prefname,NCF_FileTime]);
	
	export Payload := DATASET(Superfile_List.sfPayload, nac_v2.Layout_Payload, thor);
	
	export PayloadBadAddressRemoved := PROJECT(Payload
								,transform(Layout_Payload
									,self.prim_name
											:=if(trim(
														regexreplace(Mod_Sets.RegexBadAddress
																,Std.Str.CleanSpaces(left.prim_name),'$2',nocase)
																) in Mod_Sets.SetBadAddress
																			,''
																			,left.prim_name)
									,self:=left));	
									
									
	export Base2 := DATASET(Superfile_List.sfBase2, nac_v2.Layout_Base2, thor, OPT);
	export Base2_Father := DATASET(Superfile_List.sfBase2_father, nac_v2.Layout_Base2, thor, OPT);

	export Base_prev := DATASET(Superfile_List.Base_prev,Layouts.base, THOR);
	export Collisions  := DATASET(Superfile_List.Collisions,Layouts.Collisions, THOR,opt);
	export Collisions2  := DATASET(Superfile_List.sfCollisions, Layout_Collisions2.Layout_Collisions, THOR,opt);
	export fNewCollisions  := DATASET(Superfile_List.sfNewCollisions, Layout_Collisions2.Layout_Collisions, THOR,opt);
	
	//export temp      := DATASET(Superfile_List.temp,{string75 fn { virtual(logicalfilename)},Layouts.load}, THOR);
	export rejected  := DATASET(Superfile_List.rejectedFiles,{string75 fn { virtual(logicalfilename)},Layouts.load}, THOR);
	export test_seed :=
		dataset([
			{'test_seed', 3253586590, 'FL', 'S', '201401', '99999999990000000000', 'MARZZZUPIAL', 'ZOSE', '',
			'1239990001', '1239990001', '', '6601 PARK OF COMMERCE BLVD', '', 'BOCA RATON', 'FL', '334870000',
			'6601 PARK OF COMMERCE BLVD', '', 'BOCA RATON', 'FL', '334870000', '000', '', '99999999990000000000',
			'MARZZZUPIAL', 'ZOSE', '', 'M', 'U', 'U', '123456789', 'A', '19600101', 'A', 'E', '201401', '', 
			'', '', '', '', '', 'MARZZZUPIAL,ZOSE', '6601 PARK OF COMMERCE BLVD', 'BOCA RATON, FL 334870000', 0, 0,
			20140101, 0, 43906301, '', '','', 19600101, 57, 0, 'MR', 'ZOSE', 'ZOSE','', 'MARZZZUPIAL', '',
			'6601', '', 'PARK OF COMMERCE', 'BLVD', '', '', '', 'BOCA RATON', 'BOCA RATON', 'FL', '33487', '8247',
			'C057', 'B', '0031', 'D', '01', '3', 'S ', '12', '099', '26.406957 ', '-80.096880 ', '8960', '0070021', '0', 'S800',
			0, ''}
			], $.Layouts.base);


end;