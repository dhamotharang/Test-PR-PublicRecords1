import Relationship,data_services;

isHeaderBuild:=false : stored('isHeaderBuild');

pv3:=Relationship.key_relatives_v3;

Relationship_key_relatives_v_built:= INDEX(pv3, {pv3.did1},{pv3},data_services.Data_Location.Relatives+'thor_data400::key::header::built::relatives_v3');

         // choose key version
v3 :=    if(~isHeaderBuild,Relationship.key_relatives_v3,
                           Relationship_key_relatives_v_built)
         // apply filter
        ( type in ['PERSONAL','TRANS CLOSURE']
        , confidence in ['MEDIUM','HIGH']    );

p1 := project(v3,transform(header.layout_relatives,
                                   self.person1         := left.did1,
                                   self.person2         := left.did2,
                                   self.same_lname      := left.isanylnamematch,
                                   self.number_cohabits := MAX(left.total_score / 5, 6),
                                   self:=[]
                           ));

EXPORT File_Relatives_v3:= p1;