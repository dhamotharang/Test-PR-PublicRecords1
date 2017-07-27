import ut;
cn := company_names_only;

//cn := cnp;

r := record
  string word;
	unsigned weight;
  end;


r into(cn le,unsigned cnt) := transform
  self.word := cl(ut.Word(le.company_name,cnt));
	self.weight := le.cnt;
  end;
	
n0 := normalize(cn,ut.NoWords(left.company_name),into(left,counter))(length(word) >= 2);

n := distribute(n0,hash(word));

nr := record
  n.word;
	unsigned cnt := sum(group,n.weight);
  end;
	
t1 := table(n,nr,word,local);

export Company_Words := t1 : persist('temp::dab::company_words');

