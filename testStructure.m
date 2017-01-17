frequency = [123;234; 345; 7465; 436; 8345];

absorbance = [0.43;0.234;0.456; 0.765; 0.23; 0.15];

zmag = [1231231;223423434; 334534545; 747546765; 4856736; 83789745];

zang = [-.234;-.12; -.234; -.75; -2; -5];

%s = table(frequency, absorbance, zmag, zang);

%conversion = table2struct(s);

identifier = {'hello'; 'this'; 'is'; 'stupid'; 'ugh'; 'man'};

s = table(identifier, frequency, absorbance, zmag, zang);