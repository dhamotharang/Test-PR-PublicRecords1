IMPORT UPS_Services;
Constant := UPS_Services.Constants;


export ds_SlowQueriesNoFname2 :=

MODULE

export raw := dataset([
{'31.03','BUS','NANCY DILL DESIGNS','31 MECHANIC ST','HOLLEY','NY','14470'},
{'13.86','IND','JOHNSON','TRLR #3 TRLR 3','BOISE','ID','83705'},
{'12.22','BOTH','BRYANT','APT 112 APT 112','GREENVILLE','SC','29615'},
{'10.74','BOTH','AGUILAR','APT 191 APT 191','VISTA','CA','92084'},
{'10.66','IND','WILSON','UNIT 2 UNIT 2','RAMONA','CA','92065'},
{'10.05','IND','AGUILAR','APT 191 APT 191','VISTA','CA','92084'},
{'9.45','IND','STARY','APT 402 APT 402','SANTA ANA','CA','92706'},
{'9.42','BOTH','MOORE','5TH AVE','PITTSBURGH','PA','15213'},
{'8.95','IND','BRADLEY JR ATT','29 S LA SALLE ST','CHICAGO','IL','60603'},
{'8.62','BOTH','M','2050 FAIRWAY LAKES DR','BERLIN','MD','21811'},
{'8.59','BOTH','SIMMONS III/AT','201 N TRYON ST','CHARLOTTE','NC','28202'},
{'8.50','BUS','INTERNAL REVENUE SERVICE','3651 S I H 35','AUSTIN','TX','78741'},
{'8.45','IND','SIMMONS III/AT','201 N TRYON ST','CHARLOTTE','NC','28202'},
{'8.29','BUS','INTERNAL REVENUE SERVICE','3651 S I H 35','AUSTIN','TX','78741'},
{'8.28','IND','SIMMONS III/AT','201 N TRYON ST','CHARLOTTE','NC','28202'},
{'8.15','IND','DEWALT ','175 TONEY PENNA DR','JUPITER','FL','33458'},
{'7.98','BOTH','HILL','1141 FOLKSTONE DR','CINCINNATI','OH','45240'},
{'7.95','BUS','JOSEPH BROOKE','1748 CAMINO PALMERO ST','LOS ANGELES','CA','90046'},
{'7.93','BOTH','OLSEN','SPRING','SISTER BAY','WI','54234'},
{'7.72','BOTH','JOHNSON','6828 E 5TH ST','TULSA','OK','74145'}
	], {string10 orig_time, string4 searchtype, string40 clname, string50 addr, string25 city, string2 st, string5 zip});

export formatted :=
project(
		raw,
		transform(
			UPS_Testing.layout_TestCase,
			self.fname := '',
			self.mname := '',
			self.lname := '',
			self.cname := left.clname,
			self.addr := left.addr,
			self.city := left.city,
			self.state := left.st,
			self.zip := left.zip,
			self.phone := '',
			self.entityType := 
			case(
				left.searchtype,
				'BOTH' => Constant.TAG_ENTITY_UNK,
				'IND' => Constant.TAG_ENTITY_IND,
				'BUS' => Constant.TAG_ENTITY_BIZ,
				''
			)
		)
);

END;	