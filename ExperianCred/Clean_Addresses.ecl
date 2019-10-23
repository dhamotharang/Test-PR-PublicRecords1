import ut,address;

export Clean_Addresses(string ver):= module

norm_addr := ExperianCred.Normalize_Address(ver).all;
cache_addr := distribute(ExperianCred.Files.Cashed_Address_File, 
			  hash(Orig_Prim_Range, Orig_Predir, Orig_Prim_Name, Orig_Addr_Suffix, Orig_Postdir, Orig_Unit_Desig, Orig_Sec_Range, Orig_City, Orig_State, Orig_ZipCode)) :INDEPENDENT; 

d_addresses:= distribute(norm_addr,
			  hash(Orig_Prim_Range, Orig_Predir, Orig_Prim_Name, Orig_Addr_Suffix, Orig_Postdir, Orig_Unit_Desig, Orig_Sec_Range, Orig_City, Orig_State, Orig_ZipCode))  :INDEPENDENT; 

dedup_addr := dedup(sort(d_addresses,Orig_Prim_Range, Orig_Predir, Orig_Prim_Name, Orig_Addr_Suffix, Orig_Postdir, Orig_Unit_Desig, Orig_Sec_Range, Orig_City, Orig_State, Orig_ZipCode,LOCAL),
								     Orig_Prim_Range, Orig_Predir, Orig_Prim_Name, Orig_Addr_Suffix, Orig_Postdir, Orig_Unit_Desig, Orig_Sec_Range, Orig_City, Orig_State, Orig_ZipCode, LOCAL) ; 

//-----------------------------------------------------------------
//Match address to cache address
//-----------------------------------------------------------------
ExperianCred.Layouts.Layout_Clean_Address t_get_cleaned_addr(dedup_addr le, cache_addr ri) := transform
	self.Clean_Address := ri.Clean_Address;
	self := le;
 end;
 
addr_cleaned_cache := join(dedup_addr, cache_addr,
							left.Orig_Prim_Range = right.Orig_Prim_Range and
						    left.Orig_Predir = right.Orig_Predir and
						    left.Orig_Prim_Name = right.Orig_Prim_Name and
							left.Orig_Addr_Suffix = right.Orig_Addr_Suffix and
							left.Orig_Postdir = right.Orig_Postdir and
							left.Orig_Unit_Desig = right.Orig_Unit_Desig and
							left.Orig_Sec_Range = right.Orig_Sec_Range and
							left.Orig_City = right.Orig_City and
							left.Orig_State = right.Orig_State and
							left.Orig_ZipCode = right.Orig_ZipCode,							
							t_get_cleaned_addr(left, right), 
							left outer, 
							local);

addr_in_cache 	:= addr_cleaned_cache(Clean_Address <> '');
addr_to_clean  := addr_cleaned_cache(Clean_Address = '');

//-----------------------------------------------------------------
////Clean addresses not found in cache address
//-----------------------------------------------------------------
ExperianCred.Layouts.Layout_Clean_Address t_clean_address (addr_to_clean le) := transform
	Address1 :=  StringLib.StringCleanSpaces(le.Orig_Prim_Range + ' ' + le.Orig_Predir + ' ' + le.Orig_Prim_Name + ' ' + le.Orig_Addr_Suffix + ' ' + le.Orig_Postdir);
	Address2 :=  StringLib.StringCleanSpaces(le.Orig_Unit_Desig + ' ' + le.Orig_Sec_Range);
	
	SELF.Clean_Address := address.CleanAddress182(Address1 + ' ' + Address2, le.Orig_City + ' ' + le.Orig_State + ' ' + le.Orig_ZipCode);
	SELF := le;
END;

addr_clean := project(addr_to_clean,t_clean_address(left)); 

BuildCashAddress :=
	SEQUENTIAL(OUTPUT(addr_clean,,Superfile_List.Cache_Address_File + ver ,overwrite,__compressed__);
					FileServices.StartSuperFileTransaction(),				
					FileServices.AddSuperFile(Superfile_List.Cache_Address_File,Superfile_List.Cache_Address_File + ver),
					FileServices.FinishSuperFileTransaction());
		   
export ALL := BuildCashAddress;
 
END;
