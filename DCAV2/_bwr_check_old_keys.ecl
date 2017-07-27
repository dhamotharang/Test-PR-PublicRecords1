import dca,autokeyb2,dcav2;

akname := dca.Constants().ak_qa_keyname;
output(DCA.Key_DCA_BDID																	,named('Key_DCA_BDID'																));
output(DCA.Key_DCA_Hierarchy_BDID												,named('Key_DCA_Hierarchy_BDID'											));
output(DCA.Key_DCA_Hierarchy_Parent_to_Child_Root_Sub		,named('Key_DCA_Hierarchy_Parent_to_Child_Root_Sub'	));
output(DCA.Key_DCA_Hierarchy_Root_Sub										,named('Key_DCA_Hierarchy_Root_Sub'									));
output(DCA.Key_DCA_Root_Sub															,named('Key_DCA_Root_Sub'														));
output(AutokeyB2.Key_Address		(akname)								,named('Key_Address'																));
output(AutoKeyB2.Key_CityStName	(akname)								,named('Key_CityStName'															));
output(AutoKeyB2.key_name				(akname)								,named('key_name'																		));
output(AutoKeyB2.Key_NameWords	(akname)								,named('Key_NameWords'															));
output(AutoKeyB2.Key_StName			(akname)								,named('Key_StName'																	));
output(AutoKeyB2.Key_Zip				(akname)								,named('Key_Zip'																		));
output(dcav2.Keys().HierP2CNew.qa												,named('Key_HierP2CNew'															));
output(dcav2.Keys().HierEntNum.qa												,named('Key_HierEntNum'															));
output(dcav2.Keys().EntNum.qa														,named('Key_EntNum'																	));
output(DCA.key_dca_AutokeyPayload												,named('Key_Payload'																));