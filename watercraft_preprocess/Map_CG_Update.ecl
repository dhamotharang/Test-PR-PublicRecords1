import watercraft,ut,address,AID,header,watercraft_preprocess;

// translates merchent_vessel.mp Ab intio graph into ECL 

fIn_raw := watercraft_preprocess.Files_raw.CG ; 

fClean_name := project(fIn_raw,transform({watercraft.Layout_CG_clean_in}, 
  
  self.state_origin := 'CG'; 
  self.process_date := watercraft_preprocess.version;
  self.Propulsion_Type := left.Propulsion_Type[1..16];
  self.clean_cname := trim(left.NAME,left,right)[1..70];
  self.clean_pname := Address.CleanPersonFML73(trim(left.FIRST)+' '+trim(left.MID)+' '+trim(left.LAST)+' '+trim(left.Person_Name_Suffix));
  self.clean_address :='';/* address_sixline(
                     	string_concat(in.ADDRESS,',',in.Street_Address_Line_2,' ',in.Street_Address_Line_3),
                        in.Street_Address_Line_4,
                     	string_concat(in.CITY,' ', in.STATE,' ', in.ZIP),
                        '',
                        '',
                        '');*/
	self.USE_1 := left.USE; 
	self.first_name := left.first; 
	self.last_name := left.last ; 
	self.address_1 := left.address; 
	self:= left)); 
						
export Map_CG_Update := sequential(output(fClean_name,,watercraft.Cluster_In+'in::watercraft_cg_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_cg', watercraft.Cluster_In+'in::watercraft_cg_'+watercraft_preprocess.version)
								  ) ;