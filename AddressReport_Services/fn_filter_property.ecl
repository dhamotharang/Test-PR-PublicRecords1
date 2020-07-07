IMPORT LN_PropertyV2_Services;
export fn_filter_property(dataset(LN_PropertyV2_Services.layouts.combined.widest) prop_in) := FUNCTION
  r_tmp:=record
    recordof(prop_in);
    string tmp_fid;
    string fname;
    string lname;
    string cname;
    unsigned did;
    unsigned bdid;
  end;

  r_tmp xform_prop1 (prop_in l):=transform
    buyer := L.parties (party_type = 'O')[1]; // "Buyer"
    entity := buyer.entity[1];
    self.tmp_fid := if(l.fid_type='D',l.deeds[1].fares_iris_apn,l.assessments[1].fares_iris_apn);
    self.fname := entity.fname;
    self.lname := entity.lname;
    self.cname := entity.cname;
    self.did := (unsigned) entity.did;
    self.bdid := (unsigned) entity.bdid;
    self := l;
  end;
  //shared EQ(unsigned l, unsigned r) := l<>0 AND r<>0 AND l=r;
  Property_raw_filter_tmp := project(prop_in,xform_prop1(left));
  Property_raw_filter := sort(Property_raw_filter_tmp,-sortby_date,vendor_source_flag,fid_type);
  current_prop := choosen(Property_raw_filter,1);//[1];
  r_tmp xform_prop2 (Property_raw_filter L,current_prop r):=transform
    self:=L;
  end;

  Prop_Prior_tmp := join(choosen(Property_raw_filter,all,2),current_prop,
    left.did = right.did AND
    left.bdid = right.bdid AND
    left.lname = right.lname,
    xform_prop2(LEFT,RIGHT),
    LEFT ONLY);
  Prior_prop := dedup(sort(Prop_Prior_tmp,lname,cname,did,bdid,sortby_date,vendor_source_flag,fid_type),lname,cname,did,bdid);

  Prior_prop_final := project(Prior_prop,transform(LN_PropertyV2_Services.layouts.combined.widest,self.current_record:='',self:=left));
  current_prop_final := project(current_prop,transform(LN_PropertyV2_Services.layouts.combined.widest,self.current_record:='Y',self:=left));
  prop_final := current_prop_final&sort(Prior_prop_final,-sortby_date);
  RETURN prop_final;
END;
