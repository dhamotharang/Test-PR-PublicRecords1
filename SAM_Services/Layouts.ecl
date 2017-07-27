IMPORT BIPV2, BatchShare;

EXPORT Layouts := MODULE

		EXPORT Batch_Input := RECORD
				BatchShare.Layouts.ShareAcct;
				BIPV2.IDlayouts.l_key_ids_bare;
				BatchShare.Layouts.ShareCompany - [bdid];
				BatchShare.Layouts.ShareAddress - [addr];
				STRING16  workphone;
				STRING3   mileradius;
		END;
		
		EXPORT Batch_Input_Processed := RECORD(Batch_Input)
				STRING20 orig_acctno := '';
				Batchshare.Layouts.ShareErrors;	
		END;
		
		EXPORT Batch_Raw := RECORD
				BIPV2.IDlayouts.l_key_ids_bare;
				UNSIGNED6 bdid;
				STRING10 prim_range;
				STRING2 predir;
				STRING28 prim_name;
				STRING4 addr_suffix;
				STRING2 postdir;
				STRING10 unit_desig;
				STRING8 sec_range;
				STRING25 p_city_name;
				STRING25 v_city_name;
				STRING2 st;
				STRING5 zip;
				STRING4 zip4;
				STRING20 duns;
				STRING5 title;
				STRING20 fname;
				STRING20 mname;
				STRING20 lname;
				STRING5 name_suffix;
				STRING3 name_score;
				STRING100 cname;
				STRING75 classification;
				STRING8 activedate;
				STRING12 terminationdate;
				STRING25 samnumber;
				STRING50 exclusionprogram;
				STRING15 excludingagency;
				STRING10 ctcode;
				STRING75 exclusiontype;
		END;
		
		EXPORT Batch_Raw_Acct := RECORD
				BatchShare.Layouts.ShareAcct;
				UNSIGNED6 weight;
				Batch_Raw;
		END;
		
		EXPORT SearchSlim_layout := RECORD
				BatchShare.Layouts.ShareAcct;
				BIPV2.IDlayouts.l_key_ids_bare;
				UNSIGNED6 weight;
		END;
		
		EXPORT Batch_Output := RECORD
				BatchShare.Layouts.ShareAcct;
				Batch_Raw;
				Batchshare.Layouts.ShareErrors;
		END;
END;