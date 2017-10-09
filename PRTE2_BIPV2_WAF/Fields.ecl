IMPORT SALT38;
EXPORT Fields := MODULE
 
EXPORT NumFields := 30;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'wordbag','alpha','number');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'wordbag' => 1,'alpha' => 2,'number' => 3,0);
 
EXPORT MakeFT_wordbag(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]-^=!+&,./'); // Only allow valid symbols
  s3 := SALT38.stringcleanspaces( SALT38.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_wordbag(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]-^=!+&,./'))));
EXPORT InValidMessageFT_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]-^=!+&,./'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_alpha(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringtouppercase(s0); // Force to upper case
  s2 := SALT38.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT38.StrType s) := WHICH(SALT38.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotCaps,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_number(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'parent_proxid','ultimate_proxid','has_lgid','empid','powid','source','source_record_id','cnp_number','cnp_btype','cnp_lowv','cnp_name','company_phone','company_fein','company_sic_code1','prim_range','prim_name','sec_range','p_city_name','st','zip','company_url','isContact','title','fname','mname','lname','name_suffix','contact_email','CONTACTNAME','STREETADDRESS');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'parent_proxid','ultimate_proxid','has_lgid','empid','powid','source','source_record_id','cnp_number','cnp_btype','cnp_lowv','cnp_name','company_phone','company_fein','company_sic_code1','prim_range','prim_name','sec_range','p_city_name','st','zip','company_url','isContact','title','fname','mname','lname','name_suffix','contact_email','CONTACTNAME','STREETADDRESS');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'parent_proxid' => 0,'ultimate_proxid' => 1,'has_lgid' => 2,'empid' => 3,'powid' => 4,'source' => 5,'source_record_id' => 6,'cnp_number' => 7,'cnp_btype' => 8,'cnp_lowv' => 9,'cnp_name' => 10,'company_phone' => 11,'company_fein' => 12,'company_sic_code1' => 13,'prim_range' => 14,'prim_name' => 15,'sec_range' => 16,'p_city_name' => 17,'st' => 18,'zip' => 19,'company_url' => 20,'isContact' => 21,'title' => 22,'fname' => 23,'mname' => 24,'lname' => 25,'name_suffix' => 26,'contact_email' => 27,'CONTACTNAME' => 28,'STREETADDRESS' => 29,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],['CAPS','ALLOW'],[],['ALLOW'],[],[],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['ALLOW'],['CAPS','ALLOW'],[],[],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],['CAPS','ALLOW'],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE);
 
//Individual field level validation
 
