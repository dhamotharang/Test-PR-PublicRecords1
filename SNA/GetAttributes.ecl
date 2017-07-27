import didville, doxie;

export GetAttributes( dataset(didville.layout_did_outbatch) ids, unsigned1 GLBPurpose, unsigned1 DPPAPurpose, string50 DataRestrictionMask ) := FUNCTION

	Layouts.Layout_Attributes_v1 getPersonCluster( ids le, sna.Key_Person_Cluster_Attributes ri ) := TRANSFORM
		self.seq            := le.seq;
    self.person1        := le.did;
		self.TotalCnt1      := ri.TotalCnt;
		self.FirstDegrees1  := ri.FirstDegrees;
		self.SecondDegrees1 := ri.SecondDegrees;
		self.Cohesivity1    := ri.Cohesivity;
		self := [];
	END;

	// get clusters for all these individuals
	clusters := join( ids, sna.Key_Person_Cluster_Attributes, left.did != 0 and keyed(left.did=right.cluster_id), getPersonCluster(left,right), left outer, keep(1) );

	Layouts.Layout_Attributes_v1 getProperty( Layouts.Layout_Attributes_v1 le, SNA.Key_Prop_Cluster_Stats ri ) := TRANSFORM
    self.seq        := le.seq;
		self.person1    := le.person1;
		self.Prop1      := ri;
		self            := le;
	END;
	wProp := join( clusters, SNA.Key_Prop_Cluster_Stats, left.person1 != 0 and keyed(left.person1=right.cluster_id), getProperty(left,right), left outer, keep(1) );
  
  return wProp;
END;