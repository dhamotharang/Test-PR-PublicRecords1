import idl_header, insuranceHeader_SALT_xIDL, ut;
EXPORT files(string version = '') := Module
	
  shared post    := '::post';
  shared prep    := '::prep';
	shared link    := '::link';
  shared hier    := '::hier';
	shared qa      := '::qa';
	shared father  := '::father';
	shared gfather := '::gfather';
	shared empty   := '::empty';
	
//filenames
  export Addr_base_fname          := '~thor::insuranceheader::address_link';	
  // export Addr_link_fname          := '~temp::address_group_id::InsuranceHeader_Address::it' + workunit;
	export Addr_link_fname          := '~temp::address_group_id::InsuranceHeader_Address::it' + version;
	export Addr_link_sfname         := Addr_base_fname + link + qa;
	export Addr_link_sfname_father  := Addr_base_fname + link + father;
	export Addr_link_sfname_gfather := Addr_base_fname + link + gfather;
	export Addr_link_father_empty   := Addr_base_fname + link + empty;
	// export Addr_post_fname          := Addr_base_fname + post + workunit;
	export Addr_post_fname          := Addr_base_fname + post + version;
	export Addr_post_sfname         := Addr_base_fname + post + qa;
	export Addr_post_sfname_father  := Addr_base_fname + post + father;
	export Addr_post_sfname_gfather := Addr_base_fname + post + gfather;
  // export Addr_hier_fname          := Addr_base_fname + hier + workunit;
	export Addr_hier_fname          := Addr_base_fname + hier + version;
	export Addr_hier_sfname         := Addr_base_fname + hier;
		
//datasets
  export Addr_link_ds            := dataset(Addr_link_fname,Layout_Address_Link,thor);
	export Addr_link_sfds          := dataset(Addr_link_sfname,Layout_Address_Link,thor);
	export Addr_link_sfds_test     := dataset(Addr_link_sfname + '::Test',Layout_Address_Link,thor);
	export Addr_link_sfds_father   := dataset(Addr_link_sfname_father,Layout_Address_Link,thor);	
	export Addr_link_sfds_father_test   := dataset(Addr_link_sfname_father + '::Test',Layout_Address_Link,thor);
	export Addr_link_sfds_gfather  := dataset(Addr_link_sfname_gfather,Layout_Address_Link,thor);	
	
  export Addr_post_ds := dataset(Addr_post_fname,Layout_Address_Link,thor);	
	export Addr_post_sfds         := dataset(Addr_post_sfname,IDL_Header.Layout_Header_address,thor);
	export Addr_post_sfds_father  := dataset(Addr_post_sfname_father,IDL_Header.Layout_Header_address,thor);	
	export Addr_post_sfds_gfather := dataset(Addr_post_sfname_gfather,IDL_Header.Layout_Header_address,thor);	

	export Addr_hier_ds   := dataset(Addr_hier_fname,idl_header.Layout_Header_address,thor);
	export Addr_hier_sfds := dataset(Addr_hier_sfname,idl_header.Layout_Header_address,thor);

END;
