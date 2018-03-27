IMPORT prte_csv, address, doxie, NID, ut, PRTE2_X_Ins_PropertyScramble, PRTE2_Header_Ins;
#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'CustTest Audit Alpha PersonHdr-Base');

DS := 	PRTE2_Header_Ins.files.HDR_BASE_ALPHA_DS;
// --------------------------------------------------
appendIf(STRING s1, STRING s2) := IF(s1='',s2,TRIM(s1)+' '+TRIM(s2) );
appendIf3(STRING s1, STRING s2, STRING s3) := appendIf(appendIf(s1,s2),s3);
appendIf4(STRING s1, STRING s2, STRING s3, STRING s4) := appendIf(appendIf3(s1,s2,s3),s4);

PRTE2_Header_Ins.Layouts.Expanded_Audit_Header_Layout proj_recs(ds l,integer c) := TRANSFORM
		string st_address1 := appendIf3(l.prim_range,l.predir,l.prim_name);
		string st_address2 := appendIf4(l.suffix,l.postdir,l.unit_desig,l.sec_range);
		string st_address := appendIf(st_address1,st_address2);
		string cszString := appendIf3(l.city_name,l.st,l.zip+l.zip4);
		string clean_address := address.CleanAddress182(st_address, cszString);
		STRING errStat := clean_address[179..182];
		BOOLEAN hitErr := errStat[1]='E';
		self.prim_range := IF(hitErr,L.prim_range,clean_address[1..10]);
		self.predir := IF(hitErr,L.predir,clean_address[11..12]);
		self.prim_name := IF(hitErr,L.prim_name,clean_address[13..40]);
		self.suffix      := IF(hitErr,L.suffix,clean_address[41..44]);
		self.addr_suffix := IF(hitErr,L.addr_suffix,clean_address[41..44]);
		self.postdir := IF(hitErr,L.postdir,clean_address[45..46]);
		self.unit_desig := IF(hitErr,L.unit_desig,clean_address[47..56]);
		self.sec_range := IF(hitErr,L.sec_range,clean_address[57..64]);
		self.city_name := IF(hitErr,L.city_name,clean_address[65..89]);
		self.p_city_name := IF(hitErr,L.p_city_name,clean_address[65..89]);
		self.v_city_name := IF(hitErr,L.v_city_name,clean_address[90..114]);
		self.st := IF(hitErr,L.st,clean_address[115..116]);
		self.zip := IF(hitErr,L.zip,clean_address[117..121]); 
		self.zip4 := IF(hitErr,L.zip4,clean_address[122..125]);
		self.cart := IF(hitErr,L.cart,clean_address[126..129]);
		self.cr_sort_sz := IF(hitErr,L.cr_sort_sz,clean_address[130]);
		self.lot := IF(hitErr,L.lot,clean_address[131..134]);
		self.lot_order := IF(hitErr,L.lot_order,clean_address[135]);
		self.dbpc := IF(hitErr,L.dbpc,clean_address[136..137]);
		self.chk_digit := IF(hitErr,L.chk_digit,clean_address[138]);
		self.rec_type := IF(hitErr,L.rec_type,clean_address[139..140]);
		self.county := IF(hitErr,L.county,clean_address[143..145]);
		self.geo_lat := IF(hitErr,L.geo_lat,clean_address[146..155]);
		self.geo_long := IF(hitErr,L.geo_long,clean_address[156..166]);
		self.msa := IF(hitErr,L.msa,clean_address[167..170]);
		self.geo_blk := IF(hitErr,L.geo_blk,clean_address[171..177]);
		self.geo_match := IF(hitErr,L.geo_match,clean_address[178]);
		self.err_stat := IF(hitErr,L.err_stat,clean_address[179..182]);
		SELF := L;
END;
// --------------------------------------------------

newAuditFile := PROJECT(DS,proj_recs(LEFT,COUNTER) );

OUTPUT(newAuditFile,,PRTE2_Header_Ins.Files.HDR_AUDIT_ALPHA_NAME,overwrite);
