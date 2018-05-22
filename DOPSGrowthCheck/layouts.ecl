﻿EXPORT layouts := module
			/*export Stats_Layout	:=	record
				string PackageName;
				string KeyName;
				string KeyNickName;
				string CurrVersion;
				string PrevVersion;
				string num_recs;
				string unique_did;
				string unique_proxid;
				string unique_seleid;
				string Unique_PersistentRecID;
				string unique_Email;
				string unique_Phone;
				string unique_SSN;
				string unique_Fein;
				string unique_index;
				string unique_payload;
				string RecType;
				string Passed;
			end;*/
			export Stats_Layout	:= RECORD
				string PackageName;
				string KeyName;
				string KeyNickName;
				string CurrVersion;
				string PrevVersion;
				string Stat_Name;
				string results;
				string RecType;
				string passed;
			END;
			export Configuration_Layout := RECORD
				string PackageName;
				string KeyAttribute;
				string KeyNickName;
				string KeyFilePre;
				string KeyFilePost;
				string PersistRecIDField;
				string EmailField;
				string PhoneField;
				string SSNField;
				string FeinField;
				string FieldsOfInterest;
				string Threshold;
			END;
			export Date_Compare_Layout := RECORD
				string PackageName;
				string CertVersion;
				string ProdVersion;
				boolean Updated;
			END;
			export Build_Data_Layout := RECORD
				string PackageName;
				string KeyAttribute;
				string KeyNickName;
				string KeyFileNew;
				string KeyFileOld;
				string CertVersion;
				string ProdVersion;
				string PersistRecIDField;
				string EmailField;
				string PhoneField;
				string SSNField;
				string FeinField;
				string FieldsOfInterest;
				string Threshold;				
			END;
			export Attribute_Layout_For_Command := RECORD
				string PackageName;
				string KeyAttribute;
				string KeyNickName;
				string KeyFileNew;
				string indexfields;
				//string hasProdRecord;
				string PersistRecIDField;
				string EmailField;
				string PhoneField;
				string SSNField;
				string FeinField;
				string CertVersion;
				string ProdVersion;
			END;
			
			export Delta_Attribute_Layout_For_Command := RECORD
				string KeyFileNew;
				string KeyFileOld;
				string PackageName;
				string KeyNickName;
				string KeyAttribute;
				string PersistRecIDField;
				string CertVersion;
				string ProdVersion;
				string FieldsOfInterest;
			END;
			export Full_Delta_Stat_Layout := RECORD
				string PackageName;
				string KeyNickName;
				string CurrVersion;
				string PrevVersion;
				string field;
				string Stat_Name;
				string results_percent;
				string results_count;
				string passed;
			END;
end;