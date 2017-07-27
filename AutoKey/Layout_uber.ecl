export Layout_uber := MODULE

		export word_rec := RECORD
			string30 word;
			unsigned8 cnt;
			unsigned4 id;
			real8 field_specificity;
		 END;
		 
		export ref_rec := RECORD
			unsigned4 word_id;
			unsigned2 field;
			unsigned6 uid;
		 END;
		 
		 export word_params := RECORD
		  string30 word;
      unsigned2 field;
		 END;
		 
		 export field_definition := RECORD
		   String FieldName;
			 integer FieldID;
		 END;

END;