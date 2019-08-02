import tools;

export Keys(string pversion = '',boolean pUseOtherEnvironment = false) := module
	export b2cFile             := filenames(pversion,pUseOtherEnvironment).b2cFile;
	export c2bFile             := filenames(pversion,pUseOtherEnvironment).c2bFile;
	
     export KEY_LOGICAL_B2C     := b2cFile.New;
     export KEY_BASE_B2C        := b2cFile.QA;
     export KEY_PROD_B2C        := b2cFile.Prod;
     export KEY_FATHER_B2C      := b2cFile.Father;
     export KEY_GRANDFATHER_B2C := b2cFile.GrandFather;
	
     export KEY_LOGICAL_C2B     := c2bFile.New;
     export KEY_BASE_C2B        := c2bFile.QA;
     export KEY_PROD_C2B        := c2bFile.Prod;
     export KEY_FATHER_C2B      := c2bFile.Father;
     export KEY_GRANDFATHER_C2B := c2bFile.GrandFather;
	
     export emptyDs              := dataset([], Layouts.BipToConsumerCrossWalkRec);
     export emptyDs2             := dataset([], Layouts.ConsumerToBipCrossWalkRec);
	
     export BipToConsumerKey(
	                        string indexName                   = KEY_BASE_B2C, 
	                        dataset(Layouts.BipToConsumerCrossWalkRec) inDs = emptyDs
				        )   := index(inDs, {ultid, orgid, seleid, proxid}, {inDs}, indexName);
				  
     export ConsumerToBipKey(
	                        string indexName                   = KEY_BASE_C2B, 
	                        dataset(Layouts.ConsumerToBipCrossWalkRec) inDs = emptyDs2
				        )   := index(inDs, {contact_did}, {inDs}, indexName);
				  
				  
     export bipToConsumer := tools.macf_FilesIndex('BipToConsumerKey()' ,b2cFile);
     export consumerToBip := tools.macf_FilesIndex('ConsumerToBipKey()' ,c2bFile);
end;