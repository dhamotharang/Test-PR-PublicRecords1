import header,USPS_AIS ; 
export fn_replace_alias_street(dataset(recordof(header.Layout_Header))  header_in) := module

//Overwrites alias address with the original address if there is match - this address used only for linking  
	alias:=USPS_AIS.File_CtyState_Lookup_Alias;

	shared als  := dedup(sort(alias(
		trim(Alias_Street_Information.street_pre_drctn_abbrev,left,right)	<> trim(Street_Information.street_pre_drctn_abbrev,left,right)
	or	trim(Alias_Street_Information.Street_Name,left,right)				<> trim(Street_Information.Street_Name,left,right)
	or	trim(Alias_Street_Information.street_suffix_abbrev,left,right)		<> trim(Street_Information.street_suffix_abbrev,left,right)
	or	trim(Alias_Street_Information.street_post_drctn_abbrev,left,right)	<> trim(Street_Information.street_post_drctn_abbrev,left,right)
	    ),zip_code ,Alias_Street_Information.street_pre_drctn_abbrev,Alias_Street_Information.Street_Name,Alias_Street_Information.street_suffix_abbrev
		,Alias_Street_Information.street_post_drctn_abbrev,-(Alias_Date.Alias_Century+Alias_Date.Alias_Year+Alias_Date.Alias_Month+Alias_Date.Alias_Day)),                                        
		zip_code ,Alias_Street_Information.street_pre_drctn_abbrev,Alias_Street_Information.Street_Name,Alias_Street_Information.street_suffix_abbrev
		,Alias_Street_Information.street_post_drctn_abbrev);
				
 shared header_in  tr(header_in l, als r) := transform
	    boolean a_hit	:= r.zip_code <>'' ; 
		self.predir		:=if(a_hit,r.Street_Information.street_pre_drctn_abbrev,l.predir);
		self.prim_name	:=if(a_hit,trim(r.Street_Information.Street_Name,left,right),l.prim_name);
		self.suffix		:=if(a_hit,trim(r.Street_Information.street_suffix_abbrev,left,right),l.suffix);
		self.postdir	:=if(a_hit,r.Street_Information.street_post_drctn_abbrev,l.postdir);
		self			:=l;
	end;

export alias_header:=  join(header_in, als
					,left.zip		= right.zip_code
					and	left.predir		= right.Alias_Street_Information.street_pre_drctn_abbrev
					and	trim(left.prim_name,left,right)	= trim(right.Alias_Street_Information.Street_Name,left,right)
					and	trim(left.suffix,left,right)	= trim(right.Alias_Street_Information.street_suffix_abbrev,left,right)
					and	left.postdir	= right.Alias_Street_Information.street_post_drctn_abbrev
					,tr(left,right)
					,left outer 
					,LOOKUP
					); 
// introduces new records for slimsorts. 					
export alias_slimsorts := join(header_in, als
					,left.zip		= right.zip_code
					and	left.predir		= right.Alias_Street_Information.street_pre_drctn_abbrev
					and	trim(left.prim_name,left,right)	= trim(right.Alias_Street_Information.Street_Name,left,right)
					and	trim(left.suffix,left,right)	= trim(right.Alias_Street_Information.street_suffix_abbrev,left,right)
					and	left.postdir	= right.Alias_Street_Information.street_post_drctn_abbrev
					,tr(left,right)
					,LOOKUP
					) +header_in; 

end;