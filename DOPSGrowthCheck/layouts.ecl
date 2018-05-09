EXPORT layouts := module
			export Stats_Layout	:=	record
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
			end;
			export Configuration_Layout := RECORD
				string PackageName;
				string KeyAttribute;
				string KeyNickName;
				string KeyFile;
				string PersistRecIDField;
				string EmailField;
				string PhoneField;
				string SSNField;
				string FeinField;
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
				string KeyFile;
				string CertVersion;
				string ProdVersion;
				string PersistRecIDField;
				string EmailField;
				string PhoneField;
				string SSNField;
				string FeinField;
				string Threshold;				
			END;
			export Attribute_Layout_For_Command := RECORD
				string PackageName;
				string KeyAttribute;
				string KeyNickName;
				string KeyFile;
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
			export Full_Delta_Stat_Layout := RECORD
				string PackageName;
				string KeyAttribute;
				string KeyNickName;
				string Stat_Name;
				string results;
			END;

			end;
end;