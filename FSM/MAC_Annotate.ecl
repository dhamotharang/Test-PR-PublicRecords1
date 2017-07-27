export MAC_Annotate(infile,label,outfile) := MACRO
import ut;


rp := record
  infile;
	string word;
	unsigned mac_id;
  end;
	
r := record
  string word;
	string preserve_word;
	unsigned id;
	unsigned2 pos := 0;
	string20  _type := '';
	unsigned cnt;
  end;


rp cntr(infile le,unsigned i) := transform
  self.word := cl(le.label);
	self.mac_id := i;
	self := le;
  end;

p := project(infile,cntr(left,counter));

pi := p(ut.nowords(word)<20);
										
r into(p le,unsigned cot) := transform
  self.word := ut.Word(le.word,cot);
	self.preserve_word := '';
	self.pos := cot;
	self.id := le.mac_id;
	self._type := fsm.NaiveAnnotate(self.word);
	self.cnt := le.cnt;
  end;
	
n0 := normalize(pi,ut.nowords(left.word),into(left,counter));

nms := dedup( sort ( distribute ( key_names, hash(n) ), n, -cnt, local ), n, local );

r add_m(n0 le, nms ri) := transform
  self._type := ri.src;
  self := le;
  end;

n0c := join( n0(_type=''), nms, left.word=right.n, add_m(left,right), left outer, hash );

r combine_src(r le, r ri) := transform
  self._type := trim(le._type)+ri._type;
  self := le;
  end;

re_agg := rollup ( sort ( distribute( n0(_type<>'') + n0c, id ), id, pos, local ), left.id=right.id, combine_src(left,right),local ); 

ri := record
  infile;
	string20 _type;
  end;

ri get_name(p le,r ri) := transform
  self._type := ri._type;
  self := le;
  end;

outfile := join(p,re_agg,left.mac_id=right.id,get_name(left,right),hash);

ENDMACRO;