import AutoKeyB2, PRTE2_ATF;

EXPORT proc_build_autokeys(string filedate) := FUNCTION
	
	fAK := PRTE2_ATF.files.ATF_firearms_autokey;

	layout_autokey := RECORD
		fAK;
	END;

	layout_autokey Norm1 (fAK L,integer c) := TRANSFORM
    self.Business_Name:=if(c=1,l.Business_Name,'');
		self.license1_fname:=if(c=1,l.license1_fname,l.license2_fname);
		self.license1_mname:=if(c=1,l.license1_mname,l.license2_mname);
		self.license1_lname:=if(c=1,l.license1_lname,l.license2_lname);
		self.license1_name_suffix:=if(c=1,l.license1_name_suffix,l.license2_name_suffix);		
		self := L;
	END;

	File_ATF_autoKey_1 := normalize(fAK, IF(left.license2_lname <> '',2,1),Norm1(Left,counter));
	File_ATF_autokey_2 := dedup(File_ATF_autoKey_1,record,all);

	layout_autokey Norm2 (File_ATF_autoKey_2 L,integer c) := TRANSFORM
    self.premise_prim_range :=if(c=1,l.premise_prim_range,l.mail_prim_range);
		self.premise_predir :=if(c=1,l.premise_predir,l.mail_predir);
		self.premise_prim_name :=if(c=1,l.premise_prim_name,l.mail_prim_name);
		self.premise_suffix:=if(c=1,l.premise_suffix,l.mail_suffix);
		self.premise_postdir:=if(c=1,l.premise_postdir,l.mail_postdir);
		self.premise_unit_desig:=if(c=1,l.premise_unit_desig,l.mail_unit_desig);
		self.premise_sec_range:=if(c=1,l.premise_sec_range,l.mail_sec_range);
		self.premise_p_city_name:=if(c=1,l.premise_p_city_name,l.mail_p_city_name);
		self.premise_st:=if(c=1,l.premise_st,l.mail_st);
		self.premise_zip:=if(c=1,l.premise_zip,l.mail_zip);
		self.premise_zip4:=if(c=1,l.premise_zip4,l.mail_zip4);
		self := L;
	END;

	File_ATF_Autokey_3 := normalize(File_ATF_autoKey_2,
																	IF(left.premise_prim_name = left.mail_prim_name and left.premise_p_city_name = left.mail_p_city_name,2,1),
																	Norm2(Left,counter));
	File_ATF_Autokey := dedup(File_ATF_Autokey_3,record,all);

	AutoKeyB2.MAC_Build(File_ATF_Autokey,license1_fname,license1_mname,license1_lname,
                     best_ssn,
                     zero,
                     blank,
                     premise_prim_name,
                     premise_prim_range,
                     premise_st,
                     premise_p_city_name,
                     premise_zip,
                     premise_sec_range,
                     zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,
                     did_out6,
                     Business_Name,
                     zero,
                     zero,
                     premise_prim_name,premise_prim_range,premise_st,premise_p_city_name,premise_zip,premise_sec_range,
                     bdid6, // bdid_out
                     Constants.ak_keyname,
										 Constants.ak_logical(filedate),
                     BAK,false,
                     Constants.ak_skipSet,true,Constants.ak_typeStr,
                     true,,,zero);

	AutoKeyB2.MAC_AcceptSK_to_QA(Constants.ak_keyname, MAK,, Constants.ak_skipSet);
	
	RETURN Sequential(BAK, MAK);
END;