R := RECORD
  INTEGER owner1_did;
	STRING  owner1_Name;
	INTEGER owner1_Age;
  INTEGER owner2_did;
	STRING  owner2_Name;
	INTEGER owner2_Age;
  INTEGER seller1_did;
	STRING  seller1_Name;
	INTEGER seller1_Age;
  INTEGER seller2_did;
	STRING  seller2_Name;
	INTEGER seller2_Age;
	STRING  make;
	STRING  color;
	INTEGER veh_uid;
	INTEGER when;
	END;
	
EXPORT File_Buys := DATASET([{1,'DAVID',47,2,'KELLY',34,3,'TOM',20,4,'SALLY',21,'DODGE','BLUE',1,20141122},
                              {5,'FRED',65,6,'ETHEL',66,1,'DAVID',47,2,'KELLY',34,'TOYOTA','GREEN',2,20141123}],r);