import Corrections, crim_common;

export Layouts := MODULE
		EXPORT Layout_ofk := RECORD
			STRING60 ofk;
			STRING10 doc_num;
			unsigned6 did;
		END;
		EXPORT outpl_ds := record
			unsigned integer6 sdid;
			string60 offender_key;
			unsigned integer8 __internal_fpos__;
		end;
		EXPORT AKids_type := RECORD
			unsigned6 ID;
			boolean isDID;
			boolean isBDID;
			boolean IsFake;
		END;
		EXPORT base_params := INTERFACE
			export string25	doc_val := '' : stored('DOCNumber');
			export string2  doc_state := '' : stored('DOCState');
			export string60	ofk_val := '' : stored('OffenderKey');
      export string14 uid_value := '' : stored('UniqueId');			
		END;

		export docnum_rec := record
			string25 doc_number;
		end;
		
		EXPORT event_params := INTERFACE(base_params)
			export boolean report_reqd := false : stored('ReportReq');
			export boolean off_reqd := false : stored('ReturnOffenses'); //moved the 'or's into the raw
			export boolean par_reqd := false : stored('ReturnParoles');
			export boolean pt_reqd  := false : stored('ReturnPrisonTerms');
			export boolean acts_reqd := false : stored('ReturnActivities');		
		END;
		
		export offender_base := RECORD
		  string60	offender_key;
			string1	data_type := '';
			string25	case_type_desc := '';
		END;
		
		export offender_layout := record
	    Corrections.Layout_Offender;
    end;

		export offense_layout := record
			string25	case_type;
			corrections.Layout_Offense;
		end;

		export CourtOffenses_layout := record
			crim_common.Layout_Moxie_Court_Offenses;
			string35	arr_off_lev_mapped;
			string35	court_off_lev_mapped;
		end;
		
		EXPORT punishment_layout := RECORD
		  corrections.Layout_CrimPunishment;
		END;
		
		EXPORT activity_Layout := RECORD
		  corrections.Layout_Activity;
		ENd;
				
		export report_layout := RECORD, maxlength(350000)
			unsigned4	seq := 0;
			string60	offender_key;
			string1	data_type;
			string25	case_type_desc;
			dataset(offense_layout) DOC_offenses;
			dataset(CourtOffenses_layout) Court_offenses;
			dataset(corrections.Layout_CrimPunishment) paroles;
			dataset(corrections.Layout_CrimPunishment) prisonTerms;
			dataset(corrections.Layout_Activity) activities;
		END;
		
		export Autokey_layout := record
			unsigned6 did;
			// string45	datasource;	
			string60	offender_key;
			string20	lname;		
			string20	fname;	
			string20	mname;
			// string6		name_suffix;
			qstring10 prim_range;
			qstring28 prim_name;
			qstring8  sec_range;
			qstring25 v_city_name;
			string2   state;
			qstring5  zip5;
			string9		ssn;
			string8		dob;
			string1		blank := '';
			unsigned1	zero := 0;
		end;
		
END;