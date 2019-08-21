IMPORT ut,doxie,header,mdr, header_services,PRTE2_Header;

EXPORT fn_ADLSegmentation_v2(DATASET(header.Layout_Header) hdr_in, BOOLEAN filter_utility_z_recs=false)  := MODULE


  header_services.Supplemental_Data.mac_verify('adl_segment_inj.txt',header.Layout_Header, adl_in); // 
  hdr_adl_in := adl_in();
  hdr_full := DISTRIBUTE(hdr_in + hdr_adl_in,HASH(did)) ; 

  f_ := IF(filter_utility_z_recs,hdr_full(src NOT IN [mdr.sourceTools.src_ZUtilities,mdr.sourceTools.src_ZUtil_Work_Phone]),hdr_full);

  slimr := RECORD
    f_.did;
    f_.dt_first_seen;
    f_.dt_last_seen;
    f_.prim_range;
    f_.prim_name;
    f_.sec_range;
    f_.zip;
    BOOLEAN  is_ambig                         := false;
    BOOLEAN  has_an_ssn                       := false;
    BOOLEAN  owns_an_ssn                      := false;
    BOOLEAN  ssns_dont_belong_to_someone_else := false;//testing with Z's, R's could also be discussed
    BOOLEAN  is_dead                          := false;
    UNSIGNED rec_cnt                          := 1;
    UNSIGNED src_cnt                          := 1;
    STRING   ind                              := '';
    STRING2  src;
  END;

  #IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
    df := DATASET([],{header.file_did_death_masterv2});
  #ELSE
    df := DEDUP(SORT(DISTRIBUTE(header.file_did_death_masterv2,HASH((UNSIGNED6)did)),did,LOCAL),did,LOCAL);
  #END;
  slimr x0(slimr le, slimr ri) := TRANSFORM
    self.ssns_dont_belong_to_someone_else := le.ssns_dont_belong_to_someone_else OR ri.ssns_dont_belong_to_someone_else;
    SELF := le;
  END;

  ssn_recs             := PROJECT(f_(ssn<>''),TRANSFORM({slimr},self.ssns_dont_belong_to_someone_else:=left.valid_ssn<>'Z',SELF:=LEFT));
  ssn_recs_dupd        := DEDUP(SORT(ssn_recs,did,ssns_dont_belong_to_someone_else,LOCAL),did,ssns_dont_belong_to_someone_else,LOCAL);
  roll_ssn_recs_by_did := ROLLUP(ssn_recs_dupd,left.did=right.did,x0(LEFT,RIGHT),LOCAL);

  slimr x1(f_ le, df ri) := TRANSFORM
    self.is_ambig    := le.jflag2<>'';
    //self.has_an_ssn  := ut.full_ssn(le.ssn);
    self.has_an_ssn  := le.ssn<>'';
    self.owns_an_ssn := self.has_an_ssn AND le.valid_ssn='G';
    self.is_dead     := /*le.src=mdr.sourceTools.src_Death_Master or*/ (UNSIGNED6)ri.did > 0; 
    self.src         := IF(le.src IN [mdr.sourceTools.src_ZUtilities,mdr.sourceTools.src_ZUtil_Work_Phone],mdr.sourceTools.src_Equifax,le.src);
    SELF             := le;
  END;

  f := JOIN(DISTRIBUTED(f_,HASH(did)),df,left.did=(UNSIGNED6)right.did,x1(LEFT,RIGHT),LEFT OUTER,LOCAL);

  //Just get all DIDs
  slimr roller(slimr le,slimr ri) := TRANSFORM 
    SELF.dt_last_seen  := MAX    (le.dt_last_seen,ri.dt_last_seen);
    SELF.dt_first_seen := ut.min2(le.dt_first_seen,ri.dt_first_seen);
    self.is_ambig      := le.is_ambig    OR ri.is_ambig;
    self.has_an_ssn    := le.has_an_ssn  OR ri.has_an_ssn;
    self.owns_an_ssn   := le.owns_an_ssn OR ri.owns_an_ssn;
    self.is_dead       := le.is_dead     OR ri.is_dead;
    self.rec_cnt       := le.rec_cnt + ri.rec_cnt;
    self.src           := ri.src;
    self.src_cnt       := IF(le.src<>ri.src,le.src_cnt+1,le.src_cnt);
    SELF               := le;
  END;

  rollem0 := ROLLUP(SORT(f,did,src,LOCAL),left.did=right.did,roller(LEFT,RIGHT),LOCAL);
  rollem  := JOIN(rollem0,roll_ssn_recs_by_did,left.did=right.did,TRANSFORM({slimr},self.ssns_dont_belong_to_someone_else:=right.ssns_dont_belong_to_someone_else,SELF:=LEFT),LEFT OUTER,LOCAL);

  latest_dt_rec := RECORD
    rollem.dt_last_seen;
    cnt := COUNT(GROUP);
  END;

  //latest_date_table := table(sort(distribute(rollem,hash(dt_last_seen)),dt_last_seen,local),latest_dt_rec,dt_last_seen,local);
  latest_date_table := TABLE(rollem,latest_dt_rec,dt_last_seen,FEW);
  latest_date       := ((STRING6)MAX(latest_date_table(cnt>1000),dt_last_seen))+'01';

  // Bad Data
  h1 := DEDUP(SORT(f(ind=''),did,prim_name,-dt_last_seen,LOCAL),did,prim_name,LOCAL);

  r :=
  RECORD
    f.prim_name;
    max_date := MAX(GROUP,h1.dt_last_seen);
  END;
  // Get every street name and the last time we saw it
  t := TABLE(h1,r,prim_name,FEW);
  // Take the list of old street names - we'll take thse as "bad"
  old_addr := DISTRIBUTE(t(ut.DaysApart(((STRING6)max_date)+'01',latest_date)>18*30),HASH(prim_name));
  // Get the list of header records that have good street names
  j := JOIN(DISTRIBUTE(f(prim_name<>''),HASH(prim_name)),old_addr,LEFT.prim_name=RIGHT.prim_name,LEFT ONLY, LOCAL);
  dj := DEDUP(SORT(DISTRIBUTE(j,HASH(did)),did,LOCAL),did,LOCAL);


  dead_check     := PROJECT(rollem,        TRANSFORM({slimr},self.ind:=IF(left.ind='' AND left.is_dead,'DEAD',left.ind),SELF:=LEFT)); 
  noise_check    := JOIN(dead_check,dj,left.did=right.did,TRANSFORM({slimr},self.ind:=IF(left.ind='' AND right.did=0,'NOISE',left.ind),SELF:=LEFT),LEFT OUTER,LOCAL);
  //note the exclusion of ambiguous people from suspect
  suspect_check  := PROJECT(noise_check,   TRANSFORM({slimr},self.ind:=IF(left.ind='' AND ~left.is_ambig AND left.has_an_ssn AND ~left.ssns_dont_belong_to_someone_else,'SUSPECT',left.ind),SELF:=LEFT));
  hmerge_check   := PROJECT(suspect_check, TRANSFORM({slimr},self.ind:=IF(left.ind='' AND ut.DaysApart(latest_date,left.dt_last_seen+'01')>24*30 AND left.src_cnt=1,'H_MERGE',left.ind),SELF:=LEFT));
  cmerge_check   := PROJECT(hmerge_check,  TRANSFORM({slimr},self.ind:=IF(left.ind='' AND left.src_cnt=1,'C_MERGE',left.ind),SELF:=LEFT)); 
  inactive_check := PROJECT(cmerge_check,  TRANSFORM({slimr},self.ind:=IF(left.ind='' AND (ut.DaysApart(latest_date,left.dt_last_seen+'01') > 24*30),'INACTIVE',left.ind),SELF:=LEFT)); 
  amb_check      := PROJECT(inactive_check,TRANSFORM({slimr},self.ind:=IF(left.ind='' AND left.is_ambig,'AMBIG',left.ind),SELF:=LEFT));
  ssn_check      := PROJECT(amb_check,     TRANSFORM({slimr},self.ind:=IF(left.ind='' AND ~left.has_an_ssn, 'NO_SSN', left.ind),SELF:=LEFT));
  core1_check    := PROJECT(ssn_check,     TRANSFORM({slimr},self.ind:=IF(left.ind='' AND left.owns_an_ssn AND left.src_cnt>1,'CORE',left.ind),SELF:=LEFT));
  core2_check    := PROJECT(core1_check,    TRANSFORM({slimr},self.ind:=IF(left.ind='','CORENOVSSN',left.ind),SELF:=LEFT));

  EXPORT  core_check     := core2_check;
  EXPORT  core_check_pst := core_check : PERSIST('persist::adl_segmentation_v2');

  cross := RECORD
    core_check_pst.ind;
    cnt := COUNT(GROUP);
  END;

  EXPORT tab := TABLE(core_check_pst,cross,ind,FEW);
  //output(sort(tab,ind),named('AdlSegmentation_Table'));

END;