/* To search for records in the Real Property Search file (i.e., the "Party" file for RP) */

IMPORT LN_PropertyV2, Property, ut;

//Property Search File - same as LN_PropertyV2.File_Search_DID
Prop_Search := DATASET(ut.foreign_prod+'~thor_data400::base::ln_propertyv2::search',
										LN_PropertyV2.Layout_DID_Out, flat);

//Property Search File - prior build										
Prop_Search_father := DATASET(ut.foreign_prod+'~thor_data400::base::ln_propertyv2::search_father',
										LN_PropertyV2.Layout_DID_Out, THOR, __COMPRESSED__);
										
//*************************************************************************************************************************************************

//Search SEARCH FILE on owner name and location:
isCriteria := (
				Prop_Search.lname = 'UNCK'
				AND
				Prop_Search.fname = 'KATHY'
				AND
				Prop_Search.st = 'NE'
				AND
				Prop_Search.p_city_name = 'OMAHA'
				AND
				Prop_Search.prim_name = 'SUMMERWOOD'
			  );
			  
CriteriaSearch := Prop_Search(isCriteria);

OUTPUT(CriteriaSearch, ALL, NAMED('Property_Search_find_KATHY_UNCK'));

//*************************************************************************************************************************************************
/*
//Search SEARCH FILE FATHER on owner name and location:
isCriteria_dad := (
				Prop_Search_father.lname = 'UNCK'
				AND
				Prop_Search_father.fname = 'KATHY'
				AND
				Prop_Search_father.st = 'NE'
				AND
				Prop_Search_father.p_city_name = 'OMAHA'
				AND
				Prop_Search_father.prim_name = 'SUMMERWOOD'
			  );
			  
CriteriaSearch_dad := Prop_Search_father(isCriteria_dad);

OUTPUT(CriteriaSearch_dad, ALL, NAMED('Property_Search_Father_find_KATHY_UNCK'));
*/
//*************************************************************************************************************************************************
/*
// This will get a sample set of records from LNPropertyV2 Deeds & Mortgages that match requested constraints //

IMPORT LN_PropertyV2, Property, ut;

//Deeds Base File 
File_Base_Deeds := DATASET(ut.foreign_prod+'~thor_data400::base::ln_propertyv2::Deed',
                                        LN_PropertyV2.layout_deed_mortgage_common_model_base, flat);

rSource := 
	RECORD
		string source_val;
		LN_PropertyV2.layout_deed_mortgage_common_model_base;
	END;

rSource TwoSources(LN_PropertyV2.layout_deed_mortgage_common_model_base pInput) :=
	TRANSFORM
		SELF.source_val := IF(pInput.vendor_source_flag IN ['F','S'], 'Source A', 'Source B');  //Source A is Fares
		SELF := pInput;
	END;

ds_Base_Deeds := PROJECT(File_Base_Deeds, TwoSources(LEFT)); 
							
// Requested Constraints: 	Home Owner not in default;			 							//
//							Home Owner with a mortgage;			 							//
//							Property / Site must have full address populated;				//
//							Contract Date and Recording Date fields must be populated.		//
//							first_td_due_date field must be populated.						//


constraints_Deeds := (
					   (ds_Base_Deeds.property_full_street_address <> '')
					   AND
					   (ds_Base_Deeds.property_address_citystatezip <> '')
					   AND
					   (ds_Base_Deeds.document_type_code IN ['G','T','GD','WD'])
					   AND
					   (ds_Base_Deeds.contract_date <> '')
					   AND
					   (ds_Base_Deeds.recording_date <> '')
					   AND
					   (ds_Base_Deeds.first_td_due_date <> '')
					);

fBase_Deeds := ds_Base_Deeds(constraints_Deeds);

OUTPUT(CHOOSEN(fBase_Deeds((source_val = 'Source A') AND (current_record <> '')), 2000));
OUTPUT(CHOOSEN(fBase_Deeds((ln_fares_id[1] = 'O') AND (current_record <> '')), 2000));
//********************************************************************************************************************************
*/


export Search_Property_Search := '';