export MAC_Character_Counts := module
export Length_Layout := record
  unsigned2 len;
	unsigned  cnt;
  end;
	
export Words_Layout := record
  unsigned2 words;
	unsigned  cnt;
	end;
	
export Character_Layout := record
  string1 c;
	unsigned cnt;
  end;	
	
export Pattern_Layout := record,maxlength(4096)
  string data_pattern;
	unsigned cnt;
	end;
	
export Value_Layout := record,maxlength(4096)
  string val;
	unsigned cnt;
	end;

export ResultLine_Layout := record,maxlength(62000)
  string30 FieldName;
	unsigned                  Cardinality;
  dataset(Length_Layout)    Len;
	dataset(Words_Layout)     Words;
	dataset(Character_Layout) Characters;
	dataset(Pattern_Layout)   Patterns;
	dataset(Value_Layout)   Frequent_Terms;
  end;
export MAC(infile,infield,fieldname,o) := macro
import ut;
#uniquename(rs)
%rs% := record,maxlength(4096)
  infile.infield;
	unsigned2 xx_l := length(trim((string)infile.infield));
	unsigned2 xx_wc := ut.NoWords((string)infile.infield);
	end;
	
#uniquename(t)
%t% := table(infile,%rs%);	
// Find the cardinality of the field and the most frequently occuring terms

#uniquename(field_cnts)
%field_cnts% := record
  %t%.infield;
	unsigned cnt := count(group);
  end;
	
#uniquename(lcl_flds_cnt)
// Do locally first to avoid skew from high frequency elements
%lcl_flds_cnt% := table( %t%, %field_cnts%, infield, local );	

#uniquename(glbl_field_cnts)
%glbl_field_cnts% := record
  %lcl_flds_cnt%.infield;
	unsigned cnt := sum(group,%lcl_flds_cnt%.cnt);
  end;
	
#uniquename(glbl_flds_cnt)
// Now do locally on unskewed (and hopefully smaller)
%glbl_flds_cnt% := table( %lcl_flds_cnt%, %glbl_field_cnts%, infield );	

// Cardinality of the field
#uniquename(ca)
%ca% := count( %glbl_flds_cnt% );

#uniquename(intoval)
Business_Header_Bdid_lift.MAC_Character_Counts.Value_Layout %intoval%(%glbl_flds_cnt% le) := transform
		self.val := (string)le.infield;
		self.cnt := le.cnt;
  end;
	
#uniquename(vls)
%vls% := project ( topn (%glbl_flds_cnt%,100,-cnt),%intoval%(left) );	

#uniquename(r)
%r% := record
  string1 c;
	end;
	
#uniquename(tr)
%r% %tr%(%t% le,unsigned co) := transform
  self.c := ((string)le.infield)[co];
  end;
	
#uniquename(cs)
%cs% := normalize(%t%,left.xx_l,%tr%(left,counter));
#uniquename(rc)
%rc% := record
  %cs%.c;
	unsigned cnt := count(group);
	end;
	
#uniquename(rcp)
Business_Header_Bdid_lift.MAC_Character_Counts.character_layout %rcp%(%rc% le) := transform
  self := le;
  end;
#uniquename(o_cc)
%o_cc% := project(sort(table(%cs%,%rc%,c,few),-cnt),%rcp%(left));	
#uniquename(rl)
%rl% := record
  unsigned2 len := %t%.xx_l;
  unsigned cnt := count(group);
  end;
#uniquename(rcl)
Business_Header_Bdid_lift.MAC_Character_Counts.length_layout %rcl%(%rl% le) := transform
  self := le;
  end;
#uniquename(o_sl)
%o_sl% := project(sort(table(%t%,%rl%,xx_l),-cnt),%rcl%(left));
	
#uniquename(rw)
%rw% := record
  unsigned words := %t%.xx_wc;
  unsigned cnt := count(group);
  end;
#uniquename(rcw)
Business_Header_Bdid_lift.MAC_Character_Counts.words_layout %rcw%(%rw% le) := transform
  self := le;
  end;
#uniquename(o_wc)
%o_wc% := project(sort(table(%t%,%rw%,xx_wc),-cnt),%rcw%(left));
#uniquename(dpo)
Business_Header_Bdid_lift.mac_find_data_patterns(%t%,infield,%dpo%)
#uniquename(rcd)
Business_Header_Bdid_lift.mac_character_counts.pattern_layout %rcd%(%dpo% le) := transform
  self.data_pattern := (string)le.infield;
  self := le;
  end;
#uniquename(o_dp)
%o_dp% := project(%dpo%,%rcd%(left));

export o := dataset( [{fieldname,%ca%,global(%o_sl%,few),global(%o_wc%,few),global(%o_cc%,few),global(topn(%o_dp%,100,-cnt),few),global(%vls%,few)}], Business_Header_Bdid_lift.mac_character_counts.ResultLine_Layout );
  endmacro;
	
end;
