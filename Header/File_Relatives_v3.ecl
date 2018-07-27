import Relationship;

v3 := Relationship.key_relatives_v3

 ( type in ['PERSONAL','TRANS CLOSURE']
 , confidence in ['MEDIUM','HIGH']    );

p1 := project(v3,transform({Header.File_Relatives},
                                   self.person1         := left.did1,
                                   self.person2         := left.did2,
                                   self.same_lname      := left.isanylnamematch,
                                   self.number_cohabits := MAX(left.total_score / 5, 6),
                                   self:=[]
                           ));

EXPORT File_Relatives_v3:= p1;