
/*--TocreatecandidatesusingLGID3asinput--*/
//BIPV2_Blocklink.ManualOverlinksLGID3.candidates(85688968,85688968);					//Createcandidates using all matching fields

/*--ToremovecandidatesfromtheBlockLinkfileusingrecordidasinput.--*/
//BIPV2_Blocklink.ManualOverlinksLGID3.removeCandidates(10000000);		
//BIPV2_Blocklink.ManualOverlinksLGID3.removeSeleCandidate(SeleIn);
/*--ToaddcandidatestotheBlockLinkfile.--*/
unsigned6 seleid_in:=10000; //for example
overlink_reduced:=
dataset([
    {1, 85688968, '   ', '                    ', 'LAW COPY      ', '', '         ', '         ', '         ', '  ', ' ', '          ', true}, 
    {1, 85688968, '   ', '                    ', 'LAW COPY      ', '', '         ', '         ', '208380660', '  ', ' ', '          ', true}, 
    {1, 85688968, '   ', '                    ', 'LAW COPY      ', '', '         ', '         ', '770535071', '  ', ' ', '          ', true}, 
    {1, 85688968, '   ', '                    ', 'LAW COPY INC  ', '', '         ', '         ', '         ', '  ', ' ', 'INC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY       ', '', '         ', '         ', '         ', '  ', ' ', '          ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY       ', '', '007460723', '007460723', '         ', '  ', ' ', '          ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY INC   ', '', '         ', '         ', '         ', '  ', ' ', 'INC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY INC   ', '', '         ', '         ', '770535071', '  ', ' ', 'INC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY INC   ', '', '007460723', '007460723', '         ', '  ', ' ', 'INC       ', false}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY LLC   ', '', '         ', '         ', '         ', '  ', ' ', 'LLC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY LLC   ', '', '         ', '         ', '064703505', '  ', ' ', 'LLC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY LLC   ', '', '         ', '         ', '208380660', '  ', ' ', 'LLC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY LLC   ', '', '         ', '         ', '208380667', '  ', ' ', 'LLC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY, INC  ', '', '         ', '         ', '         ', '  ', ' ', 'INC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY, LLC  ', '', '         ', '         ', '         ', '  ', ' ', 'LLC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY, LLC  ', '', '         ', '         ', '         ', 'CA', '200702610154                    ', 'LLC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY, LLC  ', '', '         ', '         ', '770535071', '  ', ' ', 'LLC       ', true}, 
    {1, 85688968, '   ', '                    ', 'LAWCOPY, LLC  ', '', '007460723', '007460723', '         ', '  ', ' ', 'LLC       ', true}
		],BIPV2_Blocklink.ManualOverlinksLGID3.reducedlayout);
BIPV2_Blocklink.ManualOverlinksLGID3.addCandidates(overlink_reduced,seleid_in);	


/* -- To test header build -- */
// ds := idl_header.keys.idl(did in [1067439253,613597358]);
// in1 := project(ds, transform(idl_header.Layout_Header_Link, self := left, self := []));
// insuranceheader_salt_t46.Proc_Iterate(in1, 'test_manualBlockLink').doall;

/* ds:=dataset('~thor_data400::bipv2_lgid3::building',BIPV2_Files.files_lgid3.Layout_LGID3, thor);
   ds1:=ds(lgid3=85688968); 
   BIPV2_LGID3_HS.Proc_Iterate('999',ds1).doall;
*/