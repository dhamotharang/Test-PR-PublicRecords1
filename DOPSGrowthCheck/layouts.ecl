EXPORT layouts := module
			export Unique_Stats_Layout	:=	record
				string PackageName;
				string KeyName;
				string Version;
				string num_recs;
				string unique_did;
				string unique_proxid;
				string unique_seleid;
				string unique_index;
				string unique_payload;
			end;
			export Basic_Delta_Stats	:=	RECORD
				string PackageName;
				string KeyName;
				string CertVersion;
				string ProdVersion;
				string delta_num_recs;
				string delta_unique_did;
				string delta_unique_proxid;
				string delta_unique_seleid;
				string delta_unique_index;
				string delta_unique_payload;
			END;
			export Configuration_Layout := RECORD
				string PackageName;
				string KeyAttribute;
				string KeyFile;
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
				string KeyFile;
				string CertVersion;
				string ProdVersion;
				string Threshold;				
			END;
			export Attribute_Layout_For_Command := RECORD
				string PackageName;
				string KeyAttribute;
				string KeyFile;
				string indexfields;
				//string hasProdRecord;
				string CertVersion;
				string ProdVersion;
			END;
end;