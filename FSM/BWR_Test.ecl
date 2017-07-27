//f := fsm.first_names;



c_transition := record
  string1 type;
	unsigned1 shift;
	unsigned4 new_state;
  end;

state := record
  unsigned4 state_no;
	c_transition transitions[30];
  end;

r_transition := record
  unsigned4 old_state;
	unsigned4 new_state_no;
	string1   transition_type := 'C';
	string1   upon;
	string    new_state;
  end;

r_transition zero_eth(fsm.str_r inp) := transform
  self.old_state := 0;
	self.upon := inp.str;
	self.new_state := inp.str;
	self.new_state_no := 0;
  end;
	
state_list_element := record
  string state;
	unsigned1 first_occur;
	unsigned4 number;
  end;	

state_list_element add_num(state_list_element le,state_list_element ri, unsigned base) := transform
  self.number := if ( le.state='',base,le.number+1 );
  self := ri;
  end;

r_transition add_numr(r_transition le,r_transition ri, unsigned base) := transform
  self.new_state_no := if ( le.new_state='',base,le.new_state_no+1 );
  self := ri;
  end;

state_list_element into_list_el(r_transition le,unsigned i) := transform
  self.number := le.new_state_no;
	self.state := le.new_state;
	self.first_occur := i;
  end;

r_transition make_trans(state_list_element le,fsm.str_r ri) := transform
  self.old_state := le.number;
	self.new_state := if ( ri.cnt = 1, '-' + ri.rem,ri.str);
	self.upon := ri.str[length(trim(ri.str))];
	self.new_state_no := 0;
	self.transition_type := if ( ri.rem='', 'P','C' );
  end;

r_transition add_null_accept(r_transition le) := transform
  self.old_state := le.new_state_no;
	self.new_state := '';
	self.upon := ' ';
	self.new_state_no := 0;
	self.transition_type := 'A';
  end;

r_transition peel1(state_list_element le) := transform
  self.old_state := le.number;
	self.new_state := if ( length(trim(le.state))=1, '', '-' + le.state[3..] );
	self.upon := le.state[2];
	self.transition_type := if ( le.state='-','A','C' );
	self.new_state_no := 0;
  end;

	
r_transition take_num(r_transition le,state_list_element ri) := transform
	self.new_state_no := ri.number;
	self := le;
  end;
	
	

valid_first0 := project(fsm.wrd_n(1),zero_eth(left));
valid_first := iterate(valid_first0,add_numr(left,right,1));
states_1 := project( valid_first, into_list_el(left,0) );
state0 := valid_first;

iter( in_lab, n, out_trans, out_states ) := macro
#uniquename(high0)
%high0% := global(max(in_lab,number))+1;
#uniquename(j2)
#uniquename(j2a)
#uniquename(j2b)
%j2a% := join( in_lab(state[1]<>'-',first_occur=n-1), fsm.wrd_n(n+1), left.state[1..n]=right.str[1..n], make_trans(left,right),hash );
%j2b% := project( in_lab(state[1]='-',first_occur=n-1), peel1(left) );
%j2% := %j2a%+%j2b%;
#uniquename(j3)
%j3% := join( %j2%, in_lab, left.new_state = right.state, take_num(left,right), left outer, hash );
#uniquename(new_states)
%new_states% := dedup( project(%j3%(new_state<>'',new_state_no=0),into_list_el(left,n)), state, all );
#uniquename(nn1)
%nn1% := iterate(%new_states%,add_num(left,right,%high0%));
#uniquename(nn)
%nn% := join( %j3%(new_state_no=0,new_state<>''), %nn1%, left.new_state = right.state, take_num(left,right), hash );
#uniquename(nu)
%nu% := project(%nn%(transition_type='P'),add_null_accept(left));
out_states := in_lab+%nn1%;
out_trans := %nu%+%nn%+%j3%(new_state='' or new_state_no<>0);
  endmacro;

iter(states_1,1,trans_2,states_2)
iter(states_2,2,trans_3,states_3)
iter(states_3,3,trans_4,states_4)
iter(states_4,4,trans_5,states_5)
iter(states_5,5,trans_6,states_6)
iter(states_6,6,trans_7,states_7)
iter(states_7,7,trans_8,states_8)
iter(states_8,8,trans_9,states_9)
iter(states_9,9,trans_10,states_10)
iter(states_10,10,trans_11,states_11)
iter(states_11,11,trans_12,states_12)
iter(states_12,12,trans_13,states_13)
iter(states_13,13,trans_14,states_14)
iter(states_14,14,trans_15,states_15)
iter(states_15,15,trans_16,states_16)
iter(states_16,16,trans_17,states_17)
iter(states_17,17,trans_18,states_18)
iter(states_18,18,trans_19,states_19)
iter(states_19,19,trans_20,states_20)
iter(states_20,30,trans_21,states_21)

T := valid_first+trans_2+trans_3+trans_4+trans_5+trans_6+trans_7+trans_8+trans_9+trans_10
     +trans_11+trans_12+trans_13+trans_14+trans_15+trans_16+trans_17+trans_18+trans_19+trans_20+trans_21;
     //+trans_11+trans_12+trans_13;//+trans_14+trans_15+trans_16+trans_17+trans_18+trans_19+trans_20+trans_21;
		 
/*
high1 := max(states_2,number);
j3 := join( states_2, wrd_n(3), left.state[1..2]=right.str[1..2], make_trans(left,right) );
p3 := iterate(j3,add_n6m(left,right,high1));
states_3 := states_2+project(p3,into_list_el(left));
*/
/*output(valid_first);
output(states_1);
output(trans_2);
output(states_2);
output(trans_3);
output(states_3);
output(trans_4);
output(states_4);
output(trans_5);
output(states_5);
count(states_6(state[1]<>'-',first_occur=5));
count(states_6);*/
count(t);
output(trans_21);
output(states_21(first_occur>16));
count(states_21(state[1]<>'-',first_occur>18));
count(states_21);
count(fsm.wrd_n(21)(cnt>1));
count(fsm.wrd_n(21));
output(fsm.wrd_n(21));
/*se := states_13;
output(trans_13);
output(se(first_occur>12));
count(se(state[1]<>'-',first_occur>12));
count(se);
count(fsm.wrd_n(14)(cnt>1));
count(fsm.wrd_n(14));
output(fsm.wrd_n(14));*/