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
	
export ResultLine_Layout := record,maxlength(62000)
  string30 FieldName;
	unsigned                  Cardinality;
  dataset(Length_Layout)    Len;
	dataset(Words_Layout)     Words;
	dataset(Character_Layout) Characters;
	dataset(Pattern_Layout)   Patterns;
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
ngadl.mac_character_counts.character_layout %rcp%(%rc% le) := transform
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
ngadl.mac_character_counts.length_layout %rcl%(%rl% le) := transform
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
ngadl.mac_character_counts.words_layout %rcw%(%rw% le) := transform
  self := le;
  end;

#uniquename(o_wc)
%o_wc% := project(sort(table(%t%,%rw%,xx_wc),-cnt),%rcw%(left));
#uniquename(dpo)
ngadl.mac_find_data_patterns(%t%,infield,%dpo%)

#uniquename(rcd)
ngadl.mac_character_counts.pattern_layout %rcd%(%dpo% le) := transform
  self.data_pattern := (string)le.infield;
  self := le;
  end;
#uniquename(o_dp)
%o_dp% := project(%dpo%,%rcd%(left));

#uniquename(ca)
%ca% := count( dedup( %t%,infield, all ) );

export o := dataset( [{fieldname,%ca%,global(%o_sl%,few),global(%o_wc%,few),global(%o_cc%,few),global(topn(%o_dp%,100,-cnt),few)}], ngadl.mac_character_counts.ResultLine_Layout );

  endmacro;
	
end;