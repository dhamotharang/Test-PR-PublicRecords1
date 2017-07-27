import ut,doxie,NID;

export FN_Tra_Penalty_Name(string fname_field,string mname_field,string lname_field, 
                           string ref_fname,string ref_mname,string ref_lname 
                          ) := FUNCTION

unsigned1 THRESHOLD_DEFAULT := 10; //can be made external, if it really is a common convention
Doxie.MAC_Header_Field_Declare()

// Add lnameIn_clean and fnameIn_clean: used in Doxie.FN_Tra_Penalty variants
// helps to score names with punctuation/spaces within (reduces it to a single word of alpha chars only)
lnameIn := ref_lname;
fnameIn := ref_fname;
lnameIn_clean := ut.AlphasOnly(lnameIn);
fnameIn_clean := ut.AlphasOnly(fnameIn);
boolean SamePhonetization := metaphonelib.DMetaPhone1(lname_field)= metaphonelib.DMetaPhone1(lnameIn);
		
//NB: supposedly default penalty threshold is 10 (only less than that will be exposed)
RETURN MAP(lnameIn='' or lname_field=lnameIn => 0,
           lname_field='' => 3,
           // separate  handling for 'phonetics'
           (phonetics OR UsePhoneticDistance) and SamePhonetization => 5 + StringLib.EditDistance (lname_field, lnameIn),
           ut.imin2((datalib.namesimilar(ut.AlphasOnly(lname_field),lnameIn_clean,1)+ 3)/IF(SamePhonetization,2,1),THRESHOLD_DEFAULT)) + 
					 
MAP(fnameIn='' or fname_field=fnameIn => 0,
    NID.mod_PFirstTools.PFLeqPFR(fname_field,fnameIn) => 1,
    fname_field[1]=fnameIn or fname_field=fnameIn[1] => 1,   
    fname_field='' => 3,
	  //strip non-alphas before comparing to fnameIn_clean
    ut.imin2((datalib.namesimilar(ut.AlphasOnly(fname_field),fnameIn_clean,1) + 3),THRESHOLD_DEFAULT)) +
MAP(mname_value='' or mname_field=mname_value => 0,
    mname_field[1]=mname_value or mname_field=mname_value[1] => 2,
    mname_field='' => 2,
		LENGTH(TRIM(mname_value))=1=> 3,
    ut.imin2((datalib.namesimilar(mname_field,mname_value,1) * 3),THRESHOLD_DEFAULT));
END;