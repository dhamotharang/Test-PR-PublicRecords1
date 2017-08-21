import doxie,ut;

df1 := fPrepareCorpBaseFile(corp.File_Corp_Base(bdid != 0));

export key_Corp_base_bdid_pl := 
index(
df1,
{bdid},
{df1},'~thor_data400::key::corp_base_bdid_pl_' + doxie.Version_SuperKey);
