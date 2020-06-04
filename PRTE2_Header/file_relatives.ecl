IMPORT prte2,PRTE;
EXPORT file_relatives := function

// phr := PRTE2_Header.files.personrecs;
phr := PRTE2_Header.file_personrecs;
// phi := PRTE2_Header.files.file_old_ptre_header_in;
phi := PRTE2_Header.file_old_prte_header_in;

titlesSet := [2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10,11,12,13,14,15,16,17,18,19,20,21,
              22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,
              42,43,44,45,46]; // 45 total

OutRec := RECORD
    UNSIGNED6 did1;
    UNSIGNED6 did2;
    phr.link_dob;
    phr.link_ssn;
    phr.related_dob;
    phr.related_ssn;
    phr.related_title_cd;
    
END;           

phir        := project(phi,transform({recordof(LEFT) or outRec},SELF.did1:=LEFT.did,SELF:=LEFT, SELF:=[]));
phir assignRelativeTitlesLegacy(phir L, phir R, integer c):=TRANSFORM
    
        self.did2             := if(L.did=R.did,0 , L.did);
        self.related_title_cd := if(L.did=R.did,'', ((string)titlesSet[ (( L.did + R.did ) % 45)+1]));
        self                  :=R;
END;
legacy_pairs0   := iterate(sort(phir, prim_range,prim_name,city_name,st,zip,did) ,assignRelativeTitlesLegacy(LEFT,RIGHT,COUNTER)):persist('~persist::temp::legacy_pairs_0');
legacy_pairs    := project(legacy_pairs0,outRec);

phr_t := project(phr(~(cust_name='LN_PR')),transform({recordof(LEFT) or outRec},SELF:=LEFT, SELF:=[]));

phr_t assignRelativeTitles(phr_t L, phr_t R, integer c):=TRANSFORM
    
        self.related_dob := if(L.link_ssn=R.link_ssn,'',(string)L.link_dob);
        self.related_ssn := if(L.link_ssn=R.link_ssn,'',L.link_ssn);
        self.related_title_cd := if(L.link_ssn=R.link_ssn,'',
                                (string)titlesSet[(((unsigned8)L.link_ssn+(unsigned8)R.link_ssn) % 45)+1]);
        self:=R;
END;

randomPairs := iterate(sort(phr_t, addr1,addr2,city,st,zip,dob,ssn),assignRelativeTitles(LEFT,RIGHT,COUNTER));

OutRec NormIt({phr} L, INTEGER C) := TRANSFORM
    SELF.related_dob := CHOOSE(C, L.related_dob, L.related_dob2, L.related_dob3, L.related_dob4, L.related_dob5);
    SELF.related_ssn := CHOOSE(C, L.related_ssn, L.related_ssn2, L.related_ssn3, L.related_ssn4, L.related_ssn5);
    SELF.related_title_cd := CHOOSE(C, L.related_title_cd , L.related_title_cd2, 
                                       L.related_title_cd3, L.related_title_cd4, L.related_title_cd5);
    SELF := L;
    SELF := [];
END;
 
// Normalize all relatives per record 1-5
NormRelatives := NORMALIZE(phr(cust_name='LN_PR'),5,NormIt(LEFT,COUNTER));

// Take only occurances where the record had a relative
raw_pairs := (NormRelatives+project(randomPairs,outRec))
             
             (trim(related_dob)<>'' OR trim(related_ssn)<>'');
             
// Generate fake_did for the primary record PII
raw_pairs_did1 := join(
    
        raw_pairs,phr,
        LEFT.link_dob=RIGHT.link_dob AND LEFT.link_ssn=RIGHT.link_ssn,
        transform({raw_pairs}, self.did1 := prte2.fn_appendfakeid.did(
                                                             RIGHT.fname,
                                                             RIGHT.lname,
                                                             RIGHT.link_ssn,
                                                             RIGHT.link_dob,
                                                             'LN_PR'
                                                            );	
                  self := LEFT)    );

// Now generate fake did for the relative PII
raw_pairs_did2 := join(
    
        raw_pairs_did1,phr,
        LEFT.related_dob=RIGHT.link_dob AND LEFT.related_ssn=RIGHT.link_ssn,
        transform({raw_pairs_did1}, self.did2 := prte2.fn_appendfakeid.did(
                                                             RIGHT.fname,
                                                             RIGHT.lname,
                                                             RIGHT.link_ssn,
                                                             RIGHT.link_dob,
                                                             'LN_PR'
                                                            );
                  self := LEFT)     );


// Identify any missing pairs (i.e. we have 'a' related to 'b', but we are missing 'b' is related to 'a')

raw_pairs_did3 := dedup(raw_pairs_did2 + legacy_pairs,record,all);

