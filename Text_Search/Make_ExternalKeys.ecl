// Build a data for creating maps between inversion data and external keys

EXPORT Make_ExternalKeys(DATASET(Layout_DocSeg) KeySegs,
                         DATASET(Layout_Posting) DocList
                         ) := MODULE
												 
  // Create unique list of keys from Key segments
  keysIn := DISTRIBUTED(KeySegs,hash32(Docref));
  keys := dedup(sort(keysIn,DocRef.src, DocRef.doc, segment, sect, LOCAL),DocRef.src, DocRef.doc, segment, sect, LOCAL);

  Layout_ExternalKeyMap GetKeys( Layout_Posting l, Layout_DocSeg r ) := TRANSFORM
    self.DocRef := l.DocRef;
    self.part := l.part;
    self.ExternalKey := trim(r.content[1..255]);
    self.HashKey := HASH64(self.ExternalKey);
    SELF.ver := 0;
  END;

  docs := DISTRIBUTED(DocList,HASH32(DocRef));

  SHARED keymap := JOIN( docs, keys, left.DocRef = right.DocRef, GetKeys(LEFT,RIGHT), LOCAL);

  EXPORT InKey := PROJECT(keymap,Layout_ExternalKeyIn);

  EXPORT OutKey := PROJECT(keymap,Layout_ExternalKeyOut);

END : DEPRECATED('Use SALT -bh and Text_Search.Build_From_Posting instead');