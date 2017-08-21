IMPORT Accuity;
EXPORT ProcMakePep(string version) := FUNCTION

path := '/hds_3/pep/output/';

Despray(string logicalname, string filename) :=
	fileservices.Despray(logicalname,
		'edata12-bld.br.seisint.com',
		path + filename,
		allowoverwrite := true);

dsusp := ProcessFile(Files.USPentity,true);
dspep := ProcessFile(Files.PEPentity,true);
	// due diligence
dseul := ProcessFile(Files.EULentity,false);
dseua := ProcessFile(Files.EUAentity,false);
dsedc := ProcessFile(Files.EDCentity,false);
dsede := ProcessFile(Files.EDEentity,false);
dseda := ProcessFile(Files.EDAentity,false);
dsesa := ProcessFile(Files.ESAentity,false);
dsedi := ProcessFile(Files.EDIentity,false);
dseuk := ProcessFile(Files.EUKentity,false);
pepExtracts := '~thor::in::accuity::pep::extracts';
eddExtracts := '~thor::in::accuity::edd::extracts';
doit := SEQUENTIAL(
	PARALLEL(
		OUTPUT(dsusp,named('uspin')),
		OUTPUT(dspep,named('pepin')),

		MakeHdr.OutputDataXMLFile('USP 1021', 'source_USP_1021.xml',dsusp, pepExtracts),
		MakeHdr.OutputDataXMLFile('PEP 1020', 'source_PEP_1020.xml',dspep, pepExtracts),
		// due diligence
		MakeHdr.OutputDataXMLFile('EUL 1098', 'source_EUL_1098.xml',dseul, eddExtracts),
		MakeHdr.OutputDataXMLFile('EUA 1100', 'source_EUA_1100.xml',dseua, eddExtracts),
		MakeHdr.OutputDataXMLFile('EDC 1102', 'source_EDC_1102.xml',dsedc, eddExtracts),
		MakeHdr.OutputDataXMLFile('EDE 1104', 'source_EDE_1104.xml',dsede, eddExtracts),
		MakeHdr.OutputDataXMLFile('EDA 1106', 'source_EDA_1106.xml',dseda, eddExtracts),
		MakeHdr.OutputDataXMLFile('ESA 1108', 'source_ESA_1108.xml',dsesa, eddExtracts),
		MakeHdr.OutputDataXMLFile('EDI 1110', 'source_EDI_1110.xml',dsedi, eddExtracts),
		MakeHdr.OutputDataXMLFile('EUK 1112', 'source_EUK_1112.xml',dseuk, eddExtracts)
	),
		// pep
	Despray('~thor::accuity::source_USP_1021.xml', 'accuity_source_USP_1021.xml'),
	Despray('~thor::accuity::source_PEP_1020.xml', 'accuity_source_PEP_1020.xml'),
		// due diligence
	Despray('~thor::accuity::source_EUL_1098.xml', 'accuity_source_EUL_1098.xml'),
	Despray('~thor::accuity::source_EUA_1100.xml', 'accuity_source_EUA_1100.xml'),
	Despray('~thor::accuity::source_EDC_1102.xml', 'accuity_source_EDC_1102.xml'),
	Despray('~thor::accuity::source_EDE_1104.xml', 'accuity_source_EDE_1104.xml'),
	Despray('~thor::accuity::source_EDA_1106.xml', 'accuity_source_EDA_1106.xml'),
	Despray('~thor::accuity::source_ESA_1108.xml', 'accuity_source_ESA_1108.xml'),
	Despray('~thor::accuity::source_EDI_1110.xml', 'accuity_source_EDI_1110.xml'),
	Despray('~thor::accuity::source_EUK_1112.xml', 'accuity_source_EUK_1112.xml')
);

	return doit;

END;