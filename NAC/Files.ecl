import ut;
export Files(string st='') := module;

	export load_in   := DATASET(Superfile_List(st).in,{string75 fn { virtual(logicalfilename)},Layouts.load}, THOR);
	export load_in_old  := DATASET(Superfile_List(st).in_old,{string75 fn { virtual(logicalfilename)},Layouts.load_old}, THOR);
	export in_history  := DATASET(Superfile_List(st).in_history,{string75 fn { virtual(logicalfilename)},Layouts.load}, THOR);
	export Base      := DATASET(Superfile_List(st).Base,Layouts.base, THOR, opt);

	export BaseBadAddressRemoved:=project(Base
								,transform(Layouts.Base
									,self.prim_name
											:=if(trim(
														regexreplace(Mod_Sets.RegexBadAddress
																,StringLib.StringCleanSpaces(left.prim_name),'$2',nocase)
																) in Mod_Sets.SetBadAddress
																			,''
																			,left.prim_name)
									,self:=left));

	export BaseBadAddressRemoved2:=project(BaseBadAddressRemoved,Layouts.Base-[prefname,NCF_FileTime]);

	export Base_prev := DATASET(Superfile_List(st).Base_prev,Layouts.base, THOR);
	export Collisions  := DATASET(Superfile_List(st).Collisions,Layouts.Collisions, THOR,opt);
	export temp      := DATASET(Superfile_List(st).temp,{string75 fn { virtual(logicalfilename)},Layouts.load}, THOR);
	export rejected  := DATASET(Superfile_List(st).rejected,{string75 fn { virtual(logicalfilename)},Layouts.load}, THOR);
	export test_seed :=
		dataset([
			{'test_seed                                                                  ', 3253586590, 'FL', 'S', '201401', '99999999990000000000', 'MARZZZUPIAL                   ', 'ZOSE                     ', '                         ', '1239990001', '1239990001', '                                                                                                                                                                                                                                                                ', '6601 PARK OF COMMERCE BLVD                                            ', '                                                                      ', 'BOCA RATON                    ', 'FL', '334870000', '6601 PARK OF COMMERCE BLVD                                            ', '                                                                      ', 'BOCA RATON                    ', 'FL', '334870000', '000', '                         ', '99999999990000000000', 'MARZZZUPIAL                   ', 'ZOSE                     ', '                         ', 'M', 'U', 'U', '123456789', 'A', '19600101', 'A', 'E', '201401  ', '          ', '                                                                                                                                                                                                                                                                ', '                                                  ', '          ', '          ', '                                                                                                                                                                                                                                                                ', 'MARZZZUPIAL,ZOSE                                                           ', '6601 PARK OF COMMERCE BLVD                                  ', 'BOCA RATON, FL 334870000           ', 0, 0, 20140101, 0, 43906301, '         ', '         ', 19600101, 54, 0, 'MR   ', 'ZOSE                ', 'ZOSE                ', '                    ', 'MARZZZUPIAL         ', '     ', '6601      ', '  ', 'PARK OF COMMERCE            ', 'BLVD', '  ', '          ', '        ', 'BOCA RATON               ', 'BOCA RATON               ', 'FL', '33487', '8247', 'C057', 'B', '0031', 'D', '01', '3', 'S ', '12', '099', '26.406957 ', '-80.096880 ', '8960', '0070021', '0', 'S800', 0, ' '}
			], NAC.Layouts.base);

end;