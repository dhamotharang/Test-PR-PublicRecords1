//wk_ut.get_Attribute_Text('lbentley.JunkAtt');

//me := 'copy2datalandECL  := \'BIPV2_Build.proc_copy_xlink_keys(\\n\\n   pversion         := \\\'@version@\\\'\\n  ,pistesting       := false\\n  ,pSkipSuperStuff  := true\\n  ,pOverwrite       := false\\n  ,pkeyfilter2Dataland       := \\\'bizlinkfull|bipv2_seleid_relative\\\'\\n  ,psuperversions   := \\\'built\\\'         //add them to these supers after copying\\n);\';\\nkickDatalandCopy	:= wk_ut.mac_ChainWuids(copy2datalandECL,1,1,pversion,,\'infinband_hthor\',pESP := \'10.241.3.242\',pOutputEcl := false,pUniqueOutput := \'XlinkDatalandCopy\');  //kick off on dataland\\nkickDatalandCopy;';
//pversion := '20140116';

 // copy2datalandECL := 'copy2datalandECL  := \'BIPV2_Build.proc_copy_xlink_keys(\\n\\n   pversion         := \\\'@version@\\\'\\n  ,pistesting       := false\\n  ,pSkipSuperStuff  := true\\n  ,pOverwrite       := false\\n  ,pkeyfilter2Dataland       := \\\'bizlinkfull|bipv2_seleid_relative\\\'\\n  ,psuperversions   := \\\'built\\\'         //add them to these supers after copying\\n);\\nkickDatalandCopy	:= wk_ut.mac_ChainWuids(copy2datalandECL,1,1,pversion,,\\\'infinband_hthor\\\',pESP := \\\'10.241.3.242\\\',pOutputEcl := false,pUniqueOutput := \\\'XlinkDatalandCopy\\\');  //kick off on dataland\\nkickDatalandCopy;\';';
 // output(copy2datalandECL);
//kickDatalandCopy := wk_ut.mac_ChainWuids(copy2datalandECL,1,1,pversion,,'hthor',pOutputEcl := false,pUniqueOutput := 'XlinkDatalandCopy');
//kickDatalandCopy;

//pversion := '20140116';
//BIPV2_Build.proc_copy_xlink_keys(pversion);

////////////////////////////////
//copy2datalandECL2  := 'BIPV2_Build.proc_copy_xlink_keys(\n\n   pversion         := \'@version@\'\n  ,pistesting       := false\n  ,pSkipSuperStuff  := true\n  ,pOverwrite       := false\n  ,pkeyfilter2Dataland       := \'bizlinkfull|bipv2_seleid_relative\'\n  ,psuperversions   := \'built\'         //add them to these supers after copying\n);\nkickDatalandCopy	:= wk_ut.mac_ChainWuids(copy2datalandECL,1,1,pversion,,\'infinband_hthor\',pESP := \'10.241.3.242\',pOutputEcl := false,pUniqueOutput := \'XlinkDatalandCopy\');  //kick off on dataland\nkickDatalandCopy;';

//top level
// copy2datalandECL := 'copy2datalandECL  := \'BIPV2_Build.proc_copy_xlink_keys(\\n\\n   pversion         := \\\'@version@\\\'\\n  ,pistesting       := false\\n  ,pSkipSuperStuff  := true\\n  ,pOverwrite       := false\\n  ,pkeyfilter2Dataland       := \\\'bizlinkfull|bipv2_seleid_relative\\\'\\n  ,psuperversions   := \\\'built\\\'         //add them to these supers after copying\\n);\\nkickDatalandCopy	:= wk_ut.mac_ChainWuids(copy2datalandECL,1,1,pversion,,\\\'infinband_hthor\\\',pESP := \\\'10.241.3.242\\\',pOutputEcl := false,pUniqueOutput := \\\'XlinkDatalandCopy\\\');  //kick off on dataland\\nkickDatalandCopy;\';';
// output(copy2datalandECL);

//result of top level output 
// copy2datalandECL  := 'BIPV2_Build.proc_copy_xlink_keys(\n\n   pversion         := \'@version@\'\n  ,pistesting       := false\n  ,pSkipSuperStuff  := true\n  ,pOverwrite       := false\n  ,pkeyfilter2Dataland       := \'bizlinkfull|bipv2_seleid_relative\'\n  ,psuperversions   := \'built\'         //add them to these supers after copying\n);\nkickDatalandCopy	:= wk_ut.mac_ChainWuids(copy2datalandECL,1,1,pversion,,\'infinband_hthor\',pESP := \'10.241.3.242\',pOutputEcl := false,pUniqueOutput := \'XlinkDatalandCopy\');  //kick off on dataland\nkickDatalandCopy;';
// output(copy2datalandECL);

//result of above output
// BIPV2_Build.Copy_xlink_keys(

   // pversion         := '@version@'
  // ,pistesting       := false
  // ,pSkipSuperStuff  := true
  // ,pOverwrite       := false
  // ,pkeyfilter2Dataland       := 'bizlinkfull|bipv2_seleid_relative'
  // ,psuperversions   := 'built'         //add them to these supers after copying
// );
// kickDatalandCopy	:= wk_ut.mac_ChainWuids(copy2datalandECL,1,1,pversion,,'infinband_hthor',pESP := '10.241.3.242',pOutputEcl := false,pUniqueOutput := 'XlinkDatalandCopy');  //kick off on dataland
// kickDatalandCopy;
BIPV2_Build.proc_copy_xlink_keys('20140115');