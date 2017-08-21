import std;
/**
Entity URL:
https://members.worldcompliance/signin.aspx?uid=[UID]&ent=[DirectID]

Photos URL:
https://search.worldcompliance.com/Direct/GetPhoto.aspx?uid=[uid]&ent=[DirectID]
**/

OldEntityURL := 
'https://members.worldcompliance.com/signin.aspx?auth=[UID]&ent=[DirectID]';
EntityURL := 
'https://members.worldcompliance.com/metawatch2.aspx?id=[DirectID]';
PhotosURL := 								//'https://search.worldcompliance.com/Direct/GetPhoto.aspx?uid=[UID]&ent=[DirectID]';
	'https://webservices.worldcompliance.com/GetPhoto.aspx?uid=[UID]&ent=[DirectID]';

guid := '2d5f10c7-07fe-421c-ad05-a6513ac496d9';

r1 := RECORD
	unsigned8		Ent_ID;
	unicode			links;
	integer			sorter;
END;

	maxchar(unicode s) := IF(Length(s) > 8191,s[1..8191],s);


formatLink(string directid, unicode hdr, string picture) :=
			hdr  + ' | '
			+ std.str.FindReplace(
					std.str.FindReplace(EntityURL, '[UID]', guid),
					'[DirectID]', directid)
				;
/*			+ ' | Photo: | ' 
			+ IF(picture='','N/A',
				std.str.FindReplace(
					std.str.FindReplace(PhotosURL, '[UID]', guid),
					'[DirectID]', directid));
*/
r1 xExtractLinks(Layouts.rEntity infile) := TRANSFORM
				//self.Ent_ID := IF(infile.ParentID=0,infile.Ent_ID,infile.ParentID);
				self.Ent_ID := infile.Ent_ID;
				self.links := formatLink(infile.DirectId,Infile.name,infile.PictureFile);
				self.sorter := 1;
//				self.links := formatLink(infile.DirectId,
//					if(infile.ParentId=0, Infile.name, Infile.name + ': ' + Infile.EntryCategory + ', '  + Infile.EntrySubcategory + ':'),
//					infile.PictureFile
//					);
END;

r1 xMerge(r1 lft, r1 rght) := TRANSFORM
				self.Ent_ID := lft.Ent_Id;
				self.links := lft.links + ' | ' + rght.links;
				self.sorter := 1;
END;

GetRelationshipsForUrl(dataset(Layouts.rEntity) infile) := FUNCTION

	//relations := Files.dsRelationships(RelationId<>0);
	relations := GetRelationships(infile, Files.dsRelationships);
	relations1 := SORT(DISTRIBUTE(relations,Ent_IDParent), Ent_IDParent, sorter, name2, LOCAL);
		// limit to top 25 relationships
	rRelationships xLimit(rRelationships L, integer n) := TRANSFORM, SKIP(n > 25)
								self.rid := n;
								self := L;
	END;		
	relations2 := UNGROUP(PROJECT(SORT(GROUP(relations1, Ent_IDParent), sorter, name2),xLimit(LEFT,COUNTER)));
	
	
	
	rel1 := JOIN(relations2, infile,  LEFT.Ent_IDChild=RIGHT.Ent_Id, TRANSFORM(r1,
								self.Ent_Id := LEFT.Ent_IDParent;
								self.links := formatLink(RIGHT.DirectId,
										RIGHT.name + ': ' + RIGHT.EntryCategory + ', '  + RIGHT.EntrySubcategory + ':',
										RIGHT.PictureFile
									);
								self.sorter := 2;
							), INNER);
							
	return rel1;
END;

GetExcessiveRelationshipsForUrl(dataset(Layouts.rEntity) infile) := 
	JOIN(infile, ExcessiveRelations, LEFT.ent_id=RIGHT.ent_IdParent, TRANSFORM(r1,
							self.Ent_id := LEFT.Ent_Id;
							self.sorter := 3;
							self.links := notice;), INNER, LOCAL);


GetAddlInfoLinksBackup(dataset(Layouts.rEntity) infile) := FUNCTION
	
	raw := SORT(DISTRIBUTE(PROJECT(infile, xExtractLinks(LEFT)), Ent_ID), Ent_ID, LOCAL);
	// now combine them with child aka records
//	combined := rollup(raw, xMerge(LEFT, RIGHT), Ent_ID);
	// now combine them with relationship records
	related := GetRelationshipsForUrl(infile);
	combined := rollup(SORT(raw&related&GetExcessiveRelationshipsForUrl(infile),Ent_ID,sorter), xMerge(LEFT, RIGHT), Ent_ID, LOCAL);
	
	return PROJECT(combined, TRANSFORM({unsigned8 Ent_ID, Layout_XG.layout_addlinfo},
						self.Ent_ID := LEFT.Ent_Id;
						self.type := 'Other';
						self.information := 'Link to WorldCompliance Online Database';
						self.comments := maxchar(LEFT.links);
						self := [];));

END;

EXPORT GetAddlInfoLinks(dataset(Layouts.rEntity) infile) := FUNCTION
	
	raw := SORT(DISTRIBUTE(PROJECT(infile, xExtractLinks(LEFT)), Ent_ID), Ent_ID, LOCAL);
	// now combine them with child aka records
//	combined := rollup(raw, xMerge(LEFT, RIGHT), Ent_ID);
	// now combine them with relationship records
//	related := GetRelationshipsForUrl(infile);
//	combined := rollup(SORT(raw&related&GetExcessiveRelationshipsForUrl(infile),Ent_ID,sorter), xMerge(LEFT, RIGHT), Ent_ID, LOCAL);
	
	return PROJECT(raw, TRANSFORM({unsigned8 Ent_ID, Layout_XG.layout_addlinfo},
						self.Ent_ID := LEFT.Ent_Id;
						self.type := 'Other';
						self.information := 'Link to WorldCompliance Online Database';
						self.comments := maxchar(LEFT.links);
						self := [];));

END;