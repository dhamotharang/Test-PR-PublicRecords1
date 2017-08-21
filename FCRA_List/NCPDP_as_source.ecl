import header,NCPDP,MDR,data_services;

export NCPDP_as_Source(dataset(NCPDP.layouts.keybuild) pNCPDP = dataset([],NCPDP.layouts.keybuild), boolean pForFCRAHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForFCRAHeaderBuild
					   ,dataset(data_services.foreign_prod + 'thor_data400::Base::NCPDPFCRAHeader_Building',NCPDP.layouts.keybuild,flat)(did != 0)
					   ,pNCPDP
					  );

//normalize address, phone etc 

		SlimRec := record
		    STRING7    NCPDP_provider_id;
				string1     rec_type;
        UNSIGNED6  Dt_First_Seen;
        UNSIGNED6  Dt_Last_Seen; 
				unsigned6 did;
				string20	fname;
				string20	mname;
				string20	lname;
				string5		suffix;
				string10	phone;
				string10	prim_range;
				string2   predir;
				string28	prim_name;
				string4   addr_suffix;
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
				unsigned8   RawAID := 0; 
      		
		end;
			
SlimRec into_temp(dSourceData pInput, integer cnt) := transform


				self.phone 					:= 	pInput.contact_phone;
				self.rec_type 					:= '';
				self.prim_range 		:= 	choose(cnt,pInput.Phys_prim_range,pInput.Mail_prim_range);
				self.predir 		    := 	choose(cnt,pInput.Phys_predir,pInput.Mail_predir);
				self.prim_name 			:= 	choose(cnt,pInput.Phys_prim_name,pInput.Mail_prim_name);
				self.addr_suffix 			  := 	choose(cnt,pInput.Phys_addr_suffix,pInput.Mail_addr_suffix);
				self.postdir 			  := 	choose(cnt,pInput.Phys_postdir,pInput.Mail_postdir);
				self.unit_desig			:= 	choose(cnt,pInput.Phys_unit_desig,pInput.Mail_unit_desig);
				self.sec_range 			:= 	choose(cnt,pInput.Phys_sec_range,pInput.Mail_sec_range);
				self.city_name		  :=  choose(cnt,pInput.Phys_v_city_name,pInput.Mail_v_city_name);	
				self.st 						:= 	choose(cnt,pInput.Phys_state,pInput.Mail_state);																					
				self.zip						:= 	choose(cnt,pInput.Phys_zip5,pInput.Mail_zip5);				
				self.zip4						:= 	choose(cnt,pInput.Phys_zip4,pInput.Mail_zip4);																			 
				self.county 				:= 	choose(cnt,pInput.Phys_county,pInput.Mail_county);																					
				self.geo_blk 				:= 	choose(cnt,pInput.Phys_geo_blk,pInput.Mail_geo_blk);
				self.msa 				:= 	choose(cnt,pInput.Phys_msa,pInput.Mail_msa);
				self.RawAID 				:= 	choose(cnt,pInput.Append_PhyRawAID,pInput.Append_MailRawAID);
				self.did						:=  pInput.did;
				self								:= pInput;
		end;

		NormNameAddr := normalize(dSourceData,2,into_temp(LEFT,COUNTER));
	
	  NormNameAddr_dedup := dedup(sort(distribute(NormNameAddr,hash(did)), record, local), record,local);

	lsrc:=header.Layout_Source_ID;

	src_rec := {lsrc, SlimRec};

	header.Mac_Set_Header_Source(NormNameAddr_dedup,SlimRec,src_rec,MDR.sourceTools.src_NCPDP,withUID)

	return withUID;
	
  end;

