// spray PAS0868 - Pennsylvania Real Estate Appraisers, Agents, Brokers, & Firms  
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;



EXPORT spray_PAS0868 := MODULE

	#workunit('name','Spray PAS0868');
	SHARED STRING7 code						:= 'PAS0868';

	SHARED write_active(string src_file_name, string dest_file_name, string id, string typ, string status) := FUNCTION
		src_file := DATASET(src_file_name, Prof_License_Mari.layout_PAS0868.active, CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
		dest_file := PROJECT(src_file,TRANSFORM(Prof_License_Mari.layout_PAS0868.active,
																								 SELF.ID:=id;SELF.TYP:=typ;SELF.STATUS:=ut.fnTrim2Upper(status);
																								 SELF:=LEFT;SELF:=[];));
		out_dest := OUTPUT(dest_file,,dest_file_name, OVERWRITE);
		RETURN out_dest;
	END;
	
	SHARED write_inactive(string src_file_name, string dest_file_name, string id, string typ, string status) := FUNCTION
		src_file := DATASET(src_file_name, Prof_License_Mari.layout_PAS0868.inactive, CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
		dest_file := PROJECT(src_file,TRANSFORM(Prof_License_Mari.layout_PAS0868.inactive,
																								 SELF.ID:=id;SELF.TYP:=typ;SELF.STATUS:=status;
																								 SELF:=LEFT;SELF:=[];));
		out_dest := OUTPUT(dest_file,,dest_file_name, OVERWRITE);
		RETURN out_dest;
	END;

	SHARED write_active_1(string src_file_name, string dest_file_name, string id, string typ, string status) := FUNCTION
		src_file := DATASET(src_file_name, Prof_License_Mari.layout_PAS0868.active_1, CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
		dest_file := PROJECT(src_file,TRANSFORM(Prof_License_Mari.layout_PAS0868.active_1,
																								 SELF.ID:=id;SELF.TYP:=typ;SELF.STATUS:=status;
																								 SELF:=LEFT;SELF:=[];));
		out_dest := OUTPUT(dest_file,,dest_file_name, OVERWRITE);
		RETURN out_dest;
	END;
	
	SHARED write_inactive_1(string src_file_name, string dest_file_name, string id, string typ, string status) := FUNCTION
		src_file := DATASET(src_file_name, Prof_License_Mari.layout_PAS0868.inactive_1, CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
		dest_file := PROJECT(src_file,TRANSFORM(Prof_License_Mari.layout_PAS0868.inactive_1,
																								 SELF.ID:=id;SELF.TYP:=typ;SELF.STATUS:=status;
																								 SELF:=LEFT;SELF:=[];));
		out_dest := OUTPUT(dest_file,,dest_file_name, OVERWRITE);
		RETURN out_dest;
	END;

	SHARED write_active_2(string src_file_name, string dest_file_name, string id, string typ, string status) := FUNCTION
		src_file := DATASET(src_file_name, Prof_License_Mari.layout_PAS0868.active_2, CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
		dest_file := PROJECT(src_file,TRANSFORM(Prof_License_Mari.layout_PAS0868.active_2,
																								 SELF.ID:=id;SELF.TYP:=typ;SELF.STATUS:=status;
																								 SELF:=LEFT;SELF:=[];));
		out_dest := OUTPUT(dest_file,,dest_file_name, OVERWRITE);
		RETURN out_dest;
	END;
	
	SHARED write_inactive_2(string src_file_name, string dest_file_name, string id, string typ, string status) := FUNCTION
		src_file := DATASET(src_file_name, Prof_License_Mari.layout_PAS0868.inactive_2, CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
		dest_file := PROJECT(src_file,TRANSFORM(Prof_License_Mari.layout_PAS0868.inactive_2,
																								 SELF.ID:=id;SELF.TYP:=typ;SELF.STATUS:=status;
																								 SELF:=LEFT;SELF:=[];));
		out_dest := OUTPUT(dest_file,,dest_file_name, OVERWRITE);
		RETURN out_dest;
	END;

	SHARED write_active_3(string src_file_name, string dest_file_name, string id, string typ, string status) := FUNCTION
		src_file := DATASET(src_file_name, Prof_License_Mari.layout_PAS0868.active_3, CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
		dest_file := PROJECT(src_file,TRANSFORM(Prof_License_Mari.layout_PAS0868.active_3,
																								 SELF.ID:=id;SELF.TYP:=typ;SELF.STATUS:=status;
																								 SELF:=LEFT;SELF:=[];));
		out_dest := OUTPUT(dest_file,,dest_file_name, OVERWRITE);
		RETURN out_dest;
	END;
	
	SHARED write_inactive_3(string src_file_name, string dest_file_name, string id, string typ, string status) := FUNCTION
		src_file := DATASET(src_file_name, Prof_License_Mari.layout_PAS0868.inactive_3, CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
		dest_file := PROJECT(src_file,TRANSFORM(Prof_License_Mari.layout_PAS0868.inactive_3,
																								 SELF.ID:=id;SELF.TYP:=typ;SELF.STATUS:=status;
																								 SELF:=LEFT;SELF:=[];));
		out_dest := OUTPUT(dest_file,,dest_file_name, OVERWRITE);
		RETURN out_dest;
	END;

	SHARED write_inactive_4(string src_file_name, string dest_file_name, string id, string typ, string status) := FUNCTION
		src_file := DATASET(src_file_name, Prof_License_Mari.layout_PAS0868.inactive_4, CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
		dest_file := PROJECT(src_file,TRANSFORM(Prof_License_Mari.layout_PAS0868.inactive_4,
																								 SELF.ID:=id;SELF.TYP:=typ;SELF.STATUS:=status;
																								 SELF:=LEFT;SELF:=[];));
		out_dest := OUTPUT(dest_file,,dest_file_name, OVERWRITE);
		RETURN out_dest;
	END;
	
	SHARED add_Record_Source_Info(string pVersion, string filename, string su_ind) := FUNCTION
		superfile := Prof_License_Mari.Common_Prof_Lic_Mari.SourcesFolder + code + '::sprayed' + '::' + su_ind;
		src_file_name := Prof_License_Mari.Common_Prof_Lic_Mari.SourcesFolder + code + '::' + pVersion + '::' + filename + '.txt';
		dest_file_name := Prof_License_Mari.Common_Prof_Lic_Mari.SourcesFolder + code + '::' + pVersion + '::' + filename + '.raw';
		//id 900 type 12001 active format B
		id := REGEXFIND('id ([0-9]+) ', filename, 1);
		typ := REGEXFIND(' type ([0-9]+) ', filename, 1);
		status := REGEXFIND(' (active|inactive) format ', filename, 1);
		format := ut.fnTrim2Upper(REGEXFIND(' format ([A|B]$)', filename, 1));
		
		layout_tmp := RECORD
			string line;
		END;
			write_to_output := map(su_ind='active' => write_active(src_file_name,dest_file_name,id,typ,status),
														 su_ind='inactive' => write_inactive(src_file_name,dest_file_name,id,typ,status),
														 su_ind='active_1' => write_active_1(src_file_name,dest_file_name,id,typ,status),
														 su_ind='inactive_1' => write_inactive_1(src_file_name,dest_file_name,id,typ,status),
														 su_ind='active_2' => write_active_2(src_file_name,dest_file_name,id,typ,status),
														 su_ind='inactive_2' => write_inactive_2(src_file_name,dest_file_name,id,typ,status),
														 su_ind='active_3' => write_active_3(src_file_name,dest_file_name,id,typ,status),
														 su_ind='inactive_3' => write_inactive_3(src_file_name,dest_file_name,id,typ,status),
														 su_ind='inactive_4' => write_inactive_4(src_file_name,dest_file_name,id,typ,status),
														 output('Invalid file type - ' + su_ind));
		RETURN SEQUENTIAL(
							FileServices.StartSuperFileTransaction();
							FileServices.RemoveSuperFile(superfile,dest_file_name);
							FileServices.FinishSuperFileTransaction();
							write_to_output;
							FileServices.StartSuperFileTransaction();
							FileServices.RemoveSuperFile(superfile,src_file_name);
							FileServices.AddSuperFile(superfile,dest_file_name);
							FileServices.FinishSuperFileTransaction();
							);
	END;

	//  Spray All Files
	EXPORT S0868_SprayFiles(string pVersion) := FUNCTION
	
		//Active - 			id_900_type_12001_active_format_B (RL/Certified Real Est. Appraisers/Certified Residential Appraiser)
		//         			id_900_type_12005_active_format_B (GA)
		//         			id_900_type_12010_active_format_B (AV)
		//         			id_900_type_12030_active_format_B (BA)
		//inactive - 		id_900_type_12001_inactive_format_B
		//           		id_900_type_12005_inactive_format_B
		//           		id_900_type_12010_inactive_format_B
		//           		id_900_type_12030_inactive_format_B
		//active_1 - 		id_1200_type_12001_active_format_B (AB)
		//           		id_1200_type_12270_A-E_active_format_B (RS/Real Estate Salesperson-Standard)
		//           		id_1200_type_12270_F-J_active_format_B
		//           		id_1200_type_12270_K-N_active_format_B
		//           		id_1200_type_12270_O-T_active_format_B
		//           		id_1200_type_12270_U-Z_active_format_B
		//           		id_1200_type_12310_active_format_B
		//inactive_1 - 	id_1200_type_12001_inactive_format_B
		//             	id_1200_type_12270_A-E_inactive_format_B
		//             	id_1200_type_12270_F-J_inactive_format_B
		//             	id_1200_type_12270_K-N_inactive_format_B
		//             	id_1200_type_12270_O-T_inactive_format_B
		//             	id_1200_type_12270_U-Z_inactive_format_B
		//             	id_1200_type_12310_inactive_format_B (RM/Broker Multi-Licensee-Standard)
		//active_2 - 		id_1200_type_12190_active_format_A (SB/RB)
		//inactive_2 - 	id_1200_type_12190_inactive_format_A
		//active_3 - 		id_1200_type_12150_active_format_A (RO)
		//           		id_1200_type_12200_active_format_A (RB)
		//inactive_3 - 	id_1200_type_12150_inactive_format_A
		//             	id_1200_type_12200_inactive_format_A

		RETURN PARALLEL(
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 900 type 12001 active format B.txt', 'active','comma'); 
			add_Record_Source_Info(pVersion,'id 900 type 12001 active format B','active');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 900 type 12001 inactive format B.txt', 'inactive','comma'); 		 
			add_Record_Source_Info(pVersion,'id 900 type 12001 inactive format B','inactive');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 900 type 12005 active format B.txt', 'active','comma'); 		 
			add_Record_Source_Info(pVersion,'id 900 type 12005 active format B','active');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 900 type 12005 inactive format B.txt', 'inactive','comma'); 		 
			add_Record_Source_Info(pVersion,'id 900 type 12005 inactive format B','inactive');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 900 type 12010 active format B.txt', 'active','comma'); 		 
			add_Record_Source_Info(pVersion,'id 900 type 12010 active format B','active');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 900 type 12010 inactive format B.txt', 'inactive','comma'); 		 
			add_Record_Source_Info(pVersion,'id 900 type 12010 inactive format B','inactive');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 900 type 12030 active format B.txt', 'active','comma'); 		 
			add_Record_Source_Info(pVersion,'id 900 type 12030 active format B','active');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 900 type 12030 inactive format B.txt', 'inactive','comma'); 		 
			add_Record_Source_Info(pVersion,'id 900 type 12030 inactive format B','inactive');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12001 active format B.txt', 'active_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12001 active format B','active_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12001 inactive format B.txt', 'inactive_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12001 inactive format B','inactive_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12150 active format A.txt', 'active_3','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12150 active format A','active_3');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12150 inactive format A.txt', 'inactive_3','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12150 inactive format A','inactive_3');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12190 active format A.txt', 'active_2','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12190 active format A','active_2');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12190 inactive format A.txt', 'inactive_2','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12190 inactive format A','inactive_2');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12200 active format A.txt', 'active_3','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12200 active format A','active_3');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12200 inactive format A.txt', 'inactive_3','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12200 inactive format A','inactive_3');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 A-E active format B.txt', 'active_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12270 A-E active format B','active_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 A-E inactive format B.txt', 'inactive_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12270 A-E inactive format B','inactive_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 F-J active format B.txt', 'active_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12270 F-J active format B','active_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 F-J inactive format B.txt', 'inactive_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12270 F-J inactive format B','inactive_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 K-N active format B.txt', 'active_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12270 K-N active format B','active_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 K-N inactive format B.txt', 'inactive_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12270 K-N inactive format B','inactive_1');			
			// Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 K-N inactive format A.txt', 'inactive_4','comma'); 		 
			// add_Record_Source_Info(pVersion,'id 1200 type 12270 K-N inactive format A','inactive_4');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 O-T active format B.txt', 'active_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12270 O-T active format B','active_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 O-T inactive format B.txt', 'inactive_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12270 O-T inactive format B','inactive_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 U-Z active format B.txt', 'active_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12270 U-Z active format B','active_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12270 U-Z inactive format B.txt', 'inactive_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12270 U-Z inactive format B','inactive_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12310 active format B.txt', 'active_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12310 active format B','active_1');			
			Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'id 1200 type 12310 inactive format B.txt', 'inactive_1','comma'); 		 
			add_Record_Source_Info(pVersion,'id 1200 type 12310 inactive format B','inactive_1');			
		);
	END;

END;





