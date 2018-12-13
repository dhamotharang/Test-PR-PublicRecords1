

EXPORT U_Gather_PRCT_Constants := MODULE

			SHARED States1a := ['AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA','HI','IA','ID','IL','IN','KS','KY'];
			SHARED States2a := ['LA','MA','MD','ME','MI','MN','MO','MS'];
			SHARED States2b := ['MT','NC','ND','NE','NH','NJ','NM','NV','NY'];
			SHARED States3a := ['OH', 'OK','OR','PA','RI','SC','SD','TN','TX','UT','VA','VT','WA','WI','WV','WY'];
			EXPORT States1 := States1a+States2a;
			EXPORT States2 := States2b+States3a;


END;