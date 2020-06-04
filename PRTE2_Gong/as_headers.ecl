import header, mdr,gong_build,ut,Business_Header,_validate, gong_v2, gong;

EXPORT as_headers := module

  Header.Layout_New_Records 		map_to_person_header(files.file_Gong_History le) := transform
		self.src := if(le.bell_id='NEU',mdr.sourceTools.src_Gong_Neustar,mdr.sourceTools.src_Gong_History);
		SELF.dt_first_seen						:= (UNSIGNED3)le.dt_first_seen[1..6];
		SELF.dt_last_seen							:= if((UNSIGNED3)le.dt_last_seen[1..6] != 0, (UNSIGNED3)le.dt_last_seen[1..6],SELF.dt_first_seen);
		SELF.dt_vendor_first_reported := (UNSIGNED3)(Le.filedate[1..6]);
		SELF.dt_vendor_last_reported	:= (UNSIGNED3)(Le.filedate[1..6]);
		self.dt_nonglb_last_seen		:= gong_build.cast_date(le.filedate); 
		self.rec_type 				:= '1';
		self.vendor_id 			:=  le.cust_name;//gong_build.cast_uniqueid(le.filedate,le.sequence_number,le.bell_id);
		self.did                      := le.did;
		self.title                    := '';
		self.fname                    := le.name_first;;
		self.mname                    := le.name_middle;
		self.lname                    := le.name_last;;
		self.name_suffix              := le.name_suffix;;
		self.prim_range               := le.prim_range;
		self.predir                   := le.predir;
		self.prim_name                := le.prim_name;
		self.suffix                   := le.suffix;
		self.postdir                  := le.postdir;
		self.unit_desig               := le.unit_desig;
		self.sec_range                := le.sec_range;
		self.city_name                := le.v_city_name;
		self.st                       := le.st;
		self.zip                      := le.z5;
		self.zip4                     := le.z4;
		self.county                   := le.county_code;
		self := le;
		self := [];
  end;

	export person_header_gong_recs := project(files.file_Gong_History(did>0),map_to_person_header(left));
/*
	export fGong_As_Business_Header := function
		return Gong.fGong_As_Business_Header(Files.File_History_Full_Prepped_for_Keys(bdid!=0));
	end;

	export fGong_As_Business_Contact  := function
		Business_Header.Layout_Business_Contact_Full_New Translate_Gong_to_BCF(Layouts.Layout_History L) := TRANSFORM
			SELF.company_title := '';
			SELF.title := L.name_prefix;
			SELF.fname := L.name_first;
			SELF.mname := L.name_middle;
			SELF.lname := L.name_last;
			SELF.name_suffix := L.name_suffix;
			SELF.name_score := Business_Header.CleanName(L.name_first,L.name_middle,L.name_last,L.name_suffix)[142];
			SELF.vl_id := (STRING34)(L.bell_id + L.group_id);
			SELF.vendor_id := (QSTRING34)((STRING34)(L.bell_id + L.group_id));
			SELF.zip := (UNSIGNED3)L.z5;
			SELF.zip4 := (UNSIGNED2)L.z4;
			SELF.phone := (UNSIGNED6)((UNSIGNED8)L.phone10);
			SELF.addr_suffix := L.suffix;
			SELF.city := L.v_city_name;
			SELF.state := L.st;
			SELF.county := L.county_code[3..5];
			SELF.source := IF(L.listing_type_gov <> ''
												 OR ut.GovName(ut.CleanCompany(L.listed_name))
												, MDR.sourceTools.src_Gong_Government
												, MDR.sourceTools.src_Gong_Business
										);
			SELF.record_type := 'C';
			SELF.company_name := L.listed_name;
			SELF.company_prim_range := L.prim_range;
			SELF.company_predir := L.predir;
			SELF.company_prim_name := L.prim_name;
			SELF.company_addr_suffix := L.suffix;
			SELF.company_postdir := L.postdir;
			SELF.company_unit_desig := L.unit_desig;
			SELF.company_sec_range := L.sec_range;
			SELF.company_city := L.v_city_name;
			SELF.company_state := L.st;
			SELF.company_zip := (UNSIGNED3)L.z5;
			SELF.company_zip4 := (UNSIGNED2)L.z4;
			SELF.company_phone := (UNSIGNED6)((UNSIGNED8)L.phone10);
			SELF.dt_first_seen := (UNSIGNED3)(L.filedate[1..6]);
			SELF.dt_last_seen := (UNSIGNED3)(L.filedate[1..6]);
			SELF.email_address := '';
			SELF := L;
		END;
		Gong_Contacts := PROJECT(
			Files.file_Gong_History(bdid > 0, name_last <> '', listing_type_bus<>'', publish_code IN ['P','U']), 
			Translate_Gong_to_BCF(LEFT));

		return Gong_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));
	end;

	export As_Business_Linking := function
		return Gong_v2.As_Business_Linking(Files.File_History_Full_Prepped_for_Keys, true);											
	end;	
*/

END;