EXPORT layout_AllPossibleSSNs := MODULE

	EXPORT _src_rec := RECORD
				string2 src;
				unsigned2 src_rank;
				unsigned3 dt_first_seen;
				unsigned3 dt_last_seen;
				boolean ispriortodob;
			 END;

	EXPORT _ssndata_rec := RECORD
			 string1 ssn_ind;
			 DATASET(_src_rec) srcs;
			 boolean ismostrecent;
			 boolean isoriginal;
			 boolean isconfirmed;
			END;

	EXPORT _other_rec := RECORD
			 unsigned8 did;
			 string9 cluster;
			 _ssndata_rec _ssndata;
			END;

	EXPORT _subject_rec := RECORD
			string9 ssn;
			_ssndata_rec _ssndata;
			unsigned4 score;
			unsigned2 confidence;
			unsigned4 other_cnt;
			DATASET(_other_rec) other;
		 END;
		 
	EXPORT _main := RECORD
		 unsigned8 did;
		 string9 cluster;
		 DATASET(_subject_rec) subject;
		END;
 
 END;