import Relationship;

// This allows for relationships to be assymetric. IOW 1->2 does not imply 2->1
// Thus if your relationships are symmetric you need to insert two records for each one (one of which is reversed)
// All of the incoming LAB1s will be assigned a cluster


//rels_1sided := doxie.File_Relatives_Plus(current_relatives = true, person1>0, person2>0, number_cohabits>=6);
rels_1sided := Relationship.file_relative;

rels_lsided_rec := RECORDOF(rels_1sided);

relationship.layout_output.titled swap(rels_lsided_rec le) := transform
  self.did1 := le.did1;
  self.did2 := le.did2;
  self := le;
end;

rels := rels_1sided + project(rels_1sided,swap(left));

crec := RECORD
	unsigned8 cluster_id := rels.did1;
	unsigned8 associated_did := rels.did2;
	REAL4 degree := 1;
END;

j1 := table(rels,crec); // The first degree relationships; cluster ID (person1) is related to associated_did (person2)

// We now need to create a record for all of the cluster centroids
crec add_centroid( j1 le ) := TRANSFORM
	self.cluster_id     := le.associated_did;
	self.associated_did := le.associated_did;
	self.degree := 0;
end;
centroid_dupes := project( j1, add_centroid(left) );
centroids := DEDUP(centroid_dupes, associated_did, all); // an individual has a zero-degree relationship with him or herself

crec jrelt(crec le, crec ri) := TRANSFORM
	self.cluster_id     := le.cluster_id;
	self.associated_did := ri.associated_did;
	self.degree         := le.degree + ri.degree;
END;


// Construct all the second degree relatives - remove any which are already first degree relatives
with_second := join( j1, j1, left.associated_did=right.cluster_id, jrelt(left,right), hash );
j2 := join( with_second, centroids+j1, left.cluster_id=right.cluster_id and left.associated_did=right.associated_did, transform(left), left only, hash );
// j2 := JOIN(JOIN(j1,j1,left.lab1=right.cluster_id,jrelt(left,right), hash),centroids+j1,left.cluster_id=right.cluster_id and left.lab1=right.lab1,transform(left),left only, hash);

// Now compute the number of different ways the second degree relative is reached

j2cr := RECORD
  j2.cluster_id;
	j2.associated_did;
	j2.degree;
	UNSIGNED2 Cnt := COUNT(GROUP);
END;
j2c := TABLE(j2, j2cr, cluster_id, associated_did, degree, MERGE);

j2a := PROJECT(j2c,TRANSFORM(crec,SELF.Degree := LEFT.Degree - (LEFT.Cnt-1) / LEFT.Cnt, SELF := LEFT));

outfile := j2a + j1 + centroids;

// ctr := RECORD
	// outfile.cluster_id;
	// TotalCnt := COUNT(GROUP);
	// FirstDegrees := COUNT(GROUP,outfile.Degree > 0 AND outfile.Degree <= 1.0);
	// SecondDegrees := COUNT(GROUP,outfile.Degree > 1.0);
	// Cohesivity := AVE(GROUP,outfile.Degree);
// END;

// cohesivity_table := TABLE(outfile,ctr,cluster_id,MERGE);
	

personcluster := sort(outfile, cluster_id, associated_did, local)  : persist('~thor_data400::persist::sna::person_cluster');	
// output(personcluster);

// personclusterstats := sort(cohesivity_table, cluster_id) : persist('~thor40_241::persist::temp::person_cluster_stats');	
// output(personclusterstats);

// personcluster := dataset('~thor40_241::persist::temp::person_cluster', { unsigned8 cluster_id, unsigned8 person1, real4 degree }, thor);
// export person_cluster := personcluster;


export File_Person_Cluster := personcluster;