no_pairs_matches := join(distribute(raw_pairs_did3,hash32(did1)),distribute(raw_pairs_did3,hash32(did2)),
                         LEFT.did1=RIGHT.did2 AND LEFT.did2=RIGHT.did1,local, LEFT ONLY);

// Henerate missing pairs based on generazlied relationship per primary relationship (see pair cases below)
{no_pairs_matches} tMatchPair(no_pairs_matches L) := TRANSFORM

        SELF.did1:=L.did2;
        SELF.did2:=L.did1;
        SELF.link_dob := L.related_dob;
        SELF.link_ssn := L.related_ssn;
        SELF.related_dob := L.link_dob;
        SELF.related_ssn := L.link_ssn;
        SELF.related_title_cd := (string)case((integer)L.related_title_cd,
        
                                        2=>4     ,//   Husband        <-->   Spouse
                                        3=>4     ,//   Wife           <-->   Spouse
                                        4=>4     ,//   Spouse         <-->   Spouse
                                        5=>7     ,//   Ex-Husband     <-->   Ex-Spouse
                                        6=>7     ,//   Ex-Wife        <-->   Ex-Spouse
                                        7=>7     ,//   Ex-Spouse      <-->   Ex-Spouse
                                        8=>4     ,//   Widow          <-->   Spouse
                                        9=>4     ,//   Widower        <-->   Spouse
                                        10=>21   ,//   Father         <-->   Child
                                        11=>21   ,//   Mother         <-->   Child
                                        12=>21   ,//   Parent         <-->   Child
                                        13=>24   ,//   Grandfather    <-->   Grandchild
                                        14=>24   ,//   Grandmother    <-->   Grandchild
                                        15=>24   ,//   Grandparent    <-->   Grandchild
                                        16=>18   ,//   Brother        <-->   Sibling
                                        17=>18   ,//   Sister         <-->   Sibling
                                        18=>18   ,//   Sibling        <-->   Sibling
                                        19=>12   ,//   Son            <-->   Parent
                                        20=>12   ,//   Daughter       <-->   Parent
                                        21=>12   ,//   Child          <-->   Parent
                                        22=>15   ,//   Grandson       <-->   Grandparent
                                        23=>15   ,//   Granddaughter  <-->   Grandparent
                                        24=>15   ,//   Grandchild     <-->   Grandparent
                                        25=>25   ,//   In-law         <-->   In-law
                                        26=>28   ,//   Sister-in-law  <-->   Sibling-in-law
                                        27=>28   ,//   Brother-in-law <-->   Sibling-in-law
                                        28=>28   ,//   Sibling-in-law <-->   Sibling-in-law
                                        29=>25   ,//   Mother-in-law  <-->   In-law
                                        30=>25   ,//   Father-in-law  <-->   In-law
                                        31=>25   ,//   Parent-in-law  <-->   In-law
                                        32=>44   ,//   Stepfather     <-->   Relative
                                        33=>44   ,//   Stepmother     <-->   Relative
                                        34=>44   ,//   Stepparent     <-->   Relative
                                        35=>37   ,//   Stepbrother    <-->   Stepsibling
                                        36=>37   ,//   Stepsister     <-->   Stepsibling
                                        37=>37   ,//   Stepsibling    <-->   Stepsibling
                                        38=>44   ,//   Aunt           <-->   Relative
                                        39=>44   ,//   Uncle          <-->   Relative
                                        40=>44   ,//   Niece          <-->   Relative
                                        41=>44   ,//   Nephew         <-->   Relative
                                        42=>42   ,//   Cousin         <-->   Cousin
                                        43=>44   ,//   Relative       <-->   Relative
                                        44=>44   ,//   Associate      <-->   Associate
                                        45=>45   ,//   Neighbor       <-->   Neighbor
                                        46=>46   ,//   Business       <-->   Business
                                        44);
        
END;

new_matching_pairs := project(no_pairs_matches,tMatchPair(LEFT));

output(sort(raw_pairs,link_dob,link_ssn),named('raw_pairs'));
output(count(no_pairs_matches),named('no_pairs_matches_cnt'));
output(count(new_matching_pairs),named('new_matching_pairs_cnt'));
output(choosen(no_pairs_matches,150),named('missing_pair'));
output(choosen(raw_pairs_did3,150),named('raw_pairs_did3'));
output(choosen(new_matching_pairs,150),named('new_matching_pairs'));

// Add original and missing pairs
all_pairs  := raw_pairs_did3 + new_matching_pairs;

// clean up and project dataset
{PRTE.Get_Header_Base.payload} tMapToRelatives(all_pairs L) := TRANSFORM

    self.person1 := L.did1;
    self.person2 := L.did2;
    self.rtitle  := (integer)L.related_title_cd;
    self := L;
    self := [];

END;

return dedup(project(all_pairs(did1<>0 AND did2<>0), tMapToRelatives(LEFT)),except rtitle,all)(rtitle<>0);
end;