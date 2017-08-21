import uccv2, mdr;

EXPORT File_Uccv2_Base := project(uccv2.File_UCC_Party_Base_AID(ultid<>0),
																	transform({recordof(uccv2.File_UCC_Party_Base_AID), string2 source := ''},
																						self.source := mdr.sourceTools.src_uccv2,
																						self := left)): persist('~thor_data400::persist::BIPV2_WAF::File_UCC_Party_Base');
