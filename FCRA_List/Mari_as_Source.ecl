import header,Prof_License_Mari,MDR,FCRA_list,data_services;

export Mari_as_Source(dataset(Prof_License_Mari.layouts.final) pProflicMari = dataset([],Prof_License_Mari.layouts.final), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForFCRAHeaderBuild
					   ,dataset(data_services.foreign_prod + 'thor_data400::Base::proflicMarisrchFCRAHeader_Building',Prof_License_Mari.layouts.final,flat)(DID != 0
						 and (std_source_desc in FCRA_list.constants.Mari_approved_vendor 
						 or (std_source_desc = FCRA_list.constants.Mari_approved_vendor_ga and std_prof_cd = FCRA_list.constants.Mari_std_prof_cd)))
					   ,pProflicMari
					  );

//normalize address, phone etc 

		SlimRec := record
				STRING8			DATE_FIRST_SEEN;
				STRING8			DATE_LAST_SEEN;
				STRING8 		DATE_VENDOR_FIRST_REPORTED;
				STRING8			DATE_VENDOR_LAST_REPORTED;
				unsigned6 did;
				string5		title;
				string20	fname;
				string20	mname;
				string20	lname;
				string5		name_suffix;
				string10	phone;
				integer4  DOB;
				string10	prim_range;
				string2   predir;
				string28	prim_name;
				string4   suffix;
				string2   postdir;
				string10  unit_desig;
				string8	  sec_range;
				string25  city_name; 
				string2		st;
				string5		zip;
				string4		zip4;
        string3   county;
        string7	  geo_blk;
        string4   msa;
				unsigned8 persistent_record_id;
				unsigned8   RawAID := 0; 
	
		end;
		
	SlimRec into_temp(dSourceData pInput, integer cnt) := transform


				self.phone 					:= 	choose(cnt,pInput.phn_mari_1,pInput.phn_mari_2);
				self.DOB 					  := 	(integer4)pInput.birth_dte;													
				self.prim_range 		:= 	choose(cnt,pInput.Bus_prim_range,pInput.Mail_prim_range);
				self.predir 		    := 	choose(cnt,pInput.Bus_predir,pInput.Mail_predir);
				self.prim_name 			:= 	choose(cnt,pInput.Bus_prim_name,pInput.Mail_prim_name);
				self.suffix 			  := 	choose(cnt,pInput.Bus_addr_suffix,pInput.Mail_addr_suffix);
				self.postdir 			  := 	choose(cnt,pInput.Bus_postdir,pInput.Mail_postdir);
				self.unit_desig			:= 	choose(cnt,pInput.Bus_unit_desig,pInput.Mail_unit_desig);
				self.sec_range 			:= 	choose(cnt,pInput.Bus_sec_range,pInput.Mail_sec_range);
				self.city_name		  :=  choose(cnt,pInput.Bus_v_city_name,pInput.Mail_v_city_name);	
				self.st 						:= 	choose(cnt,pInput.Bus_state,pInput.Mail_state);																					
				self.zip						:= 	choose(cnt,pInput.Bus_zip5,pInput.Mail_zip5);				
				self.zip4						:= 	choose(cnt,pInput.Bus_zip4,pInput.Mail_zip4);																			 
				self.county 				:= 	choose(cnt,pInput.Bus_county,pInput.Mail_county);																					
				self.geo_blk 				:= 	choose(cnt,pInput.Bus_geo_blk,pInput.Mail_geo_blk);
				self.msa 				:= 	choose(cnt,pInput.Bus_msa,pInput.Mail_msa);
				self.RawAID 				:= 	choose(cnt,pInput.Append_BusRawAID,pInput.Append_MailRawAID);
				self.did						:=  pInput.did;
				self								:= pInput;
		end;

		NormNameAddr := normalize(dSourceData,2,into_temp(LEFT,COUNTER));
		
		NormNameAddr_dedup := dedup(sort(distribute(NormNameAddr,hash(did)), record, local), record,local);

	lsrc:=header.Layout_Source_ID;

	src_rec := {lsrc, SlimRec};

	header.Mac_Set_Header_Source(NormNameAddr_dedup,SlimRec,src_rec,MDR.sourceTools.src_Mari_Prof_Lic,withUID)

	return withUID;
  end
 ;

