import header;
export header.layout_relatives tra_flip(header.layout_relatives l, boolean flip) := transform
		//the flipping should get all our folks into person1
	self.person1 := if(flip, l.person2, l.person1);
	self.person2 := if(flip, l.person1, l.person2);
	self := l;
end;