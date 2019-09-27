import std, PromoteSupers, doxie_build, Watchdog, mdr, infutor, Relationship;

/********* RELATIVES **********/

Wdog      := distribute(Watchdog.File_Best_nonglb, hash(did))(adl_ind = 'CORE');
relatives := distribute(Relationship.key_relatives_v3(not(confidence IN ['NOISE','LOW'])), hash(did1));
inf       := distribute(Infutor.file_infutor_best, hash(did));

d2c_rel1 := join(relatives, inf, left.did1 = right.did, transform(left), inner, local) : INDEPENDENT;
d2c_rel2 := join(distribute(d2c_rel1, hash(did2)), inf, left.did2 = right.did, transform(left), inner, local) : INDEPENDENT;

lexid_pairs := record
 unsigned6 LexID1;
 unsigned6 LexID2;
end;

fullDS := project(d2c_rel2, transform(lexid_pairs, self.lexid1 := left.did1, self.lexid2 := left.did2));
         
coreDS := join(
      distribute(d2c_rel2, hash(did1)),
      Wdog,
      left.did1 = right.did,
      transform(lexid_pairs, self.lexid1 := left.did1, self.lexid2 := left.did2),
      local) : INDEPENDENT;

coreDerogatoryDS := join(
      distribute(coreDS, hash(lexid1)),
      distribute(Files.derogatoryDS, hash(did)),
      left.lexid1 = right.did,
      transform(lexid_pairs, self := left),
      local) : INDEPENDENT;

MAC_LINK_DIDs(res, ds, sMode, ver) := MACRO
   
    p1 := project(ds, transform({ds, string cat}, self.cat:= left.LexID1 + 'X' + left.Lexid2, self := left;));
    p2 := project(ds, transform({ds, string cat}, self.cat:= left.LexID2 + 'X' + left.Lexid1, self := left;));

    p := distribute(p1 + p2, hash(lexid1));
    s := sort(p, lexid1, lexid2, cat, local);

//Removing duplicate pairs, e.g  1-2 and 2-1    
    uniq_pairs_level1 := project(dedup(dedup(s, lexid1, lexid2, all), cat, all), lexid_pairs);
    
    level1_st := table(uniq_pairs_level1, {type := 1, LexID1, links := count(group)}, LexID1, few, merge);
    
    lexid_pairs tr1(lexid_pairs L, lexid_pairs R) := transform
        self.LexID2 := if(L.LexID2 = R.LexID1, R.LexID2, 0);
        self := L;
    end;

//Join to pull level2 relation
    Level2_j := join(distribute(uniq_pairs_level1, hash(lexid2)), distribute(uniq_pairs_level1, hash(lexid1)), left.LexID2 = right.LexID1, tr1(left, right), local) : INDEPENDENT;
//Remove duplicate pairs
    Level2_d := dedup(sort(distribute(Level2_j(lexid1 <> lexid2), hash(lexid1)), lexid1, lexid2, local), lexid1, lexid2, local);  
    
// code

    // p11 := project(Level2_d_, transform({Level2_d_, string cat}, self.cat:= left.LexID1 + 'X' + left.Lexid2, self := left;));
    // p12 := project(Level2_d_, transform({Level2_d_, string cat}, self.cat:= left.LexID2 + 'X' + left.Lexid1, self := left;));

    // p_ := distribute(p11 + p12, hash(lexid1));
    // s_ := sort(p_, lexid1, lexid2, cat, local);
    // Level2_d := project(dedup(dedup(s_, lexid1, lexid2, all), cat, all), lexid_pairs);

// code    

//Drop duplicate recs present in Level1 relation    
    // uniq_pairs_level2_j1 := join(distribute(uniq_pairs_level1, hash(lexid1)), distribute(Level2_d, hash(lexid1)), left.lexid1 = right.lexid1 and left.lexid2 = right.lexid2, right only, local) : INDEPENDENT;
    uniq_pairs_level2_j1 := join(distribute(Level2_d, hash(lexid1)), distribute(uniq_pairs_level1, hash(lexid1)), left.lexid1 = right.lexid1 and left.lexid2 = right.lexid2, left only, local) : INDEPENDENT;
    uniq_pairs_level2 := join(distribute(uniq_pairs_level2_j1, hash(lexid1)), distribute(uniq_pairs_level1, hash(lexid2)), left.lexid1 = right.lexid2 and left.lexid2 = right.lexid1, left only, local) : INDEPENDENT;
    
    level2_st := table(uniq_pairs_level2, {type := 2, LexID1, links := count(group)}, LexID1, few, merge);

    lexid_pairs tr2(lexid_pairs L, lexid_pairs R) := transform
        self.LexID2 := if(L.LexID1 = R.LexID2, R.LexID2, 0);
        self.LexID1 := R.LexID1;
    end;

//Join to pull level3 relation
    // Level3_j := join(distribute(uniq_pairs_level1, hash(lexid1)), distribute(uniq_pairs_level2, hash(lexid2)), left.LexID1 = right.LexID2, tr2(left, right), local) : INDEPENDENT;
    Level3_j := join(distribute(uniq_pairs_level2, hash(lexid2)), distribute(uniq_pairs_level1, hash(lexid1)), left.LexID2 = right.LexID1, tr2(left, right), local) : INDEPENDENT;
//Remove duplicate pairs
    Level3_d := dedup(sort(distribute(Level3_j(lexid1 <> lexid2), hash(lexid1)), lexid1, lexid2, local), lexid1, lexid2, local);

//Drop duplicate recs present in Level2 relation   
    // uniq_pairs_level3 := join(distribute(uniq_pairs_level2, hash(lexid1)), distribute(Level3_d, hash(lexid1)), left.lexid1 = right.lexid1 and left.lexid2 = right.lexid2, right only, local) : INDEPENDENT;
    uniq_pairs_level3 := join(distribute(Level3_d, hash(lexid1)), distribute(uniq_pairs_level2, hash(lexid1)), left.lexid1 = right.lexid1 and left.lexid2 = right.lexid2, left only, local) : INDEPENDENT;
              
    level3_st := table(uniq_pairs_level3, {type := 3, LexID1, links := count(group)}, LexID1, few, merge);
    
    level_st_ := level1_st + level2_st + level3_st;
    level_st  := sort(distribute(level_st_(links > 5), hash(LexID1)), -links, local);
    
    PromoteSupers.MAC_SF_BuildProcess(uniq_pairs_level2,'~thor_data400::output::d2c::' + sMode + '::relatives::level2',doLevel2,2,,true, ver);
    PromoteSupers.MAC_SF_BuildProcess(uniq_pairs_level3,'~thor_data400::output::d2c::' + sMode + '::relatives::level3',doLevel3,2,,true, ver);
    PromoteSupers.MAC_SF_BuildProcess(level_st,'~thor_data400::output::d2c::' + sMode + '::relatives::level_stats',doStat,2,,true, ver);
    
    res := sequential(
      doStat,
      doLevel2,
      doLevel3      
      );     

ENDMACRO;

     
EXPORT proc_build_relatives(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

   ds := map( mode = 1 => fullDS,          //FULL
              mode = 2 => coreDS,          //QUARTERLY
              mode = 3 => coreDerogatoryDS //MONTHLY
            );
   
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   MAC_LINK_DIDs(doit, ds, sMode, ver);
   
   return if(Mode not in [1,2,3], output('relatives - INVALID MODE - ' + Mode), doit);


END;