import Relationship;

kRelatives := pull(Relationship.key_relatives_v3(not(confidence IN ['NOISE','LOW']) and did1 > 0));

j1 := join(distribute(kRelatives, hash(did1)), $.MetaData, left.did1 = right.Lexid
				,TRANSFORM($.layouts.rRelative
					,SELF.LexID1  := LEFT.did1
					,SELF.LexID2  := LEFT.did2
					,SELF.relation_ind := if(LEFT.isanylnamematch, 'R', 'A')
				), LOCAL);

j2 := join(distribute(j1, hash(LexID2)), MetaData, left.LexID2 = right.Lexid, transform(LEFT), LOCAL);

rel_p := project(j2, transform({j2, string pair}, self.pair:=if(left.lexid1<left.lexid2,left.lexid1,left.lexid2)+'X'+if(left.lexid1>left.lexid2,left.lexid1,left.lexid2) ;self := left;));
single_pair := dedup(sort(distribute(rel_p, hash(pair)), pair, lexid1, local), pair, local);

EXPORT Relatives := project(distribute(single_pair, hash(lexid1)), transform($.layouts.rRelative, self:=left;));

