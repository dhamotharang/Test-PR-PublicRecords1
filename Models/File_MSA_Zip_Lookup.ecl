IMPORT Models, ut;

EXPORT File_MSA_Zip_Lookup := MODULE
			
			shared MSA_Zip_Base_file							:= '~thor_data400::base::msa_zipcode_tables_clean';

			EXPORT layout_msa_zip := record
				string5 	Zip;
				string50 	MSA;
			end;			
			
			EXPORT MSA_Zip_Base			:= dataset(MSA_Zip_Base_file, layout_msa_zip, csv(QUOTE('"'), heading(single)) );

END;
