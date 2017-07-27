IMPORT SALT25,ut;
EXPORT Relationship_Links(DATASET(layout_DOT_Base) ih) := MODULE
// Create code to walk the relationships in the relationship key
// Code to walk the ASSOC relationship
  Key := Keys(ih).ASSOC;
  NestedResultKey := RECORD
    UNSIGNED1 Level;
    Key;
  END;
  ExpandTree(DATASET(NestedResultKey) Le,UNSIGNED1 Lvl) := FUNCTION
    NestedResultKey AddLvl(Key L) := TRANSFORM
      SELF.Level := Lvl;
      SELF := L;
    END;
    LvlPlus1 := JOIN(Le(Level=Lvl-1),Key,left.Proxid2=right.Proxid1,AddLvl(RIGHT));
    NoBack := JOIN(LvlPlus1,Le,left.Proxid2=right.Proxid2,TRANSFORM(LEFT),LEFT ONLY); // Remove 'backwards' steps
    RETURN Le + DEDUP(SORT(NoBack,Proxid2,-total_score),Proxid2); // Original plus the best way to get to each next level of the tree
  END;
EXPORT ASSOCTree(SALT25.UIDType in_Proxid,UNSIGNED1 lvls) := FUNCTION
  StartingPoint := DATASET([TRANSFORM(NestedResultKey, SELF.Proxid2 := in_Proxid; SELF.Level := 0, SELF := [])]);
  RETURN LOOP(StartingPoint,lvls,ExpandTree(ROWS(LEFT),COUNTER));
END;
END;
