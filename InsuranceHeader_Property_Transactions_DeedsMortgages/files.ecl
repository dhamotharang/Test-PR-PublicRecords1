EXPORT Files (string pversion = workunit[2..7], string iter = '1') := MODULE

shared fileSuffix := '::' + pversion + '::' + workunit; 

//file name prefixes
shared common_prefix     := '~thor_data400::insuranceheader::dproptx::';
shared pre_full_prefix   := common_prefix + 'preprocess_full';  
shared salt_input_prefix := common_prefix + 'salt_input'; 
shared salt_out_prefix   := common_prefix + 'salt_output'; 
shared post_prefix       := common_prefix + 'postprocess_output'; 
shared large_prefix      := common_prefix + 'large_clusters'; 

//logical file names
export pre_full_filename           := pre_full_prefix + fileSuffix;  
export salt_input_filename         := salt_input_prefix + fileSuffix; 
export salt_output_filename        := salt_out_prefix + iter + fileSuffix; 
export post_filename               := post_prefix + fileSuffix; 
export large_filename              := large_prefix + fileSuffix; 

//super file names
export pre_full_filename_qa        := pre_full_prefix + '_qa';
export salt_input_filename_qa      := salt_input_prefix + '_qa'; 
export salt_output_filename_qa     := salt_out_prefix + '_qa'; 
export post_filename_qa            := post_prefix + '_qa';
export large_filename_qa           := large_prefix + '_qa';

export pre_full_filename_father    := pre_full_prefix + '_father';
export salt_input_filename_father  := salt_input_prefix +'_father'; 
export salt_output_filename_father := salt_out_prefix + '_father';
export post_filename_father        := post_prefix + '_father';
export large_filename_father       := large_prefix + '_father';

//logical datasets
export pre_full_ds        := dataset(pre_full_filename,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction,thor);
export salt_input_ds      := dataset(salt_input_filename,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction,thor);
export salt_output_ds     := dataset(salt_output_filename,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction,thor);
export post_ds            := dataset(post_filename,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction_out,thor);
export large_ds           := dataset(large_filename,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_fidrec,thor);

//super datasets
export pre_full_qa        := dataset(pre_full_filename_qa,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction,thor);
export salt_input_qa      := dataset(salt_input_filename_qa,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction,thor);
export salt_output_qa     := dataset(salt_output_filename_qa,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction,thor,OPT);
export post_qa            := dataset(post_filename_qa,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction_out,thor);
export large_qa           := dataset(large_filename_qa,layout_fidrec,thor,OPT);
  
export pre_full_father    := dataset(pre_full_filename_father,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction,thor);
export salt_input_father  := dataset(salt_input_filename_father,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction,thor);
export salt_output_father := dataset(salt_output_filename_father,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction,thor);
export post_father        := dataset(post_filename_father,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_property_transaction_out,thor);
export large_father       := dataset(large_filename_father,InsuranceHeader_Property_Transactions_DeedsMortgages.layout_fidrec,thor);

//Empty datasets
export empty_salt_output_ds := dataset([],layout_property_transaction);
export empty_large_ds       := dataset([],layout_fidrec);

//key file names
shared common_key_prefix := '~thor_data400::key::insuranceheader::dproptx::';
export key_ln_fares_id_filename      := common_key_prefix + 'ln_fares_id' + fileSuffix;
export key_address_filename          := common_key_prefix + 'address' + fileSuffix;

//Key super file names
export key_ln_fares_id_filename_qa   := common_key_prefix + 'ln_fares_id_qa';
export key_address_filename_qa       := common_key_prefix + 'address_qa';

END;