// count from raw Neustar file ... for test purposes
EXPORT mac_raw_disc_cnt(cnt_in_f,cnt_out_f) := macro

#uniquename(history_file)
%history_file% := cnt_in_f;

#uniquename(history_seq_rec)
%history_seq_rec% := record
     unsigned8 seq_num;
	%history_file%;	
end;

#uniquename(init_it)
%history_seq_rec% %init_it%(%history_file% l) := transform
	self.seq_num := 0;
	self := l;
end;

#uniquename(history_seq_in)
%history_seq_in% := project(%history_file%,%init_it%(left));

#uniquename(history_seq)
ut.MAC_Sequence_Records(%history_seq_in%, seq_num, %history_seq%);

#uniquename(slim_history_rec)
%slim_history_rec% := record
	unsigned8 	   seq_num;
	string10          phone10; 
	string10          PRIMARY_STREET_NUMBER;
	string2           pre_dir;
	string28          PRIMARY_STREET_NAME;
	string4           PRIMARY_STREET_SUFFIX;
	string2           POST_DIR;
	string10          unit_desig;
	string8           SECONDARY_ADDRESS_TYPE;
	string25          CITY;
	string2           STATE;
	string5           ZIP_CODE;
	string4           ZIP_PLUS4;
	string120         company_name;
	string8           dt_first_seen;
	string8           dt_last_seen;	
	string1 		   current_record_flag;  
	string8 		   deletion_date;
	unsigned2 	   disc_cnt6 := 0;
	unsigned2         rept_cnt6 := 0;    
	unsigned2 	   disc_cnt12 := 0;
	unsigned2         rept_cnt12 := 0;    
	unsigned2 	   disc_cnt18 := 0;
	unsigned2         rept_cnt18 := 0;    
end;

#uniquename(slim_it)
%slim_history_rec% %slim_it%(%history_seq% l) := transform
     self.rept_cnt6 := 0;
	self.rept_cnt12 := 0;
	self.rept_cnt18 := 0;
	self := l;
end;

#uniquename(history_slim)
%history_slim% := project(%history_seq%, %slim_it%(left));

#uniquename(history_dst)
#uniquename(history_srt)
#uniquename(history_grp)
%history_dst% := distribute(%history_slim%, hash(phone10, PRIMARY_STREET_NUMBER, pre_dir, PRIMARY_STREET_NAME, 
                                                 PRIMARY_STREET_SUFFIX, POST_DIR, unit_desig, SECONDARY_ADDRESS_TYPE, 
																									CITY, STATE, ZIP_CODE, ZIP_PLUS4, company_name));

%history_srt% := sort(%history_dst%, 						phone10, PRIMARY_STREET_NUMBER, pre_dir, PRIMARY_STREET_NAME,
																								PRIMARY_STREET_SUFFIX, POST_DIR, unit_desig, SECONDARY_ADDRESS_TYPE,
																								CITY, STATE, ZIP_CODE, ZIP_PLUS4, company_name, current_record_flag, 
																								deletion_date, local);
							
%history_grp% := group(%history_srt%, phone10, PRIMARY_STREET_NUMBER, pre_dir, PRIMARY_STREET_NAME,
																			PRIMARY_STREET_SUFFIX, POST_DIR, unit_desig, SECONDARY_ADDRESS_TYPE,
																			CITY,	STATE, ZIP_CODE, ZIP_PLUS4, company_name, local);


#uniquename(inter_it)
%history_grp% %inter_it%(%history_grp% l, %history_grp% r) := transform

//-------------------------------------------------------------------------------
#uniquename(m_6)
#uniquename(m_12)
#uniquename(m_18)
							
%m_6% := if((integer)(L.dt_last_seen[5..6])<7, 
                     (string4)((integer)(L.dt_last_seen[1..4])-1) + 
	     	      intformat((integer)(L.dt_last_seen[5..6])+6,2,1) + 
			      L.dt_last_seen[7..8],
				 L.dt_last_seen[1..4] + 
				 intformat((integer)(L.dt_last_seen[5..6])-6,2,1) + 
				 L.dt_last_seen[7..8]);
				 
%m_12% := (string4)((integer)(L.dt_last_seen[1..4])-1) + L.dt_last_seen[5..8];

%m_18% := (string4)((integer)(%m_6%[1..4])-1) + %m_6%[5..8];
//-------------------------------------------------------------------------------
	self.rept_cnt6 := if(r.deletion_date = l.deletion_date and
	                     r.current_record_flag = '' and 
					 (integer)r.deletion_date >= (integer)%m_6%, 
				      l.rept_cnt6+1,0);

	self.disc_cnt6 := map(r.current_record_flag = 'Y' => l.disc_cnt6+l.rept_cnt6,
	                    (integer)r.deletion_date >= (integer)%m_6% and
	                     r.deletion_date <> l.deletion_date => l.disc_cnt6+l.rept_cnt6+1,
				      l.disc_cnt6);     

     self.rept_cnt12 := if(r.deletion_date = l.deletion_date and
	                     r.current_record_flag = '' and 
					 (integer)r.deletion_date >= (integer)%m_12%, 
				      l.rept_cnt12+1,0);

	self.disc_cnt12 := map(r.current_record_flag = 'Y' => l.disc_cnt12+l.rept_cnt12,
	                    (integer)r.deletion_date >= (integer)%m_12% and
	                     r.deletion_date <> l.deletion_date => l.disc_cnt12+l.rept_cnt12+1,
				      l.disc_cnt12);     

     self.rept_cnt18 := if(r.deletion_date = l.deletion_date and
	                     r.current_record_flag = '' and 
					 (integer)r.deletion_date >= (integer)%m_18%, 
				      l.rept_cnt18+1,0);

	self.disc_cnt18 := map(r.current_record_flag = 'Y' => l.disc_cnt18+l.rept_cnt18,
	                    (integer)r.deletion_date >= (integer)%m_18% and
	                     r.deletion_date <> l.deletion_date => l.disc_cnt18+l.rept_cnt18+1,
				      l.disc_cnt18);     
	self := r;				  
end;

#uniquename(history_count)			
%history_count% := iterate(%history_grp%, %inter_it%(left, right));			

#uniquename(get_count)
%history_file% %get_count%(%history_seq% l, %history_count% r) := transform
	self.disc_cnt6 := r.disc_cnt6;
	self.disc_cnt12 := r.disc_cnt12;
	self.disc_cnt18 := r.disc_cnt18;
	self := l;
end;

cnt_out_f := join(%history_seq%, %history_count%,
                 left.seq_num = right.seq_num,
                 %get_count%(left, right), left outer, hash)

endmacro;