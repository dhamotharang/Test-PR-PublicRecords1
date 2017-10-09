import PRTE2_ucc, mdr;

EXPORT File_Uccv2_Base := project(PRTE2_ucc.Files.Party_base(ultid<>0),
																	transform({recordof(PRTE2_ucc.Files.Party_base), string2 source := ''},
																						self.source := mdr.sourceTools.src_uccv2,
																						self := left)): persist('~prte::persist::PRTE2_BIPV2_WAF::File_UCCv2_Base');
