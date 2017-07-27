    //input rec
		int_rec := RECORD
			string1 source;
			String20 CompanyID;
			String20 LoginID;
			String32 Session_ID;
		END;

		int_ds := DEDUP(SORT(PROJECT(WEbClick_Tracker.OrderedDSFPos,int_rec),source,session_id),source,session_id);
    
		//output rec
		user_rec := RECORD
			string1 source;
			String20 UserID;
			String1  ID_Type;
			String32 SEssion_ID;
		END;

		user_rec xfm_int_ds(int_rec L, integer c) := TRANSFORM
			SELF.UserID := CHOOSE(c,L.companyID,L.LoginID);
			SELF.ID_Type := CHOOSE(c,'C','L');
			SELF := L;
		END;

		norm_ds := NORMALIZE(int_ds,2,xfm_int_ds(Left,counter));
		

    //Base File
export build_userID := norm_ds;
