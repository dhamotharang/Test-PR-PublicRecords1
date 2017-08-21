import header,USPS_AIS;

export fn_standardize_alias_street(dataset(header.Layout_Header) inf) := function
	// standardize prim_name by transforming alias prim_name into standard prim_name
	__alias:=USPS_AIS.File_CtyState_Lookup_Alias;
	inf0:=distribute(inf,hash(zip,prim_name));
	
	als  := dedup(sort(distribute(__alias(	Alias_Street_Information.Street_Name
										<>	Street_Information.Street_Name)
								,hash(zip_code,Alias_Street_Information.Street_Name))
					,zip_code
					,Alias_Street_Information.street_pre_drctn_abbrev
					,Alias_Street_Information.Street_Name
					,Alias_Street_Information.street_suffix_abbrev
					,Alias_Street_Information.street_post_drctn_abbrev
					,local)
				,zip_code
				,Alias_Street_Information.street_pre_drctn_abbrev
				,Alias_Street_Information.Street_Name
				,Alias_Street_Information.street_suffix_abbrev
				,Alias_Street_Information.street_post_drctn_abbrev
				,local);

	inf1:= join(inf0, als
					,	left.zip		= right.zip_code
					and	left.predir		= right.Alias_Street_Information.street_pre_drctn_abbrev
					and	left.prim_name	= right.Alias_Street_Information.Street_Name
					and	left.suffix		= right.Alias_Street_Information.street_suffix_abbrev
					and	left.postdir	= right.Alias_Street_Information.street_post_drctn_abbrev
					,transform(recordof(inf)
								,self.predir	:=right.Alias_Street_Information.street_pre_drctn_abbrev 	//for consistency only; not necessary
								,self.prim_name	:=right.Alias_Street_Information.Street_Name
								,self.suffix	:=right.Alias_Street_Information.street_suffix_abbrev		//for consistency only; not necessary
								,self.postdir	:=right.Alias_Street_Information.street_post_drctn_abbrev	//for consistency only; not necessary
								,self			:=left )
					,left outer
					,LOOKUP
					,local);

	return inf1;

end;