EXPORT Make_parent_proxid(SALT38.StrType s0) := s0;
EXPORT InValid_parent_proxid(SALT38.StrType s) := 0;
EXPORT InValidMessage_parent_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultimate_proxid(SALT38.StrType s0) := s0;
EXPORT InValid_ultimate_proxid(SALT38.StrType s) := 0;
EXPORT InValidMessage_ultimate_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_has_lgid(SALT38.StrType s0) := s0;
EXPORT InValid_has_lgid(SALT38.StrType s) := 0;
EXPORT InValidMessage_has_lgid(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT38.StrType s0) := s0;
EXPORT InValid_empid(SALT38.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT38.StrType s0) := s0;
EXPORT InValid_powid(SALT38.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_source(SALT38.StrType s0) := s0;
EXPORT InValid_source(SALT38.StrType s) := 0;
EXPORT InValidMessage_source(UNSIGNED1 wh) := '';
 
EXPORT Make_source_record_id(SALT38.StrType s0) := s0;
EXPORT InValid_source_record_id(SALT38.StrType s) := 0;
EXPORT InValidMessage_source_record_id(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_number(SALT38.StrType s0) := s0;
EXPORT InValid_cnp_number(SALT38.StrType s) := 0;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_btype(SALT38.StrType s0) := s0;
EXPORT InValid_cnp_btype(SALT38.StrType s) := 0;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_lowv(SALT38.StrType s0) := s0;
EXPORT InValid_cnp_lowv(SALT38.StrType s) := 0;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';
 
EXPORT Make_cnp_name(SALT38.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_cnp_name(SALT38.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
 
EXPORT Make_company_phone(SALT38.StrType s0) := s0;
EXPORT InValid_company_phone(SALT38.StrType s) := 0;
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_company_fein(SALT38.StrType s0) := MakeFT_number(s0);
EXPORT InValid_company_fein(SALT38.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_company_sic_code1(SALT38.StrType s0) := s0;
EXPORT InValid_company_sic_code1(SALT38.StrType s) := 0;
EXPORT InValidMessage_company_sic_code1(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT38.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_prim_name(SALT38.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
 
EXPORT Make_sec_range(SALT38.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_sec_range(SALT38.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
 
EXPORT Make_p_city_name(SALT38.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_p_city_name(SALT38.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
 
EXPORT Make_st(SALT38.StrType s0) := MakeFT_alpha(s0);
EXPORT InValid_st(SALT38.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
 
EXPORT Make_zip(SALT38.StrType s0) := MakeFT_number(s0);
EXPORT InValid_zip(SALT38.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
 
EXPORT Make_company_url(SALT38.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_company_url(SALT38.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_company_url(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
 
EXPORT Make_isContact(SALT38.StrType s0) := s0;
EXPORT InValid_isContact(SALT38.StrType s) := 0;
EXPORT InValidMessage_isContact(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT38.StrType s0) := s0;
EXPORT InValid_title(SALT38.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT38.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_fname(SALT38.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
 
EXPORT Make_mname(SALT38.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_mname(SALT38.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
 
EXPORT Make_lname(SALT38.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_lname(SALT38.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
 
EXPORT Make_name_suffix(SALT38.StrType s0) := MakeFT_wordbag(s0);
EXPORT InValid_name_suffix(SALT38.StrType s) := InValidFT_wordbag(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_wordbag(wh);
 
EXPORT Make_contact_email(SALT38.StrType s0) := s0;
EXPORT InValid_contact_email(SALT38.StrType s) := 0;
EXPORT InValidMessage_contact_email(UNSIGNED1 wh) := '';
 
EXPORT Make_CONTACTNAME(SALT38.StrType s0) := s0;
EXPORT InValid_CONTACTNAME(SALT38.StrType fname,SALT38.StrType mname,SALT38.StrType lname) := 0;
EXPORT InValidMessage_CONTACTNAME(UNSIGNED1 wh) := '';
 
EXPORT Make_STREETADDRESS(SALT38.StrType s0) := s0;
EXPORT InValid_STREETADDRESS(SALT38.StrType prim_range,SALT38.StrType prim_name,SALT38.StrType sec_range) := 0;
EXPORT InValidMessage_STREETADDRESS(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,PRTE2_BIPV2_WAF;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_parent_proxid;
    BOOLEAN Diff_ultimate_proxid;
    BOOLEAN Diff_has_lgid;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_source;
    BOOLEAN Diff_source_record_id;
    BOOLEAN Diff_cnp_number;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_company_sic_code1;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_company_url;
    BOOLEAN Diff_isContact;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_contact_email;
    SALT38.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_parent_proxid := le.parent_proxid <> ri.parent_proxid;
    SELF.Diff_ultimate_proxid := le.ultimate_proxid <> ri.ultimate_proxid;
    SELF.Diff_has_lgid := le.has_lgid <> ri.has_lgid;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_source_record_id := le.source_record_id <> ri.source_record_id;
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_company_sic_code1 := le.company_sic_code1 <> ri.company_sic_code1;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_company_url := le.company_url <> ri.company_url;
    SELF.Diff_isContact := le.isContact <> ri.isContact;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_contact_email := le.contact_email <> ri.contact_email;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.SOURCE;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_parent_proxid,1,0)+ IF( SELF.Diff_ultimate_proxid,1,0)+ IF( SELF.Diff_has_lgid,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_source_record_id,1,0)+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_company_sic_code1,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_company_url,1,0)+ IF( SELF.Diff_isContact,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_contact_email,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_parent_proxid := COUNT(GROUP,%Closest%.Diff_parent_proxid);
    Count_Diff_ultimate_proxid := COUNT(GROUP,%Closest%.Diff_ultimate_proxid);
    Count_Diff_has_lgid := COUNT(GROUP,%Closest%.Diff_has_lgid);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_source_record_id := COUNT(GROUP,%Closest%.Diff_source_record_id);
    Count_Diff_cnp_number := COUNT(GROUP,%Closest%.Diff_cnp_number);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_company_sic_code1 := COUNT(GROUP,%Closest%.Diff_company_sic_code1);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_company_url := COUNT(GROUP,%Closest%.Diff_company_url);
    Count_Diff_isContact := COUNT(GROUP,%Closest%.Diff_isContact);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_contact_email := COUNT(GROUP,%Closest%.Diff_contact_email);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rcid,proxid,seleid,orgid,ultid}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.proxid);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.proxid=(UNSIGNED)f.rcid);
      UNSIGNED proxid_null0 := COUNT(GROUP,(UNSIGNED)f.proxid=0);
      UNSIGNED proxid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.proxid<(UNSIGNED)f.seleid);
      UNSIGNED proxid_atparent := COUNT(GROUP,(UNSIGNED)f.seleid=(UNSIGNED)f.proxid AND (UNSIGNED)f.proxid=(UNSIGNED)f.rcid);
      UNSIGNED seleid_null0 := COUNT(GROUP,(UNSIGNED)f.seleid=0);
      UNSIGNED seleid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.seleid<(UNSIGNED)f.orgid);
      UNSIGNED seleid_atparent := COUNT(GROUP,(UNSIGNED)f.orgid=(UNSIGNED)f.seleid AND (UNSIGNED)f.seleid=(UNSIGNED)f.proxid AND (UNSIGNED)f.proxid=(UNSIGNED)f.rcid);
      UNSIGNED orgid_null0 := COUNT(GROUP,(UNSIGNED)f.orgid=0);
      UNSIGNED orgid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.orgid<(UNSIGNED)f.ultid);
      UNSIGNED orgid_atparent := COUNT(GROUP,(UNSIGNED)f.ultid=(UNSIGNED)f.orgid AND (UNSIGNED)f.orgid=(UNSIGNED)f.seleid AND (UNSIGNED)f.seleid=(UNSIGNED)f.proxid AND (UNSIGNED)f.proxid=(UNSIGNED)f.rcid);
      UNSIGNED ultid_null0 := COUNT(GROUP,(UNSIGNED)f.ultid=0);
    END;
    EXPORT Basic0 := TABLE(f,r);
    EXPORT rcid_Clusters := SALT38.MOD_ClusterStats.Counts(f,rcid);
    EXPORT proxid_Clusters := SALT38.MOD_ClusterStats.Counts(f,proxid);
    EXPORT seleid_Clusters := SALT38.MOD_ClusterStats.Counts(f,seleid);
    EXPORT orgid_Clusters := SALT38.MOD_ClusterStats.Counts(f,orgid);
    EXPORT ultid_Clusters := SALT38.MOD_ClusterStats.Counts(f,ultid);
    EXPORT IdCounts := DATASET([{'rcid_Cnt', SUM(rcid_Clusters,NumberOfClusters)},{'proxid_Cnt', SUM(proxid_Clusters,NumberOfClusters)},{'seleid_Cnt', SUM(seleid_Clusters,NumberOfClusters)},{'orgid_Cnt', SUM(orgid_Clusters,NumberOfClusters)},{'ultid_Cnt', SUM(ultid_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
    // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)proxid=(UNSIGNED)rcid); // Get the bases
    EXPORT proxid_Unbased := JOIN(f(proxid<>0),bases,LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)seleid=(UNSIGNED)rcid); // Get the bases
    EXPORT seleid_Unbased := JOIN(f(seleid<>0),bases,LEFT.seleid=RIGHT.seleid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)orgid=(UNSIGNED)rcid); // Get the bases
    EXPORT orgid_Unbased := JOIN(f(orgid<>0),bases,LEFT.orgid=RIGHT.orgid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    bases := f((UNSIGNED)ultid=(UNSIGNED)rcid); // Get the bases
    EXPORT ultid_Unbased := JOIN(f(ultid<>0),bases,LEFT.ultid=RIGHT.ultid,TRANSFORM(LEFT),LEFT ONLY,HASH);
    // Children with two parents
    f_thin := TABLE(f(rcid<>0,proxid<>0),{rcid,proxid},rcid,proxid,MERGE);
    EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.proxid>RIGHT.proxid,TRANSFORM({SALT38.UIDType proxid1,SALT38.UIDType rcid,SALT38.UIDType proxid2},SELF.proxid1:=LEFT.proxid,SELF.proxid2:=RIGHT.proxid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(proxid<>0,seleid<>0),{proxid,seleid},proxid,seleid,MERGE);
    EXPORT proxid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.proxid=RIGHT.proxid AND LEFT.seleid>RIGHT.seleid,TRANSFORM({SALT38.UIDType seleid1,SALT38.UIDType proxid,SALT38.UIDType seleid2},SELF.seleid1:=LEFT.seleid,SELF.seleid2:=RIGHT.seleid,SELF.proxid:=LEFT.proxid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(seleid<>0,orgid<>0),{seleid,orgid},seleid,orgid,MERGE);
    EXPORT seleid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.seleid=RIGHT.seleid AND LEFT.orgid>RIGHT.orgid,TRANSFORM({SALT38.UIDType orgid1,SALT38.UIDType seleid,SALT38.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.seleid:=LEFT.seleid),HASH),WHOLE RECORD,ALL);
    f_thin := TABLE(f(orgid<>0,ultid<>0),{orgid,ultid},orgid,ultid,MERGE);
    EXPORT orgid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({SALT38.UIDType ultid1,SALT38.UIDType orgid,SALT38.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL);
    // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent,proxid_atparent,seleid_atparent,orgid_atparent];
      INTEGER proxid_unbased0 := IdCounts[2].Cnt-Basic0.rcid_atparent-IF(Basic0.proxid_null0>0,1,0);
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
      INTEGER seleid_unbased0 := IdCounts[3].Cnt-Basic0.proxid_atparent-IF(Basic0.seleid_null0>0,1,0);
      INTEGER proxid_Twoparents0 := COUNT(proxid_Twoparents);
      INTEGER orgid_unbased0 := IdCounts[4].Cnt-Basic0.seleid_atparent-IF(Basic0.orgid_null0>0,1,0);
      INTEGER seleid_Twoparents0 := COUNT(seleid_Twoparents);
      INTEGER ultid_unbased0 := IdCounts[5].Cnt-Basic0.orgid_atparent-IF(Basic0.ultid_null0>0,1,0);
      INTEGER orgid_Twoparents0 := COUNT(orgid_Twoparents);
    END;
    Advanced00 := TABLE(Basic0,r);
    Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
    EXPORT Advanced0 := SORT(SALT38.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,label='proxid'=>1,label='seleid'=>2,label='orgid'=>3,4));
  END;
  RETURN m;
ENDMACRO;
END;
