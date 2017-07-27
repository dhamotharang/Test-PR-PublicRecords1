import NID;

basefile := Corp.File_Corporate_Affiliations_Plus;

keyfile := Corp.Key_Corporate_Affiliations_State_LFName;

basefile FetchBaseRecords(basefile L) := TRANSFORM
  SELF := L;
END;

KeyFilter(STRING2 state_key, STRING20 firstname_key, STRING20 lastname_key, boolean f_loose, boolean l_loose) := 
			MAP(state_key='' =>
                       keyfile(lastname_key <> '',
                       (f_loose and (NID.mod_PFirstTools.SubLinPFR(pfname, firstname_key)
                         or NID.mod_PFirstTools.SUBPFLeqR(firstname_key,pfname))) 
                         or fname[1..length(trim(firstname_key))]=firstname_key or firstname_key[1..length(trim(fname))]=fname,
                       dph_lname=metaphonelib.DMetaPhone1(lastname_key),
                       l_loose or lname=lastname_key),
                firstname_key='' =>
			           keyfile(st=state_key,
                       dph_lname=metaphonelib.DMetaPhone1(lastname_key),
                       l_loose or lname=lastname_key),
                keyfile(st=state_key,
                       (f_loose and (NID.mod_PFirstTools.SubLinPFR(pfname, firstname_key) 
											   or NID.mod_PFirstTools.SUBPFLeqR(firstname_key, pfname)))
											   or fname[1..length(trim(firstname_key))]=firstname_key or firstname_key[1..length(trim(fname))]=fname,
                       dph_lname=metaphonelib.DMetaPhone1(lastname_key),
                       l_loose or lname=lastname_key));

export Fetch_CA_State_LFName(STRING2 state_key, STRING20 firstname_key, STRING20 lastname_key,boolean f_loose=false,boolean l_loose=false) := 
   FETCH(basefile, 
		 KeyFilter(state_key,firstname_key,lastname_key,f_loose,l_loose),
         RIGHT.__filepos,
         FetchBaseRecords(LEFT));