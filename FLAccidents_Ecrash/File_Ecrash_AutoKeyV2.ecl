/*2016-03-30T17:57:04Z (Srilatha Katukuri)
Bug# 200197 - Modified to not to include blank orig last names
*/
/*2016-03-23T18:31:08Z (Srilatha Katukuri)
Bug# 200197 - last name modification
*/
IMPORT standard,FLAccidents, std;

base_file := FLAccidents_Ecrash.File_KeybuildV2.out;

Layout_eCrash.Consolidation copyNames(Layout_eCrash.Consolidation le) := TRANSFORM
		SELF.fname := le.orig_fname;
		SELF.lname := le.orig_lname;
		SELF.mname := le.orig_mname;
		SELF := Le;
END;	 
m_base_file:= PROJECT(base_file(TRIM(lname, LEFT, RIGHT) <> TRIM(orig_lname, LEFT, RIGHT) AND  (STD.STr.CountWords(lname,' ') > 1 OR STD.STr.CountWords(orig_lname,' ') > 1 ) AND orig_lname <> '' ),copyNames(LEFT));
	
cmbnd_base_file := m_base_file + base_file;
	
// A record with all the fields needed to build the autokeys
ak_rec := RECORD
	STRING8  dt_first_seen;
	STRING8  dt_last_seen;
	STRING40  accident_nbr;
	STRING40 orig_accnbr;
	UNSIGNED6 did;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING28 prim_name ;
	STRING10 prim_range ;
	STRING8  sec_range ;
	STRING25 v_city_name ;
	STRING2  st ;
	STRING5  zip5;
	UNSIGNED6 b_did;
	STRING25 b_name;
	STRING28 b_prim_name ;
	STRING10 b_prim_range ;
	STRING8  b_sec_range ;
	STRING25 b_v_city_name ;
	STRING2  b_st ;
	STRING5  b_zip5 ;
	UNSIGNED1 zero := 0;
	STRING1   blank := '';
END;

ak_rec slim_rec(base_file l) := TRANSFORM
  BOOLEAN is_company := IF(l.cname<>'',TRUE,FALSE); 

	SELF.dt_first_seen:= l.dt_first_seen;
	SELF.dt_last_seen := l.dt_last_seen;
	SELF.accident_nbr := l.accident_nbr;
	SELF.orig_accnbr := l.orig_accnbr; 
	// people fields
	SELF.did          := (UNSIGNED6)l.did;
	SELF.fname        := IF(~is_company,l.fname,'');
	SELF.mname        := IF(~is_company,l.mname,'');
	SELF.lname        := IF(~is_company,l.lname,'');
	SELF.prim_name    := IF(~is_company,l.prim_name,'');
	SELF.prim_range   := IF(~is_company,l.prim_range,'');
	SELF.sec_range    := IF(~is_company,l.sec_range,'');
	SELF.v_city_name  := IF(~is_company,l.v_city_name,'');
	SELF.st           := IF(~is_company,l.st,'');
	SELF.zip5         := IF(~is_company,l.zip,'');
	// business fields
	SELF.b_did         := (UNSIGNED6)l.b_did;
	SELF.b_name        := IF(is_company,l.cname,'');
	SELF.b_prim_name   := IF(is_company,l.prim_name,'');
	SELF.b_prim_range  := IF(is_company,l.prim_range,'');
	SELF.b_sec_range   := IF(is_company,l.sec_range,'');
	SELF.b_v_city_name := IF(is_company,l.v_city_name,'');
	SELF.b_st          := IF(is_company,l.st,'');
	SELF.b_zip5        := IF(is_company,l.zip,'');
END;

EXPORT File_Ecrash_AutoKeyV2 := DISTRIBUTE(PROJECT(cmbnd_base_file, slim_rec(LEFT)), HASH32(accident_nbr));