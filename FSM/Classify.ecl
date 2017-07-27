import ut;
export Classify(string s,boolean roll = true) := MODULE

shared ucl(string s) := stringlib.stringtouppercase(cl(s));
shared strip_salut(string s) := if ( NaiveAnnotate(ut.Word(s,1))='T',ut.Words(s,2,ut.NoWords(s)),s);
shared with_pfirst(string s) := 
													MAP ( fsm.NaiveAnnotate(ut.Word(ucl(s),1))='T' and datalib.preferredfirst( ut.Word( ucl(s), 2 ) ) = ut.Word( ucl(s), 2 ) => s, 
															  fsm.NaiveAnnotate(ut.Word(ucl(s),1))<>'T' and datalib.preferredfirst( ut.Word( ucl(s), 1 ) ) = ut.Word( ucl(s), 1 ) => s, 
															  fsm.NaiveAnnotate(ut.Word(ucl(s),1))='T' /* pfirst different */ => ut.Word(s,1) + ' ' + datalib.preferredfirst( ut.Word(s,2) ) + ' ' + ut.Words(s,3,ut.NoWords(s) ),
																datalib.preferredfirst( ut.Word(s,1) ) + ' ' + ut.Words(s,2,ut.NoWords(s) ) );
																
shared cap100(integer i) := if ( i > 100, 100, i );
// * Needs better weighting system ... not sure of best approach ....
shared salut_person_weighting := 2.0;

Layout_ClassifyResponse into(string le) := transform
  self.Input := le;
	self.CleanedInput := ucl(le);
	self.WordCount := ut.NoWords(self.CleanedInput);
	self.ParseScore := 33; // MORE - Correct weighting for 'full match' ?
  end;
	
cand0 := DATASET(ROW(into(s)));

Layout_ClassifyResponse pfirst_into(string le) := transform
  self.Input := le;
	self.CleanedInput := ucl(with_pfirst(le));
	self.WordCount := ut.NoWords(self.CleanedInput);
	self.ParseScore := 33; // MORE - Correct weighting for 'full match' ?
  end;


export cand := if ( with_pfirst(s)=s, cand0, cand0+DATASET(ROW(pfirst_into(s))) );

Layout_ClassifyResponse NoteFullMatch(Layout_ClassifyResponse le, key_names ri) := transform
  self.VerifiedPerson := ri.src IN ['N','n','V','v'];
  self.VerifiedCompany := ri.src IN ['V','v','C','c'];
	self.ParseTokens := ri.src;
	self.IsCity := MAP ( ri.src = 'D' => 100,
													ri.src = 'd' => 75,
												 0 );
	self.IsCompany := MAP ( ri.src = 'C' => 100,
													ri.src IN ['c','V','v'] => 50,
													RI.src IN ['w','W'] => 25, 
													ri.src IN ['d'] => 12, 0 );
	self.IsPerson := cap100( MAP ( ri.src = 'N' => 100,
												 ri.src = 'n' => 75,
												 ri.src in ['V','v'] => 50,
												 ri.src IN ['F','f','l','L','N'] => 25,
												 ri.src IN ['d'] => 12,
												 0 ) * IF ( NaiveAnnotate(ut.Word(le.cleanedinput,1))='T', 2, 1 ));
  self.parsescore := ri.pcnt;
  self := le;
  end;

j0_full := join( cand, Key_Names, strip_salut(left.CleanedInput)=right.n, NoteFullMatch(left,right), left outer );

Layout_ClassifyResponse NotePartialMatch(Layout_ClassifyResponse le, key_names ri) := transform
	self.ParseTokens := IF ( ri.src = 'C', 'B','b' );
	self.IsCompany := IF(ri.src='C',100,50) * ut.NoWords(le.CleanedInput) / ut.NoWords(ri.n);
	self.PartialCompany := true;
	self.parsescore := ri.pcnt * ut.NoWords(le.CleanedInput) / ut.NoWords(ri.n);
  self := le;
  end;

j0_partial := join( j0_full(ParseTokens=''), Key_Names, left.CleanedInput=right.n[1..length(trim(left.CleanedInput))] and right.src IN ['C','c'], NotePartialMatch(left,right), keep(1), left outer );

// The full set of matches for the WHOLE string
export j := j0_full(ParseTokens<>'')+j0_partial;	
	
shared R := record
  string256 word;	//MORE
//    string word;
	string20 _type;
	unsigned1 pos;
	unsigned1 pcnt := 0;
	unsigned1 place := 1; // placing of this variant of the token
  end;
	
