import iesp,Autokey_batch;
	
export Layouts := MODULE 
		
		export gsa_rec_inBatchMaster := Record
			Autokey_batch.Layouts.rec_inBatchMaster;
			string10  cln_prim_range := ''; //For GSA filtering
			string2   cln_predir := ''; //For GSA filtering
			string28  cln_prim_name := ''; //For GSA filtering
			string4   cln_addr_suffix := ''; //For GSA filtering
			string2   cln_postdir := ''; //For GSA filtering
			string8   cln_sec_range := ''; //For GSA filtering
		end;
		
		export batchin_sequenced := RECORD
			String search_id;
			gsa_rec_inBatchMaster;
		END;
		
		export autokey_fetch_gsa_id := RECORD
			unsigned8 gsa_id;
			STRING30  acctno             := '';
			UNSIGNED1 search_status      :=  0;
			STRING10  matchCode          := '';
		END;
		
		//slim layout gsa_id record
		export gsa_slim := RECORD, maxlength(GSA_Services.Constants.max_record_length_slim)
			unsigned8 gsa_id;
			autokey_fetch_gsa_id and not [gsa_id];
			string100 Name;  
			string1 primary_aka_name;
			string15 Classification; //actual 10
			string20 CTType;  // actual 14
			string10  DUNS;	
			string8 ActionDate; //actual 8
			string8 TermDate; //actual 8
			string1 termdateindefinite;
			string2 termdatepermanent;			
			string15 CTCode; //actual 11
			string15 AgencyComponent; //actual 10
			string5  title;
			string20 fname;
			string20 mname;
			string20 lname;
			string5  name_suffix;
			string10 prim_range; 	 
			string2  predir;		 
			string28 prim_name;	 
			string4  addr_suffix;   
			string2  postdir;		 
			string10 unit_desig;	 
			string8  sec_range;	 
			string25 p_city_name;	 
			string25 v_city_name;   
			string2  st;			 
			string5  zip5;		 
			string4  zip4;		 
		end;
		
		export basic := record
			unsigned8 gsa_id;
			autokey_fetch_gsa_id and not [gsa_id];
			string100 Name;
			string100 CompanyName;
			string5  title;
			string20 fname;
			string20 mname;
			string20 lname;
			string5  name_suffix;
			string15 Classification; //actual 10
			string20 CTType;  // actual 14
		end;
		
		export action := record
			unsigned8 gsa_id;
			autokey_fetch_gsa_id and not [gsa_id];
			string8 ActionDate;
			string8 TermDate;
			string15 CTCode;
			string1 termdateindefinite;
			string2 termdatepermanent;
			string15 AgencyComponent;
		end;
		
		export address := record
			unsigned8 gsa_id;
			autokey_fetch_gsa_id and not [gsa_id];
			string10 prim_range; 	 
			string2  predir;		 
			string28 prim_name;	 
			string4  addr_suffix;   
			string2  postdir;		 
			string10 unit_desig;	 
			string8  sec_range;	 
			string25 p_city_name;	 
			string25 v_city_name;   
			string2  st;			 
			string5  zip5;		 
			string4  zip4;		 
			string10  DUNS;	
		end;
		
		export address_plus_penality := record
			unsigned2 penalt;
			address;
		end;
		
		export basic_plus_penality := record
			unsigned2 penalt;
			basic;
		end;		
		
		export reference := record
			unsigned8 gsa_id;
			autokey_fetch_gsa_id and not [gsa_id];
			string100 Name;
		end;
		
		export primary_record := record
			unsigned8 gsa_id;
			string search_id;
			autokey_fetch_gsa_id and not [gsa_id];
			recordof(iesp.gsaverification.t_GSAVerificationRecord);
		end;
		
		export plus_penalty_primary_record := record
			unsigned2 addr_penalty;
			unsigned2 name_penalty;
			recordof(primary_record);
		end;
		
		export batch_out_rec := RECORD,maxlength(GSA_Services.Constants.batch_max_record_length)
		
			//Acctno
			STRING30 acctno := '';
			//Single entity
			string100 Name:= ''; 
			string100 CompanyName:= ''; 
			unsigned2 _penalty;
			string20 fname := '';
			string20 mname := '';
			string20 lname := '';
			string15 Classification:= ''; //actual 10
			string20 ExclusionType:= '';  // actual 14
			
			//Addresses  max 5
			string110 Street1_1:= '';		//actual 103			
			string70  Street2_1:= '';		//actual 65			
			string25  City_1:= '';						
			string2   State_1:= '';	
			string5   ZIP_1:= '';
			string10  DUNS_1:= '';	

			string110 Street1_2:= '';					
			string70  Street2_2:= '';					
			string25  City_2:= '';						
			string2   State_2:= '';	
			string5   ZIP_2:= '';
			string10  DUNS_2:= '';	

			string110 Street1_3:= '';					
			string70  Street2_3:= '';					
			string25  City_3:= '';						
			string2   State_3:= '';	
			string5   ZIP_3:= '';
			string10  DUNS_3:= '';		

			string110 Street1_4:= '';					
			string70  Street2_4:= '';					
			string25  City_4:= '';						
			string2   State_4:= '';	
			string5   ZIP_4:= '';
			string10  DUNS_4:= '';		

			string110 Street1_5:= '';					
			string70  Street2_5:= '';					
			string25  City_5:= '';						
			string2   State_5:= '';	
			string5   ZIP_5:= '';
			string10  DUNS_5:= '';		
														 
			//Actions max 10
			string8 ActionDate_1:= ''; //actual 8
			string8 TerminationDate_1:= ''; //actual 8
			string15 CauseTreatmentCode_1:= ''; //actual 11
			string15 ImposingAgency_1:= ''; //actual 10

			string8  ActionDate_2:= '';
			string8  TerminationDate_2:= '';
			string15 CauseTreatmentCode_2:= '';
			string15 ImposingAgency_2:= '';

			string8  ActionDate_3:= '';
			string8  TerminationDate_3:= '';
			string15 CauseTreatmentCode_3:= '';
			string15 ImposingAgency_3:= '';

			string8  ActionDate_4:= '';
			string8  TerminationDate_4:= '';
			string15 CauseTreatmentCode_4:= '';
			string15 ImposingAgency_4:= '';

			string8  ActionDate_5:= '';
			string8  TerminationDate_5:= '';
			string15 CauseTreatmentCode_5:= '';
			string15 ImposingAgency_5:= '';

			string8  ActionDate_6:= '';
			string8  TerminationDate_6:= '';
			string15 CauseTreatmentCode_6:= '';
			string15 ImposingAgency_6:= '';

			string8  ActionDate_7:= '';
			string8  TerminationDate_7:= '';
			string15 CauseTreatmentCode_7:= '';
			string15 ImposingAgency_7:= '';

			string8  ActionDate_8:= '';
			string8  TerminationDate_8:= '';
			string15 CauseTreatmentCode_8:= '';
			string15 ImposingAgency_8:= '';

			string8  ActionDate_9:= '';
			string8  TerminationDate_9:= '';
			string15 CauseTreatmentCode_9:= '';
			string15 ImposingAgency_9:= '';

			string8  ActionDate_10:= '';
			string8  TerminationDate_10:= '';
			string15 CauseTreatmentCode_10:= '';
			string15 ImposingAgency_10:= '';
			
			
			//References max 20
			string100 reference_1:= ''; // same lenght as name field
			string100 reference_2:= '';
			string100 reference_3:= '';
			string100 reference_4:= '';
			string100 reference_5:= '';
			string100 reference_6:= '';
			string100 reference_7:= '';
			string100 reference_8:= '';
			string100 reference_9:= '';
			string100 reference_10:= '';
			string100 reference_11:= '';
			string100 reference_12:= '';
			string100 reference_13:= '';
			string100 reference_14:= '';
			string100 reference_15:= '';
			string100 reference_16:= '';
			string100 reference_17:= '';
			string100 reference_18:= '';
			string100 reference_19:= '';
			string100 reference_20:= '';
		end;				
		
		export batchInputAndResults := record
			gsa_rec_inBatchMaster- [did,ssn,dob,homephone,workphone,dl,dlstate,vin,plate,platestate,searchtype,score,matchcode,fein,sic_code,filing_number,apn ]; //Autokey_batch.Layouts.rec_inBatchMaster 
			batch_out_rec - [acctno];
			
		end;
		
		export plusPenalty := Record
			unsigned1 penalt;
			batchInputAndResults;
		end;
END;	