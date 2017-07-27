/*--LIBRARY--*/
// This library performs penalty calculations based on individual name.
// All logic for performing the calculation should be based here.
import ut, NID, AutoStandardI, STD;

alphabet := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
AlphasOnly (string strIn) := STD.Str.Filter (strIn, alphabet);

export LIB_PenaltyI_Indv_Name(AutoStandardI.LIBIN.PenaltyI_Indv_Name.full args) := MODULE/*,LIBRARY*/(AutoStandardI.LIBOUT.PenaltyI_Indv_Name(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(args);
		temp_lname_set_value := AutoStandardI.InterfaceTranslator.lname_set_value.val(args);
		temp_fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(args);
		temp_fname_set_value := AutoStandardI.InterfaceTranslator.fname_set_value.val(args);
		temp_lname4_value := AutoStandardI.InterfaceTranslator.lname4_value.val(args);
		temp_fname3_value := AutoStandardI.InterfaceTranslator.fname3_value.val(args);
		temp_lname_wild := AutoStandardI.InterfaceTranslator.lname_wild.val(args);
		temp_lname_wild_val := AutoStandardI.InterfaceTranslator.lname_wild_val.val(args);
		temp_phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(args);
		temp_usephoneticdistance := AutoStandardI.InterfaceTranslator.usephoneticdistance.val(args);
		temp_fname_wild := AutoStandardI.InterfaceTranslator.fname_wild.val(args);
		temp_fname_wild_val := AutoStandardI.InterfaceTranslator.fname_wild_val.val(args);
		temp_mname_value := AutoStandardI.InterfaceTranslator.mname_value.val(args);
		temp_non_exclusion_value := AutoStandardI.InterfaceTranslator.non_exclusion_value.val(args);
		temp_BpsLeadingNameMatch_value :=	AutoStandardI.InterfaceTranslator.BpsLeadingNameMatch_value.val(args);
		temp_lname_trailing_value :=	AutoStandardI.InterfaceTranslator.lname_trailing_value.val(args);
		temp_fname_trailing_value :=	AutoStandardI.InterfaceTranslator.fname_trailing_value.val(args);
		// Add lnameIn_clean and fnameIn_clean: used in Doxie.FN_Tra_Penalty variants
		// helps to score names with punctuation/spaces within (reduces it to a single word of alpha chars only)
		lnameIn := if(temp_lname_value != '', temp_lname_value, temp_lname4_value);
		fnameIn := if(temp_fname_value != '', temp_fname_value, temp_fname3_value);
		lnameIn_clean := AlphasOnly(lnameIn);
		fnameIn_clean := AlphasOnly(fnameIn);

		boolean SamePhonetization := metaphonelib.DMetaPhone1(args.lname_field)= metaphonelib.DMetaPhone1(lnameIn);
		clean_fields := module
			export fname := AlphasOnly(args.fname_field);
			export mname := AlphasOnly(args.mname_field);
			export lname := AlphasOnly(args.lname_field);
		end;
		
		isTransposed :=
			fnameIn_clean != '' and lnameIn_clean != '' and fnameIn_clean != lnameIn_clean and
			fnameIn_clean in [clean_fields.fname, clean_fields.mname, clean_fields.lname] and
			lnameIn_clean in [clean_fields.fname, clean_fields.mname, clean_fields.lname];
		
		//NB: supposedly default penalty threshold is 10 (only less than that will be exposed)
		pen := MAP(temp_lname_wild and args.allow_wildcard and STD.Str.WildMatch (args.lname_field, temp_lname_wild_val, true) => 0,
							 temp_lname_wild and args.allow_wildcard => AutoStandardI.Constants.DEFAULT_THRESHOLD,
							 lnameIn='' or args.lname_field=lnameIn => 0,
							 args.lname_field='' => 3,
							 temp_BpsLeadingNameMatch_value and temp_lname_trailing_value and args.lname_field[1..length(trim(lnameIn))] = lnameIn => 1,
							 args.lname_field in temp_lname_set_value => 1, // accounts for name variants match

				 //namesimilar seems return either 0-6 or 99, so it is adjusted +3
				 //metaphone appears to have too many false positives, so penalty is
				 //calculated using both, with a cap of 10 for last name mismatch
							 
							 //strip non-alphas before comparing to lnameIn_clean
							 MIN((datalib.namesimilar(clean_fields.lname,lnameIn_clean,1)+ 3)/ IF(SamePhonetization,2,1),AutoStandardI.Constants.DEFAULT_THRESHOLD)) + 
		MAP(temp_fname_wild and args.allow_wildcard and STD.Str.WildMatch (args.fname_field, temp_fname_wild_val, true) => 0,
				temp_fname_wild and args.allow_wildcard => AutoStandardI.Constants.DEFAULT_THRESHOLD,
				fnameIn='' or args.fname_field=fnameIn => 0,
				NID.mod_PFirstTools.PFLeqPFR(args.fname_field, fnameIn) => 1,
				args.fname_field[1]=fnameIn or args.fname_field=fnameIn[1] => 1,   
				args.fname_field='' => 3,
			  temp_BpsLeadingNameMatch_value and temp_fname_trailing_value and args.fname_field[1..length(trim(fnameIn))] = fnameIn => 1,
				args.fname_field in temp_fname_set_value => 1, // accounts for name variants match
			//strip non-alphas before comparing to fnameIn_clean
				MIN((datalib.namesimilar(clean_fields.fname,fnameIn_clean,1) + 3),AutoStandardI.Constants.DEFAULT_THRESHOLD)) +
		MAP(temp_mname_value='' or args.mname_field=temp_mname_value => 0,
				args.mname_field[1]=temp_mname_value or args.mname_field=temp_mname_value[1] => 1,
				args.mname_field='' => 2,
				LENGTH(TRIM(temp_mname_value))=1 or temp_non_exclusion_value => 3,
				MIN((datalib.namesimilar(args.mname_field,temp_mname_value,1) * 3),AutoStandardI.Constants.DEFAULT_THRESHOLD));
		
		return if(pen>3 and isTransposed, 3, pen); // max out at 3 when supplied fname/lname match but are transposed
	END;
END;