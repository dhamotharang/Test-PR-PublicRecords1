copy_Record :=
  record
    unsigned integer4 contact_id;
    unsigned integer4 did;
    unsigned integer4 bdid;
    string40 ssn;
    string40 score;
    string40 company_name;
    string40 company_prim_range;
    string40 ETC;
  end;
ds := //FIRST 20 RECORDS FROM W20120716-124549 (PAW.Key_contactID)
  dataset([
    {1, 0, 0, '         ', '007', 'UTC                                                                                                                     ', '          ', '  '}, 
    {2, 0, 0, '         ', '004', 'INDIANA TRANSPORTATION ASSOCIATION                                                                                      ', '          ', '  '}, 
    {3, 0, 0, '         ', '007', 'GREENBERG TRAURIG                                                                                                       ', '          ', '  '}, 
    {4, 0, 0, '         ', '007', 'BAKER   DANIELS, LLP, THE LAW FIRM OF                                                                                   ', '          ', '  '}, 
    {5, 0, 0, '         ', '007', 'MORGAN STANLEY (LEGAL AND COMPLIANCE DIVISION GOVERNMENT RELATIONS AND TAX)                                             ', '          ', '  '}, 
    {6, 0, 0, '         ', '007', 'HARNESS, DICKEY   PIERCE                                                                                                ', '          ', '  '}, 
    {7, 0, 0, '         ', '007', 'TAUIL   CHEQUER ADVOGADOS IN ASSOCIATION WITH MAYER BROWN LLP                                                           ', '          ', '  '}, 
    {8, 0, 0, '         ', '007', 'FREDRIKSON   BYRON                                                                                                      ', '          ', '  '}, 
    {9, 0, 0, '         ', '007', 'BLAKE, CASSELS   GRAYDON LLP                                                                                            ', '          ', '  '}, 
    {10, 0, 0, '         ', '007', 'GREENBERG TRAURIG                                                                                                       ', '          ', '  '}, 
    {11, 0, 0, '         ', '007', 'BLAKE, CASSELS   GRAYDON LLP                                                                                            ', '          ', '  '}, 
    {12, 0, 0, '         ', '007', 'SHERMAN   HOWARD L.L.C.                                                                                                 ', '          ', '  '}, 
    {13, 0, 0, '         ', '007', 'ABRAHAM   SARWANA                                                                                                       ', '          ', '  '}, 
    {14, 0, 0, '         ', '007', 'HOGAN LOVELLS US LLP                                                                                                    ', '          ', '  '}, 
    {15, 0, 0, '         ', '005', 'RAINSTICKS                                                                                                              ', '          ', '  '}, 
    {16, 0, 0, '         ', '005', 'TRYGLE                                                                                                                  ', '          ', '  '}, 
    {17, 0, 0, '         ', '005', 'TINKERTOYS                                                                                                              ', '1027      ', '  '}, 
    {18, 0, 0, '         ', '005', 'SAATCHI & SAATCHI                                                                                                       ', '1200      ', ' '}, 
    {19, 0, 0, '         ', '005', 'STEP START WALK N\' RIDE                                                                                                 ', '          ', '  '}, 
    {20, 0, 0, '         ', '005', 'BRATZ DOLLS                                                                                                             ', '1027      ', '  '}], copy_Record);

rec2 := record
	copy_record;
	unsigned6 rid;
	unsigned6 rid2;
	string2 src;
	unsigned6 src_rid;
end;

EXPORT zzzSampleFile :=
project(
	ds,
	transform(
		rec2,
		self.rid := counter,
		self.rid2 := counter,
		self.src_rid := counter,
		self.src := 'ZZ',
		self := left
	)
);
	