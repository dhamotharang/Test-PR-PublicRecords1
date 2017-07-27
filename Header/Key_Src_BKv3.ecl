import bankruptcyv3;

dBK_as_Source	:=	BankruptcyV3.BKv3_as_source(,,true);

src_rec := record
header.layout_Source_ID;
string50 tmsid;
end;

slim_bk := project(dbk_as_source,transform(src_rec,self := left));

mac_key_src(slim_bk, {string50 tmsid}, 
						bk_child, 
						'~thor_data400::key::bkv3_src_index_',id)

export Key_Src_BKv3 := id;