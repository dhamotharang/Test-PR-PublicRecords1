import doxie;

df := busdata.file_credit_unions_base(bdid != 0);

export key_credit_union_bdid := index(df,{bdid},{df},'~thor_Data400::key::credit_unions_bdid_' + doxie.Version_SuperKey);