R MakeWord(j le,unsigned1 nbr) := Transform
  self.word := ut.Word(le.CleanedInput,nbr);
	self.pos := nbr;
	self.pcnt := 100; // MORE - Currently 100% Confidense for naively annotated
	self._type := NaiveAnnotate(self.word);
  end;	

// Only tokenize the original input; not any variants we may have made to try to get a full match
shared n := normalize(dedup(j(CleanedInput=ucl(Input)),CleanedInput,all),left.WordCount,MakeWord(LEFT,COUNTER));

R NoteToken(R le, key_names ri) := transform
  self._type := MAP ( ri.src<>'' => ri.src, '?' );
	self.pcnt := ri.pcnt;
  self := le;
  end;

export Prob_Places := join(n(_type=''),Key_Names,left.word=right.n,NoteToken(left,right),left outer);
	
R EnumerateTokens(R Le, R Ri) := transform
  self.place := if ( ri.pos=le.pos, le.place+1, 1 );
  self := ri;
  end;

AllTokens := Prob_Places+n(_type<>''); // Join together naively tokenized and computed ones 
poss_parse := iterate( sort(AllTokens(pcnt>0),pos,-pcnt), EnumerateTokens(left, right) ); 

R add_type(R le,R ri) := transform
  self._type := trim(le._type)+ri._type;
	self.pcnt := le.pcnt*ri.pcnt/100;
	self.place := le.place+ri.place;
  self := le;
  end;


r1 := loop( poss_parse(pos=1), max(poss_parse,pos)-1,join( rows(left), poss_parse, right.pos=counter+1, add_type(left,right), all ));

R enum_places(R le,unsigned c) := transform
  self.place := c;
  self := le;
  end;

r2 := project(sort(r1(place<=10,pcnt>0),place,-pcnt),enum_places(left,counter));

Layout_ClassifyResponse TakeType(j le,R ri) := transform
  self.parseTokens := ri._type;
	self.parseplace := ri.place;
	self.parsescore := ri.pcnt;
  self := le;
  end;

// really using Cand as a cheaters way of filling in the 'other' parts of the classify response body
j3 := join(Cand,r2,true,TakeType(left,right),all);

token_body(string20 t) := if ( t[1] = 'T', t[2..], t );
person_weighted(string20 t) := t[1] = 'T';

Layout_ClassifyResponse note_cp(j3 le,key_token_patterns ri) := transform
  self.IsPerson := IF ( ri.PercentilePerson=0, 0, ri.percentileperson*ri.percentileperson/(ri.PercentilePerson+ri.PercentileCompany));
  self.IsCompany := IF ( ri.PercentileCompany=0, 0, ri.percentilecompany*ri.percentilecompany/(ri.PercentilePerson+ri.PercentileCompany));
	self.IsCity := 0;
  self := le;
  end;

j4 := join(j3,key_token_patterns,token_body(left.parsetokens)=right._type,note_cp(left,right),left outer);

	
Layout_ClassifyResponse heuristic_weighting(j4 le) := transform
  self.IsPerson := cap100(IF( person_weighted(le.parseTokens) , le.IsPerson * salut_person_weighting, le.IsPerson ));
	self.IsCompany := le.IsCompany;
	self.IsCity := le.IsCity;
  self := le;
  end;	

j_carry := j(IsPerson>0 or IsCity>0 or IsCompany>0);
Cands := dedup( if( ut.NoWords(s)>1, j4+j_carry, j_carry), whole record, all );

token_computed := project(Cands,heuristic_weighting(left))(parsescore>0);

totals_rec := record
  total_parse := sum(group,token_computed.parsescore);
	unsigned8 IsPerson := sum(group,token_computed.IsPerson*token_computed.parsescore);
	unsigned8 IsCompany := sum(group,token_computed.IsCompany*token_computed.parsescore);
  unsigned8 IsCity := sum(group,token_computed.IsCity*token_computed.parsescore);
	boolean   VerifiedPerson := max(group,token_computed.VerifiedPerson);
	boolean   VerifiedCompany := max(group,token_computed.VerifiedCompany);
	end;
	
t := table(token_computed,totals_rec);

Layout_ClassifyResponse change(Layout_ClassifyResponse le) := transform
  self.IsPerson := t[1].IsPerson / t[1].total_parse;
  self.IsCompany := t[1].IsCompany / t[1].total_parse;
  self.IsCity := t[1].IsCity / t[1].total_parse;
	self.VerifiedPerson := t[1].VerifiedPerson;
	self.VerifiedCompany := t[1].VerifiedCompany;
  self := le;
  end;
	

  export result := if ( roll, sort(project(token_computed,change(left)),-parsescore), sort( token_computed, -(parsescore+IsPerson+IsCompany+IsCity) ) );
	END;